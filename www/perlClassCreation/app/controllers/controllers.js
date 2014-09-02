
demoApp.config(function ($routeProvider){
    $routeProvider
        .when('/',
            {
                controller : 'IndexController',
                templateUrl: '../perlClassCreation/partials/projectName.html'
            })
        .when('/ClassesDeclaration',
            {
                controller : 'ClassesController',
                templateUrl: '../perlClassCreation/partials/classesList.html'
            })
        .when('/classContent',
            {
                controller : 'ClassContentController',
                templateUrl: '../perlClassCreation/partials/classContent.html'
            })
        .when('/attributeEdition/:attrIndex',
            {
                controller : 'AttributeEditionController',
                templateUrl: '../perlClassCreation/partials/AttributeModification.html'
            })
        .when('/methodEdition/:MethodIndex',
            {
                controller : 'MethodEditionController',
                templateUrl: '../perlClassCreation/partials/MethodModification.html'
            })
        .otherwise({ 
            redirectTo : '/'
        });
});
