enum Menu {
  home('Home', 'home'),
  patients('Patients', 'patients'),
  history('History', 'history'),
  settings('Settings', 'settings'),
  ;

  const Menu(this.name, this.key);
  final String name, key;
}

enum DayDateOptions {
  day('Day', 'day'),
  date('Date', 'date'),
  ;

  const DayDateOptions(this.name, this.key);
  final String name, key;
}
