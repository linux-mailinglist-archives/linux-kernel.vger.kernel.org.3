Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C3C556BFD9
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 20:36:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238877AbiGHQQX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 12:16:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237995AbiGHQQV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 12:16:21 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE6DA76EB4
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jul 2022 09:16:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657296981; x=1688832981;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=U8Q/JDShkN96zOSvjLaUmT9NJN1lPPjA0YfUSeO2/BM=;
  b=NKpqIpoMvYOkgNR+UL2vpnxppb/T5Y11+P9RCW0EXQxuL4gq3rAxlau8
   6vO1Uj5yG3BEI6sfwsT6TrRkphXbaiE5kqVKys6UOxogJjhau9/6SRnGP
   tWL4CHcaTmqKkR4ZUt70agmZ0vtsG3VFPtZ/NkR8ja+oXb02/JoCFUs60
   UVwDNpxGlWYrVq0zYujFi//gEYs6NC6OMF/Z2AAqTsvvxtJ2wfl4y3RRu
   YSHdhuQ+43RT8wc3zH6F5Np/j86SIdg12A2St3YwvKFMCQNJweeV/kHeO
   0Q4y1zXJAp7Y8U41gGFjwePQh2yGDo6ZaVSqQ3ArSvoeVplh1qrbN1TV8
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10402"; a="285056041"
X-IronPort-AV: E=Sophos;i="5.92,256,1650956400"; 
   d="scan'208";a="285056041"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2022 09:15:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,256,1650956400"; 
   d="scan'208";a="544260506"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 08 Jul 2022 09:15:58 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o9qe5-000NgU-R2;
        Fri, 08 Jul 2022 16:15:57 +0000
Date:   Sat, 9 Jul 2022 00:15:37 +0800
From:   kernel test robot <lkp@intel.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [arm-integrator:kernel-in-vmalloc-v5.19-rc1 27/35] ld.lld: error:
 arch/powerpc/kernel/vdso/vdso32.lds:244: unknown directive: static
Message-ID: <202207090002.wns3emYw-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-integrator.git kernel-in-vmalloc-v5.19-rc1
head:   144435741b0a6f31403d3084103678da3b4f9d11
commit: 67a0731f120a735a7d6f8685d1fed092e460902e [27/35] powerpc: Make virt_to_pfn() a static inline
config: powerpc-mpc8315_rdb_defconfig (https://download.01.org/0day-ci/archive/20220709/202207090002.wns3emYw-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 562c3467a6738aa89203f72fc1d1343e5baadf3c)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install powerpc cross compiling tool for clang build
        # apt-get install binutils-powerpc-linux-gnu
        # https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-integrator.git/commit/?id=67a0731f120a735a7d6f8685d1fed092e460902e
        git remote add arm-integrator https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-integrator.git
        git fetch --no-tags arm-integrator kernel-in-vmalloc-v5.19-rc1
        git checkout 67a0731f120a735a7d6f8685d1fed092e460902e
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=powerpc prepare

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> ld.lld: error: arch/powerpc/kernel/vdso/vdso32.lds:244: unknown directive: static
   >>> static inline unsigned long virt_to_pfn(const volatile void *kaddr)
   >>> ^
   clang-15: error: linker command failed with exit code 1 (use -v to see invocation)
   make[2]: *** [arch/powerpc/kernel/vdso/Makefile:66: arch/powerpc/kernel/vdso/vdso32.so.dbg] Error 1
   make[2]: Target 'include/generated/vdso32-offsets.h' not remade because of errors.
   make[1]: *** [arch/powerpc/Makefile:422: vdso_prepare] Error 2
   make[1]: Target 'prepare' not remade because of errors.
   make: *** [Makefile:219: __sub-make] Error 2
   make: Target 'prepare' not remade because of errors.

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
