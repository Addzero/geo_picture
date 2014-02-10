require "spec_helper"

describe Location do
	describe "#initisalize" do
		subject {Location.new(
			:latitude => 38.911268, 
			:longitude => -77.444243
		)}
		its (:latitude) { should == 38.911268}
		its (:longitude) {should == -77.444243}
	end	
end

describe Location do
	let(:air_space) do
		Location.new do |loc|
			loc.latitude = 38.911268
			loc.longitude = -77.444243
		end
		loc.save
		loc
	end
end

describe Location do
	let(:latitude) {38.911268}
	let(:longitude) {-77.444243}
	let(:air_space) {Location.new(:latitude => 38.911268, :longitude => -77.444243)}
	describe "#initisalize" do
		subject {air_space}
		its (:latitude) {should == latitude}
		its (:longitude) {should == longitude}
	end

	describe "#near?" do
		context "when within the specified radius" do
			subject { air_space }
			it { should be_near(latitude, longitude, 1) }
		end
		context "when outside the specified radius" do
			subject { air_space }
			it { should_not be_near(latitude * 10, longitude * 10, 1) }
		end
	end	
end

describe "Boolean" do
	subject {"non-nil is true"}
	it {should be_true}
	it {should_not be_false}
end

describe "Predicate" do
	subject {{:a  => 1, :b => 2}}
	it {should have_key(:a)} # has_key?(:a)
	it {should_not be_empty} # empty?
	its ([:b]) {should == 2}
end

describe "Collection" do
	subject { ["text one", "text two"]}
	it {should include "text one"}
	its (:first) { should include "ext"}
end

describe "Regular Expression Comparison" do
	subject {"this is a block of text"}
	it {should match('text$')}
	it {should =~ /\bblock\b/}
end

describe "Class" do
	subject {42}
	it { should be_instance_of Fixnum}
	it { should be_kind_of Integer} # Fixnum > Integer
end

describe "Contract Validation" do
	subject { Location.new}
	it {should respond_to :near?}
end

describe "Throws" do
	subject { Proc.new { throw :some_symbol, "x" } } 
	it "should throw some_symbol" do
		expect { subject.call }.to throw_symbol
		expect { subject.call }.to throw_symbol(:some_symbol)
		expect { subject.call }.to throw_symbol(:some_symbol, "x")
	end
end

describe "Errors" do
	subject { Proc.new { raise RuntimeError.new("x") } }
	it "should raise an exception" do
		expect { subject.call }.to raise_error
		expect { subject.call }.to raise_error(RuntimeError)
		expect { subject.call }.to raise_error(RuntimeError, 'x')
		expect { subject.call }.to raise_error('x')
	end
end

describe "validation" do
	before { subject.valid? }
	[:latitude, :longitude].each do |coordinate|
		context "when #{coordinate} is nil" do
			subject { Location.new(coordinate => nil)}
			it "shouldn't allow blank #{coordinate}" do
				expect(subject.errors_on(coordinate)).to include("can't be blank")
			end
		end
		context "when #{coordinate} isn't numeric" do
			subject { Location.new(coordinate => 'forty-two') }
			it "shouldn't allow non-numeric #{coordinate}" do
				expect(subject.errors_on(coordinate)).to include("is not number")
			end		
		end
		context "when #{coordinate} is an acceptable value" do
			subject { Location.new(coordinate => 42.0) }
			it "should have no errores for #{coordinate}" do
				expect(subject).to have(0).errors_on(coordinate)
			end
		end
	end
end

