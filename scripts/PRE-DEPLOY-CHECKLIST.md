# ✅ CHECKLIST PRE-DEPLOY STRAPI (Producción Railway)

Antes de subir cambios estructurales o de contenido a producción, revisar:

## 🔁 Estructura

- [ ] ¿Se modificó la colección Post?
- [ ] ¿Agregaste campos nuevos?
- [ ] ⚠️ ¿Eliminaste campos? Asegúrate de haber respaldado la data primero
- [ ] ¿Cambiaste relaciones o tipos de datos?

## 🛑 ¿Qué NO deberías hacer directo en producción?

- [ ] Eliminar campos con contenido sin respaldo
- [ ] Cambiar nombres de colecciones (causa pérdida de referencias)
- [ ] Rehacer relaciones uno-a-muchos sin guardar contenido

## 💾 Backups antes del deploy

- [ ] Ejecutaste el script `deploy-db-to-railway.sh`
- [ ] Hiciste respaldo previo de la DB en producción (o vas a usar el script "backup-from-railway.sh")

## 📤 Commit final

```bash
git add .
git commit -m "feat: actualizo estructura Post + campos nuevos"
git push origin main
