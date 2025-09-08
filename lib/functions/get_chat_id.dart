String getChatId(String user1, String user2) {
  final ids = [user1, user2]..sort();
  return ids.join('_');
}
