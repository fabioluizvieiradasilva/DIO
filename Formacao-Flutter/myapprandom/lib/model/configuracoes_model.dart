class ConfiguracoesModel {
  String _nomeUsuario = '';
  double _altura = 0;
  bool _receberNotificacao = false;
  bool _temaEscuro = false;

  ConfiguracoesModel(
    this._nomeUsuario,
    this._altura,
    this._receberNotificacao,
    this._temaEscuro,
  );

  ConfiguracoesModel.vazio() {
    _nomeUsuario = '';
    _altura = 0;
    _receberNotificacao = false;
    _temaEscuro = false;
  }

  String get nomeUsuario => _nomeUsuario;
  double get altura => _altura;
  bool get receberNotificacao => _receberNotificacao;
  bool get temaEscuro => _temaEscuro;

  set nomeUsuario(String nomeUsuario) {
    _nomeUsuario = nomeUsuario;
  }

  set altura(double altura) {
    _altura = altura;
  }

  set receberNotificacao(bool receberNotificacao) {
    _receberNotificacao = receberNotificacao;
  }

  set temaEscuro(bool temaEscuro) {
    _temaEscuro = temaEscuro;
  }
}
