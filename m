Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63D814B3CCF
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Feb 2022 19:19:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237758AbiBMSTN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Feb 2022 13:19:13 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:41404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230009AbiBMSTL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Feb 2022 13:19:11 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDBDE56C38
        for <linux-kernel@vger.kernel.org>; Sun, 13 Feb 2022 10:19:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644776344; x=1676312344;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=AC7C+XtLgDLowLvhcpQN9ya0PMvKQiVp4JhZsmuD95A=;
  b=Hfs0B9Tam8gv3mpgE4RBP93cvpdNv29jbSiW9cLseEZEKvy9cKs7T6Cp
   9rqdYmFvRnEWcu/Re1UAzu9jhQFLKdECUYVFz0Fg8H7FZcud/HkmNOOih
   z4KXZ+W8rO3YsCY6PvN/DdZ5wET3fZvdceBLtqtewt2SD8g//HbNsqHnF
   MpkNff4fJcX7scnyudOSNztTvD5UMmZW/gO0wucMj9AHW+EPqdqJQlHTx
   PSpHE5lRe88ZwrEBvM+Ma0MPWfJ3sE61e+JtcGGwnlahgFYfSmO+nrFU5
   IpK2PMtnTJkVJX9zVcwKZdnalZR9nroOmT3QMEFRVGZc3PxJYlp60SoNt
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10257"; a="249913240"
X-IronPort-AV: E=Sophos;i="5.88,366,1635231600"; 
   d="scan'208";a="249913240"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2022 10:19:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,366,1635231600"; 
   d="scan'208";a="702720479"
Received: from lkp-server01.sh.intel.com (HELO d95dc2dabeb1) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 13 Feb 2022 10:19:02 -0800
Received: from kbuild by d95dc2dabeb1 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nJJSg-0007iT-2U; Sun, 13 Feb 2022 18:19:02 +0000
Date:   Mon, 14 Feb 2022 02:18:13 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jiri Kosina <jkosina@suse.cz>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: drivers/hid/hid-nintendo.c:403:29: error: unused variable
 'JC_RUMBLE_ZERO_AMP_PKT_CNT'
Message-ID: <202202140250.xs4vEOjg-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jiri,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   b81b1829e7e39f6cebdf6e4d5484eacbceda8554
commit: daf11ca2b9f45a1ac6f90af5a61ee4db915110b1 HID: nintendo: fix -Werror build
date:   3 months ago
config: riscv-randconfig-c006-20220213 (https://download.01.org/0day-ci/archive/20220214/202202140250.xs4vEOjg-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 478c237e21b2c3a83e46f26fcbeb3876682f9b14)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install riscv cross compiling tool for clang build
        # apt-get install binutils-riscv64-linux-gnu
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=daf11ca2b9f45a1ac6f90af5a61ee4db915110b1
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout daf11ca2b9f45a1ac6f90af5a61ee4db915110b1
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=riscv SHELL=/bin/bash arch/riscv/mm/ drivers/clk/bcm/ drivers/gpu/drm/ drivers/hid/ kernel/sched/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   drivers/hid/hid-nintendo.c:196:45: error: unused variable 'joycon_rumble_frequencies' [-Werror,-Wunused-const-variable]
   static const struct joycon_rumble_freq_data joycon_rumble_frequencies[] = {
                                               ^
   drivers/hid/hid-nintendo.c:254:44: error: unused variable 'joycon_rumble_amplitudes' [-Werror,-Wunused-const-variable]
   static const struct joycon_rumble_amp_data joycon_rumble_amplitudes[] = {
                                              ^
   drivers/hid/hid-nintendo.c:400:18: error: unused variable 'JC_RUMBLE_DFLT_LOW_FREQ' [-Werror,-Wunused-const-variable]
   static const u16 JC_RUMBLE_DFLT_LOW_FREQ = 160;
                    ^
   drivers/hid/hid-nintendo.c:401:18: error: unused variable 'JC_RUMBLE_DFLT_HIGH_FREQ' [-Werror,-Wunused-const-variable]
   static const u16 JC_RUMBLE_DFLT_HIGH_FREQ = 320;
                    ^
>> drivers/hid/hid-nintendo.c:403:29: error: unused variable 'JC_RUMBLE_ZERO_AMP_PKT_CNT' [-Werror,-Wunused-const-variable]
   static const unsigned short JC_RUMBLE_ZERO_AMP_PKT_CNT = 5;
                               ^
   5 errors generated.


vim +/JC_RUMBLE_ZERO_AMP_PKT_CNT +403 drivers/hid/hid-nintendo.c

c4eae84feff3e6 Daniel J. Ogorchock 2021-09-11  252  
c4eae84feff3e6 Daniel J. Ogorchock 2021-09-11  253  #define joycon_max_rumble_amp	(1003)
c4eae84feff3e6 Daniel J. Ogorchock 2021-09-11 @254  static const struct joycon_rumble_amp_data joycon_rumble_amplitudes[] = {
c4eae84feff3e6 Daniel J. Ogorchock 2021-09-11  255  	/* high, low, amp */
c4eae84feff3e6 Daniel J. Ogorchock 2021-09-11  256  	{ 0x00, 0x0040,    0 },
c4eae84feff3e6 Daniel J. Ogorchock 2021-09-11  257  	{ 0x02, 0x8040,   10 }, { 0x04, 0x0041,   12 }, { 0x06, 0x8041,   14 },
c4eae84feff3e6 Daniel J. Ogorchock 2021-09-11  258  	{ 0x08, 0x0042,   17 }, { 0x0a, 0x8042,   20 }, { 0x0c, 0x0043,   24 },
c4eae84feff3e6 Daniel J. Ogorchock 2021-09-11  259  	{ 0x0e, 0x8043,   28 }, { 0x10, 0x0044,   33 }, { 0x12, 0x8044,   40 },
c4eae84feff3e6 Daniel J. Ogorchock 2021-09-11  260  	{ 0x14, 0x0045,   47 }, { 0x16, 0x8045,   56 }, { 0x18, 0x0046,   67 },
c4eae84feff3e6 Daniel J. Ogorchock 2021-09-11  261  	{ 0x1a, 0x8046,   80 }, { 0x1c, 0x0047,   95 }, { 0x1e, 0x8047,  112 },
c4eae84feff3e6 Daniel J. Ogorchock 2021-09-11  262  	{ 0x20, 0x0048,  117 }, { 0x22, 0x8048,  123 }, { 0x24, 0x0049,  128 },
c4eae84feff3e6 Daniel J. Ogorchock 2021-09-11  263  	{ 0x26, 0x8049,  134 }, { 0x28, 0x004a,  140 }, { 0x2a, 0x804a,  146 },
c4eae84feff3e6 Daniel J. Ogorchock 2021-09-11  264  	{ 0x2c, 0x004b,  152 }, { 0x2e, 0x804b,  159 }, { 0x30, 0x004c,  166 },
c4eae84feff3e6 Daniel J. Ogorchock 2021-09-11  265  	{ 0x32, 0x804c,  173 }, { 0x34, 0x004d,  181 }, { 0x36, 0x804d,  189 },
c4eae84feff3e6 Daniel J. Ogorchock 2021-09-11  266  	{ 0x38, 0x004e,  198 }, { 0x3a, 0x804e,  206 }, { 0x3c, 0x004f,  215 },
c4eae84feff3e6 Daniel J. Ogorchock 2021-09-11  267  	{ 0x3e, 0x804f,  225 }, { 0x40, 0x0050,  230 }, { 0x42, 0x8050,  235 },
c4eae84feff3e6 Daniel J. Ogorchock 2021-09-11  268  	{ 0x44, 0x0051,  240 }, { 0x46, 0x8051,  245 }, { 0x48, 0x0052,  251 },
c4eae84feff3e6 Daniel J. Ogorchock 2021-09-11  269  	{ 0x4a, 0x8052,  256 }, { 0x4c, 0x0053,  262 }, { 0x4e, 0x8053,  268 },
c4eae84feff3e6 Daniel J. Ogorchock 2021-09-11  270  	{ 0x50, 0x0054,  273 }, { 0x52, 0x8054,  279 }, { 0x54, 0x0055,  286 },
c4eae84feff3e6 Daniel J. Ogorchock 2021-09-11  271  	{ 0x56, 0x8055,  292 }, { 0x58, 0x0056,  298 }, { 0x5a, 0x8056,  305 },
c4eae84feff3e6 Daniel J. Ogorchock 2021-09-11  272  	{ 0x5c, 0x0057,  311 }, { 0x5e, 0x8057,  318 }, { 0x60, 0x0058,  325 },
c4eae84feff3e6 Daniel J. Ogorchock 2021-09-11  273  	{ 0x62, 0x8058,  332 }, { 0x64, 0x0059,  340 }, { 0x66, 0x8059,  347 },
c4eae84feff3e6 Daniel J. Ogorchock 2021-09-11  274  	{ 0x68, 0x005a,  355 }, { 0x6a, 0x805a,  362 }, { 0x6c, 0x005b,  370 },
c4eae84feff3e6 Daniel J. Ogorchock 2021-09-11  275  	{ 0x6e, 0x805b,  378 }, { 0x70, 0x005c,  387 }, { 0x72, 0x805c,  395 },
c4eae84feff3e6 Daniel J. Ogorchock 2021-09-11  276  	{ 0x74, 0x005d,  404 }, { 0x76, 0x805d,  413 }, { 0x78, 0x005e,  422 },
c4eae84feff3e6 Daniel J. Ogorchock 2021-09-11  277  	{ 0x7a, 0x805e,  431 }, { 0x7c, 0x005f,  440 }, { 0x7e, 0x805f,  450 },
c4eae84feff3e6 Daniel J. Ogorchock 2021-09-11  278  	{ 0x80, 0x0060,  460 }, { 0x82, 0x8060,  470 }, { 0x84, 0x0061,  480 },
c4eae84feff3e6 Daniel J. Ogorchock 2021-09-11  279  	{ 0x86, 0x8061,  491 }, { 0x88, 0x0062,  501 }, { 0x8a, 0x8062,  512 },
c4eae84feff3e6 Daniel J. Ogorchock 2021-09-11  280  	{ 0x8c, 0x0063,  524 }, { 0x8e, 0x8063,  535 }, { 0x90, 0x0064,  547 },
c4eae84feff3e6 Daniel J. Ogorchock 2021-09-11  281  	{ 0x92, 0x8064,  559 }, { 0x94, 0x0065,  571 }, { 0x96, 0x8065,  584 },
c4eae84feff3e6 Daniel J. Ogorchock 2021-09-11  282  	{ 0x98, 0x0066,  596 }, { 0x9a, 0x8066,  609 }, { 0x9c, 0x0067,  623 },
c4eae84feff3e6 Daniel J. Ogorchock 2021-09-11  283  	{ 0x9e, 0x8067,  636 }, { 0xa0, 0x0068,  650 }, { 0xa2, 0x8068,  665 },
c4eae84feff3e6 Daniel J. Ogorchock 2021-09-11  284  	{ 0xa4, 0x0069,  679 }, { 0xa6, 0x8069,  694 }, { 0xa8, 0x006a,  709 },
c4eae84feff3e6 Daniel J. Ogorchock 2021-09-11  285  	{ 0xaa, 0x806a,  725 }, { 0xac, 0x006b,  741 }, { 0xae, 0x806b,  757 },
c4eae84feff3e6 Daniel J. Ogorchock 2021-09-11  286  	{ 0xb0, 0x006c,  773 }, { 0xb2, 0x806c,  790 }, { 0xb4, 0x006d,  808 },
c4eae84feff3e6 Daniel J. Ogorchock 2021-09-11  287  	{ 0xb6, 0x806d,  825 }, { 0xb8, 0x006e,  843 }, { 0xba, 0x806e,  862 },
c4eae84feff3e6 Daniel J. Ogorchock 2021-09-11  288  	{ 0xbc, 0x006f,  881 }, { 0xbe, 0x806f,  900 }, { 0xc0, 0x0070,  920 },
c4eae84feff3e6 Daniel J. Ogorchock 2021-09-11  289  	{ 0xc2, 0x8070,  940 }, { 0xc4, 0x0071,  960 }, { 0xc6, 0x8071,  981 },
c4eae84feff3e6 Daniel J. Ogorchock 2021-09-11  290  	{ 0xc8, 0x0072, joycon_max_rumble_amp }
c4eae84feff3e6 Daniel J. Ogorchock 2021-09-11  291  };
c4eae84feff3e6 Daniel J. Ogorchock 2021-09-11  292  
2af16c1f846bd6 Daniel J. Ogorchock 2021-09-11  293  /* States for controller state machine */
2af16c1f846bd6 Daniel J. Ogorchock 2021-09-11  294  enum joycon_ctlr_state {
2af16c1f846bd6 Daniel J. Ogorchock 2021-09-11  295  	JOYCON_CTLR_STATE_INIT,
2af16c1f846bd6 Daniel J. Ogorchock 2021-09-11  296  	JOYCON_CTLR_STATE_READ,
012bd52c699d61 Daniel J. Ogorchock 2021-09-11  297  	JOYCON_CTLR_STATE_REMOVED,
2af16c1f846bd6 Daniel J. Ogorchock 2021-09-11  298  };
2af16c1f846bd6 Daniel J. Ogorchock 2021-09-11  299  
294a828759d041 Daniel J. Ogorchock 2021-09-11  300  /* Controller type received as part of device info */
294a828759d041 Daniel J. Ogorchock 2021-09-11  301  enum joycon_ctlr_type {
294a828759d041 Daniel J. Ogorchock 2021-09-11  302  	JOYCON_CTLR_TYPE_JCL = 0x01,
294a828759d041 Daniel J. Ogorchock 2021-09-11  303  	JOYCON_CTLR_TYPE_JCR = 0x02,
294a828759d041 Daniel J. Ogorchock 2021-09-11  304  	JOYCON_CTLR_TYPE_PRO = 0x03,
294a828759d041 Daniel J. Ogorchock 2021-09-11  305  };
294a828759d041 Daniel J. Ogorchock 2021-09-11  306  
2af16c1f846bd6 Daniel J. Ogorchock 2021-09-11  307  struct joycon_stick_cal {
2af16c1f846bd6 Daniel J. Ogorchock 2021-09-11  308  	s32 max;
2af16c1f846bd6 Daniel J. Ogorchock 2021-09-11  309  	s32 min;
2af16c1f846bd6 Daniel J. Ogorchock 2021-09-11  310  	s32 center;
2af16c1f846bd6 Daniel J. Ogorchock 2021-09-11  311  };
2af16c1f846bd6 Daniel J. Ogorchock 2021-09-11  312  
4ff5b10840a88e Daniel J. Ogorchock 2021-09-11  313  struct joycon_imu_cal {
4ff5b10840a88e Daniel J. Ogorchock 2021-09-11  314  	s16 offset[3];
4ff5b10840a88e Daniel J. Ogorchock 2021-09-11  315  	s16 scale[3];
4ff5b10840a88e Daniel J. Ogorchock 2021-09-11  316  };
4ff5b10840a88e Daniel J. Ogorchock 2021-09-11  317  
2af16c1f846bd6 Daniel J. Ogorchock 2021-09-11  318  /*
2af16c1f846bd6 Daniel J. Ogorchock 2021-09-11  319   * All the controller's button values are stored in a u32.
2af16c1f846bd6 Daniel J. Ogorchock 2021-09-11  320   * They can be accessed with bitwise ANDs.
2af16c1f846bd6 Daniel J. Ogorchock 2021-09-11  321   */
2af16c1f846bd6 Daniel J. Ogorchock 2021-09-11  322  static const u32 JC_BTN_Y	= BIT(0);
2af16c1f846bd6 Daniel J. Ogorchock 2021-09-11  323  static const u32 JC_BTN_X	= BIT(1);
2af16c1f846bd6 Daniel J. Ogorchock 2021-09-11  324  static const u32 JC_BTN_B	= BIT(2);
2af16c1f846bd6 Daniel J. Ogorchock 2021-09-11  325  static const u32 JC_BTN_A	= BIT(3);
2af16c1f846bd6 Daniel J. Ogorchock 2021-09-11  326  static const u32 JC_BTN_SR_R	= BIT(4);
2af16c1f846bd6 Daniel J. Ogorchock 2021-09-11  327  static const u32 JC_BTN_SL_R	= BIT(5);
2af16c1f846bd6 Daniel J. Ogorchock 2021-09-11  328  static const u32 JC_BTN_R	= BIT(6);
2af16c1f846bd6 Daniel J. Ogorchock 2021-09-11  329  static const u32 JC_BTN_ZR	= BIT(7);
2af16c1f846bd6 Daniel J. Ogorchock 2021-09-11  330  static const u32 JC_BTN_MINUS	= BIT(8);
2af16c1f846bd6 Daniel J. Ogorchock 2021-09-11  331  static const u32 JC_BTN_PLUS	= BIT(9);
2af16c1f846bd6 Daniel J. Ogorchock 2021-09-11  332  static const u32 JC_BTN_RSTICK	= BIT(10);
2af16c1f846bd6 Daniel J. Ogorchock 2021-09-11  333  static const u32 JC_BTN_LSTICK	= BIT(11);
2af16c1f846bd6 Daniel J. Ogorchock 2021-09-11  334  static const u32 JC_BTN_HOME	= BIT(12);
2af16c1f846bd6 Daniel J. Ogorchock 2021-09-11  335  static const u32 JC_BTN_CAP	= BIT(13); /* capture button */
2af16c1f846bd6 Daniel J. Ogorchock 2021-09-11  336  static const u32 JC_BTN_DOWN	= BIT(16);
2af16c1f846bd6 Daniel J. Ogorchock 2021-09-11  337  static const u32 JC_BTN_UP	= BIT(17);
2af16c1f846bd6 Daniel J. Ogorchock 2021-09-11  338  static const u32 JC_BTN_RIGHT	= BIT(18);
2af16c1f846bd6 Daniel J. Ogorchock 2021-09-11  339  static const u32 JC_BTN_LEFT	= BIT(19);
2af16c1f846bd6 Daniel J. Ogorchock 2021-09-11  340  static const u32 JC_BTN_SR_L	= BIT(20);
2af16c1f846bd6 Daniel J. Ogorchock 2021-09-11  341  static const u32 JC_BTN_SL_L	= BIT(21);
2af16c1f846bd6 Daniel J. Ogorchock 2021-09-11  342  static const u32 JC_BTN_L	= BIT(22);
2af16c1f846bd6 Daniel J. Ogorchock 2021-09-11  343  static const u32 JC_BTN_ZL	= BIT(23);
2af16c1f846bd6 Daniel J. Ogorchock 2021-09-11  344  
2af16c1f846bd6 Daniel J. Ogorchock 2021-09-11  345  enum joycon_msg_type {
2af16c1f846bd6 Daniel J. Ogorchock 2021-09-11  346  	JOYCON_MSG_TYPE_NONE,
2af16c1f846bd6 Daniel J. Ogorchock 2021-09-11  347  	JOYCON_MSG_TYPE_USB,
2af16c1f846bd6 Daniel J. Ogorchock 2021-09-11  348  	JOYCON_MSG_TYPE_SUBCMD,
2af16c1f846bd6 Daniel J. Ogorchock 2021-09-11  349  };
2af16c1f846bd6 Daniel J. Ogorchock 2021-09-11  350  
4c048f6b2c25ff Daniel J. Ogorchock 2021-09-11  351  struct joycon_rumble_output {
4c048f6b2c25ff Daniel J. Ogorchock 2021-09-11  352  	u8 output_id;
4c048f6b2c25ff Daniel J. Ogorchock 2021-09-11  353  	u8 packet_num;
4c048f6b2c25ff Daniel J. Ogorchock 2021-09-11  354  	u8 rumble_data[8];
4c048f6b2c25ff Daniel J. Ogorchock 2021-09-11  355  } __packed;
4c048f6b2c25ff Daniel J. Ogorchock 2021-09-11  356  
2af16c1f846bd6 Daniel J. Ogorchock 2021-09-11  357  struct joycon_subcmd_request {
2af16c1f846bd6 Daniel J. Ogorchock 2021-09-11  358  	u8 output_id; /* must be 0x01 for subcommand, 0x10 for rumble only */
2af16c1f846bd6 Daniel J. Ogorchock 2021-09-11  359  	u8 packet_num; /* incremented every send */
2af16c1f846bd6 Daniel J. Ogorchock 2021-09-11  360  	u8 rumble_data[8];
2af16c1f846bd6 Daniel J. Ogorchock 2021-09-11  361  	u8 subcmd_id;
2af16c1f846bd6 Daniel J. Ogorchock 2021-09-11  362  	u8 data[]; /* length depends on the subcommand */
2af16c1f846bd6 Daniel J. Ogorchock 2021-09-11  363  } __packed;
2af16c1f846bd6 Daniel J. Ogorchock 2021-09-11  364  
2af16c1f846bd6 Daniel J. Ogorchock 2021-09-11  365  struct joycon_subcmd_reply {
2af16c1f846bd6 Daniel J. Ogorchock 2021-09-11  366  	u8 ack; /* MSB 1 for ACK, 0 for NACK */
2af16c1f846bd6 Daniel J. Ogorchock 2021-09-11  367  	u8 id; /* id of requested subcmd */
2af16c1f846bd6 Daniel J. Ogorchock 2021-09-11  368  	u8 data[]; /* will be at most 35 bytes */
2af16c1f846bd6 Daniel J. Ogorchock 2021-09-11  369  } __packed;
2af16c1f846bd6 Daniel J. Ogorchock 2021-09-11  370  
4ff5b10840a88e Daniel J. Ogorchock 2021-09-11  371  struct joycon_imu_data {
4ff5b10840a88e Daniel J. Ogorchock 2021-09-11  372  	s16 accel_x;
4ff5b10840a88e Daniel J. Ogorchock 2021-09-11  373  	s16 accel_y;
4ff5b10840a88e Daniel J. Ogorchock 2021-09-11  374  	s16 accel_z;
4ff5b10840a88e Daniel J. Ogorchock 2021-09-11  375  	s16 gyro_x;
4ff5b10840a88e Daniel J. Ogorchock 2021-09-11  376  	s16 gyro_y;
4ff5b10840a88e Daniel J. Ogorchock 2021-09-11  377  	s16 gyro_z;
4ff5b10840a88e Daniel J. Ogorchock 2021-09-11  378  } __packed;
4ff5b10840a88e Daniel J. Ogorchock 2021-09-11  379  
2af16c1f846bd6 Daniel J. Ogorchock 2021-09-11  380  struct joycon_input_report {
2af16c1f846bd6 Daniel J. Ogorchock 2021-09-11  381  	u8 id;
2af16c1f846bd6 Daniel J. Ogorchock 2021-09-11  382  	u8 timer;
2af16c1f846bd6 Daniel J. Ogorchock 2021-09-11  383  	u8 bat_con; /* battery and connection info */
2af16c1f846bd6 Daniel J. Ogorchock 2021-09-11  384  	u8 button_status[3];
2af16c1f846bd6 Daniel J. Ogorchock 2021-09-11  385  	u8 left_stick[3];
2af16c1f846bd6 Daniel J. Ogorchock 2021-09-11  386  	u8 right_stick[3];
2af16c1f846bd6 Daniel J. Ogorchock 2021-09-11  387  	u8 vibrator_report;
2af16c1f846bd6 Daniel J. Ogorchock 2021-09-11  388  
4ff5b10840a88e Daniel J. Ogorchock 2021-09-11  389  	union {
4ff5b10840a88e Daniel J. Ogorchock 2021-09-11  390  		struct joycon_subcmd_reply subcmd_reply;
4ff5b10840a88e Daniel J. Ogorchock 2021-09-11  391  		/* IMU input reports contain 3 samples */
4ff5b10840a88e Daniel J. Ogorchock 2021-09-11  392  		u8 imu_raw_bytes[sizeof(struct joycon_imu_data) * 3];
4ff5b10840a88e Daniel J. Ogorchock 2021-09-11  393  	};
2af16c1f846bd6 Daniel J. Ogorchock 2021-09-11  394  } __packed;
2af16c1f846bd6 Daniel J. Ogorchock 2021-09-11  395  
2af16c1f846bd6 Daniel J. Ogorchock 2021-09-11  396  #define JC_MAX_RESP_SIZE	(sizeof(struct joycon_input_report) + 35)
c4eae84feff3e6 Daniel J. Ogorchock 2021-09-11  397  #define JC_RUMBLE_DATA_SIZE	8
c4eae84feff3e6 Daniel J. Ogorchock 2021-09-11  398  #define JC_RUMBLE_QUEUE_SIZE	8
c4eae84feff3e6 Daniel J. Ogorchock 2021-09-11  399  
c4eae84feff3e6 Daniel J. Ogorchock 2021-09-11  400  static const u16 JC_RUMBLE_DFLT_LOW_FREQ = 160;
c4eae84feff3e6 Daniel J. Ogorchock 2021-09-11  401  static const u16 JC_RUMBLE_DFLT_HIGH_FREQ = 320;
c4eae84feff3e6 Daniel J. Ogorchock 2021-09-11  402  static const u16 JC_RUMBLE_PERIOD_MS = 50;
dad74e18f72a85 Daniel J. Ogorchock 2021-09-11 @403  static const unsigned short JC_RUMBLE_ZERO_AMP_PKT_CNT = 5;
2af16c1f846bd6 Daniel J. Ogorchock 2021-09-11  404  

:::::: The code at line 403 was first introduced by commit
:::::: dad74e18f72a852ae40ad7b4246841a1b7e196b5 HID: nintendo: prevent needless queueing of the rumble worker

:::::: TO: Daniel J. Ogorchock <djogorchock@gmail.com>
:::::: CC: Jiri Kosina <jkosina@suse.cz>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
