part of 'group_chat_cubit.dart';

@immutable
sealed class GroupChatState {}

final class GroupChatInitial extends GroupChatState {}

final class GroupChatSuccess extends GroupChatState {
  final List<MessageModel> message;

  GroupChatSuccess({required this.message});
}
