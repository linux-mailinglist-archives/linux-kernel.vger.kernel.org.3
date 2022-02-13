Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47A164B3E24
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Feb 2022 23:43:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237196AbiBMWnV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Feb 2022 17:43:21 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:56348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231864AbiBMWnU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Feb 2022 17:43:20 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D266F54BD7
        for <linux-kernel@vger.kernel.org>; Sun, 13 Feb 2022 14:43:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644792193; x=1676328193;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=5I70INCTAFm2jV9wb5OhS5UsuGVLoGoku5Gmskwh1Ug=;
  b=W0ZzDKeKdJm5Uh1Yed6pgt6NwWHuTpGQG56pR/NIvFRodihByAe0xiqL
   3g3Ad3IonXvjm7NkUqIORxIVd8/h4JEV7ateElvBFWJYmeegLx07Kulxi
   4Rsr4iEPxBH2b4yyqDNqYDoRx77ImYy9pKCmt3yKRB21XTbybAJZeHOND
   /y5JUbgxCc2YVzyLw9vMjWysbTUd5eqCsuBokTEI2/F02rpTGnETqxZk8
   Kev91tALEcCqBzzL3+kz92JZTgEpc8VifuTmTA5lwcjngx7ztg57T6ft9
   RavX46+U6Pa/t3L/l3NhtfePU7xoss6ClyRqRCRD3qLhaldYtJXAcZFaZ
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10257"; a="336404706"
X-IronPort-AV: E=Sophos;i="5.88,366,1635231600"; 
   d="scan'208";a="336404706"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2022 14:43:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,366,1635231600"; 
   d="scan'208";a="485024147"
Received: from lkp-server01.sh.intel.com (HELO d95dc2dabeb1) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 13 Feb 2022 14:43:11 -0800
Received: from kbuild by d95dc2dabeb1 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nJNaJ-0007wH-1M; Sun, 13 Feb 2022 22:43:11 +0000
Date:   Mon, 14 Feb 2022 06:42:59 +0800
From:   kernel test robot <lkp@intel.com>
To:     Tom Zanussi <zanussi@kernel.org>
Cc:     kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org,
        "Steven Rostedt (Google)" <rostedt@goodmis.org>
Subject: [ammarfaizi2-block:rostedt/linux-trace/ftrace/core 12/13]
 include/linux/fortify-string.h:47:30: error: '__builtin_strncat' output
 truncated before terminating nul copying as many bytes from a string as its
 length
Message-ID: <202202140628.fj6e4w4v-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ammarfaizi2/linux-block rostedt/linux-trace/ftrace/core
head:   f125ef075cd648a7794aa0cc61a188b1c40c8f94
commit: a76d8704e28d6591e72ab79fd2807254bd79327e [12/13] tracing: Remove size restriction on hist trigger cmd error logging
config: i386-allyesconfig (https://download.01.org/0day-ci/archive/20220214/202202140628.fj6e4w4v-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build):
        # https://github.com/ammarfaizi2/linux-block/commit/a76d8704e28d6591e72ab79fd2807254bd79327e
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block rostedt/linux-trace/ftrace/core
        git checkout a76d8704e28d6591e72ab79fd2807254bd79327e
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from include/linux/string.h:253,
                    from arch/x86/include/asm/page_32.h:22,
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
       inlined from 'last_cmd_set' at kernel/trace/trace_events_hist.c:759:2:
>> include/linux/fortify-string.h:47:30: error: '__builtin_strncat' output truncated before terminating nul copying as many bytes from a string as its length [-Werror=stringop-truncation]
      47 | #define __underlying_strncat __builtin_strncat
         |                              ^
   include/linux/fortify-string.h:191:10: note: in expansion of macro '__underlying_strncat'
     191 |   return __underlying_strncat(p, q, count);
         |          ^~~~~~~~~~~~~~~~~~~~
   kernel/trace/trace_events_hist.c: In function 'last_cmd_set':
   include/linux/fortify-string.h:46:29: note: length computed here
      46 | #define __underlying_strlen __builtin_strlen
         |                             ^
   include/linux/fortify-string.h:102:10: note: in expansion of macro '__underlying_strlen'
     102 |   return __underlying_strlen(p);
         |          ^~~~~~~~~~~~~~~~~~~
   cc1: all warnings being treated as errors


vim +/__builtin_strncat +47 include/linux/fortify-string.h

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
a28a6e860c6cf2 Francis Laniel 2021-02-25 @47  #define __underlying_strncat	__builtin_strncat
a28a6e860c6cf2 Francis Laniel 2021-02-25  48  #define __underlying_strncpy	__builtin_strncpy
a28a6e860c6cf2 Francis Laniel 2021-02-25  49  #endif
a28a6e860c6cf2 Francis Laniel 2021-02-25  50  

:::::: The code at line 47 was first introduced by commit
:::::: a28a6e860c6cf231cf3c5171c75c342adcd00406 string.h: move fortified functions definitions in a dedicated header.

:::::: TO: Francis Laniel <laniel_francis@privacyrequired.com>
:::::: CC: Linus Torvalds <torvalds@linux-foundation.org>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
