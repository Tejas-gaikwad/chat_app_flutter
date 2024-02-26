part of 'theme_bloc.dart';

sealed class ThemeEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class ToggleThemeEvent extends ThemeEvent {}
