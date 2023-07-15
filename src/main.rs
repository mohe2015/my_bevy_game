use bevy::prelude::*;

fn setup(mut commands: Commands, asset_server: Res<AssetServer>) {
    commands.spawn((Camera3dBundle::default(),));
    // root node
    commands
        .spawn(NodeBundle {
            style: Style {
                width: Val::Percent(100.0),
                height: Val::Percent(100.0),
                justify_content: JustifyContent::SpaceBetween,
                ..default()
            },
            ..default()
        })
        .with_children(|parent| {
            parent.spawn(TextBundle::from_section(
                "Text Example",
                TextStyle {
                    font: asset_server.load("kenney_ui-pack/Font/kenvector_future.ttf"),
                    font_size: 30.0,
                    color: Color::WHITE,
                },
            ));
            parent
                .spawn((
                    NodeBundle {
                        style: Style {
                            width: Val::Px(500.0),
                            height: Val::Px(125.0),
                            margin: UiRect::top(Val::VMin(5.)),
                            ..default()
                        },
                        // a `NodeBundle` is transparent by default, so to see the image we have to its color to `WHITE`
                        background_color: Color::WHITE.into(),
                        ..default()
                    },
                    UiImage::new(asset_server.load("kenney_ui-pack/PNG/green_button00.png")),
                ))
                .with_children(|parent| {
                    // alt text
                    // This UI node takes up no space in the layout and the `Text` component is used by the accessiblity module
                    // and is not rendered.
                    parent.spawn((
                        NodeBundle {
                            style: Style {
                                display: Display::None,
                                ..Default::default()
                            },
                            ..Default::default()
                        },
                        Text::from_section("Bevy logo", TextStyle::default()),
                    ));
                });
        });
}

fn main() {
    App::new()
        .add_plugins(DefaultPlugins)
        .add_systems(Startup, setup)
        .add_systems(Update, bevy::window::close_on_esc)
        .run();
}
