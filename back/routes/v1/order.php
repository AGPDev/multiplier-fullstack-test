<?php

/** @var Laravel\Lumen\Routing\Router $router */

$router->group(
    [
        'prefix' => 'orders',
    ],
    function () use ($router) {
        $router->post('/', 'OrderController@store');
        $router->get('/', 'OrderController@index');
        $router->get('/{id}', 'OrderController@show');
        $router->delete('/{id}', 'OrderController@destroy');
    }
);
