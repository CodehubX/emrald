Attribute VB_Name = "AboutMe"
'========================================================
'   Emerald
'   制作：Error 404（QQ 1361778219）
'   邮箱：ris_vb@126.com
'========================================================
'   版本：参见GCore.Version
'   面向游戏开发的轻量级绘图框架
'   Emerald的诞生，离不开朋友们和Inter.Net群的支持，感谢你们。
'   组成（标*号的表示非作者编写）：
'   ┗━━━━调试功能
'       ┗━━━━Debuginfo.frm：显示调试详细信息使用的窗口
'       ┗━━━━DebugWindow.frm：显示调试工具栏使用的窗口
'       ┗━━━━GDebug.cls：调试工具栏的界面绘制
'   ┗━━━━*BASS（http://www.un4seen.com/）
'       (BASS is an audio library for use in software on several platforms.)
'       ┗━━━━*Bass.bas：Bass API 声明模块
'       ┗━━━━GMusic.cls：Emerald封装的使用了Bass的音乐播放器
'       ┗━━━━GMusicList.cls：音乐列表，管理GMusic
'   ┗━━━━存档
'       ┗━━━━GSaving.cls：Emerald存档功能
'       ┗━━━━BMEA_Engine.bas：黑嘴加密算法（不可逆）
'   ┗━━━━绘制
'       ┗━━━━GMan.cls：页面管理器，游戏核心，支持页面过渡
'       ┗━━━━GPage.cls：游戏页面，包含常规图形的绘制
'       ┗━━━━GFont.cls：游戏字体绘制
'       ┗━━━━GResource.cls：游戏资源管理
'   ┗━━━━动画
'       ┗━━━━GAnimation.cls：Emerald常规动画函数
'   ┗━━━━碰撞箱
'       ┗━━━━GCrashBox.cls：碰撞箱功能
'   ┗━━━━*GDIPlus
'       ┗━━━━*Gdiplus.bas：vIstaswx GDI+ 声明模块
'   ┗━━━━其他
'       ┗━━━━*aShadow.cls：网上复制的窗口阴影类模块
'       ┗━━━━AeroEffect.bas：Aero效果
'       ┗━━━━GCore.bas：Emerald部分核心功能
'       ┗━━━━GSysPage.cls：Emerald页面的绘制
'       ┗━━━━EmeraldWindow.frm：显示Emerald信息使用的窗口
'========================================================
'   更新日志
'========================================================
'   更新内容(ver.1208)
'   -添加“花哨”模式
'   -添加页面切换（F11）
'   更新内容(ver.1118)
'   -添加界面缩放功能
'   更新内容(ver.1002)
'   -添加点击检测区域显示
'   -使部分动画更加流畅
'   更新内容(ver.1001)
'   -完善XP兼容性
'   -添加建议中心
'   更新内容(ver.930)
'   -兼容XP
'   更新内容(ver.730)
'   -最后一次维护
'   更新内容(ver.718)
'   -添加点击锁定
'   -安装包垃圾清理
'   -存档损坏提示
'   -修复存档不创建问题
'   -突出安装包的关闭按钮
'   更新内容(ver.712)
'   -修复动画问题
'   -更改启动动画
'   -新增两种过场动画
'   -修复模板问题
'   -新增打包功能
'   更新内容(ver.711)
'   -修复文本对齐问题
'   -全新Builder
'   -修正argb函数
'   -修复模板文件夹错误
'   -修复在自身文件夹打开的问题
'   更新内容(ver.710)
'   -修复动画问题
'   更新内容(ver.707)
'   -修复动画问题
'   -修复内存泄露的问题
'   -现在可以选择不加载图片的多个方向
'   -移除阴影
'   -控制台添加poolinfo指令
'   -添加图片旋转
'   更新内容(ver.706)
'   -现在碰撞地图可以选择不加载
'   -完善HotLoad模式
'   -MusicList加入HotLoad模式
'   -现在过大的图片不会加载碰撞地图
'   -修复高级动画无视dispose的问题
'   -修复高级动画不能dispose的问题
'   -修复高级动画指令不能连用的问题
'   -高级动画的绘制加入方向
'   更新内容(ver.704)
'   -安装包加入安装路径
'   -安装包加入创建快捷方式按钮
'   -卸载程序优化
'   -新增安装程序报告
'   更新内容(ver.703)
'   -修复存档覆盖错误
'   -修复命令行参数-focus为-force
'   -新增命令行指令：info
'   -修复资源重复加载问题
'   -修复自动化异常
'   -修复安装后的应用作者显示QQ 0的问题
'   -修复控制台错误
'   -修复控制台候选指令错误
'   -新增命令行指令：backup
'   -新增命令行指令：project
'   -Builder标题栏现在可以拖动
'   更新内容(ver.702)
'   -修复Timer绘图检测错误
'   -Debug栏显示极限FPS
'   -修复绘制中心错误的问题
'   -添加调试控制台
'   更新内容(ver.701)
'   -新增Github建议
'   更新内容(ver.630)
'   -音乐播放器现在可以获取播放状态
'   -修复资源树重复卸载导致崩溃的问题
'   -添加资源树检索开始标识
'   -现在可以为资源命名
'   -多边形添加平滑模式
'   -修复应用特效图片效果后图片点击检测失常的问题
'   更新内容(ver.629)
'   -新增PaintPolygon2方法
'   -修复Builder第一次创建工程忽略代码变化的问题
'   更新内容(ver.628)
'   -点击检测支持不规则图片
'   -碰撞检测支持可缩放图片
'   更新内容(ver.627)
'   -添加碰撞路径
'   更新内容(ver.625)
'   -完善文本框
'   -添加图片特效
'   -添加图片圆形裁剪
'   更新内容(ver.624)
'   -添加滑条
'   -修复文本框越界问题
'   -添加开发文档按钮
'   更新内容(ver.623)
'   -添加自动存档开关
'   -添加热加载模式
'   -添加文本框控件
'   -修复无法保存存档的问题
'   更新内容(ver.607)
'   -添加存档管理功能
'   -删去安装包的QQ
'   -不强制要求应用图标
'   -移除碰撞箱
'   -修改存档机制
'   -警告信息移位
'   更新内容(ver.606)
'   -修复设置问题
'   -修复安装包的标题不易阅读的问题
'   -修复界面上的一些语法错误
'   -修复安装程序打开时间过长的问题
'   -加入动画功能
'   更新内容(ver.601)
'   -Form引用修复
'   -显示新增代码的大小
'   -修复引用非vb代码的问题
'   -设置迁移
'   -修复Builder最小化后无法恢复的问题
'   -修改Bass的启动行为
'   -添加一键安装程序制作
'   -修复绘制不存在的图像的问题
'   更新内容(ver.531)
'   -移除工程组
'   -修复无法新建工程的问题
'   -Example.vbp移位
'   -修复卸载异常的问题
'   -修复工程代码更新的一些问题
'   -修复卸载时选择否导致的异常
'   -更改图标
'   -不再支持Windows XP
'   -添加Debug坐标中心显示
'   -绘图过程独立存放坐标
'   -显示更新代码大小变化
'   更新内容(ver.525)
'   -添加ColorCheckBox
'   -Builder自动添加代码引用
'   -添加图形翻转绘制
'   -添加代码备份
'   -修复debug不可用的问题
'   -缩短替换时间
'   -修复Builder检查更新问题
'   更新内容(ver.524)
'   -修复Builder更新问题
'   -修复Builder更新失败的问题
'   -添加Builder代码对比功能
'   -修复Builder停止工作的问题
'   -添加Builder关于页面
'   -添加Builder检查更新的功能
'   -添加Loading动画绘制
'   更新内容(ver.519)
'   -修复编译后分层窗口不可显示的问题
'   -修复DrawImage的动画问题
'   -全新Builder
'   更新内容(ver.518)
'   -添加分层绘制和亚克力效果
'   -修复无法编译的问题
'   -现在可以禁用开场LOGO
'   -添加置顶页面
'   更新内容(ver.511)
'   -修复代码更新问题
'   -画布清空机制修改
'   -现在Core.bas不会被覆盖
'   -现在活动页面被设置前不会离开启动LOGO页面
'   -添加转时间长度函数
'   -添加滚动条控件
'   -修复音乐播放器问题
'   -修复鼠标点击错误
'   -添加线条的绘制
'   -支持自定义GIF每帧间隔数
'   -平滑加载进度条
'   更新内容(ver.510)
'   -全新Builder UI
'   -修复窗口大小错误问题
'   -资源列表迁移到Page.Res
'   -修复资源树检查
'   更新内容(ver.503)
'   -AboutMe转移到Core
'   -添加多边形绘制
'   -更新优化
'   -窗口大小修正
'   -重复资源检查
'   -增加一点点建议
'   -添加控件绘制
'   -修复Builder安装错误的问题
'   更新内容(ver.502)
'   -修复更新问题和代码不可用问题
'   -Paint添加Pos参数
'   -添加PosAlign枚举
'   -添加弧形，扇形的绘制
'   -添加页面不存在提示
'   -添加Builder修复功能
'   -Debug栏添加ToolTip
'   -单独放置更新和开发者信息
'   更新内容(ver.501)
'   -添加IsKeyUp
'   -新增开场LOGO设置
'   -添加版本更新注意事项
'   -添加过场效果枚举
'   -修复部分字体样式不可用的问题
'   -添加版本更新检测
'   -现在新建工程时会自动创建好音乐列表
'   -添加动态频谱和新的例子
'   更新内容(ver.430)
'   -添加ImgCount，ImgSize
'   -添加启动页面
'   -添加资源加载进度条
'   -修复可以以非法字符开头创建工程的错误
'   -添加模板代码
'   -现在卸载过程中途发生错误会继续执行接下来的步骤
'   -修复按下关闭按钮默认选择确认的问题
'   更新内容(ver.427)
'   -修复Builder零错误问题
'   -修改图标使其能够被清晰地察觉
'   -现在在更新工程前需要更新Builder
'   -修复不能卸载的问题（Builder）
'   -注册软件信息（Builder）
'   -添加圆角矩形
'   -添加DrawImageEx
'   -新增Builder GUI
'   更新内容(ver.426)
'   -修复矩形边框柔和边缘的问题
'   -添加画笔大小
'   -现在授权界面可以使用鼠标
'   -添加鼠标枚举
'   -全新Debug界面
'   更新内容(ver.420)
'   -增加屏幕窗口
'   -修复矩形柔和边缘的问题
'   更新内容(ver.419)
'   -添加过程一键建立器
'   -修复滑轮方向错误的问题
'   -添加文件名检测（Builder）
'   -添加最新文件更新（Builder）
'   -现在可以卸载Builder
'   -现在Builder的提示文本是中文
'   -现在Builder默认需要管理员权限
'   更新内容(ver.329)
'   -添加碰撞箱
'   -添加调试功能
'   更新内容(ver.324)
'   -完善动画
'   -修复paint动画异常的问题
'   -添加动画播放完成的事件
'   -添加动画延迟属性
'   更新内容(ver.323)
'   -DPI适应
'   -鼠标滚轮支持
'   更新内容(ver.317)
'   -新增窗口失焦和取得焦点事件
'   更新内容(ver.316)
'   -修复卷轴模式的一些问题
'   -新增6种过场特效
'   -新增动画
'   -新增页面切换事件
'   更新内容(ver.315)
'   -新增卷轴模式
'   -现在可以检测键盘按下
'   -现在支持动态GIF图片
'   -新增四种过场特效
'   更新日志(ver.211)
'   -添加窗口模糊方法（Blurto）
'========================================================
