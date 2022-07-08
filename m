Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70D7456BBA2
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 16:24:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236879AbiGHOQ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 10:16:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235326AbiGHOQ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 10:16:56 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A703F1C939
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jul 2022 07:16:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657289814; x=1688825814;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=HjTL6WcOh4+C4byoD+02hSwuUEza4U1WxzZNH4fZWL0=;
  b=T3FJWFFjqNe+QDEZ5+hbpOQYS6dtAso8xnaP3AfhxIwYNQdwbo+zUFXE
   Vk3tFPFMZ1fQfUAI9ENVfcnL5xTR9/CCzVElpCj1Jo3cTDGJA0Br/31tg
   By72cibFRzT0hOPRJV3uhCEEwtXMH5x02QxDPwe9fPQwSxAbwbEG31I/f
   AO/gD2AMFTGrW7QWylxs75XVgJo5HES7yXOlAeS9eg5tVhUBIF6kKzy+g
   c1x8Vz3rAQFIfRJTOJMZtjr2TObEh8SC00YbREdwuGzsjop8pk+ZOKHvW
   pnKVtP8Xurw2Vuk6NtcJ8rCGWAH5KK/eTpbSxgMFtNqqxjt/nfdZYl17p
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10401"; a="284311560"
X-IronPort-AV: E=Sophos;i="5.92,255,1650956400"; 
   d="scan'208";a="284311560"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2022 07:16:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,255,1650956400"; 
   d="scan'208";a="661785561"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 08 Jul 2022 07:16:53 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o9omq-000NZq-ES;
        Fri, 08 Jul 2022 14:16:52 +0000
Date:   Fri, 8 Jul 2022 22:16:24 +0800
From:   kernel test robot <lkp@intel.com>
To:     Matteo Croce <mcroce@microsoft.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>
Subject: [esmil:visionfive 4/50] arch/riscv/include/asm/string.h:22:25:
 error: redefinition of '__memset'
Message-ID: <202207082206.bRkyTg6X-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/esmil/linux visionfive
head:   943858df470556d0b7f3b31fcc10931603f0f3cc
commit: bdf1612f166c6ff3822236aa35c1497449fe7d35 [4/50] riscv: optimized memset
config: riscv-allyesconfig (https://download.01.org/0day-ci/archive/20220708/202207082206.bRkyTg6X-lkp@intel.com/config)
compiler: riscv64-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/esmil/linux/commit/bdf1612f166c6ff3822236aa35c1497449fe7d35
        git remote add esmil https://github.com/esmil/linux
        git fetch --no-tags esmil visionfive
        git checkout bdf1612f166c6ff3822236aa35c1497449fe7d35
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=riscv SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from include/linux/string.h:20,
                    from include/linux/bitmap.h:11,
                    from include/linux/cpumask.h:12,
                    from include/linux/mm_types_task.h:14,
                    from include/linux/mm_types.h:5,
                    from include/linux/buildid.h:5,
                    from include/linux/module.h:14,
                    from arch/riscv/lib/string.c:11:
   arch/riscv/include/asm/string.h:21:31: error: redefinition of '__memcpy'
      21 | #define memcpy(dst, src, len) __memcpy(dst, src, len)
         |                               ^~~~~~~~
   arch/riscv/lib/string.c:90:7: note: in expansion of macro 'memcpy'
      90 | void *memcpy(void *dest, const void *src, size_t count) __weak __alias(__memcpy);
         |       ^~~~~~
   arch/riscv/lib/string.c:31:7: note: previous definition of '__memcpy' with type 'void *(void *, const void *, size_t)' {aka 'void *(void *, const void *, long unsigned int)'}
      31 | void *__memcpy(void *dest, const void *src, size_t count)
         |       ^~~~~~~~
   In file included from include/linux/string.h:20,
                    from include/linux/bitmap.h:11,
                    from include/linux/cpumask.h:12,
                    from include/linux/mm_types_task.h:14,
                    from include/linux/mm_types.h:5,
                    from include/linux/buildid.h:5,
                    from include/linux/module.h:14,
                    from arch/riscv/lib/string.c:11:
   arch/riscv/include/asm/string.h:23:32: error: redefinition of '__memmove'
      23 | #define memmove(dst, src, len) __memmove(dst, src, len)
         |                                ^~~~~~~~~
   arch/riscv/lib/string.c:113:7: note: in expansion of macro 'memmove'
     113 | void *memmove(void *dest, const void *src, size_t count) __weak __alias(__memmove);
         |       ^~~~~~~
   arch/riscv/lib/string.c:97:7: note: previous definition of '__memmove' with type 'void *(void *, const void *, size_t)' {aka 'void *(void *, const void *, long unsigned int)'}
      97 | void *__memmove(void *dest, const void *src, size_t count)
         |       ^~~~~~~~~
   In file included from include/linux/string.h:20,
                    from include/linux/bitmap.h:11,
                    from include/linux/cpumask.h:12,
                    from include/linux/mm_types_task.h:14,
                    from include/linux/mm_types.h:5,
                    from include/linux/buildid.h:5,
                    from include/linux/module.h:14,
                    from arch/riscv/lib/string.c:11:
>> arch/riscv/include/asm/string.h:22:25: error: redefinition of '__memset'
      22 | #define memset(s, c, n) __memset(s, c, n)
         |                         ^~~~~~~~
   arch/riscv/lib/string.c:154:7: note: in expansion of macro 'memset'
     154 | void *memset(void *s, int c, size_t count) __weak __alias(__memset);
         |       ^~~~~~
   arch/riscv/lib/string.c:116:7: note: previous definition of '__memset' with type 'void *(void *, int,  size_t)' {aka 'void *(void *, int,  long unsigned int)'}
     116 | void *__memset(void *s, int c, size_t count)
         |       ^~~~~~~~


vim +/__memset +22 arch/riscv/include/asm/string.h

163ef6b6c194ae4 Matteo Croce 2021-09-29  18  
8ad8b72721d0f07 Nick Hu      2020-01-06  19  /* For those files which don't want to check by kasan. */
8ad8b72721d0f07 Nick Hu      2020-01-06  20  #if defined(CONFIG_KASAN) && !defined(__SANITIZE_ADDRESS__)
8ad8b72721d0f07 Nick Hu      2020-01-06  21  #define memcpy(dst, src, len) __memcpy(dst, src, len)
8ad8b72721d0f07 Nick Hu      2020-01-06 @22  #define memset(s, c, n) __memset(s, c, n)
04091d6c0535f6d Nylon Chen   2020-11-30  23  #define memmove(dst, src, len) __memmove(dst, src, len)
9530141455c9689 Kefeng Wang  2021-02-25  24  

:::::: The code at line 22 was first introduced by commit
:::::: 8ad8b72721d0f07fa02dbe71f901743f9c71c8e6 riscv: Add KASAN support

:::::: TO: Nick Hu <nickhu@andestech.com>
:::::: CC: Palmer Dabbelt <palmerdabbelt@google.com>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
