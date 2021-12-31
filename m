Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C642482317
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Dec 2021 10:49:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229770AbhLaJtx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Dec 2021 04:49:53 -0500
Received: from mga02.intel.com ([134.134.136.20]:32250 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229498AbhLaJtw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Dec 2021 04:49:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640944192; x=1672480192;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=nXeIfNUhFjR0KGBTOnw9Rpvrszu/qb+YY26GaGwYdW4=;
  b=GR8RxDJ9G80iXEIrAzQ5Nd/LGBIowJUfcSKaux9sJbPfGITo2K8GEEds
   NXIUKuPvtY4AB/Xl+KiCEHay815womrEtoMutR5+CJ+Znh40i4MrkVg8X
   OCp66U7aWyem050Yr19Q/zI7UqCnzsykIUXiozalmAZKy6ow94nedDTvx
   qyGOvbs5IDAZybGNATd42prwu5P8yfPSpZwrow0t8UOTCeCLDHm0tST8Q
   2+9e7sW/LTkG3hNBVae40TKeuRD+fzEt7bmvQpZHyDnIcqOvZRPtlZMBH
   /H3InPqlyQ+x26UOJfwVc+Lq7z0Zmjtc3sMZBaJh9KPSTVlY/aj9A0gFi
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10213"; a="229109385"
X-IronPort-AV: E=Sophos;i="5.88,251,1635231600"; 
   d="scan'208";a="229109385"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Dec 2021 01:49:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,251,1635231600"; 
   d="scan'208";a="619601930"
Received: from lkp-server01.sh.intel.com (HELO e357b3ef1427) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 31 Dec 2021 01:49:50 -0800
Received: from kbuild by e357b3ef1427 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n3EXl-000B9H-VI; Fri, 31 Dec 2021 09:49:49 +0000
Date:   Fri, 31 Dec 2021 17:49:30 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/vdso] BUILD SUCCESS
 9102fa34604159642625f42d7f801f1e04d9ca12
Message-ID: <61ced22a.ouPdluDBITLMbiDf%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/vdso
branch HEAD: 9102fa34604159642625f42d7f801f1e04d9ca12  x86/purgatory: Remove -nostdlib compiler flag

elapsed time: 725m

configs tested: 154
configs skipped: 69

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
i386                 randconfig-c001-20211229
i386                 randconfig-c001-20211230
mips                 randconfig-c004-20211230
arm                         at91_dt_defconfig
powerpc                 mpc832x_rdb_defconfig
sh                          sdk7780_defconfig
powerpc                    mvme5100_defconfig
ia64                        generic_defconfig
nds32                               defconfig
arm                            xcep_defconfig
arm                      footbridge_defconfig
arc                              alldefconfig
mips                          ath79_defconfig
sh                        sh7757lcr_defconfig
powerpc                 mpc8313_rdb_defconfig
arm                          collie_defconfig
powerpc                 mpc8315_rdb_defconfig
arc                          axs103_defconfig
sh                                  defconfig
mips                     loongson2k_defconfig
openrisc                         alldefconfig
csky                                defconfig
mips                        bcm63xx_defconfig
sh                          rsk7203_defconfig
riscv             nommu_k210_sdcard_defconfig
mips                            e55_defconfig
powerpc                     ksi8560_defconfig
openrisc                  or1klitex_defconfig
sh                             sh03_defconfig
powerpc                      cm5200_defconfig
arm                            dove_defconfig
sh                          lboxre2_defconfig
powerpc                 mpc8272_ads_defconfig
powerpc                   lite5200b_defconfig
h8300                               defconfig
parisc                           allyesconfig
arm                         nhk8815_defconfig
mips                           ip28_defconfig
xtensa                         virt_defconfig
arm                         bcm2835_defconfig
riscv                             allnoconfig
powerpc                     tqm8540_defconfig
arm                         orion5x_defconfig
powerpc                    adder875_defconfig
mips                         bigsur_defconfig
mips                      malta_kvm_defconfig
powerpc                     asp8347_defconfig
ia64                             allyesconfig
sh                   sh7724_generic_defconfig
mips                  maltasmvp_eva_defconfig
powerpc                    gamecube_defconfig
ia64                         bigsur_defconfig
powerpc                           allnoconfig
h8300                       h8s-sim_defconfig
um                               alldefconfig
mips                            gpr_defconfig
m68k                           sun3_defconfig
powerpc                 mpc836x_mds_defconfig
sparc64                          alldefconfig
xtensa                  cadence_csp_defconfig
arm                        spear3xx_defconfig
arm                       cns3420vb_defconfig
powerpc                  storcenter_defconfig
arm                           spitz_defconfig
sh                        sh7785lcr_defconfig
arm                            mps2_defconfig
h8300                            allyesconfig
mips                      pic32mzda_defconfig
arm                           sama5_defconfig
sh                   secureedge5410_defconfig
arm                       netwinder_defconfig
m68k                            mac_defconfig
powerpc                     powernv_defconfig
mips                        qi_lb60_defconfig
arm                        mvebu_v7_defconfig
ia64                            zx1_defconfig
powerpc                      tqm8xx_defconfig
powerpc                    socrates_defconfig
sh                        edosk7705_defconfig
arm                  randconfig-c002-20211230
ia64                             allmodconfig
ia64                                defconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
nios2                            allyesconfig
alpha                               defconfig
alpha                            allyesconfig
xtensa                           allyesconfig
arc                                 defconfig
sh                               allmodconfig
parisc                              defconfig
s390                             allyesconfig
s390                             allmodconfig
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
x86_64               randconfig-a013-20211230
x86_64               randconfig-a015-20211230
x86_64               randconfig-a012-20211230
x86_64               randconfig-a011-20211230
x86_64               randconfig-a016-20211230
x86_64               randconfig-a014-20211230
i386                 randconfig-a016-20211230
i386                 randconfig-a011-20211230
i386                 randconfig-a012-20211230
i386                 randconfig-a013-20211230
i386                 randconfig-a014-20211230
i386                 randconfig-a015-20211230
arc                  randconfig-r043-20211230
riscv                randconfig-r042-20211230
s390                 randconfig-r044-20211230
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
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
x86_64               randconfig-a002-20211230
x86_64               randconfig-a001-20211230
x86_64               randconfig-a003-20211230
x86_64               randconfig-a006-20211230
x86_64               randconfig-a004-20211230
x86_64               randconfig-a005-20211230
i386                 randconfig-a001-20211230
i386                 randconfig-a002-20211230
i386                 randconfig-a003-20211230
i386                 randconfig-a004-20211230
i386                 randconfig-a005-20211230
i386                 randconfig-a006-20211230

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
