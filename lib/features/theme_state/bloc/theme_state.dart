part of 'theme_bloc.dart';

class ThemeState extends Equatable {
  const ThemeState();

  @override
  List<Object> get props => [];
}

class ThemeInitialState extends ThemeState {}

class ThemeChanged extends ThemeState {
  final bool isDarkMode;

  const ThemeChanged({required this.isDarkMode});

  @override
  List<Object> get props => [isDarkMode];
}
