Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BB8A58B9CD
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Aug 2022 08:35:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232673AbiHGGe2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Aug 2022 02:34:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbiHGGe0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Aug 2022 02:34:26 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87A20959F
        for <linux-kernel@vger.kernel.org>; Sat,  6 Aug 2022 23:34:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659854065; x=1691390065;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Ccu78lD+IzvBx6GoQ3n0/nxcbH1B8brsl6rDIlinm4A=;
  b=k0LtzMZR1xuDGh5EvzndNJe0sa8/0XvaPQTfYPkM9CMDGAXcE1esn40b
   IK2fd2VF4yDGsOdpt8wUBNL3a0hSuO1UHWS9p5mkRgq4JkcNuXyIdl+rk
   2BoeP5fPuBJQf7jZRJwGf9Xv4W01aQK39qecoZFBrtJHLJd5PnD9X98KJ
   0t9kCkgkrd4gBYMHkehRuwEa4zanxgnNcY1sm6wyfxr9XlxaDuY/mtlOu
   GLqvSkZPYmTykR5y6VzcGtrEiJGeg306/fC9Q3tIl+F7T3jidqyoqtUzw
   7ay8M3QYXULzEeMYgwJ7TutUMnJyeSDu1VQRbm+tKfrk0/xCZfogluKjF
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10431"; a="287979054"
X-IronPort-AV: E=Sophos;i="5.93,219,1654585200"; 
   d="scan'208";a="287979054"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2022 23:34:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,219,1654585200"; 
   d="scan'208";a="632486108"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 06 Aug 2022 23:34:23 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oKZrj-000L3p-0G;
        Sun, 07 Aug 2022 06:34:23 +0000
Date:   Sun, 7 Aug 2022 14:34:13 +0800
From:   kernel test robot <lkp@intel.com>
To:     Chris Down <chris@chrisdown.name>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Petr Mladek <pmladek@suse.com>
Subject: arch/parisc/math-emu/driver.c:88:17: sparse: sparse: Using plain
 integer as NULL pointer
Message-ID: <202208071455.JpZGTtus-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   1612c382ffbdf1f673caec76502b1c00e6d35363
commit: 337015573718b161891a3473d25f59273f2e626b printk: Userspace format indexing support
date:   1 year, 1 month ago
config: parisc-randconfig-s052-20220805 (https://download.01.org/0day-ci/archive/20220807/202208071455.JpZGTtus-lkp@intel.com/config)
compiler: hppa64-linux-gcc (GCC) 12.1.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-39-gce1a6720-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=337015573718b161891a3473d25f59273f2e626b
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 337015573718b161891a3473d25f59273f2e626b
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=parisc SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
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
