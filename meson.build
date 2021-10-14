project('com.github.marbetschar.side-display', 'vala', 'c')

vapi_dir = meson.current_source_dir() / 'vapi'
add_project_arguments(['--vapidir', vapi_dir], language: 'vala')

executable(
    meson.project_name(),
    'src' / 'Application.vala',
    dependencies: [
        dependency('gtk+-3.0'),
        meson.get_compiler('c').find_library('evdi'),
        meson.get_compiler('vala').find_library('evdi-1.9.1', dirs: vapi_dir)
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