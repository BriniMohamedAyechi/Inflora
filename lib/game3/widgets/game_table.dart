import 'package:authentification/game3/widgets/play_ground_widget.dart';
import 'package:authentification/game3/widgets/progress_indicator_widget.dart';
import 'package:authentification/game3/widgets/win_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/game_over_provider.dart';
import '../providers/game_table_provider.dart';
import '../providers/win_provider.dart';
import 'card_widget.dart';
import 'game_over_widget.dart';

// ignore: must_be_immutable
class GameTable extends ConsumerWidget {
  GameTable({Key? key}) : super(key: key);

  late List<CardWidget> cardWidget;
  bool isGameOver = false;
  bool isWin = false;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    cardWidget = ref.watch(cardWidgetProvider);
    isGameOver = ref.watch(gameOverProvider);
    isWin = ref.watch(gameWinProvider);
    
    return isGameOver
        ? const GameOverWidget()
        : isWin ? const WinWidget() : cardWidget.isEmpty
            ? const MyCircularProgressIndicator()
            : PlayGroundWidget(cardWidget: cardWidget);
  }
}
