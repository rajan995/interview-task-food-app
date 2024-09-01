import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:saler/bloc/main.event.dart';
import 'package:saler/bloc/main.state.dart';

class MainBloc extends Bloc<MainEvent, MainState> {
  MainBloc() : super(InitialMainState()) {
    on<InitialMainEvent>(
      (event, emit) {},
    );
  }
}
