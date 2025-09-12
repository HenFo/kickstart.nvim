const conditiona = true;
const conditionb = true;
const conditionc = true
if (conditiona || conditionb && conditionc) { }


export function a() {
    return 1 + 2
}
export function b() {
    return a() - a()
}

export function c() {
    return b() + a() + (() => 4 + 5)();
}

interface Test {
    a: () => void
}

class B implements Test {
    a() {
        return 1 + 2;
    }
}
class A implements Test {
    a() {
        return 1 + 2;
    }
}