project('com.github.marbetschar.side-display', 'vala', 'c')

vapi_dir = meson.current_source_dir() / 'vapi'
add_project_arguments(['--vapidir', vapi_dir], language: 'vala')

libmutter_dep = dependency('libmutter-8', version: '>= 40')
mutter_dep = [
    libmutter_dep,
    dependency('mutter-cogl-8'), dependency('mutter-cogl-pango-8'),
    dependency('mutter-clutter-8')
]
mutter_typelib_dir = libmutter_dep.get_pkgconfig_variable('typelibdir')

executable(
    meson.project_name(),
    'src' / 'Application.vala',
    dependencies: [
        dependency('gtk+-3.0'),
        mutter_dep
    ],
    install: true
)

install_data(
    'data' / 'side-display.desktop',
    install_dir: get_option ('datadir') / 'applications',
    rename: meson.project_name() + '.desktop'
)

install_data(
    'data' / 'side-display.appdata.xml',
    install_dir: get_option('datadir') / 'metainfo',
    rename: meson.project_name() + '.appdata'
)

vapigen = find_program('vapigen', required: false)
if vapigen.found()
    subdir('vapi')
endif