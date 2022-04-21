Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 488E250A39A
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 17:04:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1389864AbiDUPG0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 11:06:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1389851AbiDUPGO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 11:06:14 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33E5046141
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 08:03:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650553404; x=1682089404;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=GJ+vd38TSZpFdzPd6Omy3jFNZdiMOj1T/XsQ3o7W5N8=;
  b=FrOy/JJ/1h8pAPfXaMgeSP0LcRijFe0/FOX0P3RubG6YQ1ms278Odyj+
   8+7Z1Ib0B5KTr0pgB1iBzOUPcarbu/V4b6aqwBzJl9yu/s/zOVq6iwWIT
   gga4yjdCsKtEBWXrax3gebz9/H9XgjWT+B3BgMI5tT90FWF+l5NzvxJj/
   SDpbiy3DPdiPIB+80Lcssj6PMmR+cLMWTTQZa4l357TsszWm8mNYB/vkC
   2EGOLHAsfkHLbMK0oImr+ooyPCpbqvG15yR9V/3mIriDvxy4sh6hVB2TP
   NiV9qKbj6QRyqjq+lVEydOALRq+l/33ZyruZkg6JwLsW0nkhTTklRkKuB
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10324"; a="327277464"
X-IronPort-AV: E=Sophos;i="5.90,279,1643702400"; 
   d="scan'208";a="327277464"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2022 08:03:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,279,1643702400"; 
   d="scan'208";a="626544855"
Received: from lkp-server01.sh.intel.com (HELO 3abc53900bec) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 21 Apr 2022 08:03:21 -0700
Received: from kbuild by 3abc53900bec with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nhYL2-0008V7-Qv;
        Thu, 21 Apr 2022 15:03:20 +0000
Date:   Thu, 21 Apr 2022 23:02:30 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [mingo-tip:sched/headers 2453/2579]
 drivers/media/tuners/xc2028.c:46:21: error: expected identifier
Message-ID: <202204212259.kughfomJ-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git sched/headers
head:   49e1ec6c70a6eb4b7de9250a455b8b63eb42afbe
commit: 2038c03daa4310f7cee8937d18f4514749cb40ab [2453/2579] headers/deps: driver/core: Optimize <linux/device/driver.h> dependencies, remove <linux/module.h> inclusion
config: mips-randconfig-r026-20220419 (https://download.01.org/0day-ci/archive/20220421/202204212259.kughfomJ-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project c1c49a356162b22554088d269f7689bdb044a9f1)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install mips cross compiling tool for clang build
        # apt-get install binutils-mips-linux-gnu
        # https://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git/commit/?id=2038c03daa4310f7cee8937d18f4514749cb40ab
        git remote add mingo-tip git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git
        git fetch --no-tags mingo-tip sched/headers
        git checkout 2038c03daa4310f7cee8937d18f4514749cb40ab
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=mips SHELL=/bin/bash drivers/media/tuners/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> drivers/media/tuners/xc2028.c:46:21: error: expected identifier
   module_param(debug, int, 0644);
                       ^
>> drivers/media/tuners/xc2028.c:46:1: error: type specifier missing, defaults to 'int' [-Werror,-Wimplicit-int]
   module_param(debug, int, 0644);
   ^
>> drivers/media/tuners/xc2028.c:46:13: error: a function declaration without a prototype is deprecated in all versions of C [-Werror,-Wstrict-prototypes]
   module_param(debug, int, 0644);
               ^
                                void
   drivers/media/tuners/xc2028.c:47:25: error: expected identifier
   MODULE_PARM_DESC(debug, "enable verbose debug messages");
                           ^
   drivers/media/tuners/xc2028.c:47:1: error: type specifier missing, defaults to 'int' [-Werror,-Wimplicit-int]
   MODULE_PARM_DESC(debug, "enable verbose debug messages");
   ^
   drivers/media/tuners/xc2028.c:47:17: error: a function declaration without a prototype is deprecated in all versions of C [-Werror,-Wstrict-prototypes]
   MODULE_PARM_DESC(debug, "enable verbose debug messages");
                   ^
                                                          void
   drivers/media/tuners/xc2028.c:50:27: error: expected identifier
   module_param(no_poweroff, int, 0644);
                             ^
   drivers/media/tuners/xc2028.c:50:1: error: type specifier missing, defaults to 'int' [-Werror,-Wimplicit-int]
   module_param(no_poweroff, int, 0644);
   ^
   drivers/media/tuners/xc2028.c:50:13: error: a function declaration without a prototype is deprecated in all versions of C [-Werror,-Wstrict-prototypes]
   module_param(no_poweroff, int, 0644);
               ^
                                      void
   drivers/media/tuners/xc2028.c:51:31: error: expected identifier
   MODULE_PARM_DESC(no_poweroff, "0 (default) powers device off when not used.\n"
                                 ^
   drivers/media/tuners/xc2028.c:51:1: error: type specifier missing, defaults to 'int' [-Werror,-Wimplicit-int]
   MODULE_PARM_DESC(no_poweroff, "0 (default) powers device off when not used.\n"
   ^
   drivers/media/tuners/xc2028.c:51:17: error: a function declaration without a prototype is deprecated in all versions of C [-Werror,-Wstrict-prototypes]
   MODULE_PARM_DESC(no_poweroff, "0 (default) powers device off when not used.\n"
                   ^
>> drivers/media/tuners/xc2028.c:56:32: error: redefinition of parameter 'audio_std'
   module_param_string(audio_std, audio_std, sizeof(audio_std), 0);
                                  ^
   drivers/media/tuners/xc2028.c:56:43: error: expected identifier
   module_param_string(audio_std, audio_std, sizeof(audio_std), 0);
                                             ^
   drivers/media/tuners/xc2028.c:56:1: error: type specifier missing, defaults to 'int' [-Werror,-Wimplicit-int]
   module_param_string(audio_std, audio_std, sizeof(audio_std), 0);
   ^
   drivers/media/tuners/xc2028.c:56:20: error: a function declaration without a prototype is deprecated in all versions of C [-Werror,-Wstrict-prototypes]
   module_param_string(audio_std, audio_std, sizeof(audio_std), 0);
                      ^
                                                                 void
   drivers/media/tuners/xc2028.c:58:2: error: expected identifier
           "Audio standard. XC3028 audio decoder explicitly needs to know what audio\n"
           ^
   drivers/media/tuners/xc2028.c:57:1: error: type specifier missing, defaults to 'int' [-Werror,-Wimplicit-int]
   MODULE_PARM_DESC(audio_std,
   ^
   drivers/media/tuners/xc2028.c:57:17: error: a function declaration without a prototype is deprecated in all versions of C [-Werror,-Wstrict-prototypes]
   MODULE_PARM_DESC(audio_std,
                   ^
   fatal error: too many errors emitted, stopping now [-ferror-limit=]
   20 errors generated.


vim +46 drivers/media/tuners/xc2028.c

ef8c1888b32132 drivers/media/video/tuner-xc2028.c         Mauro Carvalho Chehab 2007-11-16  44  
83fb340b318487 drivers/media/video/tuner-xc2028.c         Mauro Carvalho Chehab 2007-11-15  45  static int debug;
83fb340b318487 drivers/media/video/tuner-xc2028.c         Mauro Carvalho Chehab 2007-11-15 @46  module_param(debug, int, 0644);
83fb340b318487 drivers/media/video/tuner-xc2028.c         Mauro Carvalho Chehab 2007-11-15  47  MODULE_PARM_DESC(debug, "enable verbose debug messages");
83fb340b318487 drivers/media/video/tuner-xc2028.c         Mauro Carvalho Chehab 2007-11-15  48  
74a89b2ae352ac drivers/media/common/tuners/tuner-xc2028.c Mauro Carvalho Chehab 2008-12-05  49  static int no_poweroff;
74a89b2ae352ac drivers/media/common/tuners/tuner-xc2028.c Mauro Carvalho Chehab 2008-12-05  50  module_param(no_poweroff, int, 0644);
4900877b7cdcb8 drivers/media/common/tuners/tuner-xc2028.c Devin Heitmueller     2009-04-28 @51  MODULE_PARM_DESC(no_poweroff, "0 (default) powers device off when not used.\n"
74a89b2ae352ac drivers/media/common/tuners/tuner-xc2028.c Mauro Carvalho Chehab 2008-12-05  52  	"1 keep device energized and with tuner ready all the times.\n"
74a89b2ae352ac drivers/media/common/tuners/tuner-xc2028.c Mauro Carvalho Chehab 2008-12-05  53  	"  Faster, but consumes more power and keeps the device hotter\n");
74a89b2ae352ac drivers/media/common/tuners/tuner-xc2028.c Mauro Carvalho Chehab 2008-12-05  54  
a82200fb59e7d1 drivers/media/video/tuner-xc2028.c         Mauro Carvalho Chehab 2007-11-15  55  static char audio_std[8];
a82200fb59e7d1 drivers/media/video/tuner-xc2028.c         Mauro Carvalho Chehab 2007-11-15 @56  module_param_string(audio_std, audio_std, sizeof(audio_std), 0);
a82200fb59e7d1 drivers/media/video/tuner-xc2028.c         Mauro Carvalho Chehab 2007-11-15  57  MODULE_PARM_DESC(audio_std,
2af3eb647e9b90 drivers/media/tuners/tuner-xc2028.c        Mauro Carvalho Chehab 2016-10-12  58  	"Audio standard. XC3028 audio decoder explicitly needs to know what audio\n"
a82200fb59e7d1 drivers/media/video/tuner-xc2028.c         Mauro Carvalho Chehab 2007-11-15  59  	"standard is needed for some video standards with audio A2 or NICAM.\n"
a82200fb59e7d1 drivers/media/video/tuner-xc2028.c         Mauro Carvalho Chehab 2007-11-15  60  	"The valid values are:\n"
a82200fb59e7d1 drivers/media/video/tuner-xc2028.c         Mauro Carvalho Chehab 2007-11-15  61  	"A2\n"
a82200fb59e7d1 drivers/media/video/tuner-xc2028.c         Mauro Carvalho Chehab 2007-11-15  62  	"A2/A\n"
a82200fb59e7d1 drivers/media/video/tuner-xc2028.c         Mauro Carvalho Chehab 2007-11-15  63  	"A2/B\n"
a82200fb59e7d1 drivers/media/video/tuner-xc2028.c         Mauro Carvalho Chehab 2007-11-15  64  	"NICAM\n"
a82200fb59e7d1 drivers/media/video/tuner-xc2028.c         Mauro Carvalho Chehab 2007-11-15  65  	"NICAM/A\n"
a82200fb59e7d1 drivers/media/video/tuner-xc2028.c         Mauro Carvalho Chehab 2007-11-15  66  	"NICAM/B\n");
a82200fb59e7d1 drivers/media/video/tuner-xc2028.c         Mauro Carvalho Chehab 2007-11-15  67  

:::::: The code at line 46 was first introduced by commit
:::::: 83fb340b3184875a63564ea174350b1d1b081874 V4L/DVB (6595): Corrects printk lines

:::::: TO: Mauro Carvalho Chehab <mchehab@infradead.org>
:::::: CC: Mauro Carvalho Chehab <mchehab@infradead.org>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
