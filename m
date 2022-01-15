Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE6BE48F88F
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jan 2022 18:55:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232527AbiAORze (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Jan 2022 12:55:34 -0500
Received: from mga17.intel.com ([192.55.52.151]:24833 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232372AbiAORzc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jan 2022 12:55:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642269332; x=1673805332;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=H4ls5YJV+j2NX1bdVh34pvGAGh2uvVPHjwKwQJSJucg=;
  b=ZckWY4SUmy80eWORI2vwdjFW3ReM9+JlL+bWvCZcIqdBseA4yf1Be0g3
   kjz4iVK+1KeieOv++C3zZTgGPaGTzr18ikPgZq2OzbZebyXZ2q7Fsc0hQ
   m+gPIxVOU26xqWujWM5hvtSJJilDZUN9unPskewMi+jNShN6IVrBiBW7S
   dXrvSjOlrLBLTrnvA/ez8QcdN7Dxl61z5seK5X/RNcmVMHL3uY3EjoirT
   eCaZpE8etjuVBl9XQhk7/FylwdAhyX+OLvFQdMh0TXi8P+AoaDi5e5imA
   yH0NFt0+FqkyQeK/TkucSO5ilH7nVL7epm23KE63Sseneo1st/KmOT4bR
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10228"; a="225113449"
X-IronPort-AV: E=Sophos;i="5.88,290,1635231600"; 
   d="scan'208";a="225113449"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jan 2022 09:55:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,290,1635231600"; 
   d="scan'208";a="692605382"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 15 Jan 2022 09:55:30 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n8nGz-000ABJ-R3; Sat, 15 Jan 2022 17:55:29 +0000
Date:   Sun, 16 Jan 2022 01:54:52 +0800
From:   kernel test robot <lkp@intel.com>
To:     Daniel Palmer <daniel@0x0f.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [chenxing:msc313_mainlining 62/79]
 drivers/irqchip/irq-msc313-pm-wakeup.c:21:25: error: 'field_mask' redeclared
 as different kind of symbol
Message-ID: <202201160121.tUtiMcTY-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://github.com/linux-chenxing/linux.git msc313_mainlining
head:   944e0daa939a7374dc40b73ceedb78a788fb25d4
commit: c37ce8087960dcad8436a7120a410dba3c5ded61 [62/79] irqchip: MStar wakeup intc
config: mips-allyesconfig (https://download.01.org/0day-ci/archive/20220116/202201160121.tUtiMcTY-lkp@intel.com/config)
compiler: mips-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/linux-chenxing/linux/commit/c37ce8087960dcad8436a7120a410dba3c5ded61
        git remote add chenxing git://github.com/linux-chenxing/linux.git
        git fetch --no-tags chenxing msc313_mainlining
        git checkout c37ce8087960dcad8436a7120a410dba3c5ded61
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=mips SHELL=/bin/bash drivers/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> drivers/irqchip/irq-msc313-pm-wakeup.c:21:25: error: 'field_mask' redeclared as different kind of symbol
      21 | static struct reg_field field_mask = REG_FIELD(MSTAR_PMSLEEP_WAKEUPSOURCE, 0, 7);
         |                         ^~~~~~~~~~
   In file included from arch/mips/include/asm/mips-cps.h:10,
                    from arch/mips/include/asm/smp-ops.h:16,
                    from arch/mips/include/asm/smp.h:21,
                    from include/linux/smp.h:113,
                    from include/linux/lockdep.h:14,
                    from include/linux/spinlock.h:62,
                    from include/linux/irq.h:14,
                    from drivers/irqchip/irq-msc313-pm-wakeup.c:6:
   include/linux/bitfield.h:139:28: note: previous definition of 'field_mask' with type 'u64(u64)' {aka 'long long unsigned int(long long unsigned int)'}
     139 | static __always_inline u64 field_mask(u64 field)
         |                            ^~~~~~~~~~
   drivers/irqchip/irq-msc313-pm-wakeup.c: In function 'msc313_pm_wakeup_intc_of_init':
   drivers/irqchip/irq-msc313-pm-wakeup.c:132:9: warning: ignoring return value of 'request_irq' declared with attribute 'warn_unused_result' [-Wunused-result]
     132 |         request_irq(irq, msc313_pm_wakeup_intc_chainedhandler, IRQF_SHARED,
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     133 |                                 "pmsleep", domain);
         |                                 ~~~~~~~~~~~~~~~~~~


vim +/field_mask +21 drivers/irqchip/irq-msc313-pm-wakeup.c

    20	
  > 21	static struct reg_field field_mask = REG_FIELD(MSTAR_PMSLEEP_WAKEUPSOURCE, 0, 7);
    22	static struct reg_field field_type = REG_FIELD(MSTAR_PMSLEEP_REG24, 0, 7);
    23	static struct reg_field field_status = REG_FIELD(MSTAR_PMSLEEP_WAKEINT_STATUS, 0, 7);
    24	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
