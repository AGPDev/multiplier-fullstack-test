<?php

namespace Database\Seeders;

use App\Models\Category;
use Illuminate\Database\Seeder;

class CategorySeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        $categories = [
            'Acessórios',
            'Impressoras',
            'Monitores',
            'Mouse',
            'Teclado',
        ];

        foreach ($categories as $category) {
            Category::create(['name' => $category]);
        }

        // Category::factory()->times(10)->create();
    }
}
