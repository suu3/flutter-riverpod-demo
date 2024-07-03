class Filter {
  final int index;
  final String label;

  const Filter(this.index, this.label);
}

const Filter filterAll = Filter(0, '전체 할 일');
const Filter filterIncomplete = Filter(1, '미완료된 할 일');
const Filter filterComplete = Filter(2, '완료된 할 일');

const List<Filter> filters = [filterAll, filterIncomplete, filterComplete];
