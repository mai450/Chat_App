part of 'one_to_one_chat_cubit.dart';

@immutable
sealed class OneToOneChatState {}

final class OneToOneChatInitial extends OneToOneChatState {}

final class OneToOneChatLoading extends OneToOneChatState {}

final class OneToOneChatSuccess extends OneToOneChatState {
  final List<MessageModel> messagesList;

  OneToOneChatSuccess({required this.messagesList});
}

final class OneToOneChatFailure extends OneToOneChatState {
  final String errMessage;

  OneToOneChatFailure({required this.errMessage});
}
