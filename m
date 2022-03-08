Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 359834D1BB8
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 16:29:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236232AbiCHPa3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 10:30:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229635AbiCHPa0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 10:30:26 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05DB447ACB
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 07:29:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646753370; x=1678289370;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=2JVtHS7y2JL1cMyAoxmO+1PK36rhjFiIT/0QpYRgKVQ=;
  b=hR+lXZK6NvwrVDE0uTvflMuHjzC2skb4FbnsyNkTzJydseBT0cs0pLvg
   UoJhhNRqXjkz1FgbKV0JxiILu1JeeF0OATptmeUjg9NY3pYNLmN+EGAQN
   vn1jtlxT8yzTgowUDfvviT3ZrvoEqahuuTyQQA/LRlHT9rWh10CLLXcNv
   eny36cqhw6xCPBuPk3GZTij+gURJZZ0gV4o9ZzP3KIjY/fFrGvMGvdFWg
   pdjTWjt7P/4Wcau58xzYm8xbNfITfwbWvigqkPkAprSev+HaOLgF11Yql
   HhQnPLboiWTxqkNaY3o97Ht21IIiPykXVt6KIiajLVS8FfSPIkOkUo78k
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10280"; a="317939512"
X-IronPort-AV: E=Sophos;i="5.90,165,1643702400"; 
   d="scan'208";a="317939512"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2022 07:29:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,165,1643702400"; 
   d="scan'208";a="611031437"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by fmsmga004.fm.intel.com with ESMTP; 08 Mar 2022 07:29:27 -0800
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nRbmB-0001b3-8d; Tue, 08 Mar 2022 15:29:27 +0000
Date:   Tue, 8 Mar 2022 23:29:04 +0800
From:   kernel test robot <lkp@intel.com>
To:     Guo Ren <guoren@linux.alibaba.com>
Cc:     kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org, Palmer Dabbelt <palmer@rivosinc.com>
Subject: [ammarfaizi2-block:palmer/linux/riscv-compat 13/20]
 arch/riscv/kernel/process.c:102:49: error: 'SR_UXL' undeclared; did you mean
 'SR_XS'?
Message-ID: <202203082324.U2nq0lwC-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ammarfaizi2/linux-block palmer/linux/riscv-compat
head:   ab7e33a6b819f009c3c9ccf69b2f44c1ad84a5a0
commit: d463ff83f0d26ce352a0969c86a9accf70d30977 [13/20] riscv: compat: process: Add UXL_32 support in start_thread
config: riscv-randconfig-r042-20220308 (https://download.01.org/0day-ci/archive/20220308/202203082324.U2nq0lwC-lkp@intel.com/config)
compiler: riscv32-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/ammarfaizi2/linux-block/commit/d463ff83f0d26ce352a0969c86a9accf70d30977
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block palmer/linux/riscv-compat
        git checkout d463ff83f0d26ce352a0969c86a9accf70d30977
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
 > 101		if (is_compat_task())
 > 102			regs->status = (regs->status & ~SR_UXL) | SR_UXL_32;
   103		else
 > 104			regs->status = (regs->status & ~SR_UXL) | SR_UXL_64;
   105	}
   106	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
