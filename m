Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0753D4A7279
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 15:01:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240101AbiBBOBK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 09:01:10 -0500
Received: from mga02.intel.com ([134.134.136.20]:20731 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230213AbiBBOBJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 09:01:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643810469; x=1675346469;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=BVLR4R6agZi5mVRsS/hmDlvwLWMSe5BBSlWfL7V3KdM=;
  b=PLSiXKIt9nbyJbWtaqNrIxkwjMlmDWxdVLxf+vzNxJMhJRaKAeGW43Yc
   RhzUw22+QWnIYXloa9kzt22JF9Sf0aE4ldqcHHyk1Jak2KeJm2eOggePc
   PybNS0r8QT3KfmWoSVTsUzuQfpxHdnZn5z4jFIFFG+XzLbUGofFmkJEWB
   5KQ6iNTvJUbAw1YUzk6R/+Cc8q1X2X9xUvO2wyrUTbg/QNk4ljDYwu9fg
   9ATSOFSFjuDLaHQoCdqaCobqP7H/k/LcP3pRpQJiBO8fkzsXIaDmE2LxE
   ZhnybLK2QHkFhhuKdoR12tUx2/G2M/+zloecbnL9c2bThUXD3gqBhwBTG
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10245"; a="235316496"
X-IronPort-AV: E=Sophos;i="5.88,337,1635231600"; 
   d="scan'208";a="235316496"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2022 06:01:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,337,1635231600"; 
   d="scan'208";a="771447096"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 02 Feb 2022 06:01:02 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nFGBx-000Ufo-Rv; Wed, 02 Feb 2022 14:01:01 +0000
Date:   Wed, 02 Feb 2022 22:00:34 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:rcu/next] BUILD SUCCESS
 8194b9a5e4a00eb738b15093d67d9aee9cf0ba96
Message-ID: <61fa8e82.Sr2/z9sAxUwzgbun%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git rcu/next
branch HEAD: 8194b9a5e4a00eb738b15093d67d9aee9cf0ba96  tools/memory-model: Explain syntactic and semantic dependencies

elapsed time: 723m

configs tested: 179
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
i386                 randconfig-c001-20220131
i386                          randconfig-c001
arm                            zeus_defconfig
sh                          rsk7269_defconfig
sh                   sh7770_generic_defconfig
powerpc                 mpc85xx_cds_defconfig
powerpc                 mpc837x_rdb_defconfig
s390                       zfcpdump_defconfig
sh                           se7206_defconfig
powerpc                     redwood_defconfig
h8300                            alldefconfig
m68k                       m5475evb_defconfig
m68k                             allmodconfig
powerpc                      ppc40x_defconfig
mips                      maltasmvp_defconfig
sh                             sh03_defconfig
powerpc                     rainier_defconfig
arm                             rpc_defconfig
arm                          lpd270_defconfig
powerpc                    amigaone_defconfig
powerpc                      ppc6xx_defconfig
arm                        mvebu_v7_defconfig
arc                     nsimosci_hs_defconfig
arm                        trizeps4_defconfig
arc                        vdk_hs38_defconfig
arc                      axs103_smp_defconfig
sh                           se7619_defconfig
sh                        apsh4ad0a_defconfig
sh                        dreamcast_defconfig
arm                      jornada720_defconfig
sh                           se7705_defconfig
sh                                  defconfig
mips                        vocore2_defconfig
m68k                        mvme147_defconfig
mips                           ip32_defconfig
sh                            migor_defconfig
arm                        multi_v7_defconfig
sh                           se7343_defconfig
powerpc                      tqm8xx_defconfig
arm                     eseries_pxa_defconfig
um                             i386_defconfig
powerpc                mpc7448_hpc2_defconfig
ia64                      gensparse_defconfig
mips                         db1xxx_defconfig
mips                         mpc30x_defconfig
m68k                           sun3_defconfig
powerpc                  iss476-smp_defconfig
sh                          rsk7203_defconfig
sh                        edosk7760_defconfig
sh                           se7721_defconfig
powerpc                     stx_gp3_defconfig
sh                         ecovec24_defconfig
mips                         rt305x_defconfig
powerpc                      pasemi_defconfig
powerpc                     taishan_defconfig
xtensa                              defconfig
nios2                               defconfig
h8300                     edosk2674_defconfig
arm                         axm55xx_defconfig
sh                          sdk7786_defconfig
arm                        oxnas_v6_defconfig
powerpc                     tqm8541_defconfig
m68k                       m5208evb_defconfig
arc                           tb10x_defconfig
powerpc                   currituck_defconfig
csky                             alldefconfig
xtensa                       common_defconfig
arm                  randconfig-c002-20220130
arm                  randconfig-c002-20220131
arm                  randconfig-c002-20220202
arm                  randconfig-c002-20220201
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                                defconfig
m68k                             allyesconfig
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
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a004-20220131
x86_64               randconfig-a003-20220131
x86_64               randconfig-a001-20220131
x86_64               randconfig-a006-20220131
x86_64               randconfig-a005-20220131
x86_64               randconfig-a002-20220131
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
arc                  randconfig-r043-20220130
s390                 randconfig-r044-20220130
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
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
riscv                randconfig-c006-20220130
x86_64                        randconfig-c007
arm                  randconfig-c002-20220130
powerpc              randconfig-c003-20220130
mips                 randconfig-c004-20220130
i386                          randconfig-c001
arm                     davinci_all_defconfig
arm                       mainstone_defconfig
powerpc               mpc834x_itxgp_defconfig
powerpc                   microwatt_defconfig
arm                    vt8500_v6_v7_defconfig
powerpc                    gamecube_defconfig
arm                        magician_defconfig
arm                         lpc32xx_defconfig
powerpc                 xes_mpc85xx_defconfig
powerpc                 mpc8313_rdb_defconfig
mips                      maltaaprp_defconfig
arm                       cns3420vb_defconfig
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
riscv                randconfig-r042-20220131
hexagon              randconfig-r045-20220130
hexagon              randconfig-r045-20220131
hexagon              randconfig-r041-20220130
hexagon              randconfig-r041-20220131

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
