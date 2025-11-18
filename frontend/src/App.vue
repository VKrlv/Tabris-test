<template>
  <div style="max-width:900px;margin:30px auto;font-family:Inter,Arial;">
    <h2>Список адресов</h2>

    <div style="margin-bottom:12px;">
      <input
          v-model="query"
          @input="onInput"
          placeholder="Фильтр по региону/городу/улице..."
          style="width:100%;padding:8px;border-radius:6px;border:1px solid #ccc;"
      />
    </div>

    <div v-if="loading">Загрузка...</div>

    <table v-if="!loading" border="0" cellpadding="6" style="width:100%;border-collapse:collapse;">
      <thead style="text-align:left;border-bottom:1px solid #ddd;">
      <tr><th>Регион</th><th>Город</th><th>Улица</th></tr>
      </thead>
      <tbody>
      <tr v-for="item in data" :key="item.street_id">
        <td>{{ item.region }}</td>
        <td>{{ item.city }}</td>
        <td>{{ item.street }}</td>
      </tr>
      </tbody>
    </table>

    <div style="margin-top:12px;display:flex;gap:8px;align-items:center;">
      <button :disabled="page<=1" @click="goPage(page-1)">Prev</button>
      <span>Стр. {{page}} / {{pages}}</span>
      <button :disabled="page>=pages" @click="goPage(page+1)">Next</button>
      <select v-model.number="per_page" @change="onPerPageChange">
        <option :value="10">10</option>
        <option :value="25">25</option>
        <option :value="50">50</option>
        <option :value="100">100</option>
      </select>
    </div>
  </div>
</template>

<script>
import axios from 'axios';
import { ref, watch, computed } from 'vue';

export default {
  setup() {
    const query = ref('');
    const page = ref(1);
    const per_page = ref(50);
    const total = ref(0);
    const data = ref([]);
    const loading = ref(false);

    const pages = computed(() => Math.max(1, Math.ceil(total.value / per_page.value)));

    let t;
    function onInput() {
      clearTimeout(t);
      t = setTimeout(() => {
        page.value = 1;
        fetchData();
      }, 300);
    }

    function onPerPageChange() {
      page.value = 1;
      fetchData();
    }

    function goPage(p) {
      page.value = p;
      fetchData();
    }

    async function fetchData() {
      loading.value = true;
      try {
        const res = await axios.get('/api/addresses', {
          params: { q: query.value, page: page.value, per_page: per_page.value }
        });
        total.value = res.data.total || 0;
        data.value = res.data.data || [];
      } catch (e) {
        console.error(e);
        data.value = [];
        total.value = 0;
      } finally {
        loading.value = false;
      }
    }

    fetchData();

    return { query, page, per_page, total, data, loading, pages, onInput, onPerPageChange, goPage };
  }
};
</script>
