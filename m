Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11B8A4817AE
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Dec 2021 00:16:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233131AbhL2XQ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Dec 2021 18:16:26 -0500
Received: from mga02.intel.com ([134.134.136.20]:60440 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231897AbhL2XQZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Dec 2021 18:16:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640819785; x=1672355785;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Tjh6V2xiLKhHTAPUd7GPsxX57uGrJQh7drfQrVZE4wU=;
  b=NQwVcNSYEPCAIGZISg/lQE1MLCwhIU9qSGDnkAdbQXIPQUUVsMVQm9FL
   i98xjco54WzMl6NBqghh7ghuUO4v6r7SFs1moT54f+CrsEnIqcb568Obs
   loCfpdmSvK0TNHCEy3Dtd7OYIkzK7thDe0920vySh1pis+G10TCTtH1xv
   R9eI92AOwrC0asrt9cBL375y3duVRkB3FktqzsyJPwQnE85cqom2dxDpK
   m13CKEuMr0nWJxGO2Ay1OchOtKFuyzll295TOF1FrUIorlTyfBeyvMvkv
   Vu3olNHczdqRhKksWFmb30QMH8y1GfOUtJEnwowX1a3LXBUWiWOdV3sUD
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10212"; a="228893358"
X-IronPort-AV: E=Sophos;i="5.88,246,1635231600"; 
   d="scan'208";a="228893358"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Dec 2021 15:16:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,246,1635231600"; 
   d="scan'208";a="470475677"
Received: from lkp-server01.sh.intel.com (HELO e357b3ef1427) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 29 Dec 2021 15:16:20 -0800
Received: from kbuild by e357b3ef1427 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n2iBA-0009UW-1p; Wed, 29 Dec 2021 23:16:20 +0000
Date:   Thu, 30 Dec 2021 07:15:42 +0800
From:   kernel test robot <lkp@intel.com>
To:     Guo Ren <guoren@linux.alibaba.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Liu Shaohua <liush@allwinnertech.com>, Wei Fu <wefu@redhat.com>
Subject: [csky-linux:riscv_compat_v2_sv48_v3_xtpbmt 32/32]
 arch/riscv/errata/thead/errata.c:40:50: error: '__riscv_svpbmt' undeclared
Message-ID: <202112300758.KEBcJ4W5-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/c-sky/csky-linux riscv_compat_v2_sv48_v3_xtpbmt
head:   ff10a70d2ed4fbef7238b315145d1aa0d137f80f
commit: ff10a70d2ed4fbef7238b315145d1aa0d137f80f [32/32] riscv: errata: pgtable: Add custom Svpbmt supported for Allwinner D1
config: riscv-buildonly-randconfig-r002-20211230 (https://download.01.org/0day-ci/archive/20211230/202112300758.KEBcJ4W5-lkp@intel.com/config)
compiler: riscv32-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/c-sky/csky-linux/commit/ff10a70d2ed4fbef7238b315145d1aa0d137f80f
        git remote add csky-linux https://github.com/c-sky/csky-linux
        git fetch --no-tags csky-linux riscv_compat_v2_sv48_v3_xtpbmt
        git checkout ff10a70d2ed4fbef7238b315145d1aa0d137f80f
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=riscv SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   arch/riscv/errata/thead/errata.c: In function 'thead_errata_setup_vm':
>> arch/riscv/errata/thead/errata.c:40:50: error: '__riscv_svpbmt' undeclared (first use in this function)
      40 |                 pgprot_val(protection_map[i]) |= __riscv_svpbmt.mt_pma;
         |                                                  ^~~~~~~~~~~~~~
   arch/riscv/errata/thead/errata.c:40:50: note: each undeclared identifier is reported only once for each function it appears in

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for SERIAL_8250_DW
   Depends on TTY && HAS_IOMEM && SERIAL_8250
   Selected by
   - ERRATA_THEAD && RISCV_ERRATA_ALTERNATIVE


vim +/__riscv_svpbmt +40 arch/riscv/errata/thead/errata.c

    38	
    39		for (i = 0; i < 16; i++)
  > 40			pgprot_val(protection_map[i]) |= __riscv_svpbmt.mt_pma;

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
