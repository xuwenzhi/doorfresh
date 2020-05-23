import 'package:flutter/material.dart';
import 'dart:convert';


class FreshItem {
    String id;
    String title;
    String cover_image;
    List<FreshTag> tags;

    FreshItem({
        this.id,
        this.title,
        this.cover_image,
        this.tags,
    });

    factory FreshItem.fromJson(Map<String, dynamic> json) => FreshItem(
        id: json["id"],
        title: json["title"],
        cover_image: json["cover_image"],
        tags: List<FreshTag>.from(json["tags"].map((x) => FreshTag.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "cover_image": cover_image,
        "tags": List<dynamic>.from(tags.map((x) => x.toJson())),
    };

    factory FreshItem.fromRawJson(String str) => FreshItem.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());
}


class FreshTag {
    String id;
    String name;
    String color;
    String back_color;

    FreshTag({
        this.id,
        this.name,
        this.color,
        this.back_color,
    });

    factory FreshTag.fromJson(Map<String, dynamic> json) => FreshTag(
        id: json["id"],
        name: json["name"],
        color: json["color"],
        back_color: json["back_color"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "color": color,
        "back_color": back_color,
    };

    factory FreshTag.fromRawJson(String str) => FreshTag.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());
}
