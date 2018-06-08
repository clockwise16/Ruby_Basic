#launchy를 불러온다.
#launchy에게 브라우저를 열어달라고 한다.

require "launchy"
require "uri"
#Launchy.open("https://www.naver.com") #Launchy 대문자 주의

puts "안녕" + "루비"
a= "hello"
b= "ruby"

puts a + " " + b

keywords = ["IU", "SUZY", "fromis9"]

#https://search.naver.com/search.naver?where=nexearch&sm=top_hty&fbm=1&ie=utf8&query=
url= "https://search.naver.com/search.naver?where=nexearch&sm=top_hty&fbm=1&ie=utf8&query="
#keyword= "fromis9"
#keyword= (keywords[0])

n = 0
while(n<3)
    Launchy.open(url+keywords[n])
    n = n+1
end