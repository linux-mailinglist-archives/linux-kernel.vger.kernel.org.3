Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99E0E4D1700
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 13:14:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346731AbiCHMPW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 07:15:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346723AbiCHMPU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 07:15:20 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14B0043ED5
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 04:14:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646741664; x=1678277664;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Zt3xKn+Klw2lmd6ejBz+st0wYaOLEooTRBK1yYCq3bY=;
  b=gVkxNw9hM5YS2sjpRm0LyetLamDdk2YTaosMZFKX+wXqmkMDXNPduHnu
   mWLIN+oKKnl3K0gvz83a83vq8Lm9B4Dem0TO6Egf5H0jv1HWX6sEOOHx0
   +7fRVieE4zNq4HorBdd9CcuoLXtl+V2p0ERN3IdSrO8mcVWTK/AkU8J0F
   JQcxtRA1K6EsJqwc0VkHZBjOKpvDK0MEFbiDaFNkJxpqUyspt4LUJ2yJB
   NHcv/HPRy4rYLFHulgw7udPJaFozaP3eb4tleaXL3piuptDbwnx38jaKS
   EyyuSASN1/AkQCO+XzCjrUh72lNRaGizHWTogWdKkuRf6tmXDLQMPKIJQ
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10279"; a="252240489"
X-IronPort-AV: E=Sophos;i="5.90,164,1643702400"; 
   d="scan'208";a="252240489"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2022 04:14:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,164,1643702400"; 
   d="scan'208";a="513086205"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 08 Mar 2022 04:14:21 -0800
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nRYjM-0001ML-J2; Tue, 08 Mar 2022 12:14:20 +0000
Date:   Tue, 8 Mar 2022 20:13:30 +0800
From:   kernel test robot <lkp@intel.com>
To:     Guo Ren <guoren@linux.alibaba.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org, Palmer Dabbelt <palmer@rivosinc.com>
Subject: [ammarfaizi2-block:palmer/linux/riscv-compat 13/20]
 arch/riscv/kernel/process.c:102:35: error: use of undeclared identifier
 'SR_UXL'
Message-ID: <202203082040.sCWBscgE-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ammarfaizi2/linux-block palmer/linux/riscv-compat
head:   ab7e33a6b819f009c3c9ccf69b2f44c1ad84a5a0
commit: d463ff83f0d26ce352a0969c86a9accf70d30977 [13/20] riscv: compat: process: Add UXL_32 support in start_thread
config: riscv-randconfig-r005-20220308 (https://download.01.org/0day-ci/archive/20220308/202203082040.sCWBscgE-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project d271fc04d5b97b12e6b797c6067d3c96a8d7470e)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install riscv cross compiling tool for clang build
        # apt-get install binutils-riscv64-linux-gnu
        # https://github.com/ammarfaizi2/linux-block/commit/d463ff83f0d26ce352a0969c86a9accf70d30977
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block palmer/linux/riscv-compat
        git checkout d463ff83f0d26ce352a0969c86a9accf70d30977
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
