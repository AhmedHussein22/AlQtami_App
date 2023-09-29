import 'package:equatable/equatable.dart';

import '../../data/models/quran_sur_model.dart';

class AllQuranSur extends Equatable {
  final List<AllQuran> allQuran;

  const AllQuranSur({
    required this.allQuran,
  });

  @override
  List<Object?> get props => [allQuran];
}
