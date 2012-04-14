# -*- coding: utf-8 -*-
require 'rspec'
require './cell'

describe "Cell" do
  describe '#initialize' do
    before do
      @cell = Cell.new('alive')
    end
    it '現在のcellを返す' do
      @cell.should be_a_kind_of(Cell)
    end

    it '現在の状態(status)をセットする' do
      @cell.status.nil?.should == false
    end

    it '隣接するcellを初期化する' do
      @cell.neighbourhood.should be_a_kind_of(Array)
      @cell.neighbourhood.should be_empty
    end
  end

  describe '#status' do
    context 'cellの状態が生' do
      before do
        @alive_cell = Cell.new('alive')
      end
      it 'aliveを返す' do
        @alive_cell.status.should == 'alive'
      end
    end

    context 'cellの状態が死' do
      before do
        @dead_cell = Cell.new('dead')
      end
      it 'deadを返す' do
        @dead_cell.status.should === 'dead'
      end
    end
  end

  describe '#next_status'  do
    context 'self.status==dead' do
      before do
        @dead_cell = Cell.new('dead')
      end

      it '隣接しているセルのうち生きた状態のセルがないならばstatusは変化しない' do
        before_status = @dead_cell.status
        @dead_cell.next_status.should == before_status
      end

      it '隣接しているセルのうち1つが生きた状態ならばstatusは変化しない' do
        before_status = @dead_cell.status
        alive_cell = Cell.new('alive')
        @dead_cell.add_neighbourhood(alive_cell)
        @dead_cell.next_status.should == before_status
      end

      it '隣接しているセルのうち2つが生きた状態ならばstatusは変化しない' do
        before_status = @dead_cell.status
        2.times do
          alive_cell = Cell.new('alive')
          @dead_cell.add_neighbourhood(alive_cell)
        end
        @dead_cell.next_status.should == before_status
      end

      it '隣接しているセルのうち３つが生きた状態ならばaliveを返す' do
        3.times do
          alive_cell = Cell.new('alive')
          @dead_cell.add_neighbourhood(alive_cell)
        end
        @dead_cell.next_status.should == 'alive'
      end

      it '隣接しているセルのうち4つが生きた状態ならばstatusは変化しない' do
        before_status = @dead_cell.status
        4.times do
          alive_cell = Cell.new('alive')
          @dead_cell.add_neighbourhood(alive_cell)
        end
        @dead_cell.next_status.should == before_status
      end

      it '隣接しているセルのうち5つが生きた状態ならばstatusは変化しない' do
        before_status = @dead_cell.status
        5.times do
          alive_cell = Cell.new('alive')
          @dead_cell.add_neighbourhood(alive_cell)
        end
        @dead_cell.next_status.should == before_status
      end
    end

    context 'self.status==alive' do
      before do
        @alive_cell = Cell.new('alive')
      end

      it '隣接しているセルのうち生きた状態のセルがないならばdeadを返す' do
        @alive_cell.next_status.should == 'dead'
      end

      it '隣接しているセルのうち１つが生きた状態ならばdeadを返す' do
        alive_cell = Cell.new('alive')
        @alive_cell.add_neighbourhood(alive_cell)
        @alive_cell.next_status.should == 'dead'
      end

      it '隣接しているセルのうち２つが生きた状態ならばaliveを返す' do
        2.times do
          alive_cell = Cell.new('alive')
          @alive_cell.add_neighbourhood(alive_cell)
        end
        @alive_cell.next_status.should == 'alive'
      end

      it '隣接しているセルのうち3つが生きた状態ならばaliveを返す' do
        3.times do
          alive_cell = Cell.new('alive')
          @alive_cell.add_neighbourhood(alive_cell)
        end
        @alive_cell.next_status.should == 'alive'
      end

      it '隣接しているセルのうち4つが生きた状態ならdeadを返す' do
        4.times do
          alive_cell = Cell.new('alive')
          @alive_cell.add_neighbourhood(alive_cell)
        end
        @alive_cell.next_status.should == 'dead'
      end

      it '隣接しているセルのうち5つが生きた状態ならdeadを返す' do
        5.times do
          alive_cell = Cell.new('alive')
          @alive_cell.add_neighbourhood(alive_cell)
        end
        @alive_cell.next_status.should == 'dead'
      end
    end
  end

  describe '#neighbourhood' do
    before do
      @alive_cell = Cell.new('alive')
    end
    it '初期状態は空の配列を返す' do
      @alive_cell.neighbourhood.should be_a_kind_of(Array)
      @alive_cell.neighbourhood.should be_empty
    end

    it '隣接セルが追加された(neighbourhood)場合は追加されたセルを配列で返す' do
      @alive_cell = Cell.new('alive')
      neighbourhood_cell = Cell.new('alive')
      @alive_cell.add_neighbourhood(neighbourhood_cell)
      @alive_cell.neighbourhood.should be_a_kind_of(Array)
      @alive_cell.neighbourhood.count.should == 1
      @alive_cell.neighbourhood[0].should == neighbourhood_cell
    end
  end

  describe '#alive_neighbourhood' do
    before do
      @alive_cell = Cell.new('alive')
      @alive_cell.add_neighbourhood(Cell.new('alive'))
      @alive_cell.add_neighbourhood(Cell.new('dead'))
    end

    it '長さ１のCellクラス配列を返す' do
      @alive_cell.neighbourhood.should be_a_kind_of(Array)
      @alive_cell.alive_neighbourhood.count.should == 1
      @alive_cell.alive_neighbourhood[0].should be_a_kind_of(Cell)
    end
  end

  describe '#add_neighbourhood(cell)' do
    before do
      @alive_cell = Cell.new('alive')
    end
    it '隣接したセル(neighbourhood)を追加する' do
      @alive_cell.add_neighbourhood(Cell.new('dead'))
      @alive_cell.neighbourhood.count.should == 1
      @alive_cell.add_neighbourhood(Cell.new('alive'))
      @alive_cell.neighbourhood.count.should == 2
    end

    it '隣接したセル(neighbourhood)が既に7個ある場合はセルを追加しtrueを返す' do
      7.times do
        @alive_cell.add_neighbourhood(Cell.new('alive'))
      end
      @alive_cell.neighbourhood.count.should == 7
      @alive_cell.add_neighbourhood(Cell.new('alive')).should == true
      @alive_cell.neighbourhood.count.should == 8
    end

    it '隣接したセル(neighbourhood)が既に8個ある場合はセルを追加せずfalseを返す' do
      8.times do
        @alive_cell.add_neighbourhood(Cell.new('alive'))
      end
      @alive_cell.neighbourhood.count.should == 8
      @alive_cell.add_neighbourhood(Cell.new('alive')).should == false
      @alive_cell.neighbourhood.count.should == 8
    end
  end

  describe '#alive?' do
    it 'statusがaliveならtrueを返す' do
      Cell.new('alive').alive?.should == true
    end
    it 'statusがdeadならfalseを返す' do
      Cell.new('dead').alive?.should == false
    end
  end

  describe '#dead?' do
    it 'statusがaliveならfalseを返す' do
      Cell.new('alive').dead?.should == false
    end
    it 'statusがdeadならtrueを返す' do
      Cell.new('dead').dead?.should == true
    end
  end

  describe '#next' do
    before do
      @alive_cell = Cell.new('alive')
      4.times do
        @alive_cell.add_neighbourhood(Cell.new('alive'))
      end
    end
    it 'next_statusをstatusにセットする' do
      @alive_cell.status.should == 'alive'
      @alive_cell.next
      @alive_cell.status.should_not == 'alive'
    end
  end

  describe'#status=' do
    it 'statusを更新する' do
      alive_cell = Cell.new('alive')
      alive_cell.status.should == 'alive'
      alive_cell.status = 'dead'
      alive_cell.status.should == 'dead'
    end
  end
end
