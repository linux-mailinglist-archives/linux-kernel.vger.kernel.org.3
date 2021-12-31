Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FC214825EB
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Dec 2021 22:55:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231816AbhLaVxR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Dec 2021 16:53:17 -0500
Received: from mga06.intel.com ([134.134.136.31]:32326 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231792AbhLaVxQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Dec 2021 16:53:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640987596; x=1672523596;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=vFqB35F2RBg9EW9yu70MXseKfSxWAPn5bfqZYqrbp/M=;
  b=kOvXSTOHmKwCYyF2nmooL3EuVW5rIAZFNjJZq1UH0a6D1ddCr1CYcKcF
   zcDGNQAJUhiY+NeXShKzAb/z6JPK9Nq3cioyN+aq/4GJKGZsEosQJVYIW
   cWHMX8Y3XDH2oWgYeeKuQSi17Cuea5TtgENrZUWYfHBGvlK+xRzd1/7vn
   AVWwCd9WOBbol1kzdWOzoRP8WT2huobn3U6pMMJjBlQ+p+SiWIeZORnJd
   ZgADZx0B+TbwdW9dtWYk1QYr5ppwyKwp/V5c+C/8T6x1MHJ8VWcgNC+gA
   0t67RFQANfgBKhSpNXITijYIH/rkZFcoqafydWpjkGjZ595g3OkbC/H2B
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10213"; a="302598391"
X-IronPort-AV: E=Sophos;i="5.88,252,1635231600"; 
   d="scan'208";a="302598391"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Dec 2021 13:53:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,252,1635231600"; 
   d="scan'208";a="687580785"
Received: from lkp-server01.sh.intel.com (HELO e357b3ef1427) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 31 Dec 2021 13:53:14 -0800
Received: from kbuild by e357b3ef1427 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n3Ppp-000BiF-LT; Fri, 31 Dec 2021 21:53:13 +0000
Date:   Sat, 1 Jan 2022 05:53:04 +0800
From:   kernel test robot <lkp@intel.com>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: arch/powerpc/platforms/52xx/lite5200_pm.c:215:9: error: implicit
 declaration of function 'enable_kernel_fp'
Message-ID: <202201010554.xCKQH2XW-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christophe,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   1b4e3f26f9f7553b260b8aed43967500961448a6
commit: 7d68c89169508064c460a1208f38ed0589d226fa powerpc/32s: Allow deselecting CONFIG_PPC_FPU on mpc832x
date:   1 year, 1 month ago
config: powerpc-randconfig-r034-20220101 (https://download.01.org/0day-ci/archive/20220101/202201010554.xCKQH2XW-lkp@intel.com/config)
compiler: powerpc-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=7d68c89169508064c460a1208f38ed0589d226fa
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 7d68c89169508064c460a1208f38ed0589d226fa
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=powerpc SHELL=/bin/bash arch/powerpc/platforms/52xx/ arch/powerpc/platforms/83xx/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   arch/powerpc/platforms/52xx/lite5200_pm.c: In function 'lite5200_pm_enter':
>> arch/powerpc/platforms/52xx/lite5200_pm.c:215:9: error: implicit declaration of function 'enable_kernel_fp' [-Werror=implicit-function-declaration]
     215 |         enable_kernel_fp();
         |         ^~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors
--
   arch/powerpc/platforms/83xx/suspend.c: In function 'mpc83xx_suspend_enter':
>> arch/powerpc/platforms/83xx/suspend.c:210:17: error: implicit declaration of function 'enable_kernel_fp' [-Werror=implicit-function-declaration]
     210 |                 enable_kernel_fp();
         |                 ^~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors


vim +/enable_kernel_fp +215 arch/powerpc/platforms/52xx/lite5200_pm.c

ee983079ce0464 Domen Puncer 2007-07-18  204  
ee983079ce0464 Domen Puncer 2007-07-18  205  static int lite5200_pm_enter(suspend_state_t state)
ee983079ce0464 Domen Puncer 2007-07-18  206  {
ee983079ce0464 Domen Puncer 2007-07-18  207  	/* deep sleep? let mpc52xx code handle that */
ee983079ce0464 Domen Puncer 2007-07-18  208  	if (state == PM_SUSPEND_STANDBY) {
ee983079ce0464 Domen Puncer 2007-07-18  209  		return mpc52xx_pm_enter(state);
ee983079ce0464 Domen Puncer 2007-07-18  210  	}
ee983079ce0464 Domen Puncer 2007-07-18  211  
ee983079ce0464 Domen Puncer 2007-07-18  212  	lite5200_save_regs();
ee983079ce0464 Domen Puncer 2007-07-18  213  
ee983079ce0464 Domen Puncer 2007-07-18  214  	/* effectively save FP regs */
ee983079ce0464 Domen Puncer 2007-07-18 @215  	enable_kernel_fp();
ee983079ce0464 Domen Puncer 2007-07-18  216  
ee983079ce0464 Domen Puncer 2007-07-18  217  	lite5200_low_power(sram, mbar);
ee983079ce0464 Domen Puncer 2007-07-18  218  
ee983079ce0464 Domen Puncer 2007-07-18  219  	lite5200_restore_regs();
ee983079ce0464 Domen Puncer 2007-07-18  220  
ee983079ce0464 Domen Puncer 2007-07-18  221  	iounmap(mbar);
ee983079ce0464 Domen Puncer 2007-07-18  222  	return 0;
ee983079ce0464 Domen Puncer 2007-07-18  223  }
ee983079ce0464 Domen Puncer 2007-07-18  224  

:::::: The code at line 215 was first introduced by commit
:::::: ee983079ce04641523b23b8ed02cc3503632351e [POWERPC] MPC5200 low power mode

:::::: TO: Domen Puncer <domen.puncer@telargo.com>
:::::: CC: Paul Mackerras <paulus@samba.org>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
