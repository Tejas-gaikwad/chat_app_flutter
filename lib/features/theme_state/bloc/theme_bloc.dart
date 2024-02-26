import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'theme_event.dart';
part 'theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc(super.initialState) {
    bool isDarkMode = false;

    @override
    Stream<ThemeState> mapEventToState(ThemeEvent event) async* {
      if (event is ToggleThemeEvent) {
        isDarkMode = !isDarkMode;
        yield ThemeChanged(isDarkMode: isDarkMode);
      }
    }
  }
}
