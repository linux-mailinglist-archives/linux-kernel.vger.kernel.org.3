Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5819E53B7EC
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 13:38:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234159AbiFBLig (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 07:38:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232241AbiFBLic (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 07:38:32 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2B1CBF67
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jun 2022 04:38:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654169905; x=1685705905;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=36f3ZCb2WvfyJOoUvNLKecm8UdxmKl+uXOGt/LXVYmg=;
  b=Sh9B8+/XZ45r1rjCveaHE1ed4CxCoZIl8FBdmyscwJvMeoCKuLfeSBob
   mAMbzs53Ks5QaVznZWIo7nZVkaffb3NeHhHSohmqPHHoRhOMFzbVVy+hq
   yKDAdNVCqjsvKjIK1GhEbORlbW73WTm6Yy5QyJoudHqawiuDE9iglnF4U
   v3tLty/l4HsuvAxpIeeE+mF5X6CIC6nlpmVhSKs5BDyjF3fYnHK078+M6
   Zyh5luzR/ULDRQcZxEtwznpCQL1ebTrUpkrkhl0NFn3/4tZUBGEE/Afxk
   Tkf+iZ5PRUxcm7/pKKlDxu8RE+Yyd4AzsiRDovBqMyralcI3P7MVoTQ1x
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10365"; a="273487784"
X-IronPort-AV: E=Sophos;i="5.91,271,1647327600"; 
   d="scan'208";a="273487784"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2022 04:38:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,271,1647327600"; 
   d="scan'208";a="634009838"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 02 Jun 2022 04:38:24 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nwj9j-00051f-NW;
        Thu, 02 Jun 2022 11:38:23 +0000
Date:   Thu, 2 Jun 2022 19:37:28 +0800
From:   kernel test robot <lkp@intel.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [arm-integrator:kernel-in-vmalloc-v5.18-rc1 19/31]
 arch/csky/include/asm/page.h:39:16: error: implicit declaration of function
 '__pa'
Message-ID: <202206021943.r7Mh4R1H-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-integrator.git kernel-in-vmalloc-v5.18-rc1
head:   9083f89a58302e92fad7f144986e307db2350aad
commit: bf753d367129134a4bea8e187e07645e88cb22f4 [19/31] csky: Make virt_to_pfn() a static inline
config: csky-defconfig (https://download.01.org/0day-ci/archive/20220602/202206021943.r7Mh4R1H-lkp@intel.com/config)
compiler: csky-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-integrator.git/commit/?id=bf753d367129134a4bea8e187e07645e88cb22f4
        git remote add arm-integrator https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-integrator.git
        git fetch --no-tags arm-integrator kernel-in-vmalloc-v5.18-rc1
        git checkout bf753d367129134a4bea8e187e07645e88cb22f4
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=csky prepare

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from arch/csky/include/asm/thread_info.h:9,
                    from include/linux/thread_info.h:60,
                    from include/asm-generic/current.h:5,
                    from ./arch/csky/include/generated/asm/current.h:1,
                    from include/linux/sched.h:12,
                    from arch/csky/kernel/asm-offsets.c:4:
   arch/csky/include/asm/page.h: In function 'virt_to_pfn':
>> arch/csky/include/asm/page.h:39:16: error: implicit declaration of function '__pa' [-Werror=implicit-function-declaration]
      39 |         return __pa(kaddr) >> PAGE_SHIFT;
         |                ^~~~
   cc1: some warnings being treated as errors
   make[2]: *** [scripts/Makefile.build:120: arch/csky/kernel/asm-offsets.s] Error 1
   make[2]: Target '__build' not remade because of errors.
   make[1]: *** [Makefile:1194: prepare0] Error 2
   make[1]: Target 'prepare' not remade because of errors.
   make: *** [Makefile:219: __sub-make] Error 2
   make: Target 'prepare' not remade because of errors.


vim +/__pa +39 arch/csky/include/asm/page.h

    36	
    37	static inline unsigned long virt_to_pfn(const void *kaddr)
    38	{
  > 39		return __pa(kaddr) >> PAGE_SHIFT;
    40	}
    41	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
