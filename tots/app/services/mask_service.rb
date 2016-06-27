class MaskService
  attr_accessor :day_string, :available, :day_size, :hour_size
  def initialize(day_string, available) #Expects inputs which are binary strings of the format "MTWThFSaSu" and "0:00 0:30 ........23:00 23:30"
    @day_string = day_string
    @available = available
    @day_size = 7
    @hour_size = 48
  end


  def to_mask #returns an integer bit-mask value
    binar_mask = (@day_string.to_i(2) << @hour_size) + @available.to_i(2)
    binar_mask

  end

  def is_available?(mask_current,mask_available) #returns true false. True indicates tat mask_available contains mask_current
    current_day = mask_current >> @hour_size
    available_day = mask_available >> @hour_size

    current_half_hour = '111111111111111111111111111111111111111111111111'.to_i(2) & mask_current
    available_half_hour = '111111111111111111111111111111111111111111111111'.to_i(2) & mask_available
    if current_day & available_day > 0 && current_half_hour & available_half_hour > 0
      return true
    else
      return false
    end
  end

  def to_info(mask) #returns an array with two elements, the first is an array of days which are indicated by the mask, and the second is an array of the half-hours indicated by the mask
    day_hash = { '1'=>'sunday',
                 '2'=>'saturday',
                 '3'=>'friday',
                 '4'=>'thursday',
                 '5'=>'wednesday',
                 '6'=>'tuesday',
                 '7'=>'monday'}
    half_hour_hash = { '1'=>'23:30',
                       '2'=>'23:00',
                       '3'=>'22:30',
                       '4'=>'22:00',
                       '5'=>'21:30',
                       '6'=>'21:00',
                       '7'=>'20:30',
                       '8'=>'20:00',
                       '9'=>'19:30',
                       '10'=>'19:00',
                       '11'=>'18:30',
                       '12'=>'18:00',
                       '13'=>'17:30',
                       '14'=>'17:00',
                       '15'=>'16:30',
                       '16'=>'16:00',
                       '17'=>'15:30',
                       '18'=>'15:00',
                       '19'=>'14:30',
                       '20'=>'14:00',
                       '21'=>'13:30',
                       '22'=>'13:00',
                       '23'=>'12:30',
                       '24'=>'12:00',
                       '25'=>'11:30',
                       '26'=>'11:00',
                       '27'=>'10:30',
                       '28'=>'10:00',
                       '29'=>'09:30',
                       '30'=>'09:00',
                       '31'=>'08:30',
                       '32'=>'08:00',
                       '33'=>'07:30',
                       '34'=>'07:00',
                       '35'=>'06:30',
                       '36'=>'06:00',
                       '37'=>'05:30',
                       '38'=>'05:00',
                       '39'=>'04:30',
                       '40'=>'04:00',
                       '41'=>'03:30',
                       '42'=>'03:00',
                       '43'=>'02:30',
                       '44'=>'02:00',
                       '45'=>'01:30',
                       '46'=>'01:00',
                       '47'=>'00:30',
                       '48'=>'00:00' }
                      #  times = @raw_param['available']['time_available'].split("\r\n")
                      #  availability_string = ""
                      #  former_stop = 48
                      #  times.each do |x|
                      #    span = x.split(" - ")
                      #    start,stop = half_hour_hash.key(span[0]).to_i,half_hour_hash.key(span[1]).to_i
                      #    former_stop.downto(start) do |x|
                      #      availability_string += "0"
                      #    end
                      #    start.downto(stop) do |x|
                      #      availability_string += "1"
                      #    end
                      #    former_stop = stop
                      #  end
                      #  available_out = (availability_string.to_i(2) << former_stop).to_s(2)
    days = mask >> @hour_size
    half_hours = '111111111111111111111111111111111111111111111111'.to_i(2) & mask
    out_array = [[],[]]
    out_array[1] = ""
    1.upto(@day_size) do |x|
      if days % 2 == 1
        out_array[0] << day_hash["#{x}"]
      end
      days = days >> 1
    end
    last_half_hours = 0
    # 1.upto(@hour_size) do |x|
    #   if half_hours % 2 == 1 && last_half_hours % 2 == 0
    #
    #     out_array[1] = out_array[1] + half_hour_hash["#{x}"]
    #   elsif half_hours % 2 == 0 && last_half_hours % 2 == 1
    #     out_array[1] =     out_array[1] + " - #{half_hour_hash["#{last_half_hours}"]}\r\n"
    #   end
    #   last_half_hours = half_hours
    #   half_hours = half_hours >> 1
    # end
    last_half_hour = 1
    trailing_hour = 0
    @hour_size.downto(1) do |t|
      veracity1 = t == @hour_size && half_hours % 2 == 1
      veracity2 = half_hours % 2 == 1 && last_half_hour % 2 == 0
      if veracity1 || veracity2
        value = half_hour_hash[(49-t).to_s]
        out_array[1] = value + "\r\n" + out_array[1]
      elsif half_hours % 2 ==1 && last_half_hour % 2 == 1
        trailing_hour = t
      elsif half_hours % 2 == 0 && last_half_hour % 2 == 1 && t != @hour_size
        value = half_hour_hash[(49 - trailing_hour).to_s]
        out_array[1] = "#{value} - " + out_array[1]
      end
      last_half_hour = half_hours
      half_hours = half_hours >> 1
    end
    out_array

    end

end
