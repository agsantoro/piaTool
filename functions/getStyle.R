getStyle = function () {
  HTML("
                 @import url('https://fonts.googleapis.com/css2?family=Istok+Web&display=swap');

body {
  font-family: 'Istok Web', sans-serif;
}                 
                 
                 .panel-default>.panel-heading {
    color: blue;
    background-color: #1D9ADD;
    border-color: white

                }
.navbar-default .navbar-brand {
  color: white;
}    

.custom-div {
    position: absolute;
    top: 0;
    right: 0;
    width: 100px; /* Adjust the width as needed */
    height: 100px; /* Adjust the height as needed */
    background-color: red;
}
  
#fullpage_popup {
  overflow-y: auto;
  position: fixed;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  background-color: rgba(0, 0, 0, 0.7);
  z-index: 9999;
  display: none;
}

#NVP {
margin-left: 10%;

}
.popup-content {
  position: absolute;
  top: 50%;
  left: 50%;
  transform: translate(-50%, -50%);
  width: 80%; /* Adjust the width as needed */
  max-width: 400px; /* Optionally set a max-width for larger screens */
  background-color: white;
  padding: 20px;
  border-radius: 5px;
  box-shadow: 0 0 10px rgba(0, 0, 0, 0.3);
}
                 
                 .navbar {background-color:#1D9ADD !important;
                 border: 0 !important;
                 margin: 0 !important;
                 padding-top: 2em;
                 }
                 
                 
                 
                 
                 .navbar-default .navbar-nav>li>a:hover,.navbar-default .navbar-nav>li>a:focus {
    color: blackfff !important;
    background-color: #E95420 !important
                 }

.navbar-default .navbar-nav>.active>a,.navbar-default .navbar-nav>.active>a:hover,.navbar-default .navbar-nav>.active>a:focus {
    color: #ffffff;
    background-color: #E95420 !important
}

.btn-default {
    color: black;
    background-color: white;
    border-color: #aea79f
}

.dropdown-menu>.active>a,.dropdown-menu>.active>a:hover,.dropdown-menu>.active>a:focus {
    
    text-decoration: none;
    outline: 0;
    background-color: #1D9ADD
}


.btn-default:focus,.btn-default.focus {
    color: #ffffff;
    background-color:#f0f0f0;
    border-color: #6f675e
}
.bootstrap-select .dropdown-toggle .filter-option {
    position: static;
    top: 0;
    left: 0;
    float: left;
    height: 100%;
    width: 100%;
    text-align: left;
    overflow: hidden;
    -webkit-box-flex: 0;
    -webkit-flex: 0 1 auto;
    -ms-flex: 0 1 auto;
    flex: 0 1 auto;
    color: black;
}

.btn-default:active,.btn-default.active,.open>.dropdown-toggle.btn-default {
    color: #ffffff;
    background-color: #f0f0f0;
    border-color: #92897e
}

.btn-default:active:hover,.btn-default.active:hover,.open>.dropdown-toggle.btn-default:hover,.btn-default:active:focus,.btn-default.active:focus,.open>.dropdown-toggle.btn-default:focus,.btn-default:active.focus,.btn-default.active.focus,.open>.dropdown-toggle.btn-default.focus {
    color: black;
    background-color: #f0f0f0;
    border-color: #6f675e
}

.nav-tabs>li.active>a, .nav-tabs>li.active>a:hover, .nav-tabs>li.active>a:focus {
    color: #777777;
    background-color: #ffffff;
    border: 1px solid #dddddd;
    border-bottom-color: transparent;
    cursor: default;
    font-weight: bolder;
}

a, h1, h2, h3, h4, h5, p {font-family: 'Istok Web', sans-serif; margin: 0px 10px 0px 10px;}

a:hover {
    color: black;
    text-decoration: none;
}

a {color: black}


.dropdown-menu>li>a:hover,.dropdown-menu>li>a:focus {
    text-decoration: none;
    color:black;
    background-color: #f0f0f0
}

.btn-default:hover {
    color: black;
    background-color: #f0f0f0;
    border-color: #92897e;
}



")
}
