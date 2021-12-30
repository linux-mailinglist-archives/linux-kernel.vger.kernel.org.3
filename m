Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2208C4820E1
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Dec 2021 00:38:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240897AbhL3Xil (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Dec 2021 18:38:41 -0500
Received: from mga14.intel.com ([192.55.52.115]:46687 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240737AbhL3Xij (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Dec 2021 18:38:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640907519; x=1672443519;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=3yY439yXfoQZ4kekA93dhwUu45G0YSK7uQTTdzEitAs=;
  b=QNZ5iDa9q2gFuJiVlZHIcs8Gb5D6qJE6va9FKjcb08VLApqRdO+RrymU
   1SLXPcIbmsvfWws4bp88u+kZpFIKZBa5JBTkCk4rFBOhQrEqRhhCYj/6J
   eUXTkVPRT0ai3RhCOgbwdMEBN5zDIUqIt0dKPjk29Xd6FuMwPz8+An8Bh
   bEK8OJCjnzUImaea4+RrkT3YNE4Dh202AZQPTmdDdRwwnWIqkt1QiyMgY
   TbMGqGSjHmoCPH2RpNGIV8miGuGyuQjLFPb3Dqn3sZay8dHhuAJboLRAn
   GpC+XFkBBxUWEYzWiFp1q14vo4XsDAWbw27zIN8drVZkuJN3DNeD8yG5X
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10213"; a="241954852"
X-IronPort-AV: E=Sophos;i="5.88,248,1635231600"; 
   d="scan'208";a="241954852"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Dec 2021 15:38:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,248,1635231600"; 
   d="scan'208";a="554916037"
Received: from lkp-server01.sh.intel.com (HELO e357b3ef1427) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 30 Dec 2021 15:38:37 -0800
Received: from kbuild by e357b3ef1427 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n350G-000AlU-HV; Thu, 30 Dec 2021 23:38:36 +0000
Date:   Fri, 31 Dec 2021 07:37:44 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:master] BUILD SUCCESS
 2ad9a070f0d50bbb03200c1554bb2c9749987d97
Message-ID: <61ce42c8.TejpZLJbdRhBYZqJ%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git master
branch HEAD: 2ad9a070f0d50bbb03200c1554bb2c9749987d97  Merge branch into tip/master: 'x86/build'

elapsed time: 722m

configs tested: 164
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                               defconfig
arm                              allmodconfig
arm64                            allyesconfig
arm                              allyesconfig
i386                 randconfig-c001-20211230
i386                 randconfig-c001-20211228
arm                            hisi_defconfig
riscv                             allnoconfig
mips                       lemote2f_defconfig
powerpc                     ppa8548_defconfig
powerpc                      makalu_defconfig
sh                           se7780_defconfig
arm                         at91_dt_defconfig
powerpc                 mpc832x_rdb_defconfig
sh                          sdk7780_defconfig
powerpc                    mvme5100_defconfig
ia64                        generic_defconfig
powerpc                 mpc8313_rdb_defconfig
sh                         apsh4a3a_defconfig
arm                       multi_v4t_defconfig
sh                   rts7751r2dplus_defconfig
sh                           se7721_defconfig
powerpc                     tqm8541_defconfig
powerpc                   bluestone_defconfig
sh                          landisk_defconfig
arm                          moxart_defconfig
arm                       imx_v6_v7_defconfig
alpha                               defconfig
mips                malta_qemu_32r6_defconfig
arm                            pleb_defconfig
powerpc                     pseries_defconfig
arm                           sama7_defconfig
mips                        vocore2_defconfig
arm                      jornada720_defconfig
mips                          rm200_defconfig
powerpc                      pmac32_defconfig
powerpc                     kilauea_defconfig
sh                          lboxre2_defconfig
mips                     loongson2k_defconfig
openrisc                         alldefconfig
mips                        bcm63xx_defconfig
h8300                       h8s-sim_defconfig
powerpc                          g5_defconfig
arm                           spitz_defconfig
powerpc                mpc7448_hpc2_defconfig
arm                          pxa168_defconfig
i386                             alldefconfig
arm                            qcom_defconfig
sh                             sh03_defconfig
powerpc                    klondike_defconfig
m68k                                defconfig
powerpc                 mpc834x_itx_defconfig
powerpc                       eiger_defconfig
xtensa                          iss_defconfig
ia64                            zx1_defconfig
arm                       spear13xx_defconfig
mips                   sb1250_swarm_defconfig
sh                                  defconfig
um                               alldefconfig
mips                            gpr_defconfig
m68k                           sun3_defconfig
powerpc                 mpc836x_mds_defconfig
powerpc                    ge_imp3a_defconfig
mips                           mtx1_defconfig
sh                ecovec24-romimage_defconfig
arm                        mini2440_defconfig
xtensa                           alldefconfig
sh                            migor_defconfig
arc                          axs101_defconfig
nios2                         10m50_defconfig
arm                           sama5_defconfig
mips                            ar7_defconfig
xtensa                       common_defconfig
arc                              allyesconfig
arm                        spear6xx_defconfig
arc                         haps_hs_defconfig
powerpc                     ep8248e_defconfig
sh                        sh7785lcr_defconfig
sh                           se7750_defconfig
m68k                       m5475evb_defconfig
sh                          sdk7786_defconfig
parisc                generic-64bit_defconfig
riscv                            allmodconfig
arm                  randconfig-c002-20211230
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                             allyesconfig
nios2                               defconfig
nds32                             allnoconfig
nds32                               defconfig
nios2                            allyesconfig
csky                                defconfig
alpha                            allyesconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
xtensa                           allyesconfig
parisc                              defconfig
s390                             allyesconfig
s390                             allmodconfig
parisc                           allyesconfig
s390                                defconfig
sparc                               defconfig
i386                                defconfig
i386                             allyesconfig
sparc                            allyesconfig
i386                              debian-10.3
i386                   debian-10.3-kselftests
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a013-20211230
x86_64               randconfig-a015-20211230
x86_64               randconfig-a012-20211230
x86_64               randconfig-a011-20211230
x86_64               randconfig-a016-20211230
x86_64               randconfig-a014-20211230
i386                 randconfig-a011-20211230
i386                 randconfig-a012-20211230
i386                 randconfig-a013-20211230
i386                 randconfig-a014-20211230
i386                 randconfig-a015-20211230
i386                 randconfig-a016-20211230
arc                  randconfig-r043-20211230
riscv                randconfig-r042-20211230
s390                 randconfig-r044-20211230
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                               defconfig
riscv                          rv32_defconfig
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                           allyesconfig
x86_64                    rhel-8.3-kselftests
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
i386                 randconfig-a005-20211230
i386                 randconfig-a004-20211230
i386                 randconfig-a002-20211230
i386                 randconfig-a006-20211230
i386                 randconfig-a003-20211230
x86_64               randconfig-a015-20211228
x86_64               randconfig-a014-20211228
x86_64               randconfig-a013-20211228
x86_64               randconfig-a012-20211228
x86_64               randconfig-a011-20211228
x86_64               randconfig-a016-20211228
hexagon              randconfig-r041-20211230
hexagon              randconfig-r045-20211230

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
