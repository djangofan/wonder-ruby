require 'pry'
module Wonder
  class Deaths < Client

    def initialize
      super
      @database = 'D76'  
    end

    def get
      response = @client.post do |req|
        req.url @database
        req.body = {request_xml: request_xml}
      end
      parse(response.body)
    end

    def parse(body)
      xml = Oga.parse_xml(body)
      data_table = xml.css('page response data-table')
      binding.pry
    end

    def default_parameters
      {'O_javascript' => 'on',
      'stage' => 'request',
      'M_1' => 'D76.M1',
      'M_2' => 'D76.M2',
      'M_3' => 'D76.M3',
      'B_1' => 'D76.V5',
      'B_2' => '*None*',
      'B_3' => '*None*',
      'B_4' => '*None*',
      'B_5' => '*None*',
      'O_title' => '',
      'O_location' => 'D76.V9',
      'finder-stage-D76.V9' => 'codeset',
      'O_V9_fmode' => 'freg',
      'V_D76.V9' => '',
      'F_D76.V9' => '*All*',
      'I_D76.V9' => '*All* (The United States)',
      'finder-stage-D76.V10' => 'codeset',
      'O_V10_fmode' => 'freg',
      'V_D76.V10' => '',
      'F_D76.V10' => '*All*',
      'I_D76.V10' => '*All* (The United States)',
      'finder-stage-D76.V27' => 'codeset',
      'O_V27_fmode' => 'freg',
      'V_D76.V27' => '',
      'F_D76.V27' => '*All*',
      'I_D76.V27' => '*All* (The United States)',
      'O_urban' => 'D76.V19',
      'V_D76.V19' => '*All*',
      'V_D76.V11' => '*All*',
      'O_age' => 'D76.V5',
      'V_D76.V5' => '*All*',
      'V_D76.V51' => '*All*',
      'V_D76.V52' => '*All*',
      'V_D76.V6' => '00',
      'V_D76.V7' => '*All*',
      'V_D76.V17' => '*All*',
      'V_D76.V8' => '*All*',
      'finder-stage-D76.V1' => 'codeset',
      'O_V1_fmode' => 'freg',
      'V_D76.V1' => '',
      'F_D76.V1' => '2013',
      'I_D76.V1' => '2013 (2013)',
      'V_D76.V24' => '*All*',
      'V_D76.V20' => '*All*',
      'V_D76.V21' => '*All*',
      'O_ucd' => 'D76.V2',
      'finder-stage-D76.V2' => 'codeset',
      'O_V2_fmode' => 'freg',
      'V_D76.V2' => '',
      'F_D76.V2' => '*All*',
      'I_D76.V2' => '*All* (All Causes of Death)',
      'V_D76.V4' => '*All*',
      'V_D76.V12' => '*All*',
      'V_D76.V22' => '*All*',
      'V_D76.V23' => '*All*',
      'V_D76.V25' => '*All*',
      'O_rate_per' => '100000',
      'O_aar' => 'aar_none',
      'O_aar_pop' => '0000',
      'VM_D76.M6_D76.V1_S' => '*All*',
      'VM_D76.M6_D76.V7' => '*All*',
      'VM_D76.M6_D76.V17' => '*All*',
      'VM_D76.M6_D76.V10' => '',
      'VM_D76.M6_D76.V8' => '*All*',
      'O_show_totals' => 'true',
      'O_precision' => '1',
      'O_timeout' => '300',
      'O_labels_quick' => true,
      'O_labels_opt' => true,
      'action-Send' => 'Send'}

    end

  end
end