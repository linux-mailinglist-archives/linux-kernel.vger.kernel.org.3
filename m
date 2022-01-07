Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEEE2487E49
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 22:31:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229988AbiAGVbl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 16:31:41 -0500
Received: from mga06.intel.com ([134.134.136.31]:9752 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229978AbiAGVbk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 16:31:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641591100; x=1673127100;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=jUBahTnhIW6qW7fHowCpzT5BecM4oCkWj2IElq3movM=;
  b=LMuWlRKvloiNTpjw8GsEEepLaNsepQ8ZPAthcfXweXHCovUm/pXDuI99
   U0gWiufpYagVd3g3748lBau77R01x6Reb1D1owwMhFjQ3gwn/oedOLwRP
   mqroNwExlwaFQ5idoPmsqKCaozx9Ror9aN4hk58wsj7OTTITuAXdkLoN+
   t0mxQ4Dr8ZR2h4Dhg3rnsEMVbu8eH0tI+7ToRFG02V1Ms95njxkuUHZPb
   2ki9IPQLtVLqIci5jOHnb5+dNw0B+E+p5KbMpPAQwjWI2u+wSmPfOn+L9
   rvgNnDpDFLbYv0KS7U+vXm+wd8nJKPxuw41Rbh4LeMVlhLQMaJGI5Mn3Z
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10220"; a="303690438"
X-IronPort-AV: E=Sophos;i="5.88,271,1635231600"; 
   d="scan'208";a="303690438"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2022 13:31:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,271,1635231600"; 
   d="scan'208";a="668889959"
Received: from lkp-server01.sh.intel.com (HELO e357b3ef1427) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 07 Jan 2022 13:31:16 -0800
Received: from kbuild by e357b3ef1427 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n5wpQ-000J3p-1R; Fri, 07 Jan 2022 21:31:16 +0000
Date:   Sat, 8 Jan 2022 05:30:37 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [mingo-tip:sched/headers 81/2372]
 arch/mips/kernel/../../../kernel/sched/per_task_area_struct_defs.h:9:13:
 warning: no previous prototype for 'per_task_common'
Message-ID: <202201080502.XFPdRoCl-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git sched/headers
head:   67f8f45b4d0cf00f8e53fc1c2b50c67608ede063
commit: cbe5c34b83fe53e121e44ba15f1af1f491da4602 [81/2372] headers/deps: per_task: Add the per_task infrastructure for x86, arm64, sparc and MIPS
config: mips-randconfig-r012-20220107 (https://download.01.org/0day-ci/archive/20220108/202201080502.XFPdRoCl-lkp@intel.com/config)
compiler: mips64-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git/commit/?id=cbe5c34b83fe53e121e44ba15f1af1f491da4602
        git remote add mingo-tip git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git
        git fetch --no-tags mingo-tip sched/headers
        git checkout cbe5c34b83fe53e121e44ba15f1af1f491da4602
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
   arch/mips/kernel/asm-offsets.c:245:6: warning: no previous prototype for 'output_sc_defines' [-Wmissing-prototypes]
     245 | void output_sc_defines(void)
         |      ^~~~~~~~~~~~~~~~~
   arch/mips/kernel/asm-offsets.c:258:6: warning: no previous prototype for 'output_signal_defined' [-Wmissing-prototypes]
     258 | void output_signal_defined(void)
         |      ^~~~~~~~~~~~~~~~~~~~~
   arch/mips/kernel/asm-offsets.c:351:6: warning: no previous prototype for 'output_kvm_defines' [-Wmissing-prototypes]
     351 | void output_kvm_defines(void)
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
   arch/mips/kernel/asm-offsets.c:245:6: warning: no previous prototype for 'output_sc_defines' [-Wmissing-prototypes]
     245 | void output_sc_defines(void)
         |      ^~~~~~~~~~~~~~~~~
   arch/mips/kernel/asm-offsets.c:258:6: warning: no previous prototype for 'output_signal_defined' [-Wmissing-prototypes]
     258 | void output_signal_defined(void)
         |      ^~~~~~~~~~~~~~~~~~~~~
   arch/mips/kernel/asm-offsets.c:351:6: warning: no previous prototype for 'output_kvm_defines' [-Wmissing-prototypes]
     351 | void output_kvm_defines(void)
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

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
