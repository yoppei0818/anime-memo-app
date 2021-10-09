<template>
  <div id="app">
    <p>{{ message }}</p>
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
