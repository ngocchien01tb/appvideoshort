import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
import 'package:photo_manager/photo_manager.dart';
// import 'package:image_picker/image_picker.dart';

class AddVideoScreen extends StatefulWidget {
  const AddVideoScreen({super.key});

  @override
  State<AddVideoScreen> createState() => _AddVideoScreenState();
}

class _AddVideoScreenState extends State<AddVideoScreen> {
  @override
  void initState() {
    super.initState();
    // Gọi hàm pickVideo() khi màn hình khởi tạo
    // pickVideo();
  }

  Widget build(BuildContext context) {
    return VideoPickerScreen();
  }
}

// Future<void> pickVideo() async {
//   final ImagePicker _picker = ImagePicker();
//   final XFile? video = await _picker.pickVideo(source: ImageSource.gallery);

//   if (video != null) {
//     // Bạn đã lấy được video, giờ có thể tiếp tục với phần upload
//     print('Video path: ${video.path}');
//   } else {
//     print('No video selected.');
//   }
// }
class VideoPickerScreen extends StatefulWidget {
  @override
  _VideoPickerScreenState createState() => _VideoPickerScreenState();
}

class _VideoPickerScreenState extends State<VideoPickerScreen> {
  List<AssetEntity> _videos = [];

  @override
  void initState() {
    super.initState();
    _fetchVideos();
  }

  Future<void> _fetchVideos() async {
    // Yêu cầu quyền truy cập vào thư viện
    final PermissionState permission =
        await PhotoManager.requestPermissionExtend();
    if (permission.isAuth) {
      // Lấy danh sách video từ thư viện
      List<AssetPathEntity> albums = await PhotoManager.getAssetPathList(
        type: RequestType.video,
      );
      if (albums.isNotEmpty) {
        List<AssetEntity> videos = await albums[0]
            .getAssetListPaged(page: 0, size: 100); // Lấy tối đa 100 video
        setState(() {
          _videos = videos;
        });
      }
    } else {
      // Quyền bị từ chối
      PhotoManager.openSetting();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chọn Video từ Thư viện'),
      ),
      body: _videos.isEmpty
          ? Center(child: CircularProgressIndicator())
          : GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 4,
                mainAxisSpacing: 4,
              ),
              itemCount: _videos.length,
              itemBuilder: (context, index) {
                return FutureBuilder<Uint8List?>(
                  future: _videos[index].thumbnailData,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done &&
                        snapshot.data != null) {
                      return GestureDetector(
                        onTap: () async {
                          // Thực hiện điều gì đó khi chọn video
                          File? file = await _videos[index].file;
                          if (file != null) {
                            print('Video path: ${file.path}');
                          }
                        },
                        child: Image.memory(
                          snapshot.data!,
                          fit: BoxFit.cover,
                        ),
                      );
                    } else {
                      return Container(
                        color: Colors.grey[300],
                      );
                    }
                  },
                );
              },
            ),
    );
  }
}
