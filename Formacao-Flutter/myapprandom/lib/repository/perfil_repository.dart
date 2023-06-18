import 'package:hive/hive.dart';
import 'package:myapprandom/model/perfil_model.dart';

class PerfilRepository {
  static late Box _box;

  PerfilRepository._criar();

  static Future<PerfilRepository> carregar() async {
    if (Hive.isBoxOpen('perfilModel')) {
      _box = Hive.box('perfilModel');
    } else {
      _box = await Hive.openBox('perfilModel');
    }

    return PerfilRepository._criar();
  }

  void salvar(PerfilModel perfilModel) {
    _box.put('perfilModel', perfilModel);
  }

  PerfilModel obterDados() {
    var perfilModel = _box.get('perfilModel');
    if (perfilModel == null) {
      return PerfilModel.vazio();
    }
    return perfilModel;
  }
}
