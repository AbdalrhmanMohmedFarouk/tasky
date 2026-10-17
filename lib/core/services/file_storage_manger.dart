import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

class FileStorageManger {
  static final FileStorageManger _instance = FileStorageManger._();

  FileStorageManger._();

  factory FileStorageManger() {
    return _instance;
  }

  late final Directory _appDocumentsDirectory;
  late final File _tasksFile;

  init() async {
    _appDocumentsDirectory = await getApplicationDocumentsDirectory();
    _tasksFile = File('${_appDocumentsDirectory.path}/tasks.json');
    print(_tasksFile);
    print(_appDocumentsDirectory);
  }

  saveTask(List<dynamic> list) async {
    final listJson = jsonEncode(list);
    await _tasksFile.writeAsString(listJson);
  }
   Future <List<dynamic>> loadTasks() async {
    if(!await _tasksFile.exists()) return [];
  final tasksJason  = await _tasksFile.readAsString();
  return jsonDecode(tasksJason) as List<dynamic>;
  }
  clear() async{
    if(!await _tasksFile.exists())return;
   await _tasksFile.delete();
  }

}
