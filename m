Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B63DD48F4B3
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jan 2022 05:18:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232410AbiAOESn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 23:18:43 -0500
Received: from mga06.intel.com ([134.134.136.31]:11412 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232403AbiAOESl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 23:18:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642220321; x=1673756321;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=eodWSsLTniy2udurew7G6Q+e//rLL+3xQMwFfyhmU4k=;
  b=W8zdDFvAm1MiKgQe0Ylz4oZs3t9hjR1Ehh16F6xSIbKeBYo00fqYY6aq
   PkBeAJk8elEgCnVxnLOyLCU6kk1PBUKy7T7TYf1oh0IVEeAtdnWL37YSp
   9zxSS+0gACK1b3rpc7jT0PcYvn6Iwj1RZq5NDcIqD4mmuKTXW82DQ9Nym
   FN0Fzh4JiJLC4ZEYO9E/+5dPw1P4xVhmXh/rOgBK4DF9OGUqhTkqGsDbV
   0E+cW6xo6IKI5QRKirpQC6aKtkjQyyakm0KeHupsRDzouvTLsDtg6cvCb
   rvVXJfhUSsXTEz3Mvl4OoeOgtNgeWqCyXcKxgeGkquksZCRUGwICa15PW
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10227"; a="305107646"
X-IronPort-AV: E=Sophos;i="5.88,290,1635231600"; 
   d="scan'208";a="305107646"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2022 20:18:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,290,1635231600"; 
   d="scan'208";a="624566071"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 14 Jan 2022 20:18:39 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n8aWV-0009Mz-83; Sat, 15 Jan 2022 04:18:39 +0000
Date:   Sat, 15 Jan 2022 12:18:03 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [mingo-tip:sched/headers 2114/2384]
 arch/mips/vr41xx/common/irq.c:105:13: error: expected '=', ',', ';', 'asm'
 or '__attribute__' before 'arch_init_irq'
Message-ID: <202201151230.NFPpJt0T-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git sched/headers
head:   4c707c1c0de83967079b4e385012fa5b00e2cd11
commit: 9b3c6ae85a5f3f3a0471ed5fba5c33471c2d9290 [2114/2384] headers/deps: irq: Optimize <linux/irq.h> dependencies, remove <linux/slab.h>
config: mips-randconfig-r034-20220113 (https://download.01.org/0day-ci/archive/20220115/202201151230.NFPpJt0T-lkp@intel.com/config)
compiler: mipsel-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git/commit/?id=9b3c6ae85a5f3f3a0471ed5fba5c33471c2d9290
        git remote add mingo-tip git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git
        git fetch --no-tags mingo-tip sched/headers
        git checkout 9b3c6ae85a5f3f3a0471ed5fba5c33471c2d9290
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=mips SHELL=/bin/bash arch/mips/vr41xx/common/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from include/linux/irq.h:19,
                    from include/linux/irqdesc.h:6,
                    from arch/mips/vr41xx/common/irq.c:7:
   arch/mips/include/asm/irq.h:23:20: error: expected '=', ',', ';', 'asm' or '__attribute__' before 'init_IRQ'
      23 | extern void __init init_IRQ(void);
         |                    ^~~~~~~~
   arch/mips/vr41xx/common/irq.c:22:5: warning: no previous prototype for 'cascade_irq' [-Wmissing-prototypes]
      22 | int cascade_irq(unsigned int irq, int (*get_irq)(unsigned int))
         |     ^~~~~~~~~~~
>> arch/mips/vr41xx/common/irq.c:105:13: error: expected '=', ',', ';', 'asm' or '__attribute__' before 'arch_init_irq'
     105 | void __init arch_init_irq(void)
         |             ^~~~~~~~~~~~~


vim +105 arch/mips/vr41xx/common/irq.c

979934da9e7a00 Yoichi Yuasa 2005-09-03  104  
979934da9e7a00 Yoichi Yuasa 2005-09-03 @105  void __init arch_init_irq(void)

:::::: The code at line 105 was first introduced by commit
:::::: 979934da9e7a0005bd9c8b1d7d00febb59ff67f7 [PATCH] mips: update IRQ handling for vr41xx

:::::: TO: Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
:::::: CC: Linus Torvalds <torvalds@evo.osdl.org>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
