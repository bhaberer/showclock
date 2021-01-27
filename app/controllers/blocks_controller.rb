class BlocksController < ApplicationController
  before_action :set_event
  before_action :set_day
  before_action :set_block, only: [:show, :edit, :update, :destroy,
                                   :move_earlier, :move_later]

  def index
    @blocks = Block.where(day: @day).order(:order)
  end

  def show; end

  def new
    @block = Block.new
  end

  def edit; end

  def move_earlier
    respond_to do |format|
      if @block.move_earlier!
        format.html { redirect_to event_day_blocks_path(@event, @day), notice: 'Block was successfully moved.' }
        format.json { render :index, status: :updated, location: @block }
      else
        format.html { redirect_to event_day_blocks_path(@event, @day), notice: 'Block could not be moved.'  }
        format.json { render json: @block.errors, status: :unprocessable_entity }
      end
    end
  end

  def move_later
    respond_to do |format|
      if @block.move_later!
        format.html { redirect_to event_day_blocks_path(@event, @day), notice: 'Block was successfully moved.' }
        format.json { render :index, status: :updated, location: @block }
      else
        format.html { redirect_to event_day_blocks_path(@event, @day), notice: 'Block could not be moved.'  }
        format.json { render json: @block.errors, status: :unprocessable_entity }
      end
    end
  end

  def create
    @block = Block.new(block_params)
    @block.order = @day.blocks.length + 1

    respond_to do |format|
      if @block.save
        format.html {
          redirect_to event_day_blocks_path(@event, @day),
                      notice: "Block for #{@block.name} was successfully created" }
        format.json { render :show, status: :created, location: @block }
      else
        format.html { render :new }
        format.json { render json: @block.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @block.update(block_params)
        format.html { redirect_to event_day_blocks_path(@event, @day), notice: 'Block was successfully updated.' }
        format.json { render :show, status: :ok, location: @block }
      else
        format.html { render :edit }
        format.json { render json: @block.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @block.destroy
    respond_to do |format|
      format.html { redirect_to event_day_blocks_path(@event, @day), notice: 'Block was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def set_block
    @block = Block.find(params[:id] || params[:block_id])
  end

  def set_day
    @day = Day.find(params[:day_id])
  end

  def set_event
    @event = Event.find(params[:event_id])
  end

  def block_params
    params.require(:block).permit(:name, :block_type, :order, :duration, :day_id, :start_time)
  end
end
