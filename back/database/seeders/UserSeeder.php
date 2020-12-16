<?php

namespace Database\Seeders;

use App\Models\User;
use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\Hash;

class UserSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        User::create(
            [
                'name' => 'Anderson Guilherme Porto',
                'email' => 'anderson.porto@agpdev.com',
                'password' => Hash::make('teste123'),
            ]
        );

        User::create(
            [
                'name' => 'Fulano Beltrano',
                'email' => 'exemplo@multiplier.com.br',
                'password' => Hash::make('teste123'),
            ]
        );

        User::factory()->times(10)->create();
    }
}
