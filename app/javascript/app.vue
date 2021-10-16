<template>
  <div id="app">
    <div class="logo">
      <h1>アニメ図鑑</h1>
    </div>
    <div class="form">
      <div class="form-group">
        <input v-model="title" placeholder="アニメ名" class="form-control">
      </div>
      <div class="form-group">
        <input type="file" @change="selectedFile" accept="image/png, image/jpeg, image/jpg" class="form-control">
      </div>
      <button class="add-button" @click="addMemo">追加</button>
    </div>
    <div class="flex">
      <div v-for="memo in memos" :key="memo.id" class="card">
        <div class="card-body">
          <div class="card-title">
            {{ memo.title }}
          </div>
          <img v-bind:src="memo.image.url" v-bind:alt="memo.title">
          <div class="card-destroy">
            <button @click="destroyMemo(memo.id)">削除する</button>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import axios from 'axios'

export default {
  data: function () {
    return {
      memos: "",
      title: "",
      image: "",
    }
  },
  methods: {
    selectedFile: function(e) {
      e.preventDefault()
      this.image = e.target.files[0]
      console.log(this.image)
    },
    setMemo: function() {
      axios.get('/api/memos').then(res => {
        this.memos = res.data
      })
    },
    addMemo: function() {
      const formData = new FormData()
      formData.append("title",this.title)
      formData.append("image",this.image)
      const config = {
        headers: {
          "content-type": "multipart/form-data",
        }
      }
      
      axios.post('/api/memos',
        formData,
        config
      ).then(res => {
        this.setMemo()
        this.title = ""
      })
    },
    destroyMemo: function(id) {
      axios.delete(`/api/memos/${id}`).then(res => {
        this.setMemo()
      })
    }
  },
  mounted() {
    this.setMemo();
  }
}
</script>

<style lang="scss" scoped>
.logo {
  width: 280px;
  margin: 0 auto;

  h1 {
    text-align: center;
    font-family: 'Noto Sans JP', sans-serif;
    background: linear-gradient(transparent 70%, #a8eaff 70%);
  }
}

.form {
  width: 500px;
  background-color: rgba(91, 195, 243, 0.527);
  display: flex;
  flex-direction: column;
  justify-content: center;
  align-items: center;
  margin: 32px auto;
  padding: 30px 0px;
  border-radius: 10px;
  
  &-group {
    margin-bottom: 15px;

    input[type="file"] {
      cursor: pointer;
    }
  }
  
  &-control {
    width: 300px;
    min-height: 24px;
    font-size: 12px;
    border: 0.5px solid rgba(0, 0, 0, 0.349);
    padding: 8px 8px;
    border-radius: 5px;
    box-shadow: 2px 2px 5px 0px rgba(0,0,0,0.2);
  }
}

.add-button {
  margin-top: 10px;
  width: 150px;
  border: 1px solid rgba(0, 0, 0, 0.349);
  border-radius: 5px;
  background: #fff;
  transition: 0.3s;
  padding: 10px;
  font-size: 12px;
  font-weight: bolder;
  cursor: pointer;

  &:hover {
    color: #fff;
    background: rgba(0, 0, 0, 0.7);
  }
}

.flex {
  display: flex;
  flex-wrap: wrap;
  justify-content: center;
}

.card {
  width: 238px;
  border: 1px solid rgba(0,0,0,.125);
  border-radius: .25rem;
  margin: 16px;
  
  &-body {
    padding: 1.25rem;
  }
  
  &-title {
    margin-bottom: .75rem;
    font-weight: 600;
  }

  &-destroy {
    button {
      color: black
    }
  }
}
</style>
