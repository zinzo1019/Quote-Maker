# 오늘의 명언 앱 (Flutter)

**Notion 바로가기 > https://www.notion.so/App-19e801bc51528075bc7fc802a8ac09e1**

## 개요
Flutter를 사용하여 "오늘의 명언"을 제공하는 간단한 모바일 애플리케이션입니다.
명언 API를 호출하여 새로운 명언을 가져오고, 이를 UI에 표시합니다.

## 주요 기능
- 명언 API를 호출하여 새로운 명언을 가져옵니다.
- 명언과 저자 정보를 표시합니다.
- 버튼 클릭 시 새로운 명언을 불러옵니다.
- Flutter의 Material 디자인을 활용하여 깔끔한 UI를 제공합니다.

## 사용된 기술
- **Flutter**: UI 프레임워크
- **Dart**: 프로그래밍 언어
- **HTTP**: API 요청을 위한 패키지
- **JSON**: API 응답 데이터 처리

## 설치 및 실행 방법
1. Flutter 개발 환경이 설정되어 있어야 합니다.
   - [Flutter 설치 가이드](https://docs.flutter.dev/get-started/install)
2. 프로젝트를 클론합니다:
   ```sh
   git clone <레포지토리_주소>
   cd flutter-quote-app
   ```
3. 의존성을 설치합니다:
   ```sh
   flutter pub get
   ```
4. 앱을 실행합니다:
   ```sh
   flutter run
   ```

## 코드 설명
### 1. `main.dart`
앱의 진입점이며, `MyApp` 위젯을 실행합니다.
```dart
void main() {
  runApp(const MyApp());
}
```

### 2. `MyApp`
StatelessWidget으로 앱의 기본 구조를 제공합니다.
```dart
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: QuoteScreen(),
    );
  }
}
```

### 3. `QuoteScreen`
StatefulWidget을 사용하여 명언 데이터를 관리합니다.
명언 API 요청 후 UI를 업데이트하는 역할을 합니다.
```dart
Future<void> fetchQuote() async {
  final response = await http.get(Uri.parse('https://korean-advice-open-api.vercel.app/api/advice'));
  if (response.statusCode == 200) {
    final data = json.decode(response.body);
    setState(() {
      author = data["author"];
      authorProfile = data["authorProfile"];
      quote = data["message"];
    });
  } else {
    setState(() {
      quote = "명언을 불러오는 데 실패했습니다.";
    });
  }
}
```

### 4. UI 구성
- `Scaffold`: 앱의 기본 화면 구조를 구성합니다.
- `AppBar`: 화면 상단 제목을 표시합니다.
- `Container`: 명언 텍스트를 감싸고 스타일을 적용합니다.
- `ElevatedButton`: API 요청을 트리거하는 버튼입니다.

## 명언 API 정보
- 사용된 API: [korean-advice-open-api](https://korean-advice-open-api.vercel.app)
- 엔드포인트: `https://korean-advice-open-api.vercel.app/api/advice`
- 응답 예시:
```json
{
  "author": "이순신",
  "authorProfile": "조선시대 장군",
  "message": "하늘이 무너져도 솟아날 구멍이 있다."
}
```

## 향후 개선 사항
- 명언을 저장하고 공유하는 기능 추가
- 다크 모드 지원
- UI 디자인 개선

## 라이선스
이 프로젝트는 MIT 라이선스를 따릅니다.

