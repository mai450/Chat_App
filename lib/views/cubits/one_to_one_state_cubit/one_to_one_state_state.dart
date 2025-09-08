part of 'one_to_one_state_cubit.dart';

@immutable
sealed class OneToOneStateState {}

final class OneToOneStateStateInitial extends OneToOneStateState {}

final class OneToOneStateStateLoading extends OneToOneStateState {}

final class OneToOneStateStateSuccess extends OneToOneStateState {
  final List<ChatModel> messages;

  OneToOneStateStateSuccess({required this.messages});
}

final class OneToOneStateStateFailure extends OneToOneStateState {}
