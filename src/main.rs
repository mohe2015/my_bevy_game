use bevy::prelude::*;

fn setup(mut commands: Commands, asset_server: Res<AssetServer>) {
    commands.spawn((
        Camera3dBundle::default(),
    ));
    // root node
    commands.spawn(NodeBundle {
        style: Style {
            width: Val::Percent(100.0),
            height: Val::Percent(100.0),
            justify_content: JustifyContent::SpaceBetween,
            ..default()
        },
        ..default()
    }).with_children(|parent| {
        parent.spawn((TextBundle::from_section(
            "Text Example",
            TextStyle {
                font: asset_server.load("kenney_ui-pack/Font/kenvector_future.ttf"),
                font_size: 30.0,
                color: Color::WHITE,
            },
        )));
    });
}

fn main() {
    App::new()
        .add_plugins(DefaultPlugins)
        .add_systems(Startup, setup)
        .add_systems(Update, bevy::window::close_on_esc)
        .run();
}