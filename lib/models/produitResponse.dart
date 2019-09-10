// To parse this JSON data, do
//
//     final ProduitResponse = ProduitResponseFromJson(jsonString);

import 'dart:convert';

List<ProduitResponse> ProduitResponseFromJson(String str) => new List<ProduitResponse>.from(json.decode(str).map((x) => ProduitResponse.fromMap(x)));

String ProduitResponseToJson(List<ProduitResponse> data) => json.encode(new List<dynamic>.from(data.map((x) => x.toMap())));

class ProduitResponse {
    int id;
    String name;
    String slug;
    String permalink;
    Type type;
    Status status;
    bool featured;
    CatalogVisibility catalogVisibility;
    String description;
    String shortDescription;
    String sku;
    String price;
    String regularPrice;
    String salePrice;
    dynamic dateOnSaleFrom;
    dynamic dateOnSaleFromGmt;
    dynamic dateOnSaleTo;
    dynamic dateOnSaleToGmt;
    String priceHtml;
    bool onSale;
    bool purchasable;
    bool virtual;
    bool downloadable;
    List<dynamic> downloads;
    int downloadLimit;
    int downloadExpiry;
    String externalUrl;
    String buttonText;
    TaxStatus taxStatus;
    String taxClass;
    bool manageStock;
    dynamic stockQuantity;
    StockStatus stockStatus;
    Backorders backorders;
    bool backordersAllowed;
    bool backordered;
    bool soldIndividually;
    String weight;
    Dimensions dimensions;
    bool shippingRequired;
    bool shippingTaxable;
    String shippingClass;
    int shippingClassId;
    bool reviewsAllowed;
    String averageRating;
    int ratingCount;
    List<int> relatedIds;
    List<dynamic> upsellIds;
    List<dynamic> crossSellIds;
    int parentId;
    String purchaseNote;
    List<Category> categories;
    List<Category> tags;
    List<ImageResponse> imageResponses;
    List<Attribute> attributes;
    List<dynamic> defaultAttributes;
    List<int> variations;
    List<dynamic> groupedProducts;
    int menuOrder;
    List<MetaDatum> metaData;
    Links links;

    ProduitResponse({
        this.id,
        this.name,
        this.slug,
        this.permalink,
        this.type,
        this.status,
        this.featured,
        this.catalogVisibility,
        this.description,
        this.shortDescription,
        this.sku,
        this.price,
        this.regularPrice,
        this.salePrice,
        this.dateOnSaleFrom,
        this.dateOnSaleFromGmt,
        this.dateOnSaleTo,
        this.dateOnSaleToGmt,
        this.priceHtml,
        this.onSale,
        this.purchasable,
        this.virtual,
        this.downloadable,
        this.downloads,
        this.downloadLimit,
        this.downloadExpiry,
        this.externalUrl,
        this.buttonText,
        this.taxStatus,
        this.taxClass,
        this.manageStock,
        this.stockQuantity,
        this.stockStatus,
        this.backorders,
        this.backordersAllowed,
        this.backordered,
        this.soldIndividually,
        this.weight,
        this.dimensions,
        this.shippingRequired,
        this.shippingTaxable,
        this.shippingClass,
        this.shippingClassId,
        this.reviewsAllowed,
        this.averageRating,
        this.ratingCount,
        this.relatedIds,
        this.upsellIds,
        this.crossSellIds,
        this.parentId,
        this.purchaseNote,
        this.categories,
        this.tags,
        this.imageResponses,
        this.attributes,
        this.defaultAttributes,
        this.variations,
        this.groupedProducts,
        this.menuOrder,
        this.metaData,
        this.links,
    });

    factory ProduitResponse.fromMap(Map<String, dynamic> json) => new ProduitResponse(
        id: json["id"],
        name: json["name"],
        slug: json["slug"],
        permalink: json["permalink"],
        type: typeValues.map[json["type"]],
        status: statusValues.map[json["status"]],
        featured: json["featured"],
        catalogVisibility: catalogVisibilityValues.map[json["catalog_visibility"]],
        description: json["description"],
        shortDescription: json["short_description"],
        sku: json["sku"],
        price: json["price"],
        regularPrice: json["regular_price"],
        salePrice: json["sale_price"],
        dateOnSaleFrom: json["date_on_sale_from"],
        dateOnSaleFromGmt: json["date_on_sale_from_gmt"],
        dateOnSaleTo: json["date_on_sale_to"],
        dateOnSaleToGmt: json["date_on_sale_to_gmt"],
        priceHtml: json["price_html"],
        onSale: json["on_sale"],
        purchasable: json["purchasable"],
        virtual: json["virtual"],
        downloadable: json["downloadable"],
        downloads: new List<dynamic>.from(json["downloads"].map((x) => x)),
        downloadLimit: json["download_limit"],
        downloadExpiry: json["download_expiry"],
        externalUrl: json["external_url"],
        buttonText: json["button_text"],
        taxStatus: taxStatusValues.map[json["tax_status"]],
        taxClass: json["tax_class"],
        manageStock: json["manage_stock"],
        stockQuantity: json["stock_quantity"],
        stockStatus: stockStatusValues.map[json["stock_status"]],
        backorders: backordersValues.map[json["backorders"]],
        backordersAllowed: json["backorders_allowed"],
        backordered: json["backordered"],
        soldIndividually: json["sold_individually"],
        weight: json["weight"],
        dimensions: Dimensions.fromMap(json["dimensions"]),
        shippingRequired: json["shipping_required"],
        shippingTaxable: json["shipping_taxable"],
        shippingClass: json["shipping_class"],
        shippingClassId: json["shipping_class_id"],
        reviewsAllowed: json["reviews_allowed"],
        averageRating: json["average_rating"],
        ratingCount: json["rating_count"],
        relatedIds: new List<int>.from(json["related_ids"].map((x) => x)),
        upsellIds: new List<dynamic>.from(json["upsell_ids"].map((x) => x)),
        crossSellIds: new List<dynamic>.from(json["cross_sell_ids"].map((x) => x)),
        parentId: json["parent_id"],
        purchaseNote: json["purchase_note"],
        categories: new List<Category>.from(json["categories"].map((x) => Category.fromMap(x))),
        tags: new List<Category>.from(json["tags"].map((x) => Category.fromMap(x))),
        imageResponses: new List<ImageResponse>.from(json["images"].map((x) => ImageResponse.fromMap(x))),
        attributes: new List<Attribute>.from(json["attributes"].map((x) => Attribute.fromMap(x))),
        defaultAttributes: new List<dynamic>.from(json["default_attributes"].map((x) => x)),
        variations: new List<int>.from(json["variations"].map((x) => x)),
        groupedProducts: new List<dynamic>.from(json["grouped_products"].map((x) => x)),
        menuOrder: json["menu_order"],
        metaData: new List<MetaDatum>.from(json["meta_data"].map((x) => MetaDatum.fromMap(x))),
        links: Links.fromMap(json["_links"]),
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "slug": slug,
        "permalink": permalink,
        "type": typeValues.reverse[type],
        "status": statusValues.reverse[status],
        "featured": featured,
        "catalog_visibility": catalogVisibilityValues.reverse[catalogVisibility],
        "description": description,
        "short_description": shortDescription,
        "sku": sku,
        "price": price,
        "regular_price": regularPrice,
        "sale_price": salePrice,
        "date_on_sale_from": dateOnSaleFrom,
        "date_on_sale_from_gmt": dateOnSaleFromGmt,
        "date_on_sale_to": dateOnSaleTo,
        "date_on_sale_to_gmt": dateOnSaleToGmt,
        "price_html": priceHtml,
        "on_sale": onSale,
        "purchasable": purchasable,
        "virtual": virtual,
        "downloadable": downloadable,
        "downloads": new List<dynamic>.from(downloads.map((x) => x)),
        "download_limit": downloadLimit,
        "download_expiry": downloadExpiry,
        "external_url": externalUrl,
        "button_text": buttonText,
        "tax_status": taxStatusValues.reverse[taxStatus],
        "tax_class": taxClass,
        "manage_stock": manageStock,
        "stock_quantity": stockQuantity,
        "stock_status": stockStatusValues.reverse[stockStatus],
        "backorders": backordersValues.reverse[backorders],
        "backorders_allowed": backordersAllowed,
        "backordered": backordered,
        "sold_individually": soldIndividually,
        "weight": weight,
        "dimensions": dimensions.toMap(),
        "shipping_required": shippingRequired,
        "shipping_taxable": shippingTaxable,
        "shipping_class": shippingClass,
        "shipping_class_id": shippingClassId,
        "reviews_allowed": reviewsAllowed,
        "average_rating": averageRating,
        "rating_count": ratingCount,
        "related_ids": new List<dynamic>.from(relatedIds.map((x) => x)),
        "upsell_ids": new List<dynamic>.from(upsellIds.map((x) => x)),
        "cross_sell_ids": new List<dynamic>.from(crossSellIds.map((x) => x)),
        "parent_id": parentId,
        "purchase_note": purchaseNote,
        "categories": new List<dynamic>.from(categories.map((x) => x.toMap())),
        "tags": new List<dynamic>.from(tags.map((x) => x.toMap())),
        "imageResponses": new List<dynamic>.from(imageResponses.map((x) => x.toMap())),
        "attributes": new List<dynamic>.from(attributes.map((x) => x.toMap())),
        "default_attributes": new List<dynamic>.from(defaultAttributes.map((x) => x)),
        "variations": new List<dynamic>.from(variations.map((x) => x)),
        "grouped_products": new List<dynamic>.from(groupedProducts.map((x) => x)),
        "menu_order": menuOrder,
        "meta_data": new List<dynamic>.from(metaData.map((x) => x.toMap())),
        "_links": links.toMap(),
    };
}

class Attribute {
    int id;
    AttributeName name;
    int position;
    bool visible;
    bool variation;
    List<String> options;

    Attribute({
        this.id,
        this.name,
        this.position,
        this.visible,
        this.variation,
        this.options,
    });

    factory Attribute.fromMap(Map<String, dynamic> json) => new Attribute(
        id: json["id"],
        name: attributeNameValues.map[json["name"]],
        position: json["position"],
        visible: json["visible"],
        variation: json["variation"],
        options: new List<String>.from(json["options"].map((x) => x)),
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "name": attributeNameValues.reverse[name],
        "position": position,
        "visible": visible,
        "variation": variation,
        "options": new List<dynamic>.from(options.map((x) => x)),
    };
}

enum AttributeName { MODLES, COULEURS }

final attributeNameValues = new EnumValues({
    "Couleurs": AttributeName.COULEURS,
    "Modèles": AttributeName.MODLES
});

enum Backorders { NO }

final backordersValues = new EnumValues({
    "no": Backorders.NO
});

enum CatalogVisibility { VISIBLE }

final catalogVisibilityValues = new EnumValues({
    "visible": CatalogVisibility.VISIBLE
});

class Category {
    int id;
    String name;
    String slug;

    Category({
        this.id,
        this.name,
        this.slug,
    });

    factory Category.fromMap(Map<String, dynamic> json) => new Category(
        id: json["id"],
        name: json["name"],
        slug: json["slug"],
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "name": categoryNameValues.reverse[name],
        "slug": slugValues.reverse[slug],
    };
}

enum CategoryName { RECONDITIONN, I_PHONE_7_PLUS }

final categoryNameValues = new EnumValues({
    "IPhone 7 Plus": CategoryName.I_PHONE_7_PLUS,
    "Reconditionné": CategoryName.RECONDITIONN
});

enum Slug { RECONDITIONNE, IPHONE_7_PLUS }

final slugValues = new EnumValues({
    "iphone-7-plus": Slug.IPHONE_7_PLUS,
    "reconditionne": Slug.RECONDITIONNE
});

class Dimensions {
    String length;
    String width;
    String height;

    Dimensions({
        this.length,
        this.width,
        this.height,
    });

    factory Dimensions.fromMap(Map<String, dynamic> json) => new Dimensions(
        length: json["length"],
        width: json["width"],
        height: json["height"],
    );

    Map<String, dynamic> toMap() => {
        "length": length,
        "width": width,
        "height": height,
    };
}

class ImageResponse {
    int id;
    DateTime dateCreated;
    DateTime dateCreatedGmt;
    DateTime dateModified;
    DateTime dateModifiedGmt;
    String src;
    String name;
    String alt;

    ImageResponse({
        this.id,
        this.dateCreated,
        this.dateCreatedGmt,
        this.dateModified,
        this.dateModifiedGmt,
        this.src,
        this.name,
        this.alt,
    });

    factory ImageResponse.fromMap(Map<String, dynamic> json) => new ImageResponse(
        id: json["id"],
        dateCreated: DateTime.parse(json["date_created"]),
        dateCreatedGmt: DateTime.parse(json["date_created_gmt"]),
        dateModified: DateTime.parse(json["date_modified"]),
        dateModifiedGmt: DateTime.parse(json["date_modified_gmt"]),
        src: json["src"],
        name: json["name"],
        alt: json["alt"],
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "date_created": dateCreated.toIso8601String(),
        "date_created_gmt": dateCreatedGmt.toIso8601String(),
        "date_modified": dateModified.toIso8601String(),
        "date_modified_gmt": dateModifiedGmt.toIso8601String(),
        "src": src,
        "name": name,
        "alt": alt,
    };
}

class Links {
    List<Collection> self;
    List<Collection> collection;

    Links({
        this.self,
        this.collection,
    });

    factory Links.fromMap(Map<String, dynamic> json) => new Links(
        self: new List<Collection>.from(json["self"].map((x) => Collection.fromMap(x))),
        collection: new List<Collection>.from(json["collection"].map((x) => Collection.fromMap(x))),
    );

    Map<String, dynamic> toMap() => {
        "self": new List<dynamic>.from(self.map((x) => x.toMap())),
        "collection": new List<dynamic>.from(collection.map((x) => x.toMap())),
    };
}

class Collection {
    String href;

    Collection({
        this.href,
    });

    factory Collection.fromMap(Map<String, dynamic> json) => new Collection(
        href: json["href"],
    );

    Map<String, dynamic> toMap() => {
        "href": href,
    };
}

class MetaDatum {
    int id;
    Key key;
    dynamic value;

    MetaDatum({
        this.id,
        this.key,
        this.value,
    });

    factory MetaDatum.fromMap(Map<String, dynamic> json) => new MetaDatum(
        id: json["id"],
        key: keyValues.map[json["key"]],
        value: json["value"],
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "key": keyValues.reverse[key],
        "value": value,
    };
}

enum Key { PRODUCT_LAYOUT, PRODUCT_STYLE, TOTAL_STOCK_QUANTITY, ACCESSORY_IDS, SPECIFICATIONS_DISPLAY_ATTRIBUTES, SPECIFICATIONS_ATTRIBUTES_TITLE, SPECIFICATIONS, SLIDE_TEMPLATE, WPB_VC_JS_STATUS }

final keyValues = new EnumValues({
    "_accessory_ids": Key.ACCESSORY_IDS,
    "_product_layout": Key.PRODUCT_LAYOUT,
    "_product_style": Key.PRODUCT_STYLE,
    "slide_template": Key.SLIDE_TEMPLATE,
    "_specifications": Key.SPECIFICATIONS,
    "_specifications_attributes_title": Key.SPECIFICATIONS_ATTRIBUTES_TITLE,
    "_specifications_display_attributes": Key.SPECIFICATIONS_DISPLAY_ATTRIBUTES,
    "_total_stock_quantity": Key.TOTAL_STOCK_QUANTITY,
    "_wpb_vc_js_status": Key.WPB_VC_JS_STATUS
});

enum Status { PUBLISH }

final statusValues = new EnumValues({
    "publish": Status.PUBLISH
});

enum StockStatus { INSTOCK }

final stockStatusValues = new EnumValues({
    "instock": StockStatus.INSTOCK
});

enum TaxStatus { TAXABLE }

final taxStatusValues = new EnumValues({
    "taxable": TaxStatus.TAXABLE
});

enum Type { VARIABLE }

final typeValues = new EnumValues({
    "variable": Type.VARIABLE
});

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
