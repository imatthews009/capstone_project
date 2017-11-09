$.ajax({
    url: 'https://newsapi.org/v1/articles?source=espn&sortBy=top&apiKey=5c1e467b17854b81a86c4ccc34d3eb6e',
    dataType: 'json',
    succes: function(results) {
        console.log(results);
    }
});