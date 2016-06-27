require './app/services/mask_service.rb'

RSpec.describe "mask_service will generate a bit-mask" do
  context   "always available on mondy" do
  it "will turn a binary string into a bit-mask" do
    mask = MaskService.new('0000001','111111111111111111111111111111111111111111111111')
    actual = mask.to_mask
    expected = 562949953421311
    expect(actual).to eq(expected)
    end
  end

  context "when never available, everyday" do
    it "will turn a binary string into a bit-mask" do
      mask = MaskService.new('1111111','000000000000000000000000000000000000000000000000')
      actual = mask.to_mask
      expected = 35747322042253312
      expect(actual).to eq(expected)
    end
  end
end

RSpec.describe "mask_service will determine if you are available at a given time" do
  context "always availble, currently 1 day 1 time" do
    it "will return true if are available, false if not available" do
      current = MaskService.new('0001000', '000000000000000000000001000000000000000000000000')
      avail = MaskService.new('1111111', '111111111111111111111111111111111111111111111111')
      actual = current.is_available?(current.to_mask,avail.to_mask)
      expected = true
      expect(actual).to eq(expected)
    end
  end

    context "available and current will be exactly opposite" do
      it "will return true if are available, false if not available" do
        c = MaskService.new('1010101','010101010101010101010101010101010101010101010101')
        a = MaskService.new('0101010','101010101010101010101010101010101010101010101010')
        actual = c.is_available?(c.to_mask,a.to_mask)
        expected = false
        expect(actual).to eq(expected)
      end
    end

    context "there are many available and current overlaps" do
      it "will return true if are available, false if not available" do
        c = MaskService.new('1110101','010101010101011111010101010101010101010101010101')
        a = MaskService.new('0101010','100000001010101010101010101010101010101010101010')
        actual = c.is_available?(c.to_mask,a.to_mask)
        expected = true
        expect(actual).to eq(expected)
      end
    end
end
