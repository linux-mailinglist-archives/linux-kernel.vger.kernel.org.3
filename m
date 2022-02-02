Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFC004A7237
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 14:52:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235969AbiBBNwC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 08:52:02 -0500
Received: from mga09.intel.com ([134.134.136.24]:27429 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1344541AbiBBNwA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 08:52:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643809920; x=1675345920;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=K3DNqJv0+Yh88D8/dlbQEwER3t48zPciIGeCaPwX9uA=;
  b=cB3SY7rWYEfI3rRif/EDlru8Uxrqa9Y5hpf+OivfkvjuUA9EyV9gCUIQ
   zt2740HeSnQ1Ke/ZQvcqn+y3Ekq5XuKWv1gXanNx+5w+My1xqnwKScFd0
   Nr389G35GxUubKor4KxyZEDYJVEAxMdSDAkgAMUiN55SYHzhdcBietakB
   oK7wpiDvH/aUsg0rkwOsAhmEuCom65PQqAK0srJCY3xeWIiwpCm9Q35M0
   3G3XRdGSWcdY4Uij+TuQS+HlCr+dbju/69RNtyRIVcgzY0pLnl4qe1GZE
   QDTfqMC52YVTGdT5E2swAASmfffGTGl8l4gltt5FPvrpoSpNB+UjP8ycu
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10245"; a="247686416"
X-IronPort-AV: E=Sophos;i="5.88,336,1635231600"; 
   d="scan'208";a="247686416"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2022 05:51:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,336,1635231600"; 
   d="scan'208";a="534855601"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 02 Feb 2022 05:50:59 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nFG2E-000Uek-Jm; Wed, 02 Feb 2022 13:50:58 +0000
Date:   Wed, 2 Feb 2022 21:50:20 +0800
From:   kernel test robot <lkp@intel.com>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        Linux Memory Management List <linux-mm@kvack.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>,
        "kasan-dev@googlegroups.com" <kasan-dev@googlegroups.com>
Subject: Re: [PATCH 1/4] mm/kasan: Add CONFIG_KASAN_SOFTWARE
Message-ID: <202202022149.BRH60mXN-lkp@intel.com>
References: <a480ac6f31eece520564afd0230c277c78169aa5.1643791473.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a480ac6f31eece520564afd0230c277c78169aa5.1643791473.git.christophe.leroy@csgroup.eu>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christophe,

I love your patch! Yet something to improve:

[auto build test ERROR on tip/sched/core]
[also build test ERROR on linus/master v5.17-rc2]
[cannot apply to hnaz-mm/master next-20220202]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Christophe-Leroy/mm-kasan-Add-CONFIG_KASAN_SOFTWARE/20220202-164612
base:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git ec2444530612a886b406e2830d7f314d1a07d4bb
config: x86_64-randconfig-a013-20220131 (https://download.01.org/0day-ci/archive/20220202/202202022149.BRH60mXN-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project 6b1e844b69f15bb7dffaf9365cd2b355d2eb7579)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/29c1001f88c380ea391fa5520f2ddcce35e35681
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Christophe-Leroy/mm-kasan-Add-CONFIG_KASAN_SOFTWARE/20220202-164612
        git checkout 29c1001f88c380ea391fa5520f2ddcce35e35681
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from arch/x86/boot/compressed/cmdline.c:2:
   In file included from arch/x86/boot/compressed/misc.h:32:
   In file included from include/linux/acpi.h:14:
   In file included from include/linux/resource_ext.h:11:
   In file included from include/linux/slab.h:136:
>> include/linux/kasan.h:56:41: error: use of undeclared identifier 'KASAN_SHADOW_SCALE_SHIFT'
           return (void *)((unsigned long)addr >> KASAN_SHADOW_SCALE_SHIFT)
                                                  ^
>> include/linux/kasan.h:57:5: error: use of undeclared identifier 'KASAN_SHADOW_OFFSET'
                   + KASAN_SHADOW_OFFSET;
                     ^
   2 errors generated.
--
   In file included from arch/x86/boot/compressed/pgtable_64.c:2:
   In file included from arch/x86/boot/compressed/misc.h:32:
   In file included from include/linux/acpi.h:14:
   In file included from include/linux/resource_ext.h:11:
   In file included from include/linux/slab.h:136:
>> include/linux/kasan.h:56:41: error: use of undeclared identifier 'KASAN_SHADOW_SCALE_SHIFT'
           return (void *)((unsigned long)addr >> KASAN_SHADOW_SCALE_SHIFT)
                                                  ^
>> include/linux/kasan.h:57:5: error: use of undeclared identifier 'KASAN_SHADOW_OFFSET'
                   + KASAN_SHADOW_OFFSET;
                     ^
   In file included from arch/x86/boot/compressed/pgtable_64.c:3:
   In file included from include/linux/efi.h:19:
   In file included from include/linux/proc_fs.h:10:
   In file included from include/linux/fs.h:33:
   In file included from include/linux/percpu-rwsem.h:7:
   In file included from include/linux/rcuwait.h:6:
   In file included from include/linux/sched/signal.h:6:
   include/linux/signal.h:97:11: warning: array index 3 is past the end of the array (which contains 1 element) [-Warray-bounds]
                   return (set->sig[3] | set->sig[2] |
                           ^        ~
   arch/x86/include/asm/signal.h:24:2: note: array 'sig' declared here
           unsigned long sig[_NSIG_WORDS];
           ^
   In file included from arch/x86/boot/compressed/pgtable_64.c:3:
   In file included from include/linux/efi.h:19:
   In file included from include/linux/proc_fs.h:10:
   In file included from include/linux/fs.h:33:
   In file included from include/linux/percpu-rwsem.h:7:
   In file included from include/linux/rcuwait.h:6:
   In file included from include/linux/sched/signal.h:6:
   include/linux/signal.h:97:25: warning: array index 2 is past the end of the array (which contains 1 element) [-Warray-bounds]
                   return (set->sig[3] | set->sig[2] |
                                         ^        ~
   arch/x86/include/asm/signal.h:24:2: note: array 'sig' declared here
           unsigned long sig[_NSIG_WORDS];
           ^
   In file included from arch/x86/boot/compressed/pgtable_64.c:3:
   In file included from include/linux/efi.h:19:
   In file included from include/linux/proc_fs.h:10:
   In file included from include/linux/fs.h:33:
   In file included from include/linux/percpu-rwsem.h:7:
   In file included from include/linux/rcuwait.h:6:
   In file included from include/linux/sched/signal.h:6:
   include/linux/signal.h:98:4: warning: array index 1 is past the end of the array (which contains 1 element) [-Warray-bounds]
                           set->sig[1] | set->sig[0]) == 0;
                           ^        ~
   arch/x86/include/asm/signal.h:24:2: note: array 'sig' declared here
           unsigned long sig[_NSIG_WORDS];
           ^
   In file included from arch/x86/boot/compressed/pgtable_64.c:3:
   In file included from include/linux/efi.h:19:
   In file included from include/linux/proc_fs.h:10:
   In file included from include/linux/fs.h:33:
   In file included from include/linux/percpu-rwsem.h:7:
   In file included from include/linux/rcuwait.h:6:
   In file included from include/linux/sched/signal.h:6:
   include/linux/signal.h:100:11: warning: array index 1 is past the end of the array (which contains 1 element) [-Warray-bounds]
                   return (set->sig[1] | set->sig[0]) == 0;
                           ^        ~
   arch/x86/include/asm/signal.h:24:2: note: array 'sig' declared here
           unsigned long sig[_NSIG_WORDS];
           ^
   In file included from arch/x86/boot/compressed/pgtable_64.c:3:
   In file included from include/linux/efi.h:19:
   In file included from include/linux/proc_fs.h:10:
   In file included from include/linux/fs.h:33:
   In file included from include/linux/percpu-rwsem.h:7:
   In file included from include/linux/rcuwait.h:6:
   In file included from include/linux/sched/signal.h:6:
   include/linux/signal.h:113:11: warning: array index 3 is past the end of the array (which contains 1 element) [-Warray-bounds]
                   return  (set1->sig[3] == set2->sig[3]) &&
                            ^         ~
   arch/x86/include/asm/signal.h:24:2: note: array 'sig' declared here
           unsigned long sig[_NSIG_WORDS];
           ^
   In file included from arch/x86/boot/compressed/pgtable_64.c:3:
   In file included from include/linux/efi.h:19:
   In file included from include/linux/proc_fs.h:10:
   In file included from include/linux/fs.h:33:
   In file included from include/linux/percpu-rwsem.h:7:
   In file included from include/linux/rcuwait.h:6:
   In file included from include/linux/sched/signal.h:6:
   include/linux/signal.h:113:27: warning: array index 3 is past the end of the array (which contains 1 element) [-Warray-bounds]
                   return  (set1->sig[3] == set2->sig[3]) &&
                                            ^         ~
   arch/x86/include/asm/signal.h:24:2: note: array 'sig' declared here
           unsigned long sig[_NSIG_WORDS];
           ^
   In file included from arch/x86/boot/compressed/pgtable_64.c:3:
   In file included from include/linux/efi.h:19:
   In file included from include/linux/proc_fs.h:10:
   In file included from include/linux/fs.h:33:
   In file included from include/linux/percpu-rwsem.h:7:
   In file included from include/linux/rcuwait.h:6:
   In file included from include/linux/sched/signal.h:6:
   include/linux/signal.h:114:5: warning: array index 2 is past the end of the array (which contains 1 element) [-Warray-bounds]
                           (set1->sig[2] == set2->sig[2]) &&
                            ^         ~
   arch/x86/include/asm/signal.h:24:2: note: array 'sig' declared here
           unsigned long sig[_NSIG_WORDS];
           ^
   In file included from arch/x86/boot/compressed/pgtable_64.c:3:
   In file included from include/linux/efi.h:19:
   In file included from include/linux/proc_fs.h:10:
   In file included from include/linux/fs.h:33:
   In file included from include/linux/percpu-rwsem.h:7:
   In file included from include/linux/rcuwait.h:6:
   In file included from include/linux/sched/signal.h:6:


vim +/KASAN_SHADOW_SCALE_SHIFT +56 include/linux/kasan.h

69786cdb379bbc Andrey Ryabinin  2015-08-13  50  
9577dd74864877 Andrey Konovalov 2018-12-28  51  int kasan_populate_early_shadow(const void *shadow_start,
69786cdb379bbc Andrey Ryabinin  2015-08-13  52  				const void *shadow_end);
69786cdb379bbc Andrey Ryabinin  2015-08-13  53  
0b24becc810dc3 Andrey Ryabinin  2015-02-13  54  static inline void *kasan_mem_to_shadow(const void *addr)
0b24becc810dc3 Andrey Ryabinin  2015-02-13  55  {
0b24becc810dc3 Andrey Ryabinin  2015-02-13 @56  	return (void *)((unsigned long)addr >> KASAN_SHADOW_SCALE_SHIFT)
0b24becc810dc3 Andrey Ryabinin  2015-02-13 @57  		+ KASAN_SHADOW_OFFSET;
0b24becc810dc3 Andrey Ryabinin  2015-02-13  58  }
0b24becc810dc3 Andrey Ryabinin  2015-02-13  59  

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
