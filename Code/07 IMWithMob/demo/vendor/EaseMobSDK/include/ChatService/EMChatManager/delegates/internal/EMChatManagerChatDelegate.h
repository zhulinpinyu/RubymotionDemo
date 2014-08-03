/*!
 @header EMChatManagerChatDelegate.h
 @abstract 关于ChatManager中聊天相关功能的异步回调
 @author EaseMob Inc.
 @version 1.00 2014/01/01 Creation (1.00)
 */

#import <Foundation/Foundation.h>
#import "EMChatManagerDelegateBase.h"

@class EMMessage;
@class EMConversation;
@class EMError;
@class EMReceiptReq;
@class EMReceiptResp;

/*!
 @protocol
 @brief 本协议包括：发送消息时的回调、接收到消息时的回调等其它操作
 @discussion
 */
@protocol EMChatManagerChatDelegate <EMChatManagerDelegateBase>

@optional

/*!
 @method
 @brief 将要发送消息时的回调
 @discussion
 @param message      将要发送的消息对象
 @param error        错误信息
 @result
 */
- (void)willSendMessage:(EMMessage *)message
                 error:(EMError *)error;

/*!
 @method
 @brief 发送消息后的回调
 @discussion
 @param message      已发送的消息对象
 @param error        错误信息
 @result
 */
- (void)didSendMessage:(EMMessage *)message
                error:(EMError *)error;

/*!
 @method
 @brief 收到消息时的回调
 @param message      消息对象
 @discussion 当EMConversation对象的enableReceiveMessage属性为YES时, 会触发此回调
             针对有附件的消息, 此时附件还未被下载.
             附件下载过程中的进度回调请参考didFetchingMessageAttachments:progress:, 
             下载完所有附件后, 回调didMessageAttachmentsStatusChanged:error:会被触发
 */
- (void)didReceiveMessage:(EMMessage *)message;

/*!
 @method
 @brief SDK接收到消息时, 下载附件的进度回调, 回调方法有不在主线程中调用, 需要App自己切换到主线程中执行UI的刷新等操作
 @discussion SDK接收到消息时, 有以下两种情况:
    1. 如果是带缩略图的消息时(图片或Video), 会自动下载缩略图, 
        下载完成后, 会调用 didMessageAttachmentsStatusChanged:error这个回调
    2. 如果是语音消息时, 会自动下载语音附件, 
        会调用 didMessageAttachmentsStatusChanged:error这个回调
 @param message  正在下载的消息对象
 @param progress 下载进度
 @result
 */
- (void)didFetchingMessageAttachments:(EMMessage *)message
                            progress:(float)progress;

/*!
 @method
 @brief SDK接收到消息时, 下载附件成功或失败的回调
 @discussion SDK接收到消息时, 有以下两种情况:
     1. 如果是带缩略图的消息时(图片或Video), 会自动下载缩略图,
     2. 如果是语音消息时, 会自动下载语音附件,
 @param message  下载完成的消息对象
 @param error    若附件下载成功, error为nil, 若下载失败, 则会返回相应的error信息
 @result
 */
- (void)didMessageAttachmentsStatusChanged:(EMMessage *)message error:(EMError *)error;

/*!
 @method
 @brief 收到"已读回执"时的回调方法
 @discussion 发送方收到接收方发送的一个收到消息的回执, 意味着接收方已阅读了该消息
 @param resp 收到的"已读回执"对象, 包括 from, to, chatId等
 @result
 */
- (void)didReceiveHasReadResponse:(EMReceiptResp *)resp;

/*!
 @method
 @brief 会话列表信息更新时的回调
 @discussion 1. 当会话列表有更改时(新添加,删除), 2. 登陆成功时, 以上两种情况都会触发此回调
 @param conversationList 会话列表
 @result
 */
- (void)didUpdateConversationList:(NSArray *)conversationList;

/*!
 @method
 @brief 未读消息数改变时的回调
 @discussion 当EMConversation对象的enableUnreadMessagesCountEvent为YES时,会触发此回调
 @result
 */
- (void)didUnreadMessagesCountChanged;

@end
