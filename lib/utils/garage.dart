import 'package:localstorage/localstorage.dart';

class Garage{

  LocalStorage _store = LocalStorage('news_me_storage');

  Future<bool> init() async{
    return _store.ready;
  }

  dynamic getItem(String key){
    dynamic item = _store.getItem(key);
    print(item);
    return item;
  }

  setItem(String key, dynamic value){
    _store.setItem(key, value);
  }

  clearStorage() async{
    await _store.clear();
  }
}