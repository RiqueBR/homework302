require('PG')

class PropertyTracker

  attr_accessor :build, :address, :value, :bedroom_quantity
  attr_reader :id

    def initialize(options)
      @id = options["id"].to_i if options["id"]
      @build = options["build"]
      @address = options["address"]
      @value = options["value"].to_i
      @bedroom_quantity = options["bedroom_quantity"].to_i
    end

    def save()
      db = PG.connect({
        dbname: "property_tracker",
        host: "localhost"
        })

        sql = "INSERT INTO property_trackers
        (build, address, value, bedroom_quantity)
        VALUES
        ($1, $2, $3, $4)
        RETURNING *"

        values = [@build, @address, @value, @bedroom_quantity]

        db.prepare("save", sql)
        @id = db.exec_prepared("save", values)[0]["id"].to_i;
        db.close()
    end

    def PropertyTracker.all
      db = PG.connect ({
        dbname: "property_tracker",
        host: "localhost"
        })

        sql = "SELECT * FROM property_trackers"

        db.prepare("all", sql)
        property_trackers = db.exec_prepared("all") # here ***
        db.close()
        return property_trackers.map {|property_hash| PropertyTracker.new(property_hash)};
    end

    def delete
      db = PG.connect({
        dbname: "property_tracker",
        host: "localhost"
        })

        sql = "DELTE FROM property_trackers WHERE id = $1"

        values = [@id]

        db.prepare("delete_one", sql)
        db.exec_prepared("delete_one", values)
        db.close
    end


    def PropertyTracker.delete_all
      db = PG.connect({
        dbname: "property_tracker",
        host: "localhost"
        })

      sql = "DELETE FROM property_trackers"

      db.prepare("delete_all", sql)
      db.exec_prepared("delete_all")
      db.close()
    end

    def update
      db = PG.connect({
        dbname: "property_tracker",
        host: "localhost"
        })

      sql = "UPDATE property_trackers SET
      (build, address, value, bedroom_quantity)
      =
      ($1, $2, $3, $4)
      WHERE id = $5
      "
      values = [@build, @address, @value, @bedroom_quantity, @id]

      db.prepare("update", sql)
      dp.exec_prepared("update", values)
      db.close()
    end

    def PropertyTracker.find_by_id(id)
      db = PG.connect({
        dbname: "property_tracker",
        host: "localhost"
        })

        sql = "SELECT * FROM property_trackers
        WHERE id = $1"

        values = [id]

        db.prepare("find_by_id", sql)
        result = db.exec_prepared("find_by_id", values)
        db.close()
        found_property = result[0]
        return PropertyTracker.new(found_property)
    end

    def PropertyTracker.find_by_address(address)
      db = PG.connect({
        dbname: "property_tracker",
        host: "localhost"
        })

      sql = "SELECT * FROM property_trackers
      WHERE address = $1"

      values = [address]

      db.prepare("find_by_address", sql)
      result = db.exec_prepared("find_by_address", values)
      db.close()
      found_property_address_result = result[0]
      return PropertyTracker.new(found_property_address_result)
    end

end
