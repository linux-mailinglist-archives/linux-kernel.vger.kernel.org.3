Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C6D7513E45
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 00:03:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352757AbiD1WGn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 18:06:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352737AbiD1WGl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 18:06:41 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F7EC58E52
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 15:03:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651183405; x=1682719405;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=YYNswVvvbMrH6KjwU+DEX1dnDPFbEExRtmWGNyijP14=;
  b=a5GSAf+tGMdDi7DqKhEtG7c3ynVHYAg1055YvvfYtIN6WTveybxaQCES
   gEGUMHz+FwTEpKPAUCdaRcHq9YTbvAoGFBBST6DLqXwUcSL6MTK/Ld70L
   TpiyyRVcbrDiHEkOn6N6G3bVn0NtxcONGdBxhVVRjNt5OayfQA1IfNjIv
   uzWqhGn7Kgsmy98xqWlQguA3ovXij48mU3LX+7boCtVtrF+TZNEnLd7IS
   wfJK7bSEXABPNDbu8R+LZjhG2YuBTSboEPYPgvrvrq1xZJeNd1vdssn0i
   ZN24LN+bjQXyic7NJSxDakOj6/z6+uq5hhBfrNxvOGpoKwWukTBmrV+WL
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10331"; a="266253781"
X-IronPort-AV: E=Sophos;i="5.91,296,1647327600"; 
   d="scan'208";a="266253781"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2022 15:03:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,296,1647327600"; 
   d="scan'208";a="731732115"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 28 Apr 2022 15:03:23 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nkCEM-0005j5-D9;
        Thu, 28 Apr 2022 22:03:22 +0000
Date:   Fri, 29 Apr 2022 06:02:38 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [ardb:arm64-head-refactor-v4 23/38]
 arch/arm64/kernel/pi/kaslr_early.c:95:17: error: call to undeclared function
 '__early_cpu_has_rndr'; ISO C99 and later do not support implicit function
 declarations
Message-ID: <202204290528.NFbq0iMb-lkp@intel.com>
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

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/ardb/linux.git arm64-head-refactor-v4
head:   9e199441095c2a38ba1019e8f782e9fd10876da9
commit: b116ed6cbb1b583ebf32c54fff16e0b3e62fad4f [23/38] arm64: head: relocate kernel only a single time if KASLR is enabled
config: arm64-randconfig-r014-20220428 (https://download.01.org/0day-ci/archive/20220429/202204290528.NFbq0iMb-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project c59473aacce38cd7dd77eebceaf3c98c5707ab3b)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm64 cross compiling tool for clang build
        # apt-get install binutils-aarch64-linux-gnu
        # https://git.kernel.org/pub/scm/linux/kernel/git/ardb/linux.git/commit/?id=b116ed6cbb1b583ebf32c54fff16e0b3e62fad4f
        git remote add ardb git://git.kernel.org/pub/scm/linux/kernel/git/ardb/linux.git
        git fetch --no-tags ardb arm64-head-refactor-v4
        git checkout b116ed6cbb1b583ebf32c54fff16e0b3e62fad4f
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm64 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> arch/arm64/kernel/pi/kaslr_early.c:95:17: error: call to undeclared function '__early_cpu_has_rndr'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
           if (!seed && (!__early_cpu_has_rndr() ||
                          ^
>> arch/arm64/kernel/pi/kaslr_early.c:96:10: error: call to undeclared function '__arm64_rndr'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
                         !__arm64_rndr((unsigned long *)&seed)))
                          ^
   arch/arm64/kernel/pi/kaslr_early.c:87:16: warning: no previous prototype for function 'kaslr_early_init' [-Wmissing-prototypes]
   asmlinkage u64 kaslr_early_init(const void *fdt)
                  ^
   arch/arm64/kernel/pi/kaslr_early.c:87:12: note: declare 'static' if the function is not intended to be used outside of this translation unit
   asmlinkage u64 kaslr_early_init(const void *fdt)
              ^
              static 
   1 warning and 2 errors generated.


vim +/__early_cpu_has_rndr +95 arch/arm64/kernel/pi/kaslr_early.c

    86	
    87	asmlinkage u64 kaslr_early_init(const void *fdt)
    88	{
    89		u64 seed, mask, offset;
    90	
    91		if (is_kaslr_disabled_cmdline(fdt))
    92			return 0;
    93	
    94		seed = get_kaslr_seed(fdt);
  > 95		if (!seed && (!__early_cpu_has_rndr() ||
  > 96			      !__arm64_rndr((unsigned long *)&seed)))
    97			return 0;
    98	
    99		/*
   100		 * OK, so we are proceeding with KASLR enabled. Calculate a suitable
   101		 * kernel image offset from the seed. Let's place the kernel in the
   102		 * middle half of the VMALLOC area (VA_BITS_MIN - 2), and stay clear of
   103		 * the lower and upper quarters to avoid colliding with other
   104		 * allocations.
   105		 * Even if we could randomize at page granularity for 16k and 64k pages,
   106		 * let's always round to 2 MB so we don't interfere with the ability to
   107		 * map using contiguous PTEs
   108		 */
   109		mask = ((1UL << (VA_BITS_MIN - 2)) - 1) & ~(SZ_2M - 1);
   110		offset = BIT(VA_BITS_MIN - 3) + (seed & mask);
   111	
   112		if (!IS_ENABLED(CONFIG_KASAN_VMALLOC) &&
   113		    (IS_ENABLED(CONFIG_KASAN_GENERIC) ||
   114		     IS_ENABLED(CONFIG_KASAN_SW_TAGS)))
   115			/*
   116			 * KASAN without KASAN_VMALLOC does not expect the module region
   117			 * to intersect the vmalloc region, since shadow memory is
   118			 * allocated for each module at load time, whereas the vmalloc
   119			 * region is shadowed by KASAN zero pages. So keep modules
   120			 * out of the vmalloc region if KASAN is enabled without
   121			 * KASAN_VMALLOC, and put the kernel well within 4 GB of the
   122			 * module region.
   123			 */
   124			return offset % SZ_2G;
   125	
   126		return offset;
   127	}
   128	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
