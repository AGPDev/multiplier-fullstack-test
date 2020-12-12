<?php

namespace App\Http\Controllers\V1;

use App\Http\Controllers\Controller;
use App\Models\Category;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Hash;

class CategoryController extends Controller
{

    /**
     *  The category model instance.
     */
    private $category;

    /**
     * Create a new controller instance.
     *
     * @return void
     */
    public function __construct(Category $category)
    {
        $this->middleware('auth');
        $this->category = $category;
    }

    /**
     * Load categories list.
     *
     * @return \Illuminate\Http\JsonResponse
     */
    public function index()
    {
        return $this->category->all();
    }

    /**
     * Load category by id.
     *
     * @param string $id
     *
     * @return \Illuminate\Http\JsonResponse
     */
    public function show(string $id)
    {
        return $this->category->findOrFail($id);
    }

    /**
     * Store new category.
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
            ['name' => 'required']
        );

        return $this->category->create($attributes);
    }

    /**
     * Update category.
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
            ['name' => 'required']
        );

        $category = $this->category->findOrFail($id);

        return $category->update($attributes);
    }

    /**
     * Destroy category.
     *
     * @param string $id
     *
     * @return \Illuminate\Http\JsonResponse
     */
    public function destroy(string $id)
    {
        $category = $this->category->findOrFail($id);

        return $category->delete();
    }
}
