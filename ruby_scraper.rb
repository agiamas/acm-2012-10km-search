require 'nokogiri'
require 'open-uri'

# searches in ACM 2012 10km results for the names indicated in the search_strings array.
class RubyScraper
  attr_accessor :search_strings

  def initialize
    @search_strings = ["DIMAKOS", "KOLLIAS", "GIAMAS"]
  end

  def search
    for currentPage in 1..301
      doc = Nokogiri::HTML(open("http://acmresults.championchip.gr/acmresults2012/results.asp?p=2091&s=0&a=0&e=0&l=1&x=" + currentPage.to_s))
      for row in 1..20
        rowId = (row+1).to_s
        currentName = doc.xpath('/html/body/center/table[2]/tr['+rowId+']/td[3]/text()').to_s.strip

        @search_strings.each do |search_string|
        if(currentName.scan(search_string).size >0) then
          puts "name:" + currentName.strip
          puts "net split time:" + doc.xpath("/html/body/center/table[2]/tr[" + rowId + "]/td[4]/div[1]/div[2]/text()").to_s
          puts "net total time:" + doc.xpath("/html/body/center/table[2]/tr[" + rowId + "]/td[4]/div[2]/div[2]/text()").to_s
        end
        end
      end
    end
  end

end

rs = RubyScraper.new
rs.search
