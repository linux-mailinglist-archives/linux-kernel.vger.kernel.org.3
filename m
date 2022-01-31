Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D686C4A487D
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 14:41:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379039AbiAaNlb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 08:41:31 -0500
Received: from mga03.intel.com ([134.134.136.65]:7333 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238832AbiAaNl3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 08:41:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643636489; x=1675172489;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=1b/WHL9os+7Tr/OQvWOaXKLZkpz7CqXX3maGf2xuSKg=;
  b=VHwFfqZ/vIvqgX61+8f6lX+YySz8DpgWGgENLrSkDv2BIe1g1lo0EIcN
   frHL5Zg7C0I1cS66g9kmo/1U0McoUl2t2IDjLfzztPURwwjekjqne8HDy
   6921lutdbrcqjb7rZiy1jsvBOzlZKbV5dXPtCgNCIvkELVdz1XKoSDm3W
   +lv0CoCBAxo/043pc1OKAw9Q1eKJ4yA+lfKqqXyYhnFVAuFGWrVi8ev9p
   vDewS2tViML5TBZACIRUtmTs+x0nSDvb3H/0sj1ktJ71phHAOyAifJx1e
   8dt62smzr4rupjNdTITxngugDxfU48JuHdaSLY4sEcB8cZFvEu+7VIV9a
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10243"; a="247414856"
X-IronPort-AV: E=Sophos;i="5.88,331,1635231600"; 
   d="scan'208";a="247414856"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2022 05:41:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,331,1635231600"; 
   d="scan'208";a="770767832"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 31 Jan 2022 05:41:25 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nEWvt-000Rxt-5O; Mon, 31 Jan 2022 13:41:25 +0000
Date:   Mon, 31 Jan 2022 21:40:30 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:master] BUILD SUCCESS
 74144382b3d293e9eefc370f132925fe7e02497d
Message-ID: <61f7e6ce.Kx+WZDpN1i6LFQd6%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git master
branch HEAD: 74144382b3d293e9eefc370f132925fe7e02497d  Merge sched/core into tip/master

elapsed time: 728m

configs tested: 159
configs skipped: 31

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
i386                 randconfig-c001-20220131
powerpc              randconfig-c003-20220131
arm                           stm32_defconfig
sparc                       sparc32_defconfig
h8300                               defconfig
sh                        edosk7705_defconfig
sh                 kfr2r09-romimage_defconfig
arm                        spear6xx_defconfig
mips                       capcella_defconfig
arm                       omap2plus_defconfig
mips                        jmr3927_defconfig
arm                        keystone_defconfig
sh                          polaris_defconfig
arm                     eseries_pxa_defconfig
powerpc                 mpc8540_ads_defconfig
m68k                       m5208evb_defconfig
powerpc                  storcenter_defconfig
powerpc                       ppc64_defconfig
parisc                           allyesconfig
arm                             pxa_defconfig
arc                 nsimosci_hs_smp_defconfig
riscv                            allyesconfig
sh                        apsh4ad0a_defconfig
arm                           sama5_defconfig
arm                          pxa3xx_defconfig
nds32                               defconfig
powerpc                      mgcoge_defconfig
m68k                        m5272c3_defconfig
powerpc64                        alldefconfig
riscv                    nommu_k210_defconfig
arc                      axs103_smp_defconfig
powerpc                 linkstation_defconfig
arm                            xcep_defconfig
m68k                        mvme147_defconfig
m68k                       m5475evb_defconfig
riscv                            allmodconfig
sparc                            alldefconfig
sh                            migor_defconfig
mips                         bigsur_defconfig
mips                            gpr_defconfig
mips                        vocore2_defconfig
powerpc                     redwood_defconfig
sh                            hp6xx_defconfig
powerpc                  iss476-smp_defconfig
sh                        edosk7760_defconfig
xtensa                           allyesconfig
powerpc                       maple_defconfig
powerpc                     pq2fads_defconfig
powerpc                      bamboo_defconfig
powerpc                 mpc837x_mds_defconfig
arm                  randconfig-c002-20220130
arm                  randconfig-c002-20220131
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
nios2                            allyesconfig
h8300                            allyesconfig
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
powerpc                           allnoconfig
powerpc                          allmodconfig
powerpc                          allyesconfig
x86_64               randconfig-a004-20220131
x86_64               randconfig-a003-20220131
x86_64               randconfig-a001-20220131
x86_64               randconfig-a005-20220131
x86_64               randconfig-a002-20220131
x86_64               randconfig-a006-20220131
i386                 randconfig-a006-20220131
i386                 randconfig-a005-20220131
i386                 randconfig-a003-20220131
i386                 randconfig-a002-20220131
i386                 randconfig-a001-20220131
i386                 randconfig-a004-20220131
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
riscv                randconfig-r042-20220130
arc                  randconfig-r043-20220131
arc                  randconfig-r043-20220130
s390                 randconfig-r044-20220130
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
x86_64                    rhel-8.3-kselftests
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                           allyesconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                                  kexec

clang tested configs:
riscv                randconfig-c006-20220130
x86_64                        randconfig-c007
arm                  randconfig-c002-20220130
powerpc              randconfig-c003-20220130
mips                 randconfig-c004-20220130
i386                          randconfig-c001
mips                     loongson2k_defconfig
powerpc               mpc834x_itxgp_defconfig
riscv                             allnoconfig
powerpc                   bluestone_defconfig
powerpc                     tqm8560_defconfig
arm                             mxs_defconfig
arm                       versatile_defconfig
powerpc                      pmac32_defconfig
arm                       imx_v4_v5_defconfig
mips                     cu1830-neo_defconfig
powerpc                      ppc44x_defconfig
powerpc                    ge_imp3a_defconfig
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64               randconfig-a013-20220131
x86_64               randconfig-a015-20220131
x86_64               randconfig-a014-20220131
x86_64               randconfig-a016-20220131
x86_64               randconfig-a011-20220131
x86_64               randconfig-a012-20220131
i386                 randconfig-a011-20220131
i386                 randconfig-a013-20220131
i386                 randconfig-a014-20220131
i386                 randconfig-a012-20220131
i386                 randconfig-a015-20220131
i386                 randconfig-a016-20220131
i386                          randconfig-a011
i386                          randconfig-a013
i386                          randconfig-a015
s390                 randconfig-r044-20220131
riscv                randconfig-r042-20220131
hexagon              randconfig-r045-20220130
hexagon              randconfig-r045-20220131
hexagon              randconfig-r041-20220130
hexagon              randconfig-r041-20220131

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
