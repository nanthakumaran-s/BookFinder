import 'dart:io';
import 'package:image/image.dart' as Img;
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';

final picker = ImagePicker();

takePhoto() async {
  PickedFile _file = await picker.getImage(source: ImageSource.gallery);
  File _croppedFile = await ImageCropper.cropImage(
    sourcePath: _file.path,
    aspectRatio: CropAspectRatio(ratioX: 1.5, ratioY: 2),
  );
  File compressedFileOfImg = await compressImg(_croppedFile);
  return compressedFileOfImg;
}

compressImg(file) async {
  String postId = Uuid().v4();
  final tempDir = await getTemporaryDirectory();
  final path = tempDir.path;
  Img.Image image = Img.decodeImage(file.readAsBytesSync());
  final compressedImageFile = File('$path/$postId.jpg')
    ..writeAsBytesSync(Img.encodeJpg(
      image,
      quality: 80,
    ));
  return compressedImageFile;
}
