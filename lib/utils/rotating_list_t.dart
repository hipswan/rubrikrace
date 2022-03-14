extension Rotate<T> on List<T> {
  int _rotationTimes(int places) {
    if (isEmpty) {
      return 0;
    }
    if (places == 0) {
      throw ArgumentError('places should be more than 0');
    }
    return places % length;
  }

  List<T> rotatedRight(int places) {
    final times = _rotationTimes(places);
    if (times == 0) {
      return this;
    } else {
      final cutOff = length - times;
      return sublist(cutOff)..addAll(sublist(0, cutOff));
    }
  }

  List<T> rotatedLeft(int places) {
    final times = _rotationTimes(places);
    if (times == 0) {
      return this;
    } else {
      return sublist(times)..addAll(sublist(0, times));
    }
  }
}
