// console.log(current_user)
// $.ajax({
//   url: 'https://newsapi.org/v1/articles?source=espn&sortBy=top&apiKey=5c1e467b17854b81a86c4ccc34d3eb6e',
//   dataType: 'json',
//   success: function(results) {
//     for(var i = 0; i < results['articles'].length; i++) {
//       if(results.articles[i].url.includes('mlb')) {
//         $('.sportsData').append("<h1>"+results.articles[i].url+"</h1>")
//       }
//     }
//     for(var i = 0; i < results['articles'].length; i++) {
//       if(results.articles[i].url.includes('mlb')) {
//         $('.sportsData').append("<h1>"+results.articles[i].url+"</h1>")
//       }
//     }
//     // console.log(mlbArticleArray);
//   }
// });