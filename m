Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A94B53580B
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 05:32:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238529AbiE0DbP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 23:31:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233702AbiE0DbA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 23:31:00 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D193D4134
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 20:30:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653622256; x=1685158256;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=eta9KP2YzKxZauwVlDJ+10Ju5lJmDiQJnyNSgoBSWLg=;
  b=kc7WCFjilX6B66BD0b0qc3qQA9S3XKY/z9ECH560TDzr7SI+8JnbZeae
   jhjc2RsSQJRtBvtBiyIr/DlB8is5dvuvpVFRhGySj42t3P+oKrKLhjzVz
   OBk9VADYpBIAvaZveTIa4zquTmxHknhcuznMpms8mTkXUe6BqPicAt2FJ
   O+LvGecldYLE23oOclsLvdYvRc6k5Mh6o5o4W5Zvqy9QIgN4UDOhBl3Bo
   6nfPuOUZH6cUmMBrv+2SCMy2hDatG3+Mc4JuKTZhZk6Ta/8vtdNQ6mAGc
   5rOve+Wp7lg2rRCW3Jo5g8VOa04X/O3OWxje1BKmbUOJmTrdPmahoxd3v
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10359"; a="274468683"
X-IronPort-AV: E=Sophos;i="5.91,254,1647327600"; 
   d="scan'208";a="274468683"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2022 20:30:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,254,1647327600"; 
   d="scan'208";a="643192992"
Received: from lkp-server01.sh.intel.com (HELO db63a1be7222) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 26 May 2022 20:30:53 -0700
Received: from kbuild by db63a1be7222 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nuQge-0004N0-RE;
        Fri, 27 May 2022 03:30:52 +0000
Date:   Fri, 27 May 2022 11:30:09 +0800
From:   kernel test robot <lkp@intel.com>
To:     Yu-cheng Yu <yu-cheng.yu@intel.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        Mike Rapoport <rppt@kernel.org>, linux-kernel@vger.kernel.org,
        Kees Cook <keescook@chromium.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>
Subject: [rppt:cet/kvm 12/51] arch/x86/include/asm/pgtable.h:1312:13: error:
 invalid output size for constraint '+a'
Message-ID: <202205271127.dwkWLBxL-lkp@intel.com>
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

Hi Yu-cheng,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/rppt/linux.git cet/kvm
head:   6c13d37e6c4ff3a7f86c5490b3d0f4f12d0a40da
commit: b20ff701175a81ee3517a5f2bca5bbac90529892 [12/51] x86/mm: Update ptep_set_wrprotect() and pmdp_set_wrprotect() for transition from _PAGE_DIRTY to _PAGE_COW
config: i386-randconfig-a006 (https://download.01.org/0day-ci/archive/20220527/202205271127.dwkWLBxL-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 6f4644d194da594562027a5d458d9fb7a20ebc39)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/rppt/linux.git/commit/?id=b20ff701175a81ee3517a5f2bca5bbac90529892
        git remote add rppt https://git.kernel.org/pub/scm/linux/kernel/git/rppt/linux.git
        git fetch --no-tags rppt cet/kvm
        git checkout b20ff701175a81ee3517a5f2bca5bbac90529892
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 prepare

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from arch/x86/kernel/asm-offsets.c:13:
   In file included from include/linux/suspend.h:5:
   In file included from include/linux/swap.h:9:
   In file included from include/linux/memcontrol.h:20:
   In file included from include/linux/mm.h:33:
   In file included from include/linux/pgtable.h:6:
>> arch/x86/include/asm/pgtable.h:1312:13: error: invalid output size for constraint '+a'
                   } while (!try_cmpxchg(&ptep->pte, &old_pte.pte, new_pte.pte));
                             ^
   include/linux/atomic/atomic-instrumented.h:1978:2: note: expanded from macro 'try_cmpxchg'
           arch_try_cmpxchg(__ai_ptr, __ai_oldp, __VA_ARGS__); \
           ^
   arch/x86/include/asm/cmpxchg.h:225:2: note: expanded from macro 'arch_try_cmpxchg'
           __try_cmpxchg((ptr), (pold), (new), sizeof(*(ptr)))
           ^
   arch/x86/include/asm/cmpxchg.h:222:2: note: expanded from macro '__try_cmpxchg'
           __raw_try_cmpxchg((ptr), (pold), (new), (size), LOCK_PREFIX)
           ^
   arch/x86/include/asm/cmpxchg.h:172:23: note: expanded from macro '__raw_try_cmpxchg'
                                  [old] "+a" (__old)                       \
                                              ^
   In file included from arch/x86/kernel/asm-offsets.c:13:
   In file included from include/linux/suspend.h:5:
   In file included from include/linux/swap.h:9:
   In file included from include/linux/memcontrol.h:20:
   In file included from include/linux/mm.h:33:
   In file included from include/linux/pgtable.h:6:
>> arch/x86/include/asm/pgtable.h:1312:13: error: invalid output size for constraint '+a'
   include/linux/atomic/atomic-instrumented.h:1978:2: note: expanded from macro 'try_cmpxchg'
           arch_try_cmpxchg(__ai_ptr, __ai_oldp, __VA_ARGS__); \
           ^
   arch/x86/include/asm/cmpxchg.h:225:2: note: expanded from macro 'arch_try_cmpxchg'
           __try_cmpxchg((ptr), (pold), (new), sizeof(*(ptr)))
           ^
   arch/x86/include/asm/cmpxchg.h:222:2: note: expanded from macro '__try_cmpxchg'
           __raw_try_cmpxchg((ptr), (pold), (new), (size), LOCK_PREFIX)
           ^
   arch/x86/include/asm/cmpxchg.h:184:23: note: expanded from macro '__raw_try_cmpxchg'
                                  [old] "+a" (__old)                       \
                                              ^
   In file included from arch/x86/kernel/asm-offsets.c:13:
   In file included from include/linux/suspend.h:5:
   In file included from include/linux/swap.h:9:
   In file included from include/linux/memcontrol.h:20:
   In file included from include/linux/mm.h:33:
   In file included from include/linux/pgtable.h:6:
>> arch/x86/include/asm/pgtable.h:1312:13: error: invalid output size for constraint '+a'
   include/linux/atomic/atomic-instrumented.h:1978:2: note: expanded from macro 'try_cmpxchg'
           arch_try_cmpxchg(__ai_ptr, __ai_oldp, __VA_ARGS__); \
           ^
   arch/x86/include/asm/cmpxchg.h:225:2: note: expanded from macro 'arch_try_cmpxchg'
           __try_cmpxchg((ptr), (pold), (new), sizeof(*(ptr)))
           ^
   arch/x86/include/asm/cmpxchg.h:222:2: note: expanded from macro '__try_cmpxchg'
           __raw_try_cmpxchg((ptr), (pold), (new), (size), LOCK_PREFIX)
           ^
   arch/x86/include/asm/cmpxchg.h:196:23: note: expanded from macro '__raw_try_cmpxchg'
                                  [old] "+a" (__old)                       \
                                              ^
   In file included from arch/x86/kernel/asm-offsets.c:13:
   In file included from include/linux/suspend.h:5:
   In file included from include/linux/swap.h:9:
   In file included from include/linux/memcontrol.h:20:
   In file included from include/linux/mm.h:33:
   In file included from include/linux/pgtable.h:6:
>> arch/x86/include/asm/pgtable.h:1312:13: error: invalid output size for constraint '+a'
   include/linux/atomic/atomic-instrumented.h:1978:2: note: expanded from macro 'try_cmpxchg'
           arch_try_cmpxchg(__ai_ptr, __ai_oldp, __VA_ARGS__); \
           ^
   arch/x86/include/asm/cmpxchg.h:225:2: note: expanded from macro 'arch_try_cmpxchg'
           __try_cmpxchg((ptr), (pold), (new), sizeof(*(ptr)))
           ^
   arch/x86/include/asm/cmpxchg.h:222:2: note: expanded from macro '__try_cmpxchg'
           __raw_try_cmpxchg((ptr), (pold), (new), (size), LOCK_PREFIX)
           ^
   arch/x86/include/asm/cmpxchg.h:208:23: note: expanded from macro '__raw_try_cmpxchg'
                                  [old] "+a" (__old)                       \
                                              ^
   In file included from arch/x86/kernel/asm-offsets.c:13:
   In file included from include/linux/suspend.h:5:
   In file included from include/linux/swap.h:9:
   In file included from include/linux/memcontrol.h:20:
   In file included from include/linux/mm.h:33:
   In file included from include/linux/pgtable.h:6:
   arch/x86/include/asm/pgtable.h:1383:13: error: invalid output size for constraint '+a'
                   } while (!try_cmpxchg(&pmdp->pmd, &old_pmd.pmd, new_pmd.pmd));
                             ^
   include/linux/atomic/atomic-instrumented.h:1978:2: note: expanded from macro 'try_cmpxchg'
           arch_try_cmpxchg(__ai_ptr, __ai_oldp, __VA_ARGS__); \
           ^
   arch/x86/include/asm/cmpxchg.h:225:2: note: expanded from macro 'arch_try_cmpxchg'
           __try_cmpxchg((ptr), (pold), (new), sizeof(*(ptr)))
           ^
   arch/x86/include/asm/cmpxchg.h:222:2: note: expanded from macro '__try_cmpxchg'
           __raw_try_cmpxchg((ptr), (pold), (new), (size), LOCK_PREFIX)
           ^
   arch/x86/include/asm/cmpxchg.h:172:23: note: expanded from macro '__raw_try_cmpxchg'
                                  [old] "+a" (__old)                       \
                                              ^
   In file included from arch/x86/kernel/asm-offsets.c:13:
   In file included from include/linux/suspend.h:5:
   In file included from include/linux/swap.h:9:
   In file included from include/linux/memcontrol.h:20:
   In file included from include/linux/mm.h:33:
   In file included from include/linux/pgtable.h:6:
   arch/x86/include/asm/pgtable.h:1383:13: error: invalid output size for constraint '+a'
   include/linux/atomic/atomic-instrumented.h:1978:2: note: expanded from macro 'try_cmpxchg'
           arch_try_cmpxchg(__ai_ptr, __ai_oldp, __VA_ARGS__); \
           ^
   arch/x86/include/asm/cmpxchg.h:225:2: note: expanded from macro 'arch_try_cmpxchg'
           __try_cmpxchg((ptr), (pold), (new), sizeof(*(ptr)))
           ^
   arch/x86/include/asm/cmpxchg.h:222:2: note: expanded from macro '__try_cmpxchg'
           __raw_try_cmpxchg((ptr), (pold), (new), (size), LOCK_PREFIX)
           ^
   arch/x86/include/asm/cmpxchg.h:184:23: note: expanded from macro '__raw_try_cmpxchg'
                                  [old] "+a" (__old)                       \
                                              ^
   In file included from arch/x86/kernel/asm-offsets.c:13:
   In file included from include/linux/suspend.h:5:
   In file included from include/linux/swap.h:9:
   In file included from include/linux/memcontrol.h:20:
   In file included from include/linux/mm.h:33:
   In file included from include/linux/pgtable.h:6:
   arch/x86/include/asm/pgtable.h:1383:13: error: invalid output size for constraint '+a'
   include/linux/atomic/atomic-instrumented.h:1978:2: note: expanded from macro 'try_cmpxchg'
           arch_try_cmpxchg(__ai_ptr, __ai_oldp, __VA_ARGS__); \
           ^
   arch/x86/include/asm/cmpxchg.h:225:2: note: expanded from macro 'arch_try_cmpxchg'
           __try_cmpxchg((ptr), (pold), (new), sizeof(*(ptr)))
           ^
   arch/x86/include/asm/cmpxchg.h:222:2: note: expanded from macro '__try_cmpxchg'
           __raw_try_cmpxchg((ptr), (pold), (new), (size), LOCK_PREFIX)
           ^
   arch/x86/include/asm/cmpxchg.h:196:23: note: expanded from macro '__raw_try_cmpxchg'
                                  [old] "+a" (__old)                       \
                                              ^
   In file included from arch/x86/kernel/asm-offsets.c:13:
   In file included from include/linux/suspend.h:5:
   In file included from include/linux/swap.h:9:
   In file included from include/linux/memcontrol.h:20:
   In file included from include/linux/mm.h:33:
   In file included from include/linux/pgtable.h:6:
   arch/x86/include/asm/pgtable.h:1383:13: error: invalid output size for constraint '+a'
   include/linux/atomic/atomic-instrumented.h:1978:2: note: expanded from macro 'try_cmpxchg'
           arch_try_cmpxchg(__ai_ptr, __ai_oldp, __VA_ARGS__); \
           ^
   arch/x86/include/asm/cmpxchg.h:225:2: note: expanded from macro 'arch_try_cmpxchg'
           __try_cmpxchg((ptr), (pold), (new), sizeof(*(ptr)))
           ^
   arch/x86/include/asm/cmpxchg.h:222:2: note: expanded from macro '__try_cmpxchg'
           __raw_try_cmpxchg((ptr), (pold), (new), (size), LOCK_PREFIX)
           ^
   arch/x86/include/asm/cmpxchg.h:208:23: note: expanded from macro '__raw_try_cmpxchg'
                                  [old] "+a" (__old)                       \
                                              ^
   8 errors generated.
   make[2]: *** [scripts/Makefile.build:121: arch/x86/kernel/asm-offsets.s] Error 1
   make[2]: Target '__build' not remade because of errors.
   make[1]: *** [Makefile:1191: prepare0] Error 2
   make[1]: Target 'prepare' not remade because of errors.
   make: *** [Makefile:219: __sub-make] Error 2
   make: Target 'prepare' not remade because of errors.


vim +1312 arch/x86/include/asm/pgtable.h

  1293	
  1294	#define __HAVE_ARCH_PTEP_SET_WRPROTECT
  1295	static inline void ptep_set_wrprotect(struct mm_struct *mm,
  1296					      unsigned long addr, pte_t *ptep)
  1297	{
  1298		/*
  1299		 * If Shadow Stack is enabled, pte_wrprotect() moves _PAGE_DIRTY
  1300		 * to _PAGE_COW (see comments at pte_wrprotect()).
  1301		 * When a thread reads a RW=1, Dirty=0 PTE and before changing it
  1302		 * to RW=0, Dirty=0, another thread could have written to the page
  1303		 * and the PTE is RW=1, Dirty=1 now.  Use try_cmpxchg() to detect
  1304		 * PTE changes and update old_pte, then try again.
  1305		 */
  1306		if (cpu_feature_enabled(X86_FEATURE_SHSTK)) {
  1307			pte_t old_pte, new_pte;
  1308	
  1309			old_pte = READ_ONCE(*ptep);
  1310			do {
  1311				new_pte = pte_wrprotect(old_pte);
> 1312			} while (!try_cmpxchg(&ptep->pte, &old_pte.pte, new_pte.pte));
  1313	
  1314			return;
  1315		}
  1316		clear_bit(_PAGE_BIT_RW, (unsigned long *)&ptep->pte);
  1317	}
  1318	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
