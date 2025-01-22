from flask import Flask, jsonify
import requests

app = Flask(__name__)

# Your Marketstack API key
API_KEY = "1dab9e2bfab83037e33555ebab3edd0a"
BASE_URL = "http://api.marketstack.com/v1"

# Default stock symbols
default_symbols = ["AAPL", "MSFT", "GOOGL", "AMZN", "TSLA"]

def fetch_stock_data(symbol):
    """Fetch stock data for a given symbol."""
    params = {
        "access_key": API_KEY,
        "symbols": symbol
    }
    response = requests.get(f"{BASE_URL}/eod", params=params)
    if response.status_code == 200:
        data = response.json()
        if data["data"]:
            stock = data["data"][0]
            return {
                "symbol": stock["symbol"],
                "company_name": stock.get("name", "N/A"),
                "current_price": stock["close"],
                "change_amount": round(stock["close"] - stock["open"], 2),
                "change_percentage": round((stock["close"] - stock["open"]) / stock["open"] * 100, 2)
            }
    return None

@app.route('/stock/<symbol>', methods=['GET'])
def get_stock_by_symbol(symbol):
    """API method to get stock details by symbol."""
    stock_data = fetch_stock_data(symbol)
    if stock_data:
        return jsonify(stock_data)
    return jsonify({"error": "Stock data not found"}), 404

@app.route('/stocks/default', methods=['GET'])
def get_default_stocks():
    """API method to get details of default stocks."""
    stocks = []
    for symbol in default_symbols:
        stock_data = fetch_stock_data(symbol)
        if stock_data:
            stocks.append(stock_data)
    return jsonify(stocks)

if __name__ == '__main__':
    app.run(debug=True)
