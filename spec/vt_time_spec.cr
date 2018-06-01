require "./spec_helper"

# Collection of tests for interoperability between VirtualTimes and Times.

describe "Crystime::VirtualTime and Times" do

  it "can match Crystal's Times" do
    vt= Crystime::VirtualTime.new

    Crystime::Helpers.matches?( vt, [Time.now]).should be_true
    vt.matches?( [Time.now]).should be_true
    Crystime::VirtualTime.now.matches?(vt).should be_true

    vt.month= 3
    vt.day = (10..20).step(2)

    Crystime::Helpers.matches?( vt, [Time.parse("2018-03-10", "%F")]).should be_true
    Crystime::Helpers.matches?( vt, [Time.parse("2018-03-11", "%F")]).should be_nil
    # Same thing as above but in alternate notation:
    vt.matches?( [Time.parse("2018-03-10", "%F")]).should be_true
    vt.matches?( [Time.parse("2018-03-11", "%F")]).should be_nil
    # Same thing as above but in alternate notation:
    Crystime::VirtualTime["2018-03-10"].matches?(vt).should be_true
    Crystime::VirtualTime["2018-03-11"].matches?(vt).should be_nil
  end

  it "can do math with Times" do
    vt= Crystime::VirtualTime.new
    vt.day= 4
    t= Time.parse("2018-04-04", "%F")

    r= (vt+t)
    r.days.should eq 736_790
    r.hours.should eq 0
    r.seconds.should eq 0

    r= (t- vt)
    r.days.should eq 736_784
    r.hours.should eq 0
    r.seconds.should eq 0
  end

  # XXX Add tests for working with Time::Spans
end