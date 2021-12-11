Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42A50471711
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Dec 2021 23:00:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230343AbhLKWAz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Dec 2021 17:00:55 -0500
Received: from mga03.intel.com ([134.134.136.65]:56897 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229535AbhLKWAy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Dec 2021 17:00:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639260054; x=1670796054;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=N00dYyjaBi2FTFr0RgUppElHeHocCDhfu2dSJOuNeoE=;
  b=cSCTvivQkFXddvmxtB9CRiW4eE0eDhjGcJlkCayAQAzPakHG19AQWSjX
   NkoBd1RXj39gA3P27wgm7Oej1SjST5gHQxWdGSLG1Y6sWAjN5Q5XhrEzw
   XRxuU3wMolvMz1jrbBfWDqLEA6FAtfGUVxv/KbVtx/alDATS8BALSACWX
   ugRK431pPyY41wl55Wn09Pyw2utQ/G6tT8uy8YASnarKZjoP/HUu94Yhh
   vxXKc1G4WUJ+vBvndII1aO+bKYTqMdsKPGmqMBNs2jr2wFErDohhqpw0a
   zqlb4bwxqptT9ZTUxs5/6nVu/gjShOIHbDcKQBOphbjBOKM3yOwINQ070
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10195"; a="238506125"
X-IronPort-AV: E=Sophos;i="5.88,199,1635231600"; 
   d="scan'208";a="238506125"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2021 14:00:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,199,1635231600"; 
   d="scan'208";a="681167233"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 11 Dec 2021 14:00:53 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mwAQG-000580-EX; Sat, 11 Dec 2021 22:00:52 +0000
Date:   Sun, 12 Dec 2021 06:00:16 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:irq/urgent] BUILD SUCCESS
 b7fd35a0ad976ee8e7d4914e063410686b5fa353
Message-ID: <61b51f70.BfzyQtAaIT9caByQ%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq/urgent
branch HEAD: b7fd35a0ad976ee8e7d4914e063410686b5fa353  Merge tag 'irqchip-fixes-5.16-2' of git://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms into irq/urgent

elapsed time: 724m

configs tested: 151
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
i386                 randconfig-c001-20211210
m68k                        m5307c3_defconfig
arm                        spear6xx_defconfig
sh                             sh03_defconfig
riscv                            alldefconfig
powerpc                        cell_defconfig
arm                        mini2440_defconfig
arm                         assabet_defconfig
powerpc                     tqm8548_defconfig
powerpc64                        alldefconfig
arc                          axs101_defconfig
mips                           mtx1_defconfig
powerpc                     pseries_defconfig
mips                       lemote2f_defconfig
powerpc                     ppa8548_defconfig
arm                         shannon_defconfig
arm                         bcm2835_defconfig
riscv                            allyesconfig
arm                          iop32x_defconfig
arm                           h5000_defconfig
powerpc                 mpc837x_rdb_defconfig
arc                      axs103_smp_defconfig
sh                         apsh4a3a_defconfig
powerpc                      katmai_defconfig
powerpc                       eiger_defconfig
nios2                         3c120_defconfig
arm                       multi_v4t_defconfig
sh                           se7619_defconfig
arm                      integrator_defconfig
um                             i386_defconfig
powerpc                     sequoia_defconfig
arm                         lpc32xx_defconfig
microblaze                      mmu_defconfig
sh                        edosk7705_defconfig
arm                     eseries_pxa_defconfig
powerpc                          g5_defconfig
mips                        bcm47xx_defconfig
xtensa                  audio_kc705_defconfig
powerpc                 mpc837x_mds_defconfig
arc                          axs103_defconfig
openrisc                         alldefconfig
powerpc                 mpc8540_ads_defconfig
m68k                       bvme6000_defconfig
powerpc                      ppc40x_defconfig
powerpc                      chrp32_defconfig
m68k                        m5407c3_defconfig
arc                            hsdk_defconfig
openrisc                  or1klitex_defconfig
powerpc                     pq2fads_defconfig
alpha                            alldefconfig
arm                       netwinder_defconfig
s390                          debug_defconfig
arm                        mvebu_v7_defconfig
arm                          pxa168_defconfig
arm                  randconfig-c002-20211210
arm                  randconfig-c002-20211212
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
nds32                               defconfig
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
mips                             allmodconfig
mips                             allyesconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a001-20211210
i386                 randconfig-a002-20211210
i386                 randconfig-a005-20211210
i386                 randconfig-a003-20211210
i386                 randconfig-a006-20211210
i386                 randconfig-a004-20211210
i386                 randconfig-a013-20211211
i386                 randconfig-a011-20211211
i386                 randconfig-a016-20211211
i386                 randconfig-a014-20211211
i386                 randconfig-a015-20211211
i386                 randconfig-a012-20211211
x86_64               randconfig-a006-20211210
x86_64               randconfig-a005-20211210
x86_64               randconfig-a001-20211210
x86_64               randconfig-a002-20211210
x86_64               randconfig-a003-20211210
x86_64               randconfig-a004-20211210
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
arm                  randconfig-c002-20211210
x86_64               randconfig-c007-20211210
riscv                randconfig-c006-20211210
mips                 randconfig-c004-20211210
i386                 randconfig-c001-20211210
s390                 randconfig-c005-20211210
powerpc              randconfig-c003-20211210
x86_64               randconfig-a011-20211210
x86_64               randconfig-a012-20211210
x86_64               randconfig-a014-20211210
x86_64               randconfig-a013-20211210
x86_64               randconfig-a016-20211210
x86_64               randconfig-a015-20211210
i386                 randconfig-a013-20211210
i386                 randconfig-a011-20211210
i386                 randconfig-a016-20211210
i386                 randconfig-a014-20211210
i386                 randconfig-a015-20211210
i386                 randconfig-a012-20211210
hexagon              randconfig-r045-20211210
riscv                randconfig-r042-20211210
s390                 randconfig-r044-20211210
hexagon              randconfig-r041-20211210
hexagon              randconfig-r045-20211212
riscv                randconfig-r042-20211212
s390                 randconfig-r044-20211212
hexagon              randconfig-r041-20211212

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
