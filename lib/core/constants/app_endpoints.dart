class AppEndpoints {
  static const String baseUrl = 'https://admin.aunwalun.com/api';

  // Auth
  static const String login = '/auth/login';
  static const String logout = '/auth/logout';
  static const String me = '/auth/me';
  static const String registerCustomer = '/auth/register/customer';
  static const String registerCompany = '/auth/register/company';

  // Labors
  static const String labors = '/labors';
  static const String laborByType = '/labors/by-type';
  static String laborDetail(int id) => '/labors/$id';

  // Search & Filters
  static const String search = '/search';
  static const String filters = '/filters';
  static const String professions = '/professions';
  static const String stats = '/stats';

  // Orders
  static const String orders = '/orders';
  static const String trackOrder = '/orders/track';

  // Company
  static const String companyLabors = '/company/labors';
  static const String companyOrders = '/company/orders';

  // Profile
  static const String profile = '/profile';
}
