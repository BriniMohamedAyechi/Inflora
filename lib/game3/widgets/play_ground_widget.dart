import 'package:authentification/game3/widgets/time_counter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';

import '../providers/game_table_provider.dart';
import '../providers/heart_provider.dart';
import 'card_widget.dart';

class PlayGroundWidget extends ConsumerWidget {
  PlayGroundWidget({Key? key, required this.cardWidget}) : super(key: key);

  final List<CardWidget> cardWidget;


  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.read(controlProvider);

    return IgnorePointer(
                ignoring: !ref.watch(flipOnTouchProvider),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const TimeCounterWidget(),
                    Padding(
                      padding: const EdgeInsets.all(40.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          for (int i = 0;
                              i < ref.watch(heartProvider.state).state;
                              i++)
                            Expanded(
                              child: Lottie.network(
                                "https://assets10.lottiefiles.com/packages/lf20_npyyolgp.json",
                                width: 32,
                                height: 32,
                              ),
                            )
                        ],
                      ),
                    ),
                    Expanded(
                      child: GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 5),
                          itemCount: cardWidget.length,
                          itemBuilder: ((context, index) {
                            return cardWidget[index];
                          })),
                    ),
                  ],
                ),
              );
  }
}