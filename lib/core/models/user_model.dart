import 'dart:convert';

UserResponse userResponseFromMap(String str) => UserResponse.fromMap(json.decode(str));

String userResponseToMap(UserResponse data) => json.encode(data.toMap());

User userFromMap(String str) => User.fromMap(json.decode(str));

String userToMap(User data) => json.encode(data.toMap());

class UserResponse {
    UserResponse({
        this.user,
        this.totaluser,
        this.totalPages,
        this.totalAllUser,
        this.currentPage,
        this.limit,
    });

    List<User> user;
    int totaluser;
    int totalPages;
    int totalAllUser;
    int currentPage;
    int limit;

    factory UserResponse.fromMap(Map<String, dynamic> json) => UserResponse(
        user: List<User>.from(json["user"].map((x) => User.fromMap(x))),
        totaluser: json["totaluser"],
        totalPages: json["totalPages"],
        totalAllUser: json["totalAllUser"],
        currentPage: json["currentPage"],
        limit: json["limit"],
    );

    Map<String, dynamic> toMap() => {
        "user": List<dynamic>.from(user.map((x) => x.toMap())),
        "totaluser": totaluser,
        "totalPages": totalPages,
        "totalAllUser": totalAllUser,
        "currentPage": currentPage,
        "limit": limit,
    };
}

class User {
    User({
        this.address,
        this.fcmToken,
        this.gender,
        this.placeOfBirth,
        this.dateOfBirth,
        this.isActive,
        this.photoProfile,
        this.password,
        this.id,
        this.name,
        this.email,
        this.phoneNumber,
        this.createdAt,
        this.updatedAt,
        this.v,
    });

    String address;
    String fcmToken;
    String gender;
    String placeOfBirth;
    DateTime dateOfBirth;
    bool isActive;
    String photoProfile;
    String password;
    String id;
    String name;
    String email;
    String phoneNumber;
    DateTime createdAt;
    DateTime updatedAt;
    int v;

    factory User.fromMap(Map<String, dynamic> json) => User(
        address: json["address"],
        fcmToken: json["fcmToken"],
        gender: json["gender"],
        placeOfBirth: json["placeOfBirth"] == null ? null : json["placeOfBirth"],
        dateOfBirth: DateTime.parse(json["dateOfBirth"]),
        isActive: json["isActive"],
        photoProfile: json["photoProfile"],
        password: json["password"],
        id: json["_id"],
        name: json["name"],
        email: json["email"],
        phoneNumber: json["phoneNumber"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
    );

    Map<String, dynamic> toMap() => {
        "address": address,
        "fcmToken": fcmToken,
        "gender": gender,
        "placeOfBirth": placeOfBirth == null ? null : placeOfBirth,
        "dateOfBirth": dateOfBirth.toIso8601String(),
        "isActive": isActive,
        "photoProfile": photoProfile,
        "password": password,
        "_id": id,
        "name": name,
        "email": email,
        "phoneNumber": phoneNumber,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
    };
}