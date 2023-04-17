import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:chatgpt/dio_helper.dart';
import 'package:chatgpt/home_page.dart';
import 'package:flutter/material.dart';
class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}
class _HomePageState extends State<HomePage>{
  List<String> chat = [
  ];
  TextEditingController textEditingController = TextEditingController();
  ScrollController scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff343541),
      appBar: AppBar(
        backgroundColor: const Color(0xff343541),
        centerTitle: true,
        title: const Text('Chat GPT'),
      ),
      body:SafeArea(
       child: Column(
        children: [
          Expanded(
            child: ListView.builder(
              controller:scrollController,
            itemCount: chat.length,
            itemBuilder: (BuildContext context, int index) {
              if(index%2==0 ) {
                return Container(
                  padding: const EdgeInsets.all(8),
                  color: const Color(0xff444654),
                  child: ListTile(
                    title: Text(chat[index]),
                    leading: const Icon(Icons.account_circle, size: 25,),
                  ),
                );

              }else {
                return Container(
                  padding: const EdgeInsets.all(8),
                  child:  ListTile(
                    title: AnimatedTextKit(
                      repeatForever: false,
                      totalRepeatCount: 1,
                      animatedTexts: [
                      TypewriterAnimatedText(chat[index])
                    ],
                    ),
                    leading: Image.asset('android/asset/chatimage.png',scale: 15,),
                  ),
                );
              }
            },
          ),
          ),
          Padding(
              padding: const EdgeInsets.all(15.0),
            child: Container(
              padding: const EdgeInsets.only(left: 9,top: 4,right: 8,bottom: 4),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: const Color(0xff444654),
              ),
              child: Row(
                children: [
                  Expanded(
                      child: TextFormField(
                        controller: textEditingController,
                        decoration: const InputDecoration.collapsed(hintText: 'Type Here'),
                      ),
                  ),
                  TextButton(
                      onPressed: (){
                        getChat();
                        // setState((){
                        //   chat.add(textEditingController.text);
                        // });
                      },
                      child: const Icon(Icons.send,color: Colors.white,)
                  ),
                ],
              ),
            ),
          ),
        ],
       ),
      ),
    );
  }
  getChat(){
    if(textEditingController.text.isNotEmpty) {
      setState(() {
        chat.add(textEditingController.text);
      });
      DioHelper.postData(url: 'completions', data: {
        'model': 'gpt-3.5-turbo',
        'messages': [
          {'role': 'user', 'content': '${textEditingController.text}'}
        ]
      }).then((value) {
        if(value.statusCode==200){
          setState(() {
            chat.add(value.data['choices'][0]['message']['content']);
          });
        }else{
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Please Type Message')));
        }
      });
    }else{
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Please Type Message')));
    }
    textEditingController.clear();
  }
}





