<?php

/** @var Laravel\Lumen\Routing\Router $router */

$router->group(
    [
        'prefix' => 'users',
    ],
    function () use ($router) {
        $router->post('/', 'UserController@store');
        $router->get('/', 'UserController@index');
        $router->get('/{id}', 'UserController@show');
        $router->put('/{id}', 'UserController@update');
        $router->delete('/{id}', 'UserController@destroy');
    }
);
