Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BD224BD23C
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Feb 2022 23:27:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243402AbiBTWZX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Feb 2022 17:25:23 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:44424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230124AbiBTWZV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Feb 2022 17:25:21 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDB784B422
        for <linux-kernel@vger.kernel.org>; Sun, 20 Feb 2022 14:24:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645395898; x=1676931898;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=8yVec26YHClupi0fsuGFWOpxfzI/CfAdr+fJvawyFx0=;
  b=eu+WlwjoeHTMGSyGHxJvyn6ME6ZCLR+z/xRE6NhD/Zou0+qeCd8tZfdX
   mHwzCmWJfyhDi/69G1nyFnrMYNGV94wZCoR6tUTT2niKMQTaDIFRChhqT
   U/Nfb10BIOJoo6EHGCk3+APwz+iLBZ6CWskMOpF+lr/DxaXb0YJk/g2LK
   YGPUiR/55o0M1BN+RReySaO8YOJqtkL5GqKaYVzWwX/FHCto1kGFZqfsi
   E/Dz79wXr+Ai5/ErfvT1x9EpQsJVREirHCSYc4WwJ1XJzr2UrYzO07xyR
   3Huc/xSJos4tNhwzFXVYlImaK7nA2BsmxPYWtzk5wld+/2yOfnfOcCbRx
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10264"; a="234946937"
X-IronPort-AV: E=Sophos;i="5.88,384,1635231600"; 
   d="scan'208";a="234946937"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2022 14:24:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,384,1635231600"; 
   d="scan'208";a="547098710"
Received: from lkp-server01.sh.intel.com (HELO da3212ac2f54) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 20 Feb 2022 14:24:55 -0800
Received: from kbuild by da3212ac2f54 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nLudS-0000vp-Sv; Sun, 20 Feb 2022 22:24:54 +0000
Date:   Mon, 21 Feb 2022 06:24:47 +0800
From:   kernel test robot <lkp@intel.com>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Hector Martin <marcan@marcan.st>
Subject: [asahilinux:bits/100-shutdown-notifier 20/20]
 drivers/regulator/pfuze100-regulator.c:619:6: error: use of undeclared
 identifier 'pm_power_off_prepare'; did you mean 'pfuze_power_off_prepare'?
Message-ID: <202202210643.6maPZZt9-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/AsahiLinux/linux bits/100-shutdown-notifier
head:   cd8e473345d65a9162b255d1997fa89c86280cde
commit: cd8e473345d65a9162b255d1997fa89c86280cde [20/20] reboot: Remove pm_power_off_prepare()
config: x86_64-randconfig-a012 (https://download.01.org/0day-ci/archive/20220221/202202210643.6maPZZt9-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project d271fc04d5b97b12e6b797c6067d3c96a8d7470e)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/AsahiLinux/linux/commit/cd8e473345d65a9162b255d1997fa89c86280cde
        git remote add asahilinux https://github.com/AsahiLinux/linux
        git fetch --no-tags asahilinux bits/100-shutdown-notifier
        git checkout cd8e473345d65a9162b255d1997fa89c86280cde
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash drivers/regulator/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> drivers/regulator/pfuze100-regulator.c:619:6: error: use of undeclared identifier 'pm_power_off_prepare'; did you mean 'pfuze_power_off_prepare'?
           if (pm_power_off_prepare) {
               ^~~~~~~~~~~~~~~~~~~~
               pfuze_power_off_prepare
   drivers/regulator/pfuze100-regulator.c:574:13: note: 'pfuze_power_off_prepare' declared here
   static void pfuze_power_off_prepare(void)
               ^
   drivers/regulator/pfuze100-regulator.c:630:2: error: use of undeclared identifier 'pm_power_off_prepare'
           pm_power_off_prepare = pfuze_power_off_prepare;
           ^
   drivers/regulator/pfuze100-regulator.c:844:3: error: use of undeclared identifier 'pm_power_off_prepare'
                   pm_power_off_prepare = NULL;
                   ^
   3 errors generated.


vim +619 drivers/regulator/pfuze100-regulator.c

c29daffa322ad3 Oleksij Rempel 2018-08-02  611  
c29daffa322ad3 Oleksij Rempel 2018-08-02  612  static int pfuze_power_off_prepare_init(struct pfuze_chip *pfuze_chip)
c29daffa322ad3 Oleksij Rempel 2018-08-02  613  {
c29daffa322ad3 Oleksij Rempel 2018-08-02  614  	if (pfuze_chip->chip_id != PFUZE100) {
c29daffa322ad3 Oleksij Rempel 2018-08-02  615  		dev_warn(pfuze_chip->dev, "Requested pm_power_off_prepare handler for not supported chip\n");
c29daffa322ad3 Oleksij Rempel 2018-08-02  616  		return -ENODEV;
c29daffa322ad3 Oleksij Rempel 2018-08-02  617  	}
c29daffa322ad3 Oleksij Rempel 2018-08-02  618  
c29daffa322ad3 Oleksij Rempel 2018-08-02 @619  	if (pm_power_off_prepare) {
c29daffa322ad3 Oleksij Rempel 2018-08-02  620  		dev_warn(pfuze_chip->dev, "pm_power_off_prepare is already registered.\n");
c29daffa322ad3 Oleksij Rempel 2018-08-02  621  		return -EBUSY;
c29daffa322ad3 Oleksij Rempel 2018-08-02  622  	}
c29daffa322ad3 Oleksij Rempel 2018-08-02  623  
c29daffa322ad3 Oleksij Rempel 2018-08-02  624  	if (syspm_pfuze_chip) {
c29daffa322ad3 Oleksij Rempel 2018-08-02  625  		dev_warn(pfuze_chip->dev, "syspm_pfuze_chip is already set.\n");
c29daffa322ad3 Oleksij Rempel 2018-08-02  626  		return -EBUSY;
c29daffa322ad3 Oleksij Rempel 2018-08-02  627  	}
c29daffa322ad3 Oleksij Rempel 2018-08-02  628  
c29daffa322ad3 Oleksij Rempel 2018-08-02  629  	syspm_pfuze_chip = pfuze_chip;
c29daffa322ad3 Oleksij Rempel 2018-08-02  630  	pm_power_off_prepare = pfuze_power_off_prepare;
c29daffa322ad3 Oleksij Rempel 2018-08-02  631  
c29daffa322ad3 Oleksij Rempel 2018-08-02  632  	return 0;
c29daffa322ad3 Oleksij Rempel 2018-08-02  633  }
c29daffa322ad3 Oleksij Rempel 2018-08-02  634  

:::::: The code at line 619 was first introduced by commit
:::::: c29daffa322ad36978cbce487f8ebcd9c3c3f7c0 regulator: pfuze100-regulator: provide pm_power_off_prepare handler

:::::: TO: Oleksij Rempel <o.rempel@pengutronix.de>
:::::: CC: Mark Brown <broonie@kernel.org>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
