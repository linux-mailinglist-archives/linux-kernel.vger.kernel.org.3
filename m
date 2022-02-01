Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 740A04A54B9
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 02:35:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231933AbiBABfJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 20:35:09 -0500
Received: from mga02.intel.com ([134.134.136.20]:14774 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231946AbiBABfH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 20:35:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643679307; x=1675215307;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=aOVQsa3Cf2iiuataLA74N4rYxQcp2Lqz/FkUO5X7/GQ=;
  b=lrh7cs5ENOCG/6flbcu7pVQBpZ3pu0rgTW4GhUAg1di6MzAH32JpVCUJ
   ZsebYtfT8/CqweLHGm0h8/ugEouYdu11ui4FqmcVPyOpaJ0Ys/sko7JWR
   dHNOgzioWgI0bnXjZ54WnYPHDEGKoMnWD6cYo9ZjuUuuU8UhZuJMGi/al
   vcJEYHwPkGuuaEPTVf34pPhPK/RDFVlIm/jckL2JVuqPGyFffHs1SChXD
   fKBbFTUUZCXcwM7Oj6cvltqp6Iy4mPuZvTJv0y4Q9SQ8cuhgzPJFUzvoG
   SJvbKm9QtVF+91XYnrP9QwT8EsPHDjn5p98kwBSH18JCwgcEZyk9zgTyK
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10244"; a="234993956"
X-IronPort-AV: E=Sophos;i="5.88,332,1635231600"; 
   d="scan'208";a="234993956"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2022 17:35:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,332,1635231600"; 
   d="scan'208";a="565433895"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 31 Jan 2022 17:35:05 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nEi4W-000SZL-Un; Tue, 01 Feb 2022 01:35:04 +0000
Date:   Tue, 1 Feb 2022 09:34:03 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [jgunthorpe:iommufd 23/29] include/linux/overflow.h:66:22: warning:
 comparison of distinct pointer types lacks a cast
Message-ID: <202202010939.dIipJCeV-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/jgunthorpe/linux iommufd
head:   086f3f78da96ed1f11c2ac71115bb46e940e141e
commit: b944c7f08293cd7b049be615e67622f5d0d74cfb [23/29] iommufd: Data structure to provide IOVA to PFN mapping
config: powerpc-allyesconfig (https://download.01.org/0day-ci/archive/20220201/202202010939.dIipJCeV-lkp@intel.com/config)
compiler: powerpc-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/jgunthorpe/linux/commit/b944c7f08293cd7b049be615e67622f5d0d74cfb
        git remote add jgunthorpe https://github.com/jgunthorpe/linux
        git fetch --no-tags jgunthorpe iommufd
        git checkout b944c7f08293cd7b049be615e67622f5d0d74cfb
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=powerpc SHELL=/bin/bash drivers/iommu/iommufd/ fs/nfs/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from include/linux/mm.h:30,
                    from include/linux/scatterlist.h:8,
                    from include/linux/iommu.h:10,
                    from drivers/iommu/iommufd/io_pagetable.c:27:
   drivers/iommu/iommufd/io_pagetable.c: In function 'iopt_access_pages':
>> include/linux/overflow.h:66:22: warning: comparison of distinct pointer types lacks a cast
      66 |         (void) (&__a == &__b);                  \
         |                      ^~
   drivers/iommu/iommufd/io_pagetable.c:488:13: note: in expansion of macro 'check_add_overflow'
     488 |         if (check_add_overflow(iova, length - 1, &last_iova))
         |             ^~~~~~~~~~~~~~~~~~
   In file included from arch/powerpc/include/asm/bug.h:149,
                    from include/linux/bug.h:5,
                    from arch/powerpc/include/asm/cmpxchg.h:8,
                    from arch/powerpc/include/asm/atomic.h:11,
                    from include/linux/atomic.h:7,
                    from include/linux/cpumask.h:13,
                    from include/linux/smp.h:13,
                    from include/linux/lockdep.h:14,
                    from drivers/iommu/iommufd/io_pagetable.c:26:
   drivers/iommu/iommufd/io_pagetable.c: In function 'iopt_unaccess_pages':
>> include/linux/overflow.h:66:22: warning: comparison of distinct pointer types lacks a cast
      66 |         (void) (&__a == &__b);                  \
         |                      ^~
   include/asm-generic/bug.h:121:32: note: in definition of macro 'WARN_ON'
     121 |         int __ret_warn_on = !!(condition);                              \
         |                                ^~~~~~~~~
   drivers/iommu/iommufd/io_pagetable.c:548:21: note: in expansion of macro 'check_add_overflow'
     548 |             WARN_ON(check_add_overflow(iova, length - 1, &last_iova)))
         |                     ^~~~~~~~~~~~~~~~~~


vim +66 include/linux/overflow.h

9b80e4c4ddaca3 Kees Cook        2020-08-12  53  
f0907827a8a915 Rasmus Villemoes 2018-05-08  54  /*
f0907827a8a915 Rasmus Villemoes 2018-05-08  55   * For simplicity and code hygiene, the fallback code below insists on
f0907827a8a915 Rasmus Villemoes 2018-05-08  56   * a, b and *d having the same type (similar to the min() and max()
f0907827a8a915 Rasmus Villemoes 2018-05-08  57   * macros), whereas gcc's type-generic overflow checkers accept
f0907827a8a915 Rasmus Villemoes 2018-05-08  58   * different types. Hence we don't just make check_add_overflow an
f0907827a8a915 Rasmus Villemoes 2018-05-08  59   * alias for __builtin_add_overflow, but add type checks similar to
f0907827a8a915 Rasmus Villemoes 2018-05-08  60   * below.
f0907827a8a915 Rasmus Villemoes 2018-05-08  61   */
9b80e4c4ddaca3 Kees Cook        2020-08-12  62  #define check_add_overflow(a, b, d) __must_check_overflow(({	\
f0907827a8a915 Rasmus Villemoes 2018-05-08  63  	typeof(a) __a = (a);			\
f0907827a8a915 Rasmus Villemoes 2018-05-08  64  	typeof(b) __b = (b);			\
f0907827a8a915 Rasmus Villemoes 2018-05-08  65  	typeof(d) __d = (d);			\
f0907827a8a915 Rasmus Villemoes 2018-05-08 @66  	(void) (&__a == &__b);			\
f0907827a8a915 Rasmus Villemoes 2018-05-08  67  	(void) (&__a == __d);			\
f0907827a8a915 Rasmus Villemoes 2018-05-08  68  	__builtin_add_overflow(__a, __b, __d);	\
9b80e4c4ddaca3 Kees Cook        2020-08-12  69  }))
f0907827a8a915 Rasmus Villemoes 2018-05-08  70  

:::::: The code at line 66 was first introduced by commit
:::::: f0907827a8a9152aedac2833ed1b674a7b2a44f2 compiler.h: enable builtin overflow checkers and add fallback code

:::::: TO: Rasmus Villemoes <linux@rasmusvillemoes.dk>
:::::: CC: Kees Cook <keescook@chromium.org>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
