Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31F85510D0E
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 02:12:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356330AbiD0AP0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 20:15:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbiD0APY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 20:15:24 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E43AD674F6
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 17:12:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651018335; x=1682554335;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Ury4VdwSQsDodp4f25n7Xu3PDGnTqO8MNEhf4xqtxXY=;
  b=dJ3LsCLdCJpqxC8uzghtlXoanaX84lb9ncao3pQBEKxmC2nCxCUqfXCG
   BI5dWjKBF/5wQOhHUq3bWTJNHuMPXrysv0uB13X4Aha+HmryVKlGZENC0
   a7D4QZp9ABg1zemcxfEmt9iiOIJjJaZ5JRUEF73NyPaWKPQ5YqrvVhmb6
   tDU3ef68X09ecqXTpvFdqHkgo7evP6nw5gLf48onO7pwNuR93o9mHFU6h
   ZH/oYK4nAEa1VLeS6eOMgb2f0AxdKPYjYFNY5ye7POM12DPgcg6WZV+py
   7dHbUUf9WPTuQIAqEELmRezvwLZ7mJ2XNPk4an5p1p7W7GS/cOD88JyXp
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10329"; a="265286149"
X-IronPort-AV: E=Sophos;i="5.90,292,1643702400"; 
   d="scan'208";a="265286149"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2022 17:12:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,292,1643702400"; 
   d="scan'208";a="539224823"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 26 Apr 2022 17:12:14 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1njVHx-00046c-AR;
        Wed, 27 Apr 2022 00:12:13 +0000
Date:   Wed, 27 Apr 2022 08:11:25 +0800
From:   kernel test robot <lkp@intel.com>
To:     Chris Down <chris@chrisdown.name>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Petr Mladek <pmladek@suse.com>
Subject: arch/parisc/math-emu/driver.c:88:17: sparse: sparse: Using plain
 integer as NULL pointer
Message-ID: <202204270842.rABI2ERb-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   cf424ef014ac30b0da27125dd1fbdf10b0d3a520
commit: 337015573718b161891a3473d25f59273f2e626b printk: Userspace format indexing support
date:   9 months ago
config: parisc-randconfig-s031-20220425 (https://download.01.org/0day-ci/archive/20220427/202204270842.rABI2ERb-lkp@intel.com/config)
compiler: hppa-linux-gcc (GCC) 11.3.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=337015573718b161891a3473d25f59273f2e626b
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 337015573718b161891a3473d25f59273f2e626b
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=parisc SHELL=/bin/bash

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

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
