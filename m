Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51DFC4FAB7D
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Apr 2022 04:14:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239325AbiDJCQr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Apr 2022 22:16:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237452AbiDJCQn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Apr 2022 22:16:43 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75E18B44
        for <linux-kernel@vger.kernel.org>; Sat,  9 Apr 2022 19:14:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649556873; x=1681092873;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=z+V7sgrWsQSSGvnM8od30VjDBxVOj+uN6scvqk20SMk=;
  b=OrixpRlnaVWZL1zdnEAg0kGsDov7DoNsB8zGw5rrjsMnluNj4GUP6Fma
   wnqOXNq+xNn3q5fp+sf0GetKx5MP+DjFvyvUFYIro5hvwlF38Vm9VcQeT
   ldBtOH6h0mNmE8r4PpJEreXXhEybPCbkX3hMcpe7wr3EUcO5SDdFkhLWs
   OimGrjt1Mqvn9P21msuqM0y2JGg+hzAA+AuIOGOtWHQnCyLFFuwWWYkqn
   UNMN1qojGgRvAT4Lsf+xSzyzAcfZEhTz8qAicNhl3dTiwmvav2L5nzPFA
   qL3iiHTbvCx/Jn/3nQoKLSYOs6C/LvX9IJ1rwmLMEsvJWFtjBP9UfHjoR
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10312"; a="262114765"
X-IronPort-AV: E=Sophos;i="5.90,248,1643702400"; 
   d="scan'208";a="262114765"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2022 19:14:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,248,1643702400"; 
   d="scan'208";a="852948655"
Received: from lkp-server02.sh.intel.com (HELO d3fc50ef50de) ([10.239.97.151])
  by fmsmga005.fm.intel.com with ESMTP; 09 Apr 2022 19:14:30 -0700
Received: from kbuild by d3fc50ef50de with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1ndN5y-0000bX-5L;
        Sun, 10 Apr 2022 02:14:30 +0000
Date:   Sun, 10 Apr 2022 10:14:16 +0800
From:   kernel test robot <lkp@intel.com>
To:     Andrew Scull <ascull@google.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Marc Zyngier <maz@kernel.org>
Subject: arch/arm64/kvm/handle_exit.c:295:24: warning: no previous prototype
 for 'nvhe_hyp_panic_handler'
Message-ID: <202204101017.veFtM0ve-lkp@intel.com>
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

Hi Andrew,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   e1f700ebd6bea293abe3c7e2807b252018efde01
commit: aec0fae62e47050019474936248a311a0ab08705 KVM: arm64: Log source when panicking from nVHE hyp
date:   1 year ago
config: arm64-randconfig-r002-20220410 (https://download.01.org/0day-ci/archive/20220410/202204101017.veFtM0ve-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=aec0fae62e47050019474936248a311a0ab08705
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout aec0fae62e47050019474936248a311a0ab08705
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arm64 SHELL=/bin/bash arch/arm64/kvm/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   arch/arm64/kvm/handle_exit.c:177:35: warning: initialized field overwritten [-Woverride-init]
     177 |         [ESR_ELx_EC_WFx]        = kvm_handle_wfx,
         |                                   ^~~~~~~~~~~~~~
   arch/arm64/kvm/handle_exit.c:177:35: note: (near initialization for 'arm_exit_handlers[1]')
   arch/arm64/kvm/handle_exit.c:178:35: warning: initialized field overwritten [-Woverride-init]
     178 |         [ESR_ELx_EC_CP15_32]    = kvm_handle_cp15_32,
         |                                   ^~~~~~~~~~~~~~~~~~
   arch/arm64/kvm/handle_exit.c:178:35: note: (near initialization for 'arm_exit_handlers[3]')
   arch/arm64/kvm/handle_exit.c:179:35: warning: initialized field overwritten [-Woverride-init]
     179 |         [ESR_ELx_EC_CP15_64]    = kvm_handle_cp15_64,
         |                                   ^~~~~~~~~~~~~~~~~~
   arch/arm64/kvm/handle_exit.c:179:35: note: (near initialization for 'arm_exit_handlers[4]')
   arch/arm64/kvm/handle_exit.c:180:35: warning: initialized field overwritten [-Woverride-init]
     180 |         [ESR_ELx_EC_CP14_MR]    = kvm_handle_cp14_32,
         |                                   ^~~~~~~~~~~~~~~~~~
   arch/arm64/kvm/handle_exit.c:180:35: note: (near initialization for 'arm_exit_handlers[5]')
   arch/arm64/kvm/handle_exit.c:181:35: warning: initialized field overwritten [-Woverride-init]
     181 |         [ESR_ELx_EC_CP14_LS]    = kvm_handle_cp14_load_store,
         |                                   ^~~~~~~~~~~~~~~~~~~~~~~~~~
   arch/arm64/kvm/handle_exit.c:181:35: note: (near initialization for 'arm_exit_handlers[6]')
   arch/arm64/kvm/handle_exit.c:182:35: warning: initialized field overwritten [-Woverride-init]
     182 |         [ESR_ELx_EC_CP14_64]    = kvm_handle_cp14_64,
         |                                   ^~~~~~~~~~~~~~~~~~
   arch/arm64/kvm/handle_exit.c:182:35: note: (near initialization for 'arm_exit_handlers[12]')
   arch/arm64/kvm/handle_exit.c:183:35: warning: initialized field overwritten [-Woverride-init]
     183 |         [ESR_ELx_EC_HVC32]      = handle_hvc,
         |                                   ^~~~~~~~~~
   arch/arm64/kvm/handle_exit.c:183:35: note: (near initialization for 'arm_exit_handlers[18]')
   arch/arm64/kvm/handle_exit.c:184:35: warning: initialized field overwritten [-Woverride-init]
     184 |         [ESR_ELx_EC_SMC32]      = handle_smc,
         |                                   ^~~~~~~~~~
   arch/arm64/kvm/handle_exit.c:184:35: note: (near initialization for 'arm_exit_handlers[19]')
   arch/arm64/kvm/handle_exit.c:185:35: warning: initialized field overwritten [-Woverride-init]
     185 |         [ESR_ELx_EC_HVC64]      = handle_hvc,
         |                                   ^~~~~~~~~~
   arch/arm64/kvm/handle_exit.c:185:35: note: (near initialization for 'arm_exit_handlers[22]')
   arch/arm64/kvm/handle_exit.c:186:35: warning: initialized field overwritten [-Woverride-init]
     186 |         [ESR_ELx_EC_SMC64]      = handle_smc,
         |                                   ^~~~~~~~~~
   arch/arm64/kvm/handle_exit.c:186:35: note: (near initialization for 'arm_exit_handlers[23]')
   arch/arm64/kvm/handle_exit.c:187:35: warning: initialized field overwritten [-Woverride-init]
     187 |         [ESR_ELx_EC_SYS64]      = kvm_handle_sys_reg,
         |                                   ^~~~~~~~~~~~~~~~~~
   arch/arm64/kvm/handle_exit.c:187:35: note: (near initialization for 'arm_exit_handlers[24]')
   arch/arm64/kvm/handle_exit.c:188:35: warning: initialized field overwritten [-Woverride-init]
     188 |         [ESR_ELx_EC_SVE]        = handle_sve,
         |                                   ^~~~~~~~~~
   arch/arm64/kvm/handle_exit.c:188:35: note: (near initialization for 'arm_exit_handlers[25]')
   arch/arm64/kvm/handle_exit.c:189:35: warning: initialized field overwritten [-Woverride-init]
     189 |         [ESR_ELx_EC_IABT_LOW]   = kvm_handle_guest_abort,
         |                                   ^~~~~~~~~~~~~~~~~~~~~~
   arch/arm64/kvm/handle_exit.c:189:35: note: (near initialization for 'arm_exit_handlers[32]')
   arch/arm64/kvm/handle_exit.c:190:35: warning: initialized field overwritten [-Woverride-init]
     190 |         [ESR_ELx_EC_DABT_LOW]   = kvm_handle_guest_abort,
         |                                   ^~~~~~~~~~~~~~~~~~~~~~
   arch/arm64/kvm/handle_exit.c:190:35: note: (near initialization for 'arm_exit_handlers[36]')
   arch/arm64/kvm/handle_exit.c:191:35: warning: initialized field overwritten [-Woverride-init]
     191 |         [ESR_ELx_EC_SOFTSTP_LOW]= kvm_handle_guest_debug,
         |                                   ^~~~~~~~~~~~~~~~~~~~~~
   arch/arm64/kvm/handle_exit.c:191:35: note: (near initialization for 'arm_exit_handlers[50]')
   arch/arm64/kvm/handle_exit.c:192:35: warning: initialized field overwritten [-Woverride-init]
     192 |         [ESR_ELx_EC_WATCHPT_LOW]= kvm_handle_guest_debug,
         |                                   ^~~~~~~~~~~~~~~~~~~~~~
   arch/arm64/kvm/handle_exit.c:192:35: note: (near initialization for 'arm_exit_handlers[52]')
   arch/arm64/kvm/handle_exit.c:193:35: warning: initialized field overwritten [-Woverride-init]
     193 |         [ESR_ELx_EC_BREAKPT_LOW]= kvm_handle_guest_debug,
         |                                   ^~~~~~~~~~~~~~~~~~~~~~
   arch/arm64/kvm/handle_exit.c:193:35: note: (near initialization for 'arm_exit_handlers[48]')
   arch/arm64/kvm/handle_exit.c:194:35: warning: initialized field overwritten [-Woverride-init]
     194 |         [ESR_ELx_EC_BKPT32]     = kvm_handle_guest_debug,
         |                                   ^~~~~~~~~~~~~~~~~~~~~~
   arch/arm64/kvm/handle_exit.c:194:35: note: (near initialization for 'arm_exit_handlers[56]')
   arch/arm64/kvm/handle_exit.c:195:35: warning: initialized field overwritten [-Woverride-init]
     195 |         [ESR_ELx_EC_BRK64]      = kvm_handle_guest_debug,
         |                                   ^~~~~~~~~~~~~~~~~~~~~~
   arch/arm64/kvm/handle_exit.c:195:35: note: (near initialization for 'arm_exit_handlers[60]')
   arch/arm64/kvm/handle_exit.c:196:35: warning: initialized field overwritten [-Woverride-init]
     196 |         [ESR_ELx_EC_FP_ASIMD]   = handle_no_fpsimd,
         |                                   ^~~~~~~~~~~~~~~~
   arch/arm64/kvm/handle_exit.c:196:35: note: (near initialization for 'arm_exit_handlers[7]')
   arch/arm64/kvm/handle_exit.c:197:35: warning: initialized field overwritten [-Woverride-init]
     197 |         [ESR_ELx_EC_PAC]        = kvm_handle_ptrauth,
         |                                   ^~~~~~~~~~~~~~~~~~
   arch/arm64/kvm/handle_exit.c:197:35: note: (near initialization for 'arm_exit_handlers[9]')
>> arch/arm64/kvm/handle_exit.c:295:24: warning: no previous prototype for 'nvhe_hyp_panic_handler' [-Wmissing-prototypes]
     295 | void __noreturn __cold nvhe_hyp_panic_handler(u64 esr, u64 spsr, u64 elr,
         |                        ^~~~~~~~~~~~~~~~~~~~~~


vim +/nvhe_hyp_panic_handler +295 arch/arm64/kvm/handle_exit.c

   294	
 > 295	void __noreturn __cold nvhe_hyp_panic_handler(u64 esr, u64 spsr, u64 elr,

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
