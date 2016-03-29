//
//  UserProtolViewController.m
//  YOU WATCH－Auction
//
//  Created by zhaoyue on 15/7/27.
//  Copyright (c) 2015年 葛宾霞151. All rights reserved.
//

#import "UserProtolViewController.h"
#import "ZYControl.h"
#import "AOColorFormat.h"
#import "SettingViewController.h"
@interface UserProtolViewController ()<UITextFieldDelegate>

@end

@implementation UserProtolViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"用户协议";
    [self createTabItemLeftButton];
    [self createTextView];
}
-(void)createTabItemLeftButton
{
    UIButton *leftButton = [ZYControl createButtonWithFrame:CGRectMake(15,24,9,17) ImageName:@"返回@2x.png" Target:self Action:@selector(leftButtonClick:) Title:nil];
    self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc]initWithCustomView:leftButton];
    
}

-(void)leftButtonClick:(UIButton *)leftButton
{
    for (UIViewController *vc in self.navigationController.viewControllers) {
        if ([vc isKindOfClass:[SettingViewController class]]) {
            
            SettingViewController *aucitonVC = (SettingViewController *)vc;
            
            aucitonVC.tabBarController.tabBar.hidden = NO;
            
            [self.navigationController popToViewController:aucitonVC animated:YES];
        }else
        {
            [self.navigationController popViewControllerAnimated:YES];
        }
    }

    
}

-(void)createTextView
{
    UITextView *textview = [[UITextView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    textview.text = @"在接受本协议之前，请您仔细阅读本协议的全部内容。如果您对本协议的条款有疑问的，请通过拍大牌客服渠道进行询问，拍大牌将向您解释条款内容。除非您已阅读并接受本协议的所有条款，否则您无权下载、安装、使用、登陆本软件，您的下载、安装、使用、登陆等信行为即视为您已阅读并同意本协议的约束。\n 第一条：签约主体 \n 1.1、本协议由拍大牌与参与竞拍的用户(以下简称“竞买人”或“您”)签署。\n 第二条：协议范围 \n 2.1、本协议是您与拍大牌之间关于下载、安装、使用、复制本软件，以及使用拍大牌相关服务所订立的协议。\n 2.2、您通过拍大牌注册页面确认选择接受本协议，即表示您与拍大牌达成并协议并同意接受协议的全部约定，协议即时生效。\n 2.3、本协议内容包括协议正文、附件、以及所有拍大牌已经发布或将来可能发布的各类规则、操作流程。所有规则为协议不可分割的一部分，与协议正文具有同等法律效力。拍大牌有权需要不时地制定、修改本协议、附件或者各类规则、操作流程，如有任何变更，拍大牌将会以公示的形式通知您。如果您据需参与使用本软件参与竞拍，则视为您对修改后的条款不持异议并同意遵守。\n 第三条：软件获取和更新 \n 3.1 、你可以直接从拍大牌的网站上获取本软件，也可以从得到拍大牌授权的第三方获取。\n 3.2 、如果你从未经拍大牌授权的第三方获取本软件或与本软件名称相同的安装程序，拍大牌无法保证该软件能够正常使用，并对因此给你造成的损失不予负责。\n 3.3 、为了改善用户体验、完善服务内容，拍大牌将不断努力开发新的服务，并为你不时提供软件更新（这些更新可能会采取软件替换、修改、功能强化、版本升级等形式）。\n 3.4、为了保证本软件及服务的安全性和功能的一致性，拍大牌有权不经向你特别通知而对软件进行更新，或者对软件的部分功能效果进行改变或限制。\n 3.5、 本软件新版本发布后，旧版本的软件可能无法使用。拍大牌不保证旧版本软件继续可用及相应的客户服务，请你随时核对并下载最新版本。\n 第四条：软件的安装与卸载 \n 4.1、拍大牌可能为不同的终端设备开发了不同的软件版本，你应当根据实际情况选择下载合适的版本进行安装。\n 4.2、卸载安装程序后，你需要按照该程序提示的步骤正确安装。\n 4.3 、为提供更加优质、安全的服务，在本软件安装时拍大牌可能推荐你安装其他软件，你可以选择安装或不安装。\n 4.4 、如果你不再需要使用本软件或者需要安装新版软件，可以自行卸载。如果你愿意帮助拍大牌改进产品服务，请告知卸载的原因。\n 第五条：定义 \n 5.1、拍卖：是指拍卖商以拍卖方式发布拍品，采用公开竞价形式，由竞拍成功者最终获得拍品的交易方式。\n 5.2、送拍人：即本协议项下的“拍卖商”，指依据《中华人民共和国拍卖法》相关规定设立的从事拍卖活动的企业法人。 \n 5.3、竞买人：指参加在拍卖活动现场或是通过同步拍卖线上环境参与拍卖标的竞价的公民、法人或者其他组织。本协议项下的买家即为网络竞买人。\n 5.4、网络出价：指通过同步拍卖在拍大牌平台线上参与竞拍的竞买人的竞买报价。\n 5.5、竞拍成功者：指竞拍中获胜，最终有权购得拍品的竞买人。\n 第六条：参与竞卖人条件 \n 6.1、其已确认接受拍大牌拍卖用户许可；\n 6.2、其账户中有足够余额可以缴纳拍卖保证金，并在同步拍卖的拍品正式开拍前完成上述保证金的止付锁定操作；\n 6.3、拍大牌未拒绝其参与竞拍的申请。\n 第七条：竞买人义务\n 7.1、您应当按照本协议、附件、拍大牌发布的拍卖活动公告及须知，以及所有拍大牌已经发布的或将来可能发布的各类规则、操作流程参与竞拍，遵守相关出价、获得拍品、成交价格、拍卖保证金止付锁定/释放/赔付等各类规定。\n 7.2、您确认，因拍卖活动须向有关工商行政管理部门申报并提供竞买人（含所有参与竞拍的竞买人）的相关身份信息，您同意将您的身份信息（包含但不限于姓名、身份证件号码、住址等）提供给拍卖商用于拍向工商行政管理部门申报，具体提供方式为：在您签署本协议后，在网络页面中填写相关身份信息。\n 第八条：竞买人竞拍不买的责任 \n 8.1、竞拍成功后，竞买人须按照规定完成交易，不得竞拍不买。竞买人若发生以下任一情形，将视为竞拍不买，但买卖双方另有约定或拍卖商原因导致的除外：\n 8.2、在竞拍结束之时起的72小时内，拒绝按照成交价格支付拍品货款；\n 8.3、在竞拍成功且付款后，竞买人申请退款（拍品支持7天无理由退货除外）。\n 8.4、为了维护拍大牌的拍卖交易秩序，防止竞买人恶拍，尽量避免并妥善处理买卖双方之间的交易纠纷，您参与竞拍时止付锁定的保证金将为本次竞拍提供保障。如您出现竞拍不买行为，您同意拍大牌有权扣除您的拍卖保证金用于赔付拍卖商；且拍大牌仍有权按照相关规则的规定对您进行处理。\n •第九条：协议终止 \n 9.1、本协议在符合以下任意一项情形时终止：\n 9.2、竞买人未竞拍成功的，本协议自保证金释放之时起终止；\n 9.3、竞买人竞拍成功且未出现竞拍不买情形的，本协议自交易成功之时起终止；\n 9.4、竞买人竞拍成功且拍卖商在竞买人付款前关闭交易订单的，本协议自订单关闭且保证金释放之时起终止；\n 9.5、本协议（含规则）调整时，您明示并通知拍大牌不愿接受新的协议内容，则本协议自拍大牌收到您通知之日起终止；\n 9.6、拍大牌有权提前15天（15）天以书面通知的方式终止本协议；\n 9.7、其他协议终止条件发生或实现，导致本协议终止。\n •第十条：隐私政策 \n 10.1、保护用户个人信息是拍大牌的基本原则，我们将会采取合理的措施保护用户的个人信息。除法律法规规定的情形外，未经用户许可拍大牌不会向第三方公开、透露用户个人信息。拍大牌对相关信息采用专业加密存储与传输方式，保障用户个人信息的安全。\n 10.2、您在注册帐号或使用本服务的过程中，需要提供一些必要的信息，例如：为向你提供帐号注册服务或进行用户身份识别，需要您填写手机号码；竞拍成功后需要您提供相应邮寄的地址等。若您提供的信息不完整，则无法使用竞卖服务或在使用过程中受到限制。）的考虑，你可能无法修改注册时提供的初始注册信息及其他验证信息。\n 10.3、拍大牌将运用各种安全技术和程序建立完善的管理制度来保护你的您人信息，以免遭受未经授权的访问、使用或披露。\n 10.4、未经您的同意，拍大牌不会向拍大牌以外的任何公司、组织和个人披露您的个人信息，但法律法规另有规定的除外。\n 第十一条：免责及有限责任 \n 11.1、拍大牌将在现有技术的基础上尽最大努力提供平台相应的安全措施以保障服务安全和正常运行。但由于可能存在的计算机病毒、网络通讯故障、系统维护等方面的因素以及可能发生的不可抗力事件，拍大牌在此明确声明对技术服务不作任何明示或暗示的保证，包括但不限于对服务的可适用性、没有错误或疏漏、持续性、准确性、可靠性、适用于某一特定用途。对此竞买人予以理解并不应要求拍大牌在以下情况下承担责任：\n 11.2、系统停机维护；\n 11.3、通讯终端或电信设备出现故障不能进行数据传输的；\n 11.4、因台风、地震、海啸、洪水、停电、战争、恐怖袭击等不可抗力之因素，造成系统障碍不能提供服务的；\n 11.5、由于黑客攻击、电信部门技术调整或故障、网站升级、第三方问题等原因而造成的服务中断或者延迟。\n 第十二条：其他约定 \n 12.1、本协议适用中华人民共和国大陆地区法律。\n 12.2、因拍大牌与竞买人就本协议的签订、履行或解释发生争议，双方应努力友好协商解决。如协商不成，拍大牌和竞买人同意由拍大牌住所地法院管辖审理双方的纠纷或争议。";
    textview.textColor = [UIColor blueColor];
    textview.font = [UIFont systemFontOfSize:16];
    textview.editable = NO;
    [self.view addSubview:textview];

}


@end
