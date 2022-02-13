Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 931264B38D5
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Feb 2022 02:46:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232833AbiBMBqv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Feb 2022 20:46:51 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:45130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230179AbiBMBqs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Feb 2022 20:46:48 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E92A60063
        for <linux-kernel@vger.kernel.org>; Sat, 12 Feb 2022 17:46:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644716804; x=1676252804;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=ey6dyXrwZx0k6j2MPnq2DjkbHg59ocYU1a2PPUchemo=;
  b=gijXTqA/Nhmr93BkmVda5mCjXFFfILnVp6ScJ0/qjEG4dZvh7wCqkm/j
   m5BVJVBW9GB9Vtnl52aqI3gfribW1daQFujDJGPtbgM7lkMWxORZTllZQ
   D0ti5BH7dgr+Yk70z2VQiA98/Sjl6GPRr6i0y36T96A+5Z78Tv/rKdfdJ
   EAKRuQw91nS7Z8vsmwzWNytCL5gWw5N/hOLDrq1BpPopQk/V3dCnUkAff
   J/RriPTnQR/XQm0b6OHwic0vzcoE/7bQbRGLGloARjsOg73RVwvuYPMV4
   oLCHs+PTOpKDdblk8PnT8915WCQRr1cGfSYxte3Rjr7yXwerbenZWSIhA
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10256"; a="313196167"
X-IronPort-AV: E=Sophos;i="5.88,364,1635231600"; 
   d="scan'208";a="313196167"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2022 17:46:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,364,1635231600"; 
   d="scan'208";a="492319611"
Received: from lkp-server01.sh.intel.com (HELO d95dc2dabeb1) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 12 Feb 2022 17:46:41 -0800
Received: from kbuild by d95dc2dabeb1 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nJ3yK-0006sW-Od; Sun, 13 Feb 2022 01:46:40 +0000
Date:   Sun, 13 Feb 2022 09:46:33 +0800
From:   kernel test robot <lkp@intel.com>
To:     Chris Down <chris@chrisdown.name>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Petr Mladek <pmladek@suse.com>
Subject: arch/parisc/math-emu/driver.c:88:17: sparse: sparse: Using plain
 integer as NULL pointer
Message-ID: <202202130955.JyBizoU1-lkp@intel.com>
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

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   b81b1829e7e39f6cebdf6e4d5484eacbceda8554
commit: 337015573718b161891a3473d25f59273f2e626b printk: Userspace format indexing support
date:   7 months ago
config: parisc-randconfig-s031-20220213 (https://download.01.org/0day-ci/archive/20220213/202202130955.JyBizoU1-lkp@intel.com/config)
compiler: hppa-linux-gcc (GCC) 11.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=337015573718b161891a3473d25f59273f2e626b
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 337015573718b161891a3473d25f59273f2e626b
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=parisc SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
>> arch/parisc/math-emu/driver.c:88:17: sparse: sparse: Using plain integer as NULL pointer
>> arch/parisc/math-emu/driver.c:88:17: sparse: sparse: Using plain integer as NULL pointer
>> arch/parisc/math-emu/driver.c:88:17: sparse: sparse: Using plain integer as NULL pointer
   arch/parisc/math-emu/driver.c:90:17: sparse: sparse: Using plain integer as NULL pointer
   arch/parisc/math-emu/driver.c:90:17: sparse: sparse: Using plain integer as NULL pointer
   arch/parisc/math-emu/driver.c:90:17: sparse: sparse: Using plain integer as NULL pointer
   arch/parisc/math-emu/driver.c:93:22: sparse: sparse: undefined identifier 'decode_fpu'

vim +88 arch/parisc/math-emu/driver.c

^1da177e4c3f41 Linus Torvalds 2005-04-16  64  
^1da177e4c3f41 Linus Torvalds 2005-04-16  65  /* Handle a floating point exception.  Return zero if the faulting
^1da177e4c3f41 Linus Torvalds 2005-04-16  66     instruction can be completed successfully. */
^1da177e4c3f41 Linus Torvalds 2005-04-16  67  int
^1da177e4c3f41 Linus Torvalds 2005-04-16  68  handle_fpe(struct pt_regs *regs)
^1da177e4c3f41 Linus Torvalds 2005-04-16  69  {
^1da177e4c3f41 Linus Torvalds 2005-04-16  70  	extern void printbinary(unsigned long x, int nbits);
^1da177e4c3f41 Linus Torvalds 2005-04-16  71  	unsigned int orig_sw, sw;
^1da177e4c3f41 Linus Torvalds 2005-04-16  72  	int signalcode;
^1da177e4c3f41 Linus Torvalds 2005-04-16  73  	/* need an intermediate copy of float regs because FPU emulation
^1da177e4c3f41 Linus Torvalds 2005-04-16  74  	 * code expects an artificial last entry which contains zero
^1da177e4c3f41 Linus Torvalds 2005-04-16  75  	 *
^1da177e4c3f41 Linus Torvalds 2005-04-16  76  	 * also, the passed in fr registers contain one word that defines
^1da177e4c3f41 Linus Torvalds 2005-04-16  77  	 * the fpu type. the fpu type information is constructed 
^1da177e4c3f41 Linus Torvalds 2005-04-16  78  	 * inside the emulation code
^1da177e4c3f41 Linus Torvalds 2005-04-16  79  	 */
^1da177e4c3f41 Linus Torvalds 2005-04-16  80  	__u64 frcopy[36];
^1da177e4c3f41 Linus Torvalds 2005-04-16  81  
^1da177e4c3f41 Linus Torvalds 2005-04-16  82  	memcpy(frcopy, regs->fr, sizeof regs->fr);
^1da177e4c3f41 Linus Torvalds 2005-04-16  83  	frcopy[32] = 0;
^1da177e4c3f41 Linus Torvalds 2005-04-16  84  
^1da177e4c3f41 Linus Torvalds 2005-04-16  85  	memcpy(&orig_sw, frcopy, sizeof(orig_sw));
^1da177e4c3f41 Linus Torvalds 2005-04-16  86  
^1da177e4c3f41 Linus Torvalds 2005-04-16  87  	if (FPUDEBUG) {
^1da177e4c3f41 Linus Torvalds 2005-04-16 @88  		printk(KERN_DEBUG "FP VZOUICxxxxCQCQCQCQCQCRMxxTDVZOUI ->\n   ");

:::::: The code at line 88 was first introduced by commit
:::::: 1da177e4c3f41524e886b7f1b8a0c1fc7321cac2 Linux-2.6.12-rc2

:::::: TO: Linus Torvalds <torvalds@ppc970.osdl.org>
:::::: CC: Linus Torvalds <torvalds@ppc970.osdl.org>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
