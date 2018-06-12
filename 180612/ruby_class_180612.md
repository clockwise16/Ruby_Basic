18.06.12

# 로또 번호 추천 서비스 만들기

`[1,2,3,4,5].include?(5)` : ( )안의 숫자가 배열에 포함되는지

***

### 로또 정보(인터넷 공개)

1. 노가다 -> 손수 직접 옮기기(X)
   * 시간이 많이 걸리고, 큰 데이터 옮기기에 적합 X

2. API 방식(가장 선호)
   * 정보제공자가 기꺼이 정보를 내놓는 경우
   * 가져가기 쉽게 만들어 놓음 (프로그래밍을 통해서)

3. 스크랩/크롤링
   * 정보 제공자가 기꺼이 정보를 내놓지 않은 경우(but, 웹에 있는 경우)
   * 긁어, 뺏서 올 수 있음

***

hash : 이름표를 가진 자료 묶음, (key:이름표, value:값), 순서가 없어 배열이 아니다.

​	ex) {"이름" => "최창원"}

json(구글 확장 프로그램) :  설치하면 API 서비스를 읽기 편하게 개선

​	ex) {"이름":"최창원"}

httparty : ruby에 주소를 불러온다.

![1528771021550](C:\Users\student\AppData\Local\Temp\1528771021550.png)

![1528771668991](C:\Users\student\AppData\Local\Temp\1528771668991.png)

`response.body` : 문서(핵심내용)만 보여준다.

`require 'json' => false` : 이미 깔려있는 상태 

parsing (파싱-쪼개서 나누다) : json(hash와 같은 key value값)을 ruby hash로 바꾸기 -> `require 'json'`

`JSON.parse(response.body)` : '`":"` 이`"=>"` 로 변환된 상태



### 반복문 리팩토링

```
@lotto.push(result["drwtNo1"])
@lotto.push(result["drwtNo2"])
@lotto.push(result["drwtNo3"])
@lotto.push(result["drwtNo4"])
@lotto.push(result["drwtNo5"])
@lotto.push(result["drwtNo6"])

->
6.times do |x|
    @lotto.push(result["drwtNo#{x+1}"]) # +기호 필요없이 
end
```
    a = [1,2,3,4]
    b = [3,4,5,6]
    
    count = 0
    a.each do |x|
    	b.each do |y|
    		if x==y
    			count += 1
    		end
    	end
    end
    
    -> count = (a & b).length
### 프로그래밍 하는 방법(방법 개발론)

1. 일단 돌아가게 만든다.(엄청 무식한 방법이라도 상관X)

2. 테스트를 한다.
3. 리팩토링(refactoring)을 한다.
   - 코드의 악취(bad smell)를 제거한다.
   - 악취 1 : 반복되는 코드(DRY 원칙을 지킨다.)
   - 악취 2 : 보기 힘든 코드
   - 악취 3 : 비효율적인 코드

* 참고 - TDD(Test Driven Development) : 2 -> 1 -> 3



# 환율, 날씨, 주식 정보 서비스 만들기

`require 'eu_central_bank'` 

`bank = EuCentralBank.new` 

`bank.methods` : 사용가능한 명령어 목록

`bank.update_rates` : 현재 기준시를 토대로 환율 정보를 가져온다.

`bank.exchange(1000,'USD','KRW').to_f` : 달러를 원으로 변환 (따옴표 필수) / 소수점 둘째 자리

* option을 가진 태그

    <select name="to">
    	<option value="USD">달러</option>
    	<option value="EUR">유로</option>
    	<option value="JPY">엔</option>
    </select>
![1528788669913](C:\Users\student\AppData\Local\Temp\1528788669913.png)