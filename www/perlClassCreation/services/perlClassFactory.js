angular.module('dataFactory', []).factory('DataFactory', function($rootScope){

    var factory ={};
    factory.projectName = null;
    factory.classesList = [];
    factory.selectedClassIndex = 1;
    factory.selectedClass = null;



    factory.getClassesList = function(){
        return this.classesList;
    };
    factory.getProjectName = function(){
        return "Un nome qualunque";
    };
    factory.getSelectedClassIndex = function(){
        return this.selectedClassIndex;
    };
    factory.getSelectedClass = function(){
        return this.selectedClass;
    };


    factory.updateProjectName = function(name){
        this.projectName = name;
        $rootScope.$broadcast("valuesUpdated");
    };
    factory.setClassesList = function(classes){
        classesList = classes;
    };
    factory.setSelectedClassIndex = function(classIndx){
        this.selectedClassIndex = classIndx;
    };

    factory.setSelectedClass = function(SelClass){
        selectedClass = SelClass;
    };

    return factory;

});

var demoApp = angular.module('demoApp', ['ngCookies' , 'dataFactory']);

