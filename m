Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 922A54EFF33
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Apr 2022 08:51:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237688AbiDBGxi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Apr 2022 02:53:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229714AbiDBGxe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Apr 2022 02:53:34 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39286BC20
        for <linux-kernel@vger.kernel.org>; Fri,  1 Apr 2022 23:51:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648882303; x=1680418303;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=NmYJ1DwCBJFvnSiN/fX51Ve46KtvOb6kNyGg4idza/U=;
  b=mNmDKNMy5Jw6fPN6gTfgIKuhsvpzUDUbb3jDThdEHe0K2wbHQ+TCNbh5
   aKzdVGT1t6XGU4rXzfbSuF87Pq0kdagxqftZHOmO2mBVOPsfXG+Z2jixI
   7Qk747Nf7NgwnqxnQeMfPob+zCNmPPRR6YaUoMx3QpvrwiU+eqK6BRsgO
   E3HO2Np1+oJFSmeTH6w4LvR9VcwIF4LSp4cJNAoKlVt+bKWe/VBCoNFB9
   Q7bDiV+bPj3NcA3aDEPRxf5kiludrtoxoxnPDsMhTgRcAcZRIZG51LKkl
   R8yeqayhtYp0NqRv11wq0dHpgswsV+zMznL40xt9zfOPpywh8RVxQFRQR
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10304"; a="285219100"
X-IronPort-AV: E=Sophos;i="5.90,229,1643702400"; 
   d="scan'208";a="285219100"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2022 23:51:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,229,1643702400"; 
   d="scan'208";a="521889541"
Received: from lkp-server02.sh.intel.com (HELO 3231c491b0e2) ([10.239.97.151])
  by orsmga002.jf.intel.com with ESMTP; 01 Apr 2022 23:51:41 -0700
Received: from kbuild by 3231c491b0e2 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1naXbo-0001ya-Cs;
        Sat, 02 Apr 2022 06:51:40 +0000
Date:   Sat, 2 Apr 2022 14:50:42 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org
Subject: [ammarfaizi2-block:paulmck/linux-rcu/fastexp.2022.04.01a 117/158]
 arch/powerpc/include/asm/book3s/64/pgtable-64k.h:60:1: error: no return
 statement in function returning non-void
Message-ID: <202204021454.WDwBbwVL-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul,

First bad commit (maybe != root cause):

tree:   https://github.com/ammarfaizi2/linux-block paulmck/linux-rcu/fastexp.2022.04.01a
head:   d9f3e7d671416fdf5b61f094765754269b652db0
commit: 33a6b5d291d49c64d5e5d53c9cb7032835fc3e7b [117/158] rcutorture: Allow rcutorture without RCU Tasks Trace
config: powerpc64-randconfig-c003-20220402 (https://download.01.org/0day-ci/archive/20220402/202204021454.WDwBbwVL-lkp@intel.com/config)
compiler: powerpc64-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/ammarfaizi2/linux-block/commit/33a6b5d291d49c64d5e5d53c9cb7032835fc3e7b
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block paulmck/linux-rcu/fastexp.2022.04.01a
        git checkout 33a6b5d291d49c64d5e5d53c9cb7032835fc3e7b
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=powerpc prepare

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   WARNING: unmet direct dependencies detected for TASKS_TRACE_RCU
   Depends on RCU_EXPERT
   Selected by
   - BPF_SYSCALL
   Selected by
   - RCU_REF_SCALE_TEST && DEBUG_KERNEL
   In file included from arch/powerpc/include/asm/book3s/64/pgtable.h:310,
   from arch/powerpc/include/asm/book3s/64/mmu-hash.h:20,
   from arch/powerpc/include/asm/book3s/64/mmu.h:38,
   from arch/powerpc/include/asm/mmu.h:405,
   from arch/powerpc/include/asm/lppaca.h:46,
   from arch/powerpc/include/asm/paca.h:17,
   from arch/powerpc/include/asm/current.h:13,
   from include/linux/thread_info.h:23,
   from include/asm-generic/preempt.h:5,
   from ./arch/powerpc/include/generated/asm/preempt.h:1,
   from include/linux/preempt.h:78,
   from include/linux/spinlock.h:55,
   from include/linux/ipc.h:5,
   from include/uapi/linux/sem.h:5,
   from include/linux/sem.h:5,
   from include/linux/compat.h:14,
   from arch/powerpc/kernel/asm-offsets.c:12:
   arch/powerpc/include/asm/book3s/64/pgtable-64k.h: In function 'get_hugepd_cache_index':
>> arch/powerpc/include/asm/book3s/64/pgtable-64k.h:60:1: error: no return statement in function returning non-void
   60 | }
   | ^
   cc1: some warnings being treated as errors
   Makefile arch include kernel nr_bisected scripts source usr [scripts/Makefile.build:121: arch/powerpc/kernel/asm-offsets.s] Error 1
   Target '__build' not remade because of errors.
   Makefile arch include kernel nr_bisected scripts source usr [Makefile:1190: prepare0] Error 2
   Target 'prepare' not remade because of errors.
   make: Makefile arch include kernel nr_bisected scripts source usr [Makefile:219: __sub-make] Error 2
   make: Target 'prepare' not remade because of errors.

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for TASKS_TRACE_RCU
   Depends on RCU_EXPERT
   Selected by
   - BPF_SYSCALL
   Selected by
   - RCU_REF_SCALE_TEST && DEBUG_KERNEL


vim +60 arch/powerpc/include/asm/book3s/64/pgtable-64k.h

a9252aaefe7e721 Aneesh Kumar K.V 2016-04-29  53  
fadd03c615922d8 Aneesh Kumar K.V 2018-06-14  54  /*
fadd03c615922d8 Aneesh Kumar K.V 2018-06-14  55   * This should never get called
fadd03c615922d8 Aneesh Kumar K.V 2018-06-14  56   */
fadd03c615922d8 Aneesh Kumar K.V 2018-06-14  57  static inline int get_hugepd_cache_index(int index)
fadd03c615922d8 Aneesh Kumar K.V 2018-06-14  58  {
fadd03c615922d8 Aneesh Kumar K.V 2018-06-14  59  	BUG();
fadd03c615922d8 Aneesh Kumar K.V 2018-06-14 @60  }
fadd03c615922d8 Aneesh Kumar K.V 2018-06-14  61  

:::::: The code at line 60 was first introduced by commit
:::::: fadd03c615922d8521a2e76d4ba2335891cb2790 powerpc/mm/hash/4k: Free hugetlb page table caches correctly.

:::::: TO: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
:::::: CC: Michael Ellerman <mpe@ellerman.id.au>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
