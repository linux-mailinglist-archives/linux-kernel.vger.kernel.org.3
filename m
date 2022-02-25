Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DFC24C5216
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Feb 2022 00:30:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239408AbiBYXbF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 18:31:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239336AbiBYXbC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 18:31:02 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F32119F473
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 15:30:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645831829; x=1677367829;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=++ug63gMtYQuPNSVQoZUYLJuaPAipqR7J008vxy9R48=;
  b=fYjQX9P2cOramIe9kh1QliTbfMeEjxbfUZ7ui4J6VylsWxQdjM/h5sJy
   naTBf5uH7uW9dreHSW/ffamEUMXTk2R79Va99qQbjHBetgiAAINXaPlx5
   ik7iVcBb5JcTAdd+o6HiPOZ55xpbfbhZSilmcC+1yIG9NcqQdNKiiPYH7
   iq+R8q9VlxAdsMT8PR3mRnyek6uvMtg2SSR+tw5R2gphsJ27vfx97EITT
   JIMD4mwc8bNn827HKQVNgGdChUoy2MbK/LhFX0gLzvTXd9p9hJ90US+Tl
   Yx+PbC23YEFNIpCAaCeR2YNJnsw1rEKAymTQQoCpSJ6gXC8uhpUe/tgNG
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10269"; a="236108634"
X-IronPort-AV: E=Sophos;i="5.90,137,1643702400"; 
   d="scan'208";a="236108634"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2022 15:30:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,137,1643702400"; 
   d="scan'208";a="509429973"
Received: from lkp-server01.sh.intel.com (HELO 788b1cd46f0d) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 25 Feb 2022 15:30:27 -0800
Received: from kbuild by 788b1cd46f0d with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nNk2c-0004og-L7; Fri, 25 Feb 2022 23:30:26 +0000
Date:   Sat, 26 Feb 2022 07:29:47 +0800
From:   kernel test robot <lkp@intel.com>
To:     Vineet Gupta <vgupta@synopsys.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        linux-snps-arc@lists.infradead.org
Subject: arch/arc/kernel/signal.c:77:31: sparse: sparse: incorrect type in
 argument 1 (different address spaces)
Message-ID: <202202260759.DXHGI8gG-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   53ab78cd6d5aba25575a7cfb95729336ba9497d8
commit: 96f1b00138cb8f04c742c82d0a7c460b2202e887 ARCv2: save ABI registers across signal handling
date:   9 months ago
config: arc-randconfig-s032-20220226 (https://download.01.org/0day-ci/archive/20220226/202202260759.DXHGI8gG-lkp@intel.com/config)
compiler: arceb-elf-gcc (GCC) 11.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=96f1b00138cb8f04c742c82d0a7c460b2202e887
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 96f1b00138cb8f04c742c82d0a7c460b2202e887
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=arc SHELL=/bin/bash arch/arc/kernel/ drivers/remoteproc/ fs/ kernel/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
>> arch/arc/kernel/signal.c:77:31: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void [noderef] __user *to @@     got struct user_regs_arcv2 * @@
   arch/arc/kernel/signal.c:77:31: sparse:     expected void [noderef] __user *to
   arch/arc/kernel/signal.c:77:31: sparse:     got struct user_regs_arcv2 *
>> arch/arc/kernel/signal.c:88:41: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const [noderef] __user *from @@     got struct user_regs_arcv2 * @@
   arch/arc/kernel/signal.c:88:41: sparse:     expected void const [noderef] __user *from
   arch/arc/kernel/signal.c:88:41: sparse:     got struct user_regs_arcv2 *
>> arch/arc/kernel/signal.c:134:42: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct sigcontext *mctx @@     got struct sigcontext [noderef] __user * @@
   arch/arc/kernel/signal.c:134:42: sparse:     expected struct sigcontext *mctx
   arch/arc/kernel/signal.c:134:42: sparse:     got struct sigcontext [noderef] __user *
   arch/arc/kernel/signal.c:153:45: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct sigcontext *mctx @@     got struct sigcontext [noderef] __user * @@
   arch/arc/kernel/signal.c:153:45: sparse:     expected struct sigcontext *mctx
   arch/arc/kernel/signal.c:153:45: sparse:     got struct sigcontext [noderef] __user *

vim +77 arch/arc/kernel/signal.c

    63	
    64	static int save_arcv2_regs(struct sigcontext *mctx, struct pt_regs *regs)
    65	{
    66		int err = 0;
    67	#ifndef CONFIG_ISA_ARCOMPACT
    68		struct user_regs_arcv2 v2abi;
    69	
    70		v2abi.r30 = regs->r30;
    71	#ifdef CONFIG_ARC_HAS_ACCL_REGS
    72		v2abi.r58 = regs->r58;
    73		v2abi.r59 = regs->r59;
    74	#else
    75		v2abi.r58 = v2abi.r59 = 0;
    76	#endif
  > 77		err = __copy_to_user(&mctx->v2abi, &v2abi, sizeof(v2abi));
    78	#endif
    79		return err;
    80	}
    81	
    82	static int restore_arcv2_regs(struct sigcontext *mctx, struct pt_regs *regs)
    83	{
    84		int err = 0;
    85	#ifndef CONFIG_ISA_ARCOMPACT
    86		struct user_regs_arcv2 v2abi;
    87	
  > 88		err = __copy_from_user(&v2abi, &mctx->v2abi, sizeof(v2abi));
    89	
    90		regs->r30 = v2abi.r30;
    91	#ifdef CONFIG_ARC_HAS_ACCL_REGS
    92		regs->r58 = v2abi.r58;
    93		regs->r59 = v2abi.r59;
    94	#endif
    95	#endif
    96		return err;
    97	}
    98	
    99	static int
   100	stash_usr_regs(struct rt_sigframe __user *sf, struct pt_regs *regs,
   101		       sigset_t *set)
   102	{
   103		int err;
   104		struct user_regs_struct uregs;
   105	
   106		uregs.scratch.bta	= regs->bta;
   107		uregs.scratch.lp_start	= regs->lp_start;
   108		uregs.scratch.lp_end	= regs->lp_end;
   109		uregs.scratch.lp_count	= regs->lp_count;
   110		uregs.scratch.status32	= regs->status32;
   111		uregs.scratch.ret	= regs->ret;
   112		uregs.scratch.blink	= regs->blink;
   113		uregs.scratch.fp	= regs->fp;
   114		uregs.scratch.gp	= regs->r26;
   115		uregs.scratch.r12	= regs->r12;
   116		uregs.scratch.r11	= regs->r11;
   117		uregs.scratch.r10	= regs->r10;
   118		uregs.scratch.r9	= regs->r9;
   119		uregs.scratch.r8	= regs->r8;
   120		uregs.scratch.r7	= regs->r7;
   121		uregs.scratch.r6	= regs->r6;
   122		uregs.scratch.r5	= regs->r5;
   123		uregs.scratch.r4	= regs->r4;
   124		uregs.scratch.r3	= regs->r3;
   125		uregs.scratch.r2	= regs->r2;
   126		uregs.scratch.r1	= regs->r1;
   127		uregs.scratch.r0	= regs->r0;
   128		uregs.scratch.sp	= regs->sp;
   129	
   130		err = __copy_to_user(&(sf->uc.uc_mcontext.regs.scratch), &uregs.scratch,
   131				     sizeof(sf->uc.uc_mcontext.regs.scratch));
   132	
   133		if (is_isa_arcv2())
 > 134			err |= save_arcv2_regs(&(sf->uc.uc_mcontext), regs);
   135	
   136		err |= __copy_to_user(&sf->uc.uc_sigmask, set, sizeof(sigset_t));
   137	
   138		return err ? -EFAULT : 0;
   139	}
   140	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
