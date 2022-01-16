Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D965148FF9B
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 00:18:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236417AbiAPXQT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Jan 2022 18:16:19 -0500
Received: from mga14.intel.com ([192.55.52.115]:20948 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232895AbiAPXQS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jan 2022 18:16:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642374978; x=1673910978;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=7nuGFaA+TDZxoxKOzdPqVEtDKkMdy2FHfC6SCyKF+Zs=;
  b=Xg0dOJWfi/tCQ38/lE6mIZ5BfeoVjYFqNh1eFmDABf8sL/gpoPrifZ5B
   1JmJpNgGnwNXDRvLIQNg+WCy/3aPgQP//JsXD1i3rRsvuf54tC7pE/q1D
   Hw4XMhFU1vRlmPWzVpMlgIH46XvIta9zg92NLvkEYvlIeE5T4qeazJnbJ
   HkacWDnuFSZ1F6FTjdeDIznzIg9PGAPJ19+eOzXKaSNKrix/TPDxo8cr3
   V5ottxhbX87x3AaQLg2ZG08L8cnDbz9W6MCBzaGXilBSKpgf5Bd94tsha
   OU3GDAg5rEV7QyhaD5mCMLgqJ9t97m7wZ1vlZpWcXmCI3WF12wKXorezc
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10229"; a="244718685"
X-IronPort-AV: E=Sophos;i="5.88,293,1635231600"; 
   d="scan'208";a="244718685"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2022 15:16:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,293,1635231600"; 
   d="scan'208";a="531108795"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 16 Jan 2022 15:16:16 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n9Eky-000B2m-8E; Sun, 16 Jan 2022 23:16:16 +0000
Date:   Mon, 17 Jan 2022 07:15:52 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [mingo-tip:sched/headers 1617/2384]
 arch/mips/alchemy/common/clock.c:143:2: error: use of undeclared identifier
 'preset_lpj'
Message-ID: <202201170727.IDnTpMbA-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git sched/headers
head:   4c707c1c0de83967079b4e385012fa5b00e2cd11
commit: 4a1f9d16bf267958eefcbac668167e6135f75621 [1617/2384] headers/deps: ktime: Remove the <linux/ktime_api.h> header from <linux/ktime.h>
config: mips-randconfig-c004-20220116 (https://download.01.org/0day-ci/archive/20220117/202201170727.IDnTpMbA-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project c63a3175c2947e8c1a2d3bbe16a8586600705c54)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install mips cross compiling tool for clang build
        # apt-get install binutils-mips-linux-gnu
        # https://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git/commit/?id=4a1f9d16bf267958eefcbac668167e6135f75621
        git remote add mingo-tip git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git
        git fetch --no-tags mingo-tip sched/headers
        git checkout 4a1f9d16bf267958eefcbac668167e6135f75621
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=mips SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> arch/mips/alchemy/common/clock.c:143:2: error: use of undeclared identifier 'preset_lpj'
           preset_lpj = alchemy_clk_cpu_recalc(NULL, ALCHEMY_ROOTCLK_RATE);
           ^
   arch/mips/alchemy/common/clock.c:144:2: error: use of undeclared identifier 'preset_lpj'
           preset_lpj /= 2 * HZ;
           ^
   arch/mips/alchemy/common/clock.c:141:13: warning: no previous prototype for function 'alchemy_set_lpj' [-Wmissing-prototypes]
   void __init alchemy_set_lpj(void)
               ^
   arch/mips/alchemy/common/clock.c:141:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void __init alchemy_set_lpj(void)
   ^
   static 
   arch/mips/alchemy/common/clock.c:554:31: warning: variable 'ret' set but not used [-Wunused-but-set-variable]
           unsigned long div, v, flags, ret;
                                        ^
   arch/mips/alchemy/common/clock.c:676:31: warning: variable 'ret' set but not used [-Wunused-but-set-variable]
           unsigned long div, v, flags, ret;
                                        ^
   3 warnings and 2 errors generated.


vim +/preset_lpj +143 arch/mips/alchemy/common/clock.c

474402291a0ad4 Manuel Lauss 2014-07-23  140  
45a848f7fa067a Manuel Lauss 2015-01-29  141  void __init alchemy_set_lpj(void)
45a848f7fa067a Manuel Lauss 2015-01-29  142  {
45a848f7fa067a Manuel Lauss 2015-01-29 @143  	preset_lpj = alchemy_clk_cpu_recalc(NULL, ALCHEMY_ROOTCLK_RATE);
45a848f7fa067a Manuel Lauss 2015-01-29  144  	preset_lpj /= 2 * HZ;
45a848f7fa067a Manuel Lauss 2015-01-29  145  }
45a848f7fa067a Manuel Lauss 2015-01-29  146  

:::::: The code at line 143 was first introduced by commit
:::::: 45a848f7fa067a81ae606bb06b2edcdf53772eac MIPS: Alchemy: preset loops_per_jiffy based on CPU clock

:::::: TO: Manuel Lauss <manuel.lauss@gmail.com>
:::::: CC: Ralf Baechle <ralf@linux-mips.org>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
