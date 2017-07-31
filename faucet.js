const config = {
	manifest: false,
	bundles: [
  {
		entryPoint: "app/assets/javascripts/app.js",
		target: "app/assets/javascripts/dist/app.js",
		format: "iife",
		moduleName: "main",
		transpiler: {
			features: ["es2015"]
		}
	},
  {
		entryPoint: "app/assets/javascripts/admin.js",
		target: "app/assets/javascripts/dist/admin.js",
		format: "iife",
		moduleName: "main",
		transpiler: {
			features: ["es2015"]
		}
	}
  ]
};

module.exports = {
	js: config
};
