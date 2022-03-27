Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26C874E8A10
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Mar 2022 22:30:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233146AbiC0UcF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Mar 2022 16:32:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbiC0UcD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Mar 2022 16:32:03 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C88F21089
        for <linux-kernel@vger.kernel.org>; Sun, 27 Mar 2022 13:30:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648413023; x=1679949023;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=tn8catA+TDj66hYBgvN8kRfhWvH+W8VFSVkZuf6JzGY=;
  b=Dl6XE1X5C6KiQpiPYLS4lmLNBusXN+0Ne3e/lMr0CNXQD0720S8cqz+Y
   iCdoZBzfdl36eVE+QB4eEdPrY6bKTiExjLMDtn4deIDIEieXCs6d7p1DX
   bSItJCVyUO7a7kRZliqpjRAFHvpy/SwPsWluRE4oreWWwyY336qltBzBw
   ubc1oKIrQXg3hAQ4vg8p/JSPhoZrRMO6MsyQlwwuegOEtc1G6xuT0bguv
   C0Jzo9awYGKHODhWJVYpgwcKD74Bw9moFroUFqlpMojUTaRtU1wsOApIk
   Bq2ioJ57u2MYXSimO/z6OmEs47V5nzBBGV5pJt6QHY3ty5GTBADW4FEfC
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10299"; a="239471672"
X-IronPort-AV: E=Sophos;i="5.90,215,1643702400"; 
   d="scan'208";a="239471672"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2022 13:30:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,215,1643702400"; 
   d="scan'208";a="517292384"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga002.jf.intel.com with ESMTP; 27 Mar 2022 13:30:21 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nYZWn-0001Pj-5F; Sun, 27 Mar 2022 20:30:21 +0000
Date:   Mon, 28 Mar 2022 04:29:38 +0800
From:   kernel test robot <lkp@intel.com>
To:     Helge Deller <deller@gmx.de>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [deller-parisc:for-next 7/14]
 arch/parisc/include/asm/topology.h:11:20: error: static declaration of
 'init_cpu_topology' follows non-static declaration
Message-ID: <202203280457.DJpX1Rq4-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux.git for-next
head:   01734b6427402bb7a324707d0b2bec646bdf760b
commit: 84615181b699411d95c24fb444ed93bff2e87f1d [7/14] parisc: Switch from GENERIC_CPU_DEVICES to GENERIC_ARCH_TOPOLOGY
config: parisc-randconfig-r001-20220327 (https://download.01.org/0day-ci/archive/20220328/202203280457.DJpX1Rq4-lkp@intel.com/config)
compiler: hppa-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux.git/commit/?id=84615181b699411d95c24fb444ed93bff2e87f1d
        git remote add deller-parisc https://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux.git
        git fetch --no-tags deller-parisc for-next
        git checkout 84615181b699411d95c24fb444ed93bff2e87f1d
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=parisc prepare

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from include/linux/topology.h:36,
                    from include/linux/gfp.h:9,
                    from include/linux/percpu_counter.h:16,
                    from include/linux/sched/user.h:7,
                    from include/linux/cred.h:17,
                    from include/linux/sched/signal.h:10,
                    from include/linux/ptrace.h:7,
                    from arch/parisc/kernel/asm-offsets.c:20:
>> arch/parisc/include/asm/topology.h:11:20: error: static declaration of 'init_cpu_topology' follows non-static declaration
      11 | static inline void init_cpu_topology(void) { }
         |                    ^~~~~~~~~~~~~~~~~
   In file included from include/linux/topology.h:30,
                    from include/linux/gfp.h:9,
                    from include/linux/percpu_counter.h:16,
                    from include/linux/sched/user.h:7,
                    from include/linux/cred.h:17,
                    from include/linux/sched/signal.h:10,
                    from include/linux/ptrace.h:7,
                    from arch/parisc/kernel/asm-offsets.c:20:
   include/linux/arch_topology.h:88:6: note: previous declaration of 'init_cpu_topology' with type 'void(void)'
      88 | void init_cpu_topology(void);
         |      ^~~~~~~~~~~~~~~~~
   In file included from include/linux/topology.h:36,
                    from include/linux/gfp.h:9,
                    from include/linux/percpu_counter.h:16,
                    from include/linux/sched/user.h:7,
                    from include/linux/cred.h:17,
                    from include/linux/sched/signal.h:10,
                    from include/linux/ptrace.h:7,
                    from arch/parisc/kernel/asm-offsets.c:20:
>> arch/parisc/include/asm/topology.h:12:20: error: static declaration of 'store_cpu_topology' follows non-static declaration
      12 | static inline void store_cpu_topology(unsigned int cpuid) { }
         |                    ^~~~~~~~~~~~~~~~~~
   In file included from include/linux/topology.h:30,
                    from include/linux/gfp.h:9,
                    from include/linux/percpu_counter.h:16,
                    from include/linux/sched/user.h:7,
                    from include/linux/cred.h:17,
                    from include/linux/sched/signal.h:10,
                    from include/linux/ptrace.h:7,
                    from arch/parisc/kernel/asm-offsets.c:20:
   include/linux/arch_topology.h:89:6: note: previous declaration of 'store_cpu_topology' with type 'void(unsigned int)'
      89 | void store_cpu_topology(unsigned int cpuid);
         |      ^~~~~~~~~~~~~~~~~~
   make[2]: *** [scripts/Makefile.build:121: arch/parisc/kernel/asm-offsets.s] Error 1
   make[2]: Target '__build' not remade because of errors.
   make[1]: *** [Makefile:1192: prepare0] Error 2
   make[1]: Target 'prepare' not remade because of errors.
   make: *** [Makefile:219: __sub-make] Error 2
   make: Target 'prepare' not remade because of errors.


vim +/init_cpu_topology +11 arch/parisc/include/asm/topology.h

bf7b4c1b3c92f2 Helge Deller 2017-09-21  10  
bf7b4c1b3c92f2 Helge Deller 2017-09-21 @11  static inline void init_cpu_topology(void) { }
bf7b4c1b3c92f2 Helge Deller 2017-09-21 @12  static inline void store_cpu_topology(unsigned int cpuid) { }
bf7b4c1b3c92f2 Helge Deller 2017-09-21  13  

:::::: The code at line 11 was first introduced by commit
:::::: bf7b4c1b3c92f246a535a7c792177041d0442011 parisc: Add CPU topology support

:::::: TO: Helge Deller <deller@gmx.de>
:::::: CC: Helge Deller <deller@gmx.de>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
