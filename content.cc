#include "content.hh"

Content::Content(Game *game, QWidget *parent): QWidget(parent), m_game(game)
{
  ui.setupUi(this);
  QHBoxLayout *layoutHuman = new QHBoxLayout(ui.humanFrame);
  m_humanBoard = new BoardView(m_game->human(), true);
  layoutHuman->addWidget(m_humanBoard);
  QHBoxLayout *layoutComputer = new QHBoxLayout(ui.computerFrame);
  m_computerBoard = new BoardView(m_game->computer(), false);
  layoutComputer->addWidget(m_computerBoard);
  connect(m_computerBoard, SIGNAL(computerMove()), this, SLOT(computerMove()));
}

void Content::setGame(Game *game)
{
  m_game = game;
  m_humanBoard->setBoard(game->human());
  m_computerBoard->setBoard(game->computer());
}

void Content::computerMove(void)
{
  if (m_game->computer()->defeated()) {
    emit message("HUMAN WINS!!!");
  } else {
    m_game->computerMove();
    m_humanBoard->update();
    if (m_game->human()->defeated()) {
      emit message("COMPUTER WINS!!!");
    };
  };
}

