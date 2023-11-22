class ChatUser {
  bool? isOnline;
  String? id;
  String? createdAt;
  String? pushToken;
  String? image;
  String? email;
  String? about;
  String? lastActive;
  String? name;

  ChatUser(
      {this.isOnline,
      this.id,
      this.createdAt,
      this.pushToken,
      this.image,
      this.email,
      this.about,
      this.lastActive,
      this.name});

  ChatUser.fromJson(Map<String, dynamic> json) {
    isOnline = json['is_online'];
    id = json['id'];
    createdAt = json['created_at'];
    pushToken = json['push_token'];
    image = json['image'];
    email = json['email'];
    about = json['about'];
    lastActive = json['last_active'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['is_online'] = isOnline;
    data['id'] = id;
    data['created_at'] = createdAt;
    data['push_token'] = pushToken;
    data['image'] = image;
    data['email'] = email;
    data['about'] = about;
    data['last_active'] = lastActive;
    data['name'] = name;
    return data;
  }
}
