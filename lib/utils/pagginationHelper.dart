import 'package:we_helper_1/modules/CstData.dart';

class PagginationHelper {
  int currentIndex = 0;
  final List<CstData> list;

  PagginationHelper({required this.list}) {
    currentIndex = list.length - 1;
  }

  bool checkisNotEmpty(CstData c) {
    return c.cstName.isNotEmpty ||
        c.cstId.isNotEmpty ||
        c.cstAccount.isNotEmpty ||
        c.comment.isNotEmpty ||
        c.cstFirstPhoneNumber.isNotEmpty ||
        c.cstSecondPhoneNumberName.isNotEmpty;
  }

  CstData addData(CstData currentData) {
    save(currentData);
    if (checkisNotEmpty(list.last)) {
      list.add(CstData());
    }
    currentIndex = list.length - 1;

    return list.last;
  }

  void save(CstData currentData) {
    list[currentIndex] = currentData;
  }

  CstData get delete {
    list.removeAt(currentIndex);
    if (list.isEmpty) {
      list.add(CstData());
    }
    if (currentIndex > 0) {
      currentIndex--;
      return list[currentIndex];
    } else {
      return list[0];
    }
  }

  bool get isNext => list.length - 1 > currentIndex;
  bool get isPrev => currentIndex > 0;
  bool get isFirest => currentIndex == 0;
  bool get isLast => currentIndex == list.length - 1;

  CstData get getLast {
    currentIndex = list.length - 1;
    return list[currentIndex];
  }

  CstData get getNext => isNext ? list[++currentIndex] : list[currentIndex];

  CstData get getPrev => isPrev ? list[--currentIndex] : list[currentIndex];

  CstData get getFirest {
    currentIndex = 0;
    return list[currentIndex];
  }
}
