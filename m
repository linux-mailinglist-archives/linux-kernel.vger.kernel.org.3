Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13A494BDD88
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 18:45:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377597AbiBUOUw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 09:20:52 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:57792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377591AbiBUOUn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 09:20:43 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6F9312AF2
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 06:20:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645453219; x=1676989219;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=lIrVKhxO70mPvsp+2h0iXJyOj+WEKeXO5qoA+siKVk4=;
  b=WMuVVPXJDPDosasT85ei/Sg4JJrn5dN5nI4O0JbJ/k99mZMqJ0G6UeUf
   Gii0lCvGgJGXEd5XtNlWB9N54r15kdPob3q0PQVSA1WfbKCz4JIs4U+os
   maMOqWM26YwV8cjl+8/tAN296dPma3+lLUlruryxCYwkkUqX1+NrlU7tG
   zrro3xo+F03RPB2NoqfwlyBPXgpwuxGXv38UpexxO/aK7MeFC3LqvbVti
   agSOmfbl5L75AF+NdX/xS4B4zR2rWzZ31gerkmknJKrwNf9UDrpOABUG1
   4zoZppTLlTkACl992WiMTGUVXJb4j+0Jw4eudiXSsm8yzFzbomv57uAe4
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10264"; a="251700447"
X-IronPort-AV: E=Sophos;i="5.88,385,1635231600"; 
   d="scan'208";a="251700447"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2022 06:20:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,385,1635231600"; 
   d="scan'208";a="706271062"
Received: from lkp-server01.sh.intel.com (HELO da3212ac2f54) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 21 Feb 2022 06:20:17 -0800
Received: from kbuild by da3212ac2f54 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nM9Y1-0001gL-2q; Mon, 21 Feb 2022 14:20:17 +0000
Date:   Mon, 21 Feb 2022 22:19:32 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [mingo-tip:sched/headers 1672/2575]
 arch/arm64/kernel/traps.c:1081:13: warning: no previous prototype for
 'trap_init'
Message-ID: <202202212246.NWO9hltY-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git sched/headers
head:   21149ca19c21f6b5593d5146690ec83f8f633976
commit: 9a13b41bcfded6a24f455f3539a898baefa32041 [1672/2575] headers/deps: tracing: Optimize the <trace/syscall.h> header
config: arm64-allnoconfig (https://download.01.org/0day-ci/archive/20220221/202202212246.NWO9hltY-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git/commit/?id=9a13b41bcfded6a24f455f3539a898baefa32041
        git remote add mingo-tip git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git
        git fetch --no-tags mingo-tip sched/headers
        git checkout 9a13b41bcfded6a24f455f3539a898baefa32041
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arm64 SHELL=/bin/bash arch/arm64/kernel/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   arch/arm64/kernel/traps.c:829:43: note: (near initialization for 'esr_class_str[22]')
   arch/arm64/kernel/traps.c:830:43: warning: initialized field overwritten [-Woverride-init]
     830 |         [ESR_ELx_EC_SMC64]              = "SMC (AArch64)",
         |                                           ^~~~~~~~~~~~~~~
   arch/arm64/kernel/traps.c:830:43: note: (near initialization for 'esr_class_str[23]')
   arch/arm64/kernel/traps.c:831:43: warning: initialized field overwritten [-Woverride-init]
     831 |         [ESR_ELx_EC_SYS64]              = "MSR/MRS (AArch64)",
         |                                           ^~~~~~~~~~~~~~~~~~~
   arch/arm64/kernel/traps.c:831:43: note: (near initialization for 'esr_class_str[24]')
   arch/arm64/kernel/traps.c:832:43: warning: initialized field overwritten [-Woverride-init]
     832 |         [ESR_ELx_EC_SVE]                = "SVE",
         |                                           ^~~~~
   arch/arm64/kernel/traps.c:832:43: note: (near initialization for 'esr_class_str[25]')
   arch/arm64/kernel/traps.c:833:43: warning: initialized field overwritten [-Woverride-init]
     833 |         [ESR_ELx_EC_ERET]               = "ERET/ERETAA/ERETAB",
         |                                           ^~~~~~~~~~~~~~~~~~~~
   arch/arm64/kernel/traps.c:833:43: note: (near initialization for 'esr_class_str[26]')
   arch/arm64/kernel/traps.c:834:43: warning: initialized field overwritten [-Woverride-init]
     834 |         [ESR_ELx_EC_FPAC]               = "FPAC",
         |                                           ^~~~~~
   arch/arm64/kernel/traps.c:834:43: note: (near initialization for 'esr_class_str[28]')
   arch/arm64/kernel/traps.c:835:43: warning: initialized field overwritten [-Woverride-init]
     835 |         [ESR_ELx_EC_IMP_DEF]            = "EL3 IMP DEF",
         |                                           ^~~~~~~~~~~~~
   arch/arm64/kernel/traps.c:835:43: note: (near initialization for 'esr_class_str[31]')
   arch/arm64/kernel/traps.c:836:43: warning: initialized field overwritten [-Woverride-init]
     836 |         [ESR_ELx_EC_IABT_LOW]           = "IABT (lower EL)",
         |                                           ^~~~~~~~~~~~~~~~~
   arch/arm64/kernel/traps.c:836:43: note: (near initialization for 'esr_class_str[32]')
   arch/arm64/kernel/traps.c:837:43: warning: initialized field overwritten [-Woverride-init]
     837 |         [ESR_ELx_EC_IABT_CUR]           = "IABT (current EL)",
         |                                           ^~~~~~~~~~~~~~~~~~~
   arch/arm64/kernel/traps.c:837:43: note: (near initialization for 'esr_class_str[33]')
   arch/arm64/kernel/traps.c:838:43: warning: initialized field overwritten [-Woverride-init]
     838 |         [ESR_ELx_EC_PC_ALIGN]           = "PC Alignment",
         |                                           ^~~~~~~~~~~~~~
   arch/arm64/kernel/traps.c:838:43: note: (near initialization for 'esr_class_str[34]')
   arch/arm64/kernel/traps.c:839:43: warning: initialized field overwritten [-Woverride-init]
     839 |         [ESR_ELx_EC_DABT_LOW]           = "DABT (lower EL)",
         |                                           ^~~~~~~~~~~~~~~~~
   arch/arm64/kernel/traps.c:839:43: note: (near initialization for 'esr_class_str[36]')
   arch/arm64/kernel/traps.c:840:43: warning: initialized field overwritten [-Woverride-init]
     840 |         [ESR_ELx_EC_DABT_CUR]           = "DABT (current EL)",
         |                                           ^~~~~~~~~~~~~~~~~~~
   arch/arm64/kernel/traps.c:840:43: note: (near initialization for 'esr_class_str[37]')
   arch/arm64/kernel/traps.c:841:43: warning: initialized field overwritten [-Woverride-init]
     841 |         [ESR_ELx_EC_SP_ALIGN]           = "SP Alignment",
         |                                           ^~~~~~~~~~~~~~
   arch/arm64/kernel/traps.c:841:43: note: (near initialization for 'esr_class_str[38]')
   arch/arm64/kernel/traps.c:842:43: warning: initialized field overwritten [-Woverride-init]
     842 |         [ESR_ELx_EC_FP_EXC32]           = "FP (AArch32)",
         |                                           ^~~~~~~~~~~~~~
   arch/arm64/kernel/traps.c:842:43: note: (near initialization for 'esr_class_str[40]')
   arch/arm64/kernel/traps.c:843:43: warning: initialized field overwritten [-Woverride-init]
     843 |         [ESR_ELx_EC_FP_EXC64]           = "FP (AArch64)",
         |                                           ^~~~~~~~~~~~~~
   arch/arm64/kernel/traps.c:843:43: note: (near initialization for 'esr_class_str[44]')
   arch/arm64/kernel/traps.c:844:43: warning: initialized field overwritten [-Woverride-init]
     844 |         [ESR_ELx_EC_SERROR]             = "SError",
         |                                           ^~~~~~~~
   arch/arm64/kernel/traps.c:844:43: note: (near initialization for 'esr_class_str[47]')
   arch/arm64/kernel/traps.c:845:43: warning: initialized field overwritten [-Woverride-init]
     845 |         [ESR_ELx_EC_BREAKPT_LOW]        = "Breakpoint (lower EL)",
         |                                           ^~~~~~~~~~~~~~~~~~~~~~~
   arch/arm64/kernel/traps.c:845:43: note: (near initialization for 'esr_class_str[48]')
   arch/arm64/kernel/traps.c:846:43: warning: initialized field overwritten [-Woverride-init]
     846 |         [ESR_ELx_EC_BREAKPT_CUR]        = "Breakpoint (current EL)",
         |                                           ^~~~~~~~~~~~~~~~~~~~~~~~~
   arch/arm64/kernel/traps.c:846:43: note: (near initialization for 'esr_class_str[49]')
   arch/arm64/kernel/traps.c:847:43: warning: initialized field overwritten [-Woverride-init]
     847 |         [ESR_ELx_EC_SOFTSTP_LOW]        = "Software Step (lower EL)",
         |                                           ^~~~~~~~~~~~~~~~~~~~~~~~~~
   arch/arm64/kernel/traps.c:847:43: note: (near initialization for 'esr_class_str[50]')
   arch/arm64/kernel/traps.c:848:43: warning: initialized field overwritten [-Woverride-init]
     848 |         [ESR_ELx_EC_SOFTSTP_CUR]        = "Software Step (current EL)",
         |                                           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   arch/arm64/kernel/traps.c:848:43: note: (near initialization for 'esr_class_str[51]')
   arch/arm64/kernel/traps.c:849:43: warning: initialized field overwritten [-Woverride-init]
     849 |         [ESR_ELx_EC_WATCHPT_LOW]        = "Watchpoint (lower EL)",
         |                                           ^~~~~~~~~~~~~~~~~~~~~~~
   arch/arm64/kernel/traps.c:849:43: note: (near initialization for 'esr_class_str[52]')
   arch/arm64/kernel/traps.c:850:43: warning: initialized field overwritten [-Woverride-init]
     850 |         [ESR_ELx_EC_WATCHPT_CUR]        = "Watchpoint (current EL)",
         |                                           ^~~~~~~~~~~~~~~~~~~~~~~~~
   arch/arm64/kernel/traps.c:850:43: note: (near initialization for 'esr_class_str[53]')
   arch/arm64/kernel/traps.c:851:43: warning: initialized field overwritten [-Woverride-init]
     851 |         [ESR_ELx_EC_BKPT32]             = "BKPT (AArch32)",
         |                                           ^~~~~~~~~~~~~~~~
   arch/arm64/kernel/traps.c:851:43: note: (near initialization for 'esr_class_str[56]')
   arch/arm64/kernel/traps.c:852:43: warning: initialized field overwritten [-Woverride-init]
     852 |         [ESR_ELx_EC_VECTOR32]           = "Vector catch (AArch32)",
         |                                           ^~~~~~~~~~~~~~~~~~~~~~~~
   arch/arm64/kernel/traps.c:852:43: note: (near initialization for 'esr_class_str[58]')
   arch/arm64/kernel/traps.c:853:43: warning: initialized field overwritten [-Woverride-init]
     853 |         [ESR_ELx_EC_BRK64]              = "BRK (AArch64)",
         |                                           ^~~~~~~~~~~~~~~
   arch/arm64/kernel/traps.c:853:43: note: (near initialization for 'esr_class_str[60]')
   arch/arm64/kernel/traps.c:1069:12: warning: no previous prototype for 'early_brk64' [-Wmissing-prototypes]
    1069 | int __init early_brk64(unsigned long addr, unsigned int esr,
         |            ^~~~~~~~~~~
>> arch/arm64/kernel/traps.c:1081:13: warning: no previous prototype for 'trap_init' [-Wmissing-prototypes]
    1081 | void __init trap_init(void)
         |             ^~~~~~~~~


vim +/trap_init +1081 arch/arm64/kernel/traps.c

9fb7410f955f7a Dave P Martin   2015-07-24  1080  
60ffc30d565281 Catalin Marinas 2012-03-05 @1081  void __init trap_init(void)

:::::: The code at line 1081 was first introduced by commit
:::::: 60ffc30d5652810dd34ea2eec41504222f5d5791 arm64: Exception handling

:::::: TO: Catalin Marinas <catalin.marinas@arm.com>
:::::: CC: Catalin Marinas <catalin.marinas@arm.com>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
