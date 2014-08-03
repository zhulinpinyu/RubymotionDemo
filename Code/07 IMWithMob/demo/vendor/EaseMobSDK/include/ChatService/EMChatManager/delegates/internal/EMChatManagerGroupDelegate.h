/*!
 @header EMChatManagerUtilDelegate.h
 @abstract 此协议提供了一些群组操作的回调协议
 @author EaseMob Inc.
 @version 1.00 2014/01/01 Creation (1.00)
 */

#import <Foundation/Foundation.h>
#import "EMChatManagerDelegateBase.h"

@class EMGroup;

/*!
 @protocol
 @brief 此协议提供了一些群组操作的回调
 @discussion
 */
@protocol EMChatManagerGroupDelegate <EMChatManagerDelegateBase>

@optional

/*!
 @method
 @brief 创建一个群组后的回调
 @param group 所创建的群组对象
 @param error 错误信息
 @discussion
 */
- (void)group:(EMGroup *)group didCreateWithError:(EMError *)error;

/*!
 @method
 @brief 离开一个群组后的回调
 @param group  所要离开的群组对象
 @param reason 离开的原因
 @param error  错误信息
 @discussion
        离开的原因包含主动退出, 被别人请出, 和销毁群组三种情况
 */
- (void)group:(EMGroup *)group didLeave:(EMGroupLeaveReason)reason error:(EMError *)error;

/*!
 @method
 @brief 群组信息更新后的回调
 @param group 发生更新的群组
 @param error 错误信息
 @discussion
        当添加/移除/更改角色/更改主题/更改群组信息之后,都会触发此回调
 */
- (void)groupDidUpdateInfo:(EMGroup *)group error:(EMError *)error;

/*!
 @method
 @brief 收到了其它群组的加入邀请
 @param groupId  群组ID
 @param username 邀请人名称
 @param message  邀请信息
 @discussion
 */
- (void)didReceiveGroupInvitationFrom:(NSString *)groupId
                              inviter:(NSString *)username
                              message:(NSString *)message;

/*!
 @method
 @brief 接受群组邀请后的回调
 @param group 所接受的群组
 @param error 错误信息
 */
- (void)didAcceptInvitationFromGroup:(EMGroup *)group
                               error:(EMError *)error;

/*!
 @method
 @brief 邀请别人加入群组, 但被别人拒绝后的回调
 @param groupId  群组ID
 @param username 拒绝的人的用户名
 @param reason   拒绝理由
 */
- (void)didReceiveGroupRejectFrom:(NSString *)groupId
                          invitee:(NSString *)username
                           reason:(NSString *)reason;

/*!
 @method
 @brief 群组列表变化后的回调
 @param groupList 新的群组列表
 @param error     错误信息
 */
- (void)didUpdateGroupList:(NSArray *)groupList
                     error:(EMError *)error;

/*!
 @method
 @brief 获取所有公开群组后的回调
 @param groups 公开群组列表
 @param error  错误信息
 */
- (void)didFetchAllPublicGroups:(NSArray *)groups
                          error:(EMError *)error;

/*!
 @method
 @brief 获取群组信息后的回调
 @param group 群组对象
 @param error 错误信息
 */
- (void)didFetchGroupInfo:(EMGroup *)group
                    error:(EMError *)error;

/*!
 @method
 @brief 加入公开群组后的回调
 @param group 群组对象
 @param error 错误信息
 */
- (void)didJoinPublicGroup:(EMGroup *)group
                     error:(EMError *)error;

@end
