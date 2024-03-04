# Introduction

<h3>B2C 조명 쇼핑몰 플랫폼, 라이트링크 (외주 프로젝트)</h3>

1. Service Scope: [Web](https://lightlink.co.kr/?pn=main) / Android / IOS
2. Application Developing Tool: Flutter / Android Studio / X Code
3. Server Configuration: CentOS / MariaDB / MySQL
4. BackEnd Developing Tool: PHP / PHPMyAdmin (RDBMS) / 자사 쇼핑몰 솔루션
5. Native App Performance

- InApp Push Service: Firebase Cloud Messaging
- InAppWebView Payment Gate: Toss Payments SDK

# External Plugin List

1. cupertino_icons: ^1.0.2
2. flutter_webview_pro: ^3.0.1+4
3. webview_cookie_manager: ^2.0.6
4. permission_handler: ^11.0.1
5. shared_preferences: ^2.2.2
6. url_launcher: ^6.2.1
7. get: ^4.6.6
8. get_storage: ^2.1.1
9. package_info: ^2.0.2
10. tosspayments_widget_sdk_flutter: ^1.0.2
11. fluttertoast: ^8.2.4
12. fk_user_agent: ^2.1.0
13. android_id: ^0.3.6
14. device_info_plus: ^9.1.1
15. firebase_core: ^2.24.2
16. firebase_crashlytics: ^3.4.9
17. firebase_analytics: ^10.8.0
18. firebase_messaging: ^14.7.10
19. flutter_local_notifications: ^9.1.5

# Issue01

<h3>User Agent Issue</h3>

<div style="margin-top: 50px">
    <p>해당 이슈는 [하이브리드 앱 + 쇼핑몰 플랫폼]이 결합된 특수성으로부터 기인한다.</p>
    <p>우선 쇼핑몰은 플랫폼의 외연성 확장을 위해 '비회원 결제'를 별도의 기능으로 빼놓는다.</p>
    <p>즉, 쇼핑몰의 이용자들은 기본적으로 <strong>회원 / 비회원</strong>으로 구분되는 셈이다.</p>
    <p>여기에 어플리케이션 서비스까지 결합된다면 프로세스는 더욱 복잡해진다.</p>
    <p>회원과 비회원을 구분하기에 앞서 <strong>앱 설치 여부</strong>부터 판정해야 하기 때문이다.</p>
    <p>그래야만 로그아웃 상태의 앱 유저를 비회원으로 처리할 수 있다.</p>
    <p>하지만 하이브리드 앱과 모바일 브라우저는 사실상 동일한 환경이기 때문에 클라이언트에서 이 부분을 처리해줘야 한다.</p>
    <li><i>Native App User Agent: Mozilla/5.0 (Linux; Android 13; SM-N986N Build/TP1A.220624.014; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/121.0.6167.180 Mobile Safari/537.36</i></li>
    <li><i>Browser User Agent: Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.0.0 Mobile Safari/537.36</i></li>
</div>

<div style="margin-top: 50px">
    <p>해당 이슈를 해결하기 위해 적지 않은 시간이 투입되었지만 결과적으로 RDBMS에서 실마리를 찾을 수 있었다.</p>
    <p>관계형 데이터베이스에는 PK라는 개념이 있다.</p>
    <p>하나의 테이블에서 대체할 수 없는 유일한 값을 Primary Key라고 한다.</p>
    <p>그렇다면 클라이언트 측에서 고유한 ID 값을 생성한 다음, 서버로 전송해주면 간단하지 않을까?</p>
</div>

<div style="margin-top: 50px">
    <p>여기에 대하여 두 개의 외부 플러그인에서 답을 찾을 수 있었다.</p>
    <p>1. <a href="https://pub.dev/packages/android_id">android_id</a></p>
    <p>2. <a href="https://pub.dev/packages/device_info_plus">device_info_plus</a></p>
    <p>OS별로 상응하는 고유한 AppID를 만들어주는 난수생성기와 같은 패키지라고 할 수 있다.</p>
    <p>이 값들을 Snapshot 형태의 데이터로 담아서 List처럼 뿌려주는 것이다.</p>
    <p>그렇다면 앱이 초기화 될 때마다 해당 값들을 서버로 전송할 수 있다.</p>
    <p>자세한 로직은 하단 링크를 참조 바란다.</p>
</div>

<div style="margin-top: 50px">
    <p>#01. <a href="https://github.com/academy3746/raon_b2c/blob/main/lib/features/widgets/user_info.dart#L23">AppID 생성 (Android / IOS)</a></p>
    <p>#02. <a href="https://github.com/academy3746/raon_b2c/blob/main/lib/features/widgets/user_info.dart#L68">Snapshot Data 가공</a></p>
    <p>#03. SnapShot Data 전송</p>
    <li><a href="https://github.com/academy3746/raon_b2c/blob/main/lib/features/screens/main_screen/main_screen.dart#L45">과정1</a></li>
    <li><a href="https://github.com/academy3746/raon_b2c/blob/main/lib/features/screens/main_screen/main_screen.dart#L53">과정2</a></li>
    <li><a href="https://github.com/academy3746/raon_b2c/blob/main/lib/features/screens/main_screen/main_screen.dart#L111">과정3</a></li>
</div>

<div style="margin-top: 50px">
    <p></p>
    <p></p>
    <p></p>
    <p></p>
    <p></p>
<p></p>
</div>