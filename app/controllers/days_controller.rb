class DaysController < ApplicationController
  before_action :set_event
  before_action :set_day, only: [:show, :edit, :update, :destroy]

  def index
    @days = Day.all
  end

  def show; end

  def new
    @day = Day.new
  end

  def edit; end

  def create
    @day = Day.new(day_params)
    @day.order = @event.days.length

    respond_to do |format|
      if @day.save
        format.html { redirect_to event_day_path(@event, @day), notice: 'Day was successfully created.' }
        format.json { render :show, status: :created, location: @day }
      else
        format.html { render :new }
        format.json { render json: @day.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @day.update(day_params)
        format.html { redirect_to event_day_path(@event, @day), notice: 'Day was successfully updated.' }
        format.json { render :show, status: :ok, location: @day }
      else
        format.html { render :edit }
        format.json { render json: @day.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @day.destroy
    respond_to do |format|
      format.html { redirect_to days_url, notice: 'Day was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def set_day
    @day = Day.find(params[:id])
  end

  def set_event
    @event = Event.find(params[:event_id])
  end

  def day_params
    params.require(:day).permit(:name, :order, :event_id)
  end
end
