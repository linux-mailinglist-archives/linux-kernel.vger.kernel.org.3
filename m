Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D9EC4DB905
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 20:48:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349912AbiCPTuE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 15:50:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237897AbiCPTuD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 15:50:03 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E6F05AEFC
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 12:48:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647460128; x=1678996128;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=w6HTcuQU7kuBsWFPMo2uk0m+iZu9BqIdqJFSj1qd4Qc=;
  b=Ehk1e02uzOr9iQcKAMnuWesi1t+BVVLRXQjA8+HYqoImL1FP4+oMIaBd
   jh1Qe0ahnOTEumwD9uqqZNQi2fYNrqJ84F0GFRXwDCqf+XbnseQ2lGmzC
   cyXSi0uqogYy17kOBCd5jo9UhVHlKvyzs4Y97dUpxXw5oI66aAdpmejB1
   YsCcVd/PLQ4wS3jAfB7TwiyyTKqKq8dlzHqykxdjVUWlODfmYycjoFfCA
   G911z3EsT8ekY5382GBdVfGrFvvtJb23cLBu8m36KASB5Y3ZYcpKbaAUp
   kN7sB/JlGZmmwvmmynmEZp6IyqN6U8e/bkS/mVfPH9B+x5aeEube5bLJq
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10288"; a="244151788"
X-IronPort-AV: E=Sophos;i="5.90,187,1643702400"; 
   d="scan'208";a="244151788"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2022 12:48:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,187,1643702400"; 
   d="scan'208";a="714748115"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 16 Mar 2022 12:48:44 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nUZdT-000CpF-VI; Wed, 16 Mar 2022 19:48:43 +0000
Date:   Thu, 17 Mar 2022 03:47:44 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [mingo-tip:master 2011/2335] arch/s390/include/asm/smp.h:20:30:
 error: expected ';' after top level declarator
Message-ID: <202203170304.AksZVl8r-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git master
head:   85293bf3fca6d85608cff1447ce3097583f15fab
commit: 4f65f03071d3f05b9768f9999f35a95978daab34 [2011/2335] headers/deps: locking/lockdep: Split <linux/lockep.h> into <linux/lockep_types.h> and <linux/lockep_api.h>
config: s390-randconfig-r002-20220313 (https://download.01.org/0day-ci/archive/20220317/202203170304.AksZVl8r-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project a6ec1e3d798f8eab43fb3a91028c6ab04e115fcb)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install s390 cross compiling tool for clang build
        # apt-get install binutils-s390x-linux-gnu
        # https://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git/commit/?id=4f65f03071d3f05b9768f9999f35a95978daab34
        git remote add mingo-tip git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git
        git fetch --no-tags mingo-tip master
        git checkout 4f65f03071d3f05b9768f9999f35a95978daab34
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=s390 prepare

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from arch/s390/kernel/asm-offsets.c:11:
   In file included from include/linux/kvm_host.h:7:
   In file included from include/linux/hashtable_api.h:16:
   In file included from include/linux/rculist.h:11:
   In file included from include/linux/rcupdate.h:23:
   In file included from include/linux/lockdep_api.h:27:
   In file included from include/linux/smp_api.h:15:
>> arch/s390/include/asm/smp.h:20:30: error: expected ';' after top level declarator
   extern __vector128 __initdata boot_cpu_vector_save_area[__NUM_VXRS];
                                ^
                                ;
   In file included from arch/s390/kernel/asm-offsets.c:11:
   In file included from include/linux/kvm_host.h:7:
   In file included from include/linux/hashtable_api.h:16:
   In file included from include/linux/rculist.h:11:
   In file included from include/linux/rcupdate.h:35:
   include/linux/sched/per_task.h:48:11: fatal error: 'generated/asm-offsets.h' file not found
   # include <generated/asm-offsets.h>
             ^~~~~~~~~~~~~~~~~~~~~~~~~
   2 errors generated.
   make[2]: *** [scripts/Makefile.build:121: arch/s390/kernel/asm-offsets.s] Error 1
   make[2]: Target '__build' not remade because of errors.
   make[1]: *** [Makefile:1191: prepare0] Error 2
   make[1]: Target 'prepare' not remade because of errors.
   make: *** [Makefile:219: __sub-make] Error 2
   make: Target 'prepare' not remade because of errors.


vim +20 arch/s390/include/asm/smp.h

^1da177e4c3f41 include/asm-s390/smp.h      Linus Torvalds     2005-04-16  16  
dbd70fb499952d include/asm-s390/smp.h      Heiko Carstens     2008-04-17  17  extern struct mutex smp_cpu_state_mutex;
10ad34bc76dfbc arch/s390/include/asm/smp.h Martin Schwidefsky 2015-01-14  18  extern unsigned int smp_cpu_mt_shift;
10ad34bc76dfbc arch/s390/include/asm/smp.h Martin Schwidefsky 2015-01-14  19  extern unsigned int smp_cpu_mtid;
1a36a39e225d35 arch/s390/include/asm/smp.h Martin Schwidefsky 2015-10-29 @20  extern __vector128 __initdata boot_cpu_vector_save_area[__NUM_VXRS];
a052096bdd6809 arch/s390/include/asm/smp.h Sven Schnelle      2021-08-27  21  extern cpumask_t cpu_setup_mask;
8b646bd759086f arch/s390/include/asm/smp.h Martin Schwidefsky 2012-03-11  22  

:::::: The code at line 20 was first introduced by commit
:::::: 1a36a39e225d3558fb3776a3d3d7736cf1ec9f60 s390/dump: rework CPU register dump code

:::::: TO: Martin Schwidefsky <schwidefsky@de.ibm.com>
:::::: CC: Martin Schwidefsky <schwidefsky@de.ibm.com>

---
0-DAY CI Kernel Test Service
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
