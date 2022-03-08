Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 999F64D20C4
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 19:55:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245141AbiCHSzh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 13:55:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234202AbiCHSze (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 13:55:34 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 225FD31360
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 10:54:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646765678; x=1678301678;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=radBd3rdJ2z70Gmd7z6FNYzhfFhONB3vwqXTe/n5Qhs=;
  b=heMAPaTUA39GJ6CLcqo19EN2h5rsPFewVd69Rddfs74D2v/hNe1fg/bg
   85Aa+1DrU5UJKWMb9R72ck2RylUgIaeFZi7/YyntTgXacaFBeFv5tRx2M
   SVkIsdvFaHV4Q7bKrNppf8HSGIsF9rCwU9WV/HtCuVtevWl7/2gU/+WAT
   IVXF3NAoO9AhLlP7BDCNN/1eACoplEHEhBnkRuYe5W7K4QaXzZez0r1c/
   nYHEUdGf2C9QWWfqK85KOt8zPbYZ5NTDBO40Rbm0XFbYPiiddAeOamSJS
   sKKn4jj6+yBmCrEJS5bsVDXj89eW2GbfPOFw6myjV/ZwCPK4Emz81LuX/
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10280"; a="254514471"
X-IronPort-AV: E=Sophos;i="5.90,165,1643702400"; 
   d="scan'208";a="254514471"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2022 10:54:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,165,1643702400"; 
   d="scan'208";a="780815517"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by fmsmga006.fm.intel.com with ESMTP; 08 Mar 2022 10:54:35 -0800
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nReyh-0001ps-7W; Tue, 08 Mar 2022 18:54:35 +0000
Date:   Wed, 9 Mar 2022 02:54:00 +0800
From:   kernel test robot <lkp@intel.com>
To:     Vijay Balakrishna <vijayb@linux.microsoft.com>
Cc:     kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org, Will Deacon <will@kernel.org>,
        Pasha Tatashin <pasha.tatashin@soleen.com>
Subject: [ammarfaizi2-block:arm64/linux/for-next/misc 5/7]
 arch/arm64/mm/init.c:90:19: error: conflicting type qualifiers for
 'arm64_dma_phys_limit'
Message-ID: <202203090241.aj7paWeX-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ammarfaizi2/linux-block arm64/linux/for-next/misc
head:   819a47d24b61b5e2d660d19c8798f0f9b4498b73
commit: 031495635b4668f94e964e037ca93d0d38bfde58 [5/7] arm64: Do not defer reserve_crashkernel() for platforms with no DMA memory zones
config: arm64-randconfig-r014-20220308 (https://download.01.org/0day-ci/archive/20220309/202203090241.aj7paWeX-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/ammarfaizi2/linux-block/commit/031495635b4668f94e964e037ca93d0d38bfde58
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block arm64/linux/for-next/misc
        git checkout 031495635b4668f94e964e037ca93d0d38bfde58
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arm64 SHELL=/bin/bash arch/arm64/mm/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> arch/arm64/mm/init.c:90:19: error: conflicting type qualifiers for 'arm64_dma_phys_limit'
      90 | const phys_addr_t arm64_dma_phys_limit = PHYS_MASK + 1;
         |                   ^~~~~~~~~~~~~~~~~~~~
   In file included from include/asm-generic/qrwlock.h:14,
                    from ./arch/arm64/include/generated/asm/qrwlock.h:1,
                    from arch/arm64/include/asm/spinlock.h:9,
                    from include/linux/spinlock.h:93,
                    from include/linux/swap.h:5,
                    from arch/arm64/mm/init.c:12:
   arch/arm64/include/asm/processor.h:102:20: note: previous declaration of 'arm64_dma_phys_limit' with type 'phys_addr_t' {aka 'long long unsigned int'}
     102 | extern phys_addr_t arm64_dma_phys_limit;
         |                    ^~~~~~~~~~~~~~~~~~~~


vim +/arm64_dma_phys_limit +90 arch/arm64/mm/init.c

    57	
    58	/*
    59	 * If the corresponding config options are enabled, we create both ZONE_DMA
    60	 * and ZONE_DMA32. By default ZONE_DMA covers the 32-bit addressable memory
    61	 * unless restricted on specific platforms (e.g. 30-bit on Raspberry Pi 4).
    62	 * In such case, ZONE_DMA32 covers the rest of the 32-bit addressable memory,
    63	 * otherwise it is empty.
    64	 *
    65	 * Memory reservation for crash kernel either done early or deferred
    66	 * depending on DMA memory zones configs (ZONE_DMA) --
    67	 *
    68	 * In absence of ZONE_DMA configs arm64_dma_phys_limit initialized
    69	 * here instead of max_zone_phys().  This lets early reservation of
    70	 * crash kernel memory which has a dependency on arm64_dma_phys_limit.
    71	 * Reserving memory early for crash kernel allows linear creation of block
    72	 * mappings (greater than page-granularity) for all the memory bank rangs.
    73	 * In this scheme a comparatively quicker boot is observed.
    74	 *
    75	 * If ZONE_DMA configs are defined, crash kernel memory reservation
    76	 * is delayed until DMA zone memory range size initilazation performed in
    77	 * zone_sizes_init().  The defer is necessary to steer clear of DMA zone
    78	 * memory range to avoid overlap allocation.  So crash kernel memory boundaries
    79	 * are not known when mapping all bank memory ranges, which otherwise means
    80	 * not possible to exclude crash kernel range from creating block mappings
    81	 * so page-granularity mappings are created for the entire memory range.
    82	 * Hence a slightly slower boot is observed.
    83	 *
    84	 * Note: Page-granularity mapppings are necessary for crash kernel memory
    85	 * range for shrinking its size via /sys/kernel/kexec_crash_size interface.
    86	 */
    87	#if IS_ENABLED(CONFIG_ZONE_DMA) || IS_ENABLED(CONFIG_ZONE_DMA32)
    88	phys_addr_t __ro_after_init arm64_dma_phys_limit;
    89	#else
  > 90	const phys_addr_t arm64_dma_phys_limit = PHYS_MASK + 1;
    91	#endif
    92	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
