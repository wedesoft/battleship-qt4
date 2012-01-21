#include "gamewindow.hh"

GameWindow::GameWindow(void)
{
  m_game = new Game;
  ui.setupUi(this);
  QHBoxLayout *layoutHuman = new QHBoxLayout(ui.humanFrame);
  m_humanBoard = new BoardView(m_game->human(), true);
  layoutHuman->addWidget(m_humanBoard);
  QHBoxLayout *layoutComputer = new QHBoxLayout(ui.computerFrame);
  m_computerBoard = new BoardView(m_game->computer(), false);
  layoutComputer->addWidget(m_computerBoard);
  connect(ui.actionNewGame, SIGNAL(triggered()), this, SLOT(restart()));
  connect(ui.actionQuit, SIGNAL(triggered()), this, SLOT(close()));
  connect(ui.startButton, SIGNAL(clicked()), this, SLOT(startGame()));
  connect(m_humanBoard, SIGNAL(message(QString)), this, SLOT(status(QString)));
  connect(m_computerBoard, SIGNAL(computerMove()), this, SLOT(computerMove()));
}

GameWindow::~GameWindow(void)
{
  delete m_game;
}

void GameWindow::restart(void)
{
  delete m_game;
  m_game = new Game;
  m_humanBoard->setBoard(m_game->human());
  m_computerBoard->setBoard(m_game->computer());
  ui.startButton->setEnabled(true);
}

void GameWindow::startGame(void)
{
  m_game->setPlacing(false);
  ui.startButton->setEnabled(false);
};

void GameWindow::computerMove(void)
{
  if (m_game->computer()->defeated()) {
    status("HUMAN WINS!!!");
  } else {
    m_game->computerMove();
    m_humanBoard->update();
    if (m_game->human()->defeated()) {
      status("COMPUTER WINS!!!");
    };
  };
}

void GameWindow::status(QString text)
{
  statusBar()->showMessage(text, DELAY);
}

