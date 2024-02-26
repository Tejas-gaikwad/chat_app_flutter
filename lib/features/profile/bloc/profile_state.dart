part of 'profile_bloc.dart';

sealed class ProfileState extends Equatable {
  @override
  List<Object> get props => [];
}

class ProfileInitialState extends ProfileState {}

class GetProfileLoadingState extends ProfileState {}

class GetProfileSuccessfulState extends ProfileState {
  final UserDataModel userInformation;

  GetProfileSuccessfulState({required this.userInformation});

  @override
  List<Object> get props => [userInformation];
}

class GetProfileErrorState extends ProfileState {}
