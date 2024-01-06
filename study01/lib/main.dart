import 'package:flutter/material.dart';
import 'registration.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // title: Text("Welcome!"),
        backgroundColor: Color(0xFF4D7EA8), // AppBarの背景色を設定
      ),
      backgroundColor: Color(0xFFB6C2D9), // 全体の背景色を設定
      body: Container(
        color: Color(0xFFB6C2D9), // ログイン画面部分の背景色を設定
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  Text("ChatBot(仮)", style: TextStyle(fontSize: 50)),
                  Text("ログインしてください"),
                ],
              ),
            ),
            CustomTextField(label: "メールアドレス"),
            CustomTextField(label: "パスワード"),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("新規登録は"),
                TextButton(
                  onPressed: () {
                    // 以下の行は Registration クラスが存在する場合にのみ有効
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Registration()),
                    );
                  },
                  child: Text("こちら"),
                ),
              ],
            ),
            ElevatedButton(
              onPressed: () {},
              child: Container(
                width: 200,
                height: 50,
                alignment: Alignment.center,
                child: Text('ログイン', textAlign: TextAlign.center),
              ),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Color(0xFFC6C7C4)), // ボタンの背景色を設定
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomTextField extends StatelessWidget {
  final String label;

  CustomTextField({
    required this.label,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        onChanged: (newText) {},
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
        ),
      ),
    );
  }
}
