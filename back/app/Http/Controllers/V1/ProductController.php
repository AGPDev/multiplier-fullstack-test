<?php

namespace App\Http\Controllers\V1;

use App\Http\Controllers\Controller;
use App\Models\Product;
use Illuminate\Http\Request;

class ProductController extends Controller
{

    /**
     *  The product model instance.
     */
    private $product;

    /**
     * Create a new controller instance.
     *
     * @return void
     */
    public function __construct(Product $product)
    {
        $this->middleware('auth');
        $this->product = $product;
    }

    /**
     * Load products list.
     *
     * @return \Illuminate\Http\JsonResponse
     */
    public function index()
    {
        return $this->product->all()->load('category');
    }

    /**
     * Load product by id.
     *
     * @param string $id
     *
     * @return \Illuminate\Http\JsonResponse
     */
    public function show(string $id)
    {
        return $this->product->findOrFail($id)->load('category');
    }

    /**
     * Store new product.
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
                'category_id' => '',
                'price' => ''
            ],
        );

        return $this->product->create($attributes);
    }

    /**
     * Update product.
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
                'category_id' => '',
                'price' => ''
            ],
        );

        $product = $this->product->findOrFail($id);

        return $product->update($attributes);
    }

    /**
     * Destroy product.
     *
     * @param string $id
     *
     * @return \Illuminate\Http\JsonResponse
     */
    public function destroy(string $id)
    {
        $product = $this->product->findOrFail($id);

        return $product->delete();
    }
}
