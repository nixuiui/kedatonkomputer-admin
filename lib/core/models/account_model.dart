import 'dart:convert';

AccountModel accountModelFromMap(String str) => AccountModel.fromMap(json.decode(str));

String accountModelToMap(AccountModel data) => json.encode(data.toMap());

class AccountModel {
    AccountModel({
        this.id,
        this.fullName,
        this.email,
        this.password,
        this.phoneNumber,
        this.role,
        this.token,
    });

    String id;
    String fullName;
    String email;
    String password;
    String phoneNumber;
    String role;
    String token;

    factory AccountModel.fromMap(Map<String, dynamic> json) => AccountModel(
        id: json["_id"],
        fullName: json["fullName"],
        email: json["email"],
        password: json["password"],
        phoneNumber: json["phoneNumber"],
        role: json["role"],
        token: json["token"],
    );

    Map<String, dynamic> toMap() => {
        "_id": id,
        "fullName": fullName,
        "email": email,
        "password": password,
        "phoneNumber": phoneNumber,
        "role": role,
        "token": token,
    };
    
    Map<String, dynamic> toEditAccountMap() => {
        "fullName": fullName,
        "email": email,
        "phoneNumber": phoneNumber,
        "role": role
    };
}
