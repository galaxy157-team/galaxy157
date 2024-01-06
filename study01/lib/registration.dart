import 'package:flutter/material.dart';
import 'main.dart';

class Registration extends StatelessWidget {
  Registration({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("新規登録"),
        backgroundColor: Color(0xFF4D7EA8), // AppBarの背景色を設定
      ),
      backgroundColor: Color(0xFFB6C2D9), // 全体の背景色を設定
      body: Container(
        color: Color(0xFFB6C2D9), // ログイン画面部分の背景色を設定
      child: Column(
        children: [
          CustomTextField(label: "メールアドレス"),
          CustomTextField(label: "パスワード"),
          CustomTextField(label: "パスワード確認"),
          ElevatedButton(
              onPressed: () {},
              child: Container(
                width: 200,
                height: 50,
                alignment: Alignment.center,
                child: Text('新規登録', textAlign: TextAlign.center),
           ),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Color(0xFFC6C7C4)),
          ),
          ),// ボタンの背景色を設定
          ],
         )
        ),
    );
  }
}