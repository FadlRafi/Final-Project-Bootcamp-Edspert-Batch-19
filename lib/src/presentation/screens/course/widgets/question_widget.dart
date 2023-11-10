import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:learn_apps/src/domain/entity/question_response_entity.dart';

class QuestionWidget extends StatelessWidget {
  final QuestionDataEntity data;
  final int now;
  const QuestionWidget({super.key, required this.data, required this.now});

  @override
  Widget build(BuildContext context) {
    List answerIndex = [
      data.optionA,
      data.optionB,
      data.optionC,
      data.optionD,
      data.optionE
    ];
    List opsionIndex = ['A', 'B', 'C', 'D', 'E'];
    Widget body = const SizedBox();
    if (data.questionTitle == '') {
      body = Image.network(data.questionTitleImg);
    } else if (data.questionTitleImg == '') {
      body = HtmlWidget(
        data.questionTitle,
        textStyle: const TextStyle(color: Colors.black),
      );
    } else {
      body = HtmlWidget(
        data.questionTitle,
        textStyle: const TextStyle(color: Colors.black),
      );
    }
    return SingleChildScrollView(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
      child: Column(
        children: [
          SizedBox(
            height: 25,
            width: double.infinity,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: 10,
              separatorBuilder: (context, index) => const SizedBox(
                width: 10,
              ),
              itemBuilder: (context, index) => Container(
                  height: 25,
                  width: 25,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: now == index ? const Color(0xFF3A7FD5) : Colors.white,
                      borderRadius: BorderRadius.circular(25),
                      border: Border.all(color: const Color(0xFF3A7FD5))),
                  child: Text(
                    '${index + 1}',
                    style: TextStyle(color: now == index ? Colors.white : const Color(0xFF3A7FD5)),
                  )),
            ),
          ),
          const SizedBox(height: 18),
          LayoutBuilder(
            builder: (context, constraints) {
              return body;
            },
          ),
          const SizedBox(height: 18),
          SizedBox(
            height: 550,
            width: double.infinity,
            child: ListView.separated(
              physics: const NeverScrollableScrollPhysics(),
              separatorBuilder: (context, index) => const SizedBox(
                height: 10,
              ),
              itemCount: answerIndex.length,
              itemBuilder: (context, index) => Container(
                height: 100,
                padding: const EdgeInsets.only(left: 15, right: 15),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.black)),
                width: double.infinity,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(opsionIndex[index]),
                    SizedBox(
                      height: 85,
                      width: 270,
                      child: HtmlWidget(
                        answerIndex[index],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 25),
        ],
      ),
    );
  }
}
