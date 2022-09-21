class PostModel {
  PostModel({
    this.postId,
    this.postTitle,
    this.postBody,
    this.postType,
    this.metaData,
    this.updatedAt,
    this.category,
    this.author,
    this.images,
    this.tags,
    this.comments,
  });

  int postId;
  String postTitle;
  String postBody;
  PostType postType;
  dynamic metaData;
  String updatedAt;
  Category category;
  Author author;
  List<Image> images;
  List<Tag> tags;
  List<Comment> comments;

  factory PostModel.fromJson(Map<String, dynamic> json) => PostModel(
    postId: json["post_id"],
    postTitle: json["post_title"],
    postBody: json["post_body"],
    postType: postTypeValues.map[json["post_type"]],
    metaData: json["meta_data"],
    updatedAt: json['updated_at'],
    category: Category.fromJson(json["category"]),
    author: json["author"] == null ? null : Author.fromJson(json["author"]),
    images: List<Image>.from(json["images"].map((x) => Image.fromJson(x))),
    tags: List<Tag>.from(json["tags"].map((x) => Tag.fromJson(x))),
    comments: List<Comment>.from(json["comments"].map((x) => Comment.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "post_id": postId,
    "post_title": postTitle,
    "post_body": postBody,
    "post_type": postTypeValues.reverse[postType],
    "meta_data": metaData,
    "updated_at": updatedAtValues.reverse[updatedAt],
    "category": category.toJson(),
    "author": author == null ? null : author.toJson(),
    "images": List<dynamic>.from(images.map((x) => x.toJson())),
    "tags": List<dynamic>.from(tags.map((x) => x.toJson())),
    "comments": List<dynamic>.from(comments.map((x) => x.toJson())),
  };
}

class Author {
  Author({
    this.authorId,
    this.authorName,
    this.authorEmail,
    this.authorAvatar,
  });

  int authorId;
  String authorName;
  String authorEmail;
  String authorAvatar;

  factory Author.fromJson(Map<String, dynamic> json) => Author(
    authorId: json["author_id"],
    authorName: json["author_name"],
    authorEmail: json["author_email"],
    authorAvatar: json["author_avatar"],
  );

  Map<String, dynamic> toJson() => {
    "author_id": authorId,
    "author_name": authorName,
    "author_email": authorEmail,
    "author_avatar": authorAvatar,
  };
}

class Category {
  Category({
    this.categoryId,
    this.category,
    this.color,
  });

  int categoryId;
  String category;
  String color;

  factory Category.fromJson(Map<String, dynamic> json) => Category(
    categoryId: json["category_id"],
    category: json["category"],
    color: json["color"],
  );

  Map<String, dynamic> toJson() => {
    "category_id": categoryId,
    "category": category,
    "color": color,
  };
}

class Comment {
  Comment({
    this.commentId,
    this.author,
    this.comment,
  });

  int commentId;
  Author author;
  String comment;

  factory Comment.fromJson(Map<String, dynamic> json) => Comment(
    commentId: json["comment_id"],
    author: Author.fromJson(json["author"]),
    comment: json["comment"],
  );

  Map<String, dynamic> toJson() => {
    "comment_id": commentId,
    "author": author.toJson(),
    "comment": comment,
  };
}

class Tag {
  Tag({
    this.tagId,
    this.tag,
  });

  int tagId;
  String tag;

  factory Tag.fromJson(Map<String, dynamic> json) => Tag(
    tagId: json["tag_id"],
    tag: json["tag"],
  );

  Map<String, dynamic> toJson() => {
    "tag_id": tagId,
    "tag": tag,
  };
}

class Categories {
  Categories({
    this.categoryId,
    this.category,
    this.color,
  });

  int categoryId;
  String category;
  String color;

  factory Categories.fromJson(Map<String, dynamic> json) => Categories(
    categoryId: json["category_id"],
    category: json["category"],
    color: json["color"],
  );

  Map<String, dynamic> toJson() => {
    "category_id": categoryId,
    "category": category,
    "color": color,
  };
}

class Image {
  Image({
    this.imgId,
    this.imgDesc,
    this.imgUrl,
    this.postId,
    this.isFeatured,
  });

  int imgId;
  String imgDesc;
  String imgUrl;
  String postId;
  String isFeatured;

  factory Image.fromJson(Map<String, dynamic> json) => Image(
    imgId: json["img_id"] ?? 'fff',
    imgDesc: json["img_desc"] ?? 'fff',
    imgUrl: json["img_url"] ?? 'fff',
    postId: json["post_id"] ?? 'fff',
    isFeatured: json["is_featured"] ?? 'fff',
  );

  Map<String, dynamic> toJson() => {
    "img_id": imgId,
    "img_desc": imgDesc,
    "img_url": imgUrl,
    "post_id": postId,
    "is_featured": isFeatured,
  };
}

enum PostType { TEXT, VIDEO }

final postTypeValues = EnumValues({
  "text": PostType.TEXT,
  "video": PostType.VIDEO
});

enum UpdatedAt { THE_19072022090744 }

final updatedAtValues = EnumValues({
  "19/07/2022 | 09:07:44": UpdatedAt.THE_19072022090744
});

class Links {
  Links({
    this.first,
    this.last,
    this.prev,
    this.next,
  });

  String first;
  String last;
  dynamic prev;
  String next;

  factory Links.fromJson(Map<String, dynamic> json) => Links(
    first: json["first"],
    last: json["last"],
    prev: json["prev"],
    next: json["next"],
  );

  Map<String, dynamic> toJson() => {
    "first": first,
    "last": last,
    "prev": prev,
    "next": next,
  };
}

class Meta {
  Meta({
    this.currentPage,
    this.from,
    this.lastPage,
    this.path,
    this.perPage,
    this.to,
    this.total,
  });

  int currentPage;
  int from;
  int lastPage;
  String path;
  int perPage;
  int to;
  int total;

  factory Meta.fromJson(Map<String, dynamic> json) => Meta(
    currentPage: json["current_page"],
    from: json["from"],
    lastPage: json["last_page"],
    path: json["path"],
    perPage: json["per_page"],
    to: json["to"],
    total: json["total"],
  );

  Map<String, dynamic> toJson() => {
    "current_page": currentPage,
    "from": from,
    "last_page": lastPage,
    "path": path,
    "per_page": perPage,
    "to": to,
    "total": total,
  };
}

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
