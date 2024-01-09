import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MaterialApp(home: SplashScreen()));
}

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: 6), () async {
      await Firebase.initializeApp();
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => ChatBotPage()));
    });

    return Container(
      color: Colors.white,
      child: Center(
        child: Image.asset('image/top_bgimage.png'), // ここにスプラッシュ画像を設定
      ),
    );
  }
}

class ChatBotPage extends StatefulWidget {
  @override
  _ChatBotPageState createState() => _ChatBotPageState();
}

class _ChatBotPageState extends State<ChatBotPage> {
  String _currentStep = 'menu';
  final List<Map<String, String>> _chatMessages = [];
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFB6C2D9),
      appBar: AppBar(title: Text("ChatBot"),
      backgroundColor: Color(0xFF4D7EA8),
    ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              itemCount: _chatMessages.length,
              itemBuilder: (context, index) {
                var message = _chatMessages[index];
                return ListTile(
                  title: Text(message['text'] ?? ''),
                  subtitle: Text(message['type'] ?? 'response'),
                );
              },
            ),
          ),
          _buildInputSection(),
        ],
      ),
    );
  }

  Widget _buildInputSection() {
    return StreamBuilder<DocumentSnapshot>(
      stream: FirebaseFirestore.instance.collection('chat_steps').doc(_currentStep).snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return CircularProgressIndicator();
        var data = snapshot.data?.data() as Map<String, dynamic>?;

        return ListView(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          children: [
            if (data != null) Text(data['question'],style: TextStyle(fontSize: 20),),
            ..._buildChoices(data),
          ],
        );
      },
    );
  }

  List<Widget> _buildChoices(Map<String, dynamic>? data) {
    if (data == null || !data.containsKey('choices')) return [];
    return data['choices'].map<Widget>((choice) {
      return ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.black38, // background
          foregroundColor: Colors.white, // foreground
        ),
        child: Text(choice['text'],style: TextStyle(fontSize: 20),),
        onPressed: () {
          setState(() {

            _chatMessages.add({'text': choice['text'], 'type': ''});
            _currentStep = choice['next_step'];
            _scrollToBottom();
          });
        },
      );
    }).toList();
  }

  void _scrollToBottom() {
    Future.delayed(Duration(milliseconds: 100), () {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: Duration(milliseconds: 200),
          curve: Curves.easeOut,
        );
      }
    });
  }
}
