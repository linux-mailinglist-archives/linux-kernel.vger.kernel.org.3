Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22D65533326
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 23:57:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242001AbiEXV5W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 17:57:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241573AbiEXV5S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 17:57:18 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22C814D241
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 14:57:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653429435; x=1684965435;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=/9o0cWaHBe+UGRCaonZZRaUL83aCe5I8+U49Ha2EVzE=;
  b=P9IkNamf7Ak4RsV7UfxQIL5D3UiIJHPZDygdoWKBJZCUYgm+Tf+G2siS
   iO2rACFw1f2rsz41ocPXf/932jH4j0290OCPXkTPox/3t3IxlitJexsBI
   4vDvNzCeCO2PlJiM09EONlGSGAkZKozTs36zhMRhXgkV9yQt+M8FC9ZiF
   LfJv4WMgX+vx3G64XkUqkrp1vuvA43oXtjHqq+7lpBnrSFIb+jiHO+yNT
   3vSlfOqmOo3OpcyTlXECvyYph92ekHiJm1isonb80qYJ5NPS06rhCAdru
   zCnewaM8ntPx1/+3MCsJcKKihMQdZsOYkmfzAVhKPwR+YSVurUocQwaKv
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10357"; a="336713584"
X-IronPort-AV: E=Sophos;i="5.91,250,1647327600"; 
   d="scan'208";a="336713584"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 May 2022 14:57:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,250,1647327600"; 
   d="scan'208";a="642111804"
Received: from lkp-server01.sh.intel.com (HELO db63a1be7222) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 24 May 2022 14:57:13 -0700
Received: from kbuild by db63a1be7222 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1ntcWe-0002U8-Fl;
        Tue, 24 May 2022 21:57:12 +0000
Date:   Wed, 25 May 2022 05:56:34 +0800
From:   kernel test robot <lkp@intel.com>
To:     Hector Martin <marcan@marcan.st>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [asahilinux:bits/110-smc 13/15]
 drivers/input/misc/macsmc-hid.c:59:37: error: implicit declaration of
 function 'kernel_can_power_off'; did you mean 'kernel_power_off'?
Message-ID: <202205250557.YFfxlRna-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/AsahiLinux/linux bits/110-smc
head:   0a0b49938a3205cb2b05078117b87673c37ed319
commit: 48118a73e5717c0717e398fcee5941b0d18efad9 [13/15] Input: macsmc-hid: New driver to handle the Apple Mac SMC buttons/lid
config: arc-allyesconfig (https://download.01.org/0day-ci/archive/20220525/202205250557.YFfxlRna-lkp@intel.com/config)
compiler: arceb-elf-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/AsahiLinux/linux/commit/48118a73e5717c0717e398fcee5941b0d18efad9
        git remote add asahilinux https://github.com/AsahiLinux/linux
        git fetch --no-tags asahilinux bits/110-smc
        git checkout 48118a73e5717c0717e398fcee5941b0d18efad9
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=arc SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
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
