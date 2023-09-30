import 'package:authentification/game3/providers/time_counter_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'game_table_provider.dart';
import 'heart_provider.dart';

final gameOverProvider = StateProvider<bool>((ref) {
    bool isTimerFinish = ref.watch(countDownTimerProvider) == 0 ? true : false;
    bool isRightOver = ref.watch(heartProvider) == 0 ? true : false;
    
    if(isTimerFinish || isRightOver){
      ref.read(scoreProvider);
      return true;
    }
  return false;
});



final scoreProvider = StateProvider<int>((ref) {
  var list = ref.watch(cardWidgetProvider).where((element) => element.item.isActive);
  
  return ((list.length - 2) / 2 * 100).toInt();
});

final timeSpentProvider = StateProvider<int>(((ref) {
  return 0;
}));