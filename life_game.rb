require './cell'

target_cell = Cell.new(Cell::ALIVE_STATUS)
alive_cell = Cell.new(Cell::ALIVE_STATUS)
dead_cell = Cell.new(Cell::DEAD_STATUS)

p '***********************************************'
p "target cell status is #{target_cell.status}"
8.times do
#  p 'an alive cell aadjoin to target_cell'
  target_cell.adjoin(alive_cell)
  if target_cell.next_status != target_cell.status
    p 'status changed'
    p "target cell has #{target_cell.adjoins.count} adjoins"
    p "target cell has #{target_cell.alive_adjoins.count} avlive adjoins"
    p "target cell next_status is #{target_cell.next_status}"
  end
  target_cell.next
end
p '***********************************************'
