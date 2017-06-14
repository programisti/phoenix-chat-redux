var webpack = require("webpack")
var ExtractTextPlugin = require("extract-text-webpack-plugin");

module.exports = {
  entry: {
    app: [
      './assets/js/app.js',
      './assets/css/app.css'
    ]
  },
  output: {
    path: __dirname + "/priv/static",
    filename: 'js/app.js',
  },
  plugins: [
    new ExtractTextPlugin("css/app.css")
  ],
  module: {
    loaders: [
      {
        test: /\.js$/,
        exclude: /node_modules/,
        loader: 'babel-loader',
        query: {
          presets: ['react', 'es2015', 'stage-0'],
          plugins: []
        },
      },
      { test: /\.styl$/, loader: 'style-loader!css-loader!stylus-loader' },
      {
        test: /\.css$/,
        loader: ExtractTextPlugin.extract({ fallback: 'style-loader', use: 'css-loader' })
      }
    ],
  },
}
