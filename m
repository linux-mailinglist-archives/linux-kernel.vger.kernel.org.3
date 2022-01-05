Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33E6A4851EB
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 12:35:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235788AbiAELfn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 06:35:43 -0500
Received: from mga01.intel.com ([192.55.52.88]:55790 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235556AbiAELfk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 06:35:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641382540; x=1672918540;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=pqwSfbPwtwJe1YL6Opa0MCC6cKDRXW63ytA/VbMuSs0=;
  b=VtPfw6bjNhGLLc6H5kls9sdLZ9c0XqZTISl851LEMvUP60L1syS1iiNl
   NZ8Y1a37Pg61+RjSl6z37Qygu9SQ3iVJ03eleSo3r83vLMFq5tN8rP1E9
   V2AAZV8SYNBa+PIjTPK69twd8SyvrUPz7HKj1wPzQBPAza1G4GmebuAhW
   DmwYnHhzNvRqWHrDNzh17AQouTHxq0OTFRfcTf+wTYhzlCWbStMzFWoC2
   CBCAQWWV+6ZL1HuSVhgPP22qT0nPMMwWkCLQLCtkntg2AVX50Byf7QLNu
   aGm2Ev3HLT59Q9Cu8Hc/WTxB9eXzFPPtxm95mclauaf08B+3LizRwh6Lq
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10217"; a="266698808"
X-IronPort-AV: E=Sophos;i="5.88,263,1635231600"; 
   d="scan'208";a="266698808"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2022 03:35:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,263,1635231600"; 
   d="scan'208";a="621012076"
Received: from lkp-server01.sh.intel.com (HELO e357b3ef1427) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 05 Jan 2022 03:35:38 -0800
Received: from kbuild by e357b3ef1427 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n54Zt-000GYy-C3; Wed, 05 Jan 2022 11:35:37 +0000
Date:   Wed, 05 Jan 2022 19:34:59 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:dev.2021.12.20a] BUILD SUCCESS
 66b153e7e3980067de018ec8c478aa0aaf7ba2bd
Message-ID: <61d58263.F1O5FUjjNhpcO15h%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev.2021.12.20a
branch HEAD: 66b153e7e3980067de018ec8c478aa0aaf7ba2bd  rcu: Mark writes to the rcu_segcblist structure's ->flags field

elapsed time: 736m

configs tested: 113
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
i386                 randconfig-c001-20220105
powerpc                      bamboo_defconfig
arc                        nsim_700_defconfig
sh                        edosk7705_defconfig
sh                     magicpanelr2_defconfig
powerpc                      tqm8xx_defconfig
powerpc                 linkstation_defconfig
arm                           stm32_defconfig
powerpc                        warp_defconfig
arm                          lpd270_defconfig
arm                        shmobile_defconfig
mips                      fuloong2e_defconfig
arm                           u8500_defconfig
h8300                               defconfig
powerpc                           allnoconfig
i386                             alldefconfig
nds32                               defconfig
arm                            zeus_defconfig
mips                  maltasmvp_eva_defconfig
powerpc                 mpc85xx_cds_defconfig
arm                  randconfig-c002-20220105
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
nios2                            allyesconfig
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
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
x86_64               randconfig-a005-20220105
x86_64               randconfig-a001-20220105
x86_64               randconfig-a004-20220105
x86_64               randconfig-a006-20220105
x86_64               randconfig-a003-20220105
x86_64               randconfig-a002-20220105
i386                 randconfig-a003-20220105
i386                 randconfig-a005-20220105
i386                 randconfig-a004-20220105
i386                 randconfig-a006-20220105
i386                 randconfig-a002-20220105
i386                 randconfig-a001-20220105
arc                  randconfig-r043-20220105
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                    rhel-8.3-kselftests
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                           allyesconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                                  kexec

clang tested configs:
mips                 randconfig-c004-20220105
arm                  randconfig-c002-20220105
i386                 randconfig-c001-20220105
riscv                randconfig-c006-20220105
powerpc              randconfig-c003-20220105
x86_64               randconfig-c007-20220105
powerpc                  mpc885_ads_defconfig
arm                        multi_v5_defconfig
riscv                          rv32_defconfig
mips                           ip28_defconfig
mips                      maltaaprp_defconfig
powerpc                      obs600_defconfig
powerpc                          g5_defconfig
arm                          collie_defconfig
mips                   sb1250_swarm_defconfig
x86_64               randconfig-a012-20220105
x86_64               randconfig-a015-20220105
x86_64               randconfig-a014-20220105
x86_64               randconfig-a013-20220105
x86_64               randconfig-a011-20220105
x86_64               randconfig-a016-20220105
i386                 randconfig-a012-20220105
i386                 randconfig-a016-20220105
i386                 randconfig-a015-20220105
i386                 randconfig-a014-20220105
i386                 randconfig-a011-20220105
i386                 randconfig-a013-20220105
hexagon              randconfig-r041-20220105
hexagon              randconfig-r045-20220105
riscv                randconfig-r042-20220105

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
