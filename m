Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8ECD957C226
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 04:14:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231580AbiGUCO3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 22:14:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229724AbiGUCO1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 22:14:27 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A85C371AD
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 19:14:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658369666; x=1689905666;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=5/0SlIP6DAaty4h6Qlme2Reae2Q8S5pPYMr96dz5nI8=;
  b=b1+vyVzQYOhEsNpwUkGNCea49onye/zzyAx8/JTdVMk0XmREoMuJZErn
   F/JsIFXMTdEfAEGO442faFoNZwoipDvXfLo7oPLD4E/hLoZag3vLE3P5x
   /foSvz7oUESHKumvSnpgGWXUtOnWO+4oMtsbnodc8u5eavPFQU1Xu5Xy5
   M7YFKVhOdY7DieD+JIaCKVaDyWPclsTvdbqiBXPM726l5/jVXVqxf1sx6
   Ctraz0lahrEjDhUalF+CWi83xUJMT2rz+aNMK/bfT//aGnxAdHGZD+t2Z
   PlB9pOcwkTEe1nrMdyhEqajOf6MziuxcWFZJsMh+Wknkhf2xWj9iuRP5y
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10414"; a="267329174"
X-IronPort-AV: E=Sophos;i="5.92,288,1650956400"; 
   d="scan'208";a="267329174"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2022 19:14:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,288,1650956400"; 
   d="scan'208";a="740507605"
Received: from lkp-server01.sh.intel.com (HELO 7dfbdc7c7900) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 20 Jul 2022 19:14:25 -0700
Received: from kbuild by 7dfbdc7c7900 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1oELhp-0001Jl-8U;
        Thu, 21 Jul 2022 02:14:25 +0000
Date:   Thu, 21 Jul 2022 10:14:16 +0800
From:   kernel test robot <lkp@intel.com>
To:     Max Filippov <jcmvbkbc@gmail.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [jcmvbkbc-xtensa:xtensa-5.19-rochester 13/13]
 arch/xtensa/kernel/traps.c:162:31: warning: ignoring attribute 'section
 (".data.exception")' because it conflicts with previous 'section (".data")'
Message-ID: <202207211000.DcYukPu4-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/jcmvbkbc/linux-xtensa xtensa-5.19-rochester
head:   a44f397d234e4e2fdde909a931dfd1dcd6c69a1e
commit: a44f397d234e4e2fdde909a931dfd1dcd6c69a1e [13/13] WIP: xtensa: add VECTORS_DATA
config: xtensa-audio_kc705_defconfig (https://download.01.org/0day-ci/archive/20220721/202207211000.DcYukPu4-lkp@intel.com/config)
compiler: xtensa-test_kc705_hifi-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/jcmvbkbc/linux-xtensa/commit/a44f397d234e4e2fdde909a931dfd1dcd6c69a1e
        git remote add jcmvbkbc-xtensa https://github.com/jcmvbkbc/linux-xtensa
        git fetch --no-tags jcmvbkbc-xtensa xtensa-5.19-rochester
        git checkout a44f397d234e4e2fdde909a931dfd1dcd6c69a1e
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=xtensa SHELL=/bin/bash arch/xtensa/kernel/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from include/asm-generic/percpu.h:7,
                    from ./arch/xtensa/include/generated/asm/percpu.h:1,
                    from include/linux/irqflags.h:17,
                    from include/asm-generic/cmpxchg-local.h:6,
                    from arch/xtensa/include/asm/cmpxchg.h:90,
                    from arch/xtensa/include/asm/atomic.h:19,
                    from include/linux/atomic.h:7,
                    from include/asm-generic/bitops/lock.h:5,
                    from arch/xtensa/include/asm/bitops.h:215,
                    from include/linux/bitops.h:33,
                    from include/linux/kernel.h:22,
                    from arch/xtensa/kernel/traps.c:26:
>> arch/xtensa/kernel/traps.c:162:31: warning: ignoring attribute 'section (".data.exception")' because it conflicts with previous 'section (".data")' [-Wattributes]
     162 | DEFINE_PER_CPU_SECTION(struct exc_table, exc_table, ".exception");
         |                               ^~~~~~~~~
   include/linux/percpu-defs.h:104:38: note: in definition of macro 'DEFINE_PER_CPU_SECTION'
     104 |         __PCPU_ATTRS(sec) __typeof__(type) name
         |                                      ^~~~
   arch/xtensa/include/asm/traps.h:42:35: note: previous declaration here
      42 | DECLARE_PER_CPU(struct exc_table, exc_table);
         |                                   ^~~~~~~~~
   include/linux/percpu-defs.h:101:51: note: in definition of macro 'DECLARE_PER_CPU_SECTION'
     101 |         extern __PCPU_ATTRS(sec) __typeof__(type) name
         |                                                   ^~~~
   arch/xtensa/include/asm/traps.h:42:1: note: in expansion of macro 'DECLARE_PER_CPU'
      42 | DECLARE_PER_CPU(struct exc_table, exc_table);
         | ^~~~~~~~~~~~~~~
   arch/xtensa/kernel/traps.c:452:13: warning: no previous prototype for 'trap_init' [-Wmissing-prototypes]
     452 | void __init trap_init(void)
         |             ^~~~~~~~~


vim +162 arch/xtensa/kernel/traps.c

   156	
   157	/* The exception table <exc_table> serves two functions:
   158	 * 1. it contains three dispatch tables (fast_user, fast_kernel, default-c)
   159	 * 2. it is a temporary memory buffer for the exception handlers.
   160	 */
   161	
 > 162	DEFINE_PER_CPU_SECTION(struct exc_table, exc_table, ".exception");
   163	DEFINE_PER_CPU(struct debug_table, debug_table);
   164	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
