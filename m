Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CEEA48A850
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 08:21:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348494AbiAKHVv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 02:21:51 -0500
Received: from mga11.intel.com ([192.55.52.93]:32086 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233066AbiAKHVu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 02:21:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641885710; x=1673421710;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=xjapLZr71geqGy0ynMObGUc/b2WTvX3JtHl3+Y57FyQ=;
  b=ZPCKDbReKptblS+04zhk6Iv0vmJbQloMjgHX9AAouwBCTBBVAMpG9Rto
   ICoq+i66pozE91Q5gYneyXbYG9GzAivyexdjAwuhRnxx4zRvhuQ6P4Zy4
   MmB9iuo5pdjP+k1O0qu08pXzNPw3H7hFSqO2ckgjFDNec/LYa+SWjPZYW
   akMY0cPo+zUgw23mSEdZxJZ3dxX4SFhzCxh0d74fNZdPkPSGI5GUQCw1S
   Y54VjC0BE8sjXL5vqzcb9iXDJfjDN6pj3NiKs1ngzqogLwqXNfoAvDDW3
   bOeeMU3FbIXBBGVsnVgV9KpjTcLmnkVpnp/eGY7RXxG46FanQQ2su28I7
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10223"; a="240973002"
X-IronPort-AV: E=Sophos;i="5.88,279,1635231600"; 
   d="scan'208";a="240973002"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2022 23:21:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,279,1635231600"; 
   d="scan'208";a="514992579"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 10 Jan 2022 23:21:48 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n7BTX-0004YJ-H6; Tue, 11 Jan 2022 07:21:47 +0000
Date:   Tue, 11 Jan 2022 15:21:24 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:irq/msi] BUILD SUCCESS
 74a5257a0c175810d620b5e631c4e7554955ac25
Message-ID: <61dd2ff4.v5CAmuGl972JWWQ1%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq/msi
branch HEAD: 74a5257a0c175810d620b5e631c4e7554955ac25  genirq/msi: Populate sysfs entry only once

elapsed time: 724m

configs tested: 121
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
i386                          randconfig-c001
mips                 randconfig-c004-20220111
powerpc                     tqm8541_defconfig
nios2                            allyesconfig
powerpc                      ppc40x_defconfig
m68k                        stmark2_defconfig
sh                           se7721_defconfig
mips                      fuloong2e_defconfig
csky                             alldefconfig
powerpc                       ppc64_defconfig
powerpc                     taishan_defconfig
sh                           se7780_defconfig
um                             i386_defconfig
h8300                               defconfig
xtensa                  nommu_kc705_defconfig
parisc                generic-64bit_defconfig
arc                    vdk_hs38_smp_defconfig
arm                        multi_v7_defconfig
sh                         microdev_defconfig
arm                          iop32x_defconfig
powerpc                    adder875_defconfig
parisc                           alldefconfig
arm                           viper_defconfig
mips                 decstation_r4k_defconfig
arm                        clps711x_defconfig
powerpc                      arches_defconfig
mips                       bmips_be_defconfig
arm                            zeus_defconfig
sh                           se7722_defconfig
ia64                        generic_defconfig
mips                         mpc30x_defconfig
arc                          axs103_defconfig
sh                          urquell_defconfig
arm                            hisi_defconfig
sh                             shx3_defconfig
m68k                       bvme6000_defconfig
sh                   rts7751r2dplus_defconfig
riscv                            allyesconfig
arm                  randconfig-c002-20220111
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nds32                               defconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
xtensa                           allyesconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
parisc                              defconfig
s390                             allyesconfig
s390                             allmodconfig
parisc                           allyesconfig
s390                                defconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64                        randconfig-a006
x86_64                        randconfig-a004
x86_64                        randconfig-a002
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
riscv                randconfig-r042-20220111
arc                  randconfig-r043-20220111
s390                 randconfig-r044-20220111
riscv                    nommu_k210_defconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                    rhel-8.3-kselftests
um                           x86_64_defconfig
x86_64                           allyesconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                                  kexec

clang tested configs:
arm                  randconfig-c002-20220111
x86_64                        randconfig-c007
riscv                randconfig-c006-20220111
powerpc              randconfig-c003-20220111
i386                          randconfig-c001
s390                 randconfig-c005-20220111
mips                 randconfig-c004-20220111
arm                     am200epdkit_defconfig
arm                          imote2_defconfig
powerpc                     akebono_defconfig
powerpc                     kilauea_defconfig
powerpc                          g5_defconfig
powerpc                     kmeter1_defconfig
powerpc                     tqm5200_defconfig
arm                  colibri_pxa300_defconfig
mips                           ip22_defconfig
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
x86_64                        randconfig-a005
x86_64                        randconfig-a003
x86_64                        randconfig-a001

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
