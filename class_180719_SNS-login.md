180719

 # SNS-login

###  회원가입 시 타 SNS로 로그인



### FACEBOOK 편

* `Gemfile` 추가

  ```ruby
  gem 'devise'
  gem 'omniauth-facebook' # 각 사이트 마다의 로그인 에센스가 필요
  ```

  ```ruby
  $ bundle
  ```

* `User` 모델 `devise`로 생성

  ```ruby
  $ rails g devise:install
  $ rails g devise user
  ```

* 페이스북으로 로그인을 위해 새로운 `devise controller`를 생성

  ```ruby
  $ rails g devise:controllers users
  # controller 안에 Users 폴더 생성, 그 중 omniauth_callbacks_controller.rb 수정 예정
  ```

* 어떤 SNS로 로그인 했는지 알 수 있게 추가로 컬럼이 필요

  ![image](https://user-images.githubusercontent.com/37928445/42916235-1bf26d84-8b3f-11e8-89d6-316d96187654.png)

  ```ruby
  t.string :uid	# 유저가 가지는 고유 아이디
  t.string :provider	# 어떤 SNS로 로그인 했는지
  t.string :name	# 사용자 이름
  t.string :image	# 페이스북에서는 사용자의 이미지의 주소를 보내준다
  ```

* `scaffold` 생성

  ```ruby
  $ rails g scaffold post user_id:integer title content image
  $ rake db:migrate
  ```

* root 페이지 변경  (  `routes.rb`  )

  ![image](https://user-images.githubusercontent.com/37928445/42916309-96086394-8b3f-11e8-9271-c65fff0814da.png)

* 상단에 로그인 / 로그아웃 버튼 생성 ( `application.html.erb` )

  ```html
  <body>
    
    <% if user_signed_in? %>
      <span><%= current_user.email %></span>
      <%= link_to 'logout', destroy_user_session_path, method: :delete %>
    <% else %>
      <%= link_to 'login', new_user_session_path %>
    <% end %>
    
  <%= yield %>
  
  </body>
  ```

  

* OmniAuth 적용 ( 참고 : https://github.com/plataformatec/devise/wiki/OmniAuth%3A-Overview )

  ![image](https://user-images.githubusercontent.com/37928445/42916616-2521fe2c-8b41-11e8-8678-9214670d5dc4.png)

  ![image](https://user-images.githubusercontent.com/37928445/42916639-3f859cd8-8b41-11e8-9314-5a2bc6eca0d1.png)

  ```
  :omniauthable, omniauth_providers: %i[facebook] 
  # %i 루비에서 제공하는 심볼로 된 배열을 만드는 방법
  # => [:facebook] ,가 아닌 스페이스로 구분한다
  %i[facebook naver] #=> [:facebook, :naver]
  %w[facebook naver] #=> ['facebook','naver']
  ```

* 위의 작업으로 '페이스북으로 가입' 버튼 생성

![image](https://user-images.githubusercontent.com/37928445/42916833-0e06a264-8b42-11e8-844f-c63c4aa1578e.png)

* `routes.rb` 수정

  ```ruby
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  
  # devise는 페이스북 로그인을 어떻게 하는지 모르기 때문에 devise가 만든 기존 omniauth_callbacks 컨트롤러 대신 수정한 컨트롤러(users/omniauth_callbacks)를 사용하겠다는 의미
  ```

  

*  callback은 provider와 같은 이름의 액션으로 구현되야 합니다. 다음은 controller에 추가 할 수있는 페이스북 provider를 위한 액션 

  ![image](https://user-images.githubusercontent.com/37928445/42917675-888fb3e2-8b45-11e8-98eb-2c44894e6664.png)

  ```RUBY
    def facebook
      # You need to implement the method below in your model (e.g. app/models/user.rb)
      @user = User.from_omniauth(request.env["omniauth.auth"])
  
      if @user.persisted?
        sign_in_and_redirect @user, event: :authentication #this will throw if @user is not activated
        set_flash_message(:notice, :success, kind: "Facebook") if is_navigational_format?
      else
        session["devise.facebook_data"] = request.env["omniauth.auth"]
        redirect_to new_user_registration_url
      end
    end
  ```

  

* 
  controller가 정의 된 후에 model에서 `from_omniauth` method를 구현
   ![image](https://user-images.githubusercontent.com/37928445/42917737-d7514932-8b45-11e8-8351-bd1efb232bdf.png)



* 페이스북 키 값 발급 받기 ( https://developers.facebook.com )

  페이스북 앱 생성 후 - 페이스북 로그인 설정 - 빠른 시작이 아닌 왼쪽 설정 버튼 클릭

  유효한 OAuth 리디렉션 URI  : 페이스북으로 요청을 보내고 페이스북에서 검증된 사람이면 우리 서비스로 그 정보를 보내줄 주소 ( https://sns-login-clockwise16.c9users.io/users/auth/facebook/callback ) - 변경 내용 저장

  설정 - 기본 설정 - 앱 도메인 설정 ( https://sns-login-clockwise16.c9users.io )

  설정 - 기본 설정 - 앱 ID와 앱 시크릿 코드 복사

![image](https://user-images.githubusercontent.com/37928445/42918059-1c1ef77a-8b47-11e8-8d00-40cda7988799.png)



* 앱 ID와 앱 시크릿 코드 입력 

![image](https://user-images.githubusercontent.com/37928445/42918183-ae4e6bbc-8b47-11e8-9d17-ae1408f65433.png)



* '페이스북으로 로그인' 클릭 시

![image](https://user-images.githubusercontent.com/37928445/42918293-394ca1c0-8b48-11e8-9fdf-a83daa1ec838.png)

* 로그인 화면에 이름과 사진 보이기

  ```html
  <body>
    
    <% if user_signed_in? %>
      <%= image_tag current_user.image %>
      <span><%= current_user.name %></span>
      <span><%= current_user.email %></span>
      <%= link_to 'logout', destroy_user_session_path, method: :delete %>
    <% else %>
      <%= link_to 'login', new_user_session_path %>
    <% end %>
    
  <%= yield %>
  
  </body>
  ```

* 앱 아이디 및 앱 시크릿 터미널 창 ENV에 추가 ( ENV : 터미널 창에서만 확인 가능 )

  ![image](https://user-images.githubusercontent.com/37928445/42921593-bd9a2308-8b57-11e8-944a-b47f25743ecd.png)



### 네이버 편

* `Gemfile` 추가

  ```ruby
  gem 'omniauth-naver'
  $ bundle
  ```

* 네이버 이용 시, 추가 사항

  ![image](https://user-images.githubusercontent.com/37928445/42921753-75686eea-8b58-11e8-9b23-8250d48037ae.png)

  ![image](https://user-images.githubusercontent.com/37928445/42922776-388a4ca0-8b5d-11e8-9f91-bf4c55573dbd.png)

  ![image](https://user-images.githubusercontent.com/37928445/42921803-b88fe900-8b58-11e8-83ad-708959dbd4ab.png)



* 네이버 키 값 발급 받기 ( https://developers.naver.com/products/login/api/ )

  네이버 아이디로 로그인 - 오픈 API 이용 신청 - 로그인

  Client ID / Client Secret 터미널 창 ENV에 추가

  ![image](https://user-images.githubusercontent.com/37928445/42922028-d7b48466-8b59-11e8-8819-10143e423fa6.png)
  ![image](https://user-images.githubusercontent.com/37928445/42922039-e17c7f9e-8b59-11e8-946d-05330ec78a95.png)
  ![image](https://user-images.githubusercontent.com/37928445/42922048-ed19fc28-8b59-11e8-9784-9d75a5144392.png)

  

* 개발상태가 개발중이면 앱의 주인만 로그인이 가능, 따라서 활성화 시켜야 다른 접속자들도 로그인 가능