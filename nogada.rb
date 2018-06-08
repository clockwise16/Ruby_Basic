#1. 파일을 만든다 100개만
    # -특정 폴더로 들어간다
    # -파일을 만든다
#2. 파일들 100개의 이름을 수정한다.

puts Dir.pwd #현재 있는 디렉토리를 출력
Dir.chdir("files") #폴더 이동하기
#Dir.mkdir("fake") #폴더 만들기, 한 번 만들면 똑같은 것으로 다시 못 만든다.
#puts Dir.entries(Dir.pwd) #현재 폴더에 들어있는 내용을 보여준다.
#puts Dir.pwd #현재 위치 보기
20.times do |x|
    File.open("list#{x}.txt","w") do |f| #파일 만들기("파일이름", "행위"), 없으면 만들고 있으면 다시 덮어쓴다.
        f.write("이건 테스트 파일입니다.") #파일 안에 쓸 내용
    end
end

name = "john"
puts "hello #{name} nice to meet you"