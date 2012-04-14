class Cell
  attr_accessor :status

  ALIVE_STATUS = 'alive'
  DEAD_STATUS =  'dead'

  def initialize(status)
    @status = status
    @adjoins = []
    self
  end

  def next_status
    if self.alive?
      if self.alive_adjoins.count == 0
        return DEAD_STATUS
      elsif self.alive_adjoins.count == 1
        return DEAD_STATUS
      elsif self.alive_adjoins.count == 2
        return ALIVE_STATUS
      elsif self.alive_adjoins.count == 3
        return ALIVE_STATUS
      elsif self.alive_adjoins.count >= 4
        return DEAD_STATUS
      end
    elsif self.dead?
      if self. alive_adjoins.count == 3
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

  def adjoins
    @adjoins
  end

  def alive_adjoins
    self.adjoins.select {|c| c.alive? }
  end

  def adjoin(cell)
    if self.adjoins.count < 8
      @adjoins.push(cell) and return true
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
