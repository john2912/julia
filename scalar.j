sign(x::Scalar) = (x < 0 ? -1 : (x > 0 ? +1 : 0))
signbit(x::Scalar) = (x < 0 ? -1 : +1)
signbit(x::Float) = (x < 0 ? -1 : (x > 0 ? 1 : (1.0/x < 0 ? -1 : +1)))

conj(x::Scalar) = x
transpose(x::Scalar) = x
ctranspose(x::Scalar) = conj(transpose(x))

max(x::Scalar, y::Scalar) = x > y ? x : y
min(x::Scalar, y::Scalar) = x < y ? x : y
sum(x::Scalar, y::Scalar) = x + y
prod(x::Scalar, y::Scalar) = x * y
all(x::Scalar, y::Scalar) = x && y ? true : false
any(x::Scalar, y::Scalar) = x || y ? true : false

macro def_reduce_op(op,init)
    `begin
        ($op)() = $init
        ($op)(x::Scalar) = x
        ($op)(x::Scalar, rest::Scalar...) = ($op)(x, ($op)(rest...))
    end
end

def_reduce_op(max,-1/0)
def_reduce_op(min,+1/0)
def_reduce_op(sum,0)
def_reduce_op(prod,1)
def_reduce_op(any,false)
def_reduce_op(all,true)
