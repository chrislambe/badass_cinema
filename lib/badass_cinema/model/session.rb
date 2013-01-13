# - SessionId: '8134'
#   SessionTime: 4:00p
#   SessionStatus: onsale
#   SessionSalesURL: https://tix.drafthouse.com/visInternetTicketing/visSelectTickets.aspx?cinemacode=0002&txtSessionId=8134

module BadassCinema::Model
  class Session
    include BadassCinema::InitializeWithHash

    attr_reader :id,
                :time,
                :date,
                :status,
                :sales_url

    def film
      @film
    end

    def film= film
      return if @film == film
      @film = film
      @film.add_session self
    end

  end
end