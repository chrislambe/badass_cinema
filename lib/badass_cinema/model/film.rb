# - FilmId: A000004478
#   Film: ! 'Big Screen Classics: THE BIG GUNDOWN'
#   FilmType: Series
#   SeriesId: '18'
#   IsRRS: '0'
#   Sessions:

module BadassCinema::Model
  class Film
    include BadassCinema::InitializeWithHash

    attr_reader :id,
                :title,
                :type,
                :series_id,
                :is_rss,
                :sessions

    def add_session session
      @sessions = Array.new if @sessions.nil?
      return if @sessions.include? session
      @sessions << session
      session.film = self
    end

  end
end