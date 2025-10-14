import 'package:intl/intl.dart';

/// Simple currency formatter helpers for the app.
final NumberFormat _idrFormat = NumberFormat.currency(
  locale: 'id_ID',
  symbol: 'Rp',
  decimalDigits: 0,
);

String formatCurrency(num amount) => _idrFormat.format(amount);
