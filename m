Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDBBF49F679
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 10:37:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243714AbiA1JhM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 04:37:12 -0500
Received: from mga05.intel.com ([192.55.52.43]:18943 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238119AbiA1JhK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 04:37:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643362630; x=1674898630;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=VqXmCSG2Gq/rSqqdvuF6nNHGo04wgF2UCN2DCxhbrFA=;
  b=fWMfYN6Wjap0Z3Rx4f+d5mhcQF1BjJFdaB+nBq9hoWdVZ1UVrK5Xq+pj
   nYZTmUoDWeRp+0UbPbbJXibWuoJ6E/QQqSU2WCH/kUVGoYzYh1faQj5yL
   Pr9oCaLKtD7URPQ04WuiavG0yfJyRpI1HcZoyPTaaQqlu59T6a1V20k++
   tkHEodhFwppJfNRUhyc4pN8xTYKOxUOPBVzBbEAFnnXJbabUWMxjWWhjr
   9Tn2IrM6b30f5IqdtebcDCLE4Yvkr4zpPndFnPXUZLOs4G+98fntdCLkj
   IGfvlYictJRxuDIsw13f3gTL5Bjyfod6QqDRK+/Cp2vGTuCtm4mJdjarP
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10240"; a="333439738"
X-IronPort-AV: E=Sophos;i="5.88,323,1635231600"; 
   d="scan'208";a="333439738"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2022 01:37:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,323,1635231600"; 
   d="scan'208";a="625582200"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 28 Jan 2022 01:37:07 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nDNgp-000Ni1-8N; Fri, 28 Jan 2022 09:37:07 +0000
Date:   Fri, 28 Jan 2022 17:36:33 +0800
From:   kernel test robot <lkp@intel.com>
To:     Tom Zanussi <zanussi@kernel.org>
Cc:     kbuild-all@lists.01.org, GNU/Weeb Mailing List <gwml@gnuweeb.org>,
        linux-kernel@vger.kernel.org,
        "Steven Rostedt (Google)" <rostedt@goodmis.org>
Subject: [ammarfaizi2-block:rostedt/linux-trace/ftrace/core 13/13]
 include/linux/fortify-string.h:48:30: warning: '__builtin_strncpy' output
 truncated before terminating nul copying as many bytes from a string as its
 length
Message-ID: <202201281716.fJjEsoAS-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ammarfaizi2/linux-block rostedt/linux-trace/ftrace/core
head:   f125ef075cd648a7794aa0cc61a188b1c40c8f94
commit: f125ef075cd648a7794aa0cc61a188b1c40c8f94 [13/13] tracing: Remove size restriction on synthetic event cmd error logging
config: x86_64-randconfig-a011 (https://download.01.org/0day-ci/archive/20220128/202201281716.fJjEsoAS-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build):
        # https://github.com/ammarfaizi2/linux-block/commit/f125ef075cd648a7794aa0cc61a188b1c40c8f94
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block rostedt/linux-trace/ftrace/core
        git checkout f125ef075cd648a7794aa0cc61a188b1c40c8f94
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash kernel/trace/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from include/linux/string.h:253,
                    from include/linux/bitmap.h:11,
                    from include/linux/cpumask.h:12,
                    from arch/x86/include/asm/cpumask.h:5,
                    from arch/x86/include/asm/msr.h:11,
                    from arch/x86/include/asm/processor.h:22,
                    from arch/x86/include/asm/timex.h:5,
                    from include/linux/timex.h:65,
                    from include/linux/time32.h:13,
                    from include/linux/time.h:60,
                    from include/linux/stat.h:19,
                    from include/linux/module.h:13,
                    from kernel/trace/trace_events_synth.c:8:
   In function 'strncpy',
       inlined from 'last_cmd_set.part.0' at kernel/trace/trace_events_synth.c:65:2:
>> include/linux/fortify-string.h:48:30: warning: '__builtin_strncpy' output truncated before terminating nul copying as many bytes from a string as its length [-Wstringop-truncation]
      48 | #define __underlying_strncpy __builtin_strncpy
         |                              ^
   include/linux/fortify-string.h:59:9: note: in expansion of macro '__underlying_strncpy'
      59 |  return __underlying_strncpy(p, q, size);
         |         ^~~~~~~~~~~~~~~~~~~~
   kernel/trace/trace_events_synth.c: In function 'last_cmd_set.part.0':
   include/linux/fortify-string.h:46:29: note: length computed here
      46 | #define __underlying_strlen __builtin_strlen
         |                             ^
   include/linux/fortify-string.h:102:10: note: in expansion of macro '__underlying_strlen'
     102 |   return __underlying_strlen(p);
         |          ^~~~~~~~~~~~~~~~~~~


vim +/__builtin_strncpy +48 include/linux/fortify-string.h

3009f891bb9f32 Kees Cook      2021-08-02  26  
a28a6e860c6cf2 Francis Laniel 2021-02-25  27  #if defined(CONFIG_KASAN_GENERIC) || defined(CONFIG_KASAN_SW_TAGS)
a28a6e860c6cf2 Francis Laniel 2021-02-25  28  extern void *__underlying_memchr(const void *p, int c, __kernel_size_t size) __RENAME(memchr);
a28a6e860c6cf2 Francis Laniel 2021-02-25  29  extern int __underlying_memcmp(const void *p, const void *q, __kernel_size_t size) __RENAME(memcmp);
a28a6e860c6cf2 Francis Laniel 2021-02-25  30  extern void *__underlying_memcpy(void *p, const void *q, __kernel_size_t size) __RENAME(memcpy);
a28a6e860c6cf2 Francis Laniel 2021-02-25  31  extern void *__underlying_memmove(void *p, const void *q, __kernel_size_t size) __RENAME(memmove);
a28a6e860c6cf2 Francis Laniel 2021-02-25  32  extern void *__underlying_memset(void *p, int c, __kernel_size_t size) __RENAME(memset);
a28a6e860c6cf2 Francis Laniel 2021-02-25  33  extern char *__underlying_strcat(char *p, const char *q) __RENAME(strcat);
a28a6e860c6cf2 Francis Laniel 2021-02-25  34  extern char *__underlying_strcpy(char *p, const char *q) __RENAME(strcpy);
a28a6e860c6cf2 Francis Laniel 2021-02-25  35  extern __kernel_size_t __underlying_strlen(const char *p) __RENAME(strlen);
a28a6e860c6cf2 Francis Laniel 2021-02-25  36  extern char *__underlying_strncat(char *p, const char *q, __kernel_size_t count) __RENAME(strncat);
a28a6e860c6cf2 Francis Laniel 2021-02-25  37  extern char *__underlying_strncpy(char *p, const char *q, __kernel_size_t size) __RENAME(strncpy);
a28a6e860c6cf2 Francis Laniel 2021-02-25  38  #else
a28a6e860c6cf2 Francis Laniel 2021-02-25  39  #define __underlying_memchr	__builtin_memchr
a28a6e860c6cf2 Francis Laniel 2021-02-25  40  #define __underlying_memcmp	__builtin_memcmp
a28a6e860c6cf2 Francis Laniel 2021-02-25  41  #define __underlying_memcpy	__builtin_memcpy
a28a6e860c6cf2 Francis Laniel 2021-02-25  42  #define __underlying_memmove	__builtin_memmove
a28a6e860c6cf2 Francis Laniel 2021-02-25  43  #define __underlying_memset	__builtin_memset
a28a6e860c6cf2 Francis Laniel 2021-02-25  44  #define __underlying_strcat	__builtin_strcat
a28a6e860c6cf2 Francis Laniel 2021-02-25  45  #define __underlying_strcpy	__builtin_strcpy
a28a6e860c6cf2 Francis Laniel 2021-02-25  46  #define __underlying_strlen	__builtin_strlen
a28a6e860c6cf2 Francis Laniel 2021-02-25  47  #define __underlying_strncat	__builtin_strncat
a28a6e860c6cf2 Francis Laniel 2021-02-25 @48  #define __underlying_strncpy	__builtin_strncpy
a28a6e860c6cf2 Francis Laniel 2021-02-25  49  #endif
a28a6e860c6cf2 Francis Laniel 2021-02-25  50  

:::::: The code at line 48 was first introduced by commit
:::::: a28a6e860c6cf231cf3c5171c75c342adcd00406 string.h: move fortified functions definitions in a dedicated header.

:::::: TO: Francis Laniel <laniel_francis@privacyrequired.com>
:::::: CC: Linus Torvalds <torvalds@linux-foundation.org>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
