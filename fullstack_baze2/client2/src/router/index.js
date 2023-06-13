import * as VueRouter from 'vue-router';
import HomeE from '../views/HomeE.vue';
import KuharR from "@/views/KuharR.vue";
import ZdravnikK from "@/views/ZdravnikK.vue";
import PacientT from "@/views/PacientT.vue";
const routes = [
    {
        path: '/',
        name: 'HomeE',
        component: HomeE,
    },
    {
        path: '/kuhar',
        name: 'Kuhar',
        component: KuharR,
    },
    {
        path: '/zdravnik',
        name: 'Zdravnik',
        component: ZdravnikK,
    },
    {
        path: '/pacient',
        name: 'Pacient',
        component: PacientT,
    },
];

const router = VueRouter.createRouter({
    history: VueRouter.createWebHistory(),
    routes,
});

export default router;
