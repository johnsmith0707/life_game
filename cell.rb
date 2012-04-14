class Cell
  attr_accessor :status

  ALIVE_STATUS = 'alive'
  DEAD_STATUS =  'dead'

  def initialize(status)
    @status = status
    @neighbourhood = []
    self
  end

  def next_status
    if self.alive?
      if self.alive_neighbourhood.count == 0
        return DEAD_STATUS
      elsif self.alive_neighbourhood.count == 1
        return DEAD_STATUS
      elsif self.alive_neighbourhood.count == 2
        return ALIVE_STATUS
      elsif self.alive_neighbourhood.count == 3
        return ALIVE_STATUS
      elsif self.alive_neighbourhood.count >= 4
        return DEAD_STATUS
      end
    elsif self.dead?
      if self. alive_neighbourhood.count == 3
        return ALIVE_STATUS
      else
        return self.status
      end
    end
    ''
  end

  def next
    self.status = self.next_status
  end

  def neighbourhood
    @neighbourhood
  end

  def alive_neighbourhood
    self.neighbourhood.select {|c| c.alive? }
  end

  def add_neighbourhood(cell)
    if self.neighbourhood.count < 8
      @neighbourhood.push(cell) and return true
    else
      false
    end
  end

  def alive?
    status === 'alive'
  end

  def dead?
    status === 'dead'
  end
end
