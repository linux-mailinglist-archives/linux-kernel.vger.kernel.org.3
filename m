Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E89854C97D5
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 22:35:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237539AbiCAVgW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 16:36:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230285AbiCAVgS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 16:36:18 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 857555D1B4
        for <linux-kernel@vger.kernel.org>; Tue,  1 Mar 2022 13:35:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646170536; x=1677706536;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=4Bi6fnPrZXakhrwjSxqca61gBC1Z37lcSnNOYzaOfuU=;
  b=DzlbAvzUdZpx33dQzcZ7GEOTJL3LfUkX56nyu9B1ege7b6Ip7f7bLRA5
   gb0LDbD5QXIyZ6Gt6P2Y8INTzkAS3fe3JWqJu7AMzdwewibL7LBURPLBV
   yRhXwkGPR2VSU7DJ42pH8uDLckAzoADktUJE0PBZSTX8hSwiLLXo135Ry
   osNUXw32W1Ru5FO4FFt0Rn01tdLqhkEkJoTcmTFldYZDDZjZ6aEQ/mzsA
   xpYZ9TJvMFR+a+xpwYGD7hLGXNDPy6oEEA3iWblCgUIpYBG0SR8zXPol9
   /UDPhtutSYNc4AhtT6K/n4rrqa9MBoh2kXVgvmvux5XF8ERL1J3R8Pigq
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10273"; a="252081013"
X-IronPort-AV: E=Sophos;i="5.90,146,1643702400"; 
   d="scan'208";a="252081013"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2022 13:35:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,146,1643702400"; 
   d="scan'208";a="641432337"
Received: from lkp-server01.sh.intel.com (HELO 2146afe809fb) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 01 Mar 2022 13:35:34 -0800
Received: from kbuild by 2146afe809fb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nPA9d-00013n-DG; Tue, 01 Mar 2022 21:35:33 +0000
Date:   Wed, 2 Mar 2022 05:34:34 +0800
From:   kernel test robot <lkp@intel.com>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Subject: [ammarfaizi2-block:axboe/linux-block/m1/2022-03-01 322/355]
 drivers/regulator/pfuze100-regulator.c:619:13: error: 'pm_power_off_prepare'
 undeclared; did you mean 'pfuze_power_off_prepare'?
Message-ID: <202203020533.d8b6pI7R-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ammarfaizi2/linux-block axboe/linux-block/m1/2022-03-01
head:   d7cc9472c1c5430d7caa806e8180d2359ea46266
commit: 4d1ed10a5e4b5553438f02ca438904fc8c2dcccf [322/355] reboot: Remove pm_power_off_prepare()
config: arc-randconfig-r043-20220301 (https://download.01.org/0day-ci/archive/20220302/202203020533.d8b6pI7R-lkp@intel.com/config)
compiler: arc-elf-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/ammarfaizi2/linux-block/commit/4d1ed10a5e4b5553438f02ca438904fc8c2dcccf
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block axboe/linux-block/m1/2022-03-01
        git checkout 4d1ed10a5e4b5553438f02ca438904fc8c2dcccf
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arc SHELL=/bin/bash drivers/regulator/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   drivers/regulator/pfuze100-regulator.c: In function 'pfuze_power_off_prepare_init':
>> drivers/regulator/pfuze100-regulator.c:619:13: error: 'pm_power_off_prepare' undeclared (first use in this function); did you mean 'pfuze_power_off_prepare'?
     619 |         if (pm_power_off_prepare) {
         |             ^~~~~~~~~~~~~~~~~~~~
         |             pfuze_power_off_prepare
   drivers/regulator/pfuze100-regulator.c:619:13: note: each undeclared identifier is reported only once for each function it appears in
   drivers/regulator/pfuze100-regulator.c: In function 'pfuze100_regulator_remove':
   drivers/regulator/pfuze100-regulator.c:844:17: error: 'pm_power_off_prepare' undeclared (first use in this function); did you mean 'pfuze_power_off_prepare'?
     844 |                 pm_power_off_prepare = NULL;
         |                 ^~~~~~~~~~~~~~~~~~~~
         |                 pfuze_power_off_prepare


vim +619 drivers/regulator/pfuze100-regulator.c

c29daffa322ad36 Oleksij Rempel 2018-08-02  611  
c29daffa322ad36 Oleksij Rempel 2018-08-02  612  static int pfuze_power_off_prepare_init(struct pfuze_chip *pfuze_chip)
c29daffa322ad36 Oleksij Rempel 2018-08-02  613  {
c29daffa322ad36 Oleksij Rempel 2018-08-02  614  	if (pfuze_chip->chip_id != PFUZE100) {
c29daffa322ad36 Oleksij Rempel 2018-08-02  615  		dev_warn(pfuze_chip->dev, "Requested pm_power_off_prepare handler for not supported chip\n");
c29daffa322ad36 Oleksij Rempel 2018-08-02  616  		return -ENODEV;
c29daffa322ad36 Oleksij Rempel 2018-08-02  617  	}
c29daffa322ad36 Oleksij Rempel 2018-08-02  618  
c29daffa322ad36 Oleksij Rempel 2018-08-02 @619  	if (pm_power_off_prepare) {
c29daffa322ad36 Oleksij Rempel 2018-08-02  620  		dev_warn(pfuze_chip->dev, "pm_power_off_prepare is already registered.\n");
c29daffa322ad36 Oleksij Rempel 2018-08-02  621  		return -EBUSY;
c29daffa322ad36 Oleksij Rempel 2018-08-02  622  	}
c29daffa322ad36 Oleksij Rempel 2018-08-02  623  
c29daffa322ad36 Oleksij Rempel 2018-08-02  624  	if (syspm_pfuze_chip) {
c29daffa322ad36 Oleksij Rempel 2018-08-02  625  		dev_warn(pfuze_chip->dev, "syspm_pfuze_chip is already set.\n");
c29daffa322ad36 Oleksij Rempel 2018-08-02  626  		return -EBUSY;
c29daffa322ad36 Oleksij Rempel 2018-08-02  627  	}
c29daffa322ad36 Oleksij Rempel 2018-08-02  628  
c29daffa322ad36 Oleksij Rempel 2018-08-02  629  	syspm_pfuze_chip = pfuze_chip;
c29daffa322ad36 Oleksij Rempel 2018-08-02  630  	pm_power_off_prepare = pfuze_power_off_prepare;
c29daffa322ad36 Oleksij Rempel 2018-08-02  631  
c29daffa322ad36 Oleksij Rempel 2018-08-02  632  	return 0;
c29daffa322ad36 Oleksij Rempel 2018-08-02  633  }
c29daffa322ad36 Oleksij Rempel 2018-08-02  634  

:::::: The code at line 619 was first introduced by commit
:::::: c29daffa322ad36978cbce487f8ebcd9c3c3f7c0 regulator: pfuze100-regulator: provide pm_power_off_prepare handler

:::::: TO: Oleksij Rempel <o.rempel@pengutronix.de>
:::::: CC: Mark Brown <broonie@kernel.org>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
