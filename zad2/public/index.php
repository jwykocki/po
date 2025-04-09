<?php

use App\Kernel;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\Dotenv\Dotenv;

require_once dirname(__DIR__).'/vendor/autoload.php';

$dotenv = new Dotenv();
$dotenv->load(dirname(__DIR__).'/.env');

$env = $_SERVER['APP_ENV'] ?? 'dev';

$debug = $_SERVER['APP_DEBUG'] ?? true;

$kernel = new Kernel($env, (bool) $debug);
$request = Request::createFromGlobals();
$response = $kernel->handle($request);
$response->send();
$kernel->terminate($request, $response);
