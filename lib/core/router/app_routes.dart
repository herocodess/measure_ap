enum AppRoutes {
  splash('splash', '/splash'),
  dashboard('dashboard', '/dashboard'),
  home('home', '/home'),
  patients('patients', '/patients'),
  history('history', '/history'),
  settings('settings', '/settings'),
  newAssessment('newAssessment', '/new-assessment'),
  assessmentSteps('assessmentSteps', '/assessment-steps'),
  historyDetails('historyDetails', '/history-details'),
  ;

  const AppRoutes(this.name, this.path);
  final String name, path;
}
