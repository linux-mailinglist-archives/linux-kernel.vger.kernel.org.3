Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C45C4C97BD
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 22:24:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238578AbiCAVZU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 16:25:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233428AbiCAVZS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 16:25:18 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8363E59A6E
        for <linux-kernel@vger.kernel.org>; Tue,  1 Mar 2022 13:24:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646169876; x=1677705876;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=JZLioDVKS6LuehJBIZDO24RmEJXeYF9yp3vaFn2IdAs=;
  b=HU1Sud7/z4HP0hKM61lAJjcB09uRYHN0++kJAABjdAXKV67xjeTa5EsA
   qxN1bMaXaG3peqAIDE2GRrEApoP6WAeFe1zyO8A4QAukXgncvaa5NpotR
   7uMvLH9r2Z0ONFbOcTJ099U8Ip10S6u9NImF9vipnp92jUG/aXKW00Dpj
   HyyvLVpJAPEyOXD9ur5jh/rH+69YJ7Pe1+X/6wwEHK9jC7eSEZTR/faHr
   m8JA36qZDxNK+hW1RKdoEh+dsW3XJW887nJ4Xry8oRENwC41zZ9ByHpgj
   982AEE2OSQqIr4K4NUzmoCaJ4CfzTtl/HYU5PyhkVjgukMqo28xdKKwXl
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10273"; a="236754318"
X-IronPort-AV: E=Sophos;i="5.90,146,1643702400"; 
   d="scan'208";a="236754318"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2022 13:24:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,146,1643702400"; 
   d="scan'208";a="778602654"
Received: from lkp-server01.sh.intel.com (HELO 2146afe809fb) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 01 Mar 2022 13:24:33 -0800
Received: from kbuild by 2146afe809fb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nP9yz-00013P-7k; Tue, 01 Mar 2022 21:24:33 +0000
Date:   Wed, 2 Mar 2022 05:24:09 +0800
From:   kernel test robot <lkp@intel.com>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Subject: [ammarfaizi2-block:axboe/linux-block/m1/2022-03-01 322/355]
 drivers/regulator/pfuze100-regulator.c:619:6: error: use of undeclared
 identifier 'pm_power_off_prepare'; did you mean 'pfuze_power_off_prepare'?
Message-ID: <202203020538.0AuLqib9-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ammarfaizi2/linux-block axboe/linux-block/m1/2022-03-01
head:   d7cc9472c1c5430d7caa806e8180d2359ea46266
commit: 4d1ed10a5e4b5553438f02ca438904fc8c2dcccf [322/355] reboot: Remove pm_power_off_prepare()
config: hexagon-randconfig-r045-20220301 (https://download.01.org/0day-ci/archive/20220302/202203020538.0AuLqib9-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project d271fc04d5b97b12e6b797c6067d3c96a8d7470e)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/ammarfaizi2/linux-block/commit/4d1ed10a5e4b5553438f02ca438904fc8c2dcccf
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block axboe/linux-block/m1/2022-03-01
        git checkout 4d1ed10a5e4b5553438f02ca438904fc8c2dcccf
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=hexagon SHELL=/bin/bash drivers/regulator/

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
