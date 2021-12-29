Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 450ED48175A
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Dec 2021 23:45:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232503AbhL2WpX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Dec 2021 17:45:23 -0500
Received: from mga04.intel.com ([192.55.52.120]:31871 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230243AbhL2WpW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Dec 2021 17:45:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640817922; x=1672353922;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=FKbK56FF3G/2tJxeta3wOoQtH42eSRbpX4oLUSR2B1w=;
  b=FPv2OSO4IEovN/z6BYlxO2Zy1ILxeUE9q5ROPxlS0PNEROTlr6JjZpGL
   WUdx9R2NtAdNAuPhM2Dn80fGYp3I3J5V2oIAi9S4tnxateLXSNPG0Zk43
   t1Tt1oIvRS8vOUmKxU2cErvyxVmlNVADBcEbLA5Qn0/uuluzR8ZCpJliE
   3q8slkgzpUeB8266TjnxyB3dHKQQaDmKUqbSeEHs1+z6luzb7agg1UrT8
   rwue+zK9ubORul6SyG5AP3jM7kBFy/89wHUPdEX2GaQ7TfPVmsl/tTKfl
   R9h8jr53LUA9UmCamzuySVh4pKT3xj/j2A1J+j+rClT/GzC9sWXcAicbw
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10212"; a="240363948"
X-IronPort-AV: E=Sophos;i="5.88,246,1635231600"; 
   d="scan'208";a="240363948"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Dec 2021 14:45:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,246,1635231600"; 
   d="scan'208";a="470469780"
Received: from lkp-server01.sh.intel.com (HELO e357b3ef1427) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 29 Dec 2021 14:45:20 -0800
Received: from kbuild by e357b3ef1427 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n2hh9-0009Tb-Q0; Wed, 29 Dec 2021 22:45:19 +0000
Date:   Thu, 30 Dec 2021 06:45:14 +0800
From:   kernel test robot <lkp@intel.com>
To:     Guo Ren <guoren@linux.alibaba.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Liu Shaohua <liush@allwinnertech.com>, Wei Fu <wefu@redhat.com>
Subject: [csky-linux:riscv_compat_v2_sv48_v3_xtpbmt 32/32] errata.c:undefined
 reference to `protection_map'
Message-ID: <202112300625.f6BEYh5d-lkp@intel.com>
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
config: riscv-nommu_k210_defconfig (https://download.01.org/0day-ci/archive/20211230/202112300625.f6BEYh5d-lkp@intel.com/config)
compiler: riscv64-linux-gcc (GCC) 11.2.0
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

   riscv64-linux-ld: arch/riscv/errata/thead/errata.o: in function `.L0 ':
>> errata.c:(.init.text+0x22): undefined reference to `protection_map'
>> riscv64-linux-ld: errata.c:(.init.text+0x2a): undefined reference to `protection_map'

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for SERIAL_8250_DW
   Depends on TTY && HAS_IOMEM && SERIAL_8250
   Selected by
   - ERRATA_THEAD && RISCV_ERRATA_ALTERNATIVE

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
