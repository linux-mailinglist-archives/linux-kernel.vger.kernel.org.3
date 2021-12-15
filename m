Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6D9D476220
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 20:49:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233051AbhLOTtU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 14:49:20 -0500
Received: from mga05.intel.com ([192.55.52.43]:10109 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232964AbhLOTtT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 14:49:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639597759; x=1671133759;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=QHNVJe/Sb6OvAELRCZLwH/QPVt6nmfGJYlip4O68DuE=;
  b=RzYpPq5nIy7M5jjdG2jobyg2oBBJe2BVJS8E4okgO3emr7FbgxHBK2mS
   AeDfRqoTOTsXCw27P3wcYMPlalbEw67aX0Sj4Txp9uuVQxeBwXOzfCcAB
   9qXkmYjwiJHTUcquYFMrg2TuURJQZw9o6EdwEM1JbqnLJtEAIpvvOpUXq
   I9K/sFtTKHKs8MlGN/udb33ncvM4dvOSH4Elg0vsrbh0mJJEa9hqAKIvg
   uf5R7FeSiNmzeFspkVjZuhToTrgxyP2HUQZBQ092xLHUMZ/X5BdgtX4qr
   hhJmkrOzCJr0WstK+5AExZ6VyZ0B5yeuna1gZLRh5Xrp4KtYwW9oIx6z0
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10199"; a="325601282"
X-IronPort-AV: E=Sophos;i="5.88,207,1635231600"; 
   d="scan'208";a="325601282"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2021 11:49:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,207,1635231600"; 
   d="scan'208";a="518917083"
Received: from lkp-server02.sh.intel.com (HELO 9f38c0981d9f) ([10.239.97.151])
  by orsmga008.jf.intel.com with ESMTP; 15 Dec 2021 11:49:16 -0800
Received: from kbuild by 9f38c0981d9f with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mxaH5-0002G3-TM; Wed, 15 Dec 2021 19:49:15 +0000
Date:   Thu, 16 Dec 2021 03:48:22 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:rcu/next] BUILD SUCCESS
 461aa9e31a368be5d28ff538fcd26a042cdf927a
Message-ID: <61ba4686.b+nnlbR9DBHK5kku%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git rcu/next
branch HEAD: 461aa9e31a368be5d28ff538fcd26a042cdf927a  rcu: Make rcu_barrier() no longer block CPU-hotplug operations

elapsed time: 726m

configs tested: 203
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
i386                 randconfig-c001-20211214
i386                 randconfig-c001-20211215
sh                 kfr2r09-romimage_defconfig
xtensa                    xip_kc705_defconfig
powerpc                    klondike_defconfig
powerpc                   bluestone_defconfig
arm                          pcm027_defconfig
mips                           rs90_defconfig
h8300                            alldefconfig
powerpc                     mpc512x_defconfig
sh                          urquell_defconfig
mips                      bmips_stb_defconfig
arm                            hisi_defconfig
powerpc                      acadia_defconfig
arm                            mps2_defconfig
mips                           ip22_defconfig
powerpc                   motionpro_defconfig
powerpc                 mpc834x_itx_defconfig
sh                               alldefconfig
arm                             mxs_defconfig
arm                            zeus_defconfig
s390                             allyesconfig
powerpc                      ppc64e_defconfig
arm                         lpc32xx_defconfig
m68k                          multi_defconfig
powerpc                      pasemi_defconfig
powerpc                    gamecube_defconfig
powerpc64                        alldefconfig
m68k                          sun3x_defconfig
arm                         s5pv210_defconfig
mips                         tb0226_defconfig
sh                          polaris_defconfig
mips                     loongson2k_defconfig
arc                 nsimosci_hs_smp_defconfig
powerpc                 mpc834x_mds_defconfig
powerpc                 mpc836x_mds_defconfig
sh                          r7780mp_defconfig
csky                             alldefconfig
arm                   milbeaut_m10v_defconfig
arm                  colibri_pxa270_defconfig
powerpc                      makalu_defconfig
arm                      jornada720_defconfig
arm                       imx_v4_v5_defconfig
powerpc                 mpc832x_rdb_defconfig
arm                          lpd270_defconfig
powerpc                     ppa8548_defconfig
mips                      maltaaprp_defconfig
arm                          imote2_defconfig
powerpc                     asp8347_defconfig
mips                        maltaup_defconfig
sh                   sh7770_generic_defconfig
sh                  sh7785lcr_32bit_defconfig
mips                        bcm63xx_defconfig
sparc                               defconfig
sh                         microdev_defconfig
powerpc                     stx_gp3_defconfig
sh                      rts7751r2d1_defconfig
parisc                           alldefconfig
m68k                        m5307c3_defconfig
xtensa                          iss_defconfig
sh                            shmin_defconfig
m68k                        stmark2_defconfig
powerpc                 mpc832x_mds_defconfig
i386                             alldefconfig
mips                    maltaup_xpa_defconfig
sparc                       sparc32_defconfig
h8300                               defconfig
openrisc                            defconfig
powerpc                       ppc64_defconfig
powerpc                      pmac32_defconfig
m68k                             alldefconfig
arm                            qcom_defconfig
sh                           se7724_defconfig
sparc64                             defconfig
h8300                    h8300h-sim_defconfig
powerpc                      tqm8xx_defconfig
arm                          gemini_defconfig
mips                          rb532_defconfig
sh                              ul2_defconfig
arm                         socfpga_defconfig
powerpc                      bamboo_defconfig
ia64                         bigsur_defconfig
arm                        multi_v5_defconfig
arm                        oxnas_v6_defconfig
powerpc                 linkstation_defconfig
parisc                generic-32bit_defconfig
arm                        neponset_defconfig
arc                          axs103_defconfig
powerpc                 xes_mpc85xx_defconfig
arc                            hsdk_defconfig
xtensa                       common_defconfig
powerpc                          g5_defconfig
arm                           sama7_defconfig
arm                  randconfig-c002-20211214
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
s390                             allmodconfig
parisc                           allyesconfig
s390                                defconfig
i386                             allyesconfig
sparc                            allyesconfig
i386                                defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a006-20211214
x86_64               randconfig-a005-20211214
x86_64               randconfig-a001-20211214
x86_64               randconfig-a002-20211214
x86_64               randconfig-a003-20211214
x86_64               randconfig-a004-20211214
i386                 randconfig-a001-20211214
i386                 randconfig-a002-20211214
i386                 randconfig-a005-20211214
i386                 randconfig-a003-20211214
i386                 randconfig-a006-20211214
i386                 randconfig-a004-20211214
x86_64               randconfig-a011-20211215
x86_64               randconfig-a014-20211215
x86_64               randconfig-a012-20211215
x86_64               randconfig-a013-20211215
x86_64               randconfig-a016-20211215
x86_64               randconfig-a015-20211215
i386                 randconfig-a013-20211215
i386                 randconfig-a011-20211215
i386                 randconfig-a016-20211215
i386                 randconfig-a014-20211215
i386                 randconfig-a015-20211215
i386                 randconfig-a012-20211215
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
arm                  randconfig-c002-20211214
x86_64               randconfig-c007-20211214
riscv                randconfig-c006-20211214
mips                 randconfig-c004-20211214
i386                 randconfig-c001-20211214
s390                 randconfig-c005-20211214
powerpc              randconfig-c003-20211214
arm                  randconfig-c002-20211215
x86_64               randconfig-c007-20211215
riscv                randconfig-c006-20211215
mips                 randconfig-c004-20211215
i386                 randconfig-c001-20211215
s390                 randconfig-c005-20211215
powerpc              randconfig-c003-20211215
i386                 randconfig-a001-20211215
i386                 randconfig-a002-20211215
i386                 randconfig-a005-20211215
i386                 randconfig-a003-20211215
i386                 randconfig-a006-20211215
i386                 randconfig-a004-20211215
x86_64               randconfig-a011-20211214
x86_64               randconfig-a014-20211214
x86_64               randconfig-a012-20211214
x86_64               randconfig-a013-20211214
x86_64               randconfig-a016-20211214
x86_64               randconfig-a015-20211214
i386                 randconfig-a013-20211214
i386                 randconfig-a011-20211214
i386                 randconfig-a016-20211214
i386                 randconfig-a014-20211214
i386                 randconfig-a015-20211214
i386                 randconfig-a012-20211214
hexagon              randconfig-r045-20211214
s390                 randconfig-r044-20211214
riscv                randconfig-r042-20211214
hexagon              randconfig-r041-20211214

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
