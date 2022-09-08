class FakeAPIResponsePostModel {
  final int userId;
  final int id;
  final String title;
  final String body;

  const FakeAPIResponsePostModel(
      {required this.userId,
      required this.id,
      required this.title,
      required this.body});

  factory FakeAPIResponsePostModel.fromJson(Map<String, dynamic> json) {
    return FakeAPIResponsePostModel(
        userId: json['userId'],
        id: json['id'],
        title: json['title'],
        body: json['body']);
  }
}
