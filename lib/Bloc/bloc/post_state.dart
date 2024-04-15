import 'package:agva_app/Bloc/enums.dart';
import 'package:agva_app/Bloc/models.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class PostStates extends Equatable {
  final PostStatus postStatus;
  final List<PostModel> postList;
  // final String message;
  const PostStates({
    this.postStatus = PostStatus.loading,
    this.postList = const <PostModel>[],
    // this.message = '',
  });

  PostStates copyWith(
      {PostStatus? postStatus, List<PostModel>? postList, String? message}) {
    return PostStates(
      postStatus: postStatus ?? this.postStatus,
      postList: postList ?? this.postList,
      // message: message ?? this.message,
    );
  }

  @override
  List<Object> get props => [postStatus, postStatus];
}

class DevicesState extends Equatable {
  final PostStatus postStatus;
  final List<DeviceModel> deviceList;
  // final String message;
  const DevicesState({
    this.postStatus = PostStatus.loading,
    this.deviceList = const <DeviceModel>[],
    // this.message = '',
  });
  DevicesState copyWith(
      {PostStatus? postStatus,
      List<DeviceModel>? deviceList,
      String? message}) {
    return DevicesState(
      postStatus: postStatus ?? this.postStatus,
      deviceList: deviceList ?? this.deviceList,
      // message: message ?? this.message,
    );
  }

  @override
  // TODO: implement props
  List<Object> get props => [postStatus, postStatus];
}

class AllDevicesState extends Equatable {
  final PostStatus postStatus;
  final List<DeviceModel> alldeviceList;

  const AllDevicesState({
    this.postStatus = PostStatus.loading,
    this.alldeviceList = const <DeviceModel>[],
  });
  AllDevicesState copyWith(
      {PostStatus? postStatus,
      List<DeviceModel>? alldeviceList,
      String? message}){

   return AllDevicesState(
      postStatus: postStatus ?? this.postStatus,
      alldeviceList: alldeviceList ?? this.alldeviceList,
      // message: message ?? this.message,
    );
  }
   @override
  // TODO: implement props
  List<Object> get props => [postStatus, postStatus];

}





// class DeviceDetailsState extends Equatable{
//    final PostStatus postStatus;
//    bool currentStatus = false;

//    const DeviceDetailsState({
//     this.postStatus = PostStatus.loading,
//     this.currentStatus = false,
//    })
// }
