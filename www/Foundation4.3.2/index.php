<!-- https://groups.google.com/forum/#!topic/foundation-framework-/49lxqPzfvvo -->
<!-- http://www.sloanslistings.com/c/toys.php -->
<!DOCTYPE html>
<!--[if IE 8]> <html class="no-js lt-ie9" lang="en" > <![endif]-->
<!--[if gt IE 8]> <!--> <html class="no-js" lang="en" > <!--<![endif]-->

<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width,initial-scale=1.0">

  <title>The Toys</title>

  <link rel="stylesheet" href="css/foundation.css">
  <link rel="stylesheet" href="c/buzz.css">
 
  <script src="js/vendor/custom.modernizr.js"></script>
   <script src="//ajax.googleapis.com/ajax/libs/jquery/1.10.2/jquery.min.js"></script>

</head>

<body><div class="wrapper">
<!-- Start Top Header -->
<header class="top-header"> 
<div class="row"> 
  <div class="small-12 medium-8 large-9 columns"> 
    <div class="brand hide"></div>
  </div>
  <div class="small-12 medium-4 large-3 columns text-right"> 
              <nav class="nav-user">
            <ul class="inline-list">
             <li><a href="signup.html" data-reveal-id="signup" data-reveal-ajax="true">SIGN UP</a></li>
               <div id="signup" class="reveal-modal tiny" data-reveal></div>
   
             <li class="or">OR</li>
			 
             <li><a href="login.html" data-reveal-id="login" data-reveal-ajax="true">LOG IN</a></li>
               <div id="login" class="reveal-modal tiny" data-reveal></div>
            <ul>
          </nav>  </div>
</div>
</header> 
<!-- End Top Header -->
<!-- Start Content Area -->
<div class="row content-container"> 
  <div class="small-12 medium-12 large-12 columns"> 

    <div data-alert class="alert-box info radius">This is the beginning of the 
      current testing section.<a href="#" class="close">&times;</a></div> 
	  
<!-- CURRENT TEST -->
<br/>
<!-- Testing -->
<h4>Testing</h4><hr/>

<!-- Testing end -->

<!-- CURRENT TEST END -->
<br/>
<div data-alert class="alert-box warning round">This is the end of the testing section</div>
<br/>
<!-- Accordion -->
<h4>Accordion</h4><hr/>
		<dl class="accordion" data-accordion>
		  <dd>
			<a href="#panel1">Accordion 1</a>
			<div id="panel1" class="content active">
			  <dl class="tabs" data-tab>
				<dd class="active"><a href="#panel2-1">Tab 1</a></dd>
				<dd><a href="#panel2-2">Tab 2</a></dd>
				<dd><a href="#panel2-3">Tab 3</a></dd>
				<dd><a href="#panel2-4">Tab 4</a></dd>
			  </dl>
			  <div class="tabs-content">
				<div class="content active" id="panel2-1">
				  <p>First panel content goes here...</p>
				</div>
				<div class="content" id="panel2-2">
				  <p>Second panel content goes here...</p>
				</div>
				<div class="content" id="panel2-3">
				  <p>Third panel content goes here...</p>
				</div>
				<div class="content" id="panel2-4">
				  <p>Fourth panel content goes here...</p>
				</div>
			  </div>
			</div>
		  </dd>
		  <dd>
			<a href="#panel2">Accordion 2</a>
			<div id="panel2" class="content">
			  Panel 2. Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.
			</div>
		  </dd>
		  <dd>
			<a href="#panel3">Accordion 3</a>
			<div id="panel3" class="content">
			  Panel 3. Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.
			</div>
		  </dd>
		</dl>
<!-- Accordion end -->
<br/>  	<div id="firstStop" class="panel">Some awesome part of your site!</div>

<!-- Tables -->
<h4>Tables</h4><hr/>
		<table>
		  <thead>
			<tr>
			  <th width="200">Table Header</th>
			  <th>Table Header</th>
			  <th width="150">Table Header</th>
			  <th width="150">Table Header</th>
			</tr>
		  </thead>
		  <tbody>
			<tr>
			  <td>Content Goes Here</td>
			  <td>This is longer content Donec id elit non mi porta gravida at eget metus.</td>
			  <td>Content Goes Here</td>
			  <td>Content Goes Here</td>
			</tr>
			<tr>
			  <td>Content Goes Here</td>
			  <td>This is longer Content Goes Here Donec id elit non mi porta gravida at eget metus.</td>
			  <td>Content Goes Here</td>
			  <td>Content Goes Here</td>
			</tr>
			<tr>
			  <td>Content Goes Here</td>
			  <td>This is longer Content Goes Here Donec id elit non mi porta gravida at eget metus.</td>
			  <td>Content Goes Here</td>
			  <td>Content Goes Here</td>
			</tr>
		  </tbody>
		</table>
<!-- Tables end -->
<br/>
<!-- Hover Dropdown -->
	<h4>Hover Dropdown</h4><hr/>
		<a href="#" data-dropdown="hover1" data-options="is_hover:true">Has Hover Dropdown</a>
		
		<ul id="hover1" class="f-dropdown" data-dropdown-content>
		  <li><a href="#">This is a link</a></li>
		  <li><a href="#">This is another</a></li>
		  <li><a href="#">Yet another</a></li>
		</ul>
<!-- Hover Dropdown end -->
<br/><br/>
<!-- Joyride - make sure to see bottom of page for rest of code-->
<h4>Joyride</h4></hr>
	
<div id="numero6"></div>

<!-- Joyride end -->
<br/>
<!-- Tooltip -->	

	<h4>Tooltip</h4><hr/><div id="numero1"></div>
    <span data-tooltip class="has-tip" title="Don't eat yellow snow...but you knew that.">Hover over me for a tip.</span>
<!-- Tooltip end -->
<br/><br/><br/>
<!-- Callout -->
	<h4>Callout with Radius</h4><hr/>
		<div class="panel callout radius">
		  <h5>This is a callout panel.</h5>
		  <p>It's a little ostentatious (really!), but useful for important content.</p>
		</div>
<!-- Callout end -->
<br/>
<!-- Panel -->
	<h4>Panel</h4><hr/>
		<div class="panel">
		  <h5>This is a regular panel.</h5>
		  <p>It has an easy to override visual style, and is appropriately subdued.</p>
		</div>
<!-- Panel end -->
<br/>
<!-- Labels -->
	<h4>Labels</h4><hr/>
		<span class="label">Regular Label</span>
		<span class="success label">Success Label</span>
		<span class="alert round label">Alert Round Label</span>
		<span class="secondary radius label">Secondary Radius Label</span>
<!-- Labels end -->
<br/>
<br/>
<!-- Dropdown Button --><div id="numero2"></div>
	<h4>Dropdown Button</h4><hr/>
		  <a href="#" data-dropdown="drop" class="button dropdown">Dropdown Button</a><br>
			<ul id="drop" data-dropdown-content class="f-dropdown">
			  <li><a href="#">This is a link</a></li>
			  <li><a href="#">This is another</a></li>
			  <li><a href="#">Yet another</a></li>
			</ul>
<!-- Dropdown Button end -->
<br/>
<!-- Split Button -->
		<h4>Split Button</h4><hr/>
		  <a href="#" class="button split">Split Button <span data-dropdown="drop"></span></a><br>
			<ul id="drop" class="f-dropdown" data-dropdown-content>
			  <li><a href="#">This is a link</a></li>
			  <li><a href="#">This is another</a></li>
			  <li><a href="#">Yet another</a></li>
			</ul>
<!-- Split Button end -->
<br/>
<!-- Button Groups -->
	<h4>Button Groups</h4><hr/>
	<div class="button-bar">
		<ul class="button-group radius">
		  <li><a href="#" class="button secondary">Button 1</a></li>
		  <li><a href="#" class="button secondary">Button 2</a></li>
		  <li><a href="#" class="button success">Button 3</a></li>
		</ul>
	</div>
<!-- Buttons Groups end -->
<br/>
<!-- Button Bar -->
	<h4>Button Bar</h4><hr/>
	<div class="button-bar">
	  <ul class="button-group radius">
		<li><a href="#" class="small button alert ">Button 1</a></li>
		<li><a href="#" class="small button success ">Button 2</a></li>
		<li><a href="#" class="small button secondary disabled">Button 3</a></li>
	  </ul>
	</div>
<!-- Button Bar end -->
<br/>
<!-- Buttons -->
	<h4>Buttons</h4><hr/>
		<!-- Size Classes -->
		<a href="#" class="button tiny">Tiny Button</a>
		<a href="#" class="button small">Small Button</a>
		<a href="#" class="button large">Large Button</a>
		<!-- Color Classes -->
		<a href="#" class="button secondary">Secondary Button</a>
		<a href="#" class="button success">Success Button</a>
		<a href="#" class="button alert">Alert Button</a>
		<!-- Radius Classes -->
		<a href="#" class="button round">Round Button</a>
		<a href="#" class="button radius">Radius Button</a>
		<!-- Disabled Class -->
		<a href="#" class="button disabled">Disabled Button</a>
<!-- Buttons end -->
<br/>
<!-- Pagination --><div id="numero3"></div>
	<h4>Pagination</h4><hr/>

		<div class="pagination-centered">
		  <ul class="pagination">
			<li class="arrow unavailable"><a href="">&laquo;</a></li>
			<li class="current"><a href="">1</a></li>
			<li><a href="">2</a></li>
			<li><a href="">3</a></li>
			<li><a href="">4</a></li>
			<li class="unavailable"><a href="">&hellip;</a></li>
			<li><a href="">12</a></li>
			<li><a href="">13</a></li>
			<li class="arrow"><a href="">&raquo;</a></li>
		  </ul>
		</div>
<!-- Pagination end -->
    <br/>
<!-- Breadcrumbs--><h4>Breadcrumbs</h4><hr/>
	<ul class="breadcrumbs">
	  <li><a href="#">Home</a></li>
	  <li><a href="#">Features</a></li>
	  <li class="unavailable"><a href="#">Gene Splicing</a></li>
	  <li class="current"><a href="#">Cloning</a></li>
	</ul>
<!-- Breadcrumbs end -->
<br/>
<!-- Magellan --><h4>Magellan</h4><hr/>

	<div data-magellan-expedition="fixed">
  	 <dl class="sub-nav">
       <dd data-magellan-arrival="build"><a href="#build">Build</a></dd>
       <dd data-magellan-arrival="js"><a href="#js">JS</a></dd>
     </dl>
   </div>
<!-- Magellan end -->
<br/>
<!-- Horizontal tabs --><h4>Horizontal Tabs</h4><hr/>

    <dl class="tabs" data-tab>
      <dd><a href="#panel2-1">Tab 1</a></dd>
      <dd><a href="#panel2-2">Tab 2</a></dd>
      <dd class="active"><a href="#panel2-3">Tab 3</a></dd>
      <dd><a href="#panel2-4">Tab 4</a></dd>
    </dl>
 
 
    <div class="tabs-content"> 
      <div class="content" id="panel2-1"> 
        <p>First panel content goes here...</p>
      </div>
      <div class="content" id="panel2-2"> 
        <p>Second panel content goes here...</p>
      </div>
      <div class="content active" id="panel2-3"> 
        <p>Third panel content goes here...</p>
      </div>
      <div class="content" id="panel2-4"> 
        <p>Fourth panel content goes here...</p>
      </div>
    </div>


	<!-- Horizontal tabs end -->
	<br/><p><a name="build"></a></p>
<h3 data-magellan-destination="build">build</h3>

    <!-- Regular alert -->
    <h3>Normal Alert</h3>
    <hr/>
    <div class="alert-box">Just a regular alert box, nothing fancy.</div>
    <!-- Regular alert end -->
    <br/>
    <!-- Topbar Stichy --><div id="numero4"></div>

	<h3>Top Bar Sticky Nav</h3>
    <hr/>

      <div class="contain-to-grid sticky"> <nav class="top-bar" data-topbar> 
        <ul class="title-area">
          <li class="name"> 
            <h1><a href="#">COMPANY NAME</a></h1>
          </li>
        </ul>
        <section class="top-bar-section">
        <!-- Right Nav Section -->
        <ul class="right">
          <li><a href="/">HOME</a></li>
          <li><a href="#">ABOUT</a></li>
          <li><a href="#">CONTACT</a></li>
          <li><a href="#">MY PICTURES</a></li>
          <li class="has-dropdown"><a href="/a/news.php">MY PROJECTS</a> 
            <ul class="dropdown">
              <li> 
                <label>LABEL IF YOU WANT</label>
              </li>
              <li class="divider"></li>
              <li><a href="#">Project 1</a></li>
              <li class="divider"></li>
              <li><a href="#">Project 2</a></li>
              <li class="divider"></li>
              <li><a href="#">Project 3</a></li>
              <li class="divider"></li>
              <li><a href="#">Project 4</a></li>
            </ul>
          </li>
          <li class="active"><a href="#">Username +</a></li>
        </ul>
        <!-- Left Nav Section -->
        <ul class="left">
          <li><a href="#">Left Nav Button</a></li>
        </ul>
        </section> </nav> </div>
    <!-- Topbar end -->
	<br/>
    <!-- Modal 1 with html from div below -->
    <h3>Modal 1</h3>
    <hr/>
    <p><a href="#" data-reveal-id="basicModal">Here is a modal with some basic 
      text</a></p>
    <div id="basicModal" class="reveal-modal" data-reveal> 
      <h2>Here is your text</h2>
      <p>And some more...</p>
      <a class="close-reveal-modal">&#215;</a></div>
    <br/>
    <!-- Modal 2 with page from same site -->
    <h3>Modal 2</h3>
    <hr/>
    <p><a href="signup.html" data-reveal-id="pageModal" data-reveal-ajax="true">Here 
      is a modal that shows another page from my site. In this case, a sign up 
      form.</a></p>
    <div id="pageModal" class="reveal-modal" data-reveal></div>
    <!--End modals -->
    <br/><p><a name="js"></a></p>
<h3 data-magellan-destination="js">js</h3>

    <!-- Form -->
    <h3>Form with an alert</h3><div id="numero5"></div>
    <hr/>
    <form action="" method="post" data-abide>
      <div class="row"> 
        <div class="large-6 columns"> 
          <div data-alert class="alert-box success">Your Message Was Successfully 
            Sent. Thank You!<a href="#" class="close">&times;</a></div>
        </div>
      </div>
      <div class="row"> 
        <div class="medium-3 large-3 columns"> 
          <label class="error"></label>
          <input type="text" name="fname" placeholder="First Name" value="" required>
          <small class="error">Please enter a valid first name</small> </div>
        <div class="medium-3 large-3 pull-6 columns"> 
          <label class="error"></label>
          <input type="text" name="lname" placeholder="Last Name" value="" required>
          <small class="error">Please enter a valid last name</small> </div>
      </div>
      <div class="row"> 
        <div class="medium-3 large-3 columns"> 
          <label class="error"></label>
          <input type="text" name="phone" placeholder="Phone Number" value="" required>
          <small class="error">Please enter a valid phone number</small> </div>
        <div class="medium-3 large-3 pull-6 columns"> 
          <label class="error"></label>
          <input type="text" name="email" placeholder="Email Address" value="" required>
          <small class="error">Please enter a valid email address</small> </div>
      </div>
      <div class="row"> 
        <div class="medium-6 large-6 columns" > 
          <label></label>
          <textarea type="text" name="comment" placeholder="Let us know how we can help you..." value=""></textarea>
          <small class="error">Please explain how we can help</small> </div>
      </div>
      <div class="row"> 
        <div class="medium-12 large-12 columns"> 
          <input type="Submit" name="Submit" class="button">
        </div>
      </div>
    </form>
    <!-- Form end -->
    <br/>
    <!--Tabs -->
    <h3>Horizontal Tabs (2)</h3>
    <hr/>
    <div class="row"> 
      <div class="large-12 columns"> 
        <div class="section-container auto" data-section data-options="deep_linking: true;"> 
          <section class="section"> 
          <p class="title"><a href="#panel1">TAB #1</a></p>
          <div class="content" data-slug="panel1"> 
            <p> 
            <h4>My First Tab</h4>
            <p>Some text and a form that with server side validation set up</p>
            <!-- Form inside tab -->
            <form action="" method="post" data-abide>
              <div class="row"> 
                <div class="medium-3 large-3 columns"> 
                  <label class="error"></label>
                  <input type="text" name="fname" placeholder="First Name" value="" required>
                  <small class="error">Please enter a valid first name</small> 
                </div>
                <div class="medium-3 large-3 pull-6 columns"> 
                  <label class="error"></label>
                  <input type="text" name="lname" placeholder="Last Name" value="" required>
                  <small class="error">Please enter a valid last name</small> 
                </div>
              </div>
              <div class="row"> 
                <div class="medium-3 large-3 columns"> 
                  <label class="error"></label>
                  <input type="text" name="phone" placeholder="Phone Number" value="" required>
                  <small class="error">Please enter a valid phone number</small>	
                </div>
                <div class="medium-3 large-3 pull-6 columns"> 
                  <label class="error"></label>
                  <input type="text" name="email" placeholder="Email Address" value="" required>
                  <small class="error">Please enter a valid email address</small>	
                </div>
              </div>
              <div class="row"> 
                <div class="medium-6 large-6 columns" > 
                  <label></label>
                  <textarea type="text" name="comment" placeholder="Let us know how we can help you..." value=""></textarea>
                  <small class="error">Please explain how we can help</small> 
                </div>
              </div>
              <div class="row"> 
                <div class="medium-12 large-12 columns"> 
                  <input type="Submit" name="Submit" class="button">
                </div>
              </div>
            </form>
            <!-- Form inside tab end -->
          </div>
          </section> 
          <div class="section"> 
            <p class="title"><a href="#panel2">TAB #2</a></p>
            <div class="content" data-slug="panel2"> 
              <h3>My Second Tab</h3>
              <p>Some text with a <a href="#">link</a> for you.</p>
            </div>
          </div>
        </div>
      </div>
      <!-- Tabs end -->
      <br/>
      <!-- Typography -->
      <h3>Typography</h3>
      <hr/>
      <div class="small-12 medium-12 large-12 columns"> 
        <h1>H1</h1>
        <h2>H2</h2>
        <h3>H3</h3>
        <h4>H4</h4>
        <h5>H5</h5>
        <h6>H6</h6>
        <p>This is normal text with a <a href="#">link</a>.</p>
        <p><strong>This is bold text with a <a href="#">link</a>.</strong></p>
        <h1>This is an h1 with a <a href="#">link</a></h1>
        <h2>This is an h2 with a <a href="#">link</a></h2>
        <h3>This is an h3 with a <a href="#">link</a></h3>
        <h4>This is an h4 with a <a href="#">link</a></h4>
        <h5>This is an h5 with a <a href="#">link</a></h5>
        <h6>This is an h6 with a <a href="#">link</a></h6>
      </div>
      <!-- Typography end -->
      <br/>
      <h3>Top Bar Fixed</h3>
      <hr/>
      <!-- Topbar -->
      <div class="fixed"> <nav class="top-bar" data-topbar> 
        <ul class="title-area">
          <li class="name"> 
            <h1><a href="#">COMPANY NAME</a></h1>
          </li>
        </ul>
        <section class="top-bar-section">
        <!-- Right Nav Section -->
        <ul class="right">
          <li><a href="/">HOME</a></li>
          <li><a href="#">ABOUT</a></li>
          <li><a href="#">CONTACT</a></li>
          <li><a href="#">MY PICTURES</a></li>
          <li class="has-dropdown"><a href="/a/news.php">MY PROJECTS</a> 
            <ul class="dropdown">
              <li> 
                <label>LABEL IF YOU WANT</label>
              </li>
              <li class="divider"></li>
              <li><a href="#">Project 1</a></li>
              <li class="divider"></li>
              <li><a href="#">Project 2</a></li>
              <li class="divider"></li>
              <li><a href="#">Project 3</a></li>
              <li class="divider"></li>
              <li><a href="#">Project 4</a></li>
            </ul>
          </li>
          <li class="active"><a href="#">Username +</a></li>
        </ul>
        <!-- Left Nav Section -->
        <ul class="left">
          <li><a href="#">Left Nav Button</a></li>
        </ul>
        </section> </nav> </div>
      <!-- Topbar end -->
<!-- More Joyride -->
		<ol class="joyride-list" data-joyride>
		  <li data-id="firstStop" data-text="Next" data-options="tip_location: top">
			<p>Hello and welcome to the Joyride.</p>
		  </li>
		  <li data-id="numero1" data-class="custom so-awesome" data-text="Next">
			<h4>Stop #1</h4>
			<p> A Tooltip.</p>
		  </li>
		  <li data-id="numero2" data-button="Next" data-options="tip_location:top;tip_animation:fade">
			<h4>Stop #2</h4>
			<p>Button, button, who has the button.</p>
		  </li>
		  <li data-id="numero3" data-button="Next" data-options="tip_location:top;tip_animation:fade">
			<h4>Stop #3</h4>
			<p>Paginations</p>
		  </li>
		  <li data-id="numero4" data-class="custom so-awesome" data-text="Next">
			<h4>Stop #4</h4>
			<p>Sticky</p>
		  </li>
		  <li data-id="numero5" data-class="custom so-awesome" data-text="Next">
			<h4>Stop #5</h4>
			<p>Form</p>
		  </li>
		  <li data-id="numero6" data-class="custom so-awesome" data-text="Next">
			<h4>Stop #6</h4>
			<p>That's all for now, how was the ride?</p>
		  </li>

		  <li data-button="End">
			<h4>Stop #7 aka Dizzy</h4>
			<p>Oh yeah, it works as a modal too!</p>
		  </li>
		</ol>
<!-- Joyride end -->
	  
	  
	  
	   </content>
      </div>
  </div>
  <!-- End Content Area -->
  <div class="push"></div>
</div>
<!-- End page wrap -->
<!-- Start Footer Area -->
<footer class="footer hide"> 
<div class="row footer-container"> 
</div>
<!-- End Footer Area -->
<!-- Start Copyright Area -->
<div class="copyright"> 
  <div class="row hide"> 
  </div>
</div>
</footer> 
<br/>

<!-- End Copyright Area -->
 
    <script>
      document.write('<script src=/js/vendor/'
        + ('__proto__' in {} ? 'zepto' : 'jquery')
        + '.js><\/script>');
    </script>

  <script src="js/foundation/foundation.js"></script>
  <script src="js/foundation/foundation.reveal.js"></script>
  <script src="js/foundation/foundation.section.js"></script>
  <script src="js/foundation/foundation.abide.js"></script>
  <script src="js/foundation/foundation.accordion.js"></script>
  <script src="js/foundation/foundation.alert.js"></script>
  <script src="js/foundation/foundation.clearing.js"></script>
  <script src="js/foundation/foundation.cookie.js"></script>
  <script src="js/foundation/foundation.dropdown.js"></script>
  <script src="js/foundation/foundation.forms.js"></script>
  <script src="js/foundation/foundation.interchange.js"></script> 
  <script src="js/foundation/foundation.joyride.js"></script> 
  <script src="js/foundation/foundation.magellan.js"></script> 
  <script src="js/foundation/foundation.orbit.js"></script>
  <script src="js/foundation/foundation.placeholder.js"></script>  
  <script src="js/foundation/foundation.tooltip.js"></script>
  <script src="js/foundation/foundation.topbar.js"></script>
  <script src="js/foundation/foundation.interchange.js"></script>
  <script src="js/foundation/foundation.offcanvas.js"></script>
  <script src="js/foundation/jquery.cookie.js"></script>
  
    <!-- Other JS plugins can be included here --> 

  <script>
    $(document).foundation();
  </script>
   
</body>
</html>