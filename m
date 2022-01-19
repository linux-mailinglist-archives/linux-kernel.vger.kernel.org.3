Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7D904934F8
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 07:28:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351777AbiASG2X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 01:28:23 -0500
Received: from mga03.intel.com ([134.134.136.65]:41001 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1351700AbiASG2W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 01:28:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642573702; x=1674109702;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=WWPpMqAPxPCuRbsA26zAD576Bp3HmOEprdaixSO8FCA=;
  b=JNWX3y3rre15r7bblziG4+7H40H/Lq46vWvMCh+DJK9sWZrBv27O9IqR
   oWddKskfY2fOBs4QwEAZyWw0lr6W/oKDO+d30Z4elr0V9chIxZYHVKRtM
   vfUB+I6oXMVj9EEeJk9zK+lQgfjc5vWT03d9OIKTXTEGrc2zaCQmZOYt9
   rIGwwX3aP3yu0vJxqAZFcRL+2w0jVKm5mMJqN5PTjBqkCC2JO6fXkn6r8
   TyxzAAavAsYGMIbncQnoIMC29a/fU6hLdufybfwWm67N8jVkKkaQkBqGH
   dPND68cBT8UAnXIEU0KPyVbQNufDT4NwgVukrK8q31pfNbwFh8IyVTCOS
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10231"; a="244954019"
X-IronPort-AV: E=Sophos;i="5.88,299,1635231600"; 
   d="scan'208";a="244954019"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2022 22:28:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,299,1635231600"; 
   d="scan'208";a="625773243"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 18 Jan 2022 22:28:20 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nA4SC-000DL2-9w; Wed, 19 Jan 2022 06:28:20 +0000
Date:   Wed, 19 Jan 2022 14:27:34 +0800
From:   kernel test robot <lkp@intel.com>
To:     Emil Renner Berthing <kernel@esmil.dk>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [esmil:visionfive 75/80]
 drivers/soc/sifive/sifive_l2_cache.c:157:17: error: implicit declaration of
 function 'writeq'; did you mean 'writeb'?
Message-ID: <202201191446.e8ud7CAP-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/esmil/linux visionfive
head:   e46c3a7e373e6faa03399f1a41c29cf7546c37cb
commit: 37af0be028777ba2227a48b8d94ff92f52f7aba7 [75/80] RISC-V: Enable SIFIVE_L2_FLUSH for StarFive SoCs
config: riscv-randconfig-r002-20220118 (https://download.01.org/0day-ci/archive/20220119/202201191446.e8ud7CAP-lkp@intel.com/config)
compiler: riscv32-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/esmil/linux/commit/37af0be028777ba2227a48b8d94ff92f52f7aba7
        git remote add esmil https://github.com/esmil/linux
        git fetch --no-tags esmil visionfive
        git checkout 37af0be028777ba2227a48b8d94ff92f52f7aba7
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=riscv SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   drivers/soc/sifive/sifive_l2_cache.c: In function 'sifive_l2_flush64_range':
>> drivers/soc/sifive/sifive_l2_cache.c:157:17: error: implicit declaration of function 'writeq'; did you mean 'writeb'? [-Werror=implicit-function-declaration]
     157 |                 writeq(line, l2_base + SIFIVE_L2_FLUSH64);
         |                 ^~~~~~
         |                 writeb
   cc1: some warnings being treated as errors


vim +157 drivers/soc/sifive/sifive_l2_cache.c

a967a289f16969 arch/riscv/mm/sifive_l2_cache.c      Yash Shah          2019-05-06  125  
d21f24663c127e drivers/soc/sifive/sifive_l2_cache.c Tom                2021-01-08  126  #ifdef CONFIG_SIFIVE_L2_FLUSH
d21f24663c127e drivers/soc/sifive/sifive_l2_cache.c Tom                2021-01-08  127  void sifive_l2_flush64_range(unsigned long start, unsigned long len)
d21f24663c127e drivers/soc/sifive/sifive_l2_cache.c Tom                2021-01-08  128  {
d21f24663c127e drivers/soc/sifive/sifive_l2_cache.c Tom                2021-01-08  129  	unsigned long line;
d21f24663c127e drivers/soc/sifive/sifive_l2_cache.c Tom                2021-01-08  130  
d21f24663c127e drivers/soc/sifive/sifive_l2_cache.c Tom                2021-01-08  131  	if(!l2_base) {
d21f24663c127e drivers/soc/sifive/sifive_l2_cache.c Tom                2021-01-08  132  		pr_warn("L2CACHE: base addr invalid, skipping flush\n");
d21f24663c127e drivers/soc/sifive/sifive_l2_cache.c Tom                2021-01-08  133  		return;
d21f24663c127e drivers/soc/sifive/sifive_l2_cache.c Tom                2021-01-08  134  	}
d21f24663c127e drivers/soc/sifive/sifive_l2_cache.c Tom                2021-01-08  135  
d21f24663c127e drivers/soc/sifive/sifive_l2_cache.c Tom                2021-01-08  136  	/* TODO: if (len == 0), skipping flush or going on? */
d21f24663c127e drivers/soc/sifive/sifive_l2_cache.c Tom                2021-01-08  137  	if(!len) {
d21f24663c127e drivers/soc/sifive/sifive_l2_cache.c Tom                2021-01-08  138  		pr_debug("L2CACHE: flush64 range @ 0x%lx(len:0)\n", start);
d21f24663c127e drivers/soc/sifive/sifive_l2_cache.c Tom                2021-01-08  139  		return;
d21f24663c127e drivers/soc/sifive/sifive_l2_cache.c Tom                2021-01-08  140  	}
d21f24663c127e drivers/soc/sifive/sifive_l2_cache.c Tom                2021-01-08  141  
09426958620627 drivers/soc/sifive/sifive_l2_cache.c Atish Patra        2021-06-12  142  	len = len + (start % SIFIVE_L2_FLUSH64_LINE_LEN);
09426958620627 drivers/soc/sifive/sifive_l2_cache.c Atish Patra        2021-06-12  143  	start = ALIGN_DOWN(start, SIFIVE_L2_FLUSH64_LINE_LEN);
09426958620627 drivers/soc/sifive/sifive_l2_cache.c Atish Patra        2021-06-12  144  
d21f24663c127e drivers/soc/sifive/sifive_l2_cache.c Tom                2021-01-08  145  	/* make sure the address is in the range */
d21f24663c127e drivers/soc/sifive/sifive_l2_cache.c Tom                2021-01-08  146  	if(start < CONFIG_SIFIVE_L2_FLUSH_START ||
d21f24663c127e drivers/soc/sifive/sifive_l2_cache.c Tom                2021-01-08  147  	   (start + len) > (CONFIG_SIFIVE_L2_FLUSH_START +
d21f24663c127e drivers/soc/sifive/sifive_l2_cache.c Tom                2021-01-08  148  			     CONFIG_SIFIVE_L2_FLUSH_SIZE)) {
36921b04361a57 drivers/soc/sifive/sifive_l2_cache.c Geert Uytterhoeven 2021-05-21  149  		WARN(1, "L2CACHE: flush64 out of range: %lx(%lx), skip flush\n",
d21f24663c127e drivers/soc/sifive/sifive_l2_cache.c Tom                2021-01-08  150  		     start, len);
d21f24663c127e drivers/soc/sifive/sifive_l2_cache.c Tom                2021-01-08  151  		return;
d21f24663c127e drivers/soc/sifive/sifive_l2_cache.c Tom                2021-01-08  152  	}
d21f24663c127e drivers/soc/sifive/sifive_l2_cache.c Tom                2021-01-08  153  
d21f24663c127e drivers/soc/sifive/sifive_l2_cache.c Tom                2021-01-08  154  	mb();	/* sync */
d21f24663c127e drivers/soc/sifive/sifive_l2_cache.c Tom                2021-01-08  155  	for (line = start; line < start + len;
d21f24663c127e drivers/soc/sifive/sifive_l2_cache.c Tom                2021-01-08  156  	     line += SIFIVE_L2_FLUSH64_LINE_LEN) {
d21f24663c127e drivers/soc/sifive/sifive_l2_cache.c Tom                2021-01-08 @157  		writeq(line, l2_base + SIFIVE_L2_FLUSH64);
d21f24663c127e drivers/soc/sifive/sifive_l2_cache.c Tom                2021-01-08  158  		mb();
d21f24663c127e drivers/soc/sifive/sifive_l2_cache.c Tom                2021-01-08  159  	}
d21f24663c127e drivers/soc/sifive/sifive_l2_cache.c Tom                2021-01-08  160  }
d21f24663c127e drivers/soc/sifive/sifive_l2_cache.c Tom                2021-01-08  161  EXPORT_SYMBOL_GPL(sifive_l2_flush64_range);
d21f24663c127e drivers/soc/sifive/sifive_l2_cache.c Tom                2021-01-08  162  #endif
d21f24663c127e drivers/soc/sifive/sifive_l2_cache.c Tom                2021-01-08  163  

:::::: The code at line 157 was first introduced by commit
:::::: d21f24663c127ec288f925cd991a1d767e1dd609 sifive/sifive_l2_cache: Add sifive_l2_flush64_range function

:::::: TO: Tom <support@vamrs.com>
:::::: CC: Emil Renner Berthing <kernel@esmil.dk>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
