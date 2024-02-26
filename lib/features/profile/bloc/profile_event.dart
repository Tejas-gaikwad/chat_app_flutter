part of 'profile_bloc.dart';

sealed class ProfileEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class GetProfileInformationEvent extends ProfileEvent {
  final String userId;

  GetProfileInformationEvent({
    required this.userId,
  });

  @override
  List<Object> get props => [userId];
}
