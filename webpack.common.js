const path = require('path');
const webpack = require('webpack');
const CopyWebpackPlugin = require('copy-webpack-plugin');
const ExtractTextPlugin = require("extract-text-webpack-plugin");
const autoprefixer = require('autoprefixer');

module.exports = {
    entry: [path.join(__dirname, './src/index.js')],

    output: {
        path: path.resolve(__dirname, 'build'),
        filename: '[name].[hash:8].js',
    },

    resolve: {
        extensions: ['.js', '.elm'],
    },

    plugins: [
        new CopyWebpackPlugin([
            { from: 'static/style', to: '' },
        ]),
    ],

    module: {
        noParse: /\.elm$/,
        rules: [
            // {
            //     test: /\.css$/,
            //     exclude: /(node_modules)/,
            //     loader: ExtractTextPlugin.extract({
            //         // use style-loader in development
            //         fallback: 'style-loader?sourceMap=false',
            //         use: [
            //             {
            //                 loader: 'css-loader', options: { sourceMap: false, }
            //             },
            //             {
            //
            //             }
            //         ],
            //     }),
            // },
            {
                test: /\.(s?css)$/,
                use: [{
                  loader: 'style-loader', // inject CSS to page
                }, {
                  loader: 'css-loader', // translates CSS into CommonJS modules
                }, {
                  loader: 'postcss-loader', // Run post css actions
                  options: {
                    plugins: function () { // post css plugins, can be exported to postcss.config.js
                      return [
                        require('precss'),
                        require('autoprefixer')
                      ];
                    }
                  }
                }, {
                  loader: 'sass-loader'
                }]
            },
            {
                test: /\.(ttf|eot)(\?v=[0-9]\.[0-9]\.[0-9])?$/,
                loader: 'file-loader',
                options: { name: "[name].[ext]" }
            },
            {
                test: /\.jpe?g$|\.gif$|\.png$/i,
                loader: "file-loader?name=/img/[name].[ext]"
            },
            {
                test: /\.svg$/,
                loader: 'file-loader',
                options: { name: '[name].[ext]' }
            },
            {
                test: /\.css$/,
                loader: 'file-loader',
                options: { name: '[name].[ext]' }
            },
            {
                test: /\.scss$/,
                loader: 'file-loader',
                options: { name: '[name].[ext]' }
            }
        ],
    }
}
