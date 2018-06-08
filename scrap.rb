require 'httparty'
require 'nokogiri'

# 1.네이버에 원하는 정보가 담긴 페이지 요청
# 2.네이버에게 받은 문서 안에 있는 원하는 정보를 추출
# 3.빼온 정보를 출력
# res = Httparty.get("http://finance.naver.com/sise/")
# val = Nokogiri::HTML(res).css("#KOSPI_now")
# puts "현재 코스피 지수는"+ val.text

headers = {
  'User-Agent': 'Mozilla/5.0 (Windows; U; MSIE 9.0; WIndows NT 9.0; ko-KR))'
} 
res = HTTParty.get("http://finance.daum.net/exchange/exchangeMain.daum", headers: headers)
val = Nokogiri::HTML(res).css("#exInfoList > li:nth-child(1) > div > dl > dd.exPrice")
puts val