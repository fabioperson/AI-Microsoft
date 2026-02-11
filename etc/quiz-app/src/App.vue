<template>
  <div>
    <a href="#main-content" class="skip-link">Skip to content</a>
    <nav aria-label="Main navigation">
      <ul>
        <li>
          <router-link class="navlink" to="/">Home</router-link>
        </li>
        <li>
          <label for="locale-select">locale</label>
        </li>
        <li>
          <select id="locale-select" v-model="locale" aria-label="Select language">
            <option>en</option>
            <option>es</option>
          </select>
        </li>
        <li class="title">{{ questions[locale][0].title }}</li>
      </ul>
    </nav>
    <main id="main-content">
      <router-view />
    </main>
  </div>
</template>

<script>
import Quiz from "@/components/Quiz.vue";
import messages from "@/assets/translations";

export default {
  name: "App",
  computed: {
    questions() {
      return messages;
    },
  },
  i18n: { messages },
  components: {
    Quiz,
  },
  data() {
    return {
      locale: "",
    };
  },
  watch: {
    locale(val) {
      this.$root.$i18n.locale = val;
    },
  },
  created() {
    this.route = this.$route.params.id;
    if (this.$route.query.loc) {
      this.locale = this.$route.query.loc;
    } else {
      this.locale = "en";
    }
  },
};
</script>

<style>
html {
  font-family: Avenir, Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  color: #252d4a;
}
nav {
  background-color: #252d4a;
  padding: 1em;
  margin-bottom: 20px;
}

nav a {
  color: white;
  text-align: right;
}

ul {
  list-style-type: none;
  margin: 0;
  padding: 0;
  display: flex;
  align-items: center;
  flex-wrap: wrap;
}

li {
  margin-right: 0.5em;
}

.title {
  color: white;
  font-weight: bold;
  font-size: x-large;
  margin-left: auto;
}

.skip-link {
  position: absolute;
  top: -40px;
  left: 0;
  background: #252d4a;
  color: white;
  padding: 8px;
  z-index: 100;
}

.skip-link:focus {
  top: 0;
}

.link {
  display: list-item;
}

h1,
h2,
h3,
.message {
  text-align: center;
}
.error {
  color: #c62828;
  font-weight: bold;
}
.error::before {
  content: "\2717 ";
}
.complete {
  color: #2e7d32;
  font-weight: bold;
}
.complete::before {
  content: "\2713 ";
}
.card {
  width: 90%;
  max-width: 700px;
  border: #252d4a solid;
  border-radius: 5px;
  margin: auto;
  padding: 1em;
}
.btn {
  min-width: 50%;
  font-size: 16px;
  text-align: center;
  cursor: pointer;
  margin-bottom: 5px;
  width: 100%;
  max-width: 500px;
  color: #ffffff;
  background-color: #252d4a;
  border-radius: 5px;
  border: 2px solid #252d4a;
  padding: 8px 12px;
  justify-content: flex-start;
  align-items: center;
  transition: background-color 0.2s, border-color 0.2s;
}
.btn:hover {
  background-color: #3a4672;
  border-color: #3a4672;
}
.btn:focus {
  outline: 2px solid #5c6bc0;
  outline-offset: 2px;
}
.btn:active {
  background-color: #1a1f36;
}
.ans-btn {
  justify-content: center;
  display: flex;
  margin: 4px auto;
}

@media (max-width: 600px) {
  .card {
    width: 95%;
    padding: 0.75em;
  }
  .btn {
    min-width: 80%;
    width: 100%;
  }
  .title {
    font-size: large;
    margin-left: 0;
    width: 100%;
    margin-top: 0.5em;
  }
}
</style>
