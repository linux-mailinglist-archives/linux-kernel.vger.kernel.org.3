Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D3AF49F0DE
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 03:18:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345255AbiA1CQu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 21:16:50 -0500
Received: from mga02.intel.com ([134.134.136.20]:59247 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1345221AbiA1CQt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 21:16:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643336209; x=1674872209;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=8JxPEhFMsspR4OIfOK+OrFTfWgdbsDxM05ouNkLUsAw=;
  b=X/IRrByleE1HKA6Tuz3NNLEleKydvpyZGuT6mK03sHrO0rd+MQ1KDdpe
   Vvq85gGFYdFE2JcAFTv2JwmHF8FfMjvG/Jvr/gBlUqfxOYsU889zehH4N
   xcWk7qmgOw5Kb90uhk6mMdSfj8uEkyGlbM0YzKz61M0G22lpqO0qOgO3R
   DO1j4I4uck/KVsNz2NXYVRX1FUv6DlWZIRxbFN6ZJjY3ylNGGmXsY3fwi
   oyuEuL8C2wTewBe8iTwnm61bSOAfg82vn8xtN0JJMCM67m+QwHHNFmpBh
   IfLM9usv8GStSaRo/VnV1hH1Xg02roPPwP6ciatB6nzTyZJUXqe/w9KBV
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10240"; a="234398335"
X-IronPort-AV: E=Sophos;i="5.88,322,1635231600"; 
   d="scan'208";a="234398335"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2022 18:16:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,322,1635231600"; 
   d="scan'208";a="495961848"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 27 Jan 2022 18:16:47 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nDGog-000NIJ-LY; Fri, 28 Jan 2022 02:16:46 +0000
Date:   Fri, 28 Jan 2022 10:16:06 +0800
From:   kernel test robot <lkp@intel.com>
To:     Tom Zanussi <zanussi@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [zanussi-trace:ftrace/misc-bugfixes-v1 6/7]
 include/linux/fortify-string.h:47:30: warning: '__builtin_strncat' output
 truncated before terminating nul copying as many bytes from a string as its
 length
Message-ID: <202201281016.u1LRBCEw-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/zanussi/linux-trace.git ftrace/misc-bugfixes-v1
head:   a291c672d6e1d7f557d9e15a5ac3f0b446e29dcd
commit: b519e15e681319e99055a92c8d090072ebb2b179 [6/7] tracing: Remove size restriction on hist trigger cmd error logging
config: i386-randconfig-a002-20220124 (https://download.01.org/0day-ci/archive/20220128/202201281016.u1LRBCEw-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/zanussi/linux-trace.git/commit/?id=b519e15e681319e99055a92c8d090072ebb2b179
        git remote add zanussi-trace https://git.kernel.org/pub/scm/linux/kernel/git/zanussi/linux-trace.git
        git fetch --no-tags zanussi-trace ftrace/misc-bugfixes-v1
        git checkout b519e15e681319e99055a92c8d090072ebb2b179
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash kernel/trace/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from include/linux/string.h:253,
                    from arch/x86/include/asm/page_32.h:35,
                    from arch/x86/include/asm/page.h:14,
                    from arch/x86/include/asm/processor.h:19,
                    from arch/x86/include/asm/timex.h:5,
                    from include/linux/timex.h:65,
                    from include/linux/time32.h:13,
                    from include/linux/time.h:60,
                    from include/linux/stat.h:19,
                    from include/linux/module.h:13,
                    from kernel/trace/trace_events_hist.c:8:
   In function 'strncat',
       inlined from 'last_cmd_set' at kernel/trace/trace_events_hist.c:759:2,
       inlined from 'event_hist_trigger_parse' at kernel/trace/trace_events_hist.c:6190:3:
>> include/linux/fortify-string.h:47:30: warning: '__builtin_strncat' output truncated before terminating nul copying as many bytes from a string as its length [-Wstringop-truncation]
      47 | #define __underlying_strncat __builtin_strncat
         |                              ^
   include/linux/fortify-string.h:191:10: note: in expansion of macro '__underlying_strncat'
     191 |   return __underlying_strncat(p, q, count);
         |          ^~~~~~~~~~~~~~~~~~~~
   kernel/trace/trace_events_hist.c: In function 'event_hist_trigger_parse':
   include/linux/fortify-string.h:46:29: note: length computed here
      46 | #define __underlying_strlen __builtin_strlen
         |                             ^
   include/linux/fortify-string.h:102:10: note: in expansion of macro '__underlying_strlen'
     102 |   return __underlying_strlen(p);
         |          ^~~~~~~~~~~~~~~~~~~


vim +/__builtin_strncat +47 include/linux/fortify-string.h

3009f891bb9f328 Kees Cook      2021-08-02  26  
a28a6e860c6cf23 Francis Laniel 2021-02-25  27  #if defined(CONFIG_KASAN_GENERIC) || defined(CONFIG_KASAN_SW_TAGS)
a28a6e860c6cf23 Francis Laniel 2021-02-25  28  extern void *__underlying_memchr(const void *p, int c, __kernel_size_t size) __RENAME(memchr);
a28a6e860c6cf23 Francis Laniel 2021-02-25  29  extern int __underlying_memcmp(const void *p, const void *q, __kernel_size_t size) __RENAME(memcmp);
a28a6e860c6cf23 Francis Laniel 2021-02-25  30  extern void *__underlying_memcpy(void *p, const void *q, __kernel_size_t size) __RENAME(memcpy);
a28a6e860c6cf23 Francis Laniel 2021-02-25  31  extern void *__underlying_memmove(void *p, const void *q, __kernel_size_t size) __RENAME(memmove);
a28a6e860c6cf23 Francis Laniel 2021-02-25  32  extern void *__underlying_memset(void *p, int c, __kernel_size_t size) __RENAME(memset);
a28a6e860c6cf23 Francis Laniel 2021-02-25  33  extern char *__underlying_strcat(char *p, const char *q) __RENAME(strcat);
a28a6e860c6cf23 Francis Laniel 2021-02-25  34  extern char *__underlying_strcpy(char *p, const char *q) __RENAME(strcpy);
a28a6e860c6cf23 Francis Laniel 2021-02-25  35  extern __kernel_size_t __underlying_strlen(const char *p) __RENAME(strlen);
a28a6e860c6cf23 Francis Laniel 2021-02-25  36  extern char *__underlying_strncat(char *p, const char *q, __kernel_size_t count) __RENAME(strncat);
a28a6e860c6cf23 Francis Laniel 2021-02-25  37  extern char *__underlying_strncpy(char *p, const char *q, __kernel_size_t size) __RENAME(strncpy);
a28a6e860c6cf23 Francis Laniel 2021-02-25  38  #else
a28a6e860c6cf23 Francis Laniel 2021-02-25  39  #define __underlying_memchr	__builtin_memchr
a28a6e860c6cf23 Francis Laniel 2021-02-25  40  #define __underlying_memcmp	__builtin_memcmp
a28a6e860c6cf23 Francis Laniel 2021-02-25  41  #define __underlying_memcpy	__builtin_memcpy
a28a6e860c6cf23 Francis Laniel 2021-02-25  42  #define __underlying_memmove	__builtin_memmove
a28a6e860c6cf23 Francis Laniel 2021-02-25  43  #define __underlying_memset	__builtin_memset
a28a6e860c6cf23 Francis Laniel 2021-02-25  44  #define __underlying_strcat	__builtin_strcat
a28a6e860c6cf23 Francis Laniel 2021-02-25  45  #define __underlying_strcpy	__builtin_strcpy
a28a6e860c6cf23 Francis Laniel 2021-02-25  46  #define __underlying_strlen	__builtin_strlen
a28a6e860c6cf23 Francis Laniel 2021-02-25 @47  #define __underlying_strncat	__builtin_strncat
a28a6e860c6cf23 Francis Laniel 2021-02-25  48  #define __underlying_strncpy	__builtin_strncpy
a28a6e860c6cf23 Francis Laniel 2021-02-25  49  #endif
a28a6e860c6cf23 Francis Laniel 2021-02-25  50  

:::::: The code at line 47 was first introduced by commit
:::::: a28a6e860c6cf231cf3c5171c75c342adcd00406 string.h: move fortified functions definitions in a dedicated header.

:::::: TO: Francis Laniel <laniel_francis@privacyrequired.com>
:::::: CC: Linus Torvalds <torvalds@linux-foundation.org>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
