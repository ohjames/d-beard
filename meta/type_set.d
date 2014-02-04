module beard.meta.type_set;

public import beard.meta.type_list;
public import beard.meta.fold_left : foldLeft;
public import beard.meta.contains  : contains;

/// A typeset (contains no duplicate types).
template TSet(T...) {
    mixin TL!T;

    template append(U) {
        static if (contains!U)
            alias TSet!T append;
        else
            alias TSet!(T, U) append;
    }

    private template add(alias U, V) { alias U.append!V add; }

    template append(U...) if (U.length > 1) {
        alias foldLeft!(add, TSet!T, U) append;
    }
}
// vim:ts=4 sw=4
