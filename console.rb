require("pry")
require_relative("./models/property_tracker")

PropertyTracker.delete_all()

property1 = PropertyTracker.new({
  "build" => "flat",
  "address" => "50 Dumbarton rd",
  "value" => 120000,
  "bedroom_quantity" => 2
  });

  property1.save()

  property2 = PropertyTracker.new({
    "build" => "semi-detached",
    "address" => "32 Hyndland rd",
    "value" => 250000,
    "bedroom_quantity" => 4
    });

    property2.save()

    properties = PropertyTracker.all()

    found_property = PropertyTracker.find_by_id(property1.id)

    found_property_address = PropertyTracker.find_by_address("32 Hyndland rd")

    binding.pry
    nil
