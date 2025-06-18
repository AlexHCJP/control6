import 'package:control6/models/profile_model.dart';

sealed class ProfileState {}

final class ProfileInitialState extends ProfileState {}

final class ProfileLoadingState extends ProfileState {}

final class ProfileLoadedState extends ProfileState {
  final ProfileModel profile;

  ProfileLoadedState({required this.profile});
}

final class ProfileExceptionState extends ProfileState {}