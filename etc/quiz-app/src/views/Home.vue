<template>
  <div>
    <div class="home-header">
      <h1 class="home-title">Choose a Quiz</h1>
      <p class="home-subtitle">Test your AI knowledge across all lessons</p>
    </div>
    <div class="quiz-grid" v-for="q in questions[currLocale]" :key="q.id">
      <router-link
        v-for="quiz in q.quizzes"
        :key="quiz.id"
        :to="`quiz/${quiz.id}`"
        class="quiz-card"
      >
        <span class="quiz-card-number">{{ quiz.id }}</span>
        <span class="quiz-card-title">{{ quiz.title }}</span>
        <span class="quiz-card-arrow">&rarr;</span>
      </router-link>
    </div>
  </div>
</template>

<script>
import messages from "@/assets/translations";

export default {
  name: "Home",
  computed: {
    questions() {
      return messages;
    },
    currLocale() {
      return this.$root.$i18n.locale;
    },
  },
  i18n: { messages },
};
</script>

<style scoped>
.home-header {
  text-align: center;
  margin-bottom: 2rem;
}

.home-title {
  font-size: 2rem;
  font-weight: 700;
  color: #1e293b;
  margin-bottom: 0.25rem;
}

.home-subtitle {
  color: #64748b;
  font-size: 1.05rem;
}

.quiz-grid {
  display: grid;
  grid-template-columns: repeat(auto-fill, minmax(280px, 1fr));
  gap: 0.75rem;
}

.quiz-card {
  display: flex;
  align-items: center;
  gap: 1rem;
  background: white;
  border-radius: 14px;
  padding: 1rem 1.25rem;
  text-decoration: none;
  color: #1e293b;
  box-shadow: 0 2px 8px rgba(0, 0, 0, 0.04);
  border: 1px solid #e2e8f0;
  transition: all 0.2s ease;
}

.quiz-card:hover {
  border-color: #c7d2fe;
  box-shadow: 0 4px 16px rgba(79, 70, 229, 0.12);
  transform: translateY(-2px);
}

.quiz-card-number {
  flex-shrink: 0;
  width: 36px;
  height: 36px;
  display: flex;
  align-items: center;
  justify-content: center;
  background: linear-gradient(135deg, #eef2ff, #e0e7ff);
  color: #4f46e5;
  font-weight: 700;
  font-size: 0.85rem;
  border-radius: 10px;
}

.quiz-card-title {
  flex: 1;
  font-weight: 500;
  font-size: 0.95rem;
  line-height: 1.3;
}

.quiz-card-arrow {
  flex-shrink: 0;
  color: #c7d2fe;
  font-size: 1.25rem;
  transition: color 0.2s, transform 0.2s;
}

.quiz-card:hover .quiz-card-arrow {
  color: #4f46e5;
  transform: translateX(3px);
}

@media (max-width: 600px) {
  .home-title {
    font-size: 1.5rem;
  }

  .quiz-grid {
    grid-template-columns: 1fr;
  }
}
</style>
