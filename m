Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CBBC4C300A
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 16:41:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236463AbiBXPmA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 10:42:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232717AbiBXPl6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 10:41:58 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BD212465C1
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 07:41:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645717288; x=1677253288;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=tFGquLjlcsAHzuVwlqOIiy77lEjYW1VEOYeIrhl4xXs=;
  b=KXMRdlQ8/e41hd44stXEvmm94vTvH9MtPnwf/6On2tk/11JIgJMWlZiu
   HFDdw3pAbUaJxSZA48VBl6gbBkP6lcvZim5kwBUoFXAQ9GYlMsIba8KoJ
   kC2QlSCP2y7UUQr6nB/Jp02qSfa2DJUcNAwYOvH2MB97cv2UkN76G5qC2
   5n2ijgL25pgnAjBOKeql/eF+56E/T+6Ev+HAiSX7PmGNsawVPCp3S/PP9
   I8oPf6MeMFyobr17VpdM+qKruSbbrd3EtFF/27wcNcQho2HI/P4/wE7sA
   HbhgUAdzM9FmhVwvQIx1NkscTuXY/yZVx/zYmqKrosgAOiNhzj7S/jYTG
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10268"; a="239662991"
X-IronPort-AV: E=Sophos;i="5.90,134,1643702400"; 
   d="scan'208";a="239662991"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2022 07:41:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,134,1643702400"; 
   d="scan'208";a="491640630"
Received: from lkp-server01.sh.intel.com (HELO 788b1cd46f0d) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 24 Feb 2022 07:41:26 -0800
Received: from kbuild by 788b1cd46f0d with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nNGFB-0003Fj-Tg; Thu, 24 Feb 2022 15:41:25 +0000
Date:   Thu, 24 Feb 2022 23:40:58 +0800
From:   kernel test robot <lkp@intel.com>
To:     Guo Ren <guoren@linux.alibaba.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [csky-linux:riscv_compat_v6 13/20]
 arch/riscv/kernel/process.c:102:35: error: use of undeclared identifier
 'SR_UXL'
Message-ID: <202202242346.yPxgaryD-lkp@intel.com>
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

tree:   https://github.com/c-sky/csky-linux riscv_compat_v6
head:   4aafa1859382d5a159bdafe2956453feafd38845
commit: 4cebbf9e791522be5b6e7cea289ab1c43c66cbc0 [13/20] riscv: compat: process: Add UXL_32 support in start_thread
config: riscv-buildonly-randconfig-r003-20220223 (https://download.01.org/0day-ci/archive/20220224/202202242346.yPxgaryD-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project d271fc04d5b97b12e6b797c6067d3c96a8d7470e)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install riscv cross compiling tool for clang build
        # apt-get install binutils-riscv64-linux-gnu
        # https://github.com/c-sky/csky-linux/commit/4cebbf9e791522be5b6e7cea289ab1c43c66cbc0
        git remote add csky-linux https://github.com/c-sky/csky-linux
        git fetch --no-tags csky-linux riscv_compat_v6
        git checkout 4cebbf9e791522be5b6e7cea289ab1c43c66cbc0
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=riscv SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   arch/riscv/kernel/process.c:101:6: error: implicit declaration of function 'is_compat_task' [-Werror,-Wimplicit-function-declaration]
           if (is_compat_task())
               ^
>> arch/riscv/kernel/process.c:102:35: error: use of undeclared identifier 'SR_UXL'
                   regs->status = (regs->status & ~SR_UXL) | SR_UXL_32;
                                                   ^
>> arch/riscv/kernel/process.c:102:45: error: use of undeclared identifier 'SR_UXL_32'
                   regs->status = (regs->status & ~SR_UXL) | SR_UXL_32;
                                                             ^
   arch/riscv/kernel/process.c:104:35: error: use of undeclared identifier 'SR_UXL'
                   regs->status = (regs->status & ~SR_UXL) | SR_UXL_64;
                                                   ^
>> arch/riscv/kernel/process.c:104:45: error: use of undeclared identifier 'SR_UXL_64'
                   regs->status = (regs->status & ~SR_UXL) | SR_UXL_64;
                                                             ^
   5 errors generated.


vim +/SR_UXL +102 arch/riscv/kernel/process.c

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
