class Hint {
  String _text;
  bool _used = false;

  Hint(String text) {
    _text = text;
  }

  void setUsed() {
    _used = true;
  }

  bool isUsed() {
    return _used;
  }

  String getText() {
    return _text;
  }
}