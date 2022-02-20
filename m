Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 979D14BD1CE
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Feb 2022 22:14:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244818AbiBTVNR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Feb 2022 16:13:17 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:44074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232995AbiBTVNP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Feb 2022 16:13:15 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49648E49
        for <linux-kernel@vger.kernel.org>; Sun, 20 Feb 2022 13:12:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645391574; x=1676927574;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Vk2tDjbOnHikAUnKAmvAj0uwOJ8uIVfZQ3YJKq9bWV0=;
  b=nwxP6oi/8VtKGeJ4aFsotPVJ374tkNFp9FKEcWygk3kINiPH7wgYpu+D
   +hI8oA/3nolW4DVBs9QsSb9Umh68Px01VCDam+wa6ecDGV0DTxmualwM9
   oW0W3qD12EMpFeF8xmmEiA4tdSJ8Nt4O0sF2mjr+4VCNC4xcfeIuviWYU
   4g5/2jVwOoq4/JWIa1IadlTLxWHWqNeJvy9EUyn8q0vC1d+zQk06k3ppn
   HdPGpcbbU5iqQ+O/Aa1eCKyT0XW47cDY+TRjDaMJuIRCgoTXuQZJmCykl
   5jITdNP71RsqiXF6GlMEBN+mv7S6ADr1cGaVqIyt2yJApHeNCbApys+Nv
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10264"; a="251154690"
X-IronPort-AV: E=Sophos;i="5.88,384,1635231600"; 
   d="scan'208";a="251154690"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2022 13:12:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,384,1635231600"; 
   d="scan'208";a="778516324"
Received: from lkp-server01.sh.intel.com (HELO da3212ac2f54) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 20 Feb 2022 13:12:52 -0800
Received: from kbuild by da3212ac2f54 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nLtVj-0000m4-U7; Sun, 20 Feb 2022 21:12:51 +0000
Date:   Mon, 21 Feb 2022 05:12:12 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [mingo-tip:sched/headers 2102/2574]
 arch/s390/include/asm/smp.h:20:31: error: expected '=', ',', ';', 'asm' or
 '__attribute__' before 'boot_cpu_vector_save_area'
Message-ID: <202202210503.pOOrnRHr-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git sched/headers
head:   39e8a0edc8fae20758051dadf7846849edc18b88
commit: 6e3778bc537864e3af5cdcc1d03ef151bbd79a41 [2102/2574] headers/deps: locking/lockdep: Split <linux/lockep.h> into <linux/lockep_types.h> and <linux/lockep_api.h>
config: s390-randconfig-r044-20220220 (https://download.01.org/0day-ci/archive/20220221/202202210503.pOOrnRHr-lkp@intel.com/config)
compiler: s390-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git/commit/?id=6e3778bc537864e3af5cdcc1d03ef151bbd79a41
        git remote add mingo-tip git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git
        git fetch --no-tags mingo-tip sched/headers
        git checkout 6e3778bc537864e3af5cdcc1d03ef151bbd79a41
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
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
