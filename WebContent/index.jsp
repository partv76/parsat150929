<!DOCTYPE HTML>
<%@ page import="redis.clients.jedis.Jedis" %>
<%@ page import="redis.clients.jedis.JedisPool" %>
<%@ page import="redis.clients.jedis.JedisPoolConfig" %>
<%@ page import="redis.clients.jedis.*" %>
<%@ page import="argo.jdom.*" %>

<%
String values = "";
try {
	String strAddName = request.getParameter("getNames");
    String vcap_services = System.getenv("VCAP_SERVICES");
    System.out.println("vcap_services="+vcap_services);
    //out.println("vcap_services="+vcap_services);out.println("<br>");
    if (vcap_services != null && vcap_services.length() > 0) {
        // parsing rediscloud credentials
        JsonRootNode root = new JdomParser().parse(vcap_services);
        JsonNode rediscloudNode = root.getNode("rediscloud");
        JsonNode credentials = rediscloudNode.getNode(0).getNode("credentials");

        /*
        JedisPool pool = new JedisPool(new JedisPoolConfig(),
                credentials.getStringValue("hostname"),
                Integer.parseInt(credentials.getNumberValue("port")),
                Protocol.DEFAULT_TIMEOUT,
                credentials.getStringValue("password"));
        */
   
        //out.println("Hostname="+credentials.getStringValue("hostname"));out.println("<br>");
        //out.println("Port="+credentials.getStringValue("port"));out.println("<br>");
        //out.println("Password="+credentials.getStringValue("password"));out.println("<br>");


Jedis jedis = new Jedis(credentials.getStringValue("hostname"), Integer.parseInt(credentials.getStringValue("port")));
jedis.auth(credentials.getStringValue("password"));
out.println("<br>");out.println("<br>");
System.out.println("Connected to Redis");
out.println("<h3><font color=darkgreen>Connected to Redis!!!</font></h3>");

if (strAddName != null && strAddName.equals("employee")) {
	jedis.set("Names", "[\"partha\", \"sathiya\"]");
	values = jedis.get("Names");
} else if (strAddName != null && strAddName.equals("country")) {
	jedis.set("CountryNames", "[\"Andorra\",\"United Arab Emirates\",\"Afghanistan\",\"Antigua and Barbuda\",\"Anguilla\",\"Albania\",\"Armenia\",\"Angola\",\"Antarctica\",\"Argentina\",\"American Samoa\",\"Austria\",\"Australia\",\"Aruba\",\"Iceland\",\"Azerbaijan\",\"Bosnia and Herzegovina\",\"Barbados\",\"Bangladesh\",\"Belgium\",\"Burkina Faso\",\"Bulgaria\",\"Bahrain\",\"Burundi\",\"Benin\",\"Saint Barthelemy\",\"Bermuda\",\"Brunei\",\"Bolivia\",\"Bonaire\",\"Brazil\",\"Bahamas\",\"Bhutan\",\"Bouvet Island\",\"Botswana\",\"Belarus\",\"Belize\",\"Canada\",\"Cocos Islands\",\"Congo\",\"Central African Republic\",\"Republic of the Congo\",\"Switzerland\",\"Ivory Coast\",\"Cook Islands\",\"Chile\",\"Cameroon\",\"China\",\"Colombia\",\"Costa Rica\",\"Cuba\",\"Cape Verde\",\"Curacao\",\"Christmas Island\",\"Cyprus\",\"Czechia\",\"Germany\",\"Djibouti\",\"Denmark\",\"Dominica\",\"Dominican Republic\",\"Algeria\",\"Ecuador\",\"Estonia\",\"Egypt\",\"Western Sahara\",\"Eritrea\",\"Spain\",\"Ethiopia\",\"Finland\",\"Fiji\",\"Falkland Islands\",\"Micronesia\",\"Faroe Islands\",\"France\",\"Gabon\",\"United Kingdom\",\"Grenada\",\"Georgia\",\"French Guiana\",\"Guernsey\",\"Ghana\",\"Gibraltar\",\"Greenland\",\"Gambia\",\"Guinea\",\"Guadeloupe\",\"Equatorial Guinea\",\"Greece\",\"South Georgia and the South Sandwich Islands\",\"Guatemala\",\"Guam\",\"Guinea-Bissau\",\"Guyana\",\"Hong Kong\",\"Heard Island and McDonald Islands\",\"Honduras\",\"Croatia\",\"Haiti\",\"Hungary\",\"Indonesia\",\"Ireland\",\"Israel\",\"Isle of Man\",\"India\",\"British Indian Ocean Territory\",\"Iraq\",\"Iran\",\"Iceland\",\"Italy\",\"Jersey\",\"Jamaica\",\"Jordan\",\"Japan\",\"Kenya\",\"Kyrgyzstan\",\"Cambodia\",\"Kiribati\",\"Comoros\",\"Saint Kitts and Nevis\",\"North Korea\",\"South Korea\",\"Kuwait\",\"Cayman Islands\",\"Kazakhstan\",\"Laos\",\"Lebanon\",\"Saint Lucia\",\"Liechtenstein\",\"Sri Lanka\",\"Liberia\",\"Lesotho\",\"Lithuania\",\"Luxembourg\",\"Latvia\",\"Libya\",\"Morocco\",\"Monaco\",\"Moldova\",\"Montenegro\",\"Saint Martin\",\"Madagascar\",\"Marshall Islands\",\"Macedonia\",\"Mali\",\"Myanmar\",\"Mongolia\",\"Macao\",\"Northern Mariana Islands\",\"Martinique\",\"Mauritania\",\"Montserrat\",\"Malta\",\"Mauritius\",\"Maldives\",\"Malawi\",\"Mexico\",\"Malaysia\",\"Mozambique\",\"Namibia\",\"New Caledonia\",\"Niger\",\"Norfolk Island\",\"Nigeria\",\"Nicaragua\",\"Netherlands\",\"Norway\",\"Nepal\",\"Nauru\",\"Niue\",\"New Zealand\",\"Oman\",\"Panama\",\"Peru\",\"French Polynesia\",\"Papua New Guinea\",\"Philippines\",\"Pakistan\",\"Poland\",\"Saint Pierre and Miquelon\",\"Pitcairn Islands\",\"Puerto Rico\",\"Palestine\",\"Portugal\",\"Palau\",\"Paraguay\",\"Qatar\",\"Romania\",\"Serbia\",\"Russia\",\"Rwanda\",\"Saudi Arabia\",\"Solomon Islands\",\"Seychelles\",\"Sudan\",\"Sweden\",\"Singapore\",\"Saint Helena\",\"Slovenia\",\"Svalbard and Jan Mayen\",\"Slovakia\",\"Sierra Leone\",\"San Marino\",\"Senegal\",\"Somalia\",\"Suriname\",\"South Sudan\",\"El Salvador\",\"Sint Maarten\",\"Syria\",\"Swaziland\",\"Turks and Caicos Islands\",\"Chad\",\"French Southern Territories\",\"Togo\",\"Thailand\",\"Tajikistan\",\"Tokelau\",\"East Timor\",\"Turkmenistan\",\"Tunisia\",\"Tonga\",\"Turkey\",\"Trinidad and Tobago\",\"Tuvalu\",\"Taiwan\",\"Tanzania\",\"Ukraine\",\"Uganda\",\"U.S. Minor Outlying Islands\",\"United States\",\"Uruguay\",\"Uzbekistan\",\"Vatican City\",\"Saint Vincent and the Grenadines\",\"Venezuela\",\"British Virgin Islands\",\"U.S. Virgin Islands\",\"Vietnam\",\"Vanuatu\",\"Wallis and Futuna\",\"Samoa\",\"Kosovo\",\"Yemen\",\"Mayotte\",\"South Africa\",\"Zambia\",\"Zimbabwe\"]");
	values = jedis.get("CountryNames");
} else if (strAddName != null && strAddName.equals("testdata")) {
	String combStore = "[";
	for (int i=1; i<10000; i++) {
		combStore += "\"search keyword " +i + "\","; 
	}
	combStore += "\"search keyword 10000\"]";
	jedis.set("testdata", combStore);
	values = jedis.get("testdata");
} else if (strAddName != null && strAddName.equals("halfmillion")) {
	String combStore = "[";
	for (int i=1; i<500000; i++) {
		combStore += "\"half million " +i + "\","; 
	}
	combStore += "\"half million 500000\"]";
	jedis.set("halfmillion", combStore);
	values = jedis.get("halfmillion");
} else {
	jedis.set("Names", "[\"partha\", \"sathiya\"]");
	values = jedis.get("Names");
}
	out.println("<br>"); 
	//out.println("<h4><font color=darkgreen>Values got from Redis!!!="+values + "</font></h4>");    
	}
} catch (Exception ex) {
    // vcap_services could not be parsed.
	System.out.println("ex"+ex.toString());
	out.println("<br>");
	out.println("EXCEPTION::::::"+ex.toString());
}

/*
      //Connecting to Redis server on localhost
      Jedis jedis = new Jedis("localhost");
      System.out.println("Connection to server sucessfully");
      //check whether server is running or not
      System.out.println("Server is running: "+jedis.ping());
	  
    String value = jedis.get("Names");
	System.out.println("Value: "+value);
	*/


%>
<html>
<head>
  <meta charset="utf-8">
  <title>Create an autocomplete input box</title>
  
  <!-- Bootstrap CSS Toolkit styles -->
  <link rel="stylesheet" href="WebContent/WEB-INF/css/bootstrap.min.css">
  <link rel="stylesheet" href="WebContent/WEB-INF/css/styles.css">
</head>

<body>
  <div class="container">
    <p class="example-description">Prefetches data, stores it in localStorage, and searches it on the client: </p>
    <input id="my-input" class="typeahead" type="text" placeholder="input a employee name">
  </div>

  <!-- Load jQuery and the typeahead JS files -->
  <script src="jquery-1.10.1.min.js"></script>
  <script src="typeahead.min.js"></script>
  
  

  <script type="text/javascript">
    // Waiting for the DOM ready...
	
    $(function(){

      // applied typeahead to the text input box
      $('#my-input').typeahead({
        //name: 'countries',

        // data source 
        //prefetch: 'countries.json',
      	local: <%= values%>,
		

        // max item numbers list in the dropdown
        limit: 10
      });

    });
  </script>
</body> 
</html>