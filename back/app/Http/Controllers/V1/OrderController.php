<?php

namespace App\Http\Controllers\V1;

use App\Http\Controllers\Controller;
use App\Models\Order;
use App\Models\Product;
use Illuminate\Http\Request;
use Illuminate\Support\Arr;

class OrderController extends Controller
{

    /**
     *  The order model instance.
     */
    private $order;

    /**
     *  The product model instance.
     */
    private $product;

    /**
     * Create a new controller instance.
     *
     * @return void
     */
    public function __construct(Order $order, Product $product)
    {
        $this->middleware('auth');
        $this->order = $order;
        $this->product =  $product;
    }

    /**
     * Load orders list.
     *
     * @return \Illuminate\Http\JsonResponse
     */
    public function index()
    {
        return $this->order->all();
    }

    /**
     * Load order by id.
     *
     * @param string $id
     *
     * @return \Illuminate\Http\JsonResponse
     */
    public function show(string $id)
    {
        return $this->order->findOrFail($id);
    }

    /**
     * Store new order.
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
            ['products' => 'required']
        );

        $ids = Arr::pluck($attributes['products'], 'id');
        $idsQuantity = Arr::pluck($attributes['products'], 'quantity', 'id');

        $products = $this->product->whereIn('id', $ids)->get();

        $qty = 0;
        $total = 0;
        foreach ($products as $key => $product) {
            $products[$key]['quantity'] = $idsQuantity[$product->id];
            $products[$key]['subtotal'] = $product->price * $idsQuantity[$product->id];
            $qty += $products[$key]['quantity'];
            $total += $products[$key]['subtotal'];
        }

        $order = [
            'products' => $products,
            'qty_products' => $qty,
            'total' => $total
        ];

        return $this->order->create($order);
    }

    /**
     * Destroy order.
     *
     * @param string $id
     *
     * @return \Illuminate\Http\JsonResponse
     */
    public function destroy(string $id)
    {
        $order = $this->order->findOrFail($id);

        return $order->delete();
    }
}
