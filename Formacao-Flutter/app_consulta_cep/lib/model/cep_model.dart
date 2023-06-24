class CepModel {
  String _cep = '';
  String _logradouro = '';
  String _complemento = '';
  String _bairro = '';
  String _localidade = '';
  String _uf = '';
  String _ibge = '';
  String _gia = '';
  String _ddd = '';
  String _siafi = '';

  CepModel(
      {String? cep,
      String? logradouro,
      String? complemento,
      String? bairro,
      String? localidade,
      String? uf,
      String? ibge,
      String? gia,
      String? ddd,
      String? siafi}) {
    _cep = cep ?? '';
    _logradouro = logradouro ?? '';
    _complemento = complemento ?? '';
    _bairro = bairro ?? '';
    _localidade = localidade ?? '';
    _uf = uf ?? '';
    _ibge = ibge ?? '';
    _gia = gia ?? '';
    _ddd = ddd ?? '';
    _siafi = siafi ?? '';
  }

  String get cep => _cep;
  set cep(String cep) => _cep = cep;
  String get logradouro => _logradouro;
  set logradouro(String logradouro) => _logradouro = logradouro;
  String get complemento => _complemento;
  set complemento(String complemento) => _complemento = complemento;
  String get bairro => _bairro;
  set bairro(String bairro) => _bairro = bairro;
  String get localidade => _localidade;
  set localidade(String localidade) => _localidade = localidade;
  String get uf => _uf;
  set uf(String uf) => _uf = uf;
  String get ibge => _ibge;
  set ibge(String ibge) => _ibge = ibge;
  String get gia => _gia;
  set gia(String gia) => _gia = gia;
  String get ddd => _ddd;
  set ddd(String ddd) => _ddd = ddd;
  String get siafi => _siafi;
  set siafi(String siafi) => _siafi = siafi;

  CepModel.fromJson(Map<String, dynamic> json) {
    _cep = json['cep'] ?? '';
    _logradouro = json['logradouro'] ?? '';
    _complemento = json['complemento'] ?? '';
    _bairro = json['bairro'] ?? '';
    _localidade = json['localidade'] ?? '';
    _uf = json['uf'] ?? '';
    _ibge = json['ibge'] ?? '';
    _gia = json['gia'] ?? '';
    _ddd = json['ddd'] ?? '';
    _siafi = json['siafi'] ?? '';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cep'] = _cep;
    data['logradouro'] = _logradouro;
    data['complemento'] = _complemento;
    data['bairro'] = _bairro;
    data['localidade'] = _localidade;
    data['uf'] = _uf;
    data['ibge'] = _ibge;
    data['gia'] = _gia;
    data['ddd'] = _ddd;
    data['siafi'] = _siafi;
    return data;
  }
}
