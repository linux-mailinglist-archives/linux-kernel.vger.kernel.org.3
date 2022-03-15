Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35EE54D92DE
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 04:13:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344592AbiCODOt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 23:14:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233712AbiCODOr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 23:14:47 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EFAFDEC8
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 20:13:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647314016; x=1678850016;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=RaWSIShl4ewaaeMrT1kRnoPFYViSpQuNIZzcrXDEOTQ=;
  b=QF1jfOhKzrZ9UDnD7QKW2XYdIp/KxZsHyZTl0gGDWMk3Ncjy/MXm0Ebe
   3gFfvTeTN4CJBZtzbWR4ZXgZuoSBgbb0yGAWhx3NZS68GRzQ683Mhvg8J
   VIWJ4wCJblEekBi2kJVI4eEstBmWb/kMvoL9DhvBDc+zANhRQyxzBEyfv
   NhoJBYjF6xzphqn/X47iYRKwC1Gik/yCpMbbyj/f9p7ur3BZgRewxcBnd
   E+HzyY6imT1d97fusiijYVjehWdGLS0F8CgJN081jQir33hyyNQ//OewC
   wMHCXzAqOCRkP8Xc/TlYxOXiguBPaUu16nTZd5RmhMlCmLtip0iI2X2Wg
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10286"; a="243651521"
X-IronPort-AV: E=Sophos;i="5.90,182,1643702400"; 
   d="scan'208";a="243651521"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2022 20:13:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,182,1643702400"; 
   d="scan'208";a="497859477"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 14 Mar 2022 20:13:34 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nTxcr-000AUY-T0; Tue, 15 Mar 2022 03:13:33 +0000
Date:   Tue, 15 Mar 2022 11:13:23 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:timers/core] BUILD SUCCESS
 b166e52541f2357ce126a92ce1d9a580fdca719d
Message-ID: <62300453.JvHs7y1u/51gA9mF%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers/core
branch HEAD: b166e52541f2357ce126a92ce1d9a580fdca719d  Merge tag 'timers-v5.18-rc1' of https://git.linaro.org/people/daniel.lezcano/linux into timers/core

elapsed time: 725m

configs tested: 192
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
i386                          randconfig-c001
i386                 randconfig-c001-20220314
mips                 randconfig-c004-20220314
powerpc              randconfig-c003-20220313
arm                            zeus_defconfig
sh                                  defconfig
mips                           xway_defconfig
arm                          pxa910_defconfig
m68k                          multi_defconfig
powerpc                      pasemi_defconfig
arm                       imx_v6_v7_defconfig
x86_64                              defconfig
xtensa                              defconfig
arm                         nhk8815_defconfig
mips                       bmips_be_defconfig
parisc64                            defconfig
arm                          simpad_defconfig
sh                          rsk7264_defconfig
m68k                        mvme16x_defconfig
arm                         lpc18xx_defconfig
arm                       aspeed_g5_defconfig
m68k                        stmark2_defconfig
arm                             pxa_defconfig
arc                         haps_hs_defconfig
h8300                    h8300h-sim_defconfig
um                           x86_64_defconfig
alpha                            allyesconfig
ia64                         bigsur_defconfig
arc                          axs101_defconfig
openrisc                  or1klitex_defconfig
arm                            xcep_defconfig
riscv             nommu_k210_sdcard_defconfig
sh                            migor_defconfig
powerpc                         ps3_defconfig
i386                                defconfig
sh                             sh03_defconfig
m68k                           sun3_defconfig
m68k                        m5272c3_defconfig
powerpc                        cell_defconfig
sh                           se7705_defconfig
powerpc                      bamboo_defconfig
csky                             alldefconfig
parisc                generic-32bit_defconfig
powerpc                 mpc837x_mds_defconfig
powerpc                  storcenter_defconfig
arm                         vf610m4_defconfig
arm                        mini2440_defconfig
sh                        sh7785lcr_defconfig
mips                           jazz_defconfig
sh                   secureedge5410_defconfig
h8300                     edosk2674_defconfig
m68k                         apollo_defconfig
powerpc                      arches_defconfig
m68k                                defconfig
parisc                generic-64bit_defconfig
powerpc                 mpc834x_mds_defconfig
sh                         microdev_defconfig
sh                     sh7710voipgw_defconfig
arm                           stm32_defconfig
powerpc                       ppc64_defconfig
arm                            mps2_defconfig
sh                          lboxre2_defconfig
powerpc                     pq2fads_defconfig
sh                          kfr2r09_defconfig
openrisc                 simple_smp_defconfig
arc                     haps_hs_smp_defconfig
m68k                       m5475evb_defconfig
sh                           se7750_defconfig
mips                           ip32_defconfig
sh                   rts7751r2dplus_defconfig
m68k                       m5208evb_defconfig
nios2                            allyesconfig
mips                        bcm47xx_defconfig
arm                         axm55xx_defconfig
powerpc                mpc7448_hpc2_defconfig
mips                  decstation_64_defconfig
arm                  randconfig-c002-20220313
arm                  randconfig-c002-20220314
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
nds32                               defconfig
csky                                defconfig
alpha                               defconfig
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
i386                   debian-10.3-kselftests
i386                              debian-10.3
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64                        randconfig-a006
x86_64                        randconfig-a004
x86_64                        randconfig-a002
x86_64               randconfig-a004-20220314
x86_64               randconfig-a005-20220314
x86_64               randconfig-a003-20220314
x86_64               randconfig-a002-20220314
x86_64               randconfig-a006-20220314
x86_64               randconfig-a001-20220314
i386                 randconfig-a003-20220314
i386                 randconfig-a004-20220314
i386                 randconfig-a001-20220314
i386                 randconfig-a006-20220314
i386                 randconfig-a002-20220314
i386                 randconfig-a005-20220314
x86_64                        randconfig-a011
x86_64                        randconfig-a013
x86_64                        randconfig-a015
arc                  randconfig-r043-20220313
arc                  randconfig-r043-20220314
riscv                randconfig-r042-20220313
s390                 randconfig-r044-20220313
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                    rhel-8.3-kselftests
um                             i386_defconfig
x86_64                           allyesconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                         rhel-8.3-kunit
x86_64                                  kexec

clang tested configs:
arm                  randconfig-c002-20220313
x86_64                        randconfig-c007
powerpc              randconfig-c003-20220313
riscv                randconfig-c006-20220313
mips                 randconfig-c004-20220313
i386                          randconfig-c001
powerpc                       ebony_defconfig
mips                      bmips_stb_defconfig
arm                       cns3420vb_defconfig
arm                      pxa255-idp_defconfig
arm                        magician_defconfig
mips                           mtx1_defconfig
powerpc                      obs600_defconfig
powerpc                      ppc64e_defconfig
powerpc                      pmac32_defconfig
powerpc                          allyesconfig
powerpc               mpc834x_itxgp_defconfig
mips                     cu1000-neo_defconfig
arm                           omap1_defconfig
mips                          ath25_defconfig
powerpc                 mpc8313_rdb_defconfig
powerpc                      ppc44x_defconfig
i386                             allyesconfig
mips                malta_qemu_32r6_defconfig
powerpc                 mpc832x_rdb_defconfig
x86_64               randconfig-a014-20220314
x86_64               randconfig-a015-20220314
x86_64               randconfig-a016-20220314
x86_64               randconfig-a012-20220314
x86_64               randconfig-a013-20220314
x86_64               randconfig-a011-20220314
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
i386                 randconfig-a013-20220314
i386                 randconfig-a015-20220314
i386                 randconfig-a014-20220314
i386                 randconfig-a011-20220314
i386                 randconfig-a016-20220314
i386                 randconfig-a012-20220314
i386                          randconfig-a011
i386                          randconfig-a013
i386                          randconfig-a015
hexagon              randconfig-r045-20220314
hexagon              randconfig-r045-20220313
riscv                randconfig-r042-20220314
hexagon              randconfig-r041-20220313
hexagon              randconfig-r041-20220314

---
0-DAY CI Kernel Test Service
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
