class QuestionResponse {
    int? status;
    String? message;
    List<QuestionData>? data;

    QuestionResponse({
        this.status,
        this.message,
        this.data,
    });

    factory QuestionResponse.fromJson(Map<String, dynamic> json) => QuestionResponse(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null ? [] : List<QuestionData>.from(json["data"]!.map((x) => QuestionData.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    };
}

class QuestionData {
    String? exerciseIdFk;
    String? bankQuestionId;
    String? questionTitle;
    dynamic questionTitleImg;
    String? optionA;
    dynamic optionAImg;
    String? optionB;
    dynamic optionBImg;
    String? optionC;
    dynamic optionCImg;
    String? optionD;
    dynamic optionDImg;
    String? optionE;
    dynamic optionEImg;
    String? studentAnswer;

    QuestionData({
        this.exerciseIdFk,
        this.bankQuestionId,
        this.questionTitle,
        this.questionTitleImg,
        this.optionA,
        this.optionAImg,
        this.optionB,
        this.optionBImg,
        this.optionC,
        this.optionCImg,
        this.optionD,
        this.optionDImg,
        this.optionE,
        this.optionEImg,
        this.studentAnswer,
    });

    factory QuestionData.fromJson(Map<String, dynamic> json) => QuestionData(
        exerciseIdFk: json["exercise_id_fk"],
        bankQuestionId: json["bank_question_id"],
        questionTitle: json["question_title"],
        questionTitleImg: json["question_title_img"],
        optionA: json["option_a"],
        optionAImg: json["option_a_img"],
        optionB: json["option_b"],
        optionBImg: json["option_b_img"],
        optionC: json["option_c"],
        optionCImg: json["option_c_img"],
        optionD: json["option_d"],
        optionDImg: json["option_d_img"],
        optionE: json["option_e"],
        optionEImg: json["option_e_img"],
        studentAnswer: json["student_answer"],
    );

    Map<String, dynamic> toJson() => {
        "exercise_id_fk": exerciseIdFk,
        "bank_question_id": bankQuestionId,
        "question_title": questionTitle,
        "question_title_img": questionTitleImg,
        "option_a": optionA,
        "option_a_img": optionAImg,
        "option_b": optionB,
        "option_b_img": optionBImg,
        "option_c": optionC,
        "option_c_img": optionCImg,
        "option_d": optionD,
        "option_d_img": optionDImg,
        "option_e": optionE,
        "option_e_img": optionEImg,
        "student_answer": studentAnswer,
    };
}

