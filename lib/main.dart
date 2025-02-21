import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

/**
 * Dart 프로그램의 진입점
 */
void main() {
  // Flutter 프레임워크에서 UI를 실행하는 역할
  // 앱의 루트 위젯 지정
  runApp(const MyApp());
}

/**
 * StatelessWidget - 상태가 변하지 않는 위젯
 */
class MyApp extends StatelessWidget {
  // const 키워드로 불필요한 리빌드 방지 -> 성능 최적화
  const MyApp({super.key});

  /**
   * 위젯을 그리는 함수 - 앱의 기본 구조 반환
   */
  @override
  Widget build(BuildContext context) {
    // Material 디자인을 기반으로 하는 Flutter 앱의 기본 구조 제공
    return MaterialApp(
      // 디버그 모드에서 화면 우측 상단에 나타나는 DEBUG 배너 제거
      debugShowCheckedModeBanner: false,
      // 앱의 첫 화면 지정
      home: QuoteScreen(),
    );
  }
}

/**
 * 앱의 첫 화면 구현
 * StatefulWidget - 상태가 변할 수 있는 위젯
 */
class QuoteScreen extends StatefulWidget {
  // QuoteScreen의 상태를 관리할 새로운 _QuoteScreenState 객체 생성
  @override
  _QuoteScreenState createState() => _QuoteScreenState();
}

class _QuoteScreenState extends State<QuoteScreen> {
  String author = "";
  String authorProfile = "";
  String quote = "오늘의 명언을 탐색해보세요.";

  /**
   * 비동기 명언 API 요청 함수
   * 비동기 - 요청과 결과의 응답은 동시에 일어나지 않음
   * 명언 요청 후 사용자는 다른 작업을 할 수 있음
   */
  Future<void> fetchQuote() async {
    // await 키워드를 사용하면 API 응답이 올 때까지 기다림
    final response = await http.get(Uri.parse('https://korean-advice-open-api.vercel.app/api/advice'));

    // await 키워드를 사용하지 않으면 응답이 오기 전에 아래 코드가 실행됨
    if (response.statusCode == 200) {
      // JSON -> Dart 객체 변환
      final data = json.decode(response.body);
      // setState 호출하여 UI 업데이트
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

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('오늘의 명언'),
        centerTitle: true,
        backgroundColor: Color(0xFF52796F), // 짙은 녹색
        elevation: 0,
      ),
      backgroundColor: Color(0xFFCAD2C5), // 연한 그린 톤
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Color(0xFF84A98C), // 중간 톤 녹색
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 10,
                      offset: Offset(2, 4),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Text(
                      quote,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white, // 텍스트 대비를 위해 흰색
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      author,
                      style: const TextStyle(
                        fontSize: 14,
                        fontStyle: FontStyle.italic,
                        color: Colors.white70, // 살짝 흐린 흰색
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: fetchQuote,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF52796F), // 버튼도 짙은 녹색
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                ),
                child: const Text(
                  '🌿 새로운 명언 가져오기 🌿',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white, // 버튼 텍스트는 흰색
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

