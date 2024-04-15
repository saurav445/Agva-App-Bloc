import 'package:agva_app/Bloc/bloc/post_event.dart';
import 'package:agva_app/Bloc/bloc/post_state.dart';
import 'package:agva_app/Bloc/enums.dart';
import 'package:agva_app/Bloc/repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PostBloc extends Bloc<PostEvent, PostStates> {
  PostRepository postRepository = PostRepository();
  PostBloc() : super(const PostStates()) {
    on<PostFetched>(fetchPostApi);
  }
  void fetchPostApi(PostFetched event, Emitter<PostStates> emit) async {
    await postRepository.fetchPost().then((value) {
      emit(state.copyWith(postStatus: PostStatus.success, postList: value));
    }).onError((error, stackTrace) {
      emit(state.copyWith(
          postStatus: PostStatus.Failure, message: error.toString()));
    });
  }
}

class BlocDevices extends Bloc<DevicesEvent, DevicesState> {
  DevicesRepository devicesRepository = DevicesRepository();
  BlocDevices() : super(const DevicesState()) {
    on<FetchDevices>(fetchDeviceApi);
  }
  void fetchDeviceApi(FetchDevices event, Emitter<DevicesState> emit) async {
    await devicesRepository.fetchFocusedDevices().then((value) {
      emit(state.copyWith(postStatus: PostStatus.success, deviceList: value));
    }).onError((error, stackTrace) {
      emit(state.copyWith(
          postStatus: PostStatus.Failure, message: error.toString()));
    });
  }
}
class BlocAllDevices extends Bloc<AllDevicesListEvent, AllDevicesState> {
  AllDevicesRepository allDevicesRepository = AllDevicesRepository();

  BlocAllDevices() : super(const AllDevicesState()) {
    on<FetchAllDevices>(fetchAllDevicesApi);
  }

    // Stream<AllDevicesState> get allDevicesStream => stream;

  void fetchAllDevicesApi(
      FetchAllDevices event, Emitter<AllDevicesState> emit) async {
    await allDevicesRepository.fetchFocusedDevices(event.hospital).then((value) {
      emit(
          state.copyWith(postStatus: PostStatus.success, alldeviceList: value));
    }).onError((error, stackTrace) {
      emit(state.copyWith(
          postStatus: PostStatus.Failure, message: error.toString()));
    });
  }
}

