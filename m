Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B039248CE6A
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 23:29:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234270AbiALW3s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 17:29:48 -0500
Received: from mga02.intel.com ([134.134.136.20]:18358 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234351AbiALW3V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 17:29:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642026561; x=1673562561;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=ZiCO+TGjNzNGZRo/ByDNR4ej/SbDp01wWtAHeTrtIMg=;
  b=nq+5hX6RfyFR2cIkEpIa7Pmk7Vzy+oO26psVbEYlWG54VhTF726r+fLH
   KQz+6bjJZjQ4inHHusJ7GoqB8f0Evd06HimBQmfRaBc0LYxhzwJNIkxNx
   Z8oi9FSG/B3TKpakxVJsZ6KqKp2szl1VzmDBg0qtDxb11ZCHQgRIXwKiI
   TmAObtFQUiCQ++p/LglH2qdcjQKhnkSGAmgHOh/NN8oVxyJr8dPzkXgO2
   WIC0iK/bLy1+uoxC0VtciwWcTGaKXBwzhlWgzSwW18kLYV0nxtDkHQSRZ
   iodq2VDPP903Oxiayss8qNzH0KZe97q+WxdcmNImpGcujKDsOOpp4FvmP
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10225"; a="231210011"
X-IronPort-AV: E=Sophos;i="5.88,284,1635231600"; 
   d="scan'208";a="231210011"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2022 14:29:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,284,1635231600"; 
   d="scan'208";a="691559298"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 12 Jan 2022 14:29:20 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n7m7L-0006UL-IK; Wed, 12 Jan 2022 22:29:19 +0000
Date:   Thu, 13 Jan 2022 06:28:30 +0800
From:   kernel test robot <lkp@intel.com>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [mark:treewide/gnu99 1/1] include/asm-generic/fixmap.h:21:46:
 warning: left shift of negative value
Message-ID: <202201130624.MemBkw6f-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git treewide/gnu99
head:   df0f3c59f076be0ab4a6d8de53fdeef871394594
commit: df0f3c59f076be0ab4a6d8de53fdeef871394594 [1/1] treewide: use -std=gnu99
config: um-i386_defconfig (https://download.01.org/0day-ci/archive/20220113/202201130624.MemBkw6f-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git/commit/?id=df0f3c59f076be0ab4a6d8de53fdeef871394594
        git remote add mark https://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git
        git fetch --no-tags mark treewide/gnu99
        git checkout df0f3c59f076be0ab4a6d8de53fdeef871394594
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=um SUBARCH=i386 SHELL=/bin/bash arch/um/kernel/ fs/isofs/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from arch/um/include/asm/fixmap.h:54,
                    from arch/um/include/asm/pgtable.h:11,
                    from include/linux/pgtable.h:6,
                    from include/linux/mm.h:33,
                    from include/linux/memblock.h:13,
                    from arch/um/kernel/mem.c:8:
   arch/um/kernel/mem.c: In function 'paging_init':
>> include/asm-generic/fixmap.h:21:46: warning: left shift of negative value [-Wshift-negative-value]
      21 | #define __fix_to_virt(x) (FIXADDR_TOP - ((x) << PAGE_SHIFT))
         |                                              ^~
   arch/um/kernel/mem.c:167:10: note: in expansion of macro '__fix_to_virt'
     167 |  vaddr = __fix_to_virt(__end_of_fixed_addresses - 1) & PMD_MASK;
         |          ^~~~~~~~~~~~~
   arch/um/kernel/mem.c: At top level:
   arch/um/kernel/mem.c:184:8: warning: no previous prototype for 'pgd_alloc' [-Wmissing-prototypes]
     184 | pgd_t *pgd_alloc(struct mm_struct *mm)
         |        ^~~~~~~~~
   arch/um/kernel/mem.c:197:7: warning: no previous prototype for 'uml_kmalloc' [-Wmissing-prototypes]
     197 | void *uml_kmalloc(int size, int flags)
         |       ^~~~~~~~~~~
--
   fs/isofs/util.c: In function 'iso_date':
>> fs/isofs/util.c:40:14: warning: left shift of negative value [-Wshift-negative-value]
      40 |    tz |= (-1 << 8);
         |              ^~


vim +21 include/asm-generic/fixmap.h

d57c33c5daa4ef Mark Salter 2014-01-23  20  
d57c33c5daa4ef Mark Salter 2014-01-23 @21  #define __fix_to_virt(x)	(FIXADDR_TOP - ((x) << PAGE_SHIFT))
d57c33c5daa4ef Mark Salter 2014-01-23  22  #define __virt_to_fix(x)	((FIXADDR_TOP - ((x)&PAGE_MASK)) >> PAGE_SHIFT)
d57c33c5daa4ef Mark Salter 2014-01-23  23  

:::::: The code at line 21 was first introduced by commit
:::::: d57c33c5daa4efa9e4d303bd0faf868080b532be add generic fixmap.h

:::::: TO: Mark Salter <msalter@redhat.com>
:::::: CC: Linus Torvalds <torvalds@linux-foundation.org>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
