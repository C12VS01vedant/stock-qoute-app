abstract class Url {
  // Authentication and User APIs
  static const String BASE_URL = "http://10.0.2.2:3000/api/auth";
  static const String SIGN_UP = "$BASE_URL/signup";
  static const String LOGIN = "$BASE_URL/login";
  static const String GET_DATA = "$BASE_URL/me"; // Requires Bearer token
  static const String LOGOUT = "$BASE_URL/logout"; // Requires Bearer token

  // Stock APIs (Flask Backend)
  static const String STOCK_BASE_URL = "http://10.0.2.2:5000";

  // Endpoint to fetch stock data for a specific symbol
  static String getStockApi(String symbol) {
    return "$STOCK_BASE_URL/get_stock_data?symbol=$symbol";
  }

  // Endpoint to fetch data for default stocks
  static const String GET_DEFAULT_STOCKS = "$STOCK_BASE_URL/get_default_stocks";
}
