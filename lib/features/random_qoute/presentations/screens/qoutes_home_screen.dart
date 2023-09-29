import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:naser_alqtami/features/random_qoute/presentations/cubits/random_quote_cubit.dart';
import 'package:naser_alqtami/features/random_qoute/presentations/cubits/random_quote_state.dart';

import '../../../../config/locale/app_localizations.dart';
import '../../../../common_widgets/error_widget.dart';
import '../../../../utils/app_utils/app_colors.dart';
import '../../../on_boarding/presentation/bloc/locale_bloc.dart';
import '../widgets/quots_content.dart';

class QuoteScreen extends StatefulWidget {
  const QuoteScreen({super.key});

  @override
  State<QuoteScreen> createState() => _QuoteScreenState();
}

class _QuoteScreenState extends State<QuoteScreen> {
  _getRandomQuote() => BlocProvider.of<RandomQuoteCubit>(context).getRandomQuote();

  @override
  void initState() {
    super.initState();
    _getRandomQuote();
  }

  Widget _buildBodyContent() {
    return BlocBuilder<RandomQuoteCubit, RandomQuoteState>(
      builder: (context, state) {
        if (state is RandomQuoteIsLoading) {
          return const Center(
            child: CircularProgressIndicator.adaptive(
              backgroundColor: AppColors.DARK_BLUE_COLOR,
            ),
          );
        } else if (state is RandomQuoteError) {
          return OnErrorWidget(
            errorMsg: state.errormsg,
            onPress: () => _getRandomQuote(),
          );
        } else if (state is RandomQuoteLoaded) {
          return Column(
            children: [
              QuoteContent(
                quote: state.quote,
              ),
              InkWell(
                  onTap: () => _getRandomQuote(),
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 15),
                    padding: const EdgeInsets.all(10),
                    decoration: const BoxDecoration(shape: BoxShape.circle, color: AppColors.DARK_BLUE_COLOR),
                    child: const Icon(
                      Icons.refresh,
                      size: 28,
                      color: Colors.white,
                    ),
                  ))
            ],
          );
        } else {
          return const CircularProgressIndicator.adaptive(backgroundColor: AppColors.DARK_BLUE_COLOR);
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(
      leading: IconButton(
        icon: const Icon(
          Icons.translate_outlined,
          color: AppColors.DARK_BLUE_COLOR,
        ),
        onPressed: () {
          if (AppLocalizations.of(context)!.isEnLocale) {
            BlocProvider.of<LocaleCubit>(context).toArabic();
          } else {
            BlocProvider.of<LocaleCubit>(context).toEnglish();
          }
        },
      ),
      title: Text(
        tr(context, "app_name"),
        //AppLocalizations.of(context)!.translate('app_name'),
      ),
    );
    return Scaffold(appBar: appBar, body: _buildBodyContent());
  }
}
