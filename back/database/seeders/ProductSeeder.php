<?php

namespace Database\Seeders;

use App\Models\Product;
use Illuminate\Database\Seeder;

class ProductSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        $products = [
            [
                'name' =>  'APRESENTADOR LOGITECH R500 USB WIRELESS PRETO',
                'category_id' => 1, // Acessórios,
                'price' => 144.89,
            ],
            [
                'name' =>  'HUB USB NZXT INTERNO 5 PORTAS 2.0, AC-IUSBH-M1',
                'category_id' => 1, // Acessórios
                'price' => 179.89,
            ],
            [
                'name' =>  'PLACA DE CAPTURA DE VIDEO AVERMEDIA LIVE GAMER ULTRA 4K HDR, GC553',
                'category_id' => 1, // Acessórios
                'price' => 1699.92,
            ],
            [
                'name' =>  'IMPRESSORA HP NEVERSTOP LASER MFP WIRELESS 1200W, 4RY26A',
                'category_id' => 2, // Impressoras
                'price' => 2109.90,
            ],
            [
                'name' =>  'IMPRESSORA HP 517 MULTIFUNCIONAL WIRELESS SMART TANK, 1TJ10A',
                'category_id' => 2, // Impressoras
                'price' => 1189.90,
            ],
            [
                'name' =>  'IMPRESSORA 3D FLASHFORGE DREAMER NX, 30786',
                'category_id' => 2, // Impressoras
                'price' => 4300.03,
            ],
            [
                'name' =>  'MONITOR PHILIPS 49" SUPERWIDE W-LED CURVO LCD VA HDMI/DISPLAYPORT/USB-C + WEBCAM, 499P9H/00',
                'category_id' => 3, // Monitores
                'price' => 8999.28,
            ],
            [
                'name' =>  'MONITOR LG 27" IPS 5MS 4K FREESYNC HDR10 HDMI/DP, 27UL500-W',
                'category_id' => 3, // Monitores
                'price' => 2489.08,
            ],
            [
                'name' =>  'MONITOR LG 21,5" TN 75HZ 5MS FHD PRETO, 22MK400H-B',
                'category_id' => 3, // Monitores
                'price' => 749.02,
            ],
            [
                'name' =>  'MOUSE GAMER REDRAGON GRIFFIN RGB 7200DPI, M607',
                'category_id' => 4, // Mouse
                'price' => 129.89,
            ],
            [
                'name' =>  'MOUSE TRUST YVI WIRELESS USB PRETO/CINZA, T18519',
                'category_id' => 4, // Mouse
                'price' => 47.49,
            ],
            [
                'name' =>  'MOUSE THERMALTAKE TTESPORTS THERON INFRARED, MO-TRN006DTM',
                'category_id' => 4, // Mouse
                'price' => 239.90,
            ],
            [
                'name' =>  'TECLADO MECÂNICO CORSAIR K68 RGB SWITCH CHERRY MX RED, CH-9102010-NA',
                'category_id' => 5, // Teclado
                'price' => 1042.50,
            ],
            [
                'name' =>  'TECLADO NEWLINK BLUETOOTH ULTRA SLIM, TC101SNL',
                'category_id' => 5, // Teclado
                'price' => 99.90,
            ],
            [
                'name' =>  'TECLADO THERMALTAKE TT ESPORTS POSEIDON Z RGB SWITCH MARROM, KB-PZR-KBBRUS-01',
                'category_id' => 5, // Teclado
                'price' => 649.90,
            ],
        ];

        foreach ($products as $product) {
            Product::create($product);
        }

        // Product::factory()->times(30)->create();
    }
}
