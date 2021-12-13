Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6F854737B8
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 23:42:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243606AbhLMWmK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 17:42:10 -0500
Received: from mga06.intel.com ([134.134.136.31]:56984 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243753AbhLMWmA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 17:42:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639435320; x=1670971320;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=8MQdGwojxAw7y4szkMSyqsqVvv0P2kGBswWuxrRjxU4=;
  b=JIASZ9ftIptAvzqexJqEmIfDD0vz75SG1nwKvjzJyYnLpkQXCz2fCkGA
   8EDd0E7sryM+T4r22/CUpbuWk99QEPHXhsHUk7nJvLSAeF/VluiMBUqDI
   XIsCEgIrsydYJvBGnKynls5/Btm0HAjPr9HuoKkd2iO2JB9FW162LHeoj
   eNKLKXY+MHykWgEZbjiBfFWwxkNixWNRAzeDt2VNXADTk+dbhbJ2WPCmk
   mvwgUPOQkWWoTvDcwg4N0E40dOrZqSx3xZ7dwIclw/AXZ6FnR/PFxbIcK
   Cqvu7MqyzfHnVN5udDBgJp1kkjegpY8QNXb+XRWYH8hvf+rGcisuWlDkS
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10197"; a="299627281"
X-IronPort-AV: E=Sophos;i="5.88,203,1635231600"; 
   d="scan'208";a="299627281"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2021 14:42:00 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,203,1635231600"; 
   d="scan'208";a="583065288"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by fmsmga004.fm.intel.com with ESMTP; 13 Dec 2021 14:41:58 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mwu18-000796-77; Mon, 13 Dec 2021 22:41:58 +0000
Date:   Tue, 14 Dec 2021 06:41:37 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:locking/core] BUILD SUCCESS
 5fb6e8cf53b005d287d4c2d137a415ff7d025a81
Message-ID: <61b7cc21.t8/whQ+qZrxmL+AP%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git locking/core
branch HEAD: 5fb6e8cf53b005d287d4c2d137a415ff7d025a81  locking/atomic: atomic64: Remove unusable atomic ops

elapsed time: 731m

configs tested: 208
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
i386                 randconfig-c001-20211213
powerpc                      pasemi_defconfig
mips                        jmr3927_defconfig
powerpc                       holly_defconfig
powerpc                          allmodconfig
sh                          landisk_defconfig
powerpc                         wii_defconfig
powerpc                      acadia_defconfig
arm                        magician_defconfig
arm                        oxnas_v6_defconfig
powerpc                     ep8248e_defconfig
arm                           omap1_defconfig
mips                  decstation_64_defconfig
powerpc                 mpc837x_rdb_defconfig
powerpc                     tqm5200_defconfig
powerpc                      walnut_defconfig
sh                ecovec24-romimage_defconfig
mips                           xway_defconfig
arm                        keystone_defconfig
powerpc                      pcm030_defconfig
mips                     loongson1b_defconfig
powerpc                      katmai_defconfig
powerpc                        warp_defconfig
ia64                      gensparse_defconfig
sh                           se7705_defconfig
powerpc                   motionpro_defconfig
arm                       imx_v6_v7_defconfig
arm                         s5pv210_defconfig
powerpc                     taishan_defconfig
arm                          pxa3xx_defconfig
sh                           se7722_defconfig
arc                     haps_hs_smp_defconfig
mips                     decstation_defconfig
mips                          rm200_defconfig
xtensa                  audio_kc705_defconfig
mips                     cu1830-neo_defconfig
mips                           mtx1_defconfig
mips                     loongson1c_defconfig
mips                           rs90_defconfig
powerpc                      ppc6xx_defconfig
powerpc                   currituck_defconfig
sparc                       sparc32_defconfig
arm                      integrator_defconfig
sh                     magicpanelr2_defconfig
powerpc                   bluestone_defconfig
m68k                       m5249evb_defconfig
s390                             allyesconfig
arc                        vdk_hs38_defconfig
arc                                 defconfig
xtensa                              defconfig
powerpc                 mpc834x_mds_defconfig
powerpc                 mpc85xx_cds_defconfig
mips                           gcw0_defconfig
mips                         tb0219_defconfig
powerpc                       ebony_defconfig
arm                        trizeps4_defconfig
arm                       aspeed_g4_defconfig
sh                         ap325rxa_defconfig
m68k                            mac_defconfig
sh                             shx3_defconfig
arm                          pxa168_defconfig
arc                          axs103_defconfig
arm                         at91_dt_defconfig
arm                       spear13xx_defconfig
powerpc64                        alldefconfig
sh                        sh7785lcr_defconfig
m68k                        stmark2_defconfig
powerpc                    ge_imp3a_defconfig
powerpc                     pq2fads_defconfig
arm                       cns3420vb_defconfig
arm                            hisi_defconfig
powerpc                      pmac32_defconfig
xtensa                  cadence_csp_defconfig
i386                             alldefconfig
powerpc                 mpc8560_ads_defconfig
m68k                                defconfig
xtensa                  nommu_kc705_defconfig
sh                          kfr2r09_defconfig
sh                          r7785rp_defconfig
powerpc                     mpc83xx_defconfig
sh                           sh2007_defconfig
arc                     nsimosci_hs_defconfig
powerpc                    sam440ep_defconfig
m68k                       m5208evb_defconfig
m68k                         apollo_defconfig
sh                              ul2_defconfig
sh                   sh7724_generic_defconfig
m68k                        m5307c3_defconfig
sh                            migor_defconfig
sh                        edosk7705_defconfig
m68k                       bvme6000_defconfig
powerpc                 canyonlands_defconfig
arm                           sunxi_defconfig
mips                           ip22_defconfig
powerpc                     tqm8541_defconfig
sh                 kfr2r09-romimage_defconfig
powerpc                      ppc64e_defconfig
mips                       rbtx49xx_defconfig
openrisc                         alldefconfig
mips                         bigsur_defconfig
arc                 nsimosci_hs_smp_defconfig
openrisc                            defconfig
powerpc                  iss476-smp_defconfig
nds32                               defconfig
arm                      tct_hammer_defconfig
mips                           ip32_defconfig
h8300                    h8300h-sim_defconfig
m68k                          hp300_defconfig
mips                          malta_defconfig
powerpc                     ksi8560_defconfig
h8300                       h8s-sim_defconfig
arm                       multi_v4t_defconfig
mips                      loongson3_defconfig
mips                         tb0287_defconfig
sh                          r7780mp_defconfig
ia64                        generic_defconfig
arm                            qcom_defconfig
sh                           se7724_defconfig
mips                      bmips_stb_defconfig
mips                         mpc30x_defconfig
mips                        vocore2_defconfig
mips                      pic32mzda_defconfig
powerpc                     mpc512x_defconfig
m68k                          multi_defconfig
arm                  randconfig-c002-20211213
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
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
sh                               allmodconfig
parisc                              defconfig
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
powerpc                           allnoconfig
x86_64               randconfig-a011-20211213
x86_64               randconfig-a012-20211213
x86_64               randconfig-a014-20211213
x86_64               randconfig-a013-20211213
x86_64               randconfig-a016-20211213
x86_64               randconfig-a015-20211213
i386                 randconfig-a013-20211213
i386                 randconfig-a011-20211213
i386                 randconfig-a016-20211213
i386                 randconfig-a014-20211213
i386                 randconfig-a015-20211213
i386                 randconfig-a012-20211213
arc                  randconfig-r043-20211213
riscv                randconfig-r042-20211213
s390                 randconfig-r044-20211213
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
x86_64               randconfig-c007-20211213
arm                  randconfig-c002-20211213
riscv                randconfig-c006-20211213
mips                 randconfig-c004-20211213
i386                 randconfig-c001-20211213
s390                 randconfig-c005-20211213
powerpc              randconfig-c003-20211213
i386                 randconfig-a001-20211213
i386                 randconfig-a002-20211213
i386                 randconfig-a005-20211213
i386                 randconfig-a003-20211213
i386                 randconfig-a006-20211213
i386                 randconfig-a004-20211213
x86_64               randconfig-a006-20211213
x86_64               randconfig-a005-20211213
x86_64               randconfig-a001-20211213
x86_64               randconfig-a002-20211213
x86_64               randconfig-a003-20211213
x86_64               randconfig-a004-20211213
hexagon              randconfig-r045-20211213
hexagon              randconfig-r041-20211213

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
