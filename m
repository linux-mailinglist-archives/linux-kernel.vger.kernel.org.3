Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBEDC481D3E
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Dec 2021 15:43:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240413AbhL3OnJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Dec 2021 09:43:09 -0500
Received: from mga12.intel.com ([192.55.52.136]:18706 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239927AbhL3OnI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Dec 2021 09:43:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640875388; x=1672411388;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=LgHddwe/83Rr07Ya4fLnIlC3D1krr+coufYjy7PdIIg=;
  b=BjMiukZrQ22O3DGV27cHI2aLmtl7t6Qu/7eJNhsOqE9dyIi1zq6N2bkd
   IL9ASWZp5PXSRy2Z3LpnVqYETHfqy3DH7CL+9cYOflSrXSuLdx9rahdp+
   YoRwTEPguzmY5XpVdpDMUrlNerAjyGQCb+IeaIVSolDD4gIHTkxUyTDaM
   v/KXtaLaPwJJ9rqI8npkHy49bf8y9T+5+HArw82k2mH8NakBa8mx/eO4y
   9imi5VPW09iqMJgoi1puyLUL4RWinXpzoRNOmRqofVzkFt5l/GHl9k0KS
   prRbto6eRwGytxx6fVTgfqkuJYps/0D6o6l428bwN0kZIR3DHaPjjQowP
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10212"; a="221683860"
X-IronPort-AV: E=Sophos;i="5.88,248,1635231600"; 
   d="scan'208";a="221683860"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Dec 2021 06:43:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,248,1635231600"; 
   d="scan'208";a="470678611"
Received: from lkp-server01.sh.intel.com (HELO e357b3ef1427) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 30 Dec 2021 06:43:06 -0800
Received: from kbuild by e357b3ef1427 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n2we2-000AHy-2S; Thu, 30 Dec 2021 14:43:06 +0000
Date:   Thu, 30 Dec 2021 22:42:45 +0800
From:   kernel test robot <lkp@intel.com>
To:     Daniel Palmer <daniel@0x0f.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [chenxing:msc313_mainlining 66/83]
 drivers/irqchip/irq-msc313-pm-wakeup.c:21:25: error: 'field_mask' redeclared
 as different kind of symbol
Message-ID: <202112302223.uJAotq1F-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://github.com/linux-chenxing/linux.git msc313_mainlining
head:   4d461524348d96538a0092563aea810f48831d8c
commit: 8745e4c4dfa051f1e8a251e07135c7768e4199d0 [66/83] irqchip: MStar wakeup intc
config: mips-allmodconfig (https://download.01.org/0day-ci/archive/20211230/202112302223.uJAotq1F-lkp@intel.com/config)
compiler: mips-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/linux-chenxing/linux/commit/8745e4c4dfa051f1e8a251e07135c7768e4199d0
        git remote add chenxing git://github.com/linux-chenxing/linux.git
        git fetch --no-tags chenxing msc313_mainlining
        git checkout 8745e4c4dfa051f1e8a251e07135c7768e4199d0
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=mips SHELL=/bin/bash drivers/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> drivers/irqchip/irq-msc313-pm-wakeup.c:21:25: error: 'field_mask' redeclared as different kind of symbol
      21 | static struct reg_field field_mask = REG_FIELD(MSTAR_PMSLEEP_WAKEUPSOURCE, 0, 7);
         |                         ^~~~~~~~~~
   In file included from arch/mips/include/asm/mips-cm.h:14,
                    from arch/mips/include/asm/mips-cps.h:104,
                    from arch/mips/include/asm/smp-ops.h:16,
                    from arch/mips/include/asm/smp.h:21,
                    from include/linux/smp.h:113,
                    from include/linux/lockdep.h:14,
                    from include/linux/spinlock.h:62,
                    from include/linux/irq.h:14,
                    from drivers/irqchip/irq-msc313-pm-wakeup.c:6:
   include/linux/bitfield.h:122:28: note: previous definition of 'field_mask' with type 'u64(u64)' {aka 'long long unsigned int(long long unsigned int)'}
     122 | static __always_inline u64 field_mask(u64 field)
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
