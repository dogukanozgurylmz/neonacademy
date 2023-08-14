import 'package:get_it/get_it.dart';
import 'package:mobx_sm/counter.dart';

final getIt = GetIt.instance;

void setup() {
  getIt.registerSingleton<Counter>(Counter());
}
