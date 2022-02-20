Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75BB34BD0BC
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Feb 2022 19:48:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244551AbiBTSsP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Feb 2022 13:48:15 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:60024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243159AbiBTSsM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Feb 2022 13:48:12 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E005349FB2
        for <linux-kernel@vger.kernel.org>; Sun, 20 Feb 2022 10:47:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645382868; x=1676918868;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=A0YC4IFs3uhwPM9+UjiLnG4O5oYdtFNNf6iJs1TiruM=;
  b=JxmupjUHJh+JlhJ256v+fJWMUCK56ZqLaasydTzmNpKi9miYjRWDKul6
   D2On3VV5Ejtktlig7CezpScMy7ckyfDD7QUj+G7oJXgjdfr9bzhn/QBGn
   SBdN+/dOLPvsrRjKssAJEF7O2zYH06+UcBf0q1AdgtmpjjP05HJ6kQOdG
   GQSDZnIwLXD9CYjTHqfI0fZUQI+7G0VHp8fWfvTZNrOhZgxm7aaIxXs8T
   avvy7mF28UnFT+Wokfp8sic4aw54Tb4kTQELplktCJFJtKovRoL/4r8HJ
   C0bNMuV8Hny5xypukvxfLDG4b/4Ul0gRhoCeLDLWN2MOHRWIrghzjNhLR
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10264"; a="251146748"
X-IronPort-AV: E=Sophos;i="5.88,384,1635231600"; 
   d="scan'208";a="251146748"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2022 10:47:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,384,1635231600"; 
   d="scan'208";a="490222262"
Received: from lkp-server01.sh.intel.com (HELO da3212ac2f54) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 20 Feb 2022 10:47:46 -0800
Received: from kbuild by da3212ac2f54 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nLrFK-0000aw-6l; Sun, 20 Feb 2022 18:47:46 +0000
Date:   Mon, 21 Feb 2022 02:46:53 +0800
From:   kernel test robot <lkp@intel.com>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Hector Martin <marcan@marcan.st>
Subject: [asahilinux:bits/100-shutdown-notifier 20/20]
 drivers/regulator/pfuze100-regulator.c:619:6: error: 'pm_power_off_prepare'
 undeclared; did you mean 'pfuze_power_off_prepare'?
Message-ID: <202202210242.0zAHMGFJ-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/AsahiLinux/linux bits/100-shutdown-notifier
head:   cd8e473345d65a9162b255d1997fa89c86280cde
commit: cd8e473345d65a9162b255d1997fa89c86280cde [20/20] reboot: Remove pm_power_off_prepare()
config: x86_64-randconfig-a011 (https://download.01.org/0day-ci/archive/20220221/202202210242.0zAHMGFJ-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build):
        # https://github.com/AsahiLinux/linux/commit/cd8e473345d65a9162b255d1997fa89c86280cde
        git remote add asahilinux https://github.com/AsahiLinux/linux
        git fetch --no-tags asahilinux bits/100-shutdown-notifier
        git checkout cd8e473345d65a9162b255d1997fa89c86280cde
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   drivers/regulator/pfuze100-regulator.c: In function 'pfuze_power_off_prepare_init':
>> drivers/regulator/pfuze100-regulator.c:619:6: error: 'pm_power_off_prepare' undeclared (first use in this function); did you mean 'pfuze_power_off_prepare'?
     619 |  if (pm_power_off_prepare) {
         |      ^~~~~~~~~~~~~~~~~~~~
         |      pfuze_power_off_prepare
   drivers/regulator/pfuze100-regulator.c:619:6: note: each undeclared identifier is reported only once for each function it appears in
   drivers/regulator/pfuze100-regulator.c: In function 'pfuze100_regulator_remove':
   drivers/regulator/pfuze100-regulator.c:844:3: error: 'pm_power_off_prepare' undeclared (first use in this function); did you mean 'pfuze_power_off_prepare'?
     844 |   pm_power_off_prepare = NULL;
         |   ^~~~~~~~~~~~~~~~~~~~
         |   pfuze_power_off_prepare


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
