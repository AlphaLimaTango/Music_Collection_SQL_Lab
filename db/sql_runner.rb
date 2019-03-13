require('pg')

class SqlRunner

  def self.run(sql, values =[])
    begin
      db = PG.connect({ dbname: 'music_collection', host: 'localhost' })
      db.prepare('sql_query', sql)
      results = db.exec_prepared('sql_query', values)
    ensure
      db.close() if db != nil
    end
    return result
  end 
end
