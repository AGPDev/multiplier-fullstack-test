<?php

/** @var Laravel\Lumen\Routing\Router $router */

$router->post('/auth/login', 'AuthController@login');

$router->group(
    [
        'middleware' => 'auth',
    ],
    function () use ($router) {
        include 'user.php';
    }
);
