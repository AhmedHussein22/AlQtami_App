import 'package:naser_alqtami/features/random_qoute/domain/entities/qoutes.dart';

class QuoteModel extends Qoutes {
  const QuoteModel({
    required String msg,
  }) : super(msg: msg);

  factory QuoteModel.fromJson(Map<String, dynamic> json) => QuoteModel(
        msg: json["message"],
      );
}
