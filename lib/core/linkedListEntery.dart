class MyLinkedList<T> {
  final List<T> _list;

  MyLinkedList(this._list);

  T next(T item) => this._list.indexOf(item) < this._list.length - 1
      ? this._list[this._list.indexOf(item) + 1]
      : this._list[0];

  List<T> get list => _list;
}

class Link {}
