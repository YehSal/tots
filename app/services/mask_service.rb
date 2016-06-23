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

  def self.is_available?(mask_current,mask_available) #returns true false. True indicates tat mask_available contains mask_current
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
    day_hash = { '1'=>'Sunday',
                 '2'=>'Saturday',
                 '3'=>'Friday',
                 '4'=>'Thursday',
                 '5'=>'Wednesday',
                 '6'=>'Tuesday',
                 '7'=>'Monday'}
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
                       '29'=>'9:30',
                       '30'=>'9:00',
                       '31'=>'8:30',
                       '32'=>'8:00',
                       '33'=>'7:30',
                       '34'=>'7:00',
                       '35'=>'6:30',
                       '36'=>'6:00',
                       '37'=>'5:30',
                       '38'=>'5:00',
                       '39'=>'4:30',
                       '40'=>'4:00',
                       '41'=>'3:30',
                       '42'=>'3:00',
                       '43'=>'2:30',
                       '44'=>'2:00',
                       '45'=>'1:30',
                       '46'=>'1:00',
                       '47'=>'0:30',
                       '48'=>'0:00' }
    days = mask >> @hour_size
    half_hours = '111111111111111111111111111111111111111111111111'.to_i(2) & mask
    out_array = [[],[]]
    1.upto(@day_size) do |x|
      if days % 2 == 1
        out_array[0] << day_hash["#{x}"]
      end
      days = days >> 1
    end
    1.upto(@hour_size) do |x|
      if half_hours % 2 == 1
        out_array[1] << half_hour_hash["#{x}"]
      end
      half_hours = half_hours >> 1
    end
    out_array
  end

end
