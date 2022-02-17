Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83AD24B9998
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 08:07:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235941AbiBQHHV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 02:07:21 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:56686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbiBQHHT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 02:07:19 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 839EE1B8FE4
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 23:07:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645081625; x=1676617625;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=/CMRxxgpYFcN8OCyhrZweqdmJFVzeDxEGk4XSaM1dvY=;
  b=euzoQOwYei9TldU2jeIsI9hezV9hrQDiFHQSf/ArNtVxFZlHUzgUQf9b
   RursNdGFwa97UqwgHI5mkvr4YTXWhqyUEvAi7CC1vcaiTwNMeHpwnPkz5
   8dXA52VOAceqxXcUQ1NYlhF/tZXLpFzqZPnNNloTx16qSCg5nAEi0Lz7O
   ZmMTFgH30HpQ2sxS58tu2bmIvsSSQm2VfoiS9bVUHj3pyFLX8r32vYmWL
   MfLj+E2e8O7KMbfKGkYchuXn+owtj5DA5xTmzeYT6GtE/2afcifBUnx97
   R174Sbv5MfZTX4mh0Jv15yEpdHa7ihbjbBOvwNFcxt4Z683MemN/gRHnc
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10260"; a="275398746"
X-IronPort-AV: E=Sophos;i="5.88,375,1635231600"; 
   d="scan'208";a="275398746"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2022 23:07:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,375,1635231600"; 
   d="scan'208";a="529998525"
Received: from lkp-server01.sh.intel.com (HELO d95dc2dabeb1) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 16 Feb 2022 23:07:03 -0800
Received: from kbuild by d95dc2dabeb1 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nKasZ-000BYH-1T; Thu, 17 Feb 2022 07:07:03 +0000
Date:   Thu, 17 Feb 2022 15:06:06 +0800
From:   kernel test robot <lkp@intel.com>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Rich Felker <dalias@libc.org>
Subject: arch/sh/kernel/traps_32.c:574:9: sparse: sparse: incorrect type in
 initializer (different address spaces)
Message-ID: <202202171504.3sm5Zvhs-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   f71077a4d84bbe8c7b91b7db7c4ef815755ac5e3
commit: ca42bc4b7bda7c6d68f1cc97c27fc8ff7385c4c7 sh: fix trivial misannotations
date:   5 months ago
config: sh-randconfig-s032-20220217 (https://download.01.org/0day-ci/archive/20220217/202202171504.3sm5Zvhs-lkp@intel.com/config)
compiler: sh4-linux-gcc (GCC) 11.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=ca42bc4b7bda7c6d68f1cc97c27fc8ff7385c4c7
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout ca42bc4b7bda7c6d68f1cc97c27fc8ff7385c4c7
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=sh SHELL=/bin/bash arch/sh/kernel/

If you fix the issue, kindly add following tag as appropriate
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

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
