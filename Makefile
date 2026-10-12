apk:
		mv build/app/outputs/apk/release/app-release.apk build/Spotube-android-all-arch.apk

gensums:
				sh -c scripts/gensums.sh

migrate:
				dart run drift_dev make-migrations

changelog:
	git-cliff --unreleased