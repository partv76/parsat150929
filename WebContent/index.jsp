<!DOCTYPE HTML>
<%@ page import="redis.clients.jedis.Jedis" %>
<%@ page import="redis.clients.jedis.JedisPool" %>
<%@ page import="redis.clients.jedis.JedisPoolConfig" %>
<%@ page import="redis.clients.jedis.*" %>
<%@ page import="argo.jdom.*" %>

<%

try {
    String vcap_services = System.getenv("VCAP_SERVICES");
    System.out.println("vcap_services="+vcap_services);
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
   



Jedis jedis = new Jedis(credentials.getStringValue("hostname"), Integer.parseInt(credentials.getNumberValue("port")));
jedis.auth(credentials.getStringValue("password"));
System.out.println("Connected to Redis");
    }
} catch (Exception ex) {
    // vcap_services could not be parsed.
	System.out.println("ex"+ex.toString());
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
        prefetch: 'countries.json',
		
		

        // max item numbers list in the dropdown
        limit: 10
      });

    });
  </script>
</body> 
</html>