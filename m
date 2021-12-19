Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB345479FD7
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Dec 2021 08:56:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232925AbhLSH4b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Dec 2021 02:56:31 -0500
Received: from mga04.intel.com ([192.55.52.120]:19246 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231314AbhLSH43 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Dec 2021 02:56:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639900588; x=1671436588;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=dMyJ0xM4qP3sUbL2vjGGYlJGvIi73WG2IUTMjHZ14Zk=;
  b=K/U2Z4Q0NdgiUg0fcmGFICNlhizc9+k/NMwxf6DFcAg5dXIpqNoDR5NE
   inn7nJi1QjOUawLlXQhJVUFaM7h464QcS08oWE6lzPZIJobH994iCicRp
   k6xkukDH699BAgT77lw2SaBMwoU+k/NmRSEcs51WYY7SFrfkbz7e+E5wx
   WtpjIufzpfWv2OIBAegP/Axq09RABD8L5DRNuDrfVNeva9EYj3LKPdinh
   aqO9Mb9kiV+zW7nZMNKJq1ViYwmlBLf+rNlx1/i6ItmW1R51NHKkBdxBR
   GG9tcfivsff75wMhbU24yopsm9LrENYDYw9bnV8uQRhm2D+COyTCvRAVG
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10202"; a="238734958"
X-IronPort-AV: E=Sophos;i="5.88,217,1635231600"; 
   d="scan'208";a="238734958"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Dec 2021 23:56:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,217,1635231600"; 
   d="scan'208";a="546860093"
Received: from lkp-server02.sh.intel.com (HELO 9f38c0981d9f) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 18 Dec 2021 23:56:26 -0800
Received: from kbuild by 9f38c0981d9f with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1myr3S-0006nl-83; Sun, 19 Dec 2021 07:56:26 +0000
Date:   Sun, 19 Dec 2021 15:56:12 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:irq/msi] BUILD SUCCESS
 d558285413ea2f934ab90223ba908c30c5113aee
Message-ID: <61bee59c.jpzrEsuSYMQ/Xw/7%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq/msi
branch HEAD: d558285413ea2f934ab90223ba908c30c5113aee  PCI/MSI: Unbreak pci_irq_get_affinity()

elapsed time: 726m

configs tested: 141
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
nios2                            alldefconfig
powerpc                       ebony_defconfig
mips                      malta_kvm_defconfig
arm                           sama5_defconfig
riscv                          rv32_defconfig
powerpc                    sam440ep_defconfig
arm                      pxa255-idp_defconfig
h8300                            alldefconfig
arm                       spear13xx_defconfig
mips                         cobalt_defconfig
powerpc               mpc834x_itxgp_defconfig
arc                 nsimosci_hs_smp_defconfig
xtensa                       common_defconfig
arc                     nsimosci_hs_defconfig
powerpc                 mpc8315_rdb_defconfig
powerpc                 xes_mpc85xx_defconfig
mips                        omega2p_defconfig
sparc64                             defconfig
sh                     sh7710voipgw_defconfig
arm                              alldefconfig
nds32                            alldefconfig
m68k                       m5208evb_defconfig
m68k                        m5407c3_defconfig
arm                            hisi_defconfig
sh                   rts7751r2dplus_defconfig
arm                         shannon_defconfig
arm                        clps711x_defconfig
sh                           se7724_defconfig
m68k                       m5249evb_defconfig
arm                            dove_defconfig
powerpc                     powernv_defconfig
um                           x86_64_defconfig
mips                        jmr3927_defconfig
powerpc                     stx_gp3_defconfig
sh                  sh7785lcr_32bit_defconfig
mips                     loongson1b_defconfig
mips                         db1xxx_defconfig
powerpc                      ppc6xx_defconfig
sh                           sh2007_defconfig
arm                           viper_defconfig
powerpc64                        alldefconfig
sh                   sh7770_generic_defconfig
arm                         mv78xx0_defconfig
powerpc                     tqm8560_defconfig
h8300                       h8s-sim_defconfig
mips                     cu1830-neo_defconfig
i386                             alldefconfig
arm                           u8500_defconfig
m68k                        mvme147_defconfig
ia64                         bigsur_defconfig
arc                     haps_hs_smp_defconfig
powerpc                      arches_defconfig
mips                          rb532_defconfig
powerpc                 canyonlands_defconfig
arm                        trizeps4_defconfig
powerpc                   motionpro_defconfig
powerpc                 linkstation_defconfig
m68k                           sun3_defconfig
openrisc                    or1ksim_defconfig
h8300                            allyesconfig
arm                  randconfig-c002-20211219
ia64                                defconfig
ia64                             allmodconfig
ia64                             allyesconfig
m68k                                defconfig
m68k                             allmodconfig
m68k                             allyesconfig
nds32                             allnoconfig
nios2                               defconfig
arc                              allyesconfig
nds32                               defconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
nios2                            allyesconfig
xtensa                           allyesconfig
arc                                 defconfig
sh                               allmodconfig
parisc                              defconfig
s390                             allyesconfig
s390                             allmodconfig
parisc                           allyesconfig
s390                                defconfig
i386                                defconfig
i386                              debian-10.3
sparc                               defconfig
i386                             allyesconfig
i386                   debian-10.3-kselftests
sparc                            allyesconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a011-20211219
x86_64               randconfig-a013-20211219
x86_64               randconfig-a012-20211219
x86_64               randconfig-a014-20211219
x86_64               randconfig-a015-20211219
x86_64               randconfig-a016-20211219
i386                 randconfig-a011-20211219
i386                 randconfig-a015-20211219
i386                 randconfig-a012-20211219
i386                 randconfig-a013-20211219
i386                 randconfig-a016-20211219
i386                 randconfig-a014-20211219
arc                  randconfig-r043-20211219
riscv                randconfig-r042-20211219
s390                 randconfig-r044-20211219
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                            allmodconfig
x86_64                    rhel-8.3-kselftests
um                             i386_defconfig
x86_64                           allyesconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                                  kexec

clang tested configs:
i386                 randconfig-a002-20211219
i386                 randconfig-a001-20211219
i386                 randconfig-a005-20211219
i386                 randconfig-a003-20211219
i386                 randconfig-a006-20211219
i386                 randconfig-a004-20211219
x86_64               randconfig-a006-20211219
x86_64               randconfig-a005-20211219
x86_64               randconfig-a001-20211219
x86_64               randconfig-a003-20211219
x86_64               randconfig-a002-20211219
x86_64               randconfig-a004-20211219
hexagon              randconfig-r045-20211219
hexagon              randconfig-r041-20211219

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
