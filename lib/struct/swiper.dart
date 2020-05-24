import 'dart:convert';

class SwiperItem {
    String id;
    String image;
    String schema;

    SwiperItem({
        this.id,
        this.image,
        this.schema,
    });

    factory SwiperItem.fromRawJson(String str) => SwiperItem.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory SwiperItem.fromJson(Map<String, dynamic> json) => SwiperItem(
        id: json["id"],
        image: json["image"],
        schema: json["schema"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "image": image,
        "schema": schema,
    };
}
