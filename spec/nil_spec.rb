require "nil.rb"
describe Configuratrilla::Nil do
  let(:nil_conf) { Configuratrilla::Nil.new(nil, nil) }
  context "behaves like nil" do

    it "should react on to_ary" do
      expect { nil_conf.to_ary(1) }.to raise_error(NoMethodError, "undefined method `to_ary' for nil:NilClass")
    end

    it "should return nil on nil?" do
      expect(nil_conf).to be_nil
    end

    it "should return blank array" do
      expect(nil_conf.to_a).to eq([])
    end

    it "should return 0.0" do
      expect(nil_conf.to_f).to eq(0.0)
    end

    it "should return 0" do
      expect(nil_conf.to_i).to eq(0)
    end

    it "should return (0+0i)" do
      expect(nil_conf.to_c).to eq(Complex(0))
    end

    it "should return (0/1)" do
      expect(nil_conf.to_r).to eq(Rational(0))
    end

    it "should return (0/1) when rationalize" do
      expect(nil_conf.rationalize).to eq(Rational(0))
    end

    it "should return false" do
      expect(nil_conf & true).to be_false
    end

    it "should return true" do
      expect(nil_conf | "1").to be_true
    end

    it "should return true" do
      expect(nil_conf ^ "1").to be_true
    end

    it "should be comparable(==) like nil" do
      expect((nil_conf == nil)).to be_true
    end

    it "should be comparable(!=) like nil" do
      expect((nil_conf != nil)).to be_false
    end

    it "should be true when !" do
      expect((!nil_conf)).to be_true
    end

    it "should return compare nils ===" do
      expect((nil_conf === nil)).to be_true
    end

    it "should return compare nils <=>" do
      expect((nil_conf <=> nil)).to eq(0)
    end

    it "should return compare nils eql?" do
      expect((nil_conf.eql? nil)).to be_true
    end

    it "should return compare nils equal?" do
      expect((nil_conf.equal? nil)).to be_true
    end
  end

end