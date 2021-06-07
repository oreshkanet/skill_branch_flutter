class User {
  String id;
  String updatedAt;
  String username;
  String name;
  String firstName;
  String lastName;
  String twitterUsername;
  String portfolioUrl;
  String bio;
  String location;
  int totalLikes;
  int totalPhotos;
  int totalCollections;
  bool followedByUser;
  int downloads;
  int uploadsRemaining;
  String instagramUsername;
  int followersCount;
  int followingCount;
  String email;
  ProfileImage profileImage;
  UserBadge badge;
  UserLinks links;

  User(
      {this.id,
      this.updatedAt,
      this.username,
      this.name,
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
      this.followersCount,
      this.followingCount,
      this.email,
      this.profileImage,
      this.badge,
      this.links});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    updatedAt = json['updated_at'];
    username = json['username'];
    name = json['name'];
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
    followersCount = json['followers_count'];
    followingCount = json['following_count'];
    email = json['email'];
    profileImage = json['profile_image'] != null
        ? new ProfileImage.fromJson(json['profile_image'])
        : null;
    badge =
        json['badge'] != null ? new UserBadge.fromJson(json['badge']) : null;
    links =
        json['links'] != null ? new UserLinks.fromJson(json['links']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['updated_at'] = this.updatedAt;
    data['username'] = this.username;
    data['name'] = this.name;
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
    data['followers_count'] = this.followersCount;
    data['following_count'] = this.followingCount;
    data['email'] = this.email;
    if (this.profileImage != null) {
      data['profile_image'] = this.profileImage.toJson();
    }
    if (this.badge != null) {
      data['badge'] = this.badge.toJson();
    }
    if (this.links != null) {
      data['links'] = this.links.toJson();
    }
    return data;
  }
}

class ProfileImage {
  String small;
  String medium;
  String large;

  ProfileImage({this.small, this.medium, this.large});

  ProfileImage.fromJson(Map<String, dynamic> json) {
    small = json['small'];
    medium = json['medium'];
    large = json['large'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['small'] = this.small;
    data['medium'] = this.medium;
    data['large'] = this.large;
    return data;
  }
}

class UserBadge {
  String title;
  bool primary;
  String slug;
  String link;

  UserBadge({this.title, this.primary, this.slug, this.link});

  UserBadge.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    primary = json['primary'];
    slug = json['slug'];
    link = json['link'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['primary'] = this.primary;
    data['slug'] = this.slug;
    data['link'] = this.link;
    return data;
  }
}

class UserLinks {
  String self;
  String html;
  String photos;
  String likes;
  String portfolio;

  UserLinks({this.self, this.html, this.photos, this.likes, this.portfolio});

  UserLinks.fromJson(Map<String, dynamic> json) {
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
