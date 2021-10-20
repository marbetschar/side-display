vapigen_args = [
    '--directory=@0@'.format(meson.current_build_dir()),
    '--metadatadir=@0@'.format(meson.current_source_dir()),
    '--girdir=@0@'.format(mutter_typelib_dir),
    '--vapidir=@0@'.format(meson.current_build_dir()),
    '--vapidir=@0@'.format(meson.current_source_dir()),
]

cogl_target = custom_target('mutter-cogl-8',
    command: [
        vapigen,
        mutter_typelib_dir / 'Cogl-8.gir',
        '--library=mutter-cogl-8',
        '--pkg=gobject-2.0',
        '--pkg=cairo',
        '--pkg=graphene-gobject-1.0',
        vapigen_args,
        files('Cogl-8-custom.vala')
    ],
    output: 'mutter-cogl-8.vapi'
)

cogl_pango_target = custom_target('mutter-cogl-pango-8',
    command: [
        vapigen,
        mutter_typelib_dir / 'CoglPango-8.gir',
        '--library=mutter-cogl-pango-8',
        '--pkg=mutter-cogl-8',
        '--pkg=pangocairo',
        vapigen_args
    ],
    depends: cogl_target,
    output: 'mutter-cogl-pango-8.vapi'
)

clutter_target = custom_target('mutter-clutter-8',
    command: [
        vapigen,
        mutter_typelib_dir / 'Clutter-8.gir',
        '--library=mutter-clutter-8',
        '--pkg=graphene-gobject-1.0',
        '--pkg=mutter-cogl-8',
        '--pkg=mutter-cogl-pango-8',
        '--pkg=atk',
        '--pkg=gio-2.0',
        '--pkg=json-glib-1.0',
        '--pkg=pangocairo',
        vapigen_args,
        files('Clutter-8-custom.vala')
    ],
    depends: [ cogl_target, cogl_pango_target ],
    output: 'mutter-clutter-8.vapi'
)

libmutter_target = custom_target('libmutter-8',
    command: [
        vapigen,
        mutter_typelib_dir / 'Meta-8.gir',
        '--library=libmutter-8',
        '--pkg=graphene-gobject-1.0',
        '--pkg=mutter-cogl-8',
        '--pkg=mutter-cogl-pango-8',
        '--pkg=mutter-clutter-8',
        '--pkg=atk',
        '--pkg=gio-2.0',
        '--pkg=json-glib-1.0',
        '--pkg=pangocairo',
        '--pkg=gtk+-3.0',
        '--pkg=x11',
        '--pkg=xfixes-4.0',
        vapigen_args
    ],
    depends: [ cogl_target, cogl_pango_target, clutter_target ],
    output: 'libmutter-8.vapi'
)