;;! component_model_async = true
;;! component_model_async_builtins = true

;; stream.new
(component
  (core module $m
    (import "" "stream.new" (func $stream-new (result i64)))
  )
  (type $stream-type (stream u8))
  (core func $stream-new (canon stream.new $stream-type))
  (core instance $i (instantiate $m (with "" (instance (export "stream.new" (func $stream-new))))))
)

;; stream.read
(component
  (core module $libc (memory (export "memory") 1))
  (core instance $libc (instantiate $libc))
  (core module $m
    (import "" "stream.read" (func $stream-read (param i32 i32 i32) (result i32)))
  )
  (type $stream-type (stream u8))
  (core func $stream-read (canon stream.read $stream-type async (memory $libc "memory")))
  (core instance $i (instantiate $m (with "" (instance (export "stream.read" (func $stream-read))))))
)

;; stream.read; with realloc
(component
  (core module $libc
    (func (export "realloc") (param i32 i32 i32 i32) (result i32) unreachable)
    (memory (export "memory") 1)
  )
  (core instance $libc (instantiate $libc))
  (core module $m
    (import "" "stream.read" (func $stream-read (param i32 i32 i32) (result i32)))
  )
  (type $stream-type (stream string))
  (core func $stream-read (canon stream.read $stream-type async (memory $libc "memory") (realloc (func $libc "realloc"))))
  (core instance $i (instantiate $m (with "" (instance (export "stream.read" (func $stream-read))))))
)

;; stream.write
(component
  (core module $libc (memory (export "memory") 1))
  (core instance $libc (instantiate $libc))
  (core module $m
    (import "" "stream.write" (func $stream-write (param i32 i32 i32) (result i32)))
  )
  (type $stream-type (stream u8))
  (core func $stream-write (canon stream.write $stream-type async (memory $libc "memory")))
  (core instance $i (instantiate $m (with "" (instance (export "stream.write" (func $stream-write))))))
)

;; stream.cancel-read
(component
  (core module $m
    (import "" "stream.cancel-read" (func $stream-cancel-read (param i32) (result i32)))
  )
  (type $stream-type (stream u8))
  (core func $stream-cancel-read (canon stream.cancel-read $stream-type async))
  (core instance $i (instantiate $m (with "" (instance (export "stream.cancel-read" (func $stream-cancel-read))))))
)

;; stream.cancel-write
(component
  (core module $m
    (import "" "stream.cancel-write" (func $stream-cancel-write (param i32) (result i32)))
  )
  (type $stream-type (stream u8))
  (core func $stream-cancel-write (canon stream.cancel-write $stream-type async))
  (core instance $i (instantiate $m (with "" (instance (export "stream.cancel-write" (func $stream-cancel-write))))))
)

;; stream.drop-readable
(component
  (core module $m
    (import "" "stream.drop-readable" (func $stream-drop-readable (param i32)))
  )
  (type $stream-type (stream u8))
  (core func $stream-drop-readable (canon stream.drop-readable $stream-type))
  (core instance $i (instantiate $m (with "" (instance (export "stream.drop-readable" (func $stream-drop-readable))))))
)

;; stream.drop-writable
(component
  (core module $m
    (import "" "stream.drop-writable" (func $stream-drop-writable (param i32)))
  )
  (type $stream-type (stream u8))
  (core func $stream-drop-writable (canon stream.drop-writable $stream-type))
  (core instance $i (instantiate $m (with "" (instance (export "stream.drop-writable" (func $stream-drop-writable))))))
)
