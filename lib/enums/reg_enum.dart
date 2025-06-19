enum RegEnum {
  password(r'(?=.*[0-9])(?=.*[a-zA-Z])(?=.*[^a-zA-Z0-9]).{8,30}', '密码');

  /// 正则字符串
  final String regPattern;

  /// 描述
  final String desc;

  const RegEnum(this.regPattern, this.desc);

  /// 正则表达式
  RegExp get reg => RegExp(regPattern);
}
