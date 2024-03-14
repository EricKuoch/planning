
class Planning
  require 'date'
  attr_reader :full_week_slots
  attr_reader :available_slots

  def initialize(busy_slots)
    @full_week_slots = {}
    @busy_slots = busy_slots
    create_full_week_slots
  end
  

  def find_available_slots(wanted_hour)
    @available_slots = {}
    @full_week_slots.each do |date, availability|
      @available_slots[date] = []
      availability.delete_if { |_, value| value == "occupied" }
      open_slots = availability.keys.chunk_while { |i, j| i.last + 1 == j.last }.to_a
      open_slots.each do |open_slot|
        if open_slot.count >= wanted_hour
          @available_slots[date] << open_slot.map { |hour| [hour,'available'] }.to_h 
        end
      end
    end
    @available_slots
  end

  def fetch_occupied_slots
    @busy_slots.each do |busy_slot|
      date = DateTime.parse(busy_slot[:start]).strftime('%d-%m-%Y')
      start_hour = DateTime.parse(busy_slot[:start]).hour
      end_hour = DateTime.parse(busy_slot[:end]).hour
      occupied_slots = start_hour..end_hour - 1
      occupied_slots.each do |slot|
        @full_week_slots[date][(slot..slot + 1)] = 'occupied'
      end
    end
    @full_week_slots
  end

  private 

  def create_full_week_slots
    beginning_of_week = get_monday(DateTime.parse(@busy_slots.first[:start]))
    end_of_week = get_friday(DateTime.parse(@busy_slots.first[:start]))
    full_week = beginning_of_week..end_of_week
    full_week.each do |day|
      date = day.strftime('%d-%m-%Y')
      full_day_work = 9..17
      @full_week_slots[date] = full_day_work.map do |hour|
        [(hour..hour + 1), 'available']
      end.to_h
    end
    fetch_occupied_slots
  end
  

  def get_monday(date)
    date - date.wday
  end

  def get_friday(date)
    day_to_add = (5 - date.wday) % 7
    date + day_to_add
  end
end
