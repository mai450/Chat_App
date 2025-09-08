part of 'group_state_cubit.dart';

@immutable
sealed class GroupStateState {}

final class GroupStateInitial extends GroupStateState {}

final class GroupStateLoading extends GroupStateState {}

final class GroupStateLastMessage extends GroupStateState {
  final List<ChatModel> message;

  GroupStateLastMessage({required this.message});
}
