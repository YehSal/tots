require './app/services/mask_service.rb'

RSpec.describe "profile_service will assign data to a User " do
  context   "always available on mondy" do
  it "will turn a binary string into a bit-mask" do
    mask = MaskService.new('0000001','111111111111111111111111111111111111111111111111')
    actual = mask.to_mask
    expected = 562949953421311
    expect(actual).to eq(expected)
    end
  end
