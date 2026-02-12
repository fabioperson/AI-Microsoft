<template>
  <div class="app">
    <a href="#main-content" class="skip-link">Skip to content</a>
    <nav aria-label="Main navigation">
      <div class="nav-inner">
        <router-link class="nav-brand" to="/">
          <span class="nav-icon">&#9889;</span>
          {{ questions[locale][0].title }}
        </router-link>
        <div class="nav-controls">
          <label for="locale-select" class="locale-label">Language</label>
          <select id="locale-select" v-model="locale" aria-label="Select language" class="locale-select">
            <option>en</option>
            <option>es</option>
          </select>
        </div>
      </div>
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
@import url('https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap');

*,
*::before,
*::after {
  box-sizing: border-box;
  margin: 0;
  padding: 0;
}

html {
  font-family: 'Inter', -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  color: #1e293b;
  line-height: 1.6;
  font-size: 16px;
}

body {
  background: linear-gradient(135deg, #f0f4ff 0%, #e8ecf8 50%, #f5f0ff 100%);
  min-height: 100vh;
}

/* Navigation */
nav {
  background: linear-gradient(135deg, #4f46e5 0%, #7c3aed 100%);
  padding: 0;
  margin-bottom: 0;
  box-shadow: 0 4px 20px rgba(79, 70, 229, 0.3);
  position: sticky;
  top: 0;
  z-index: 50;
}

.nav-inner {
  max-width: 960px;
  margin: 0 auto;
  padding: 1rem 1.5rem;
  display: flex;
  align-items: center;
  justify-content: space-between;
}

.nav-brand {
  color: white;
  text-decoration: none;
  font-weight: 700;
  font-size: 1.25rem;
  display: flex;
  align-items: center;
  gap: 0.5rem;
  transition: opacity 0.2s;
}

.nav-brand:hover {
  opacity: 0.9;
}

.nav-icon {
  font-size: 1.5rem;
}

.nav-controls {
  display: flex;
  align-items: center;
  gap: 0.5rem;
}

.locale-label {
  color: rgba(255, 255, 255, 0.8);
  font-size: 0.8rem;
  font-weight: 500;
  text-transform: uppercase;
  letter-spacing: 0.05em;
}

.locale-select {
  background: rgba(255, 255, 255, 0.15);
  color: white;
  border: 1px solid rgba(255, 255, 255, 0.3);
  border-radius: 8px;
  padding: 0.4rem 0.75rem;
  font-size: 0.875rem;
  font-family: inherit;
  cursor: pointer;
  transition: background 0.2s;
  -webkit-appearance: none;
  appearance: none;
}

.locale-select:hover {
  background: rgba(255, 255, 255, 0.25);
}

.locale-select option {
  color: #1e293b;
  background: white;
}

.skip-link {
  position: absolute;
  top: -40px;
  left: 0;
  background: #4f46e5;
  color: white;
  padding: 8px 16px;
  z-index: 100;
  border-radius: 0 0 8px 0;
  font-weight: 500;
  text-decoration: none;
}

.skip-link:focus {
  top: 0;
}

/* Main content */
main {
  max-width: 960px;
  margin: 0 auto;
  padding: 2rem 1.5rem 4rem;
}

/* Typography */
h1 {
  font-size: 1.75rem;
  font-weight: 700;
  color: #1e293b;
  text-align: center;
  margin-bottom: 0.5rem;
}

h2 {
  font-size: 1.2rem;
  font-weight: 500;
  color: #334155;
  text-align: center;
  line-height: 1.5;
  margin-bottom: 1.5rem;
}

h3 {
  text-align: center;
}

/* Messages */
.message {
  text-align: center;
}

.error {
  color: #dc2626;
  font-weight: 600;
  background: #fef2f2;
  border: 1px solid #fecaca;
  border-radius: 12px;
  padding: 0.75rem 1.25rem;
  margin-bottom: 1rem;
}

.error::before {
  content: "\2717 ";
}

.complete {
  color: #16a34a;
  font-weight: 600;
  background: #f0fdf4;
  border: 1px solid #bbf7d0;
  border-radius: 12px;
  padding: 1rem 1.5rem;
  font-size: 1.25rem;
  margin-bottom: 1rem;
}

.complete::before {
  content: "\2713 ";
}

/* Cards */
.card {
  width: 100%;
  max-width: 700px;
  background: white;
  border: none;
  border-radius: 20px;
  margin: 0 auto;
  padding: 2.5rem 2rem;
  box-shadow: 0 4px 24px rgba(0, 0, 0, 0.06), 0 1px 4px rgba(0, 0, 0, 0.04);
}

/* Buttons */
.btn {
  font-family: inherit;
  font-size: 1rem;
  font-weight: 500;
  text-align: center;
  text-decoration: none;
  cursor: pointer;
  width: 100%;
  max-width: 500px;
  color: #4f46e5;
  background: #eef2ff;
  border: 2px solid #e0e7ff;
  border-radius: 12px;
  padding: 0.875rem 1.25rem;
  transition: all 0.2s ease;
  display: block;
}

.btn:hover {
  background: #4f46e5;
  color: white;
  border-color: #4f46e5;
  transform: translateY(-1px);
  box-shadow: 0 4px 12px rgba(79, 70, 229, 0.3);
}

.btn:focus {
  outline: 2px solid #818cf8;
  outline-offset: 2px;
}

.btn:active {
  transform: translateY(0);
  box-shadow: none;
}

.ans-btn {
  margin: 0.5rem auto;
}

@media (max-width: 600px) {
  .nav-inner {
    padding: 0.875rem 1rem;
  }

  .nav-brand {
    font-size: 1rem;
  }

  main {
    padding: 1.25rem 1rem 3rem;
  }

  .card {
    padding: 1.5rem 1.25rem;
    border-radius: 16px;
  }

  h1 {
    font-size: 1.375rem;
  }

  h2 {
    font-size: 1.05rem;
  }
}
</style>
