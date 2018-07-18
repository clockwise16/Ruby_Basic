180718

# template

### 샘플 템플릿을 기존 프로젝트에 적용해보기

( 참고 강사님 깃헙 : https://github.com/lovings2u/template_app )

<오늘 배운 것과 강사님 자료 다른 부분>

쓸 도구가 아직 준비가 안됐는데 쓰고 싶어하기 때문에 에러 발생. => 따라서 다음과 같이 수정

```
# 다음 문항을 application.html.erb에서 잘라내서 index.html.erb 가장 아래에 붙여준다.
<%= javascript_include_tag    params[:controller] %>
```



* 사용하려는 template의 bootstrap 버전을 확인 할 것 v.3.3.6

  (https://getbootstrap.com/docs/3.3/ 에서도 3.3.7 버전 문서 참고)

* `Gemfile` 변경

  ```ruby
  gem 'bootstrap-sass'	# 3. 대 버전
  # gem 'bootstrap', '~> 4.1.1'	# 4.1 버전 사용시 
  # gem 'turbolinks'
  ```

  ```ruby
  $ bundle
  ```

![1531874682066](https://user-images.githubusercontent.com/37928445/42853043-ecfcbfd2-8a6e-11e8-8d22-035fd231499d.PNG)

* `application.scss`으로 확장자명 변경 

  ```ruby
  # 내용 다 지우고 아래 입력
  @import 'bootstrap';
  ```

* `application.js` 수정

  ```javascript
  //= require turbolinks
  //= require_tree .	# 지우기
  
  // //= require popper	# 4.1 버전 사용시 삽입 or
  //= require bootstrap	# 입력
  
  # 다른 기기에서도 다른 화면에서도 이쁘게 보고 싶으면 bootstrap 아래로 home.js를 다 붙여넣는다
  ```

* `controller` 생성

  ```ruby
  $ rails g controller home index
  ```

* `routes.rb` 수정

  ```ruby
  root 'home#index'
  ```

![1531876180819](https://user-images.githubusercontent.com/37928445/42853607-6fe97eb4-8a72-11e8-8ab2-8ad35edde503.png)



* 테스트로 버튼 추가

  ```html
  <button class="btn btn-info">확인</button>
  ```

  ![image](https://user-images.githubusercontent.com/37928445/42853984-9bd69d70-8a74-11e8-9c4f-a4913a096da3.png)

* 크롬에서 실행한 `index.html` => 검사에서 스타일 시트 확인

  

  ![image](https://user-images.githubusercontent.com/37928445/42853877-11053ed6-8a74-11e8-950a-b19d18fcd1b1.png)

![image](https://user-images.githubusercontent.com/37928445/42853889-1f3b162e-8a74-11e8-9eac-1716ca44298e.png)

![image](https://user-images.githubusercontent.com/37928445/42853921-56c1531a-8a74-11e8-8f91-87b9c1ec1011.png)

* `vender` => `stylesheets` 폴더에 위 사진의 css 파일 추가 ( 이 파일을 적용하는 것은 `home.scss`에서 한다.)

* `home.scss` 수정

  ```ruby
  # 프로젝트에 추가는 됐지만 아직 사용가능한 상태는 아님 다음과 같이 작성 필요
  @import 'external';
  @import 'style';
  @import 'settings';
  @import 'layers';
  @import 'navigation';
  # precompile(하나의 파일로 압축시키겠다) 필요
  
  ```

* `layouts` => `application.html.erb` 수정

  ```html
  <head>
    <title>Workspace</title>
    <%= stylesheet_link_tag    'application', media: 'all'%>	# application.scss를 가지고 온다.
    <%= stylesheet_link_tag    params[:controller], media: 'all' %> # home.scss를 가지고 온다.
    <%= javascript_include_tag 'application'%>
    <%= csrf_meta_tags %>
  </head>
  # 'data-turbolinks-track' => true 삭제 
  ```

*  문법 오류 발생!

  ```ruby
  $ rake assets:precompile	
  $ rake assets:clobber
  # precompile에 home.css 추가가 필요 따라서 하단과 같이 수정
  ```

  ```ruby
  # initializers => assets.rb
  Rails.application.config.assets.precompile += %w( home.js 
                                                    home.scss ) # 주석 해체, js 수정   
  ```

  * `.coffe` 자바 스크립트의 일종

* `javascripts`폴더 =>`home.coffe`를 `home.js`로 수정, 내부 내용 삭제

  

  

  ![image](https://user-images.githubusercontent.com/37928445/42854480-07aa5b8e-8a77-11e8-966d-d4a42f77f6a0.png)

  ![image](https://user-images.githubusercontent.com/37928445/42854608-8ae1ab38-8a77-11e8-9b56-f8206fc49b7f.png)

* `stylesheets`폴더 => `layers.csss` 5651줄 삭제 (error 수정) 

* `stylesheets`폴더 => `navigation.css` 761줄, 1421줄  ; 추가

* 수정 후 서버 다시 껐다 키고, `$ rake assets:precompile` 실행





![image](https://user-images.githubusercontent.com/37928445/42854829-a4a1abd0-8a78-11e8-9db4-50226dce80a8.png)

  ![image](https://user-images.githubusercontent.com/37928445/42854633-b7fc26f2-8a77-11e8-9e66-87ded7de17db.png)

* 기존 사이트에 `home.scss` 적용된 모습 ( `precompile` 후 하나의 파일로 붙여 넣었다 )





![image](https://user-images.githubusercontent.com/37928445/42855411-6abad1c8-8a7b-11e8-96ed-64b48fcc5e77.png)

* `Navbar` 적용 해보기

  `Navbar` 부분 `index`에 붙여 넣기



![image](https://user-images.githubusercontent.com/37928445/42855483-ad6ae2b0-8a7b-11e8-80e1-c88bf4ba6217.png)

* 자바스크립트 추가하기 (위 자바스크립트 모두 추가하면 됨)



![image](https://user-images.githubusercontent.com/37928445/42855510-d4fde106-8a7b-11e8-9a8f-9331e4fe1a20.png)

... 자바스크립트 추가하는 중 ...

![image](https://user-images.githubusercontent.com/37928445/42855562-14a38022-8a7c-11e8-8ded-75fa75cea0b3.png)

![image](https://user-images.githubusercontent.com/37928445/42856062-70736c8a-8a7e-11e8-892f-14e0708bc862.png)

 `rsconfig.js`도 추가할 것 (슬라이드 동작에 관여)

자바스크립트 최종 추가 모습!

* `home.js`에 추가 (확장자 빼고 파일명 추가)

  ```javascript
  //= require plugins
  //= require functions
  //= require jquery.themepunch.tools.min
  //= require jquery.themepunch.revolution.min
  //= require revolution.extension.video.min
  //= require revolution.extension.slideanims.min
  //= require revolution.extension.actions.min
  //= require revolution.extension.layeranimation.min
  //= require revolution.extension.kenburn.min
  //= require revolution.extension.navigation.min
  //= require revolution.extension.migration.min
  //= require revolution.extension.parallax.min
  //= require rsconfig
  ```




* 아이콘이미지가 뜨지 않는 상태 => 이미지 파일 추가하기

  ![image](https://user-images.githubusercontent.com/37928445/42855785-1d0101bc-8a7d-11e8-9355-ec4c720a1f49.png)

  ![image](https://user-images.githubusercontent.com/37928445/42855850-5d160342-8a7d-11e8-82c7-2e92e8849e88.png)

  

  ![image](https://user-images.githubusercontent.com/37928445/42855888-8e26cebc-8a7d-11e8-94b2-12ddb049cc58.png)

  ```
  # views => home => index.html.erb
  # .jpg, .png 파일 다음과 같이 수정
  <img src="<%= asset_path 'blog/thumb/1.jpg' %>" alt="title"/>
  ...
  <img class="logo-dark" src="<%= asset_path 'logo/logo-dark.png' %>" alt="Whole logo">
  ```

  

  ![image](https://user-images.githubusercontent.com/37928445/42858965-3cf63474-8a8c-11e8-9659-7c2e0ddd3e93.png)

  ![image](https://user-images.githubusercontent.com/37928445/42859003-67de87d6-8a8c-11e8-9d88-ac7f482a674a.png)

* Navbar를 index에서 분리하기



![image](https://user-images.githubusercontent.com/37928445/42859025-9ce46fea-8a8c-11e8-8025-fa7eb7ac3e1d.png)

* div application.html.erb로 이동 

* 작성한 _nav.html.erb를 index로 불러오기

  ```
  <div id="wrapper" class="wrapper clearfix">
    <%= render 'shared/nav' %>
    <%= yield %>
  ```

  

![image](https://user-images.githubusercontent.com/37928445/42859214-974a968a-8a8d-11e8-9912-1ac7fc912224.png)

* `footer`를 `index`에서 분리하기 (`_footer.html.erb`에 `footer` 옮기기)



![image](https://user-images.githubusercontent.com/37928445/42859837-57e3181c-8a8f-11e8-9043-4b0c4356ad2b.png)

![image](https://user-images.githubusercontent.com/37928445/42859565-bbcc2536-8a8e-11e8-84d5-993ff2cf553a.png)

* 크롬 콘솔 폰트 error ( woff : web only font file ) 폰트 폴더 만들고 추가하기





![image](https://user-images.githubusercontent.com/37928445/42859605-f4f7be9c-8a8e-11e8-89ef-7ea28cff5eb5.png)

* 에러창에서 찾지 못한 `Linearicons`를 검색 - Search Results에서 더블 클릭하면 해당 부분이 열림 -  수정

  ```
  # url('fonts/Linearicons-Free.woff?w118d') format('woff') => 다음과 같이 변경
  font-url('Linearicons-Free.woff?w118d') format('woff'),
  ```





![image](https://user-images.githubusercontent.com/37928445/42859975-1cf70438-8a90-11e8-8f14-1665b5aea029.png)

* `fontawesome`을 검색 -  수정

  ```
  # url('../fonts/fontawesome-webfont.ttf?v=4.6.3') format('truetype'), => 다음과 같이 변경
  font-url('fontawesome-webfont.ttf?v=4.6.3') format('truetype'),
  
  ```

  

* 추가 변경 해야할 곳

  심장 박동 아이콘 있는 부분 - feature1 / 사진 누르면 설명나오는 항목 - 포트폴리오

  `views` - `home` - `index.html.erb` 위와 같이 붙여 넣기 => 발생하는 사진 에러 해결하기



* 사용자가 보고있는 사이즈가 몇인지 반응해서 배치해줌. (반응형 웹)

  ```
  # application.html.erb 에서 title 아래 붙여주기
  <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
  ```