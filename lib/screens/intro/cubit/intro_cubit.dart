import 'package:doctorapp/screens/intro/cubit/intro_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class IntroCubit extends Cubit<IntroStates> {
  IntroCubit() : super(InitIntroState());
  static IntroCubit get(context) => BlocProvider.of(context);

  int step = 1;

  changeStaep(int val) {
    step = val;
    emit(ChangeSteps());
  }
}
