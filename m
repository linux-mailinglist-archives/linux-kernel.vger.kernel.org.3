Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A3F04DB9C5
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 21:51:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239166AbiCPUwC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 16:52:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236608AbiCPUv7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 16:51:59 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D462B5A5B5
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 13:50:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647463844; x=1678999844;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=5rTx0VkfmyTgcyY0GLxRZZKS14Mwj2aNsggT7IlBymQ=;
  b=GbDU4oneY2qjmD1WbUP41r8TGzT0cS0Jfvu012luZ6Cd0iSE3rvgdyEG
   F4h2XM+lu5n1gmxdqfdSAiqTUxtpDYX7Jc28pDxTkzb4RVZmbT1kK08He
   tSuic4B/4otnhg1kC7TRZ54SzbWYy+ZjaKA40/yHtpv6tbHei5rLW/Syn
   ie0vFng7ORjtl5jHP0SZxxSvQRBbQK61a3nGHwSfnOjlGJTpazuuEc1SV
   aZRpXlwjY23uL7pdsOGcfRimER+DXkGXP8ev6ePCXbajqEtlod1TytZvx
   DTnituTfVE55swc0QQnPT/pRVwmIF0WQ9yy63f4AB853QjSmYDq2bO0ki
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10288"; a="319921612"
X-IronPort-AV: E=Sophos;i="5.90,187,1643702400"; 
   d="scan'208";a="319921612"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2022 13:50:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,187,1643702400"; 
   d="scan'208";a="516491900"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 16 Mar 2022 13:50:41 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nUabQ-000CuQ-IE; Wed, 16 Mar 2022 20:50:40 +0000
Date:   Thu, 17 Mar 2022 04:49:51 +0800
From:   kernel test robot <lkp@intel.com>
To:     Anup Patel <apatel@ventanamicro.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [avpatel:riscv_kvm_aia_v1 32/38] include/linux/stddef.h:8:14:
 warning: initialization of 'unsigned int' from 'void *' makes integer from
 pointer without a cast
Message-ID: <202203170426.cQSnwc5c-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/avpatel/linux.git riscv_kvm_aia_v1
head:   1f93371b93e3d215381b1ebcecacb9f2e54b270f
commit: ef83a194815d993203e117d8a83e591f0a0c288e [32/38] RISC-V: KVM: Add G-stage ioremap() and iounmap() functions
config: arm64-defconfig (https://download.01.org/0day-ci/archive/20220317/202203170426.cQSnwc5c-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/avpatel/linux/commit/ef83a194815d993203e117d8a83e591f0a0c288e
        git remote add avpatel https://github.com/avpatel/linux.git
        git fetch --no-tags avpatel riscv_kvm_aia_v1
        git checkout ef83a194815d993203e117d8a83e591f0a0c288e
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
                    from include/linux/compiler.h:255,
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
   arch/arm64/kvm/mmu.c:768:62: note: in expansion of macro 'NULL'
     768 |         struct kvm_mmu_memory_cache cache = { 0, __GFP_ZERO, NULL, };
         |                                                              ^~~~
   include/linux/stddef.h:8:14: note: (near initialization for 'cache.gfp_atomic')
       8 | #define NULL ((void *)0)
         |              ^
   arch/arm64/kvm/mmu.c:768:62: note: in expansion of macro 'NULL'
     768 |         struct kvm_mmu_memory_cache cache = { 0, __GFP_ZERO, NULL, };
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
0-DAY CI Kernel Test Service
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
