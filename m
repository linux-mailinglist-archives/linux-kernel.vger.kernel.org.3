Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 946BB484231
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 14:17:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233370AbiADNRz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 08:17:55 -0500
Received: from mga18.intel.com ([134.134.136.126]:57156 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229568AbiADNRw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 08:17:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641302272; x=1672838272;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=kJOqrUbJmYVCfX1CriSTBll9xoJcUY8icC5XZKh6Ifw=;
  b=V2a1HPAcsVgQfzg+h4KhkwMFcmTGZ8B92BnXhfOuiiXvNNMEwPsJrkCA
   PXcYs+pZg9bC9A+gA7HjXSWfgW3VIRvNcugcIk6M2GOBTiyPa4SeNwyvr
   gFqlpy9GWIzsgh3rQKVpWHHTOkR5xhZJpusrDiKTCyU7nfEcUN7ko/CH3
   8waL2dECyS0slLXKI/NKv/0cr90JVzz27c0+W3G2iNO9/u6JOPWYJiYvQ
   dzRBguuQhYL3OE9QOoMXR3SEsS/JJpO/q99R5UcBSuNZPfMWMm3iw43/s
   yRiwuiLh68ylg8HmkI5mQyqS6TBjZEmfD222H8gxNjDpaRL+GEBB1kH/Y
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10216"; a="229040445"
X-IronPort-AV: E=Sophos;i="5.88,261,1635231600"; 
   d="scan'208";a="229040445"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2022 05:17:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,261,1635231600"; 
   d="scan'208";a="526045611"
Received: from lkp-server01.sh.intel.com (HELO e357b3ef1427) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 04 Jan 2022 05:17:50 -0800
Received: from kbuild by e357b3ef1427 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n4jhG-000FO5-2P; Tue, 04 Jan 2022 13:17:50 +0000
Date:   Tue, 04 Jan 2022 21:17:14 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:master] BUILD SUCCESS
 30fddd0b8484a19a6d49503265b2da33f1569ec4
Message-ID: <61d448da.u6+SN783ST5mU7kD%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git master
branch HEAD: 30fddd0b8484a19a6d49503265b2da33f1569ec4  Merge ras/core into tip/master

elapsed time: 3055m

configs tested: 148
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
sh                            shmin_defconfig
xtensa                       common_defconfig
arm                         cm_x300_defconfig
m68k                        m5407c3_defconfig
nios2                         3c120_defconfig
arm                        spear6xx_defconfig
mips                            ar7_defconfig
powerpc                 mpc834x_mds_defconfig
xtensa                         virt_defconfig
powerpc                     ep8248e_defconfig
mips                           ci20_defconfig
powerpc                      chrp32_defconfig
arm                          exynos_defconfig
arc                        vdk_hs38_defconfig
sh                        dreamcast_defconfig
mips                           gcw0_defconfig
arm                             rpc_defconfig
arm                         nhk8815_defconfig
powerpc                   motionpro_defconfig
sh                         ap325rxa_defconfig
ia64                                defconfig
ia64                          tiger_defconfig
mips                      loongson3_defconfig
mips                           ip32_defconfig
sh                   sh7724_generic_defconfig
powerpc                       ppc64_defconfig
arc                                 defconfig
powerpc                     taishan_defconfig
xtensa                  nommu_kc705_defconfig
arm                        shmobile_defconfig
arm64                            alldefconfig
mips                         tb0226_defconfig
arm                           viper_defconfig
um                                  defconfig
arm                  randconfig-c002-20220103
arm                  randconfig-c002-20220102
ia64                             allmodconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nds32                               defconfig
nios2                            allyesconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
sh                               allmodconfig
xtensa                           allyesconfig
h8300                            allyesconfig
parisc                              defconfig
s390                             allyesconfig
s390                             allmodconfig
parisc                           allyesconfig
s390                                defconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a015-20220102
x86_64               randconfig-a012-20220102
x86_64               randconfig-a014-20220102
x86_64               randconfig-a013-20220102
x86_64               randconfig-a011-20220102
x86_64               randconfig-a016-20220102
i386                 randconfig-a012-20220102
i386                 randconfig-a016-20220102
i386                 randconfig-a014-20220102
i386                 randconfig-a015-20220102
i386                 randconfig-a011-20220102
i386                 randconfig-a013-20220102
s390                 randconfig-r044-20220102
arc                  randconfig-r043-20220102
riscv                randconfig-r042-20220102
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                           allyesconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                                  kexec
x86_64                    rhel-8.3-kselftests

clang tested configs:
arm                  randconfig-c002-20220102
mips                 randconfig-c004-20220102
i386                 randconfig-c001-20220102
riscv                randconfig-c006-20220102
powerpc              randconfig-c003-20220102
s390                 randconfig-c005-20220102
x86_64               randconfig-c007-20220102
mips                           rs90_defconfig
powerpc                   microwatt_defconfig
arm                       aspeed_g4_defconfig
powerpc                    socrates_defconfig
arm                          pcm027_defconfig
arm                    vt8500_v6_v7_defconfig
powerpc                          allmodconfig
mips                        omega2p_defconfig
powerpc                 mpc836x_rdk_defconfig
arm                            mmp2_defconfig
arm                        mvebu_v5_defconfig
hexagon                             defconfig
mips                  cavium_octeon_defconfig
mips                        maltaup_defconfig
x86_64               randconfig-a001-20220102
x86_64               randconfig-a002-20220102
x86_64               randconfig-a003-20220102
x86_64               randconfig-a005-20220102
x86_64               randconfig-a004-20220102
x86_64               randconfig-a006-20220102
i386                 randconfig-a004-20220102
i386                 randconfig-a001-20220102
i386                 randconfig-a002-20220102
i386                 randconfig-a003-20220102
i386                 randconfig-a005-20220102
i386                 randconfig-a006-20220102
x86_64               randconfig-a014-20220103
x86_64               randconfig-a013-20220103
x86_64               randconfig-a011-20220103
x86_64               randconfig-a012-20220103
x86_64               randconfig-a015-20220103
x86_64               randconfig-a016-20220103
i386                 randconfig-a012-20220103
i386                 randconfig-a014-20220103
i386                 randconfig-a011-20220103
i386                 randconfig-a013-20220103
i386                 randconfig-a016-20220103
i386                 randconfig-a015-20220103
hexagon              randconfig-r045-20220102
hexagon              randconfig-r041-20220102

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
