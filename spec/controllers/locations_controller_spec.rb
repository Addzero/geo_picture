require 'spec_helper'

describe LocationsController do
	describe "#create" do
		subject {
			post :create, {
				:location => {
					:latitude => 25.0, 
					:longitude => -40.0
				}
			}
		}
		its(:status) {should == 302} # redirect
		it "save the location" do
			subject
			Location.all.count.should == 1
		end
		it "should redirect to show the created location" do
			subject.should redirect_to(location_path(Location.first.id))
		end
	end

	describe "#new" do
		context "when invalid longitude" do
			subject {post :create, 
				{:location => 
					{:latitude => 25.0}
				}
			}
			its(:status) {should == 200} # OK
			it "should render the new view" do
				subject
				response.should render_template("new")
			end
		end
	end

	describe "#show" do
		context "when the location exists" do
			let(:location) {
				Location.create(
					:latitude => 25.0, :longitude => -40.0
				)
			}
			subject {get :show, :id => location.id}
			it "assigns @location" do
				subject
				assigns(:location).should eq(location)
			end
			it "renders the show template" do
				subject
				response.should render_template("show")
			end
		end

		context "when the location does not exist" do
			subject { get :show, :id => 404}
			its(:status) {should == 404}
		end
	end

	describe "#index" do
		context "when there are some location" do
			let(:locations) do
				[
					Location.create(:latitude => 25.0, :longitude => -40.0),
					Location.create(:latitude => -10, :longitude => 42.0)
				]
			end
			#TODO check with let!
			before {locations}
			subject { get :index }
			it "assigns @locations" do
				subject # let!
				assigns(:locations).should eq(locations)
			end
			it "renders the index template" do
				subject
				response.should render_template("index")
			end
		end

		context "when there are no locations" do
			subject { get :index}
			it "assigns @locations" do
				subject
				assigns(:locations).should eq([])
			end
		end
	end

	describe "#destroy" do
		context "when the locaton exists" do
			let(:location) {
				Location.create(
					:latitude => 25.0, :longitude => -40.0
				)
			}
			subject { post :destroy, :id => location.id }
			it "deletes the location" do
				subject
				Location.all.count.should == 0
			end
		end
	end
end
