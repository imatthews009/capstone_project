class NewsController < ApplicationController
    def index
        @basketballArray = []
        @tennisArray = []
        @golfArray = []
        @display = []
        @articlesEspn = Unirest.get("https://newsapi.org/v1/articles?source=espn&sortBy=top&apiKey=5c1e467b17854b81a86c4ccc34d3eb6e").body
        @articlesEspn['articles'].each do |article|
            if article['url'].include?('golf')
                @golfArray.push(article['url'])
            end
        end   
        @articlesEspn['articles'].each do |article|
            if article['url'].include?('tennis')
                @golfArray.push(article['url'])
            end
        end

        @articlesBbc = Unirest.get("https://newsapi.org/v1/articles?source=bbc-sport&sortBy=top&apiKey=5c1e467b17854b81a86c4ccc34d3eb6e").body
        @articlesBbc['articles'].each do |article|
            if article['url'].include?('golf')
                @golfArray.push(article['url'])
            end
        end   
        @articlesBbc['articles'].each do |article|
            if article['url'].include?('tennis')
                @golfArray.push(article['url'])
            end
        end

    end
end
