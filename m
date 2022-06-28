Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F41C55C718
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 14:53:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238778AbiF1FjL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 01:39:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233378AbiF1FjJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 01:39:09 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E652513E25
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 22:39:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656394748; x=1687930748;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=ir8lmK7C7d8cLKlhbPdCb+2NADN21Wc5Vd2lMQ7GZVE=;
  b=Ntd5w1A7AJ5RZjW5tE+m8nlPY7kcp8sHkoZh2Ceup/ZvkrrD2uDYtjoD
   0mvWQWltp420TC1p8zc6M/6KGYrufiYB0wbwJBbB9eDevK17x4ttJeJUd
   DXD6S+V5msK8N/+Kd3x/xwXi/1CWCzS+0gwVVJPnUl85L3rgQeIFKqmxO
   Sdz8FXbT2BTJE/sFZ61iPZInXtcDY5kJLmjJ2GuohmxhP691E0/izguc3
   67KoVzDYunWniuiVqHLKUzrehtM7tD9/6L0AC8ez7SJZ7oCEWwUTuAir9
   MXdgC8+4pQ8Tos0LATwDsNkDB7gYWT5v7uL/hQmpvpjdiQFwKvQnuNU4v
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10391"; a="343328114"
X-IronPort-AV: E=Sophos;i="5.92,227,1650956400"; 
   d="scan'208";a="343328114"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2022 22:39:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,227,1650956400"; 
   d="scan'208";a="587737228"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 27 Jun 2022 22:39:07 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o63wI-0009Yh-Gx;
        Tue, 28 Jun 2022 05:39:06 +0000
Date:   Tue, 28 Jun 2022 13:38:08 +0800
From:   kernel test robot <lkp@intel.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: arch/arm/mach-pxa/corgi_pm.c:137:15: warning: no previous prototype
 for function 'corgipm_read_devdata'
Message-ID: <202206281334.Hj0eme5G-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   941e3e7912696b9fbe3586083a7c2e102cee7a87
commit: 8c1fb11b8a77dc489a8ef6d96c38c1297b629d06 ARM: s3c: enable s3c24xx multiplatform support
date:   3 months ago
config: arm-buildonly-randconfig-r001-20220627 (https://download.01.org/0day-ci/archive/20220628/202206281334.Hj0eme5G-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 016342e319fd31e41cf5ed16a6140a8ea2de74dd)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm cross compiling tool for clang build
        # apt-get install binutils-arm-linux-gnueabi
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=8c1fb11b8a77dc489a8ef6d96c38c1297b629d06
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 8c1fb11b8a77dc489a8ef6d96c38c1297b629d06
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> arch/arm/mach-pxa/corgi_pm.c:137:15: warning: no previous prototype for function 'corgipm_read_devdata' [-Wmissing-prototypes]
   unsigned long corgipm_read_devdata(int type)
                 ^
   arch/arm/mach-pxa/corgi_pm.c:137:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   unsigned long corgipm_read_devdata(int type)
   ^
   static 
   1 warning generated.


vim +/corgipm_read_devdata +137 arch/arm/mach-pxa/corgi_pm.c

d72f25b0dfb080 Richard Purdie 2005-11-13  136  
b7557de41a0434 Richard Purdie 2006-01-05 @137  unsigned long corgipm_read_devdata(int type)
d72f25b0dfb080 Richard Purdie 2005-11-13  138  {
b7557de41a0434 Richard Purdie 2006-01-05  139  	switch(type) {
b7557de41a0434 Richard Purdie 2006-01-05  140  	case SHARPSL_STATUS_ACIN:
9bf448c66d4b4c Haojian Zhuang 2011-10-17  141  		return !gpio_get_value(CORGI_GPIO_AC_IN);
b7557de41a0434 Richard Purdie 2006-01-05  142  	case SHARPSL_STATUS_LOCK:
05732d7eb0d7f7 Eric Miao      2010-07-04  143  		return gpio_get_value(sharpsl_pm.machinfo->gpio_batlock);
b7557de41a0434 Richard Purdie 2006-01-05  144  	case SHARPSL_STATUS_CHRGFULL:
05732d7eb0d7f7 Eric Miao      2010-07-04  145  		return gpio_get_value(sharpsl_pm.machinfo->gpio_batfull);
b7557de41a0434 Richard Purdie 2006-01-05  146  	case SHARPSL_STATUS_FATAL:
05732d7eb0d7f7 Eric Miao      2010-07-04  147  		return gpio_get_value(sharpsl_pm.machinfo->gpio_fatal);
b7557de41a0434 Richard Purdie 2006-01-05  148  	case SHARPSL_ACIN_VOLT:
b7557de41a0434 Richard Purdie 2006-01-05  149  		return sharpsl_pm_pxa_read_max1111(MAX1111_ACIN_VOLT);
b7557de41a0434 Richard Purdie 2006-01-05  150  	case SHARPSL_BATT_TEMP:
b7557de41a0434 Richard Purdie 2006-01-05  151  		return sharpsl_pm_pxa_read_max1111(MAX1111_BATT_TEMP);
b7557de41a0434 Richard Purdie 2006-01-05  152  	case SHARPSL_BATT_VOLT:
b7557de41a0434 Richard Purdie 2006-01-05  153  	default:
b7557de41a0434 Richard Purdie 2006-01-05  154  		return sharpsl_pm_pxa_read_max1111(MAX1111_BATT_VOLT);
b7557de41a0434 Richard Purdie 2006-01-05  155  	}
d72f25b0dfb080 Richard Purdie 2005-11-13  156  }
d72f25b0dfb080 Richard Purdie 2005-11-13  157  

:::::: The code at line 137 was first introduced by commit
:::::: b7557de41a04346cb545d4dda7088760cb96e713 [ARM] 3228/1: SharpSL: Move PM code to arch/arm/common

:::::: TO: Richard Purdie <rpurdie@rpsys.net>
:::::: CC: Russell King <rmk+kernel@arm.linux.org.uk>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
