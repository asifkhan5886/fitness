import 'package:hive/hive.dart';
part 'user_details.g.dart';

@HiveType(typeId: 0)
class UserDetails {
  @HiveField(0)
  String? name;
  @HiveField(1)
  String? age;
  @HiveField(2)
  String? emailAddress;
  @HiveField(3)
  String? contactPhone;
  @HiveField(4)
  String? height;
  @HiveField(5)
  String? weight;
  @HiveField(6)
  String? sex;

  UserDetails({
    this.name,
    this.emailAddress,
    this.contactPhone,
    this.height,
    this.weight,
    this.sex,
    this.age,
  });

  // UserDetails.fromJson(Map<String, dynamic> json) {
  //   token = json['token'];
  //   name = json['first_name'];
  //   lastName = json['last_name'];
  //   password = json['password'];
  //   cpassword = json['cpassword'];
  //   emailAddress = json['email_address'];
  //   contactPhone = json['contact_phone'];
  //   status = json['status'];
  //   avatar = json['avatar'];
  //   mesiboUid= json["mesibo_uid"];
  //   mesiboAddress= json["mesibo_address"];
  //   mesiboToken= json["mesibo_token"];
  //   countryCode= json["country_code"];
  // }
  //
  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data =  <String, dynamic>{};
  //   data['first_name'] = name;
  //   data['email_address'] = emailAddress;
  //   data['contact_phone'] = contactPhone;
  //   return data;
  // }
}
