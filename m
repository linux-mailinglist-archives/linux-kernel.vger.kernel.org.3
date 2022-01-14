Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7FA148E34B
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 05:30:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239189AbiANEaq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 23:30:46 -0500
Received: from mga03.intel.com ([134.134.136.65]:59050 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239020AbiANEap (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 23:30:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642134645; x=1673670645;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Db3v2WR6zdYDj89/1HtLVLfRq6qpI5iJWhsa09yCTys=;
  b=iyrLuStUPgav9FSpkoznQ8pDQEgWkYPA+oY32/SAJZoB9MtpacWswoZr
   4jMt7rYmMPPK33wNw2e5QChnhQPECdUmN3LRbAmG40q3B1nlI9LsSJd0O
   bMndBBNiaZwRPLRF+sR8iTffIRFpQWk4n96tV9HwRWRgF9oaOLto8RM6y
   Wnv0S6/Bqxg0PakMXPan6w8cwjCQFdgkNRQNPmrmwjUSukEmv6Mnxz+g1
   9muB04sD+a9ba8x/FgpvRkq3n3Lhrr8cD8XSs13eSDZ9Ebu14JshFd7Hr
   6agKCQ3vyxeTU4mZXf9qeTmC2Vk2zcN6617uF5yO8OnmVGeoe9FqKNSjo
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10226"; a="244136366"
X-IronPort-AV: E=Sophos;i="5.88,287,1635231600"; 
   d="scan'208";a="244136366"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2022 20:30:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,287,1635231600"; 
   d="scan'208";a="559354866"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 13 Jan 2022 20:30:24 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n8EEJ-00085j-Bz; Fri, 14 Jan 2022 04:30:23 +0000
Date:   Fri, 14 Jan 2022 12:30:12 +0800
From:   kernel test robot <lkp@intel.com>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [mhiramat:kprobes/fixes 2/3] include/asm-generic/bug.h:99:17: error:
 too few arguments to function '__warn_printk'
Message-ID: <202201141214.4SkSLX9S-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/mhiramat/linux.git kprobes/fixes
head:   dfa160b26549af888185cb9d3001b577ce755dd3
commit: 9eb569267490d4537bd3ea1819f6cdfc03e986be [2/3] powerpc/kprobes: Fix alloc_optinsn_page() to use all area of optinsn_slot
config: powerpc-allyesconfig (https://download.01.org/0day-ci/archive/20220114/202201141214.4SkSLX9S-lkp@intel.com/config)
compiler: powerpc-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/mhiramat/linux.git/commit/?id=9eb569267490d4537bd3ea1819f6cdfc03e986be
        git remote add mhiramat https://git.kernel.org/pub/scm/linux/kernel/git/mhiramat/linux.git
        git fetch --no-tags mhiramat kprobes/fixes
        git checkout 9eb569267490d4537bd3ea1819f6cdfc03e986be
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=powerpc SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from arch/powerpc/include/asm/bug.h:149,
                    from include/linux/bug.h:5,
                    from arch/powerpc/include/asm/cmpxchg.h:8,
                    from arch/powerpc/include/asm/atomic.h:11,
                    from include/linux/atomic.h:7,
                    from include/linux/cpumask.h:13,
                    from include/linux/smp.h:13,
                    from include/linux/lockdep.h:14,
                    from include/linux/mutex.h:17,
                    from include/linux/notifier.h:14,
                    from include/linux/kprobes.h:21,
                    from arch/powerpc/kernel/optprobes.c:8:
   arch/powerpc/kernel/optprobes.c: In function 'free_optinsn_page':
>> include/asm-generic/bug.h:99:17: error: too few arguments to function '__warn_printk'
      99 |                 __warn_printk(arg);                                     \
         |                 ^~~~~~~~~~~~~
   include/asm-generic/bug.h:132:17: note: in expansion of macro '__WARN_printf'
     132 |                 __WARN_printf(TAINT_WARN, format);                      \
         |                 ^~~~~~~~~~~~~
   include/linux/once_lite.h:19:25: note: in expansion of macro 'WARN'
      19 |                         func(__VA_ARGS__);                              \
         |                         ^~~~
   include/asm-generic/bug.h:150:9: note: in expansion of macro 'DO_ONCE_LITE_IF'
     150 |         DO_ONCE_LITE_IF(condition, WARN, 1, format)
         |         ^~~~~~~~~~~~~~~
   arch/powerpc/kernel/optprobes.c:49:9: note: in expansion of macro 'WARN_ONCE'
      49 |         WARN_ONCE(idx & (PAGE_SIZE - 1));
         |         ^~~~~~~~~
   include/asm-generic/bug.h:95:28: note: declared here
      95 | extern __printf(1, 2) void __warn_printk(const char *fmt, ...);
         |                            ^~~~~~~~~~~~~
>> include/asm-generic/bug.h:99:17: error: too few arguments to function '__warn_printk'
      99 |                 __warn_printk(arg);                                     \
         |                 ^~~~~~~~~~~~~
   include/asm-generic/bug.h:132:17: note: in expansion of macro '__WARN_printf'
     132 |                 __WARN_printf(TAINT_WARN, format);                      \
         |                 ^~~~~~~~~~~~~
   include/linux/once_lite.h:19:25: note: in expansion of macro 'WARN'
      19 |                         func(__VA_ARGS__);                              \
         |                         ^~~~
   include/asm-generic/bug.h:150:9: note: in expansion of macro 'DO_ONCE_LITE_IF'
     150 |         DO_ONCE_LITE_IF(condition, WARN, 1, format)
         |         ^~~~~~~~~~~~~~~
   arch/powerpc/kernel/optprobes.c:51:13: note: in expansion of macro 'WARN_ONCE'
      51 |         if (WARN_ONCE(idx >= OPTINSN_SLOT_PAGES))
         |             ^~~~~~~~~
   include/asm-generic/bug.h:95:28: note: declared here
      95 | extern __printf(1, 2) void __warn_printk(const char *fmt, ...);
         |                            ^~~~~~~~~~~~~


vim +/__warn_printk +99 include/asm-generic/bug.h

^1da177e4c3f41 Linus Torvalds   2005-04-16   67  
af9379c7121d55 David Brownell   2009-01-06   68  /*
af9379c7121d55 David Brownell   2009-01-06   69   * WARN(), WARN_ON(), WARN_ON_ONCE, and so on can be used to report
96c6a32ccb55a3 Dmitry Vyukov    2018-08-21   70   * significant kernel issues that need prompt attention if they should ever
96c6a32ccb55a3 Dmitry Vyukov    2018-08-21   71   * appear at runtime.
96c6a32ccb55a3 Dmitry Vyukov    2018-08-21   72   *
96c6a32ccb55a3 Dmitry Vyukov    2018-08-21   73   * Do not use these macros when checking for invalid external inputs
96c6a32ccb55a3 Dmitry Vyukov    2018-08-21   74   * (e.g. invalid system call arguments, or invalid data coming from
96c6a32ccb55a3 Dmitry Vyukov    2018-08-21   75   * network/devices), and on transient conditions like ENOMEM or EAGAIN.
96c6a32ccb55a3 Dmitry Vyukov    2018-08-21   76   * These macros should be used for recoverable kernel issues only.
96c6a32ccb55a3 Dmitry Vyukov    2018-08-21   77   * For invalid external inputs, transient conditions, etc use
96c6a32ccb55a3 Dmitry Vyukov    2018-08-21   78   * pr_err[_once/_ratelimited]() followed by dump_stack(), if necessary.
96c6a32ccb55a3 Dmitry Vyukov    2018-08-21   79   * Do not include "BUG"/"WARNING" in format strings manually to make these
96c6a32ccb55a3 Dmitry Vyukov    2018-08-21   80   * conditions distinguishable from kernel issues.
96c6a32ccb55a3 Dmitry Vyukov    2018-08-21   81   *
96c6a32ccb55a3 Dmitry Vyukov    2018-08-21   82   * Use the versions with printk format strings to provide better diagnostics.
af9379c7121d55 David Brownell   2009-01-06   83   */
d4bce140b4e739 Kees Cook        2019-09-25   84  #ifndef __WARN_FLAGS
b9075fa968a0a4 Joe Perches      2011-10-31   85  extern __printf(4, 5)
ee8711336c5170 Kees Cook        2019-09-25   86  void warn_slowpath_fmt(const char *file, const int line, unsigned taint,
b9075fa968a0a4 Joe Perches      2011-10-31   87  		       const char *fmt, ...);
f2f84b05e02b77 Kees Cook        2019-09-25   88  #define __WARN()		__WARN_printf(TAINT_WARN, NULL)
5916d5f9b33473 Thomas Gleixner  2020-03-13   89  #define __WARN_printf(taint, arg...) do {				\
5916d5f9b33473 Thomas Gleixner  2020-03-13   90  		instrumentation_begin();				\
5916d5f9b33473 Thomas Gleixner  2020-03-13   91  		warn_slowpath_fmt(__FILE__, __LINE__, taint, arg);	\
5916d5f9b33473 Thomas Gleixner  2020-03-13   92  		instrumentation_end();					\
5916d5f9b33473 Thomas Gleixner  2020-03-13   93  	} while (0)
a8f18b909c0a3f Arjan van de Ven 2008-07-25   94  #else
a7bed27af194aa Kees Cook        2017-11-17   95  extern __printf(1, 2) void __warn_printk(const char *fmt, ...);
a44f71a9ab99b5 Kees Cook        2019-09-25   96  #define __WARN()		__WARN_FLAGS(BUGFLAG_TAINT(TAINT_WARN))
d4bce140b4e739 Kees Cook        2019-09-25   97  #define __WARN_printf(taint, arg...) do {				\
5916d5f9b33473 Thomas Gleixner  2020-03-13   98  		instrumentation_begin();				\
d4bce140b4e739 Kees Cook        2019-09-25  @99  		__warn_printk(arg);					\
a44f71a9ab99b5 Kees Cook        2019-09-25  100  		__WARN_FLAGS(BUGFLAG_NO_CUT_HERE | BUGFLAG_TAINT(taint));\
5916d5f9b33473 Thomas Gleixner  2020-03-13  101  		instrumentation_end();					\
6b15f678fb7d5e Drew Davenport   2019-07-16  102  	} while (0)
2da1ead4d5f7fa Kees Cook        2019-09-25  103  #define WARN_ON_ONCE(condition) ({				\
2da1ead4d5f7fa Kees Cook        2019-09-25  104  	int __ret_warn_on = !!(condition);			\
2da1ead4d5f7fa Kees Cook        2019-09-25  105  	if (unlikely(__ret_warn_on))				\
2da1ead4d5f7fa Kees Cook        2019-09-25  106  		__WARN_FLAGS(BUGFLAG_ONCE |			\
2da1ead4d5f7fa Kees Cook        2019-09-25  107  			     BUGFLAG_TAINT(TAINT_WARN));	\
2da1ead4d5f7fa Kees Cook        2019-09-25  108  	unlikely(__ret_warn_on);				\
2da1ead4d5f7fa Kees Cook        2019-09-25  109  })
3a6a62f96f168d Olof Johansson   2008-01-30  110  #endif
3a6a62f96f168d Olof Johansson   2008-01-30  111  

:::::: The code at line 99 was first introduced by commit
:::::: d4bce140b4e739bceb4e239d4842cf8f346c1e0f bug: clean up helper macros to remove __WARN_TAINT()

:::::: TO: Kees Cook <keescook@chromium.org>
:::::: CC: Linus Torvalds <torvalds@linux-foundation.org>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
