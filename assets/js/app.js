// We need to import the CSS so that webpack will load it.
// The MiniCssExtractPlugin is used to separate it out into
// its own CSS file.
import css from "../css/app.css"

// webpack automatically bundles all modules in your
// entry points. Those entry points can be configured
// in "webpack.config.js".
//
// Import dependencies
//
import "phoenix_html"

// Import local files
//
// Local files can be imported directly using relative paths, for example:
// import socket from "./socket"
import spotifyRedirect from "./eventListeners.js"
spotifyRedirect();
// document.location.replace('https://accounts.spotify.com/authorize?response_type=code&client_id=ff570fbf9c52459a8eae080c5cab560c&redirect_uri=https%3A%2F%2Flocalhost%3A4000%2Fshows&scope=user-top-read');
// document.location.replace('https://accounts.spotify.com/authorize?response_type=code&client_id=ff570fbf9c52459a8eae080c5cab560c&redirect_uri=https%3A%2F%2Fabqshowfinder.com%2Fshows&scope=user-top-read');
