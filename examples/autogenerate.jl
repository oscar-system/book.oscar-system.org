using Oscar
function collect_examples(oscardir::String)
    booktestdir = joinpath(oscardir, "test/book")
    examples = load(joinpath(booktestdir, "ordered_examples.json"))
    for key in keys(examples)
        println(key)
        folder, filename = split(key, "/")
        if !isdir(joinpath(".", folder))
            mkdir(joinpath(".", folder))
        end
        io = open(joinpath(".", folder, filename*".md"), "w")
        for file in examples[key]
            println("  ", file)
            write(io, "```julia\n")
            content = read(joinpath(booktestdir, folder, filename, file), String)
            # Remove output block that is in some examples
            content = split(content, "# output")[1]
            write(io, content)
            write(io, "```\n\n")
        end
        close(io)
    end
end
