Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A58F53D8B7
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Jun 2022 00:24:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242206AbiFDWK7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Jun 2022 18:10:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232884AbiFDWK4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jun 2022 18:10:56 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2FAE2FFEB
        for <linux-kernel@vger.kernel.org>; Sat,  4 Jun 2022 15:10:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654380655; x=1685916655;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=O9lxN0nnbWVu76gl4EognGBjN8hbt8L0zgC/qTcSkhQ=;
  b=Gf6vF0dq0kjJ7QnSeQbb5FvqRUy+VeAQvwuHe9R5dojDxZIXWsq/U89X
   y5tLfvxRRx+9auEGzPNAO4tVZ+dmH7Y4l+yOLgn9orwmWQ8/AjUrMcQmb
   lmrAWUJH9XSpIAkrfp5JQUczdJTDGjjk+fXhPyDN4wAPCOLibfdI4G7Qs
   ba9uRC47ot18yAjRKgmgtbCB06ZjQ/XI1kfnVJ1O0OzBKchgsPwoC2wQs
   fDfYshOi0i8k71o8gAxYPW3pIbkmXFIpG18FixpbAd9/aZG3Fn1bZfXGd
   +M3SXE96ywmoY6nwwJAyo12+6T5INiWzrJg9kQ449lrfiG5kSuQZGg3dS
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10368"; a="256347544"
X-IronPort-AV: E=Sophos;i="5.91,278,1647327600"; 
   d="scan'208";a="256347544"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2022 15:10:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,278,1647327600"; 
   d="scan'208";a="635041269"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 04 Jun 2022 15:10:54 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nxbyv-000BFL-NB;
        Sat, 04 Jun 2022 22:10:53 +0000
Date:   Sun, 5 Jun 2022 06:10:04 +0800
From:   kernel test robot <lkp@intel.com>
To:     Anup Patel <apatel@ventanamicro.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [avpatel:riscv_kvm_aia_v1 32/38] include/linux/stddef.h:8:14:
 warning: initialization of 'unsigned int' from 'void *' makes integer from
 pointer without a cast
Message-ID: <202206050641.z48IuOJU-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/avpatel/linux.git riscv_kvm_aia_v1
head:   0c38c32343008325233d4b0d253ce0b52c46f72e
commit: f2fe9133a40a131ca4c946b73cc87c111ad0b407 [32/38] RISC-V: KVM: Add G-stage ioremap() and iounmap() functions
config: arm64-defconfig (https://download.01.org/0day-ci/archive/20220605/202206050641.z48IuOJU-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/avpatel/linux/commit/f2fe9133a40a131ca4c946b73cc87c111ad0b407
        git remote add avpatel https://github.com/avpatel/linux.git
        git fetch --no-tags avpatel riscv_kvm_aia_v1
        git checkout f2fe9133a40a131ca4c946b73cc87c111ad0b407
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=arm64 SHELL=/bin/bash arch/arm64/kvm/

If you fix the issue, kindly add following tag where applicable
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

^1da177e4c3f41 Linus Torvalds   2005-04-16  6  
^1da177e4c3f41 Linus Torvalds   2005-04-16  7  #undef NULL
^1da177e4c3f41 Linus Torvalds   2005-04-16 @8  #define NULL ((void *)0)
6e218287432472 Richard Knutsson 2006-09-30  9  

:::::: The code at line 8 was first introduced by commit
:::::: 1da177e4c3f41524e886b7f1b8a0c1fc7321cac2 Linux-2.6.12-rc2

:::::: TO: Linus Torvalds <torvalds@ppc970.osdl.org>
:::::: CC: Linus Torvalds <torvalds@ppc970.osdl.org>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
