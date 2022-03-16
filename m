Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8218A4DA706
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 01:41:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352833AbiCPAmo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 20:42:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231308AbiCPAmm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 20:42:42 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CA765DE4E
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 17:41:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647391289; x=1678927289;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=SB/rHEovR4enZWZifS1tOPqr2GdWEfSrNH95UFQglH0=;
  b=GZhEuSxUD/ejH+EHROl2L0A9zgyxhXPm6sBuSEoP6AwFLVE2OWPwjChX
   fyBk8/kARUJug04RNn6aFd2E+UEglXdWzpjCuW9puCaWauYV3FtU0knIT
   cUUgKgMqtiv1YuEUePwuPLNdquOvdL5lh/M3RPkS66p/3sZxRoQVsc8KG
   uI6wSqqbEjccHqtGSBh8iHHHbwU7ri8t5FdHMeW9d3WDsFcQpXXYaYHRb
   nD/9uIHy9NvFMYExhMpEJX8Ttagks+YSOr5j1ltyNcTDM1LjfzojUEh3I
   QDn/7mPoIAE58ZOIRET6AzPQy46pmKln5umQMWWHevru4UNev5kfhOHig
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10286"; a="281231754"
X-IronPort-AV: E=Sophos;i="5.90,185,1643702400"; 
   d="scan'208";a="281231754"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2022 17:41:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,185,1643702400"; 
   d="scan'208";a="516102370"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 15 Mar 2022 17:41:27 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nUHjD-000Bia-4T; Wed, 16 Mar 2022 00:41:27 +0000
Date:   Wed, 16 Mar 2022 08:40:58 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [mingo-tip:master 2011/2335] arch/s390/include/asm/smp.h:20:31:
 error: expected '=', ',', ';', 'asm' or '__attribute__' before
 'boot_cpu_vector_save_area'
Message-ID: <202203160826.xoNhnyk2-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
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
config: s390-randconfig-m031-20220314 (https://download.01.org/0day-ci/archive/20220316/202203160826.xoNhnyk2-lkp@intel.com/config)
compiler: s390-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git/commit/?id=4f65f03071d3f05b9768f9999f35a95978daab34
        git remote add mingo-tip git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git
        git fetch --no-tags mingo-tip master
        git checkout 4f65f03071d3f05b9768f9999f35a95978daab34
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=s390 prepare

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from include/linux/smp_api.h:15,
                    from include/linux/lockdep_api.h:27,
                    from include/linux/rcupdate.h:23,
                    from include/linux/rculist.h:11,
                    from include/linux/hashtable_api.h:16,
                    from include/linux/kvm_host.h:7,
                    from arch/s390/kernel/asm-offsets.c:11:
>> arch/s390/include/asm/smp.h:20:31: error: expected '=', ',', ';', 'asm' or '__attribute__' before 'boot_cpu_vector_save_area'
      20 | extern __vector128 __initdata boot_cpu_vector_save_area[__NUM_VXRS];
         |                               ^~~~~~~~~~~~~~~~~~~~~~~~~
   In file included from include/linux/rcupdate.h:35,
                    from include/linux/rculist.h:11,
                    from include/linux/hashtable_api.h:16,
                    from include/linux/kvm_host.h:7,
                    from arch/s390/kernel/asm-offsets.c:11:
   include/linux/sched/per_task.h:48:11: fatal error: generated/asm-offsets.h: No such file or directory
      48 | # include <generated/asm-offsets.h>
         |           ^~~~~~~~~~~~~~~~~~~~~~~~~
   compilation terminated.
   make[2]: *** [scripts/Makefile.build:121: arch/s390/kernel/asm-offsets.s] Error 1
   make[2]: Target '__build' not remade because of errors.
   make[1]: *** [Makefile:1191: prepare0] Error 2
   make[1]: Target 'prepare' not remade because of errors.
   make: *** [Makefile:219: __sub-make] Error 2
   make: Target 'prepare' not remade because of errors.


vim +20 arch/s390/include/asm/smp.h

^1da177e4c3f415 include/asm-s390/smp.h      Linus Torvalds     2005-04-16  16  
dbd70fb499952d0 include/asm-s390/smp.h      Heiko Carstens     2008-04-17  17  extern struct mutex smp_cpu_state_mutex;
10ad34bc76dfbc4 arch/s390/include/asm/smp.h Martin Schwidefsky 2015-01-14  18  extern unsigned int smp_cpu_mt_shift;
10ad34bc76dfbc4 arch/s390/include/asm/smp.h Martin Schwidefsky 2015-01-14  19  extern unsigned int smp_cpu_mtid;
1a36a39e225d355 arch/s390/include/asm/smp.h Martin Schwidefsky 2015-10-29 @20  extern __vector128 __initdata boot_cpu_vector_save_area[__NUM_VXRS];
a052096bdd6809e arch/s390/include/asm/smp.h Sven Schnelle      2021-08-27  21  extern cpumask_t cpu_setup_mask;
8b646bd759086f6 arch/s390/include/asm/smp.h Martin Schwidefsky 2012-03-11  22  

:::::: The code at line 20 was first introduced by commit
:::::: 1a36a39e225d3558fb3776a3d3d7736cf1ec9f60 s390/dump: rework CPU register dump code

:::::: TO: Martin Schwidefsky <schwidefsky@de.ibm.com>
:::::: CC: Martin Schwidefsky <schwidefsky@de.ibm.com>

---
0-DAY CI Kernel Test Service
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
