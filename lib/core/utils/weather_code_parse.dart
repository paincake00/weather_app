enum WeatherCondition {
  clear,
  rainy,
  cloudy,
  snowy,
  unknown,
}

final clearCodes = {0};
final cloudyCodes = {1, 2, 3, 45, 48};
final rainyCodes = {
  51,
  53,
  55,
  56,
  57,
  61,
  63,
  65,
  66,
  67,
  80,
  81,
  82,
  95,
  96,
  99
};
final snowyCodes = {71, 73, 75, 77, 85, 86};

extension WeatherCondFromCode on int {
  WeatherCondition get toCondition {
    return switch (this) {
      final code when clearCodes.contains(code) => WeatherCondition.clear,
      final code when cloudyCodes.contains(code) => WeatherCondition.cloudy,
      final code when rainyCodes.contains(code) => WeatherCondition.rainy,
      final code when snowyCodes.contains(code) => WeatherCondition.snowy,
      _ => WeatherCondition.unknown,
    };
  }
}
