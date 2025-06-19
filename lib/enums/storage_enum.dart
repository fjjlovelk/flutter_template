enum StorageEnum {
  tokenKey('用户 token'),
  isLogin('用户是否登陆'),
  userInfo('用户个人信息');

  const StorageEnum(this.desc);

  final String desc;
}
