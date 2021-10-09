<template>
  <div id="app">
    <ul>
      <li v-for="memo in memos" :key="memo.id">
        {{ memo.title }}：{{ memo.description }}
      </li>
    </ul>
  </div>
</template>

<script>
import axios from 'axios'

export default {
  data: function () {
    return {
      memos: ""
    }
  },
  methods: {
    setMemo: function() {
      axios.get('/api/memos').then(res => (
        this.memos = res.data
      ))
    }
  },
  mounted() {
    this.setMemo();
  }
}
</script>

<style scoped>
p {
  font-size: 2em;
  text-align: center;
}
</style>
