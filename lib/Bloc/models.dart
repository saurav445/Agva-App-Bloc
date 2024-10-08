class PostModel {
  String? hospitalname;
  String? city;
  String? pincode;

  PostModel({this.hospitalname, this.city, this.pincode});
}

class ProfileModel {
  String? associationName;
  String? workAddress;
  String? workEmail;
  String? department;
  

  ProfileModel(
      {this.associationName,
      this.workAddress,
      this.workEmail,
      this.department,
      
      });
}

class DeviceModel {
  String? wardno;
  String? hospital;
  String? devicetype;
  String? deviceId;
  String? message;
  bool? addTofocus;

  DeviceModel({
    this.wardno,
    this.hospital,
    this.devicetype,
    this.deviceId,
    this.message,
    this.addTofocus,
  });
}

class FocusStatusModel {
  bool? focusStatus;
}
