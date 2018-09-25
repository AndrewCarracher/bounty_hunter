require('pg')

class TrackBounty

  attr_accessor(:bounty_value, :last_known_location)
  attr_reader(:id, :name, :species)

  def initialize(options)
    @id.to_i()
    @name,
    @species,
    @last_known_location,
    @bounty_value.to_i()
  end

  def self.delete_all()
    db = PG.connect({
      dbname: 'bounty_hunter',
      host: 'localhost'
      })

    sql = 'DELETE FROM track_bounties;'

    db.exec(sql)
    db.close()
  end

  def self.all()
    db = PG.connect({
      dbname: 'bounty_hunter',
      host: 'localhost'
      })

    sql = 'SELECT * FROM track_bounties;'

    db.prepare('all', sql)
    order_hashes = db.exec_prepared('all')
    db.close()

    order_objects = order_hashes.map do |order_hash|
      TrackBounty.new(order_hash)
    end

    return order_objects
  end

  def save()
    db = PG.connect({
      dbname: 'bounty_hunter',
      host: 'localhost'
      })

    sql = "
      INSERT INTO  track_bounties (
      name,
      species,
      last_known_location,
      bounty_value
      )
      VALUES ($1, $2, $3, $4)
      RETURNING id;
      "

    db.prepare('save', sql)
    result = db.exec_prepared('save', [
      @name,
      @species,
      @last_known_location,
      @bounty_value
      @id
    ])
    db.close()

    result_hash = result[0]
    string_id = result_hash['id']
    id = string_id.to_i()
    @id = id
  end

  def update()
    db = PG.connect ({
      dbname: 'bounty_hunter',
      host: 'localhost'
      })

    sql = "
      UPDATE pizza_orders
      SET (
        name,
        species,
        last_known_location,
        bounty_value
      ) = ( $1, $2, $3, $4 )
      WHERE id = $5;
    "
    values = [
      @name,
      @species,
      @last_known_location,
      @bounty_value
      @id
    ]

    db.prepare('update', sql)
    db.exec_prepared('update', values)
    db.close()
  end
end
