require 'pry'
module Wonder
  class Deaths < Client

    def initialize
      super
      @database = 'D76'  
    end

    def post
      response = @client.post do |req|
        req.url @database
        req.body = {request_xml: request_xml}
      end
      parse(response.body)
    end

    def parse(body)
      xml = Oga.parse_xml(body)
      data_table = xml.css('page response data-table')
      parse_table(data_table[0])
    end

    def parse_table(table)
      #loop through the rows
      table.children.each do |r|
        next if r.class == Oga::XML::Text
        #loop through the columns
        @data << r.children.map do |c|
          next if c.class == Oga::XML::Text
          c.attributes[0].value == 1 ? "Total" : c.attributes[0].value
        end
      end
      if @data[-1][0] == "1"
        @data[-1][0] = "Total"
      end
      @data
    end

    #people who died from by_years by_cause_of_death by_location

    #
    def group_by(*args)
      @group_by = nil
      raise 'You can only group_by five levels' if args.size > 5
      args.each_with_index do |a,i|
      raise "#{a} not in list of available options" if !group_by_options.keys.include?(a)
         group_by_parameters["B_#{i+1}"] = a
      end
    end

    def group_by_parameters
      @group_by ||= {'B_1' => 'D76.V5',
      'B_2' => '*None*',
      'B_3' => '*None*',
      'B_4' => '*None*',
      'B_5' => '*None*'}
    end

    def group_by_options
      {"D76.V5"=>"Age Groups",
      "D76.V20"=>"Autopsy",
      "D76.V7"=>"Gender",
      "D76.V17"=>"Hispanic Origin",
      "D76.V28"=>"15 Leading Causes of Death",
      "D76.V29"=>"15 Leading Causes of Death (Infants)",
      "D76.V2-level1"=>"ICD Chapter",
      "D76.V2-level2"=>"ICD Sub-Chapter",
      "D76.V2-level3"=>"Cause of death",
      "D76.V4"=>"ICD-10 113 Cause List",
      "D76.V12"=>"ICD-10 130 Cause List (Infants)",
      "D76.V22"=>"Injury Intent",
      "D76.V23"=>"Injury Mechanism &amp; All Other Leading Causes",
      "D76.V25"=>"Drug/Alcohol Induced Causes",
      "D76.V21"=>"Place of Death",
      "D76.V8"=>"Race",
      "D76.V10-level1"=>"Census Region",
      "D76.V10-level2"=>"Census Division",
      "D76.V27-level1"=>"HHS Region",
      "D76.V9-level1"=>"State",
      "D76.V9-level2"=>"County",
      "D76.V19"=>"2013 Urbanization",
      "D76.V11"=>"2006 Urbanization",
      "D76.V24"=>"Weekday",
      "D76.V1-level1"=>"Year",
      "D76.V1-level2"=>"Month"}
    end

    def state_options
      {"*All*" =>"The United States",
      "01"=>"Alabama",
      "02"=>"Alaska",
      "04"=>"Arizona",
      "05"=>"Arkansas",
      "06"=>"California",
      "08"=>"Colorado",
      "09"=>"Connecticut",
      "10"=>"Delaware",
      "11"=>"District of Columbia",
      "12"=>"Florida",
      "13"=>"Georgia",
      "15"=>"Hawaii",
      "16"=>"Idaho",
      "17"=>"Illinois",
      "18"=>"Indiana",
      "19"=>"Iowa",
      "20"=>"Kansas",
      "21"=>"Kentucky",
      "22"=>"Louisiana",
      "23"=>"Maine",
      "24"=>"Maryland",
      "25"=>"Massachusetts",
      "26"=>"Michigan",
      "27"=>"Minnesota",
      "28"=>"Mississippi",
      "29"=>"Missouri",
      "30"=>"Montana",
      "31"=>"Nebraska",
      "32"=>"Nevada",
      "33"=>"New Hampshire",
      "34"=>"New Jersey",
      "35"=>"New Mexico",
      "36"=>"New York",
      "37"=>"North Carolina",
      "38"=>"North Dakota",
      "39"=>"Ohio",
      "40"=>"Oklahoma",
      "41"=>"Oregon",
      "42"=>"Pennsylvania",
      "44"=>"Rhode Island",
      "45"=>"South Carolina",
      "46"=>"South Dakota",
      "47"=>"Tennessee",
      "48"=>"Texas",
      "49"=>"Utah",
      "50"=>"Vermont",
      "51"=>"Virginia",
      "53"=>"Washington",
      "54"=>"West Virginia",
      "55"=>"Wisconsin",
      "56"=>"Wyoming"}
    end

    def measure_parameters
      {'M_1' => 'D76.M1',
      'M_2' => 'D76.M2',
      'M_3' => 'D76.M3'
      }
    end

    def where_parameters
      {"V_D76.V9"=>"", "V_D76.V10"=>"", "V_D76.V27"=>"", "V_D76.V19"=>"*All*", "V_D76.V11"=>"*All*", "V_D76.V5"=>"*All*", "V_D76.V51"=>"*All*", "V_D76.V52"=>"*All*", "V_D76.V6"=>"00", "V_D76.V7"=>"*All*", "V_D76.V17"=>"*All*", "V_D76.V8"=>"*All*", "V_D76.V1"=>"", "V_D76.V24"=>"*All*", "V_D76.V20"=>"*All*", "V_D76.V21"=>"*All*", "V_D76.V2"=>"", "V_D76.V4"=>"*All*", "V_D76.V12"=>"*All*", "V_D76.V22"=>"*All*", "V_D76.V23"=>"*All*", "V_D76.V25"=>"*All*"}
    end

    def finder_parameters
      {"F_D76.V9"=>"*All*", "F_D76.V10"=>"*All*", "F_D76.V27"=>"*All*", "F_D76.V1"=>"2013", "F_D76.V2"=>"*All*"}
    end

    def misc_parameters
      {"O_javascript"=>"on", "O_title"=>"", "O_location"=>"D76.V9", "O_V9_fmode"=>"freg", "O_V10_fmode"=>"freg", "O_V27_fmode"=>"freg", "O_urban"=>"D76.V19", "O_age"=>"D76.V5", "O_V1_fmode"=>"freg", "O_ucd"=>"D76.V2", "O_V2_fmode"=>"freg", "O_rate_per"=>"100000", "O_aar"=>"aar_none", "O_aar_pop"=>"0000", "O_show_totals"=>"true", "O_precision"=>"1", "O_timeout"=>"300", "O_labels_quick"=>true, "O_labels_opt"=>true}
    end

    def age_adjusted_parameters
      {'VM_D76.M6_D76.V1_S' => '*All*',
      'VM_D76.M6_D76.V7' => '*All*',
      'VM_D76.M6_D76.V17' => '*All*',
      'VM_D76.M6_D76.V10' => '',
      'VM_D76.M6_D76.V8' => '*All*'
      }
    end

    def default_parameters
      [group_by_parameters, measure_parameters, misc_parameters, age_adjusted_parameters, 
            finder_parameters, where_parameters].each_with_object({}) { |oh, nh| nh.merge!(oh)}
    end

  end
end