export default {
    async afterCreate(event) {
      const { result } = event;
  
      try {
        await fetch("https://www.abecerraguz.com/api/publicar-en-linkedin", {
          method: "POST",
          headers: {
            "Content-Type": "application/json",
          },
          body: JSON.stringify({
            mensaje: `🚀 Nuevo post: ${result.title}\n📖 ${result.content || ''}\n🔗 https://www.abecerraguz.com/blog/${result.slug}`,
          }),
        });
      } catch (error) {
        strapi.log.error("Error publicando en LinkedIn:", error);
      }
    },
  };
  