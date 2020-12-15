const routes = [
  {
    path: '/login',
    component: () => import('layouts/MainLayout.vue'),
    children: [
      {
        path: '',
        component: () => import('pages/auth/Login.vue')
      }
    ]
  },
  {
    path: '/',
    component: () => import('layouts/PrivateLayout.vue'),
    children: [
      {
        path: '',
        component: () => import('pages/Index.vue')
      },
      {
        path: 'categorias',
        component: () => import('pages/categories/CategoryIndex.vue'),
        children: [
          {
            path: 'add',
            component: () => import('pages/categories/CategoryAdd.vue')
          },
          {
            path: 'edit/:id',
            component: () => import('pages/categories/CategoryEdit.vue')
          }
        ]
      },
      {
        path: 'produtos',
        component: () => import('pages/products/ProductIndex.vue'),
        children: [
          {
            path: 'add',
            component: () => import('pages/products/ProductAdd.vue')
          },
          {
            path: 'edit/:id',
            component: () => import('pages/products/ProductEdit.vue')
          }
        ]
      },
      {
        path: 'pedidos',
        component: () => import('pages/orders/OrderIndex.vue')
      },
      {
        path: '/pedidos/carrinho',
        component: () => import('pages/Cart.vue')
      },
      {
        path: 'usuarios',
        component: () => import('pages/users/UserIndex.vue'),
        children: [
          {
            path: 'add',
            component: () => import('pages/users/UserAdd.vue')
          },
          {
            path: 'edit/:id',
            component: () => import('pages/users/UserEdit.vue')
          }
        ]
      }

    ]
  },
  {
    path: '*',
    component: () => import('pages/Error404.vue')
  }
]

export default routes
