Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB0F946C218
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 18:49:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240224AbhLGRw4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 12:52:56 -0500
Received: from mga03.intel.com ([134.134.136.65]:7206 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230181AbhLGRw4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 12:52:56 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10190"; a="237582164"
X-IronPort-AV: E=Sophos;i="5.87,293,1631602800"; 
   d="scan'208";a="237582164"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2021 09:32:12 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,293,1631602800"; 
   d="scan'208";a="542882153"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 07 Dec 2021 09:32:10 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mueK1-000MoW-Sh; Tue, 07 Dec 2021 17:32:09 +0000
Date:   Wed, 8 Dec 2021 01:31:27 +0800
From:   kernel test robot <lkp@intel.com>
To:     Anup Patel <anup.patel@wdc.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [avpatel:riscv_kvm_aia_v1 38/40]
 include/linux/irqchip/riscv-imsic.h:64:10: error: use of undeclared
 identifier 'ENODEV'
Message-ID: <202112080139.lb5Z5UZJ-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/avpatel/linux.git riscv_kvm_aia_v1
head:   eb55ca3817a59020fc1e3d5a5de0a5adcebbedd0
commit: c72c5647e9ebb7176ee3862a1ca95bcd3bdfe71b [38/40] RISC-V: KVM: Implement device interface for AIA irqchip
config: riscv-randconfig-c006-20211207 (https://download.01.org/0day-ci/archive/20211208/202112080139.lb5Z5UZJ-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project 097a1cb1d5ebb3a0ec4bcaed8ba3ff6a8e33c00a)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install riscv cross compiling tool for clang build
        # apt-get install binutils-riscv64-linux-gnu
        # https://github.com/avpatel/linux/commit/c72c5647e9ebb7176ee3862a1ca95bcd3bdfe71b
        git remote add avpatel https://github.com/avpatel/linux.git
        git fetch --no-tags avpatel riscv_kvm_aia_v1
        git checkout c72c5647e9ebb7176ee3862a1ca95bcd3bdfe71b
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=riscv SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from arch/riscv/kvm/aia_device.c:10:
>> include/linux/irqchip/riscv-imsic.h:64:10: error: use of undeclared identifier 'ENODEV'
           return -ENODEV;
                   ^
   1 error generated.


vim +/ENODEV +64 include/linux/irqchip/riscv-imsic.h

2ad4dc808c3e01 Anup Patel 2021-04-26  59  
2ad4dc808c3e01 Anup Patel 2021-04-26  60  static inline int imsic_cpu_page_phys(unsigned int cpu,
2ad4dc808c3e01 Anup Patel 2021-04-26  61  				      unsigned int guest_index,
2ad4dc808c3e01 Anup Patel 2021-04-26  62  				      phys_addr_t *out_msi_pa)
2ad4dc808c3e01 Anup Patel 2021-04-26  63  {
2ad4dc808c3e01 Anup Patel 2021-04-26 @64  	return -ENODEV;
2ad4dc808c3e01 Anup Patel 2021-04-26  65  }
2ad4dc808c3e01 Anup Patel 2021-04-26  66  

:::::: The code at line 64 was first introduced by commit
:::::: 2ad4dc808c3e0175e4975b41cecbb996ee217731 irqchip: Add incoming MSI controller driver

:::::: TO: Anup Patel <anup.patel@wdc.com>
:::::: CC: Anup Patel <anup@brainfault.org>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
