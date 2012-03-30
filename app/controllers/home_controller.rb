class HomeController < ApplicationController
  respond_to :json, :html
  # text = "oracle share price"
  @@test_data = <<EOF
<?xml version='1.0' encoding='UTF-8'?>
<queryresult success='true'
    error='false'
    numpods='4'
    datatypes='Financial'
    timedout=''
    timedoutpods=''
    timing='2.527'
    parsetiming='0.209'
    parsetimedout='false'
    recalculate=''
    id='MSPa2051a0ig0gda9e9e31a00006a52c261c434g9ch'
    host='http://www2.wolframalpha.com'
    server='10'
    related='http://www2.wolframalpha.com/api/v2/relatedQueries.jsp?id=MSPa2061a0ig0gda9e9e31a0000618b7dfd0f15g7d2&amp;s=10'
    version='2.5'>
 <pod title='Input interpretation'
     scanner='Identity'
     id='Input'
     position='100'
     error='false'
     numsubpods='1'>
  <subpod title=''>
   <plaintext>Oracle | price</plaintext>
   <img src='http://www2.wolframalpha.com/Calculate/MSP/MSP2071a0ig0gda9e9e31a000044h1dg805hi699c1?MSPStoreType=image/gif&amp;s=10'
       alt='Oracle | price'
       title='Oracle | price'
       width='106'
       height='23' />
  </subpod>
 </pod>
 <pod title='Result'
     scanner='Data'
     id='Result'
     position='200'
     error='false'
     numsubpods='1'
     primary='true'>
  <subpod title=''>
   <plaintext>$29.21  (ORCL | NASDAQ | 12:40:49 pm PDT  |  Thursday, March 29, 2012)</plaintext>
   <img src='http://www2.wolframalpha.com/Calculate/MSP/MSP2081a0ig0gda9e9e31a00001280b57hde20e7bc?MSPStoreType=image/gif&amp;s=10'
       alt='$29.21  (ORCL | NASDAQ | 12:40:49 pm PDT  |  Thursday, March 29, 2012)'
       title='$29.21  (ORCL | NASDAQ | 12:40:49 pm PDT  |  Thursday, March 29, 2012)'
       width='420'
       height='18' />
  </subpod>
 </pod>
 <pod title='Market data'
     scanner='Data'
     id='Quote:FinancialData'
     position='300'
     error='false'
     numsubpods='1'>
  <subpod title=''>
   <plaintext>change | -$0.17 (0.58% down from last close)
previous close | $29.36
open | $29.21
day&apos;s range | $29.11 (-0.9%) to $29.58 (+0.7%)
volume | 14.85 million shares
(percentage changes based on initial stock value)</plaintext>
   <img src='http://www2.wolframalpha.com/Calculate/MSP/MSP2091a0ig0gda9e9e31a0000431896b4f900935c?MSPStoreType=image/gif&amp;s=10'
       alt='change | -$0.17 (0.58% down from last close)
previous close | $29.36
open | $29.21
day&apos;s range | $29.11 (-0.9%) to $29.58 (+0.7%)
volume | 14.85 million shares
(percentage changes based on initial stock value)'
       title='change | -$0.17 (0.58% down from last close)
previous close | $29.36
open | $29.21
day&apos;s range | $29.11 (-0.9%) to $29.58 (+0.7%)
volume | 14.85 million shares
(percentage changes based on initial stock value)'
       width='382'
       height='185' />
  </subpod>
  <states count='1'>
   <state name='More'
       input='Quote:FinancialData__More' />
  </states>
 </pod>
 <pod title='History'
     scanner='Data'
     id='HistoryDaily:Last:FinancialData'
     position='400'
     error='false'
     numsubpods='1'>
  <subpod title=''>
   <plaintext>
minimum | average | maximum
$24.78 | $30.56 | $36.37
(Friday, Aug 19, 2011) |   | (Monday, May 2, 2011)</plaintext>
   <img src='http://www2.wolframalpha.com/Calculate/MSP/MSP2101a0ig0gda9e9e31a00002e1hiig0efi38473?MSPStoreType=image/gif&amp;s=10'
       alt='
minimum | average | maximum
$24.78 | $30.56 | $36.37
(Friday, Aug 19, 2011) |   | (Monday, May 2, 2011)'
       title='
minimum | average | maximum
$24.78 | $30.56 | $36.37
(Friday, Aug 19, 2011) |   | (Monday, May 2, 2011)'
       width='496'
       height='225' />
  </subpod>
  <states count='2'>
   <statelist count='7'
       value='Last year'
       delimiters=''>
    <state name='Last 3 months'
        input='HistoryDaily:Last:FinancialData__Last 3 months' />
    <state name='Last 6 months'
        input='HistoryDaily:Last:FinancialData__Last 6 months' />
    <state name='Last year'
        input='HistoryDaily:Last:FinancialData__Last year' />
    <state name='Last 2 years'
        input='HistoryDaily:Last:FinancialData__Last 2 years' />
    <state name='Last 5 years'
        input='HistoryDaily:Last:FinancialData__Last 5 years' />
    <state name='Last 10 years'
        input='HistoryDaily:Last:FinancialData__Last 10 years' />
    <state name='All data'
        input='HistoryDaily:Last:FinancialData__All data' />
   </statelist>
   <state name='Log scale'
       input='HistoryDaily:Last:FinancialData__Log scale' />
  </states>
 </pod>
 <sources count='1'>
  <source url='http://www.wolframalpha.com/sources/FinancialDataSourceInformationNotes.html'
      text='Financial data' />
 </sources>
</queryresult>
EOF

  def index
  end

  def process_speech
    conn = Faraday.new(:url => 'http://api.wolframalpha.com', :proxy => "http://www-proxy.us.oracle.com:80/") do |builder|
      builder.request  :url_encoded 
      builder.response :logger
      builder.adapter  :net_http
    end

    resp = conn.get do |req|
      req.url '/v2/query'
      # req.options = {
      #   :proxy => {
      #     :uri => "http://www-proxy.us.oracle.com:80/",  # proxy server URI
      #   }
      # }
      req.params['input'] = params[:utterance]
      req.params['appid'] = 'R5569T-AV7RJTE4A2'
    end
    #respond_with(["Server received: #{params[:utterance]}"])
    puts resp.body
    respond_with(MultiXml.parse(resp.body))
    #puts @@test_data
    #respond_with(MultiXml.parse(@@test_data))
  end

end