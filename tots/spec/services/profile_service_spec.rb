# require './app/services/profile_service.rb'
#
#
# RSpec.describe "profile_service will assign data to a User " do
#   context   "MWSa, 3-4 10-11p" do
#   it "will check the availability mask" do
#     param = {"utf8"=>"✓",
#      "authenticity_token"=>"bfDM3nb+7Q7tY2puEm6BdQrNVj7RRLPLhq6wKFvTuMwUZ2DmYeTOwerTRLKzQcsTzLIP3kaVtm5mqI+K+L+PWg==",
#      "status"=>"1",
#      "location"=>"",
#      "picture"=>"",
#      "monday"=>{"available"=>"1"},
#      "tuesday"=>{"available"=>"0"},
#      "wednesday"=>{"available"=>"1"},
#      "thursday"=>{"available"=>"0"},
#      "friday"=>{"available"=>"0"},
#      "saturday"=>{"available"=>"1"},
#      "sunday"=>{"available"=>"0"},
#      "available"=>{"time_available"=>"03:00 - 04:00\r\n22:00 - 23:00"},
#      "commit"=>"Create",
#      "controller"=>"profiles",
#      "action"=>"create"}
#      user_id = 1
#     profile = ProfileService.new(param,user_id)
#     actual = profile.parse
#     day_string = "1010010"
#     half_hour_mask = "000000110000000000000000000000000000000000001100"
#     expected_mask = MaskService.new(day_string,half_hour_mask).to_mask
#     actual = User.find(user_id).availability
#     expected = expected_mask
#     expect(actual).to eq(expected)
#     end
#   end
# end
