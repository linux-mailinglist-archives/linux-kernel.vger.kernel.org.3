Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8027F4B5199
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 14:26:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354269AbiBNN0U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 08:26:20 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:44240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349573AbiBNN0S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 08:26:18 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED39648889
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 05:26:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644845170; x=1676381170;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=5jNgIHxNZOOS/AB+upxJvjRy/e4U4wwkc8aLnCKWzG0=;
  b=D1vEp4EO03cHWLXJFmSLcAfH8aGy4b7o/MJSikWgPJuKm0VIa0Gqlswm
   lPIfbTfkD+zMs4E64b+2+8g68NI30sCzi52VB1jq3nRXs0dY0p+mpqa/C
   8vYMuafhCBUn7tuGE63Vkcbl9U1qVI0KOfA+bP4pbEaN5FiurOVzXSQTl
   5ZMaokZK+B15+57kRkElnbJ2kKyBCLEU389HYeRftvbG72JebgsLzK9xL
   gJWMETDXX3oqik3FEIQa8xvQiF3qREqOwRd5R7d1X1gGdO9R4kVxS1BHB
   Lx7RUULcs1zjHfrQnt2v1JXY+0g12mx2IWpksy0O1qNHI3iAQerUZuCcd
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10257"; a="250292283"
X-IronPort-AV: E=Sophos;i="5.88,367,1635231600"; 
   d="scan'208";a="250292283"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2022 05:26:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,367,1635231600"; 
   d="scan'208";a="624217028"
Received: from lkp-server01.sh.intel.com (HELO d95dc2dabeb1) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 14 Feb 2022 05:26:09 -0800
Received: from kbuild by d95dc2dabeb1 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nJbMi-0008aY-6U; Mon, 14 Feb 2022 13:26:04 +0000
Date:   Mon, 14 Feb 2022 21:25:17 +0800
From:   kernel test robot <lkp@intel.com>
To:     Helge Deller <deller@gmx.de>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [deller-parisc:for-next 5/6] arch/parisc/include/asm/bitops.h:20:2:
 error: #error "Please use 'ARCH=parisc64' to build the 64-bit kernel."
Message-ID: <202202142139.fHrrv9Oy-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux.git for-next
head:   dbd0b42350d5717786cb8257fbe5b528f3af9772
commit: b160628e9ebcdc85d0db9d7f423c26b3c7c179d0 [5/6] parisc: Show error if wrong 32/64-bit compiler is being used
config: parisc-randconfig-r004-20220213 (https://download.01.org/0day-ci/archive/20220214/202202142139.fHrrv9Oy-lkp@intel.com/config)
compiler: hppa64-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux.git/commit/?id=b160628e9ebcdc85d0db9d7f423c26b3c7c179d0
        git remote add deller-parisc https://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux.git
        git fetch --no-tags deller-parisc for-next
        git checkout b160628e9ebcdc85d0db9d7f423c26b3c7c179d0
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=parisc prepare

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from include/linux/bitops.h:33,
                    from include/linux/kernel.h:22,
                    from arch/parisc/include/asm/bug.h:5,
                    from include/linux/bug.h:5,
                    from include/linux/page-flags.h:10,
                    from kernel/bounds.c:10:
>> arch/parisc/include/asm/bitops.h:20:2: error: #error "Please use 'ARCH=parisc64' to build the 64-bit kernel."
      20 | #error "Please use 'ARCH=parisc64' to build the 64-bit kernel."
         |  ^~~~~
   In file included from arch/parisc/include/asm/bitops.h:209,
                    from include/linux/bitops.h:33,
                    from include/linux/kernel.h:22,
                    from arch/parisc/include/asm/bug.h:5,
                    from include/linux/bug.h:5,
                    from include/linux/page-flags.h:10,
                    from kernel/bounds.c:10:
   include/asm-generic/bitops/__fls.h: In function '__fls':
   include/asm-generic/bitops/__fls.h:18:28: warning: left shift count >= width of type [-Wshift-count-overflow]
      18 |         if (!(word & (~0ul << 32))) {
         |                            ^~
   include/asm-generic/bitops/__fls.h:20:22: warning: left shift count >= width of type [-Wshift-count-overflow]
      20 |                 word <<= 32;
         |                      ^~~
   include/asm-generic/bitops/__fls.h:23:28: warning: left shift count >= width of type [-Wshift-count-overflow]
      23 |         if (!(word & (~0ul << (BITS_PER_LONG-16)))) {
         |                            ^~
   include/asm-generic/bitops/__fls.h:27:28: warning: left shift count >= width of type [-Wshift-count-overflow]
      27 |         if (!(word & (~0ul << (BITS_PER_LONG-8)))) {
         |                            ^~
   include/asm-generic/bitops/__fls.h:31:28: warning: left shift count >= width of type [-Wshift-count-overflow]
      31 |         if (!(word & (~0ul << (BITS_PER_LONG-4)))) {
         |                            ^~
   include/asm-generic/bitops/__fls.h:35:28: warning: left shift count >= width of type [-Wshift-count-overflow]
      35 |         if (!(word & (~0ul << (BITS_PER_LONG-2)))) {
         |                            ^~
   include/asm-generic/bitops/__fls.h:39:28: warning: left shift count >= width of type [-Wshift-count-overflow]
      39 |         if (!(word & (~0ul << (BITS_PER_LONG-1))))
         |                            ^~
   make[2]: *** [scripts/Makefile.build:121: kernel/bounds.s] Error 1
   make[2]: Target '__build' not remade because of errors.
   make[1]: *** [Makefile:1191: prepare0] Error 2
   make[1]: Target 'prepare' not remade because of errors.
   make: *** [Makefile:219: __sub-make] Error 2
   make: Target 'prepare' not remade because of errors.


vim +20 arch/parisc/include/asm/bitops.h

    14	
    15	/* compiler build environment sanity checks: */
    16	#if !defined(CONFIG_64BIT) && defined(__LP64__)
    17	#error "Please use 'ARCH=parisc' to build the 32-bit kernel."
    18	#endif
    19	#if defined(CONFIG_64BIT) && !defined(__LP64__)
  > 20	#error "Please use 'ARCH=parisc64' to build the 64-bit kernel."
    21	#endif
    22	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
