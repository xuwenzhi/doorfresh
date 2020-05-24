import 'dart:convert';


class FreshItem {
    String id;
    String title;
    String cover_image;
    String price;
    String price_unit;
    String show_price;
    List<FreshTag> tags;

    FreshItem({
        this.id,
        this.title,
        this.cover_image,
        this.price,
        this.price_unit,
        this.show_price,
        this.tags,
    });

    factory FreshItem.fromJson(Map<String, dynamic> json) => FreshItem(
        id: json["id"],
        title: json["title"],
        cover_image: json["cover_image"],
        price: json["price"],
        price_unit: json["price_unit"],
        show_price: json["show_price"],
        tags: List<FreshTag>.from(json["tags"].map((x) => FreshTag.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "cover_image": cover_image,
        "price" : price,
        "price_unit": price_unit,
        "show_price" : show_price,
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
