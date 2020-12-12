<?php

namespace App\Http\Controllers\V1;

use App\Http\Controllers\Controller;
use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Hash;

class UserController extends Controller
{

    /**
     *  The user model instance.
     */
    private $user;

    /**
     * Create a new controller instance.
     *
     * @return void
     */
    public function __construct(User $user)
    {
        $this->middleware('auth');
        $this->user = $user;
    }

    /**
     * Load users list.
     *
     * @return \Illuminate\Http\JsonResponse
     */
    public function index()
    {
        return $this->user->all();
    }

    /**
     * Load user by id.
     *
     * @param string $id
     *
     * @return \Illuminate\Http\JsonResponse
     */
    public function show(string $id)
    {
        return $this->user->findOrFail($id);
    }

    /**
     * Store new user.
     *
     * @param  \Illuminate\Http\Request  $request
     *
     * @return \Illuminate\Http\JsonResponse
     * @throws \Illuminate\Validation\ValidationException
     */
    public function store(Request $request)
    {
        $attributes = $this->validate(
            $request,
            [
                'name' => 'required',
                'email' => 'required|email|unique:users,email',
                'password' => 'required',
            ]
        );

        $attributes['password'] = Hash::make($attributes['password']);

        return $this->user->create($attributes);
    }

    /**
     * Update user.
     *
     * @param string $id
     * @param  \Illuminate\Http\Request  $request
     *
     * @return \Illuminate\Http\JsonResponse
     * @throws \Illuminate\Validation\ValidationException
     */
    public function update(string $id, Request $request)
    {
        $attributes = $this->validate(
            $request,
            [
                'name' => 'required',
                'email' => 'required|email|unique:users,email,' . $id . ',id',
                'password' => '',
                'current_password' => 'required|password:api',
            ]
        );

        if ($attributes['password'] == '') {
            $attributes['password'] = $attributes['current_password'];
        }

        $attributes['password'] = Hash::make($attributes['password']);

        $user = $this->user->findOrFail($id);

        return $user->update($attributes);
    }

    /**
     * Destroy user.
     *
     * @param string $id
     *
     * @return \Illuminate\Http\JsonResponse
     */
    public function destroy(string $id)
    {
        $user = $this->user->findOrFail($id);

        return $user->delete();
    }
}
