import 'package:equatable/equatable.dart';

class Qoutes extends Equatable {
  final String msg;


  const Qoutes({
    required this.msg,
  
  });
  @override
  
  List<Object?> get props => [msg];
}
