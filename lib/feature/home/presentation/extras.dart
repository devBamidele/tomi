import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:path_provider/path_provider.dart';

extension PlatformFileExtension on PlatformFile {
  /// Converts this PlatformFile to a File.
  ///
  /// If [path] is non-null, returns a File pointing to that path.
  /// Otherwise, saves [bytes] to a temporary file and returns it.
  /// Returns null if neither path nor bytes are available.
  Future<File?> toFile() async {
    if (path != null) {
      return File(path!);
    } else if (bytes != null) {
      final tempDir = await getTemporaryDirectory();
      final tempFile = File('${tempDir.path}/$name');
      await tempFile.writeAsBytes(bytes!);
      return tempFile;
    }
    return null;
  }
}
