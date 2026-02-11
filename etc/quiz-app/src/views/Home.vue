<template>
  <div>
    <div v-for="q in questions[currLocale]" :key="q.id">
      <router-link
        v-for="quiz in q.quizzes"
        :key="quiz.id"
        :to="`quiz/${quiz.id}`"
        class="link"
      >
        {{ quiz.title }}
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
