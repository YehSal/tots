# {"utf8"=>"✓",
#  "authenticity_token"=>"bfDM3nb+7Q7tY2puEm6BdQrNVj7RRLPLhq6wKFvTuMwUZ2DmYeTOwerTRLKzQcsTzLIP3kaVtm5mqI+K+L+PWg==",
#  "status"=>"1",
#  "location"=>"",
#  "picture"=>"",
#  "monday"=>{"available"=>"0"},
#  "Tuesday"=>{"available"=>"0"},
#  "wednesday"=>{"available"=>"0"},
#  "thursday"=>{"available"=>"0"},
#  "friday"=>{"available"=>"0"},
#  "saturday"=>{"available"=>"0"},
#  "sunday"=>{"available"=>"0"},
#  "available"=>{"time_available"=>""},
#  "commit"=>"Create",
#  "controller"=>"profiles",
#  "action"=>"create"}

class ProfileService
  attr_accessor :raw_param, :user_id
  def initialize(raw_param,user_id)
    @raw_param = raw_param
    @user_id = user_id
  end

  def parse

    picture = @raw_param['picture']
    location = @raw_param['location']
    status = @raw_param['status']
    monday =  @raw_param['monday'] || '0'
    tuesday =  @raw_param['tuesday'] || '0'
    wednesday =  @raw_param['wednesday'] || '0'
    thursday =  @raw_param['thursday'] || '0'
    friday =  @raw_param['friday'] || '0'
    saturday =  @raw_param['saturday'] || '0'
    sunday =  @raw_param['sunday'] || '0'


    day_availability =  monday+tuesday+wednesday+thursday+friday+saturday+sunday
    available_out = find_availability_string
    profile_mask = MaskService.new(day_availability,available_out)
    user = User.find(@user_id)
    user.picture = picture
    user.location = location
    user.availability = profile_mask.to_mask
    user.status = status

    user.save!

  end

  def find_availability_string
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
    times = @raw_param['available'].split("\r\n")
    availability_string = ""
    former_stop = 48
    times.each do |x|
      span = x.split(" - ")
      start,stop = half_hour_hash.key(span[0]).to_i,half_hour_hash.key(span[1]).to_i
      former_stop.downto(start+1) do |x|
        availability_string += "0"
      end
      (start).downto(stop) do |x|
        availability_string += "1"
      end
      former_stop = stop -1
    end
    available_out = (availability_string.to_i(2) << (former_stop)).to_s(2)
    available_out
end
end
