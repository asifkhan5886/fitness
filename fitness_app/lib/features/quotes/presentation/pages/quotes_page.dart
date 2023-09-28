import 'package:fitness_app/core/common_widgets/common_circular_progress_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fitness_app/core/base/base_bloc.dart';
import 'package:fitness_app/features/quotes/presentation/bloc/quotes_bloc.dart';

import '../bloc/quotes_state.dart';

class QuotesPage extends StatelessWidget {
  const QuotesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final orientation = MediaQuery.of(context).orientation;
    QuotesBloc bloc = BlocProvider.of<QuotesBloc>(context);
    return BlocBuilder<QuotesBloc, BaseState>(builder: (context, state) {
      if (state is StateLoading) {
        return  const Center(child: CommonCircularProgressIndicator());
      }
      else if ((state is GetQuotesState) &&
          state.quotesList != null &&
          (state.quotesList?.isNotEmpty ?? false)) {
        return ListView.builder(
          shrinkWrap: true,
          physics: const BouncingScrollPhysics(),
          itemCount: state.quotesList!.length,
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          itemBuilder: (BuildContext context, int index) {
            return Card(
              child: ListTile(
                title: Text( state.quotesList?[index].author ?? ''),
                subtitle: Text(state.quotesList?[index].quote??''),
              ),
            );
          },
        );
      } else if ((state is GetQuotesState) &&
          state.quotesList == null &&
          (state.quotesList?.isEmpty ?? true)) {
        return const Center(
          child: Text("No data found"),
        );
      } else {
        return const SizedBox.shrink();
      }
    });
  }
}
