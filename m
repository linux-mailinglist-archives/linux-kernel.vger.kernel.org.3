Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E9FE50ABE7
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 01:18:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442310AbiDUXU6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 19:20:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442211AbiDUXU5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 19:20:57 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 415163CFE1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 16:18:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650583086; x=1682119086;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=3HDiJ8oX4H1fort48Tf+jIRSNYLDP5q421WmnpUv1+0=;
  b=bT/m3clYtb57EOtssr7DX7whS3grn9hDreraqVRMy5rp6ZDZaj0h3QWk
   jvaeTHl9IzwZlAg1VmbIbRCet1o43dy7cm4the8RdbzMP478EHIYPGPw0
   1Sr9AzhoDRmefERAqbtmoFdKTyRHx89s8WlXo1B23zLq5D9BhoLWb3mXL
   zmgAr/jEJP2riI6tFVYUK5F/WNktQRMNKFGZMPBpuRi46u4vAOaTMYif0
   p6eFgkbX4j837NX0jPmk2R9nXqzTjcRcnXHqjlGIWa7GKaWcMZ1ekFLCr
   7XMmPHrkxtrTfrS14jInStnRNhVgyua+zNMTxpZFrmwd8+ZZ4L2fvB59r
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10324"; a="263357995"
X-IronPort-AV: E=Sophos;i="5.90,280,1643702400"; 
   d="scan'208";a="263357995"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2022 16:18:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,280,1643702400"; 
   d="scan'208";a="626726823"
Received: from lkp-server01.sh.intel.com (HELO 3abc53900bec) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 21 Apr 2022 16:18:04 -0700
Received: from kbuild by 3abc53900bec with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nhg3n-0008sY-S1;
        Thu, 21 Apr 2022 23:18:03 +0000
Date:   Fri, 22 Apr 2022 07:16:56 +0800
From:   kernel test robot <lkp@intel.com>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Subject: drivers/watchdog/pic32-wdt.c:159:34: warning: unused variable
 'pic32_wdt_dt_ids'
Message-ID: <202204220754.nuORtA1j-lkp@intel.com>
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

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   b253435746d9a4a701b5f09211b9c14d3370d0da
commit: c434b9f80b0923e6460031b0fd964f8b0bf3c6a6 MIPS: Kconfig: add MIPS_GENERIC_KERNEL symbol
date:   1 year, 7 months ago
config: mips-randconfig-r005-20220422 (https://download.01.org/0day-ci/archive/20220422/202204220754.nuORtA1j-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 5bd87350a5ae429baf8f373cb226a57b62f87280)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install mips cross compiling tool for clang build
        # apt-get install binutils-mips-linux-gnu
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=c434b9f80b0923e6460031b0fd964f8b0bf3c6a6
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout c434b9f80b0923e6460031b0fd964f8b0bf3c6a6
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=mips SHELL=/bin/bash drivers/staging/media/hantro/ drivers/watchdog/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/watchdog/pic32-wdt.c:159:34: warning: unused variable 'pic32_wdt_dt_ids' [-Wunused-const-variable]
   static const struct of_device_id pic32_wdt_dt_ids[] = {
                                    ^
   1 warning generated.


vim +/pic32_wdt_dt_ids +159 drivers/watchdog/pic32-wdt.c

8f91fc56bc439a Joshua Henderson 2016-02-26  158  
8f91fc56bc439a Joshua Henderson 2016-02-26 @159  static const struct of_device_id pic32_wdt_dt_ids[] = {
8f91fc56bc439a Joshua Henderson 2016-02-26  160  	{ .compatible = "microchip,pic32mzda-wdt", },
8f91fc56bc439a Joshua Henderson 2016-02-26  161  	{ /* sentinel */ }
8f91fc56bc439a Joshua Henderson 2016-02-26  162  };
8f91fc56bc439a Joshua Henderson 2016-02-26  163  MODULE_DEVICE_TABLE(of, pic32_wdt_dt_ids);
8f91fc56bc439a Joshua Henderson 2016-02-26  164  

:::::: The code at line 159 was first introduced by commit
:::::: 8f91fc56bc439a5baefae598040d263f48526596 watchdog: pic32-wdt: Add PIC32 watchdog driver

:::::: TO: Joshua Henderson <joshua.henderson@microchip.com>
:::::: CC: Ralf Baechle <ralf@linux-mips.org>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
