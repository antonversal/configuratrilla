require "configuratrilla"

describe Configuratrilla::Config do
  let(:configuratrilla) { Configuratrilla::Config.new }
  context "when save config variables" do
    context "when first nesting" do
      before(:each) do
        configuratrilla.variable1 = 100
        configuratrilla.variable2 = 300
      end

      it "should store multiple values" do
        expect(configuratrilla.variable1).to eq(100)
        expect(configuratrilla.variable2).to eq(300)
      end

      it "should reassign variables" do
        configuratrilla.variable1 = "test1"
        configuratrilla.variable2 "test2"
        expect(configuratrilla.variable1).to eq("test1")
        expect(configuratrilla.variable2).to eq("test2")
      end

      describe "#to_hash" do
        it { expect(configuratrilla.to_hash).to eq({"variable1" => 100, "variable2" => 300}) }
      end
    end

    context "when assign like method" do
      it "should assign" do
        configuratrilla.variable1 100
        configuratrilla.variable2 300
        expect(configuratrilla.variable1).to eq(100)
        expect(configuratrilla.variable2).to eq(300)
      end

      it "should reassign variables" do
        configuratrilla.variable1 = "test1"
        configuratrilla.variable2 "test2"
        expect(configuratrilla.variable1).to eq("test1")
        expect(configuratrilla.variable2).to eq("test2")
      end
    end
  end

  context "when second nesting" do
    before(:each) do
      configuratrilla.database.host = "127.0.0.1"
      configuratrilla.database.login = "rails"
    end

    it "should store multiple values" do
      expect(configuratrilla.database.host).to eq("127.0.0.1")
      expect(configuratrilla.database.login).to eq("rails")
    end

    describe "#to_hash" do
      it { expect(configuratrilla.to_hash).to eq({"database" => {"host" => "127.0.0.1", "login" => "rails"}}) }
    end

  end

  context "when third nesting" do
    before(:each) do
      configuratrilla.database.test.host = "127.0.0.1"
      configuratrilla.database.test.login = "rails"
    end

    it "should store multiple values" do
      expect(configuratrilla.database.test.host).to eq("127.0.0.1")
      expect(configuratrilla.database.test.login).to eq("rails")
    end
  end

  context "when 6th nesting" do
    before(:each) do
      configuratrilla.database.test1.test2.test3.test4.host = "127.0.0.1"
      configuratrilla.database.test1.test2.test3.test5.login = "rails"
    end

    it "should store multiple values" do
      expect(configuratrilla.database.test1.test2.test3.test4.host).to eq("127.0.0.1")
      expect(configuratrilla.database.test1.test2.test3.test5.login).to eq("rails")
    end

    describe "#to_hash" do
      it {
        hash = {
          "database" => {
            "test1" => {
              "test2" => {
                "test3" => {
                  "test4" => {"host" => "127.0.0.1"},
                  "test5" => {"login" => "rails"}
                }
              }
            }
          }
        }
        expect(configuratrilla.to_hash).to eq(hash)
      }
    end

  end

  it "should rise error when more than one argument" do
    expect { configuratrilla.send(":variable1=", 100, 200) }.to raise_error("Too many arguments")
  end

  context "when &block" do
    it "should assign inside block" do
      configuratrilla = Configuratrilla::Config.new do
        variable1 100
        variable2 200
      end
      expect(configuratrilla.variable1).to eq(100)
      expect(configuratrilla.variable2).to eq(200)
    end

    it "should accept second nesting" do
      configuratrilla = Configuratrilla::Config.new do
        database do
          host "127.0.0.1"
          user "rails"
        end
      end
      expect(configuratrilla.database.host).to eq("127.0.0.1")
      expect(configuratrilla.database.user).to eq("rails")
    end

    it "should accept six nesting" do
      configuratrilla = Configuratrilla::Config.new do
        database do
          test1 do
            test2 do
              test3 do
                test4 do
                  host "127.0.0.1"
                  user "rails"
                end
              end
            end
          end
        end
      end
      expect(configuratrilla.database.test1.test2.test3.test4.host).to eq("127.0.0.1")
      expect(configuratrilla.database.test1.test2.test3.test4.user).to eq("rails")
    end

    it "should accept chain of methods and then block" do
      configuratrilla = Configuratrilla::Config.new
      configuratrilla.database.test do
        host "127.0.0.1"
        user "rails"
      end
      expect(configuratrilla.database.test.host).to eq("127.0.0.1")
      expect(configuratrilla.database.test.user).to eq("rails")
    end

    it "should assign few blocks" do
      configuratrilla = Configuratrilla::Config.new do
        database do
          testing do
            host "127.0.0.1"
            user "rails"
          end
          production do
            host "test_host.com"
            user "rails_production"
          end
        end
      end

      expect(configuratrilla.database.testing.host).to eq("127.0.0.1")
      expect(configuratrilla.database.testing.user).to eq("rails")
      expect(configuratrilla.database.production.host).to eq("test_host.com")
      expect(configuratrilla.database.production.user).to eq("rails_production")
    end
  end
end