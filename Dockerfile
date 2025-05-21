# [도커로 웹 서버 구동하는 방법]



# 1. Node.js 설치
# FROM 이미지  <= 도커파일 시작시에 FROM으로 시작함!
FROM node:20-slim



# 2. npm install express 터미널에 입력함 
# RUN npm install express를 하면 되기는 하는데 만약 라이브러리가 100개라면 그 때마다 다 적기가 힘들다. 
# 그래서 Package.json을 복사하고 거기 있는 내용을 npm install을 하면 됨!
# 2.1. Package.json 복사 
# COPY 내컴경로 이미지컴터경로 => COPY . .
# 근데 위의 오른쪽 처럼 하면 모든 폴더가 복사 되므로 복사될 필요가 없는 파일은 .dockerignore라는 파일을 만들어서 제외한다.  
# 또한 같은 폴더에 마구마구 복사하니까 폴더가 복잡해지게 되니 복사가 되는 폴더는 만들어서 복사가 되게 한다. 
# 2.1.1. 복사될 폴더를 지정한다. 
WORKDIR /app

# 2.1.2. 이제 /app 으로 복사한다. 
# ** 그런데 속도를 높이기 위해서는 package.json과 package-lock.json파일을 먼저 복사하여 npm install 한 다음에 하는 것이 더 속도를 빠르게 한다(캐싱)
# 2.1.2.1. package*.json 을 먼저 복사한다. 
COPY package*.json . 

# 2.1.2.2. npm install 한다. 
# 이 방법 보다 더 좋은 방법(ci:Clean Install)이 있어서 그 방법을 사용한다.  
# RUN ["npm", "install"] 
RUN ["npm", "ci"]

# 2.1.2.3. 이제 /app으로 모든 파일을 복사한다.
COPY . . 

# 2.1.2.3.1 환경 변수를 집어 넣을 수도 있다. 
# [문법] ENV 이름 = 값
ENV NODE_ENV = production


# 2.2. npm install 을 하려면 아래의 두가지 방법이 있음!
# RUN npm install       <= 첫번째 방법 : /bin/sh -c npm install 실행됨(즉, 쉘 프로그램이 실행됨)
# 2.1.2.X 에서 진행했으므로 여기서는 할 필요 없음!
# RUN ["npm", "install"] 

# 2.3. 추가적으로 EXPOSE라는 것을 할수가 있다. 
# 특정 포트를 열어서 사용하겠다고 메모하는 용도 
EXPOSE 8080



# 3. server.js에 코드 작성함 - 이것은 이미 2번에 다 했음!

# 서버를 실행하는 입장에서는 관리자로 실행하는 것 보다 유저를 만들어서 실행하는 것이 좋음
# 3.1 유저를 생성하는 명령이 필요한데 Node.js 공식 이미지를 사용하는 경우에는 node라는 이름의 유저가 이미 만들어져 있음 
# 3.2 그러므로 유저를 node로 바꾸는 명령을 실행해준다. 
USER node 

# 4. node server.js 터미널에 입력함 - 그런데 도커 파일의 마지막 명령어는 RUN 이 아니라 CMD 이다. 
CMD ["node", "server.js;"] 



# 스프링 부트에서 docker를 사용하는 방법에 대한 간단한 설명도 6강 [성능을 위한 Dockerfile 작성법]에 있음 Java로 개발할경우 참고 가능할 듯!