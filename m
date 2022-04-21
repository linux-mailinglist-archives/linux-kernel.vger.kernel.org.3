Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 462DF50985A
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 09:05:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385267AbiDUGuf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 02:50:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1385407AbiDUGrs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 02:47:48 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 961062666
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 23:44:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650523494; x=1682059494;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=/oKD/voQRMoCzUrKHuGdW9n3YlCf8ApRcVIjhxXFbNs=;
  b=jhrz4PSVk4TIpJqvuMLns/mnpYwrV+iyebIZuigTvZfAVwNxzDzEJ7Bc
   aXVUtp/5Mw9oxlXSN9PBsdPN6FSXDCQOwBzhGMWFJ6jcmFXMjM1BZi8Vd
   zv0CS5R9hS3QLMRKIBJGd981HtJT1tzPs7zQRI2gLr88PEdT384xwSUpr
   XBFqk/w7Sdw2A0KCg7pTSFXoABSWhKcMNJcgNzFstGwOtCbTscgKNcbdc
   QU3S6dY4J1EYpV5n2gSswUHDwrIdCq6zKIy1fD9e46TwmLJRB6XzMLxBi
   hK3os9zwj5Bc4j0VebroN2jvIdvkYDcU5zG2DJeBoisoQJKRJyJIEMfYI
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10323"; a="324700686"
X-IronPort-AV: E=Sophos;i="5.90,278,1643702400"; 
   d="scan'208";a="324700686"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2022 23:44:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,278,1643702400"; 
   d="scan'208";a="614758664"
Received: from lkp-server01.sh.intel.com (HELO 3abc53900bec) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 20 Apr 2022 23:44:52 -0700
Received: from kbuild by 3abc53900bec with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nhQYd-00081p-EO;
        Thu, 21 Apr 2022 06:44:51 +0000
Date:   Thu, 21 Apr 2022 14:44:29 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Daniel J. Ogorchock" <djogorchock@gmail.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Jiri Kosina <jkosina@suse.cz>
Subject: drivers/hid/hid-nintendo.c:403:29: warning: unused variable
 'JC_RUMBLE_ZERO_AMP_PKT_CNT'
Message-ID: <202204211058.3UoweQuz-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daniel,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   b253435746d9a4a701b5f09211b9c14d3370d0da
commit: dad74e18f72a852ae40ad7b4246841a1b7e196b5 HID: nintendo: prevent needless queueing of the rumble worker
date:   6 months ago
config: s390-randconfig-c005-20220420 (https://download.01.org/0day-ci/archive/20220421/202204211058.3UoweQuz-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project bac6cd5bf85669e3376610cfc4c4f9ca015e7b9b)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install s390 cross compiling tool for clang build
        # apt-get install binutils-s390x-linux-gnu
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=dad74e18f72a852ae40ad7b4246841a1b7e196b5
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout dad74e18f72a852ae40ad7b4246841a1b7e196b5
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=s390 SHELL=/bin/bash drivers/gpu/drm/amd/amdgpu/ drivers/gpu/drm/amd/display/dc/ drivers/hid/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

                   ^
   drivers/hid/hid-nintendo.c:51:17: warning: unused variable 'JC_SUBCMD_STATE' [-Wunused-const-variable]
   static const u8 JC_SUBCMD_STATE                 /*= 0x00*/;
                   ^
   drivers/hid/hid-nintendo.c:52:17: warning: unused variable 'JC_SUBCMD_MANUAL_BT_PAIRING' [-Wunused-const-variable]
   static const u8 JC_SUBCMD_MANUAL_BT_PAIRING     = 0x01;
                   ^
   drivers/hid/hid-nintendo.c:55:17: warning: unused variable 'JC_SUBCMD_TRIGGERS_ELAPSED' [-Wunused-const-variable]
   static const u8 JC_SUBCMD_TRIGGERS_ELAPSED      = 0x04;
                   ^
   drivers/hid/hid-nintendo.c:56:17: warning: unused variable 'JC_SUBCMD_GET_PAGE_LIST_STATE' [-Wunused-const-variable]
   static const u8 JC_SUBCMD_GET_PAGE_LIST_STATE   = 0x05;
                   ^
   drivers/hid/hid-nintendo.c:57:17: warning: unused variable 'JC_SUBCMD_SET_HCI_STATE' [-Wunused-const-variable]
   static const u8 JC_SUBCMD_SET_HCI_STATE         = 0x06;
                   ^
   drivers/hid/hid-nintendo.c:58:17: warning: unused variable 'JC_SUBCMD_RESET_PAIRING_INFO' [-Wunused-const-variable]
   static const u8 JC_SUBCMD_RESET_PAIRING_INFO    = 0x07;
                   ^
   drivers/hid/hid-nintendo.c:59:17: warning: unused variable 'JC_SUBCMD_LOW_POWER_MODE' [-Wunused-const-variable]
   static const u8 JC_SUBCMD_LOW_POWER_MODE        = 0x08;
                   ^
   drivers/hid/hid-nintendo.c:61:17: warning: unused variable 'JC_SUBCMD_SPI_FLASH_WRITE' [-Wunused-const-variable]
   static const u8 JC_SUBCMD_SPI_FLASH_WRITE       = 0x11;
                   ^
   drivers/hid/hid-nintendo.c:62:17: warning: unused variable 'JC_SUBCMD_RESET_MCU' [-Wunused-const-variable]
   static const u8 JC_SUBCMD_RESET_MCU             = 0x20;
                   ^
   drivers/hid/hid-nintendo.c:63:17: warning: unused variable 'JC_SUBCMD_SET_MCU_CONFIG' [-Wunused-const-variable]
   static const u8 JC_SUBCMD_SET_MCU_CONFIG        = 0x21;
                   ^
   drivers/hid/hid-nintendo.c:64:17: warning: unused variable 'JC_SUBCMD_SET_MCU_STATE' [-Wunused-const-variable]
   static const u8 JC_SUBCMD_SET_MCU_STATE         = 0x22;
                   ^
   drivers/hid/hid-nintendo.c:66:17: warning: unused variable 'JC_SUBCMD_GET_PLAYER_LIGHTS' [-Wunused-const-variable]
   static const u8 JC_SUBCMD_GET_PLAYER_LIGHTS     = 0x31;
                   ^
   drivers/hid/hid-nintendo.c:69:17: warning: unused variable 'JC_SUBCMD_SET_IMU_SENSITIVITY' [-Wunused-const-variable]
   static const u8 JC_SUBCMD_SET_IMU_SENSITIVITY   = 0x41;
                   ^
   drivers/hid/hid-nintendo.c:70:17: warning: unused variable 'JC_SUBCMD_WRITE_IMU_REG' [-Wunused-const-variable]
   static const u8 JC_SUBCMD_WRITE_IMU_REG         = 0x42;
                   ^
   drivers/hid/hid-nintendo.c:71:17: warning: unused variable 'JC_SUBCMD_READ_IMU_REG' [-Wunused-const-variable]
   static const u8 JC_SUBCMD_READ_IMU_REG          = 0x43;
                   ^
   drivers/hid/hid-nintendo.c:73:17: warning: unused variable 'JC_SUBCMD_GET_REGULATED_VOLTAGE' [-Wunused-const-variable]
   static const u8 JC_SUBCMD_GET_REGULATED_VOLTAGE = 0x50;
                   ^
   drivers/hid/hid-nintendo.c:76:17: warning: unused variable 'JC_INPUT_BUTTON_EVENT' [-Wunused-const-variable]
   static const u8 JC_INPUT_BUTTON_EVENT           = 0x3F;
                   ^
   drivers/hid/hid-nintendo.c:83:17: warning: unused variable 'JC_FEATURE_LAST_SUBCMD' [-Wunused-const-variable]
   static const u8 JC_FEATURE_LAST_SUBCMD          = 0x02;
                   ^
   drivers/hid/hid-nintendo.c:84:17: warning: unused variable 'JC_FEATURE_OTA_FW_UPGRADE' [-Wunused-const-variable]
   static const u8 JC_FEATURE_OTA_FW_UPGRADE       = 0x70;
                   ^
   drivers/hid/hid-nintendo.c:85:17: warning: unused variable 'JC_FEATURE_SETUP_MEM_READ' [-Wunused-const-variable]
   static const u8 JC_FEATURE_SETUP_MEM_READ       = 0x71;
                   ^
   drivers/hid/hid-nintendo.c:86:17: warning: unused variable 'JC_FEATURE_MEM_READ' [-Wunused-const-variable]
   static const u8 JC_FEATURE_MEM_READ             = 0x72;
                   ^
   drivers/hid/hid-nintendo.c:87:17: warning: unused variable 'JC_FEATURE_ERASE_MEM_SECTOR' [-Wunused-const-variable]
   static const u8 JC_FEATURE_ERASE_MEM_SECTOR     = 0x73;
                   ^
   drivers/hid/hid-nintendo.c:88:17: warning: unused variable 'JC_FEATURE_MEM_WRITE' [-Wunused-const-variable]
   static const u8 JC_FEATURE_MEM_WRITE            = 0x74;
                   ^
   drivers/hid/hid-nintendo.c:89:17: warning: unused variable 'JC_FEATURE_LAUNCH' [-Wunused-const-variable]
   static const u8 JC_FEATURE_LAUNCH               = 0x75;
                   ^
   drivers/hid/hid-nintendo.c:92:17: warning: unused variable 'JC_USB_CMD_CONN_STATUS' [-Wunused-const-variable]
   static const u8 JC_USB_CMD_CONN_STATUS          = 0x01;
                   ^
   drivers/hid/hid-nintendo.c:96:17: warning: unused variable 'JC_USB_CMD_EN_TIMEOUT' [-Wunused-const-variable]
   static const u8 JC_USB_CMD_EN_TIMEOUT           = 0x05;
                   ^
   drivers/hid/hid-nintendo.c:97:17: warning: unused variable 'JC_USB_RESET' [-Wunused-const-variable]
   static const u8 JC_USB_RESET                    = 0x06;
                   ^
   drivers/hid/hid-nintendo.c:98:17: warning: unused variable 'JC_USB_PRE_HANDSHAKE' [-Wunused-const-variable]
   static const u8 JC_USB_PRE_HANDSHAKE            = 0x91;
                   ^
   drivers/hid/hid-nintendo.c:99:17: warning: unused variable 'JC_USB_SEND_UART' [-Wunused-const-variable]
   static const u8 JC_USB_SEND_UART                = 0x92;
                   ^
   drivers/hid/hid-nintendo.c:196:45: warning: unused variable 'joycon_rumble_frequencies' [-Wunused-const-variable]
   static const struct joycon_rumble_freq_data joycon_rumble_frequencies[] = {
                                               ^
   drivers/hid/hid-nintendo.c:254:44: warning: unused variable 'joycon_rumble_amplitudes' [-Wunused-const-variable]
   static const struct joycon_rumble_amp_data joycon_rumble_amplitudes[] = {
                                              ^
   drivers/hid/hid-nintendo.c:400:18: warning: unused variable 'JC_RUMBLE_DFLT_LOW_FREQ' [-Wunused-const-variable]
   static const u16 JC_RUMBLE_DFLT_LOW_FREQ = 160;
                    ^
   drivers/hid/hid-nintendo.c:401:18: warning: unused variable 'JC_RUMBLE_DFLT_HIGH_FREQ' [-Wunused-const-variable]
   static const u16 JC_RUMBLE_DFLT_HIGH_FREQ = 320;
                    ^
>> drivers/hid/hid-nintendo.c:403:29: warning: unused variable 'JC_RUMBLE_ZERO_AMP_PKT_CNT' [-Wunused-const-variable]
   static const unsigned short JC_RUMBLE_ZERO_AMP_PKT_CNT = 5;
                               ^
   36 warnings generated.


vim +/JC_RUMBLE_ZERO_AMP_PKT_CNT +403 drivers/hid/hid-nintendo.c

   252	
   253	#define joycon_max_rumble_amp	(1003)
 > 254	static const struct joycon_rumble_amp_data joycon_rumble_amplitudes[] = {
   255		/* high, low, amp */
   256		{ 0x00, 0x0040,    0 },
   257		{ 0x02, 0x8040,   10 }, { 0x04, 0x0041,   12 }, { 0x06, 0x8041,   14 },
   258		{ 0x08, 0x0042,   17 }, { 0x0a, 0x8042,   20 }, { 0x0c, 0x0043,   24 },
   259		{ 0x0e, 0x8043,   28 }, { 0x10, 0x0044,   33 }, { 0x12, 0x8044,   40 },
   260		{ 0x14, 0x0045,   47 }, { 0x16, 0x8045,   56 }, { 0x18, 0x0046,   67 },
   261		{ 0x1a, 0x8046,   80 }, { 0x1c, 0x0047,   95 }, { 0x1e, 0x8047,  112 },
   262		{ 0x20, 0x0048,  117 }, { 0x22, 0x8048,  123 }, { 0x24, 0x0049,  128 },
   263		{ 0x26, 0x8049,  134 }, { 0x28, 0x004a,  140 }, { 0x2a, 0x804a,  146 },
   264		{ 0x2c, 0x004b,  152 }, { 0x2e, 0x804b,  159 }, { 0x30, 0x004c,  166 },
   265		{ 0x32, 0x804c,  173 }, { 0x34, 0x004d,  181 }, { 0x36, 0x804d,  189 },
   266		{ 0x38, 0x004e,  198 }, { 0x3a, 0x804e,  206 }, { 0x3c, 0x004f,  215 },
   267		{ 0x3e, 0x804f,  225 }, { 0x40, 0x0050,  230 }, { 0x42, 0x8050,  235 },
   268		{ 0x44, 0x0051,  240 }, { 0x46, 0x8051,  245 }, { 0x48, 0x0052,  251 },
   269		{ 0x4a, 0x8052,  256 }, { 0x4c, 0x0053,  262 }, { 0x4e, 0x8053,  268 },
   270		{ 0x50, 0x0054,  273 }, { 0x52, 0x8054,  279 }, { 0x54, 0x0055,  286 },
   271		{ 0x56, 0x8055,  292 }, { 0x58, 0x0056,  298 }, { 0x5a, 0x8056,  305 },
   272		{ 0x5c, 0x0057,  311 }, { 0x5e, 0x8057,  318 }, { 0x60, 0x0058,  325 },
   273		{ 0x62, 0x8058,  332 }, { 0x64, 0x0059,  340 }, { 0x66, 0x8059,  347 },
   274		{ 0x68, 0x005a,  355 }, { 0x6a, 0x805a,  362 }, { 0x6c, 0x005b,  370 },
   275		{ 0x6e, 0x805b,  378 }, { 0x70, 0x005c,  387 }, { 0x72, 0x805c,  395 },
   276		{ 0x74, 0x005d,  404 }, { 0x76, 0x805d,  413 }, { 0x78, 0x005e,  422 },
   277		{ 0x7a, 0x805e,  431 }, { 0x7c, 0x005f,  440 }, { 0x7e, 0x805f,  450 },
   278		{ 0x80, 0x0060,  460 }, { 0x82, 0x8060,  470 }, { 0x84, 0x0061,  480 },
   279		{ 0x86, 0x8061,  491 }, { 0x88, 0x0062,  501 }, { 0x8a, 0x8062,  512 },
   280		{ 0x8c, 0x0063,  524 }, { 0x8e, 0x8063,  535 }, { 0x90, 0x0064,  547 },
   281		{ 0x92, 0x8064,  559 }, { 0x94, 0x0065,  571 }, { 0x96, 0x8065,  584 },
   282		{ 0x98, 0x0066,  596 }, { 0x9a, 0x8066,  609 }, { 0x9c, 0x0067,  623 },
   283		{ 0x9e, 0x8067,  636 }, { 0xa0, 0x0068,  650 }, { 0xa2, 0x8068,  665 },
   284		{ 0xa4, 0x0069,  679 }, { 0xa6, 0x8069,  694 }, { 0xa8, 0x006a,  709 },
   285		{ 0xaa, 0x806a,  725 }, { 0xac, 0x006b,  741 }, { 0xae, 0x806b,  757 },
   286		{ 0xb0, 0x006c,  773 }, { 0xb2, 0x806c,  790 }, { 0xb4, 0x006d,  808 },
   287		{ 0xb6, 0x806d,  825 }, { 0xb8, 0x006e,  843 }, { 0xba, 0x806e,  862 },
   288		{ 0xbc, 0x006f,  881 }, { 0xbe, 0x806f,  900 }, { 0xc0, 0x0070,  920 },
   289		{ 0xc2, 0x8070,  940 }, { 0xc4, 0x0071,  960 }, { 0xc6, 0x8071,  981 },
   290		{ 0xc8, 0x0072, joycon_max_rumble_amp }
   291	};
   292	
   293	/* States for controller state machine */
   294	enum joycon_ctlr_state {
   295		JOYCON_CTLR_STATE_INIT,
   296		JOYCON_CTLR_STATE_READ,
   297		JOYCON_CTLR_STATE_REMOVED,
   298	};
   299	
   300	/* Controller type received as part of device info */
   301	enum joycon_ctlr_type {
   302		JOYCON_CTLR_TYPE_JCL = 0x01,
   303		JOYCON_CTLR_TYPE_JCR = 0x02,
   304		JOYCON_CTLR_TYPE_PRO = 0x03,
   305	};
   306	
   307	struct joycon_stick_cal {
   308		s32 max;
   309		s32 min;
   310		s32 center;
   311	};
   312	
   313	struct joycon_imu_cal {
   314		s16 offset[3];
   315		s16 scale[3];
   316	};
   317	
   318	/*
   319	 * All the controller's button values are stored in a u32.
   320	 * They can be accessed with bitwise ANDs.
   321	 */
   322	static const u32 JC_BTN_Y	= BIT(0);
   323	static const u32 JC_BTN_X	= BIT(1);
   324	static const u32 JC_BTN_B	= BIT(2);
   325	static const u32 JC_BTN_A	= BIT(3);
   326	static const u32 JC_BTN_SR_R	= BIT(4);
   327	static const u32 JC_BTN_SL_R	= BIT(5);
   328	static const u32 JC_BTN_R	= BIT(6);
   329	static const u32 JC_BTN_ZR	= BIT(7);
   330	static const u32 JC_BTN_MINUS	= BIT(8);
   331	static const u32 JC_BTN_PLUS	= BIT(9);
   332	static const u32 JC_BTN_RSTICK	= BIT(10);
   333	static const u32 JC_BTN_LSTICK	= BIT(11);
   334	static const u32 JC_BTN_HOME	= BIT(12);
   335	static const u32 JC_BTN_CAP	= BIT(13); /* capture button */
   336	static const u32 JC_BTN_DOWN	= BIT(16);
   337	static const u32 JC_BTN_UP	= BIT(17);
   338	static const u32 JC_BTN_RIGHT	= BIT(18);
   339	static const u32 JC_BTN_LEFT	= BIT(19);
   340	static const u32 JC_BTN_SR_L	= BIT(20);
   341	static const u32 JC_BTN_SL_L	= BIT(21);
   342	static const u32 JC_BTN_L	= BIT(22);
   343	static const u32 JC_BTN_ZL	= BIT(23);
   344	
   345	enum joycon_msg_type {
   346		JOYCON_MSG_TYPE_NONE,
   347		JOYCON_MSG_TYPE_USB,
   348		JOYCON_MSG_TYPE_SUBCMD,
   349	};
   350	
   351	struct joycon_rumble_output {
   352		u8 output_id;
   353		u8 packet_num;
   354		u8 rumble_data[8];
   355	} __packed;
   356	
   357	struct joycon_subcmd_request {
   358		u8 output_id; /* must be 0x01 for subcommand, 0x10 for rumble only */
   359		u8 packet_num; /* incremented every send */
   360		u8 rumble_data[8];
   361		u8 subcmd_id;
   362		u8 data[]; /* length depends on the subcommand */
   363	} __packed;
   364	
   365	struct joycon_subcmd_reply {
   366		u8 ack; /* MSB 1 for ACK, 0 for NACK */
   367		u8 id; /* id of requested subcmd */
   368		u8 data[]; /* will be at most 35 bytes */
   369	} __packed;
   370	
   371	struct joycon_imu_data {
   372		s16 accel_x;
   373		s16 accel_y;
   374		s16 accel_z;
   375		s16 gyro_x;
   376		s16 gyro_y;
   377		s16 gyro_z;
   378	} __packed;
   379	
   380	struct joycon_input_report {
   381		u8 id;
   382		u8 timer;
   383		u8 bat_con; /* battery and connection info */
   384		u8 button_status[3];
   385		u8 left_stick[3];
   386		u8 right_stick[3];
   387		u8 vibrator_report;
   388	
   389		union {
   390			struct joycon_subcmd_reply subcmd_reply;
   391			/* IMU input reports contain 3 samples */
   392			u8 imu_raw_bytes[sizeof(struct joycon_imu_data) * 3];
   393		};
   394	} __packed;
   395	
   396	#define JC_MAX_RESP_SIZE	(sizeof(struct joycon_input_report) + 35)
   397	#define JC_RUMBLE_DATA_SIZE	8
   398	#define JC_RUMBLE_QUEUE_SIZE	8
   399	
   400	static const u16 JC_RUMBLE_DFLT_LOW_FREQ = 160;
   401	static const u16 JC_RUMBLE_DFLT_HIGH_FREQ = 320;
   402	static const u16 JC_RUMBLE_PERIOD_MS = 50;
 > 403	static const unsigned short JC_RUMBLE_ZERO_AMP_PKT_CNT = 5;
   404	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
