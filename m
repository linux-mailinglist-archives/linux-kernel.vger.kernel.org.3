Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 871934D292B
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 07:52:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230145AbiCIGw7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 01:52:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbiCIGw4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 01:52:56 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3764C163056
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 22:51:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646808718; x=1678344718;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=+SvHOOIm0sHoKCK6SR/TRj4bdu62kMvAYTbdx8WQCOw=;
  b=ck4yg2h3e9F812/lOEKTUjxtBnYduK6Q80hITftV06ZM8V3iJSv91zIX
   APeHzfZNYKnkRXLE6qSmiTTx1Ft8V1DP8zypHMUc4YwR0iaPutg4T2/F7
   xAkOpJF2VmLRZYii2dbP2kiK6IDphm9l4pPLgVXs8205KeV4EemUC3riz
   Sgd4vfOZUUqoasUTCxGpMs4FfSXCTtuD5+YXmo2bBubDRhc1UHBtKzZTJ
   hpqADP5kZPtEJlvl6RIGV9G8WH3uGfHGapzapW1lWdZM1dswZvx7o6EEH
   VoKarfrF9yqObhzbC0aoEnwJ+3C5P+kMSXwjLIw+Icgp2+Xgl+U4WYAtr
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10280"; a="242347280"
X-IronPort-AV: E=Sophos;i="5.90,167,1643702400"; 
   d="scan'208";a="242347280"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2022 22:51:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,167,1643702400"; 
   d="scan'208";a="643939365"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 08 Mar 2022 22:51:56 -0800
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nRqAt-0002ma-Vs; Wed, 09 Mar 2022 06:51:55 +0000
Date:   Wed, 9 Mar 2022 14:50:54 +0800
From:   kernel test robot <lkp@intel.com>
To:     Hector Martin <marcan@marcan.st>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [asahilinux:bits/110-smc 14/14]
 drivers/input/misc/macsmc-hid.c:59:37: error: implicit declaration of
 function 'kernel_can_power_off'; did you mean 'kernel_power_off'?
Message-ID: <202203091443.LMXLVF5Z-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/AsahiLinux/linux bits/110-smc
head:   fc585c48a7b76dfddc48b92c764b619a36435404
commit: fc585c48a7b76dfddc48b92c764b619a36435404 [14/14] Input: macsmc-hid: New driver to handle the Apple Mac SMC buttons/lid
config: arm64-randconfig-r031-20220307 (https://download.01.org/0day-ci/archive/20220309/202203091443.LMXLVF5Z-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/AsahiLinux/linux/commit/fc585c48a7b76dfddc48b92c764b619a36435404
        git remote add asahilinux https://github.com/AsahiLinux/linux
        git fetch --no-tags asahilinux bits/110-smc
        git checkout fc585c48a7b76dfddc48b92c764b619a36435404
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arm64 SHELL=/bin/bash drivers/input/misc/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   drivers/input/misc/macsmc-hid.c: In function 'macsmc_hid_event':
>> drivers/input/misc/macsmc-hid.c:59:37: error: implicit declaration of function 'kernel_can_power_off'; did you mean 'kernel_power_off'? [-Werror=implicit-function-declaration]
      59 |                                 if (kernel_can_power_off())
         |                                     ^~~~~~~~~~~~~~~~~~~~
         |                                     kernel_power_off
   cc1: some warnings being treated as errors


vim +59 drivers/input/misc/macsmc-hid.c

    29	
    30	static int macsmc_hid_event(struct notifier_block *nb, unsigned long event, void *data)
    31	{
    32		struct macsmc_hid *smchid = container_of(nb, struct macsmc_hid, nb);
    33		u16 type = event >> 16;
    34		u8 d1 = (event >> 8) & 0xff;
    35		u8 d2 = event & 0xff;
    36	
    37		switch (type) {
    38		case SMC_EV_BTN:
    39			switch (d1) {
    40			case BTN_POWER:
    41				input_report_key(smchid->input, KEY_POWER, d2);
    42				input_sync(smchid->input);
    43				break;
    44			case BTN_POWER_HELD1:
    45				/*
    46				 * TODO: is this pre-warning useful?
    47				 */
    48				if (d2)
    49					dev_warn(smchid->dev, "Power button held down\n");
    50				break;
    51			case BTN_POWER_HELD2:
    52				/*
    53				 * If we get here, we have about 4 seconds before forced shutdown.
    54				 * Try to do an emergency shutdown to make sure the NVMe cache is
    55				 * flushed. macOS actually does this by panicing (!)...
    56				 */
    57				if (d2) {
    58					dev_crit(smchid->dev, "Triggering forced shutdown!\n");
  > 59					if (kernel_can_power_off())
    60						kernel_power_off();
    61					else /* Missing macsmc-reboot driver? */
    62						kernel_restart("SMC power button triggered restart");
    63				}
    64				break;
    65			default:
    66				dev_info(smchid->dev, "Unknown SMC button event: %02x %02x\n", d1, d2);
    67				break;
    68			}
    69			return NOTIFY_OK;
    70		case SMC_EV_LID:
    71			input_report_switch(smchid->input, SW_LID, d1);
    72			input_sync(smchid->input);
    73			return NOTIFY_OK;
    74		}
    75	
    76		return NOTIFY_DONE;
    77	}
    78	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
