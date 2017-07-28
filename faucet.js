const config = {
	manifest: false,
	bundles: [{
		entryPoint: "app/assets/javascripts/main.js",
		target: "app/assets/javascripts/dist/main.js",
		format: "cjs",
		moduleName: "render",
		transpiler: {
			features: ["es2015"]
		}
	}]
};

module.exports = {
	js: config
};
