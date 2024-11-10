class ShortVideo {
  String? id;
  String? userId;
  String? description;
  String? videoUrl;
  int? likesCount;
  int? commentsCount;
  int? sharesCount;
  dynamic createdAt;

  ShortVideo(
      {this.id,
      this.userId,
      this.description,
      this.videoUrl,
      this.likesCount,
      this.commentsCount,
      this.sharesCount,
      this.createdAt});
}
