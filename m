Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A62C4A0358
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 23:16:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244883AbiA1WQH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 17:16:07 -0500
Received: from mga03.intel.com ([134.134.136.65]:5815 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230408AbiA1WQG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 17:16:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643408166; x=1674944166;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=ufpN1+TkYAwK1e6VaoCiYHqab3vhNbjkjXg74bn67k0=;
  b=P0mAsX4zevjwTbOkQFET+zUyh7hfdUQpPqRVbxF9X1aplUgZKpTblPdV
   Z14QbFYUugXZ6mCa46Day1uoV/X0jg56M+7hciaysigOiso1BANLjeGae
   c39MGePycLFAE5m9WSAVCHI08DFUgQDT98Mgvx3+xR58yDDwGhRF6iDXW
   TPhJzk0PhUwdYYVu0evqNr34JdJFoa7fUf0dDGPUi6rnhfBJCfDqo6r3r
   Z2QGQJxTjeER65DaLqfrQXLCuUQ7OMhK+XucYaNPjmrTFZA9JShebHYRD
   Ku7Eqcsql7VbjLzYI393wwWAltZqNHafmeYk4PlXTl0EoDdF1ZpeGAUPQ
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10241"; a="247156371"
X-IronPort-AV: E=Sophos;i="5.88,325,1635231600"; 
   d="scan'208";a="247156371"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2022 14:16:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,325,1635231600"; 
   d="scan'208";a="521871836"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 28 Jan 2022 14:16:04 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nDZXH-000OOJ-Un; Fri, 28 Jan 2022 22:16:03 +0000
Date:   Sat, 29 Jan 2022 06:15:35 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [ardb:arm64-ro-page-tables-pkvm-v5.17 11/26]
 include/linux/pgtable.h:83:29: error: redefinition of 'p4d_index'
Message-ID: <202201290655.jMtwgXZW-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/ardb/linux.git arm64-ro-page-tables-pkvm-v5.17
head:   b38f2df95cbf61e70bc32017da5318d1cb03e3e3
commit: 213a01959c0f951a020c1affdab630af1f4077ee [11/26] mm: add default definition of p4d_index()
config: x86_64-allyesconfig (https://download.01.org/0day-ci/archive/20220129/202201290655.jMtwgXZW-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/ardb/linux.git/commit/?id=213a01959c0f951a020c1affdab630af1f4077ee
        git remote add ardb git://git.kernel.org/pub/scm/linux/kernel/git/ardb/linux.git
        git fetch --no-tags ardb arm64-ro-page-tables-pkvm-v5.17
        git checkout 213a01959c0f951a020c1affdab630af1f4077ee
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=x86_64 prepare

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from include/linux/kasan.h:30,
                    from include/linux/slab.h:136,
                    from include/linux/crypto.h:20,
                    from arch/x86/kernel/asm-offsets.c:9:
>> include/linux/pgtable.h:83:29: error: redefinition of 'p4d_index'
      83 | static inline unsigned long p4d_index(unsigned long address)
         |                             ^~~~~~~~~
   In file included from include/linux/pgtable.h:6,
                    from include/linux/kasan.h:30,
                    from include/linux/slab.h:136,
                    from include/linux/crypto.h:20,
                    from arch/x86/kernel/asm-offsets.c:9:
   arch/x86/include/asm/pgtable.h:904:29: note: previous definition of 'p4d_index' was here
     904 | static inline unsigned long p4d_index(unsigned long address)
         |                             ^~~~~~~~~
   make[2]: *** [scripts/Makefile.build:121: arch/x86/kernel/asm-offsets.s] Error 1
   make[2]: Target '__build' not remade because of errors.
   make[1]: *** [Makefile:1191: prepare0] Error 2
   make[1]: Target 'prepare' not remade because of errors.
   make: *** [Makefile:219: __sub-make] Error 2
   make: Target 'prepare' not remade because of errors.


vim +/p4d_index +83 include/linux/pgtable.h

    81	
    82	#ifndef p4d_index
  > 83	static inline unsigned long p4d_index(unsigned long address)
    84	{
    85		return (address >> P4D_SHIFT) & (PTRS_PER_P4D - 1);
    86	}
    87	#define p4d_index p4d_index
    88	#endif
    89	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
