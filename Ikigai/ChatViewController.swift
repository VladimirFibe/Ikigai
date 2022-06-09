//
//  ChatViewController.swift
//  Ikigai
//
//  Created by Икигай on 09.06.2022.
// https://messagekit.github.io
import SwiftUI
import InputBarAccessoryView
import UIKit
import MessageKit
struct Sender: SenderType {
  var senderId: String
  var displayName: String
}
struct Message: MessageType {
  var sender: MessageKit.SenderType
  var messageId: String
  var sentDate: Date
  var kind: MessageKit.MessageKind
}
class ChatViewController: MessagesViewController, MessagesDataSource, MessagesLayoutDelegate, MessagesDisplayDelegate {
  
  lazy var messages = [
    Message(sender: me,
            messageId: UUID().uuidString,
            sentDate: Date().addingTimeInterval(-90000),
            kind: .text("Привет")),
    Message(sender: she,
            messageId: UUID().uuidString,
            sentDate: Date().addingTimeInterval(-80000),
            kind: .text("Здравствуй")),
    Message(sender: me,
            messageId: UUID().uuidString,
            sentDate: Date().addingTimeInterval(-70000),
            kind: .text("Как делишки ?")),
    Message(sender: she,
            messageId: UUID().uuidString,
            sentDate: Date().addingTimeInterval(-60000),
            kind: .text("Не смею жаловаться, а твои ?")),
    Message(sender: me,
            messageId: UUID().uuidString,
            sentDate: Date().addingTimeInterval(-50000),
            kind: .text("Тоже нормально")),
    Message(sender: me,
            messageId: UUID().uuidString,
            sentDate: Date().addingTimeInterval(-40000),
            kind: .text("Она смотрела на экран и старалась прочесть что-то родное для сердца между строк. А он писал и она отвечала,но это был разговор двух чужих людей.Её это пугало,как так можно,ведь есть ещё любовь и есть чувства?!Он ей казался хмурым и чужим,сердце сжималось и хотелось плакать,но она не могла себе этого позволить.Она должна была быть сильной,не она первая и не последняя.")),
  ]
  let me = Sender(senderId: "me", displayName: "Владимир")
  let she = Sender(senderId: "she", displayName: "Маша")
  
  override func viewDidLoad() {
    super.viewDidLoad()
    messageInputBar.delegate = self
    messagesCollectionView.messagesDataSource = self
    messagesCollectionView.messagesLayoutDelegate = self
    messagesCollectionView.messagesDisplayDelegate = self
    removeMessageAvatars()
  }
  
  func currentSender() -> MessageKit.SenderType {
    me
  }
  
  func messageForItem(at indexPath: IndexPath, in messagesCollectionView: MessageKit.MessagesCollectionView) -> MessageKit.MessageType {
    messages[indexPath.section]
  }
  
  func numberOfSections(in messagesCollectionView: MessageKit.MessagesCollectionView) -> Int {
    messages.count
  }
  
  func messageTopLabelAttributedText(for message: MessageType, at indexPath: IndexPath) -> NSAttributedString? {
    let name = message.sender.displayName
    return NSAttributedString(string: name, attributes: [
      .font: UIFont.preferredFont(forTextStyle: .caption1),
      .foregroundColor: UIColor(white: 0.3, alpha: 1)
    ])
  }
  
  func footerViewSize(
    for message: MessageType,
    at indexPath: IndexPath,
    in messagesCollectionView: MessagesCollectionView
  ) -> CGSize {
    return CGSize(width: 0, height: 8)
  }
  
  func messageTopLabelHeight(
    for message: MessageType,
    at indexPath: IndexPath,
    in messagesCollectionView: MessagesCollectionView
  ) -> CGFloat {
    return 20
  }
  
//  func backgroundColor(
//    for message: MessageType,
//    at indexPath: IndexPath,
//    in messagesCollectionView: MessagesCollectionView
//  ) -> UIColor {
//    return isFromCurrentSender(message: message) ? .green : .systemGray6
//  }
  
  func shouldDisplayHeader(
    for message: MessageType,
    at indexPath: IndexPath,
    in messagesCollectionView: MessagesCollectionView
  ) -> Bool {
    return false
  }
  
  func configureAvatarView(
    _ avatarView: AvatarView,
    for message: MessageType,
    at indexPath: IndexPath,
    in messagesCollectionView: MessagesCollectionView
  ) {
    avatarView.isHidden = true
  }
  
  func messageStyle(
    for message: MessageType,
    at indexPath: IndexPath,
    in messagesCollectionView: MessagesCollectionView
  ) -> MessageStyle {
    let corner: MessageStyle.TailCorner =
    isFromCurrentSender(message: message) ? .bottomRight : .bottomLeft
    return .bubbleTail(corner, .curved)
  }
  
  private func removeMessageAvatars() {
    guard let layout = messagesCollectionView.collectionViewLayout as? MessagesCollectionViewFlowLayout
    else { return }
    layout.textMessageSizeCalculator.outgoingAvatarSize = .zero
    layout.textMessageSizeCalculator.incomingAvatarSize = .zero
    layout.setMessageIncomingAvatarSize(.zero)
    layout.setMessageOutgoingAvatarSize(.zero)
    let incomingLabelAlignment = LabelAlignment(
      textAlignment: .left,
      textInsets: UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 0))
    layout.setMessageIncomingMessageTopLabelAlignment(incomingLabelAlignment)
    let outgoingLabelAlignment = LabelAlignment(
      textAlignment: .right,
      textInsets: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 15))
    layout.setMessageOutgoingMessageTopLabelAlignment(outgoingLabelAlignment)
  }
}


// MARK: - InputBarAccessoryViewDelegate
extension ChatViewController: InputBarAccessoryViewDelegate {
  func inputBar(_ inputBar: InputBarAccessoryView, didPressSendButtonWith text: String) {
    let message = Message(sender: me, messageId: UUID().uuidString, sentDate: Date(), kind: .text(text)) //Message(user: me, content: text)
    messages.append(message)
    messagesCollectionView.reloadData()
    
//    if messages.contains(message) {
//      return
//    }
//
//    messages.append(message)
//    messages.sort()
//
//    let isLatestMessage = messages.firstIndex(of: message) == (messages.count - 1)
//    let shouldScrollToBottom = messagesCollectionView.isAtBottom && isLatestMessage
//
//    messagesCollectionView.reloadData()
//
//    if shouldScrollToBottom {
//      messagesCollectionView.scrollToLastItem(animated: true)
//    }
    inputBar.inputTextView.text = ""
  }
}

// MARK: - Preview
struct SwiftUIViewController: UIViewControllerRepresentable {
  typealias UIViewControllerType = ChatViewController
  
  func makeUIViewController(context: Context) -> UIViewControllerType {
    let viewController = UIViewControllerType()
    return viewController
  }
  
  func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
    
  }
}

struct ViewController_Previews: PreviewProvider {
  static var previews: some View {
    SwiftUIViewController()
      .edgesIgnoringSafeArea(.all)
  }
}
