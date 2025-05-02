// express 라이브러리 사용
const express = require('express');
const app = express();

// Web Server 띄울것
app.listen(8080, () => {
  console.log('서버 실행중 http://localhost:8080');
});

// 메인 페이지 방문시 '안녕'을 보여주게 함!
app.get('/', (req, res) => {
  res.send('안녕~~~~~~~~~ 우헤헤헤헤');
}); 