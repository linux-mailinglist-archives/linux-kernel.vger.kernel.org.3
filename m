Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87DCE53065A
	for <lists+linux-kernel@lfdr.de>; Sun, 22 May 2022 23:50:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348117AbiEVVum (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 May 2022 17:50:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbiEVVui (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 May 2022 17:50:38 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B07DD34677
        for <linux-kernel@vger.kernel.org>; Sun, 22 May 2022 14:50:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653256237; x=1684792237;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=tuGNTQKb7tov2NqHToiPCQKs9Nz+OzX5pq7XJ3d4Hus=;
  b=MNktvHJIgmZZvU+P8JeMWdbgCPoMgVi6nAA7r5XUQ54bK7ZZutP6/30d
   iopTwtS0piZLj/uztQ7sDZ/7WqsaHrJj1tX1kBTfGIaqDVmuv1/7xdbxN
   92rorcUJA/r8aIPa8MBVJ2NFKOROn54h03X3t1kmdJRmoVmY5GsF+CnFk
   eBVlhXDVodaxEwucfScrgsTzBFzqHL+Rh+6Df6ZGZ80hznuUAv6GfhJj6
   PRqwLaq6SJbThSoeGwwmt8Xggy/fx/UXzSh6ay3llnhwz4d8V43oK7alU
   YDAHLnMizurWDYAgRJgr/CI5NqoMDmSY9HqhZ/F0kY36TX+kgBmRrNMUf
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10355"; a="333685728"
X-IronPort-AV: E=Sophos;i="5.91,244,1647327600"; 
   d="scan'208";a="333685728"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2022 14:50:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,244,1647327600"; 
   d="scan'208";a="702682155"
Received: from lkp-server01.sh.intel.com (HELO db63a1be7222) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 22 May 2022 14:50:35 -0700
Received: from kbuild by db63a1be7222 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nstT9-0000df-7m;
        Sun, 22 May 2022 21:50:35 +0000
Date:   Mon, 23 May 2022 05:50:07 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Madhavan T. Venkataraman" <madvenka@linux.microsoft.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [madvenka786:orc_v2 17/20] arch/arm64/include/asm/module.h:19:8:
 error: redefinition of 'mod_arch_specific'
Message-ID: <202205230540.ycgHZVXI-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/madvenka786/linux orc_v2
head:   ed9a1d5c036130a53c639eb712485e3d13ab4372
commit: 9da8b45b52cb2268200c44977bc7482d3bea70dc [17/20] arm64: Build the kernel with ORC information
config: arm64-randconfig-r011-20220523 (https://download.01.org/0day-ci/archive/20220523/202205230540.ycgHZVXI-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 1443dbaba6f0e57be066995db9164f89fb57b413)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm64 cross compiling tool for clang build
        # apt-get install binutils-aarch64-linux-gnu
        # https://github.com/madvenka786/linux/commit/9da8b45b52cb2268200c44977bc7482d3bea70dc
        git remote add madvenka786 https://github.com/madvenka786/linux
        git fetch --no-tags madvenka786 orc_v2
        git checkout 9da8b45b52cb2268200c44977bc7482d3bea70dc
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm64 prepare

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from arch/arm64/kernel/asm-offsets.c:10:
   In file included from include/linux/arm_sdei.h:8:
   In file included from include/acpi/ghes.h:5:
   In file included from include/acpi/apei.h:9:
   In file included from include/linux/acpi.h:15:
   In file included from include/linux/device.h:32:
   In file included from include/linux/device/driver.h:21:
   In file included from include/linux/module.h:33:
>> arch/arm64/include/asm/module.h:19:8: error: redefinition of 'mod_arch_specific'
   struct mod_arch_specific {
          ^
   include/asm-generic/module.h:10:8: note: previous definition is here
   struct mod_arch_specific
          ^
   1 error generated.
   make[2]: *** [scripts/Makefile.build:120: arch/arm64/kernel/asm-offsets.s] Error 1
   make[2]: Target '__build' not remade because of errors.
   make[1]: *** [Makefile:1194: prepare0] Error 2
   make[1]: Target 'prepare' not remade because of errors.
   make: *** [Makefile:219: __sub-make] Error 2
   make: Target 'prepare' not remade because of errors.


vim +/mod_arch_specific +19 arch/arm64/include/asm/module.h

24af6c4e4e0f6e Ard Biesheuvel           2017-02-21  18  
24af6c4e4e0f6e Ard Biesheuvel           2017-02-21 @19  struct mod_arch_specific {
9da8b45b52cb22 Madhavan T. Venkataraman 2022-05-22  20  #ifdef CONFIG_ARM64_MODULE_PLTS
24af6c4e4e0f6e Ard Biesheuvel           2017-02-21  21  	struct mod_plt_sec	core;
24af6c4e4e0f6e Ard Biesheuvel           2017-02-21  22  	struct mod_plt_sec	init;
e71a4e1bebaf7f Ard Biesheuvel           2017-06-06  23  
e71a4e1bebaf7f Ard Biesheuvel           2017-06-06  24  	/* for CONFIG_DYNAMIC_FTRACE */
3b23e4991fb66f Torsten Duwe             2019-02-08  25  	struct plt_entry	*ftrace_trampolines;
fd045f6cd98ec4 Ard Biesheuvel           2015-11-24  26  #endif
9da8b45b52cb22 Madhavan T. Venkataraman 2022-05-22  27  #ifdef CONFIG_UNWINDER_ORC
9da8b45b52cb22 Madhavan T. Venkataraman 2022-05-22  28  	unsigned int num_orcs;
9da8b45b52cb22 Madhavan T. Venkataraman 2022-05-22  29  	int *orc_unwind_ip;
9da8b45b52cb22 Madhavan T. Venkataraman 2022-05-22  30  	struct orc_entry *orc_unwind;
9da8b45b52cb22 Madhavan T. Venkataraman 2022-05-22  31  #endif
9da8b45b52cb22 Madhavan T. Venkataraman 2022-05-22  32  };
fd045f6cd98ec4 Ard Biesheuvel           2015-11-24  33  

:::::: The code at line 19 was first introduced by commit
:::::: 24af6c4e4e0f6e9803bec8dca0f7748afbb2bbf0 arm64: module: split core and init PLT sections

:::::: TO: Ard Biesheuvel <ard.biesheuvel@linaro.org>
:::::: CC: Catalin Marinas <catalin.marinas@arm.com>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
