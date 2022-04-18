Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E61C50606A
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 02:00:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236297AbiDSADA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 20:03:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235925AbiDSACz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 20:02:55 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7940EBC96
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 17:00:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650326414; x=1681862414;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=MAqT9RMA6b4dnkmNoVjddZGKEP09Mmugkj11bMGsY1M=;
  b=N4da43k38tC+WdXewxPB30lnQbDuvCT4FWahCwh0+C8lTJAIqAEVZhJh
   bc2u5m4LpBoOl79RfwIkoQDL7dn7fq9ka7GFPaSUvxaJvwCECOWR+OAbY
   cm+1k+MNHZauL8qcFWFavYO/DiZXMZ/JbXPVUX3Rk6lWB/V+hAxTczUaI
   /ttAwuwK/t0OrOIvEak6P/u/oxW/TeVaXNVVGx0nHiHZzWdlkBnSGbxAE
   o0ToN6YZbWWsdSxp01IwYj5S7BSYM9tZX8GIo/q472fMqNtSfrsWQz4bL
   unJcFwjk09U5g9a55Ejh+GRBN/ORQ5rhs+gd+DjiJtR2FRLbRqOYYGoa5
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10321"; a="263395151"
X-IronPort-AV: E=Sophos;i="5.90,271,1643702400"; 
   d="scan'208";a="263395151"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2022 17:00:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,271,1643702400"; 
   d="scan'208";a="592571222"
Received: from lkp-server01.sh.intel.com (HELO 3abc53900bec) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 18 Apr 2022 17:00:07 -0700
Received: from kbuild by 3abc53900bec with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1ngbHq-00056m-Tj;
        Tue, 19 Apr 2022 00:00:06 +0000
Date:   Tue, 19 Apr 2022 07:59:57 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [mingo-tip:sched/headers 84/2356]
 arch/mips/kernel/../../../kernel/sched/per_task_area_struct_defs.h:9:13:
 warning: no previous prototype for 'per_task_common'
Message-ID: <202204190758.aysUCWYS-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git sched/headers
head:   af93551cf39027d176f30b9beafc60a4c130998a
commit: dcac6390a2220f99834d2d14650fb82f2da9136b [84/2356] headers/deps: per_task: Add the per_task infrastructure for x86, arm64, sparc and MIPS
config: mips-allyesconfig (https://download.01.org/0day-ci/archive/20220419/202204190758.aysUCWYS-lkp@intel.com/config)
compiler: mips-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git/commit/?id=dcac6390a2220f99834d2d14650fb82f2da9136b
        git remote add mingo-tip git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git
        git fetch --no-tags mingo-tip sched/headers
        git checkout dcac6390a2220f99834d2d14650fb82f2da9136b
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=mips prepare

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from arch/mips/kernel/asm-offsets.c:29:
>> arch/mips/kernel/../../../kernel/sched/per_task_area_struct_defs.h:9:13: warning: no previous prototype for 'per_task_common' [-Wmissing-prototypes]
       9 | void __used per_task_common(void)
         |             ^~~~~~~~~~~~~~~
   arch/mips/kernel/asm-offsets.c:35:6: warning: no previous prototype for 'output_ptreg_defines' [-Wmissing-prototypes]
      35 | void output_ptreg_defines(void)
         |      ^~~~~~~~~~~~~~~~~~~~
   arch/mips/kernel/asm-offsets.c:87:6: warning: no previous prototype for 'output_task_defines' [-Wmissing-prototypes]
      87 | void output_task_defines(void)
         |      ^~~~~~~~~~~~~~~~~~~
   arch/mips/kernel/asm-offsets.c:101:6: warning: no previous prototype for 'output_thread_info_defines' [-Wmissing-prototypes]
     101 | void output_thread_info_defines(void)
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~~
   arch/mips/kernel/asm-offsets.c:117:6: warning: no previous prototype for 'output_thread_defines' [-Wmissing-prototypes]
     117 | void output_thread_defines(void)
         |      ^~~~~~~~~~~~~~~~~~~~~
   arch/mips/kernel/asm-offsets.c:141:6: warning: no previous prototype for 'output_thread_fpu_defines' [-Wmissing-prototypes]
     141 | void output_thread_fpu_defines(void)
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~
   arch/mips/kernel/asm-offsets.c:184:6: warning: no previous prototype for 'output_mm_defines' [-Wmissing-prototypes]
     184 | void output_mm_defines(void)
         |      ^~~~~~~~~~~~~~~~~
   arch/mips/kernel/asm-offsets.c:223:6: warning: no previous prototype for 'output_sc_defines' [-Wmissing-prototypes]
     223 | void output_sc_defines(void)
         |      ^~~~~~~~~~~~~~~~~
   arch/mips/kernel/asm-offsets.c:258:6: warning: no previous prototype for 'output_signal_defined' [-Wmissing-prototypes]
     258 | void output_signal_defined(void)
         |      ^~~~~~~~~~~~~~~~~~~~~
   arch/mips/kernel/asm-offsets.c:325:6: warning: no previous prototype for 'output_pbe_defines' [-Wmissing-prototypes]
     325 | void output_pbe_defines(void)
         |      ^~~~~~~~~~~~~~~~~~
   arch/mips/kernel/asm-offsets.c:337:6: warning: no previous prototype for 'output_pm_defines' [-Wmissing-prototypes]
     337 | void output_pm_defines(void)
         |      ^~~~~~~~~~~~~~~~~
   arch/mips/kernel/asm-offsets.c:351:6: warning: no previous prototype for 'output_kvm_defines' [-Wmissing-prototypes]
     351 | void output_kvm_defines(void)
         |      ^~~~~~~~~~~~~~~~~~
   arch/mips/kernel/asm-offsets.c:395:6: warning: no previous prototype for 'output_cps_defines' [-Wmissing-prototypes]
     395 | void output_cps_defines(void)
         |      ^~~~~~~~~~~~~~~~~~
--
   In file included from arch/mips/kernel/asm-offsets.c:29:
>> arch/mips/kernel/../../../kernel/sched/per_task_area_struct_defs.h:9:13: warning: no previous prototype for 'per_task_common' [-Wmissing-prototypes]
       9 | void __used per_task_common(void)
         |             ^~~~~~~~~~~~~~~
   arch/mips/kernel/asm-offsets.c:35:6: warning: no previous prototype for 'output_ptreg_defines' [-Wmissing-prototypes]
      35 | void output_ptreg_defines(void)
         |      ^~~~~~~~~~~~~~~~~~~~
   arch/mips/kernel/asm-offsets.c:87:6: warning: no previous prototype for 'output_task_defines' [-Wmissing-prototypes]
      87 | void output_task_defines(void)
         |      ^~~~~~~~~~~~~~~~~~~
   arch/mips/kernel/asm-offsets.c:101:6: warning: no previous prototype for 'output_thread_info_defines' [-Wmissing-prototypes]
     101 | void output_thread_info_defines(void)
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~~
   arch/mips/kernel/asm-offsets.c:117:6: warning: no previous prototype for 'output_thread_defines' [-Wmissing-prototypes]
     117 | void output_thread_defines(void)
         |      ^~~~~~~~~~~~~~~~~~~~~
   arch/mips/kernel/asm-offsets.c:141:6: warning: no previous prototype for 'output_thread_fpu_defines' [-Wmissing-prototypes]
     141 | void output_thread_fpu_defines(void)
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~
   arch/mips/kernel/asm-offsets.c:184:6: warning: no previous prototype for 'output_mm_defines' [-Wmissing-prototypes]
     184 | void output_mm_defines(void)
         |      ^~~~~~~~~~~~~~~~~
   arch/mips/kernel/asm-offsets.c:223:6: warning: no previous prototype for 'output_sc_defines' [-Wmissing-prototypes]
     223 | void output_sc_defines(void)
         |      ^~~~~~~~~~~~~~~~~
   arch/mips/kernel/asm-offsets.c:258:6: warning: no previous prototype for 'output_signal_defined' [-Wmissing-prototypes]
     258 | void output_signal_defined(void)
         |      ^~~~~~~~~~~~~~~~~~~~~
   arch/mips/kernel/asm-offsets.c:325:6: warning: no previous prototype for 'output_pbe_defines' [-Wmissing-prototypes]
     325 | void output_pbe_defines(void)
         |      ^~~~~~~~~~~~~~~~~~
   arch/mips/kernel/asm-offsets.c:337:6: warning: no previous prototype for 'output_pm_defines' [-Wmissing-prototypes]
     337 | void output_pm_defines(void)
         |      ^~~~~~~~~~~~~~~~~
   arch/mips/kernel/asm-offsets.c:351:6: warning: no previous prototype for 'output_kvm_defines' [-Wmissing-prototypes]
     351 | void output_kvm_defines(void)
         |      ^~~~~~~~~~~~~~~~~~
   arch/mips/kernel/asm-offsets.c:395:6: warning: no previous prototype for 'output_cps_defines' [-Wmissing-prototypes]
     395 | void output_cps_defines(void)
         |      ^~~~~~~~~~~~~~~~~~


vim +/per_task_common +9 arch/mips/kernel/../../../kernel/sched/per_task_area_struct_defs.h

     8	
   > 9	void __used per_task_common(void)
    10	{
    11	#ifdef CONFIG_THREAD_INFO_IN_TASK
    12		DEF_PER_TASK(ti);
    13	#endif
    14		DEF_PER_TASK(stack);
    15		DEF_PER_TASK(usage);
    16		DEF_PER_TASK(flags);
    17		DEF_PER_TASK(ptrace);
    18	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
