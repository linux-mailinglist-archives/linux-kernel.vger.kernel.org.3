Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70C36495888
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 04:21:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232735AbiAUDVb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 22:21:31 -0500
Received: from mga06.intel.com ([134.134.136.31]:63300 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230304AbiAUDV3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 22:21:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642735289; x=1674271289;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=92rlmVrw3lLOqR+EnQpKds7s6eF7pph1L2jPHsXm0Is=;
  b=ZyezdW4HbmdPia8U0UtEUizuWUmDay3DbfdwNrCieSeRinkyU2HH65qY
   PymJ6MKhN5/2tl/2mDpuva2jSksDVMY8XRnTRjURFNAt6ji5s4RjCjcaA
   w9cCcCQAfvrsP39TCtGkLuJEfHKIZUvJL0qeUuf4D8FpQiDrZ0B9SOTsE
   /ebrVB1WuMY+yaALBPuF6tVWkl7ETP0FSL79Hxj+F189xNC5tiziMIppP
   zmRjSm6hK6nZvvcNPGfZ0g/tSuwj66nVAZA0wLqZ+iEGCXsBzTGINliPw
   izvWTwIYqSxOow9Z+o8/+Bmzrte91DcaOfgEypzgs7vnw+iRgsxblfze6
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10233"; a="306279687"
X-IronPort-AV: E=Sophos;i="5.88,304,1635231600"; 
   d="scan'208";a="306279687"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2022 19:21:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,304,1635231600"; 
   d="scan'208";a="518902294"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 20 Jan 2022 19:21:27 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nAkUQ-000Eqh-P7; Fri, 21 Jan 2022 03:21:26 +0000
Date:   Fri, 21 Jan 2022 11:20:50 +0800
From:   kernel test robot <lkp@intel.com>
To:     Mike Rapoport <rppt@linux.ibm.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        Mike Rapoport <rppt@kernel.org>, linux-kernel@vger.kernel.org
Subject: [rppt:gfp-unmapped/v0 1/3] mm/page_alloc.c:90:9: warning:
 'PMD_ORDER' macro redefined
Message-ID: <202201211125.en8nqmwl-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/rppt/linux.git gfp-unmapped/v0
head:   53acd000a0eef1457aaa4930c0d2003d7785f799
commit: 253f456a5cb652a16a59cc4ac2e18669997d79cd [1/3] mm/page_alloc: introduce __GFP_UNMAPPED and MIGRETE_UNMAPPED
config: mips-loongson1c_defconfig (https://download.01.org/0day-ci/archive/20220121/202201211125.en8nqmwl-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project f7b7138a62648f4019c55e4671682af1f851f295)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install mips cross compiling tool for clang build
        # apt-get install binutils-mips-linux-gnu
        # https://git.kernel.org/pub/scm/linux/kernel/git/rppt/linux.git/commit/?id=253f456a5cb652a16a59cc4ac2e18669997d79cd
        git remote add rppt https://git.kernel.org/pub/scm/linux/kernel/git/rppt/linux.git
        git fetch --no-tags rppt gfp-unmapped/v0
        git checkout 253f456a5cb652a16a59cc4ac2e18669997d79cd
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=mips SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> mm/page_alloc.c:90:9: warning: 'PMD_ORDER' macro redefined [-Wmacro-redefined]
   #define PMD_ORDER      (PMD_SHIFT - PAGE_SHIFT)
           ^
   arch/mips/include/asm/pgtable-32.h:85:9: note: previous definition is here
   #define PMD_ORDER       aieeee_attempt_to_allocate_pmd
           ^
   mm/page_alloc.c:3955:15: warning: no previous prototype for function 'should_fail_alloc_page' [-Wmissing-prototypes]
   noinline bool should_fail_alloc_page(gfp_t gfp_mask, unsigned int order)
                 ^
   mm/page_alloc.c:3955:10: note: declare 'static' if the function is not intended to be used outside of this translation unit
   noinline bool should_fail_alloc_page(gfp_t gfp_mask, unsigned int order)
            ^
            static 
   2 warnings generated.
--
>> mm/page_alloc.c:90:9: warning: 'PMD_ORDER' macro redefined [-Wmacro-redefined]
   #define PMD_ORDER      (PMD_SHIFT - PAGE_SHIFT)
           ^
   arch/mips/include/asm/pgtable-32.h:85:9: note: previous definition is here
   #define PMD_ORDER       aieeee_attempt_to_allocate_pmd
           ^
   1 warning generated.


vim +/PMD_ORDER +90 mm/page_alloc.c

    85	
    86	/*
    87	 * FIXME: add a proper definition in include/linux/mm.h once DAX and arch
    88	 * people agree on the name
    89	 */
  > 90	#define PMD_ORDER      (PMD_SHIFT - PAGE_SHIFT)
    91	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
