class BlocksController < ApplicationController
  before_action :set_event
  before_action :set_day
  before_action :set_block, only: [:show, :edit, :update, :destroy]

  def index
    @blocks = Block.where(day: @day)
  end

  def show; end

  def new
    @block = Block.new
  end

  def edit; end

  def create
    @block = Block.new(block_params)
    @block.order = @day.blocks.length

    respond_to do |format|
      if @block.save
        format.html {
          redirect_to event_day_path(@event, @day),
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
        format.html { redirect_to event_day_block_path(@event, @day, @block), notice: 'Block was successfully updated.' }
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
    @block = Block.find(params[:id])
  end

  def set_day
    @day = Day.find(params[:day_id])
  end

  def set_event
    @event = Event.find(params[:event_id])
  end

  def block_params
    params.require(:block).permit(:name, :block_type, :order, :duration, :day_id)
  end
end
