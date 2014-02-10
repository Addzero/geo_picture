require 'spec_helper'
describe "Routes" do
	describe "LocationsController" do
		it "routes get new" do
			{:get => '/locations/new'}.should route_to(
				:controller => 'locations',
				:action => 'new'
			)
		end
		it "routes post create" do
			{ :post => 'locations'}.should route_to(
				:controller => 'locations',
				:action => 'create'
			)
		end
		it "routes get index" do
			{:get => 'locations'}.should route_to(
				:controller => 'locations',
				:action => 'index'
			)
		end
		it "routes get show" do
			{:get => 'locations/42'}.should route_to(
				:controller => 'locations',
				:action => 'show',
				:id => '42'
			)
		end
		it "routes delete destroy" do
			{:delete => 'locations/42'}.should route_to(
				:controller => 'locations',
				:action => 'destroy',
				:id => '42'
			)
		end
		it "does not route get edit" do
			{:get => 'locations/42/edit'}.should_not be_routable
		end
		it "does not route put update" do
			{:put => 'locations/42'}.should_not be_routable
		end
		it "allows HTTPS for history" do
			{:get => 'https://test.host/locations/42/history'}.should route_to(
				:controller => 'locations',
				:action => 'history',
				:id => '42'
			)
		end
		it "doest not route HTTP for history" do
			{:get => 'http://test.host/locations/42/history'}.should_not be_routable
		end
	end
end