class ProfileMe {
  String id;
  String updatedAt;
  String username;
  String firstName;
  String lastName;
  String twitterUsername;
  Null portfolioUrl;
  String bio;
  Null location;
  int totalLikes;
  int totalPhotos;
  int totalCollections;
  bool followedByUser;
  int downloads;
  int uploadsRemaining;
  String instagramUsername;
  String email;
  Links links;

  ProfileMe(
      {this.id,
      this.updatedAt,
      this.username,
      this.firstName,
      this.lastName,
      this.twitterUsername,
      this.portfolioUrl,
      this.bio,
      this.location,
      this.totalLikes,
      this.totalPhotos,
      this.totalCollections,
      this.followedByUser,
      this.downloads,
      this.uploadsRemaining,
      this.instagramUsername,
      this.email,
      this.links});

  ProfileMe.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    updatedAt = json['updated_at'];
    username = json['username'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    twitterUsername = json['twitter_username'];
    portfolioUrl = json['portfolio_url'];
    bio = json['bio'];
    location = json['location'];
    totalLikes = json['total_likes'];
    totalPhotos = json['total_photos'];
    totalCollections = json['total_collections'];
    followedByUser = json['followed_by_user'];
    downloads = json['downloads'];
    uploadsRemaining = json['uploads_remaining'];
    instagramUsername = json['instagram_username'];
    email = json['email'];
    links = json['links'] != null ? new Links.fromJson(json['links']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['updated_at'] = this.updatedAt;
    data['username'] = this.username;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['twitter_username'] = this.twitterUsername;
    data['portfolio_url'] = this.portfolioUrl;
    data['bio'] = this.bio;
    data['location'] = this.location;
    data['total_likes'] = this.totalLikes;
    data['total_photos'] = this.totalPhotos;
    data['total_collections'] = this.totalCollections;
    data['followed_by_user'] = this.followedByUser;
    data['downloads'] = this.downloads;
    data['uploads_remaining'] = this.uploadsRemaining;
    data['instagram_username'] = this.instagramUsername;
    data['email'] = this.email;
    if (this.links != null) {
      data['links'] = this.links.toJson();
    }
    return data;
  }
}

class Links {
  String self;
  String html;
  String photos;
  String likes;
  String portfolio;

  Links({this.self, this.html, this.photos, this.likes, this.portfolio});

  Links.fromJson(Map<String, dynamic> json) {
    self = json['self'];
    html = json['html'];
    photos = json['photos'];
    likes = json['likes'];
    portfolio = json['portfolio'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['self'] = this.self;
    data['html'] = this.html;
    data['photos'] = this.photos;
    data['likes'] = this.likes;
    data['portfolio'] = this.portfolio;
    return data;
  }
}
