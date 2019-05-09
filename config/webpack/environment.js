const { environment } = require('@rails/webpacker')
const webpack = require('webpack')

// const { BundleAnalyzerPlugin } = require('webpack-bundle-analyzer')

// environment.plugins.append(
//   'BundleAnalyzer',
//   new BundleAnalyzerPlugin()
// )

environment.plugins.prepend('Provide', new webpack.ProvidePlugin({
  $: 'jquery',
  JQuery: 'jquery',
  jquery: 'jquery',
  'window.Tether': "tether",
  Popper: ['popper.js', 'default'], // for Bootstrap 4
}))

module.exports = environment
