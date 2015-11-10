require 'mechanize'

REG_NO = '130905586'
BIRTH_DATE = '1995-01-13' #YYYY-MM-DD

agent = Mechanize.new

begin
  homepage = agent.get('http://websismit.manipal.edu/websis/control/main')
  login_form = homepage.form_with(:name => 'loginform')
  login_form.idValue = REG_NO
  login_form.birthDate = BIRTH_DATE
  login_form.birthDate_i18n = BIRTH_DATE

  signed_in = agent.submit(login_form, login_form.buttons.first)
  raise SocketError.new if signed_in.nil?
  #signed_in
  puts signed_in.search('.loginbar').text
  acad_status = signed_in.link_with(text: 'Academic Status')
  raise SocketError.new if acad_status.nil?
  acad_status = acad_status.click

  if acad_status.nil?
    raise SocketError.new
  else
    attendance = acad_status.search('table#ListAttendanceSummary_table > tr').each do |row|
      row.search('td>span')[1..-1].each do |data|
        print data.text.strip + "\t"
      end
      puts
    end
  end

rescue SocketError
  abort 'There was an error while connecting to the site, please check your connection and try again'
end
