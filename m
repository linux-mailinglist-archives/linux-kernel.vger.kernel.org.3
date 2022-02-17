Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94AE24B9A06
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 08:48:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236527AbiBQHrp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 02:47:45 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:42392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234942AbiBQHrk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 02:47:40 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CEFEE540D
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 23:47:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645084045; x=1676620045;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=zVvJKRzm2Xe/8yW3Zn0lbnAlgMujOU0B6CBZqB2zgIM=;
  b=JcUSzBr0PiwFb2+enJtd6IMyBJwy5MnRBhbI+hBJEM7a01JwelAw7GEY
   owNXBypUkPH4Pr3R3Ti0XUZ1RoxBFwm3fIGeiFrHIbS+fs3OB4loCzpIo
   /yYQOS+Ea2H8BW+5d1j3rpMgOpvCPeioLdnnN2sGymos2vpF1P5vm17+C
   p9EBkZ8nh3IfhtPGa8ZJDFsCo73yzIsatpr4oSED1rGvceAX5WYAdgl9S
   6gVWXsmEhZ3481xa0+S9igCEhjKpTU3ew7n+yuPIrTHUiHSwH01jvv1eS
   eMcCxCxY8rt9npOKHsO8kGsWCspPDF8TuNR3G5yd4I3ocu7M32p1ZSN2l
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10260"; a="249652622"
X-IronPort-AV: E=Sophos;i="5.88,375,1635231600"; 
   d="scan'208";a="249652622"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2022 23:47:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,375,1635231600"; 
   d="scan'208";a="704674043"
Received: from lkp-server01.sh.intel.com (HELO d95dc2dabeb1) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 16 Feb 2022 23:47:04 -0800
Received: from kbuild by d95dc2dabeb1 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nKbVH-000BZz-Of; Thu, 17 Feb 2022 07:47:03 +0000
Date:   Thu, 17 Feb 2022 15:46:51 +0800
From:   kernel test robot <lkp@intel.com>
To:     Yu-cheng Yu <yu-cheng.yu@intel.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        Mike Rapoport <rppt@kernel.org>, linux-kernel@vger.kernel.org,
        Mike Rapoport <rppt@linux.ibm.com>,
        Kees Cook <keescook@chromium.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>
Subject: [rppt:cet/kvm 12/49] arch/x86/include/asm/pgtable.h:1312:13: error:
 invalid output size for constraint '+a'
Message-ID: <202202171546.ctApx9Nj-lkp@intel.com>
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

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/rppt/linux.git cet/kvm
head:   e2f9808bd7530f44cd5d95332036bb660b66b8db
commit: b20ff701175a81ee3517a5f2bca5bbac90529892 [12/49] x86/mm: Update ptep_set_wrprotect() and pmdp_set_wrprotect() for transition from _PAGE_DIRTY to _PAGE_COW
config: i386-randconfig-a006 (https://download.01.org/0day-ci/archive/20220217/202202171546.ctApx9Nj-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 0bad7cb56526f2572c74449fcf97c1fcda42b41d)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/rppt/linux.git/commit/?id=b20ff701175a81ee3517a5f2bca5bbac90529892
        git remote add rppt https://git.kernel.org/pub/scm/linux/kernel/git/rppt/linux.git
        git fetch --no-tags rppt cet/kvm
        git checkout b20ff701175a81ee3517a5f2bca5bbac90529892
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 prepare

If you fix the issue, kindly add following tag as appropriate
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

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
