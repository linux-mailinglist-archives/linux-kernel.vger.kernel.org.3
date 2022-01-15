Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B74848F52E
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jan 2022 06:39:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232538AbiAOFjr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Jan 2022 00:39:47 -0500
Received: from mga14.intel.com ([192.55.52.115]:54635 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232531AbiAOFjq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jan 2022 00:39:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642225186; x=1673761186;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=75+YhRjUaMDilg1Gnh4edLsebkubg/S5XzVviLv/oug=;
  b=dg9sJGhcyYoo7ncwz9i585M+w4jvM+S63zfzdz0V2yGbFzZA8v10OkT6
   2eJfvnZaSzQweNRJPu276tiEAG+BPVFILlLljuH6mv9oMa+UpOM51g4wj
   s7a7h2QWJM0hJUpwQLJWRDAxLKxiXUaS/BPlJ0/SPqKieCjcN6izzHynw
   W9pfyDHeWf98wPNYxUH2C3rXlhtu+Sij6wBnOxFAeevLIAWL32UbS8am1
   cpU0W15dW4rKQ57hocSggbe63HprW7ckPRTQbe1fVaOKHt81IjaccTE4e
   aNl41cawj5dCP6Oue1T05PL4M1oLcxd7DPGSDjJdUnDmr9A/oNYi1TXtn
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10227"; a="244580431"
X-IronPort-AV: E=Sophos;i="5.88,290,1635231600"; 
   d="scan'208";a="244580431"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2022 21:39:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,290,1635231600"; 
   d="scan'208";a="614559830"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 14 Jan 2022 21:39:45 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n8bmy-0009QE-La; Sat, 15 Jan 2022 05:39:44 +0000
Date:   Sat, 15 Jan 2022 13:39:17 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [mingo-tip:sched/headers 2114/2384] arch/mips/n64/irq.c:13:13:
 error: expected '=', ',', ';', 'asm' or '__attribute__' before
 'arch_init_irq'
Message-ID: <202201151359.yIVoREOh-lkp@intel.com>
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
config: mips-randconfig-r036-20220113 (https://download.01.org/0day-ci/archive/20220115/202201151359.yIVoREOh-lkp@intel.com/config)
compiler: mips-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git/commit/?id=9b3c6ae85a5f3f3a0471ed5fba5c33471c2d9290
        git remote add mingo-tip git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git
        git fetch --no-tags mingo-tip sched/headers
        git checkout 9b3c6ae85a5f3f3a0471ed5fba5c33471c2d9290
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=mips SHELL=/bin/bash arch/mips/n64/ drivers/media/rc/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from include/linux/interrupt.h:23,
                    from arch/mips/n64/irq.c:8:
   arch/mips/include/asm/irq.h:23:20: error: expected '=', ',', ';', 'asm' or '__attribute__' before 'init_IRQ'
      23 | extern void __init init_IRQ(void);
         |                    ^~~~~~~~
>> arch/mips/n64/irq.c:13:13: error: expected '=', ',', ';', 'asm' or '__attribute__' before 'arch_init_irq'
      13 | void __init arch_init_irq(void)
         |             ^~~~~~~~~~~~~


vim +13 arch/mips/n64/irq.c

baec970aa5ba11 Lauri Kasanen 2021-01-13  12  
baec970aa5ba11 Lauri Kasanen 2021-01-13 @13  void __init arch_init_irq(void)

:::::: The code at line 13 was first introduced by commit
:::::: baec970aa5ba11099ad7a91773350c91fb2113f0 mips: Add N64 machine type

:::::: TO: Lauri Kasanen <cand@gmx.com>
:::::: CC: Thomas Bogendoerfer <tsbogend@alpha.franken.de>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
