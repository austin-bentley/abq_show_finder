


function spotifyRedirect() {
  let searchButton = document.querySelector(".hero-image__search")
  searchButton.addEventListener('click', () => {
    document.location.replace('https://accounts.spotify.com/authorize?response_type=code&client_id=ff570fbf9c52459a8eae080c5cab560c&redirect_uri=http%3A%2F%2Flocalhost%3A4000%2Fshows&scope=user-top-read');
    // document.location.replace('https://accounts.spotify.com/authorize?response_type=code&client_id=ff570fbf9c52459a8eae080c5cab560c&redirect_uri=https%3A%2F%2Fabqshowfinder.com%2Fshows&scope=user-top-read');
  })
}


export default spotifyRedirect