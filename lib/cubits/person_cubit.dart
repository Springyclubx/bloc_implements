import 'package:flutter_bloc/flutter_bloc.dart';

import '../classes/person.dart';

class PersonCubit extends Cubit<Person> {
  PersonCubit(super.initialState);

  void changePerson(Person person) {
    emit(
      state.copyWith(
        name: person.name,
        height: person.height,
        year: person.year,
      ),
    );
  }
}
