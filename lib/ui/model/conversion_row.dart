class ConversionRow {
  ConversionRow({required this.left, required this.right});

  final double left;
  final double right;

  @override
  bool operator ==(Object other) {
    if(other is! ConversionRow) {
      return false;
    }

    return other.left == left && other.right == right;
  }

  @override
  int get hashCode => ('$left-$right').hashCode;
}