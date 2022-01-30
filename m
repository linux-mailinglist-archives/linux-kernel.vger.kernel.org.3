Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3496E4A3AB1
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jan 2022 23:29:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356545AbiA3W3A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jan 2022 17:29:00 -0500
Received: from mga18.intel.com ([134.134.136.126]:23253 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233723AbiA3W24 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jan 2022 17:28:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643581736; x=1675117736;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=6mnn7teCe03fQDahwdWoGE6gC/Up48SsngYBV2Y6sbQ=;
  b=YlMow4OdsHuAapamYpXmA37ennCf2o/8EVNdBY3mJIk6bZHNJosrf4Ir
   e2h6CD4uuGx0e8G+MSAbhxVQi8DEUQ1zy6goRWqkV213zeUiGE0tGx1Ku
   ipGVxBaNFlGlckVOP9sGT5uzMuBqILfbj7erFENk39wWP2t7OotYmO07S
   nY7BkIpWGk+2YWpZEZEE4hfyeip4arCMfHrdaOS4ka+b6yKPvxuMcl0gm
   6eam/sW+9ZzZZBhNUrjAHULXxYMSovG5KPECCfnsk7wfg7mfE7doKj++A
   AJFodD9Gwph7fZopUqkSI6rguiFh3Jqfl6haGirKsrCNWvQyIhHcxvfd9
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10243"; a="230950747"
X-IronPort-AV: E=Sophos;i="5.88,329,1635231600"; 
   d="scan'208";a="230950747"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2022 14:28:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,329,1635231600"; 
   d="scan'208";a="522405546"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 30 Jan 2022 14:28:54 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nEIgn-000R3O-RT; Sun, 30 Jan 2022 22:28:53 +0000
Date:   Mon, 31 Jan 2022 06:28:34 +0800
From:   kernel test robot <lkp@intel.com>
To:     Aaron Conole <aconole@redhat.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [linux-stable-rc:linux-4.4.y 6439/9999]
 include/asm-generic/bug.h:159:2: error: implicit declaration of function
 'no_printk'; did you mean 'printk'?
Message-ID: <202201310535.VmQma3Z4-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Aaron,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.4.y
head:   26e2ad2acac73730fe99e6cfd43a2019b904d983
commit: b60b53d4980f879884740e672d83155980d74445 [6439/9999] printk: help pr_debug and pr_devel to optimize out arguments
config: h8300-randconfig-r026-20220130 (https://download.01.org/0day-ci/archive/20220131/202201310535.VmQma3Z4-lkp@intel.com/config)
compiler: h8300-linux-gcc (GCC) 7.5.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git/commit/?id=b60b53d4980f879884740e672d83155980d74445
        git remote add linux-stable-rc https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
        git fetch --no-tags linux-stable-rc linux-4.4.y
        git checkout b60b53d4980f879884740e672d83155980d74445
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-7.5.0 make.cross O=build_dir ARCH=h8300 SHELL=/bin/bash lib/842/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from lib/842/842_decompress.c:23:0:
   lib/842/842_debugfs.h: In function 'sw842_debugfs_create':
   lib/842/842_debugfs.h:27:16: warning: comparison between signed and unsigned integer expressions [-Wsign-compare]
     for (i = 0; i < ARRAY_SIZE(template_count); i++) {
                   ^
   lib/842/842_decompress.c: In function 'next_bits':
   lib/842/842_decompress.c:115:28: warning: comparison between signed and unsigned integer expressions [-Wsign-compare]
     if (DIV_ROUND_UP(bits, 8) > p->ilen)
                               ^
   In file included from arch/h8300/include/asm/bug.h:7:0,
                    from include/linux/bug.h:4,
                    from include/linux/thread_info.h:11,
                    from include/asm-generic/preempt.h:4,
                    from arch/h8300/include/generated/asm/preempt.h:1,
                    from include/linux/preempt.h:59,
                    from include/linux/spinlock.h:50,
                    from include/linux/seqlock.h:35,
                    from include/linux/time.h:5,
                    from include/linux/stat.h:18,
                    from include/linux/module.h:10,
                    from lib/842/842.h:76,
                    from lib/842/842_decompress.c:22:
   lib/842/842_decompress.c: In function '__do_index':
>> include/asm-generic/bug.h:159:2: error: implicit declaration of function 'no_printk'; did you mean 'printk'? [-Werror=implicit-function-declaration]
     no_printk(format);      \
     ^
   lib/842/842_decompress.c:72:3: note: in expansion of macro 'WARN'
      WARN(1, "pr_debug param err invalid size %x\n", s))
      ^~~~
   include/linux/printk.h:114:17: note: in expansion of macro 'beN_to_cpu'
      printk(fmt, ##__VA_ARGS__); \
                    ^~~~~~~~~~~
   include/linux/printk.h:289:2: note: in expansion of macro 'no_printk'
     no_printk(KERN_DEBUG pr_fmt(fmt), ##__VA_ARGS__)
     ^~~~~~~~~
   lib/842/842_decompress.c:205:2: note: in expansion of macro 'pr_debug'
     pr_debug("index%x to %lx off %lx adjoff %lx tot %lx data %lx\n",
     ^~~~~~~~
   lib/842/842_decompress.c:71:54: warning: signed and unsigned type in conditional expression [-Wsign-compare]
      (s) == 8 ? be64_to_cpu(get_unaligned((__be64 *)d)) : \
                                                         ^
   include/linux/printk.h:114:17: note: in expansion of macro 'beN_to_cpu'
      printk(fmt, ##__VA_ARGS__); \
                    ^~~~~~~~~~~
   include/linux/printk.h:289:2: note: in expansion of macro 'no_printk'
     no_printk(KERN_DEBUG pr_fmt(fmt), ##__VA_ARGS__)
     ^~~~~~~~~
   lib/842/842_decompress.c:205:2: note: in expansion of macro 'pr_debug'
     pr_debug("index%x to %lx off %lx adjoff %lx tot %lx data %lx\n",
     ^~~~~~~~
   cc1: some warnings being treated as errors


vim +159 include/asm-generic/bug.h

b607e70ec6a982 Josh Triplett 2014-04-07  155  
b607e70ec6a982 Josh Triplett 2014-04-07  156  #ifndef WARN
b607e70ec6a982 Josh Triplett 2014-04-07  157  #define WARN(condition, format...) ({					\
b607e70ec6a982 Josh Triplett 2014-04-07  158  	int __ret_warn_on = !!(condition);				\
4e50ebde32bed6 Josh Triplett 2014-04-07 @159  	no_printk(format);						\
b607e70ec6a982 Josh Triplett 2014-04-07  160  	unlikely(__ret_warn_on);					\
b607e70ec6a982 Josh Triplett 2014-04-07  161  })
b607e70ec6a982 Josh Triplett 2014-04-07  162  #endif
b607e70ec6a982 Josh Triplett 2014-04-07  163  

:::::: The code at line 159 was first introduced by commit
:::::: 4e50ebde32bed67a9aec8c239bbd89e5d0b8727b bug: when !CONFIG_BUG, make WARN call no_printk to check format and args

:::::: TO: Josh Triplett <josh@joshtriplett.org>
:::::: CC: Linus Torvalds <torvalds@linux-foundation.org>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
