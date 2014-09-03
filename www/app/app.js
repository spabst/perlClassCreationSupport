// var demoApp = angular.module('demoApp', ['ngCookies']);


// function overlay() {
//     // alert("tutto bene");
//     el = document.getElementById("overlay");
//     el.style.visibility = (el.style.visibility == "visible") ? "hidden" : "visible";
// }

function JsonDataController($scope, $location, $cookieStore, $filter, DataFactory){

    $scope.classesList=DataFactory.classesList;

    $scope.setProjectName = function(){
        DataFactory.updateProjectName($scope.new_project_name);
        // alert($scope.new_project_name);
        // alert(DataFactory.projectName);
        $cookieStore.put('projectName', "Nome del progetto");
        // $cookieStore.put('projectName', $scope.projectName);
        $location.path('/ClassesDeclaration');
    };
    $scope.AddClass = function(){
        $scope.classesList.push({name: $scope.NewClass_name, comments : "",  attributes :[] , methods : [], hasParent: false});
        $cookieStore.put('classesList', $scope.classesList);
        $('#Modal').foundation('reveal', 'close');

    };
  
    $scope.AddAttribut = function(){
        $scope.attr_properties = {name: $scope.NewAttribute_name, mandatory: 0, rw : 0, VarType: "Any", defaultValue:"", trigger:"", inherited: false};
        $scope.classesList[DataFactory.getSelectedClassIndex()].attributes.push($scope.attr_properties) ;
        $cookieStore.put('classesList', $scope.classesList);
        $location.path('/classContent');
        $('#AddAttributeModal').foundation('reveal', 'close');
    };

    $scope.AddMethod = function(){
        $scope.classesList[DataFactory.getSelectedClassIndex()].methods.push({name: $scope.NewMethod_name, defintition: "", inherited: false, overridden : ''});
        $cookieStore.put('classesList', $scope.classesList);
        $location.path('/classContent');
        $('#AddMethodsModal').foundation('reveal', 'close');
    };

};


function IndexController($scope, $location){
    $scope.OpenReveal = function(){
        $('#SetProjectName').foundation('reveal', 'open');
    };
};








function ClassesController($scope, $location, $cookieStore, DataFactory){
    
    //$scope.projectName = "Prova per il nome";
    // $scope.$on('valuesUpdated', function() {
    //     $scope.projectName = DataFactory.projectName;
    //     // $scope.bottomValue = DemoService.bottomValue;
    // });    

    $scope.initio = function(){
        // $scope.projectName = DataFactory.getProjectName();
        $scope.classesList = DataFactory.classesList;
        $scope.selectedClassIndex = DataFactory.getSelectedClassIndex();
        $('#SetProjectName').foundation('reveal', 'close');
        alert("finestra di prova");
        // alert(DataFactory.projectName);
        $scope.projectName = DataFactory.projectName;
        // alert($scope.projectName);
    };
    $scope.initio();
   

    $scope.OpenReveal = function(){
        $('#Modal').foundation('reveal', 'open');
    };

    $scope.EditClass = function(){
        $cookieStore.put('SelectedClass', $scope.SelectedClass);
        DataFactory.setSelectedClassIndex($scope.classesList.indexOf($scope.SelectedClass));
        $cookieStore.put('selectedClassIndex' , $scope.classesList.indexOf($scope.SelectedClass))
        $location.path("/classContent");
    };
    $scope.RemoveClass = function(){     
        $scope.classesList.splice($scope.classesList.indexOf($scope.SelectedClass), 1);
        $cookieStore.put('classesList', $scope.classesList);
        $scope.SelectedClass= null;
    };

    $scope.DownloadZip = function(){
        alert(this);
        console.log(this.href);


    }

    // Prompt box: It asks the user for a confirmation about erasing all data and starting a new project
    $scope.reset = function(){
        var r=confirm("WARNING! This procedure is going to erase every data collected. Do you want to continue?");
        if (r==true){
            $cookieStore.remove('SelectedClass');
            $cookieStore.remove('projectName');
            $cookieStore.remove('classesList');
            
           
                $location.path('/');
                $window.location.reload();
            // window.location.href = 'http://localhost/SebaPerlClas/index.html#/';
            // $route.reload();
        }
    };

    // Debugging Functions
    // $scope.ShowSelectedClass = function(){
    //     console.log($scope.SelectedClass);
    // };
    $scope.ShowDataFactory = function(){
        console.log('Project Name : ', DataFactory.projectName);
        console.log('Classes List : ',  DataFactory.classesList);
        // console.log('Selected Class Index : ',  DataFactory.getSelectedClassIndex());
        // console.log('Cookiestore projectname : ', $cookieStore.get('projectName') );
    };


};



function ClassContentController($scope, $location, $filter, $cookieStore, DataFactory){

    $scope.init = function(){
        $scope.projectName = DataFactory.getProjectName();
        $scope.classesList = DataFactory.getClassesList();
        $scope.selectedClassIndex = DataFactory.getSelectedClassIndex();   
        $scope.SelectedClass = $scope.classesList[DataFactory.getSelectedClassIndex()];   
    };
    $scope.init();

    $scope.parentName = $scope.classesList[0];

    $scope.ShowHide = function(){
         $('#set_ParentClass').slideToggle();
    };
    $scope.SetParentClass = function(){
        $scope.SelectedClass.hasParent = $scope.parentName.name;

        
        $scope.SelectedClass.attributes = $filter('filter')($scope.SelectedClass.attributes, {inherited:false});

        var provvisorio = {}
        for (var i=0; i<$scope.parentName.attributes.length; i++){
            if(!($filter('filter')($scope.SelectedClass.attributes, {name: $scope.parentName.attributes[i].name})[0])){
                // alert($scope.parentName.attributes[i].name);
                provvisorio = $scope.parentName.attributes[i];
                provvisorio.inherited = 'inherited';
                $scope.SelectedClass.attributes.push(provvisorio);
            }            
        };

        alert($scope.parentName.methods.length );
        console.log( $filter('filter')($scope.SelectedClass.methods, {inherited:'inherited', overridden : '( overridden )'}));
        $scope.SelectedClass.methods =  $filter('filter')($scope.SelectedClass.methods, {inherited: false});
        //$scope.SelectedClass.methods.push( $filter('filter')($scope.SelectedClass.methods, {inherited:'inherited', overridden : '( overridden )'}) )

        for (var i=0; i<$scope.parentName.methods.length; i++){
            if(!($filter('filter')($scope.SelectedClass.methods, {name: $scope.parentName.methods[i].name})[0])){
                // alert($scope.parentName.methods[i].name);
                provvisorio = $scope.parentName.methods[i];
                provvisorio.inherited = 'inherited';
                provvisorio.overridden = '';
                $scope.SelectedClass.methods.push(provvisorio);
            }            
        };
    };
    $scope.OpenAttributesReveal = function(){
        $('#AddAttributeModal').foundation('reveal', 'open');
    };
    $scope.OpenMethodsReveal = function(){
        $('#AddMethodsModal').foundation('reveal', 'open');
    };




    $scope.RemoveAttribute = function(){     
        var attrIndex = $scope.SelectedClass.attributes.indexOf($scope.selectedAttribute)
        $scope.classesList[$scope.classesList.indexOf($scope.SelectedClass)].attributes.splice(attrIndex, 1);
        $scope.selectedAttribute = null;
        $cookieStore.put('classesList', $scope.classesList);
    }

    $scope.RemoveMethod = function(){     
        $scope.classesList.splice($scope.classesList.indexOf($scope.SelectedClass), 1);
        $cookieStore.put('classesList', $scope.classesList);
    }

// This function removes every attribute stored in the Browser's cookies and redirects to de index page
    $scope.reset = function(){
        var r=confirm("WARNING! This procedure is going to erase every data collected. Do you want to continue?");
        if (r==true){
            $cookieStore.remove('SelectedClass');
            $cookieStore.remove('projectName');
            $cookieStore.remove('classesList');

            window.location.href = 'http://localhost/SebaPerlClas/index.html#/';
        }
    };
    // Debugging Functions
    $scope.ShowSelectedClass = function(){
        console.log($scope.SelectedClass);
    };
    $scope.ShowDataFactory = function(){
        console.log('Project Name : ', DataFactory.getProjectName());
        console.log('Classes List : ',  DataFactory.getClassesList());
        console.log('Selected Class Index : ',  DataFactory.getSelectedClassIndex());
        console.log('Scope Selected Class : ',  $scope.SelectedClass);
        console.log('Cookiestore projectname : ', $cookieStore.get('projectName') );
    };

};

function AttributeEditionController($scope, $location, $routeParams, $filter, DataFactory){


    $scope.init = function(){
        $scope.projectName = DataFactory.getProjectName();
        $scope.classesList = DataFactory.getClassesList();
        $scope.selectedClassIndex = DataFactory.getSelectedClassIndex();   
        $scope.SelectedClass = $scope.classesList[DataFactory.getSelectedClassIndex()];   
    };
    $scope.init();

    $scope.attributeIndex = $routeParams.attrIndex;
    $scope.Attribute = angular.copy($scope.SelectedClass.attributes[$routeParams.attrIndex]);
    //$scope.SelectedClass.attributes[$routeParams.attrIndex].name = "blabla";


    $scope.varTypes = [
                    { value: 'Any', name : 'Any', category : 'simple', suggestion : "", regExp: "/^(.)*/" },
                    { value: 'Str', name : 'String', category : 'simple', suggestion : "Ex : Some text. Quotation marks are not needed", regExp: "/^[A-Za-z0-9]{0,20}$/" },
                    { value: 'Array', name : 'Array', category : 'simple', suggestion : 'Ex: ( "An" , "array" , "with" , 5 , "elements" ) or (1 .. 10)', regExp:  '/^\(\s*("[A-Za-z0-9]+"|\d+)\s*(,\s*("[A-Za-z0-9]+"|\d+)\s*)*\)$/' },
                    { value: 'Hash', name : 'Hash', category : 'simple', suggestion : 'Ex: ( "seba" => 213)', regExp: '/^\(\s*"[A-Za-z0-9]+"\s*=>\s*("[A-Za-z0-9]+"|\d+)\s*(,\s*"[A-Za-z0-9]+"\s*=>\s*("[A-Za-z0-9]+"|\d+)\s*)*\)$/' },
                    { value: 'Bool', name : 'Boolean', category : 'simple', suggestion : 'Ex: 0 or 1", regExp: "/^(0|1)$/' },
                    { value: 'Undef', name : 'Undefined', category : 'simple', suggestion : "", regExp: "/^$/"  },
                    { value: 'Num', name : 'Numeric', category : 'simple', suggestion : "Ex: 5.231423", regExp: '/^[0-9]+([.][0-9]+)?$/'},
                    { value: 'Int', name : 'Integers', category : 'simple', suggestion : "Ex: 5", regExp: '/^[0-9]+$/' },
                    { value: 'ScalarRef', name : 'Reference to a scalar ', category : 'references', suggestion : "", regExp: "" },
                    { value: 'ArreyRef', name : 'Reference to a an array', category : 'references', suggestion : "", regExp: '/^\[\s*("[A-Za-z0-9]+"|\d+)\s*(,\s*("[A-Za-z0-9]+"|\d+)\s*)*\]$/' },
                    { value: 'HashRef', name : 'Reference to a hash', category : 'references', suggestion : "", regExp: '/^{\s*"[A-Za-z0-9]+"\s*=>\s*("[A-Za-z0-9]+"|\d+)\s*(,\s*"[A-Za-z0-9]+"\s*=>\s*("[A-Za-z0-9]+"|\d+)\s*)*}$/' },
    ];


    $scope.typeName = $scope.SelectedClass.attributes[$routeParams.attrIndex].VarType;
    $scope.gradeC = $filter('filter')($scope.varTypes, {value: $scope.typeName})[0];
    $scope.typeIndex = $scope.varTypes.indexOf($scope.gradeC);
    $scope.Attribute.VarType = $scope.varTypes[$scope.typeIndex];

    $scope.SaveAttributesContent = function(){
        $scope.SelectedClass.attributes[$routeParams.attrIndex] = angular.copy($scope.Attribute);
        $scope.SelectedClass.attributes[$routeParams.attrIndex].VarType = angular.copy($scope.Attribute.VarType.value);
        $location.path("/classContent");
    };

};


function MethodEditionController($scope, $location, $routeParams, DataFactory){

    $scope.init = function(){
        $scope.projectName = DataFactory.getProjectName();
        $scope.classesList = DataFactory.getClassesList();
        $scope.selectedClassIndex = DataFactory.getSelectedClassIndex();   
        $scope.SelectedClass = $scope.classesList[DataFactory.getSelectedClassIndex()];   
    };
    $scope.init();

    $scope.Method = angular.copy($scope.SelectedClass.methods[$routeParams.MethodIndex]);

    $scope.SaveMethodContent = function(){
        $scope.SelectedClass.methods[$routeParams.MethodIndex] = angular.copy($scope.Method);
        $location.path("/classContent");
    };
};


