Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B166749F053
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 02:06:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344808AbiA1BGB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 20:06:01 -0500
Received: from mga12.intel.com ([192.55.52.136]:37391 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1344743AbiA1BF7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 20:05:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643331959; x=1674867959;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=XDT/nMKUBh1WdeIy4UyOfFH/m+wz3ykbjI6v0HGp+I0=;
  b=DJn/sXrKYXC4h1o7ZsCPb7jk6IDckBQyk3wvTtcEb0WfuZZCAXFfd+x/
   EFBFJc7yjVD3C1FURzjQjRhwF2khvFquRVnqdKux8fvYpqxIE4A+V6TFg
   PFvc1E/2IogqrmDemTPdQxeoJ9HBzBSa0f2LM/WwYJCsLLdCtCXL2q/pf
   kI1QGEwWcBOWFy2N68vw4NRZvDhGg+SzFYMZJPE9Q3Zxi1hhk0D+/6hYR
   l1daFREHS5fiO775BqS+DOhxEMrjGhHjf1p1OlWZyJjkf3wPUstzoRWI1
   Tg1//53vpjeow4zaaOHu73SwtsQZfeA0/EM+5U4QWVDdETZ72sKtbj1oG
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10239"; a="226988992"
X-IronPort-AV: E=Sophos;i="5.88,322,1635231600"; 
   d="scan'208";a="226988992"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2022 17:05:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,322,1635231600"; 
   d="scan'208";a="564008468"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 27 Jan 2022 17:05:45 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nDFhw-000NFK-Sb; Fri, 28 Jan 2022 01:05:44 +0000
Date:   Fri, 28 Jan 2022 09:05:18 +0800
From:   kernel test robot <lkp@intel.com>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@gnuweeb.org>,
        linux-kernel@vger.kernel.org
Subject: [ammarfaizi2-block:google/android/kernel/common/android13-5.10
 9980/9999] kernel/cfi.c:334:6: warning: no previous prototype for function
 '__cfi_slowpath'
Message-ID: <202201280858.mQTzGZcJ-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ammarfaizi2/linux-block google/android/kernel/common/android13-5.10
head:   7edc8bc69d7def26c4528360c9ec96dbeadcd0a1
commit: e48efff5cb5fd63a687465347bdbb52ef98dad44 [9980/9999] ANDROID: arch/Kconfig: fix up LTO LLVM_IAS depdency
config: arm64-buildonly-randconfig-r006-20220127 (https://download.01.org/0day-ci/archive/20220128/202201280858.mQTzGZcJ-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project f32dccb9a43b02ce4e540d6ba5dbbdb188f2dc7d)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm64 cross compiling tool for clang build
        # apt-get install binutils-aarch64-linux-gnu
        # https://github.com/ammarfaizi2/linux-block/commit/e48efff5cb5fd63a687465347bdbb52ef98dad44
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block google/android/kernel/common/android13-5.10
        git checkout e48efff5cb5fd63a687465347bdbb52ef98dad44
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm64 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> kernel/cfi.c:334:6: warning: no previous prototype for function '__cfi_slowpath' [-Wmissing-prototypes]
   void cfi_slowpath_handler(uint64_t id, void *ptr, void *diag)
        ^
   kernel/cfi.c:25:30: note: expanded from macro 'cfi_slowpath_handler'
   #define cfi_slowpath_handler    __cfi_slowpath
                                   ^
   kernel/cfi.c:334:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void cfi_slowpath_handler(uint64_t id, void *ptr, void *diag)
   ^
   static 
   kernel/cfi.c:343:6: warning: no previous prototype for function '__ubsan_handle_cfi_check_fail_abort' [-Wmissing-prototypes]
   void cfi_failure_handler(void *data, void *ptr, void *vtable)
        ^
   kernel/cfi.c:24:29: note: expanded from macro 'cfi_failure_handler'
   #define cfi_failure_handler     __ubsan_handle_cfi_check_fail_abort
                                   ^
   kernel/cfi.c:343:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void cfi_failure_handler(void *data, void *ptr, void *vtable)
   ^
   static 
>> kernel/cfi.c:349:6: warning: no previous prototype for function '__cfi_check_fail' [-Wmissing-prototypes]
   void __cfi_check_fail(void *data, void *ptr)
        ^
   kernel/cfi.c:349:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void __cfi_check_fail(void *data, void *ptr)
   ^
   static 
   3 warnings generated.


vim +/__cfi_slowpath +334 kernel/cfi.c

2c351bb70ac5e5 Sami Tolvanen 2019-04-25  333  
2c351bb70ac5e5 Sami Tolvanen 2019-04-25 @334  void cfi_slowpath_handler(uint64_t id, void *ptr, void *diag)
2c351bb70ac5e5 Sami Tolvanen 2019-04-25  335  {
2c351bb70ac5e5 Sami Tolvanen 2019-04-25  336  	handle_cfi_failure(ptr); /* No modules */
2c351bb70ac5e5 Sami Tolvanen 2019-04-25  337  }
2c351bb70ac5e5 Sami Tolvanen 2019-04-25  338  
2c351bb70ac5e5 Sami Tolvanen 2019-04-25  339  #endif /* CONFIG_MODULES */
2c351bb70ac5e5 Sami Tolvanen 2019-04-25  340  
2c351bb70ac5e5 Sami Tolvanen 2019-04-25  341  EXPORT_SYMBOL(cfi_slowpath_handler);
2c351bb70ac5e5 Sami Tolvanen 2019-04-25  342  
2c351bb70ac5e5 Sami Tolvanen 2019-04-25  343  void cfi_failure_handler(void *data, void *ptr, void *vtable)
2c351bb70ac5e5 Sami Tolvanen 2019-04-25  344  {
2c351bb70ac5e5 Sami Tolvanen 2019-04-25  345  	handle_cfi_failure(ptr);
2c351bb70ac5e5 Sami Tolvanen 2019-04-25  346  }
2c351bb70ac5e5 Sami Tolvanen 2019-04-25  347  EXPORT_SYMBOL(cfi_failure_handler);
2c351bb70ac5e5 Sami Tolvanen 2019-04-25  348  
2c351bb70ac5e5 Sami Tolvanen 2019-04-25 @349  void __cfi_check_fail(void *data, void *ptr)

:::::: The code at line 334 was first introduced by commit
:::::: 2c351bb70ac5e5212f247a495199042a95b43e38 ANDROID: add support for Clang's Control Flow Integrity (CFI)

:::::: TO: Sami Tolvanen <samitolvanen@google.com>
:::::: CC: Alistair Delva <adelva@google.com>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
