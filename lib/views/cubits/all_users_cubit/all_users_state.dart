part of 'all_users_cubit.dart';

@immutable
sealed class AllUsersState {}

final class AllUsersInitial extends AllUsersState {}

final class AllUsersLoading extends AllUsersState {}

final class AllUsersSuccess extends AllUsersState {
  final List<UserModel> allUsersList;

  AllUsersSuccess({required this.allUsersList});
}

final class AllUsersFailure extends AllUsersState {
  final String errorMessage;

  AllUsersFailure({required this.errorMessage});
}
