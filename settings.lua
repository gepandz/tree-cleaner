data:extend({
    {
        type = "int-setting",
		name = "tree-cleaner-chunk-range",
		setting_type  = "runtime-global",
		default_value = 3,
		minimum_value = 0,
		maximum_value = 10
    },
	{
        type = "bool-setting",
        name = "tree-cleaner-cliffs-too",
        setting_type = "runtime-global",
        default_value = true
    }
})