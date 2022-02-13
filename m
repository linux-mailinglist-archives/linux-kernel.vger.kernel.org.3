Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2F0E4B3D91
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Feb 2022 21:51:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238214AbiBMUvR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Feb 2022 15:51:17 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:56740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235807AbiBMUvQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Feb 2022 15:51:16 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26BBA53711
        for <linux-kernel@vger.kernel.org>; Sun, 13 Feb 2022 12:51:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644785469; x=1676321469;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=pHsjhKwgbVoo5NOuPtCu0km8i4WrTiCWj5A92evXJGA=;
  b=YXjIsnHuubjGcXuETUHEhJA25gmnVXGG4DKrfXr6BWrgAFQ2Enf6hMJW
   CoC9QTPzjfaAN/ChAm1i/viBA6F8dnieXGusePwVgu59EUnreF7aI8NSy
   4D8nCUoCciwb0lYJxRvBW3pqbR88ut7pr0W1xbKB8H9/WEWAIzQ/DOsFH
   krNz4qQQgbofpttDM7bNAxYpZjeVyfKtcU0WTXzeHi8paq1MRQcWQeff0
   HZlzzV0rtJD3T9pZorzAQmc7/wpAEgx6cdrOcdXLTgt7N/PmylsVJPAAa
   WEwZW8aMC0iyV+RUf7PlazTM5/dfeRSF3jBTDevlUKNcYKNrshYXd+0Iu
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10257"; a="247567413"
X-IronPort-AV: E=Sophos;i="5.88,366,1635231600"; 
   d="scan'208";a="247567413"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2022 12:51:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,366,1635231600"; 
   d="scan'208";a="569685037"
Received: from lkp-server01.sh.intel.com (HELO d95dc2dabeb1) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 13 Feb 2022 12:51:07 -0800
Received: from kbuild by d95dc2dabeb1 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nJLpq-0007pS-GO; Sun, 13 Feb 2022 20:51:06 +0000
Date:   Mon, 14 Feb 2022 04:50:45 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Daniel J. Ogorchock" <djogorchock@gmail.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Jiri Kosina <jkosina@suse.cz>
Subject: drivers/hid/hid-nintendo.c:403:29: error:
 'JC_RUMBLE_ZERO_AMP_PKT_CNT' defined but not used
Message-ID: <202202140412.ltmfle7c-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daniel,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   b81b1829e7e39f6cebdf6e4d5484eacbceda8554
commit: dad74e18f72a852ae40ad7b4246841a1b7e196b5 HID: nintendo: prevent needless queueing of the rumble worker
date:   4 months ago
config: parisc-randconfig-r024-20220213 (https://download.01.org/0day-ci/archive/20220214/202202140412.ltmfle7c-lkp@intel.com/config)
compiler: hppa-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=dad74e18f72a852ae40ad7b4246841a1b7e196b5
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout dad74e18f72a852ae40ad7b4246841a1b7e196b5
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=parisc SHELL=/bin/bash drivers/hid/ fs/notify/fanotify/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> drivers/hid/hid-nintendo.c:403:29: error: 'JC_RUMBLE_ZERO_AMP_PKT_CNT' defined but not used [-Werror=unused-const-variable=]
     403 | static const unsigned short JC_RUMBLE_ZERO_AMP_PKT_CNT = 5;
         |                             ^~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/hid/hid-nintendo.c:401:18: error: 'JC_RUMBLE_DFLT_HIGH_FREQ' defined but not used [-Werror=unused-const-variable=]
     401 | static const u16 JC_RUMBLE_DFLT_HIGH_FREQ = 320;
         |                  ^~~~~~~~~~~~~~~~~~~~~~~~
   drivers/hid/hid-nintendo.c:400:18: error: 'JC_RUMBLE_DFLT_LOW_FREQ' defined but not used [-Werror=unused-const-variable=]
     400 | static const u16 JC_RUMBLE_DFLT_LOW_FREQ = 160;
         |                  ^~~~~~~~~~~~~~~~~~~~~~~
   drivers/hid/hid-nintendo.c:254:44: error: 'joycon_rumble_amplitudes' defined but not used [-Werror=unused-const-variable=]
     254 | static const struct joycon_rumble_amp_data joycon_rumble_amplitudes[] = {
         |                                            ^~~~~~~~~~~~~~~~~~~~~~~~
   drivers/hid/hid-nintendo.c:196:45: error: 'joycon_rumble_frequencies' defined but not used [-Werror=unused-const-variable=]
     196 | static const struct joycon_rumble_freq_data joycon_rumble_frequencies[] = {
         |                                             ^~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/hid/hid-nintendo.c:99:17: error: 'JC_USB_SEND_UART' defined but not used [-Werror=unused-const-variable=]
      99 | static const u8 JC_USB_SEND_UART                = 0x92;
         |                 ^~~~~~~~~~~~~~~~
   drivers/hid/hid-nintendo.c:98:17: error: 'JC_USB_PRE_HANDSHAKE' defined but not used [-Werror=unused-const-variable=]
      98 | static const u8 JC_USB_PRE_HANDSHAKE            = 0x91;
         |                 ^~~~~~~~~~~~~~~~~~~~
   drivers/hid/hid-nintendo.c:97:17: error: 'JC_USB_RESET' defined but not used [-Werror=unused-const-variable=]
      97 | static const u8 JC_USB_RESET                    = 0x06;
         |                 ^~~~~~~~~~~~
   drivers/hid/hid-nintendo.c:96:17: error: 'JC_USB_CMD_EN_TIMEOUT' defined but not used [-Werror=unused-const-variable=]
      96 | static const u8 JC_USB_CMD_EN_TIMEOUT           = 0x05;
         |                 ^~~~~~~~~~~~~~~~~~~~~
   drivers/hid/hid-nintendo.c:92:17: error: 'JC_USB_CMD_CONN_STATUS' defined but not used [-Werror=unused-const-variable=]
      92 | static const u8 JC_USB_CMD_CONN_STATUS          = 0x01;
         |                 ^~~~~~~~~~~~~~~~~~~~~~
   drivers/hid/hid-nintendo.c:89:17: error: 'JC_FEATURE_LAUNCH' defined but not used [-Werror=unused-const-variable=]
      89 | static const u8 JC_FEATURE_LAUNCH               = 0x75;
         |                 ^~~~~~~~~~~~~~~~~
   drivers/hid/hid-nintendo.c:88:17: error: 'JC_FEATURE_MEM_WRITE' defined but not used [-Werror=unused-const-variable=]
      88 | static const u8 JC_FEATURE_MEM_WRITE            = 0x74;
         |                 ^~~~~~~~~~~~~~~~~~~~
   drivers/hid/hid-nintendo.c:87:17: error: 'JC_FEATURE_ERASE_MEM_SECTOR' defined but not used [-Werror=unused-const-variable=]
      87 | static const u8 JC_FEATURE_ERASE_MEM_SECTOR     = 0x73;
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/hid/hid-nintendo.c:86:17: error: 'JC_FEATURE_MEM_READ' defined but not used [-Werror=unused-const-variable=]
      86 | static const u8 JC_FEATURE_MEM_READ             = 0x72;
         |                 ^~~~~~~~~~~~~~~~~~~
   drivers/hid/hid-nintendo.c:85:17: error: 'JC_FEATURE_SETUP_MEM_READ' defined but not used [-Werror=unused-const-variable=]
      85 | static const u8 JC_FEATURE_SETUP_MEM_READ       = 0x71;
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/hid/hid-nintendo.c:84:17: error: 'JC_FEATURE_OTA_FW_UPGRADE' defined but not used [-Werror=unused-const-variable=]
      84 | static const u8 JC_FEATURE_OTA_FW_UPGRADE       = 0x70;
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/hid/hid-nintendo.c:83:17: error: 'JC_FEATURE_LAST_SUBCMD' defined but not used [-Werror=unused-const-variable=]
      83 | static const u8 JC_FEATURE_LAST_SUBCMD          = 0x02;
         |                 ^~~~~~~~~~~~~~~~~~~~~~
   drivers/hid/hid-nintendo.c:76:17: error: 'JC_INPUT_BUTTON_EVENT' defined but not used [-Werror=unused-const-variable=]
      76 | static const u8 JC_INPUT_BUTTON_EVENT           = 0x3F;
         |                 ^~~~~~~~~~~~~~~~~~~~~
   drivers/hid/hid-nintendo.c:73:17: error: 'JC_SUBCMD_GET_REGULATED_VOLTAGE' defined but not used [-Werror=unused-const-variable=]
      73 | static const u8 JC_SUBCMD_GET_REGULATED_VOLTAGE = 0x50;
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/hid/hid-nintendo.c:71:17: error: 'JC_SUBCMD_READ_IMU_REG' defined but not used [-Werror=unused-const-variable=]
      71 | static const u8 JC_SUBCMD_READ_IMU_REG          = 0x43;
         |                 ^~~~~~~~~~~~~~~~~~~~~~
   drivers/hid/hid-nintendo.c:70:17: error: 'JC_SUBCMD_WRITE_IMU_REG' defined but not used [-Werror=unused-const-variable=]
      70 | static const u8 JC_SUBCMD_WRITE_IMU_REG         = 0x42;
         |                 ^~~~~~~~~~~~~~~~~~~~~~~
   drivers/hid/hid-nintendo.c:69:17: error: 'JC_SUBCMD_SET_IMU_SENSITIVITY' defined but not used [-Werror=unused-const-variable=]
      69 | static const u8 JC_SUBCMD_SET_IMU_SENSITIVITY   = 0x41;
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/hid/hid-nintendo.c:66:17: error: 'JC_SUBCMD_GET_PLAYER_LIGHTS' defined but not used [-Werror=unused-const-variable=]
      66 | static const u8 JC_SUBCMD_GET_PLAYER_LIGHTS     = 0x31;
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/hid/hid-nintendo.c:64:17: error: 'JC_SUBCMD_SET_MCU_STATE' defined but not used [-Werror=unused-const-variable=]
      64 | static const u8 JC_SUBCMD_SET_MCU_STATE         = 0x22;
         |                 ^~~~~~~~~~~~~~~~~~~~~~~
   drivers/hid/hid-nintendo.c:63:17: error: 'JC_SUBCMD_SET_MCU_CONFIG' defined but not used [-Werror=unused-const-variable=]
      63 | static const u8 JC_SUBCMD_SET_MCU_CONFIG        = 0x21;
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~
   drivers/hid/hid-nintendo.c:62:17: error: 'JC_SUBCMD_RESET_MCU' defined but not used [-Werror=unused-const-variable=]
      62 | static const u8 JC_SUBCMD_RESET_MCU             = 0x20;
         |                 ^~~~~~~~~~~~~~~~~~~
   drivers/hid/hid-nintendo.c:61:17: error: 'JC_SUBCMD_SPI_FLASH_WRITE' defined but not used [-Werror=unused-const-variable=]
      61 | static const u8 JC_SUBCMD_SPI_FLASH_WRITE       = 0x11;
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/hid/hid-nintendo.c:59:17: error: 'JC_SUBCMD_LOW_POWER_MODE' defined but not used [-Werror=unused-const-variable=]
      59 | static const u8 JC_SUBCMD_LOW_POWER_MODE        = 0x08;
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~
   drivers/hid/hid-nintendo.c:58:17: error: 'JC_SUBCMD_RESET_PAIRING_INFO' defined but not used [-Werror=unused-const-variable=]
      58 | static const u8 JC_SUBCMD_RESET_PAIRING_INFO    = 0x07;
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/hid/hid-nintendo.c:57:17: error: 'JC_SUBCMD_SET_HCI_STATE' defined but not used [-Werror=unused-const-variable=]
      57 | static const u8 JC_SUBCMD_SET_HCI_STATE         = 0x06;
         |                 ^~~~~~~~~~~~~~~~~~~~~~~
   drivers/hid/hid-nintendo.c:56:17: error: 'JC_SUBCMD_GET_PAGE_LIST_STATE' defined but not used [-Werror=unused-const-variable=]
      56 | static const u8 JC_SUBCMD_GET_PAGE_LIST_STATE   = 0x05;
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/hid/hid-nintendo.c:55:17: error: 'JC_SUBCMD_TRIGGERS_ELAPSED' defined but not used [-Werror=unused-const-variable=]
      55 | static const u8 JC_SUBCMD_TRIGGERS_ELAPSED      = 0x04;
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/hid/hid-nintendo.c:52:17: error: 'JC_SUBCMD_MANUAL_BT_PAIRING' defined but not used [-Werror=unused-const-variable=]
      52 | static const u8 JC_SUBCMD_MANUAL_BT_PAIRING     = 0x01;
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/hid/hid-nintendo.c:51:17: error: 'JC_SUBCMD_STATE' defined but not used [-Werror=unused-const-variable=]
      51 | static const u8 JC_SUBCMD_STATE                 /*= 0x00*/;


vim +/JC_RUMBLE_ZERO_AMP_PKT_CNT +403 drivers/hid/hid-nintendo.c

   399	
   400	static const u16 JC_RUMBLE_DFLT_LOW_FREQ = 160;
   401	static const u16 JC_RUMBLE_DFLT_HIGH_FREQ = 320;
   402	static const u16 JC_RUMBLE_PERIOD_MS = 50;
 > 403	static const unsigned short JC_RUMBLE_ZERO_AMP_PKT_CNT = 5;
   404	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
