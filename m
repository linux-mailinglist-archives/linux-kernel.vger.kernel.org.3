Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD17A50989F
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 09:06:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385143AbiDUGr1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 02:47:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1385152AbiDUGqh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 02:46:37 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EECA816582
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 23:43:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650523381; x=1682059381;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=IyqTtKl8pfWrORbTfBAnzI+EZwggZHYfLzrZbrWNmAw=;
  b=jqt4/KQqqYuAg40nhwo1UR+Bk5uCJww76Fl21fA4LYbQ+KgsUuuoNC/K
   y9220BdRaKMjQUkDs3XbGbz1wzNa2+JcwGhhA9wn9PDZXvOXH3rjAhwKO
   cdjcbR3rfDCcxazUQmEaliCnQ6v4R8EwEKalTYJcvXRlFHUduk4sW1G1J
   GEfqm8eeNlnwcGkOLkSCJGNRidVoA2DgdngJEL+4yCWI+EFEzlsVl8ed9
   udGxicOcZ3bbsCikiPnAGiwncF2XmD4zIYNSQDLotyZZISgRfKrO0jTvg
   C6yoCUWmrBK+yg/pRow5i0Lq+jy4tp8totCDyorO0qGVNsFr18MbAiN0o
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10323"; a="263109252"
X-IronPort-AV: E=Sophos;i="5.90,278,1643702400"; 
   d="scan'208";a="263109252"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2022 23:42:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,278,1643702400"; 
   d="scan'208";a="865402049"
Received: from lkp-server01.sh.intel.com (HELO 3abc53900bec) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 20 Apr 2022 23:42:51 -0700
Received: from kbuild by 3abc53900bec with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nhQWg-000808-Ph;
        Thu, 21 Apr 2022 06:42:50 +0000
Date:   Thu, 21 Apr 2022 14:41:51 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [mingo-tip:sched/headers 2360/2579] include/linux/signal.h:97:11:
 error: array index 3 is past the end of the array (which contains 2
 elements)
Message-ID: <202204210229.ZtiUn30E-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git sched/headers
head:   49e1ec6c70a6eb4b7de9250a455b8b63eb42afbe
commit: e43870d97c8fb5c656b4592457df87ac2ee05f7a [2360/2579] headers/deps: mm: Optimize <linux/mm_api.h> dependencies, remove <linux/mmzone_api.h> dependency
config: i386-randconfig-a002 (https://download.01.org/0day-ci/archive/20220421/202204210229.ZtiUn30E-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project bac6cd5bf85669e3376610cfc4c4f9ca015e7b9b)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git/commit/?id=e43870d97c8fb5c656b4592457df87ac2ee05f7a
        git remote add mingo-tip git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git
        git fetch --no-tags mingo-tip sched/headers
        git checkout e43870d97c8fb5c656b4592457df87ac2ee05f7a
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash arch/x86/kvm/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from arch/x86/kvm/vmx/nested.c:9:
   In file included from include/linux/pgtable_api.h:15:
   In file included from include/linux/mmzone_api.h:33:
   In file included from arch/x86/include/asm/highmem.h:26:
   In file included from arch/x86/include/asm/tlbflush.h:5:
   In file included from include/linux/mm_api.h:393:
   include/linux/huge_mm.h:207:10: error: implicit declaration of function 'pmd_none' is invalid in C99 [-Werror,-Wimplicit-function-declaration]
           return !pmd_none(pmd) && !pmd_present(pmd);
                   ^
   include/linux/huge_mm.h:207:28: error: implicit declaration of function 'pmd_present' is invalid in C99 [-Werror,-Wimplicit-function-declaration]
           return !pmd_none(pmd) && !pmd_present(pmd);
                                     ^
   include/linux/huge_mm.h:214:27: error: implicit declaration of function 'pmd_trans_huge' is invalid in C99 [-Werror,-Wimplicit-function-declaration]
           if (is_swap_pmd(*pmd) || pmd_trans_huge(*pmd) || pmd_devmap(*pmd))
                                    ^
   include/linux/huge_mm.h:214:51: error: implicit declaration of function 'pmd_devmap' is invalid in C99 [-Werror,-Wimplicit-function-declaration]
           if (is_swap_pmd(*pmd) || pmd_trans_huge(*pmd) || pmd_devmap(*pmd))
                                                            ^
   include/linux/huge_mm.h:222:6: error: implicit declaration of function 'pud_trans_huge' is invalid in C99 [-Werror,-Wimplicit-function-declaration]
           if (pud_trans_huge(*pud) || pud_devmap(*pud))
               ^
   include/linux/huge_mm.h:222:30: error: implicit declaration of function 'pud_devmap' is invalid in C99 [-Werror,-Wimplicit-function-declaration]
           if (pud_trans_huge(*pud) || pud_devmap(*pud))
                                       ^
   include/linux/huge_mm.h:254:37: error: implicit declaration of function 'pmd_pfn' is invalid in C99 [-Werror,-Wimplicit-function-declaration]
           return READ_ONCE(huge_zero_pfn) == pmd_pfn(pmd) && pmd_present(pmd);
                                              ^
   include/linux/huge_mm.h:254:53: error: implicit declaration of function 'pmd_present' is invalid in C99 [-Werror,-Wimplicit-function-declaration]
           return READ_ONCE(huge_zero_pfn) == pmd_pfn(pmd) && pmd_present(pmd);
                                                              ^
   In file included from arch/x86/kvm/vmx/nested.c:9:
   In file included from include/linux/pgtable_api.h:19:
   arch/x86/include/asm/pgtable.h:209:29: error: static declaration of 'pmd_pfn' follows non-static declaration
   static inline unsigned long pmd_pfn(pmd_t pmd)
                               ^
   include/linux/huge_mm.h:254:37: note: previous implicit declaration is here
           return READ_ONCE(huge_zero_pfn) == pmd_pfn(pmd) && pmd_present(pmd);
                                              ^
   In file included from arch/x86/kvm/vmx/nested.c:9:
   In file included from include/linux/pgtable_api.h:19:
   arch/x86/include/asm/pgtable.h:250:19: error: static declaration of 'pmd_trans_huge' follows non-static declaration
   static inline int pmd_trans_huge(pmd_t pmd)
                     ^
   include/linux/huge_mm.h:214:27: note: previous implicit declaration is here
           if (is_swap_pmd(*pmd) || pmd_trans_huge(*pmd) || pmd_devmap(*pmd))
                                    ^
   In file included from arch/x86/kvm/vmx/nested.c:9:
   In file included from include/linux/pgtable_api.h:19:
   arch/x86/include/asm/pgtable.h:744:19: error: static declaration of 'pmd_present' follows non-static declaration
   static inline int pmd_present(pmd_t pmd)
                     ^
   include/linux/huge_mm.h:207:28: note: previous implicit declaration is here
           return !pmd_none(pmd) && !pmd_present(pmd);
                                     ^
   In file included from arch/x86/kvm/vmx/nested.c:9:
   In file included from include/linux/pgtable_api.h:19:
   arch/x86/include/asm/pgtable.h:773:19: error: static declaration of 'pmd_none' follows non-static declaration
   static inline int pmd_none(pmd_t pmd)
                     ^
   include/linux/huge_mm.h:207:10: note: previous implicit declaration is here
           return !pmd_none(pmd) && !pmd_present(pmd);
                   ^
   In file included from arch/x86/kvm/vmx/nested.c:9:
   include/linux/pgtable_api.h:1201:19: error: static declaration of 'pmd_devmap' follows non-static declaration
   static inline int pmd_devmap(pmd_t pmd)
                     ^
   include/linux/huge_mm.h:214:51: note: previous implicit declaration is here
           if (is_swap_pmd(*pmd) || pmd_trans_huge(*pmd) || pmd_devmap(*pmd))
                                                            ^
   In file included from arch/x86/kvm/vmx/nested.c:9:
   include/linux/pgtable_api.h:1205:19: error: static declaration of 'pud_devmap' follows non-static declaration
   static inline int pud_devmap(pud_t pud)
                     ^
   include/linux/huge_mm.h:222:30: note: previous implicit declaration is here
           if (pud_trans_huge(*pud) || pud_devmap(*pud))
                                       ^
   In file included from arch/x86/kvm/vmx/nested.c:9:
   include/linux/pgtable_api.h:1218:19: error: static declaration of 'pud_trans_huge' follows non-static declaration
   static inline int pud_trans_huge(pud_t pud)
                     ^
   include/linux/huge_mm.h:222:6: note: previous implicit declaration is here
           if (pud_trans_huge(*pud) || pud_devmap(*pud))
               ^
   In file included from arch/x86/kvm/vmx/nested.c:25:
   In file included from arch/x86/kvm/cpuid.h:5:
   In file included from arch/x86/kvm/x86.h:5:
   In file included from include/linux/kvm_host.h:17:
>> include/linux/signal.h:97:11: error: array index 3 is past the end of the array (which contains 2 elements) [-Werror,-Warray-bounds]
                   return (set->sig[3] | set->sig[2] |
                           ^        ~
   arch/x86/include/asm/signal.h:24:2: note: array 'sig' declared here
           unsigned long sig[_NSIG_WORDS];
           ^
   In file included from arch/x86/kvm/vmx/nested.c:25:
   In file included from arch/x86/kvm/cpuid.h:5:
   In file included from arch/x86/kvm/x86.h:5:
   In file included from include/linux/kvm_host.h:17:
   include/linux/signal.h:97:25: error: array index 2 is past the end of the array (which contains 2 elements) [-Werror,-Warray-bounds]
                   return (set->sig[3] | set->sig[2] |
                                         ^        ~
   arch/x86/include/asm/signal.h:24:2: note: array 'sig' declared here
           unsigned long sig[_NSIG_WORDS];
           ^
   In file included from arch/x86/kvm/vmx/nested.c:25:
   In file included from arch/x86/kvm/cpuid.h:5:
   In file included from arch/x86/kvm/x86.h:5:
   In file included from include/linux/kvm_host.h:17:
   include/linux/signal.h:113:11: error: array index 3 is past the end of the array (which contains 2 elements) [-Werror,-Warray-bounds]
                   return  (set1->sig[3] == set2->sig[3]) &&
                            ^         ~
   arch/x86/include/asm/signal.h:24:2: note: array 'sig' declared here
           unsigned long sig[_NSIG_WORDS];
           ^
   In file included from arch/x86/kvm/vmx/nested.c:25:
   In file included from arch/x86/kvm/cpuid.h:5:
   In file included from arch/x86/kvm/x86.h:5:
   In file included from include/linux/kvm_host.h:17:
   include/linux/signal.h:113:27: error: array index 3 is past the end of the array (which contains 2 elements) [-Werror,-Warray-bounds]
                   return  (set1->sig[3] == set2->sig[3]) &&
                                            ^         ~
   arch/x86/include/asm/signal.h:24:2: note: array 'sig' declared here
           unsigned long sig[_NSIG_WORDS];
           ^
   fatal error: too many errors emitted, stopping now [-ferror-limit=]
   20 errors generated.


vim +97 include/linux/signal.h

^1da177e4c3f41 Linus Torvalds  2005-04-16   92  
71fabd5e483530 George Anzinger 2006-01-08   93  static inline int sigisemptyset(sigset_t *set)
71fabd5e483530 George Anzinger 2006-01-08   94  {
71fabd5e483530 George Anzinger 2006-01-08   95  	switch (_NSIG_WORDS) {
71fabd5e483530 George Anzinger 2006-01-08   96  	case 4:
71fabd5e483530 George Anzinger 2006-01-08  @97  		return (set->sig[3] | set->sig[2] |
71fabd5e483530 George Anzinger 2006-01-08   98  			set->sig[1] | set->sig[0]) == 0;
71fabd5e483530 George Anzinger 2006-01-08   99  	case 2:
71fabd5e483530 George Anzinger 2006-01-08  100  		return (set->sig[1] | set->sig[0]) == 0;
71fabd5e483530 George Anzinger 2006-01-08  101  	case 1:
71fabd5e483530 George Anzinger 2006-01-08  102  		return set->sig[0] == 0;
71fabd5e483530 George Anzinger 2006-01-08  103  	default:
1c3bea0e71892e Oleg Nesterov   2014-10-13  104  		BUILD_BUG();
71fabd5e483530 George Anzinger 2006-01-08  105  		return 0;
71fabd5e483530 George Anzinger 2006-01-08  106  	}
71fabd5e483530 George Anzinger 2006-01-08  107  }
71fabd5e483530 George Anzinger 2006-01-08  108  

:::::: The code at line 97 was first introduced by commit
:::::: 71fabd5e4835309b4feca6209122ce56c595c461 [PATCH] sigaction should clear all signals on SIG_IGN, not just < 32

:::::: TO: George Anzinger <george@mvista.com>
:::::: CC: Linus Torvalds <torvalds@g5.osdl.org>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
