Given(/^I need to check the Connectivity$/) do
  puts "Trying to Establish Connectivity ****"

  username='XXXXXX'
  pwd='YYYYY'
  host_name='Server_name'
  @appn_id='logger_abbend'
  Net::SSH.start(host_name, username, :password => pwd) do |unix_connection|
    puts "Connection Established ******"
    path_name= '/opt/server_logs/'
    region='appl01'
    svc_file_pattern="#{@appn_id}*"
    exec_str="ls #{path_name}#{region}/#{svc_file_pattern}"
    @dir_content=unix_connection.exec!(exec_str)
  end
end

Then(/^I need to Validate the Dir or Files were Present$/) do
  service_types="error,critical,medium"
  service_list=service_types.split(", ")
  service_list.each{|service_type|
    puts "verifying " + service_type + "_" + log_type +".xml"
    expect(@dir_content).to include service_type + "_" + log_type +".xml"
  }
  puts "Validated Success Fully"
end