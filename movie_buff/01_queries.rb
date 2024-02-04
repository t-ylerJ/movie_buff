

def it_was_ok
  # Consider the following:
  # Movie.where(yr: 1970..1979)
  # You can use ranges (a..b) inside a where method.
  # Find the id, title, and score of all movies with scores between 2 and 3.
  # Movie.select( :id, :title, :score).where(score: 2..3)
  Movie.select('id, title, score').where('score BETWEEN 2 AND 3')

end

def harrison_ford
  # Consider the following:
  #
  # Actor
  #   .joins(:movies)
  #   .where(movies: { title: 'Blade Runner' })
  #
  # It's possible to join based on Active Record associations defined in models.
  #
  # Find the id and title of all movies in which Harrison Ford appeared but not
  # as a lead actor.




  #open source rb and look for classname/foreign key we want. 
  #that relationship will be what we put in joins
  Movie.joins(:actors, :castings)
  .where(actors: {name: 'Harrison Ford'})
  .where.not(castings: {ord: 1})
  .select('DISTINCT movies.id, title')

  # 
end

def biggest_cast
  # Consider the following:
  #
  # Actor
  #   .joins(:movies)
  #   .group('actors.id')
  #   .order('COUNT(movies.id) DESC')
  #   .limit(1)
  #
  # Sometimes you need to use aggregate SQL functions like COUNT, MAX, and AVG.
  # Often these are combined with `group` (SQL: `GROUP BY`).
  #
  # Find the id and title of the 3 movies with the largest casts (i.e., most
  # actors).
  
#always start with .rb file that has end result you want
 Movie.joins(:castings).group('movies.id')
    .order('COUNT(castings.id) DESC')
    .limit(3)
    .select('movies.id, movies.title')
  #movie and not movie Id because association

end
 
def directed_by_one_of(them)
  # Consider the following:
  # Movie.where('yr IN (?)', years)

  # given director names
  # You can use IN to test if an element is present in an array.
  # Active Record gives you an even better way to write this:

    
  # Movie.where(yr: years)
  #where(actors.name: ?, them)
  #
  # Find the id and title of all the movies directed by one of 'them'.
  
  # Note: Directors appear in the 'actors' table.
  Movie.joins(:director).where('actors.name IN (?)', them).select('movies.id, movies.title')
  #director is assc, line 17

end

def movie_names_before_1940
  # Consider the following:
  #
  # Movie.where('score < 2.0').pluck(:title)
  # => ['Police Academy: Mission to Moscow']
  #
  # Pluck works similarly to select, except that it converts a query result
  # directly into a Ruby Array instead of an Active Record object. This can
  # improve performance for larger queries.
  #
  # Use pluck to find the title of all movies made before 1940.

end