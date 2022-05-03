Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38B2D5187F4
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 17:09:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237989AbiECPL5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 11:11:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237957AbiECPLx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 11:11:53 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AC423B003
        for <linux-kernel@vger.kernel.org>; Tue,  3 May 2022 08:08:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651590499; x=1683126499;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=HIV7+BriOVIHhbMS5XwJ9TB/Dt1Tpi6juyaLYsRlF8Y=;
  b=AVaPUnNlfHHKmmcs0nVahxKgoIA1oxPRN/bhsE4BPy2nVSyen8sC0php
   ow/wQMvDZYyKci8V45vfvIIbeoP/7HjQbvXTDmiIs/+HDjZrrWW0FrZZ0
   LM76ohgZNQvpvx9ndGTUKT30K4bnzrWn2bhR3a8hncPB78ahGuZCpDVzj
   vkrfXXfhh6HpvBeT6XIoJ2owiDOtfqcf0sI5i8feo8bFcrHPijjYdHxPs
   K6VCQaeEFBX0bcp1JklJ3fyuAu4gg26g5RqnBKryzwRu2GqpoBvmDKBwp
   VfgFaTiz3fosu7PuexJqMzZMpsc9Kr/oJej43oX5yuZo/h1zwJYygxy9G
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10336"; a="249478606"
X-IronPort-AV: E=Sophos;i="5.91,195,1647327600"; 
   d="scan'208";a="249478606"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 May 2022 08:07:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,195,1647327600"; 
   d="scan'208";a="547626049"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 03 May 2022 08:07:53 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nlu80-000AYm-PI;
        Tue, 03 May 2022 15:07:52 +0000
Date:   Tue, 3 May 2022 23:06:56 +0800
From:   kernel test robot <lkp@intel.com>
To:     Hector Martin <marcan@marcan.st>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [asahilinux:bits/110-smc 13/14]
 drivers/input/misc/macsmc-hid.c:59:37: error: implicit declaration of
 function 'kernel_can_power_off'; did you mean 'kernel_power_off'?
Message-ID: <202205032215.0V3jamj1-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/AsahiLinux/linux bits/110-smc
head:   dc3db43287ff1d44b447fff8ed6386b28b339f1c
commit: 0f263115481acb56629afae7ff2bda87b8aef659 [13/14] Input: macsmc-hid: New driver to handle the Apple Mac SMC buttons/lid
config: arm64-randconfig-c003-20220501 (https://download.01.org/0day-ci/archive/20220503/202205032215.0V3jamj1-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/AsahiLinux/linux/commit/0f263115481acb56629afae7ff2bda87b8aef659
        git remote add asahilinux https://github.com/AsahiLinux/linux
        git fetch --no-tags asahilinux bits/110-smc
        git checkout 0f263115481acb56629afae7ff2bda87b8aef659
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=arm64 SHELL=/bin/bash

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

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
