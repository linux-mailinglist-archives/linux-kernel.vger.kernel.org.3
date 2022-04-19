Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3822506349
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 06:35:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348342AbiDSEgd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 00:36:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348293AbiDSEgR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 00:36:17 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DC3F27CD9
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 21:33:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650342816; x=1681878816;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=O0McZ/ikjxVmcmblckwMmw9PFxKOUrV//NGzehRM8aE=;
  b=aOYuHWPVwp+qRzMyxFgIYs433ouV4ECL46v7KzejPFKM3gR8rORE39/O
   0K9aQko48/k008/Zcaua7cUFndBO3fEQRtYgDL2JyPbLjbObHk9ZaolM2
   7Hjf+8CXrVo2CkNrbDkNL47qP2l4m0iSb/vX26Chi6M2snN+XWer80myB
   0pGJPjiQhW74UmJhMJipEjA/bV3qKnzGm5fvdBd5k8SB4X9V7Jg7k4tRf
   n3d6kC05hJDnRY5Z820PhYKUkSYn4EdwwPgjC9ANuDOJp0JHPcwNiY7ma
   WUkRX2R0ZhaWGrcHRS7Nl49a/jC9YLNTJfbrvnZRSjAjaL91Ty5JauKyI
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10321"; a="263847029"
X-IronPort-AV: E=Sophos;i="5.90,271,1643702400"; 
   d="scan'208";a="263847029"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2022 21:33:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,271,1643702400"; 
   d="scan'208";a="554549289"
Received: from lkp-server01.sh.intel.com (HELO 3abc53900bec) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 18 Apr 2022 21:33:24 -0700
Received: from kbuild by 3abc53900bec with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1ngfYK-0005Ln-2U;
        Tue, 19 Apr 2022 04:33:24 +0000
Date:   Tue, 19 Apr 2022 12:32:58 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [mingo-tip:sched/headers 2012/2356]
 arch/s390/include/asm/smp.h:19:30: error: expected ';' after top level
 declarator
Message-ID: <202204191258.clDxeh51-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git sched/headers
head:   af93551cf39027d176f30b9beafc60a4c130998a
commit: 73e8295a34e49141903dc467f10daf2d31e2a411 [2012/2356] headers/deps: locking/lockdep: Split <linux/lockep.h> into <linux/lockep_types.h> and <linux/lockep_api.h>
config: s390-buildonly-randconfig-r005-20220418 (https://download.01.org/0day-ci/archive/20220419/202204191258.clDxeh51-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project c1c49a356162b22554088d269f7689bdb044a9f1)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install s390 cross compiling tool for clang build
        # apt-get install binutils-s390x-linux-gnu
        # https://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git/commit/?id=73e8295a34e49141903dc467f10daf2d31e2a411
        git remote add mingo-tip git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git
        git fetch --no-tags mingo-tip sched/headers
        git checkout 73e8295a34e49141903dc467f10daf2d31e2a411
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
>> arch/s390/include/asm/smp.h:19:30: error: expected ';' after top level declarator
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
   make[2]: *** [scripts/Makefile.build:120: arch/s390/kernel/asm-offsets.s] Error 1
   make[2]: Target '__build' not remade because of errors.
   make[1]: *** [Makefile:1194: prepare0] Error 2
   make[1]: Target 'prepare' not remade because of errors.
   make: *** [Makefile:219: __sub-make] Error 2
   make: Target 'prepare' not remade because of errors.


vim +19 arch/s390/include/asm/smp.h

^1da177e4c3f41 include/asm-s390/smp.h      Linus Torvalds     2005-04-16  15  
dbd70fb499952d include/asm-s390/smp.h      Heiko Carstens     2008-04-17  16  extern struct mutex smp_cpu_state_mutex;
10ad34bc76dfbc arch/s390/include/asm/smp.h Martin Schwidefsky 2015-01-14  17  extern unsigned int smp_cpu_mt_shift;
10ad34bc76dfbc arch/s390/include/asm/smp.h Martin Schwidefsky 2015-01-14  18  extern unsigned int smp_cpu_mtid;
1a36a39e225d35 arch/s390/include/asm/smp.h Martin Schwidefsky 2015-10-29 @19  extern __vector128 __initdata boot_cpu_vector_save_area[__NUM_VXRS];
a052096bdd6809 arch/s390/include/asm/smp.h Sven Schnelle      2021-08-27  20  extern cpumask_t cpu_setup_mask;
8b646bd759086f arch/s390/include/asm/smp.h Martin Schwidefsky 2012-03-11  21  

:::::: The code at line 19 was first introduced by commit
:::::: 1a36a39e225d3558fb3776a3d3d7736cf1ec9f60 s390/dump: rework CPU register dump code

:::::: TO: Martin Schwidefsky <schwidefsky@de.ibm.com>
:::::: CC: Martin Schwidefsky <schwidefsky@de.ibm.com>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
