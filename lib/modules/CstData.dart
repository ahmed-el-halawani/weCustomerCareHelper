class CstData {
  final String cstName;
  final String cstId;
  final String cstAdslNumber;
  final String cstAccount;
  final String cstFirstPhoneNumber;
  final String cstSecondPhoneNumberName;
  final String comment;

  CstData({
    this.cstName = "",
    this.cstId = "",
    this.cstAccount = "",
    this.cstAdslNumber = "",
    this.cstFirstPhoneNumber = "",
    this.cstSecondPhoneNumberName = "",
    this.comment = "",
  });

  CstData copyWith({
    String? cstName,
    String? cstId,
    String? cstAdslNumber,
    String? cstAccount,
    String? cstFirstPhoneNumber,
    String? cstSecondPhoneNumberName,
    String? comment,
  }) {
    return CstData(
      cstName: cstName ?? this.cstName,
      cstId: cstId ?? this.cstId,
      cstAdslNumber: cstAdslNumber ?? this.cstAdslNumber,
      cstAccount: cstAccount ?? this.cstAccount,
      cstFirstPhoneNumber: cstFirstPhoneNumber ?? this.cstFirstPhoneNumber,
      cstSecondPhoneNumberName:
          cstSecondPhoneNumberName ?? this.cstSecondPhoneNumberName,
      comment: comment ?? this.comment,
    );
  }

  @override
  String toString() {
    return 'CstData(cstName: $cstName, cstId: $cstId, cstAdslNumber: $cstAdslNumber, cstAccount: $cstAccount, cstFirstPhoneNumber: $cstFirstPhoneNumber, cstSecondPhoneNumberName: $cstSecondPhoneNumberName, comment: $comment)';
  }
}
