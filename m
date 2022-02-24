Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FCD94C2FAB
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 16:31:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236296AbiBXPbB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 10:31:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232698AbiBXPa6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 10:30:58 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC0CF1BE4DB
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 07:30:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645716628; x=1677252628;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=SG/qNyoyeD33UZHttvum//yi24uhmRcyyS6OKq8v1K4=;
  b=S5NrCo7rkNYMhFzoM8zz/9Un5XhQvvmq6NpWNVaKzJ7JBRwh1AfnV2cM
   Y1MS0Q66KRr4fIMQcjOlpoYoGm0r9IV1Nl0M9RQKij9f5IMFwuSLffTe7
   3y8R4xr35CCwv4TeoicQNPmkH/a4vfaryCxEqwJyx1dda3N36o67G792W
   VTHeMjUiLSVy9QYKE4zsUdNmqXzEBtz+riof1GXcaoXJv2X0YP7VC28ui
   DJAUVehJvCgu0whW8XZ7yg4t4RkKP7u4U0kju+yZNgJCIu9k96ZAMM+o2
   8WKTCIwFm4flLz/xgTAXOVWjj2yxflKKMM7pbwtKKpLD7d4gWYOyDevbn
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10268"; a="315481514"
X-IronPort-AV: E=Sophos;i="5.90,134,1643702400"; 
   d="scan'208";a="315481514"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2022 07:30:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,134,1643702400"; 
   d="scan'208";a="491637382"
Received: from lkp-server01.sh.intel.com (HELO 788b1cd46f0d) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 24 Feb 2022 07:30:26 -0800
Received: from kbuild by 788b1cd46f0d with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nNG4X-0003FC-P6; Thu, 24 Feb 2022 15:30:25 +0000
Date:   Thu, 24 Feb 2022 23:30:20 +0800
From:   kernel test robot <lkp@intel.com>
To:     Guo Ren <guoren@linux.alibaba.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [csky-linux:riscv_compat_v6 13/20]
 arch/riscv/kernel/process.c:102:49: error: 'SR_UXL' undeclared; did you mean
 'SR_XS'?
Message-ID: <202202242354.qbKyVs40-lkp@intel.com>
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

tree:   https://github.com/c-sky/csky-linux riscv_compat_v6
head:   4aafa1859382d5a159bdafe2956453feafd38845
commit: 4cebbf9e791522be5b6e7cea289ab1c43c66cbc0 [13/20] riscv: compat: process: Add UXL_32 support in start_thread
config: riscv-buildonly-randconfig-r006-20220224 (https://download.01.org/0day-ci/archive/20220224/202202242354.qbKyVs40-lkp@intel.com/config)
compiler: riscv32-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/c-sky/csky-linux/commit/4cebbf9e791522be5b6e7cea289ab1c43c66cbc0
        git remote add csky-linux https://github.com/c-sky/csky-linux
        git fetch --no-tags csky-linux riscv_compat_v6
        git checkout 4cebbf9e791522be5b6e7cea289ab1c43c66cbc0
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=riscv SHELL=/bin/bash arch/riscv/kernel/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   arch/riscv/kernel/process.c: In function 'start_thread':
   arch/riscv/kernel/process.c:101:13: error: implicit declaration of function 'is_compat_task' [-Werror=implicit-function-declaration]
     101 |         if (is_compat_task())
         |             ^~~~~~~~~~~~~~
>> arch/riscv/kernel/process.c:102:49: error: 'SR_UXL' undeclared (first use in this function); did you mean 'SR_XS'?
     102 |                 regs->status = (regs->status & ~SR_UXL) | SR_UXL_32;
         |                                                 ^~~~~~
         |                                                 SR_XS
   arch/riscv/kernel/process.c:102:49: note: each undeclared identifier is reported only once for each function it appears in
>> arch/riscv/kernel/process.c:102:59: error: 'SR_UXL_32' undeclared (first use in this function)
     102 |                 regs->status = (regs->status & ~SR_UXL) | SR_UXL_32;
         |                                                           ^~~~~~~~~
>> arch/riscv/kernel/process.c:104:59: error: 'SR_UXL_64' undeclared (first use in this function)
     104 |                 regs->status = (regs->status & ~SR_UXL) | SR_UXL_64;
         |                                                           ^~~~~~~~~
   cc1: some warnings being treated as errors


vim +102 arch/riscv/kernel/process.c

    85	
    86	void start_thread(struct pt_regs *regs, unsigned long pc,
    87		unsigned long sp)
    88	{
    89		regs->status = SR_PIE;
    90		if (has_fpu()) {
    91			regs->status |= SR_FS_INITIAL;
    92			/*
    93			 * Restore the initial value to the FP register
    94			 * before starting the user program.
    95			 */
    96			fstate_restore(current, regs);
    97		}
    98		regs->epc = pc;
    99		regs->sp = sp;
   100	
   101		if (is_compat_task())
 > 102			regs->status = (regs->status & ~SR_UXL) | SR_UXL_32;
   103		else
 > 104			regs->status = (regs->status & ~SR_UXL) | SR_UXL_64;
   105	}
   106	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
