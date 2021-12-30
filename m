Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87878481BDA
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Dec 2021 12:59:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239102AbhL3L7z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Dec 2021 06:59:55 -0500
Received: from mga04.intel.com ([192.55.52.120]:26078 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235352AbhL3L7z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Dec 2021 06:59:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640865595; x=1672401595;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=e91rGBDnnBExM9MfRfDS3dDuOZycaNGnwE0QZDCs9Tk=;
  b=nh/pr5G3u3fY6VyDZLNPfjbaWrVMDzldaAJH0WSfgOKnAmUcwDcgw3vK
   dNf3dusaAps/nGdSqyd4TwDg/fEga2O0dpHIcRZuGdJNj/9WzlrwFHGkQ
   W4vLSXH0FoZTTjMG+6Mw32xFBlnbzA21rnNKiS8YIx7X0cE3kl+rm0myO
   fM04LaUxdwT6sNSCZ8XtMaR3EJsQqqe3/ISY9oQ65JLnGnZUTyL1wvFtY
   LZSGx1sViLM1jviV9nTfdkFJfVvcytMlHm653xqq1vLcsb4dHOM/tyc+n
   JUSYPsb0rcw2ufAQzrN6d6fEY7bGtbuM64H8tmHcotvTI3SRgDjQ9tVtc
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10212"; a="240446756"
X-IronPort-AV: E=Sophos;i="5.88,248,1635231600"; 
   d="scan'208";a="240446756"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Dec 2021 03:59:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,248,1635231600"; 
   d="scan'208";a="609891722"
Received: from lkp-server01.sh.intel.com (HELO e357b3ef1427) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 30 Dec 2021 03:59:53 -0800
Received: from kbuild by e357b3ef1427 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n2u65-000A2F-6L; Thu, 30 Dec 2021 11:59:53 +0000
Date:   Thu, 30 Dec 2021 19:59:28 +0800
From:   kernel test robot <lkp@intel.com>
To:     Anup Patel <anup.patel@wdc.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [avpatel:riscv_kvm_aia_v1 36/42] include/linux/stddef.h:8:14:
 warning: initialization of 'unsigned int' from 'void *' makes integer from
 pointer without a cast
Message-ID: <202112301918.hIsG4eZV-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/avpatel/linux.git riscv_kvm_aia_v1
head:   39b04982423339e2b116ac84de98458b8cb7c4d4
commit: 6ad98a79665c11894c5062b40cc0779f814dac6a [36/42] RISC-V: KVM: Add G-stage ioremap() and iounmap() functions
config: arm64-allyesconfig (https://download.01.org/0day-ci/archive/20211230/202112301918.hIsG4eZV-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/avpatel/linux/commit/6ad98a79665c11894c5062b40cc0779f814dac6a
        git remote add avpatel https://github.com/avpatel/linux.git
        git fetch --no-tags avpatel riscv_kvm_aia_v1
        git checkout 6ad98a79665c11894c5062b40cc0779f814dac6a
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arm64 SHELL=/bin/bash arch/arm64/kvm/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from include/uapi/linux/posix_types.h:5,
                    from include/uapi/linux/types.h:14,
                    from include/linux/types.h:6,
                    from include/linux/kasan-checks.h:5,
                    from include/asm-generic/rwonce.h:26,
                    from arch/arm64/include/asm/rwonce.h:71,
                    from include/linux/compiler.h:266,
                    from include/asm-generic/bug.h:5,
                    from arch/arm64/include/asm/bug.h:26,
                    from include/linux/bug.h:5,
                    from include/linux/mmdebug.h:5,
                    from include/linux/mm.h:9,
                    from include/linux/mman.h:5,
                    from arch/arm64/kvm/mmu.c:7:
   arch/arm64/kvm/mmu.c: In function 'kvm_phys_addr_ioremap':
>> include/linux/stddef.h:8:14: warning: initialization of 'unsigned int' from 'void *' makes integer from pointer without a cast [-Wint-conversion]
       8 | #define NULL ((void *)0)
         |              ^
   arch/arm64/kvm/mmu.c:647:62: note: in expansion of macro 'NULL'
     647 |         struct kvm_mmu_memory_cache cache = { 0, __GFP_ZERO, NULL, };
         |                                                              ^~~~
   include/linux/stddef.h:8:14: note: (near initialization for 'cache.gfp_atomic')
       8 | #define NULL ((void *)0)
         |              ^
   arch/arm64/kvm/mmu.c:647:62: note: in expansion of macro 'NULL'
     647 |         struct kvm_mmu_memory_cache cache = { 0, __GFP_ZERO, NULL, };
         |                                                              ^~~~


vim +8 include/linux/stddef.h

^1da177e4c3f41 Linus Torvalds   2005-04-16  6  
^1da177e4c3f41 Linus Torvalds   2005-04-16  7  #undef NULL
^1da177e4c3f41 Linus Torvalds   2005-04-16 @8  #define NULL ((void *)0)
6e218287432472 Richard Knutsson 2006-09-30  9  

:::::: The code at line 8 was first introduced by commit
:::::: 1da177e4c3f41524e886b7f1b8a0c1fc7321cac2 Linux-2.6.12-rc2

:::::: TO: Linus Torvalds <torvalds@ppc970.osdl.org>
:::::: CC: Linus Torvalds <torvalds@ppc970.osdl.org>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
