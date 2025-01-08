# project814

A new Flutter project.

## Getting Started

# 1. 개요

### 1.1 프로젝트 소개

- 모립포터(Morib Potter; Processor Ryunafe’s Potion Class)는 ‘몰입캠프 + 해리포터’에서 따온 이름으로 해리포터 컨셉의 게임입니다!

### 1.2. 기술 스택

- Front-End: Flutter
- Back_End: Node.js
- DB: MySQL
- IDE: Android Studio
- Version Control: Github

# 2. 팀원 소개

### 최현우

- KAIST 전산학부 21학번
- 백엔드-DB 구현

### 김재민

- 한양대학교 컴퓨터소프트웨어학부 23학번
- 프론트엔드 구현

# 3. 기능 소개

### 3.1. 로그인
- 카카오 소셜 로그인으로 쉽게 로그인 할 수 있어요.
- DB에 저장된 유저라면 바로 기숙사로 가고, 새로운 유저라면 기숙사를 배정받으러 가요.
### 3.2. 기숙사 배정
- 모립포터에는 아름핀도르, 진리데린, 성실푸프, 사랑클로라는 4개의 기숙사가 있어요.
- 새로운 유저인 경우 성격 검사를 통해 가장 잘 맞을 것 같은 기숙사에 배정해 드릴게요.
### 3.3. 기숙사 방(홈 화면)
- 배정받은 기숙사 방을 둘러보세요.
- 표지판을 클릭하면 도서관, 시험장으로 이동할 수 있어요.
- 리더보드 표지판을 클릭하면 내 기록과 전체 랭킹을 볼 수 있어요.
### 3.4. 마법 포션 레시피 족보 도서관

![TalkMedia_i_c7b779e93859.jpg.jpg](https://prod-files-secure.s3.us-west-2.amazonaws.com/f6cb388f-3934-47d6-9928-26d2e10eb0fc/e25ba605-a5fc-4062-8123-67c2bbfb2075/TalkMedia_i_c7b779e93859.jpg.jpg)

![자습실 gif.gif](https://prod-files-secure.s3.us-west-2.amazonaws.com/f6cb388f-3934-47d6-9928-26d2e10eb0fc/954b6b88-4a03-49e7-8c47-fbe615e5d39f/%EC%9E%90%EC%8A%B5%EC%8B%A4_gif.gif)

- 엇! 이 책은 뭐지?
- 포션을 클릭하면 넣어야 하는 재료와 시간 등 정확한 레시피를 볼 수 있어요.
- 레시피를 열심히 암기한 뒤 시험장으로 가세요.

### 3.5. 류네이프 교수님의 마법 포션 시험장

![KakaoTalk_20250108_200054289-ezgif.com-video-to-gif-converter.gif](https://prod-files-secure.s3.us-west-2.amazonaws.com/f6cb388f-3934-47d6-9928-26d2e10eb0fc/51400efd-c599-4108-a8b6-6fa234755c64/KakaoTalk_20250108_200054289-ezgif.com-video-to-gif-converter.gif)

![결과 사진.jpg](https://prod-files-secure.s3.us-west-2.amazonaws.com/f6cb388f-3934-47d6-9928-26d2e10eb0fc/94901c9d-66cd-4830-bc20-1d42460c5e4d/%EA%B2%B0%EA%B3%BC_%EC%82%AC%EC%A7%84.jpg)

- 포션 3개가 랜덤으로 문제에 나와요.
- 재료를 드래그해서 정확한 시간에 냄비에 넣고 정확한 시간에 제출하기 버튼을 누릅니다.
- 포션을 하나 만들 때마다 재료의 위치가 바뀌니 주의하세요!
- 시험 문제 버튼을 클릭하면 문제를 다시 볼 수 있지만, 그 사이에도 시간은 흐르고 있습니다…
- 세 번째 포션까지 제출하면 바로 성적과 류네이프 교수님의 코멘트를 볼 수 있어요!
- 성적이 낮다면 다시 도서관에 가서 공부하세요…!

### 3.6. 리더보드

![TalkMedia_i_a695444291f9.jpg.jpg](https://prod-files-secure.s3.us-west-2.amazonaws.com/f6cb388f-3934-47d6-9928-26d2e10eb0fc/3b351dc9-f4ad-458c-a9c1-b7b7b91b0ec4/TalkMedia_i_a695444291f9.jpg.jpg)

![TalkMedia_i_debb5280a7c4.jpg.jpg](https://prod-files-secure.s3.us-west-2.amazonaws.com/f6cb388f-3934-47d6-9928-26d2e10eb0fc/0142872e-20e3-4307-a2d7-f0fd78638f5b/TalkMedia_i_debb5280a7c4.jpg.jpg)

- 리더보드에서 내 성적 변화를 확인해 보세요.
- 전체 랭킹 탭에서는 다른 사람들의 최고 성적도 볼 수 있어요.

### 3.7. DB Schema
- **`Users (id, nickname, dorm)`**
- **`Scores (id, user_id, score, timestamp)`**
- **`Recipes (id, portion_name, fir_id, fir_time, sec_id, sec_time, thi_id, thi_time, full_time, image_path)`**
- **`ingredients (id, name, image_path)`**

# 4. 보완할 점
- 서버에 이미지까지 업로드해서 사용하고 싶었는데 어려워서 image_path만 저장하여 썼다.
- 디자인을 더 완벽하게 하지 못해서 아쉽다. 특히 버튼…
- 시험 결과에 점수가 더 상세히 나왔으면 더 좋았을 것 같다.

# 5. 사건사고

- **카카오는 위대하다.**
    - 로그인 구현 하나에만 3일을 썼다면 믿으시겠습니까…? 로그인 기능이 이렇게 어려운 것인지 살면서 처음 알았다. 코딩만 해야 하는 것이 아니라 살면서 눌러본 적도 없는 카카오 개발자 센터라는 곳에 가서 Redirection URI를 등록하고, 해시 키를 만들고… 정말 영혼까지 끌어다 썼는데 결국 그냥 대영이형이 가르쳐줘서 성공했다. 외쳐 갓대영~
- **ChatGPT는 실수를 할 수 있습니다.**
    - localhost에서만 돌리던 코드를 kcloud의 vm 서버에 업로드하던 날. 이제는 localhost를 쓰면 안되는 것 아니냐 물으니 chatGPT는 서버 내부의 IP 주소를 사용해야 한다며 나에게 코드를 짜 주었다. 하지만 아무리 돌려봐도 서버에 연결이 되지 않았다. 온갖 고생을 다 해본 후에 NAT IP에 대해서 공부하니 아무리 생각해도 내부 IP가 아니라 저걸 써야 하는 것 아닌가 하는 생각이 들어서 ChatGPT에게 물어봤더니 절대 아니란다. 철썩같이 믿고 다른 방법 시도해보다가 결국 3시간 더 날렸다. 내가 코딩을 너무 많이 시켜서 복수한 것 건가?
- **Github는 어렵다.**
    - 때는 불과 2시간 전, 둘 다 코드를 완성하고 최종 병합해서 돌렸는데 코드가 build조차 되지 않았다. 알고 보니 이상하게 병합된 상태로 commit하고 push까지 해버렸던 것. 덕분에 멘탈 나가서 싹다 rollback하고 한쪽 코드만 가지고 와서 그냥 처음부터 다시 짰다. 오늘 발표 못할까봐 너무 무서웠어요…ㅠㅠ

---

# 6. 후기

### 김재민

- 2주차는 정말 시간이 어떻게 지나갔는지 모르겠어요. 그냥 모르겠어요. 그래도 이게 또 되네요~ 새벽까지 코딩하는 경험이 힘들기도 하지만 뿌듯하고 재밌어요. 그리고 제가 구글 로그인 못 해서 카카오로 떠넘기는 바람에 백엔드하느라 고생한 현우오빠에게 고마움과 미안함을 전하고 싶습니다… 벌써 2주가 지나 제 손 안에 앱 2개가 생겼다는 사실이 새삼 놀랍네요. 남은 2주도 화이팅!!

### 최현우

- 분명히 새벽 4시에 퇴근했는데 내가 제일 빨리 퇴근하고 있는 미친 상황… 밤 새는거 하나는 자신 있었는데 다른 사람들 열정이 정말 대단하네요 🔥🔥 개발 2주차 뉴비인데 벌써 front back 둘 다 해봤다는게 나름 뿌듯하고 행복합니다. 디자인 감각은 전혀 없는 주제에 쓸데없이 욕심은 많아가지고 재민이한테 이거 해줘 저거 해줘 요구한 게 많았는데 군말없이 바꿔준 재민이에게 너무 고맙고 덕분에 2주차도 정말 즐거웠습니다!!
