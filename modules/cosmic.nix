{ config, pkgs, ... }:

{
  xdg.configFile = {
    # Включение автоматического тайлинга окон
    "cosmic/com.system76.CosmicComp/v1/autotile".text = "true";

    # Поведение тайлинга (индивидуально для каждого рабочего стола)
    "cosmic/com.system76.CosmicComp/v1/autotile_behavior".text = "PerWorkspace";

    # Настройки рабочих столов
    "cosmic/com.system76.CosmicComp/v1/workspaces".text = ''
      (
          workspace_mode: OutputBound,
          workspace_layout: Vertical,
          action_on_typing: r#None,
          workspace_wraparound: true,
      )
    '';

    # Настройки клавиатуры и переключения раскладки
    "cosmic/com.system76.CosmicComp/v1/xkb_config".text = ''
      (
          rules: "",
          model: "",
          layout: "us,ru",
          variant: ",",
          options: None,
          repeat_delay: 600,
          repeat_rate: 25,
      )
    '';

    # Настройки горячих клавиш
    "cosmic/com.system76.CosmicSettings.Shortcuts/v1/custom".text = ''
{
    (
        modifiers: [
            Super,
        ],
        key: "s",
    ): Focus(Down),
    (
        modifiers: [
            Super,
        ],
        key: "l",
    ): System(LockScreen),
    (
        modifiers: [
            Super,
            Shift,
        ],
        key: "Right",
    ): Disable,
    (
        modifiers: [
            Super,
            Shift,
        ],
        key: "a",
    ): Move(Left),
    (
        modifiers: [
            Ctrl,
        ],
        key: "Escape",
    ): System(Terminal),
    (
        modifiers: [
            Super,
        ],
        key: "Escape",
    ): Disable,
    (
        modifiers: [],
        key: "Print",
    ): Disable,
    (
        modifiers: [
            Super,
        ],
        key: "m",
    ): Disable,
    (
        modifiers: [
            Super,
        ],
        key: "Left",
    ): Disable,
    (
        modifiers: [
            Super,
        ],
        key: "Up",
    ): Disable,
    (
        modifiers: [
            Super,
            Shift,
        ],
        key: "Down",
    ): Disable,
    (
        modifiers: [
            Super,
            Shift,
        ],
        key: "Up",
    ): Disable,
    (
        modifiers: [
            Super,
        ],
        key: "a",
    ): Focus(Left),
    (
        modifiers: [
            Ctrl,
            Alt,
        ],
        key: "p",
    ): System(Screenshot),
    (
        modifiers: [
            Super,
        ],
        key: "w",
    ): Focus(Up),
    (
        modifiers: [
            Super,
        ],
        key: "e",
    ): System(HomeFolder),
    (
        modifiers: [
            Super,
            Shift,
        ],
        key: "d",
    ): Move(Right),
    (
        modifiers: [
            Super,
        ],
        key: "d",
    ): Focus(Right),
    (
        modifiers: [
            Super,
            Shift,
        ],
        key: "w",
    ): Move(Up),
    (
        modifiers: [
            Super,
        ],
        key: "Down",
    ): Disable,
    (
        modifiers: [
            Super,
        ],
        key: "f",
    ): ToggleWindowFloating,
    (
        modifiers: [
            Super,
        ],
        key: "Right",
    ): Disable,
    (
        modifiers: [
            Super,
            Shift,
        ],
        key: "Left",
    ): Disable,
    (
        modifiers: [
            Super,
        ],
        key: "t",
    ): ToggleStacking,
    (
        modifiers: [
            Super,
            Shift,
        ],
        key: "s",
    ): Move(Down),
    (
        modifiers: [
            Super,
        ],
        key: "g",
    ): Disable,
}
    '';

    # Системные действия
    "cosmic/com.system76.CosmicSettings.Shortcuts/v1/system_actions".text = ''
      {
          Terminal: "alacritty",
      }
    '';

    # Настройка апплетов
    "cosmic/com.system76.CosmicPanel/v1/entries".text = ''
      [
          "Panel",
      ]
    '';
    
    # Настройки Главной Панели (Статус-бар)
    "cosmic/com.system76.CosmicPanel.Panel/v1/anchor".text = "Left";
    "cosmic/com.system76.CosmicPanel.Panel/v1/anchor_gap".text = "false";
    "cosmic/com.system76.CosmicPanel.Panel/v1/autohide".text = "None";
    "cosmic/com.system76.CosmicPanel.Panel/v1/autohover_delay_ms".text = "Some(500)";
    "cosmic/com.system76.CosmicPanel.Panel/v1/background".text = "ThemeDefault";
    "cosmic/com.system76.CosmicPanel.Panel/v1/border_radius".text = "0";
    "cosmic/com.system76.CosmicPanel.Panel/v1/exclusive_zone".text = "true";
    "cosmic/com.system76.CosmicPanel.Panel/v1/expand_to_edges".text = "true";
    "cosmic/com.system76.CosmicPanel.Panel/v1/keyboard_interactivity".text = "OnDemand";
    "cosmic/com.system76.CosmicPanel.Panel/v1/layer".text = "Top";
    "cosmic/com.system76.CosmicPanel.Panel/v1/margin".text = "0";
    "cosmic/com.system76.CosmicPanel.Panel/v1/name".text = "\"Panel\"";
    "cosmic/com.system76.CosmicPanel.Panel/v1/opacity".text = "1.0";
    "cosmic/com.system76.CosmicPanel.Panel/v1/output".text = "All";
    "cosmic/com.system76.CosmicPanel.Panel/v1/padding".text = "0";
    "cosmic/com.system76.CosmicPanel.Panel/v1/padding_overlap".text = "0.5";
    "cosmic/com.system76.CosmicPanel.Panel/v1/size".text = "XS";
    "cosmic/com.system76.CosmicPanel.Panel/v1/size_center".text = "None";
    "cosmic/com.system76.CosmicPanel.Panel/v1/size_wings".text = "None";
    "cosmic/com.system76.CosmicPanel.Panel/v1/spacing".text = "0";
    
    "cosmic/com.system76.CosmicPanel.Panel/v1/plugins_center".text = ''
      Some([
          "com.system76.CosmicAppletTime",
      ])
    '';
    
    "cosmic/com.system76.CosmicPanel.Panel/v1/plugins_wings".text = ''
      Some(([
          "com.system76.CosmicPanelAppButton",
          "com.system76.CosmicAppletWorkspaces",
      ], [
          "com.system76.CosmicAppletInputSources",
          "com.system76.CosmicAppletStatusArea",
          "com.system76.CosmicAppletTiling",
          "com.system76.CosmicAppletAudio",
          "com.system76.CosmicAppletNetwork",
          "com.system76.CosmicAppletNotifications",
          "com.system76.CosmicAppletPower",
      ]))
    '';
  };
}
