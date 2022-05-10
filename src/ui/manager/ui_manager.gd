extends Node

@onready var states: Dictionary = {
	"splash_screen": $States/Screens/SplashScreen,
	"main_screen": $States/Screens/MainScreen,
	"pause_screen": $States/Screens/PauseScreen,
	
	"main_menu": $States/Menus/MainMenu,
	"play_menu": $States/Menus/PlayMenu,
	"settings_menu": $States/Menus/SettingsMenu,
	"pause_menu": $States/Menus/PauseMenu,
	"quit_menu": $States/Menus/QuitMenu,
}
@onready var state_machine: StateMachine = $StateMachine


func _ready() -> void:
	state_machine.states = states

func _process(delta: float) -> void:
	state_machine.process(delta)

func _physics_process(delta: float) -> void:
	state_machine.physics_process(delta)

func _input(event: InputEvent) -> void:
	state_machine.input(event)
