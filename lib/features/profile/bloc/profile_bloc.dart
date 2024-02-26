import 'package:bloc/bloc.dart';
import 'package:chat_app_flutter/models/user_data_model.dart';
import 'package:equatable/equatable.dart';

import '../../../services/profile/profile_services.dart';
part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc(super.initialState) {
    final profileServices = ProfileServices();
    on<GetProfileInformationEvent>((event, emit) async {
      try {
        emit(GetProfileLoadingState());

        final userData =
            await profileServices.getProfileInformation(userId: event.userId);

        emit(
          GetProfileSuccessfulState(
            userInformation: UserDataModel(
              uid: userData.uid,
              username: userData.username,
              email: userData.email,
              imagePath: userData.imagePath ??
                  "https://cdn.pixabay.com/photo/2016/08/08/09/17/avatar-1577909_1280.png",
            ),
          ),
        );
      } catch (err) {
        print("Error ->>>>   $err");
        emit(GetProfileErrorState());
      }
    });
  }
}
