Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA9E053D743
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Jun 2022 16:37:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236920AbiFDOhs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Jun 2022 10:37:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236840AbiFDOhn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jun 2022 10:37:43 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C363C1C918
        for <linux-kernel@vger.kernel.org>; Sat,  4 Jun 2022 07:37:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654353461; x=1685889461;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=f2V/ymNlX/Fb8qfD/ShFKyEi+mN2l0NI0+vAL5qSiZc=;
  b=CLnn0tiE41RGM26kDsehpDAPWIBEh8UIKd+suFE7ffad/anU5aWWGACj
   To0CJ57f4SRp3RP0xe2zRglvd6tSGwQN3Yhq9VXzUycI0sYI7OZzJP4Mp
   1vfbGyL33sK1kWAQb/AH9d30ECXMEDVzL9iSk0lLsldY/sksZr6vAnEE8
   7P7SiP54/95r709uasSoKi/4KN1tXQbCyXRb6rcSqNkR3JINRev5z511U
   t+kgej2lBqeBRKt/lpIMASK91+jbSyky6H3dcDsmYDLro+Gvn8rubL1Bd
   7iI52kXOv/wcemS9s6JA60g1QnjRJkLacZ9da/JkoJKt0AMRjtUZ2weL/
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10368"; a="276506584"
X-IronPort-AV: E=Sophos;i="5.91,277,1647327600"; 
   d="scan'208";a="276506584"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2022 07:37:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,277,1647327600"; 
   d="scan'208";a="757872650"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 04 Jun 2022 07:37:39 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nxUuJ-000Awp-54;
        Sat, 04 Jun 2022 14:37:39 +0000
Date:   Sat, 4 Jun 2022 22:36:40 +0800
From:   kernel test robot <lkp@intel.com>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Rich Felker <dalias@libc.org>
Subject: arch/sh/kernel/traps_32.c:574:9: sparse: sparse: incorrect type in
 initializer (different address spaces)
Message-ID: <202206042243.Lmt7DB09-lkp@intel.com>
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
head:   032dcf09e2bf7c822be25b4abef7a6c913870d98
commit: ca42bc4b7bda7c6d68f1cc97c27fc8ff7385c4c7 sh: fix trivial misannotations
date:   9 months ago
config: sh-randconfig-s031-20220603 (https://download.01.org/0day-ci/archive/20220604/202206042243.Lmt7DB09-lkp@intel.com/config)
compiler: sh4-linux-gcc (GCC) 11.3.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-18-g56afb504-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=ca42bc4b7bda7c6d68f1cc97c27fc8ff7385c4c7
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout ca42bc4b7bda7c6d68f1cc97c27fc8ff7385c4c7
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=sh SHELL=/bin/bash arch/sh/kernel/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
>> arch/sh/kernel/traps_32.c:574:9: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned short const [noderef] __user *__gu_addr @@     got unsigned short * @@
   arch/sh/kernel/traps_32.c:574:9: sparse:     expected unsigned short const [noderef] __user *__gu_addr
   arch/sh/kernel/traps_32.c:574:9: sparse:     got unsigned short *
   arch/sh/kernel/traps_32.c:563:5: sparse: sparse: symbol 'is_dsp_inst' was not declared. Should it be static?

vim +574 arch/sh/kernel/traps_32.c

^1da177e4c3f41 arch/sh/kernel/traps.c Linus Torvalds 2005-04-16  558  
^1da177e4c3f41 arch/sh/kernel/traps.c Linus Torvalds 2005-04-16  559  #ifdef CONFIG_SH_DSP
^1da177e4c3f41 arch/sh/kernel/traps.c Linus Torvalds 2005-04-16  560  /*
^1da177e4c3f41 arch/sh/kernel/traps.c Linus Torvalds 2005-04-16  561   *	SH-DSP support gerg@snapgear.com.
^1da177e4c3f41 arch/sh/kernel/traps.c Linus Torvalds 2005-04-16  562   */
^1da177e4c3f41 arch/sh/kernel/traps.c Linus Torvalds 2005-04-16  563  int is_dsp_inst(struct pt_regs *regs)
^1da177e4c3f41 arch/sh/kernel/traps.c Linus Torvalds 2005-04-16  564  {
882c12c4e1a95e arch/sh/kernel/traps.c Paul Mundt     2007-05-14  565  	unsigned short inst = 0;
^1da177e4c3f41 arch/sh/kernel/traps.c Linus Torvalds 2005-04-16  566  
^1da177e4c3f41 arch/sh/kernel/traps.c Linus Torvalds 2005-04-16  567  	/*
^1da177e4c3f41 arch/sh/kernel/traps.c Linus Torvalds 2005-04-16  568  	 * Safe guard if DSP mode is already enabled or we're lacking
^1da177e4c3f41 arch/sh/kernel/traps.c Linus Torvalds 2005-04-16  569  	 * the DSP altogether.
^1da177e4c3f41 arch/sh/kernel/traps.c Linus Torvalds 2005-04-16  570  	 */
11c1965687b0a4 arch/sh/kernel/traps.c Paul Mundt     2006-12-25  571  	if (!(current_cpu_data.flags & CPU_HAS_DSP) || (regs->sr & SR_DSP))
^1da177e4c3f41 arch/sh/kernel/traps.c Linus Torvalds 2005-04-16  572  		return 0;
^1da177e4c3f41 arch/sh/kernel/traps.c Linus Torvalds 2005-04-16  573  
^1da177e4c3f41 arch/sh/kernel/traps.c Linus Torvalds 2005-04-16 @574  	get_user(inst, ((unsigned short *) regs->pc));
^1da177e4c3f41 arch/sh/kernel/traps.c Linus Torvalds 2005-04-16  575  
^1da177e4c3f41 arch/sh/kernel/traps.c Linus Torvalds 2005-04-16  576  	inst &= 0xf000;
^1da177e4c3f41 arch/sh/kernel/traps.c Linus Torvalds 2005-04-16  577  
^1da177e4c3f41 arch/sh/kernel/traps.c Linus Torvalds 2005-04-16  578  	/* Check for any type of DSP or support instruction */
^1da177e4c3f41 arch/sh/kernel/traps.c Linus Torvalds 2005-04-16  579  	if ((inst == 0xf000) || (inst == 0x4000))
^1da177e4c3f41 arch/sh/kernel/traps.c Linus Torvalds 2005-04-16  580  		return 1;
^1da177e4c3f41 arch/sh/kernel/traps.c Linus Torvalds 2005-04-16  581  
^1da177e4c3f41 arch/sh/kernel/traps.c Linus Torvalds 2005-04-16  582  	return 0;
^1da177e4c3f41 arch/sh/kernel/traps.c Linus Torvalds 2005-04-16  583  }
^1da177e4c3f41 arch/sh/kernel/traps.c Linus Torvalds 2005-04-16  584  #else
^1da177e4c3f41 arch/sh/kernel/traps.c Linus Torvalds 2005-04-16  585  #define is_dsp_inst(regs)	(0)
^1da177e4c3f41 arch/sh/kernel/traps.c Linus Torvalds 2005-04-16  586  #endif /* CONFIG_SH_DSP */
^1da177e4c3f41 arch/sh/kernel/traps.c Linus Torvalds 2005-04-16  587  

:::::: The code at line 574 was first introduced by commit
:::::: 1da177e4c3f41524e886b7f1b8a0c1fc7321cac2 Linux-2.6.12-rc2

:::::: TO: Linus Torvalds <torvalds@ppc970.osdl.org>
:::::: CC: Linus Torvalds <torvalds@ppc970.osdl.org>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
