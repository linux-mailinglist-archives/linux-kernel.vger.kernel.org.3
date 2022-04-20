Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 979DC5080C5
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 07:57:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350049AbiDTGAB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 02:00:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232098AbiDTF7y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 01:59:54 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66B0637010
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 22:57:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650434228; x=1681970228;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=dlOqVIZR/L6MtBohPXpS6Rrn6hDW2/Wi7App5uHPJEI=;
  b=Oxb3odVxTSMJjbShVumltVmSMruoozJPPx4Q1elb8UIS46H2OdBtQBOD
   H1QtDNLfVWruuNKw/Pi8yyZiiM0YKi/v4fUzD6SfXhhwsY4mteLvbOxNt
   nNs8ouQPXj+RGHk5buRhWPDW3uquPKN2+BhQFsvIatdSlCOw6VKIvP1iQ
   +WnVeLf/2l6EsKjksVBozUo62FsX01Hyzz6fxYsuccYqnjqTo6FLrhdCd
   HnLrYyTG4rA/YJs/5zCss3xCCychuet+48AI7Sz5+bJfM1o78pQg4/tL2
   ZfgDctZVUL1uvSKHQ+ENH2oCmdifaJN7xVmDinLE9mBMFkVpo67Yb5cxq
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10322"; a="261548722"
X-IronPort-AV: E=Sophos;i="5.90,274,1643702400"; 
   d="scan'208";a="261548722"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2022 22:57:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,274,1643702400"; 
   d="scan'208";a="727350038"
Received: from lkp-server01.sh.intel.com (HELO 3abc53900bec) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 19 Apr 2022 22:57:06 -0700
Received: from kbuild by 3abc53900bec with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nh3Kr-0006dC-K4;
        Wed, 20 Apr 2022 05:57:05 +0000
Date:   Wed, 20 Apr 2022 13:56:31 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [mingo-tip:sched/headers 2152/2579]
 arch/s390/include/asm/smp.h:19:30: error: expected ';' after top level
 declarator
Message-ID: <202204201328.V8wP7bP6-lkp@intel.com>
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
head:   49e1ec6c70a6eb4b7de9250a455b8b63eb42afbe
commit: 87125f7f4d668eb2a4fc48a926799299c8774fdf [2152/2579] headers/deps: locking/lockdep: Split <linux/lockep.h> into <linux/lockep_types.h> and <linux/lockep_api.h>
config: s390-randconfig-r044-20220420 (https://download.01.org/0day-ci/archive/20220420/202204201328.V8wP7bP6-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project bac6cd5bf85669e3376610cfc4c4f9ca015e7b9b)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install s390 cross compiling tool for clang build
        # apt-get install binutils-s390x-linux-gnu
        # https://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git/commit/?id=87125f7f4d668eb2a4fc48a926799299c8774fdf
        git remote add mingo-tip git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git
        git fetch --no-tags mingo-tip sched/headers
        git checkout 87125f7f4d668eb2a4fc48a926799299c8774fdf
        # save the config file
        mkdir build_dir && cp config build_dir/.config
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

^1da177e4c3f415 include/asm-s390/smp.h      Linus Torvalds     2005-04-16  15  
dbd70fb499952d0 include/asm-s390/smp.h      Heiko Carstens     2008-04-17  16  extern struct mutex smp_cpu_state_mutex;
10ad34bc76dfbc4 arch/s390/include/asm/smp.h Martin Schwidefsky 2015-01-14  17  extern unsigned int smp_cpu_mt_shift;
10ad34bc76dfbc4 arch/s390/include/asm/smp.h Martin Schwidefsky 2015-01-14  18  extern unsigned int smp_cpu_mtid;
1a36a39e225d355 arch/s390/include/asm/smp.h Martin Schwidefsky 2015-10-29 @19  extern __vector128 __initdata boot_cpu_vector_save_area[__NUM_VXRS];
a052096bdd6809e arch/s390/include/asm/smp.h Sven Schnelle      2021-08-27  20  extern cpumask_t cpu_setup_mask;
8b646bd759086f6 arch/s390/include/asm/smp.h Martin Schwidefsky 2012-03-11  21  

:::::: The code at line 19 was first introduced by commit
:::::: 1a36a39e225d3558fb3776a3d3d7736cf1ec9f60 s390/dump: rework CPU register dump code

:::::: TO: Martin Schwidefsky <schwidefsky@de.ibm.com>
:::::: CC: Martin Schwidefsky <schwidefsky@de.ibm.com>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
