Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 917F55684EC
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 12:14:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232736AbiGFKN7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 06:13:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231898AbiGFKN5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 06:13:57 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9174DE8
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jul 2022 03:13:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657102436; x=1688638436;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=C8e9Ary7CS/Usq4YlOj+xf9gVfFxt63NWjas0FuW7E8=;
  b=AN6A4IukANF3BJ1l6UUDWbhxgGa5lNOxRI/vKZORBWjNPWNqw7/Yqbcl
   txTg4tSYLfGJg1h0ArkDymnWZ3d//0M4K4roWTcKB7QeD5lQpNHNlCdaN
   07SvvYnm/O0tU7s7tjzY8nQilEDxnJ4/iMxXP8tTSImzky/QHCGSqDrSF
   BeT0OPmQQqMqDhK1HZc0LdV/rWPAZ7qY+EkiF1OTMTSmbDZveHXIrImdt
   QrerWq7yWoETMGKM/dHCms56XJLpvMbl/EX2l96rLPMLfmF3VVOWttbnS
   YYEvLmws0POC03D1cuSK4Yum3jNDOwBKHHYcnQu5Sn8R5TJd/IHGMA4YT
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10399"; a="272490303"
X-IronPort-AV: E=Sophos;i="5.92,249,1650956400"; 
   d="scan'208";a="272490303"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2022 03:13:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,249,1650956400"; 
   d="scan'208";a="720080321"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 06 Jul 2022 03:13:55 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o922c-000KQH-BU;
        Wed, 06 Jul 2022 10:13:54 +0000
Date:   Wed, 6 Jul 2022 18:12:56 +0800
From:   kernel test robot <lkp@intel.com>
To:     Matteo Croce <mcroce@microsoft.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>
Subject: [esmil:visionfive 3/50] arch/riscv/include/asm/string.h:27:32:
 error: redefinition of '__memmove'
Message-ID: <202207061822.TbmIa2x2-lkp@intel.com>
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

tree:   https://github.com/esmil/linux visionfive
head:   943858df470556d0b7f3b31fcc10931603f0f3cc
commit: 163ef6b6c194ae4d1f709053e4677687e6b87a27 [3/50] riscv: optimized memmove
config: riscv-allyesconfig (https://download.01.org/0day-ci/archive/20220706/202207061822.TbmIa2x2-lkp@intel.com/config)
compiler: riscv64-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/esmil/linux/commit/163ef6b6c194ae4d1f709053e4677687e6b87a27
        git remote add esmil https://github.com/esmil/linux
        git fetch --no-tags esmil visionfive
        git checkout 163ef6b6c194ae4d1f709053e4677687e6b87a27
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
   arch/riscv/include/asm/string.h:25:31: error: redefinition of '__memcpy'
      25 | #define memcpy(dst, src, len) __memcpy(dst, src, len)
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
>> arch/riscv/include/asm/string.h:27:32: error: redefinition of '__memmove'
      27 | #define memmove(dst, src, len) __memmove(dst, src, len)
         |                                ^~~~~~~~~
   arch/riscv/lib/string.c:113:7: note: in expansion of macro 'memmove'
     113 | void *memmove(void *dest, const void *src, size_t count) __weak __alias(__memmove);
         |       ^~~~~~~
   arch/riscv/lib/string.c:97:7: note: previous definition of '__memmove' with type 'void *(void *, const void *, size_t)' {aka 'void *(void *, const void *, long unsigned int)'}
      97 | void *__memmove(void *dest, const void *src, size_t count)
         |       ^~~~~~~~~


vim +/__memmove +27 arch/riscv/include/asm/string.h

163ef6b6c194ae Matteo Croce 2021-09-29  22  
8ad8b72721d0f0 Nick Hu      2020-01-06  23  /* For those files which don't want to check by kasan. */
8ad8b72721d0f0 Nick Hu      2020-01-06  24  #if defined(CONFIG_KASAN) && !defined(__SANITIZE_ADDRESS__)
8ad8b72721d0f0 Nick Hu      2020-01-06  25  #define memcpy(dst, src, len) __memcpy(dst, src, len)
8ad8b72721d0f0 Nick Hu      2020-01-06  26  #define memset(s, c, n) __memset(s, c, n)
04091d6c0535f6 Nylon Chen   2020-11-30 @27  #define memmove(dst, src, len) __memmove(dst, src, len)
9530141455c968 Kefeng Wang  2021-02-25  28  

:::::: The code at line 27 was first introduced by commit
:::::: 04091d6c0535f6dc82af864ab56425235c6581a4 riscv: provide memmove implementation

:::::: TO: Nylon Chen <nylon7@andestech.com>
:::::: CC: Palmer Dabbelt <palmerdabbelt@google.com>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
