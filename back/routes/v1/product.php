<?php

/** @var Laravel\Lumen\Routing\Router $router */

$router->group(
    [
        'prefix' => 'products',
    ],
    function () use ($router) {
        $router->post('/', 'ProductController@store');
        $router->get('/', 'ProductController@index');
        $router->get('/{id}', 'ProductController@show');
        $router->put('/{id}', 'ProductController@update');
        $router->delete('/{id}', 'ProductController@destroy');
    }
);
