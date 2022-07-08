Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81B3656B1ED
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 07:00:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237155AbiGHE7j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 00:59:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236708AbiGHE7j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 00:59:39 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5358376EAA
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jul 2022 21:59:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657256378; x=1688792378;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=ZtDYUcj6AmC/7C4R9y2OR/dhEz5H0ngqoyDYn+aKV58=;
  b=OhzzEGz4BdTIj2Qq7q5tDWbSsROwKqSobawJ/puUhJiSnbzuL21awNP8
   GsAU44+k3kSbv+Nyv2bWIRDBZUPEoISCzH4CNnE6UCXU2bIvOg3+8njRI
   TPuIe53gn5TOUCG4GBKlUvBF4eriNewsBMT2/Sk/Wifn0iVALknykxRRo
   zVfcMWiuC8Kte2DJLf/CXxg1drtOYwc3sPdV00y3DpMD4JXTe08cf/am6
   LhzKksSQU6iZbid/6u6o1VOknqO0TF75AZJCVbsne5aY/DPR7h1o2JLNQ
   bdTRuIPMEbInwTs9waS5xPI6zuSOetAc6QTkQuTzQuWwl10e+pEXaCuOj
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10401"; a="281739729"
X-IronPort-AV: E=Sophos;i="5.92,254,1650956400"; 
   d="scan'208";a="281739729"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2022 21:59:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,254,1650956400"; 
   d="scan'208";a="736212744"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 07 Jul 2022 21:59:25 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o9g5M-000MwO-LX;
        Fri, 08 Jul 2022 04:59:24 +0000
Date:   Fri, 8 Jul 2022 12:58:38 +0800
From:   kernel test robot <lkp@intel.com>
To:     Hector Martin <marcan@marcan.st>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [asahilinux:t8112/bringup 8/19] drivers/iommu/apple-dart.c:1075:64:
 error: too few arguments provided to function-like macro invocation
Message-ID: <202207081257.fudLBidd-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/AsahiLinux/linux t8112/bringup
head:   0e7640fed025ba0ce4b845a0bbf2a5fdceab631d
commit: d6138d6b66705917ed95ced5735b41387a6c378d [8/19] iommu: dart: Support different variants with different registers
config: arm64-buildonly-randconfig-r006-20220707 (https://download.01.org/0day-ci/archive/20220708/202207081257.fudLBidd-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 562c3467a6738aa89203f72fc1d1343e5baadf3c)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm64 cross compiling tool for clang build
        # apt-get install binutils-aarch64-linux-gnu
        # https://github.com/AsahiLinux/linux/commit/d6138d6b66705917ed95ced5735b41387a6c378d
        git remote add asahilinux https://github.com/AsahiLinux/linux
        git fetch --no-tags asahilinux t8112/bringup
        git checkout d6138d6b66705917ed95ced5735b41387a6c378d
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm64 SHELL=/bin/bash drivers/hid/ drivers/iommu/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> drivers/iommu/apple-dart.c:1075:64: error: too few arguments provided to function-like macro invocation
                   dart->save_tcr[sid] = readl_relaxed(dart->regs + DART_TCR(sid));
                                                                                ^
   drivers/iommu/apple-dart.c:87:9: note: macro 'DART_TCR' defined here
   #define DART_TCR(dart, sid) ((dart)->hw->tcr + ((sid) << 2))
           ^
>> drivers/iommu/apple-dart.c:1075:52: error: use of undeclared identifier 'DART_TCR'
                   dart->save_tcr[sid] = readl_relaxed(dart->regs + DART_TCR(sid));
                                                                    ^
>> drivers/iommu/apple-dart.c:1075:52: error: use of undeclared identifier 'DART_TCR'
>> drivers/iommu/apple-dart.c:1075:52: error: use of undeclared identifier 'DART_TCR'
>> drivers/iommu/apple-dart.c:1075:52: error: use of undeclared identifier 'DART_TCR'
>> drivers/iommu/apple-dart.c:1075:52: error: use of undeclared identifier 'DART_TCR'
>> drivers/iommu/apple-dart.c:1075:52: error: use of undeclared identifier 'DART_TCR'
   drivers/iommu/apple-dart.c:1100:64: error: too few arguments provided to function-like macro invocation
                   writel_relaxed(dart->save_tcr[sid], dart->regs + DART_TCR(sid));
                                                                                ^
   drivers/iommu/apple-dart.c:87:9: note: macro 'DART_TCR' defined here
   #define DART_TCR(dart, sid) ((dart)->hw->tcr + ((sid) << 2))
           ^
   drivers/iommu/apple-dart.c:1100:52: error: use of undeclared identifier 'DART_TCR'
                   writel_relaxed(dart->save_tcr[sid], dart->regs + DART_TCR(sid));
                                                                    ^
   9 errors generated.

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for APPLE_ADMAC
   Depends on DMADEVICES && (ARCH_APPLE || COMPILE_TEST
   Selected by
   - SND_SOC_APPLE_MCA && SOUND && !UML && SND && SND_SOC && (ARCH_APPLE || COMPILE_TEST


vim +1075 drivers/iommu/apple-dart.c

ccedaa71b5d55f2 Sven Peter    2021-11-02  1067  
010b44d6011e2ad Hector Martin 2022-03-05  1068  #ifdef CONFIG_PM_SLEEP
010b44d6011e2ad Hector Martin 2022-03-05  1069  static int apple_dart_suspend(struct device *dev)
010b44d6011e2ad Hector Martin 2022-03-05  1070  {
010b44d6011e2ad Hector Martin 2022-03-05  1071  	struct apple_dart *dart = dev_get_drvdata(dev);
010b44d6011e2ad Hector Martin 2022-03-05  1072  	unsigned int sid, idx;
010b44d6011e2ad Hector Martin 2022-03-05  1073  
a65f5b92f35db32 Hector Martin 2022-06-28  1074  	for (sid = 0; sid < dart->num_streams; sid++) {
010b44d6011e2ad Hector Martin 2022-03-05 @1075  		dart->save_tcr[sid] = readl_relaxed(dart->regs + DART_TCR(sid));
8c8ecc72e0be0e8 Hector Martin 2022-06-28  1076  		for (idx = 0; idx < dart->hw->ttbr_count; idx++)
010b44d6011e2ad Hector Martin 2022-03-05  1077  			dart->save_ttbr[sid][idx] =
8c8ecc72e0be0e8 Hector Martin 2022-06-28  1078  				readl_relaxed(dart->regs + DART_TTBR(dart, sid, idx));
010b44d6011e2ad Hector Martin 2022-03-05  1079  	}
010b44d6011e2ad Hector Martin 2022-03-05  1080  
010b44d6011e2ad Hector Martin 2022-03-05  1081  	return 0;
010b44d6011e2ad Hector Martin 2022-03-05  1082  }
010b44d6011e2ad Hector Martin 2022-03-05  1083  

:::::: The code at line 1075 was first introduced by commit
:::::: 010b44d6011e2adc292d45fc286332e3b6aa3b49 iommu: dart: Add suspend/resume support

:::::: TO: Hector Martin <marcan@marcan.st>
:::::: CC: Hector Martin <marcan@marcan.st>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
