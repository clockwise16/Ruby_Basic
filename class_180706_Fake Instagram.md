180706

# Fake Instagram

* Post(CRUD)[N]+ @ => 사진 업로드 ( `carrierwave` )  https://github.com/carrierwaveuploader/carrierwave

  User(CRUD)[1] => 로그인 ( `devise` )

  

* 로그인 기능을 빠르게 쓰기위해 `scaffold` 활용

  ```ruby
  $ rails g scaffold Post content image user_id:integer tag
  $ rake db:migrate
  ```

  

* `routing` 확인

  ```ruby
  $ rake routes
  =>
         Prefix Verb   URI Pattern               Controller#Action
      posts GET    /posts(.:format)          posts#index
            POST   /posts(.:format)          posts#create
   new_post GET    /posts/new(.:format)      posts#new
  edit_post GET    /posts/:id/edit(.:format) posts#edit
       post GET    /posts/:id(.:format)      posts#show
            PATCH  /posts/:id(.:format)      posts#update
            PUT    /posts/:id(.:format)      posts#update
            DELETE /posts/:id(.:format)      posts#destroy
  ```

  

* `root` 페이지를 `index` 페이지로  (`routes.rb`)

  ```ruby
  Rails.application.routes.draw do
    root 'posts#index'
    
    resources :posts
  
  end
  ```

  

* 이미지를 주소가 아닌 사진으로 보여줌

  ```html
  # index.html.erb
  <tbody>
    <% @posts.each do |post| %>
      <tr>
        <td><%= post.content %></td>
        <td><img width="200" height="200" src="<%= post.image %>"></td>
        <td><%= post.user_id %></td>
        <td><%= post.tag %></td>
        <td><%= link_to 'Show', post %></td>
        <td><%= link_to 'Edit', edit_post_path(post) %></td>
        <td><%= link_to 'Destroy', post, method: :delete, data: { confirm: 'Are you sure?' }%></td>
      </tr>
    <% end %>
   </tbody>
  ```

  ```html
  # show.html.erb
  <p>
    <strong>Image:</strong>
    <img src="<%= @post.image %>">
  </p>
  ```

  

* 파일 업로드 할 수 있도록 `carrierwave`사용

  ```ruby
  # Gemfile 추가
  gem 'carrierwave', '~> 1.0'
  ```

  ```ruby
  $ bundle
  $ rails g uploader Image
  ```

  

*  이미지 업로드 기능 추가 ( `Models -> post.rb` )

  ```ruby
  class Post < ActiveRecord::Base
      mount_uploader :image, ImageUploader # 여기에 파일 업로드 할 수 있게 기능을 붙일게,
  end									  # 이미지 칼럼부분에 그리고 그 이름은 ImageUploader
  ```

  

* 이미지 업로드 형식 변경 / 이미지 주소가 아닌 파일 업로드 ( `views` -> `posts` -> `_form.html.erb` )

  `form for` : view 헬퍼의 하나로 form 형태를 만들어 준다. 

  ```html
    <div class="field">
      <%= f.label :image %><br>
      <%= f.file_field :image %>	# text 필드가 input 필드 기능을 함. 이것을 file 필드로 변경
    </div>
  ```

  

* `devise ` 사용하기  https://github.com/plataformatec/devise

  ```ruby
  # Gemfile 추가
  gem 'devise'
  ```

  ```ruby
  $ bundle
  $ rails g devise:install
  $ rails g devise User
  $ rake db:drop		# 이전 DB 제거
  $ rake db:migrate	# DB 변경 후, 서버 껐다가 켜주기
  ```

  

* `routing` 확인 ( https://fake-insta-clockwise16.c9users.io/rails/info/routes 와 같은 정보)

  ```ruby
                    Prefix Verb   URI Pattern                    Controller#Action
          new_user_session GET    /users/sign_in(.:format)       devise/sessions#new
              user_session POST   /users/sign_in(.:format)       devise/sessions#create
      destroy_user_session DELETE /users/sign_out(.:format)      devise/sessions#destroy
             user_password POST   /users/password(.:format)      devise/passwords#create
         new_user_password GET    /users/password/new(.:format)  devise/passwords#new
        edit_user_password GET    /users/password/edit(.:format) devise/passwords#edit
                           PATCH  /users/password(.:format)      devise/passwords#update
                           PUT    /users/password(.:format)      devise/passwords#update
  cancel_user_registration GET    /users/cancel(.:format)        devise/registrations#cancel
         user_registration POST   /users(.:format)               devise/registrations#create
     new_user_registration GET    /users/sign_up(.:format)       devise/registrations#new
    edit_user_registration GET    /users/edit(.:format)          devise/registrations#edit
                           PATCH  /users(.:format)               devise/registrations#update
                           PUT    /users(.:format)               devise/registrations#update
                           DELETE /users(.:format)               devise/registrations#destroy
                      root GET    /                              posts#index
                     posts GET    /posts(.:format)               posts#index
                           POST   /posts(.:format)               posts#create
                  new_post GET    /posts/new(.:format)           posts#new
                 edit_post GET    /posts/:id/edit(.:format)      posts#edit
                      post GET    /posts/:id(.:format)           posts#show
                           PATCH  /posts/:id(.:format)           posts#update
                           PUT    /posts/:id(.:format)           posts#update
                           DELETE /posts/:id(.:format)           posts#destroy
  ```

  

* 로그인, 회원가입 경로 추가 ( `application.html.erb` )

  ```html
  <body>
  	<a href='/'>인스타그램</a>
  	<a href='/users/sign_in'>로그인</a>
  	<a href='/users/sign_up'>회원가입</a>
      <P><%= current_user.email %></P>	# 로그인한 사용자의 이메일 보여주기
  	<%= yield %>
  </body>
  ```

  

* 로그인한 사용자 정보

  ```html
  <P><%= current_user %></P>	# User.find(session[:user_id])와 같은 기능
  ```

  

* 유저 아이디를 통해 사용자의 이메일 정보 가져오기

  ```html
  # _form.html.erb
    <div class="field">
      <%= f.label :user_id %><br>
      <%= f.hidden_field :user_id, value: current_user.id %>	# f.number_field에서 변경
    </div>
  ```

  ```html
  # index.html.erb
    <td><%= User.find(post.user_id}.email %></td>
  ```

  

* `Post`와 `User` 관계 설정 ( 1:N )

  ```ruby
  # user.rb
  class User < ActiveRecord::Base
    # Include default devise modules. Others available are:
    # :confirmable, :lockable, :timeoutable and :omniauthable
    devise :database_authenticatable, :registerable,
           :recoverable, :rememberable, :trackable, :validatable
    has_many :posts
  end
  ```

  ```ruby
  # post.rb
  class Post < ActiveRecord::Base
      mount_uploader :image, ImageUploader
      belongs_to :user
  end
  ```

  

* `Post`에서 `User ` 의 이메일 정보 가져오기

  ```html
  # index.html.erb
          <td><%= post.user.email %></td>
  ```

  ```html
  # show.html.erb
  <p>
    <strong>User:</strong>
    <%= @post.user.email %>
  </p>
  ```

  

* `route`에서 `posts` 확인 ( `new.html.erb` )

  ```ruby
  <%= link_to 'Back', posts_path %>
  ```

  