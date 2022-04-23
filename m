Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18F9850C5C1
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Apr 2022 02:35:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229524AbiDWAhp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 20:37:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229622AbiDWAh1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 20:37:27 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A0BCFD23
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 17:34:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650674070; x=1682210070;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=/mheS9aNbEjyEwao0RL13S+cA11F+iq4i7YYxoo9Tzw=;
  b=nEg24/ml/ca4i0BB1AdpH/C+6yj1Qu9XED45DFmuO23RxhishSyVMbP5
   8UAXB2CymDITrj7IROI0Xt2Bu/Vjs+16Y3zah4oKxzrS2MaFfYr0/wS/4
   CddAshNpuVRRiv/Bum/UCEGYPZe+3LLdo1ADiM5TM0PgVrRsIVeipUfzw
   zG7eU/WhO97Zpm0fyhBLcce2GmLrTDhenVHOSNXSr1Ek0tY7mElp9LMZf
   Xz0bzv6f6kbnmqIqYkxWcXJN+3OtohfWtJUkcrx4+lnbnFrCkm06TL9Ci
   xYYaPU6IOV9Im0o8pf4O4LFfPK0tAsCMmADNM9/Vm+7P1VCeJDK67BC+E
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10324"; a="327735757"
X-IronPort-AV: E=Sophos;i="5.90,282,1643702400"; 
   d="scan'208";a="327735757"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2022 17:34:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,282,1643702400"; 
   d="scan'208";a="511798831"
Received: from lkp-server01.sh.intel.com (HELO 3abc53900bec) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 22 Apr 2022 17:34:29 -0700
Received: from kbuild by 3abc53900bec with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1ni3jI-000Aj8-Du;
        Sat, 23 Apr 2022 00:34:28 +0000
Date:   Sat, 23 Apr 2022 08:33:46 +0800
From:   kernel test robot <lkp@intel.com>
To:     Anup Patel <apatel@ventanamicro.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [avpatel:riscv_kvm_aia_v1 30/36] include/linux/stddef.h:8:14:
 warning: initialization of 'unsigned int' from 'void *' makes integer from
 pointer without a cast
Message-ID: <202204230806.rm6YF30b-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/avpatel/linux.git riscv_kvm_aia_v1
head:   98e428a1d1998ce64188c5d7565a9f1c245c55f3
commit: 5c645e193e2c3d4db82b0e8984d7560fad50ddba [30/36] RISC-V: KVM: Add G-stage ioremap() and iounmap() functions
config: arm64-defconfig (https://download.01.org/0day-ci/archive/20220423/202204230806.rm6YF30b-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/avpatel/linux/commit/5c645e193e2c3d4db82b0e8984d7560fad50ddba
        git remote add avpatel https://github.com/avpatel/linux.git
        git fetch --no-tags avpatel riscv_kvm_aia_v1
        git checkout 5c645e193e2c3d4db82b0e8984d7560fad50ddba
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross W=1 O=build_dir ARCH=arm64 SHELL=/bin/bash arch/arm64/kvm/ drivers/edac/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from include/uapi/linux/posix_types.h:5,
                    from include/uapi/linux/types.h:14,
                    from include/linux/types.h:6,
                    from include/linux/kasan-checks.h:5,
                    from include/asm-generic/rwonce.h:26,
                    from arch/arm64/include/asm/rwonce.h:71,
                    from include/linux/compiler.h:248,
                    from include/asm-generic/bug.h:5,
                    from arch/arm64/include/asm/bug.h:26,
                    from include/linux/bug.h:5,
                    from include/linux/mmdebug.h:5,
                    from include/linux/mm.h:6,
                    from include/linux/mman.h:5,
                    from arch/arm64/kvm/mmu.c:7:
   arch/arm64/kvm/mmu.c: In function 'kvm_phys_addr_ioremap':
>> include/linux/stddef.h:8:14: warning: initialization of 'unsigned int' from 'void *' makes integer from pointer without a cast [-Wint-conversion]
       8 | #define NULL ((void *)0)
         |              ^
   arch/arm64/kvm/mmu.c:767:62: note: in expansion of macro 'NULL'
     767 |         struct kvm_mmu_memory_cache cache = { 0, __GFP_ZERO, NULL, };
         |                                                              ^~~~
   include/linux/stddef.h:8:14: note: (near initialization for 'cache.gfp_atomic')
       8 | #define NULL ((void *)0)
         |              ^
   arch/arm64/kvm/mmu.c:767:62: note: in expansion of macro 'NULL'
     767 |         struct kvm_mmu_memory_cache cache = { 0, __GFP_ZERO, NULL, };
         |                                                              ^~~~


vim +8 include/linux/stddef.h

^1da177e4c3f415 Linus Torvalds   2005-04-16  6  
^1da177e4c3f415 Linus Torvalds   2005-04-16  7  #undef NULL
^1da177e4c3f415 Linus Torvalds   2005-04-16 @8  #define NULL ((void *)0)
6e2182874324727 Richard Knutsson 2006-09-30  9  

:::::: The code at line 8 was first introduced by commit
:::::: 1da177e4c3f41524e886b7f1b8a0c1fc7321cac2 Linux-2.6.12-rc2

:::::: TO: Linus Torvalds <torvalds@ppc970.osdl.org>
:::::: CC: Linus Torvalds <torvalds@ppc970.osdl.org>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
