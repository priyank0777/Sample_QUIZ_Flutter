import 'package:flutter/material.dart';
import '../constants.dart';
import '../Questions/question_model.dart';
import '../Widgets/question_widget.dart';
import '../Widgets/next_button.dart';
import '../Widgets/option_card.dart';
import '../Widgets/result_box.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({Key? key}) : super(key: key);

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {

  List<Question> _questions = [
    Question(
        id: '10',
        title: 'What is 4+4',
        options: {'1':false,'16':false,'8':true,'2':false}
    ),
    Question(
        id: '10',
        title: 'What is 4+2',
        options: {'1':false,'16':false,'6':true,'2':false}
    ),
    Question(
        id: '10',
        title: 'What is 4+44',
        options: {'1':false,'16':false,'48':true,'2':false}
    )
  ];
  int index = 0;

  int score = 0;

  bool isPressed = false;

  bool isAlreadySelected = false;

  void nextQuestion(){
    if(index == _questions.length-1){
      showDialog(context: context,
          barrierDismissible: false ,
          builder: (ctx) => ResultBox(
        result:score ,//total score that user scored
        questionLength: _questions.length,// out of how many questions
        onPressed: startOver,
          ));
    }else{
      if(isPressed){
        setState(() {
          index++;
          isPressed = false;
          isAlreadySelected = false;
        });
      }else{
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content:Text('Please select atleast one option'),behavior:
            SnackBarBehavior.floating,
          margin: EdgeInsets.symmetric(vertical: 20.0),)
        );
      }
    }
  }
  void checkAnswerAndUpdate(bool value){
    if(isAlreadySelected){
      return;
    }else{
      if(value = true){
        score++;
      }{
        setState(() {
          isPressed = true;
          isAlreadySelected = true;
        });
    }
    }

  }

  void startOver(){
    setState(() {
      index = 0;
      score = 0;
      isPressed = false;
      isAlreadySelected = false;
    });
    Navigator.pop(context);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      appBar:AppBar(
        title: const Text("Sample Quiz App"),
        backgroundColor: background,
        shadowColor: Colors.transparent,
        actions: [
          Padding(padding: const EdgeInsets.all(18.0),
              child: Text('Score : $score',
          style: TextStyle(fontSize: 18.0),))
        ],
      ),
      body: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Column(
          children: [
            QuestionWidget(
                question: _questions[index].title,
                indexAction: index,
                totalQuestions: _questions.length,
            ),
            const Divider(color: neutral),
            //adding some space
            const SizedBox(height: 25.0),
            for(int i = 0;i< _questions[index].options.length;i++)
              GestureDetector(
                onTap: () => checkAnswerAndUpdate(_questions[index].options.values.toList()[i]),
                child: OptionCard(
                    option: _questions[index].options.keys.toList()[i],
                    color: isPressed ? _questions[index].options.values.toList()[i] == true
                    ? correct : incorrect : neutral,

                ),
              ),
          ],
        ),
      ),
      //FloatingActionButton
      floatingActionButton: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.0),
          child: NextButton(
            nextQuestion: nextQuestion,
          ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
