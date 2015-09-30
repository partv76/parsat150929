<!DOCTYPE HTML>
<%@ page import="redis.clients.jedis.Jedis" %>

<%

      //Connecting to Redis server on localhost
      Jedis jedis = new Jedis("localhost");
      System.out.println("Connection to server sucessfully");
      //check whether server is running or not
      System.out.println("Server is running: "+jedis.ping());
	  
    String value = jedis.get("Names");
	System.out.println("Value: "+value);
	


%>
<html>
<head>
  <meta charset="utf-8">
  <title>Create an autocomplete input box</title>
  
  <!-- Bootstrap CSS Toolkit styles -->
  <link rel="stylesheet" href="css/bootstrap.min.css">
  <link rel="stylesheet" href="css/styles.css">
</head>

<body>
  <div class="container">
    <p class="example-description">Prefetches data, stores it in localStorage, and searches it on the client: </p>
    <input id="my-input" class="typeahead" type="text" placeholder="input a employee name">
  </div>

  <!-- Load jQuery and the typeahead JS files -->
  <script src="js/jquery-1.10.1.min.js"></script>
  <script src="js/typeahead.min.js"></script>
  

  <script type="text/javascript">
    // Waiting for the DOM ready...
	
    $(function(){

      // applied typeahead to the text input box
      $('#my-input').typeahead({
        //name: 'countries',

        // data source
        //prefetch: 'data/countries.json',
		
		local: <%= value%>,

        // max item numbers list in the dropdown
        limit: 10
      });

    });
  </script>
</body> 
</html>