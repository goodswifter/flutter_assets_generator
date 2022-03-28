import 'package:path/path.dart' as path_library;

class Template {
  Template(this.className);

  final String className;

  String license = '''
/// Generate by [flutter_assets_generator](https://github.com/goodswifter/flutter_assets_generator) library.
/// 
/// PLEASE DO NOT EDIT MANUALLY.\n
''';

  String get classDeclare => '''
class $className {\n
  const $className._();\n''';

  String get classDeclareFooter => '}\n';

  String formatFiled(String path, String projectPath, bool isPreview) {
    if (isPreview) {
      return '''

  /// ![preview](file://$projectPath${path_library.separator}${_formatPreviewName(path)})
  static const String ${_formatFiledName(path)} = '$path';\n''';
    }
    return '''

  static const String ${_formatFiledName(path)} = '$path';\n''';
  }

  String _formatPreviewName(String path) {
    path = path.replaceAll(' ', '%20').replaceAll('/', path_library.separator);
    return path;
  }

  String _formatFiledName(String path) {
    path = path
        .replaceAll('/', '_')
        .replaceAll('.', '_')
        .replaceAll(' ', '_')
        .replaceAll('-', '_')
        .replaceAll('@', '_AT_');
    return path.replaceAllMapped(RegExp(r'_([A-z])'), (Match match) {
      return match.group(0)!.replaceAll('_', '').toUpperCase();
    }).replaceAll('_', '');
  }

  // String toUppercaseFirstLetter(String str) {
  //   return '${str[0].toUpperCase()}${str.substring(1)}';
  // }
}
