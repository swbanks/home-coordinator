<template>
  <div class="hello">
    <h1>{{ msg }}</h1>
    <p>Today's date: 1/1/2021</p>
    <ul>
      <li v-for="chore in choreList" :key="chore.id" class="grid-container">
        <div class="grid-item">{{ chore.name }}</div>
        <div class="grid-item fas" :class="{'fa-check-double': chore.parentChecked, 'fa-check': chore.childChecked}" @click="choreDone(chore)"></div>
        <button class="grid-item" @click="markParentChecked(chore)">Click Me!</button>
      </li>
    </ul>
  </div>
</template>

<script>
export default {
  name: 'HelloWorld',
  props: {
    msg: String
  },
  computed: {
    getCheckedClass() {
      let chore = {};
      if (chore) {
        return ['fas', 'fa-check-double', 'grid-item'];
      } else if (chore.childChecked) {
        return ['fas', 'fa-check', 'grid-item'];
      }

      return 'grid-item';
    }
  },
  methods: {
    choreDone(chore) {
      chore.childChecked = !chore.childChecked;
    },
    markParentChecked(chore) {
      chore.parentChecked = !chore.parentChecked;
    }
  },
  data() {
    return {
      choreList: [
        {
          id: 1,
          name: "Clean Bedroom",
          childChecked: false,
          parentChecked: false
        },
        {
          id: 2,
          name: "Empty Dishwasher",
          childChecked: false,
          parentChecked: false
        },
        {
          id: 3,
          name: "Living Room",
          childChecked: false,
          parentChecked: false
        },
        {
          id: 4,
          name: "School done and checked",
          childChecked: false,
          parentChecked: false
        },
        {
          id: 5,
          name: "Devotions",
          childChecked: false,
          parentChecked: false
        }
      ],
    };
  },
}
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped>
.grid-container {
  display: grid;
  grid-gap: 0px 0px 0px;
  grid-template-columns: 9fr 1fr 1fr;
}

.grid-item {
 flex: 1;
 text-align: center;
 /* border: 1px 1px 1px 1px solid #dfdfdf; */
 border-top: 1px solid #dfdfdf;
 border-left: 1px solid #dfdfdf;
 border-right: 1px solid #dfdfdf;
 border-bottom: 1px solid #dfdfdf;
 /* max-width: 50px */
}

h3 {
  margin: 40px 0 0;
}
ul {
  width: 50%;
  margin: 0 auto;
  /* list-style-type: none; */
  padding: 0;
}
li {
  display: inline-block;
  margin: 0 10px;
}
a {
  color: #42b983;
}

.fa-check-double {
  color: #42b983;
}
</style>
