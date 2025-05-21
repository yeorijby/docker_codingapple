# [도커로 웹 서버 구동하는 방법]



# 1. nginx 설치
# FROM 이미지  <= 도커파일 시작시에 FROM으로 시작함!
FROM nginx:1.27.2-alpine


# 2. nginx 설정 파일 작성 
COPY ./myconfig1.conf /etc/nginx/conf.d/myconfig1.conf 

# 3. defualt.conf 파일 지우기 
# RUN rm /etc/nginx/conf.d/defualt.conf
# 그런데 이렇게 하면 파일이 존재하지 않을 경우 오류가 발생한다. 
RUN test -e /etc/nginx/conf.d/default.conf && rm /etc/nginx/conf.d/default.conf 
# test -e 존재 여부, test -d 미존재 여부=> 존재시 &&

# 4. 추가적으로 EXPOSE라는 것을 할수가 있다. 
# 특정 포트를 열어서 사용하겠다고 메모하는 용도 
EXPOSE 81


# 5. nginx 실행 명령어를 터미널에 입력함 - 그런데 도커 파일의 마지막 명령어는 RUN 이 아니라 CMD 이다. 
CMD ["nginx", "-g", "daemon off;"] 
