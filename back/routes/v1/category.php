<?php

/** @var Laravel\Lumen\Routing\Router $router */

$router->group(
    [
        'prefix' => 'categories',
    ],
    function () use ($router) {
        $router->post('/', 'CategoryController@store');
        $router->get('/', 'CategoryController@index');
        $router->get('/{id}', 'CategoryController@show');
        $router->put('/{id}', 'CategoryController@update');
        $router->delete('/{id}', 'CategoryController@destroy');
    }
);
