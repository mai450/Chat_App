part of 'group_unread_msg_cubit.dart';

@immutable
sealed class GroupUnreadMsgState {}

final class GroupUnreadMsgInitial extends GroupUnreadMsgState {}

final class GroupUnreadMsgCount extends GroupUnreadMsgState {
  final int count;

  GroupUnreadMsgCount({required this.count});
}
