Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3BEB4D9B99
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 13:50:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348486AbiCOMvK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 08:51:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348389AbiCOMvI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 08:51:08 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D52635004B
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 05:49:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647348591; x=1678884591;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=SfW00ZwuA7gEkmiM+FXaiu2fQPLJNs0OT34MPTvSSQs=;
  b=XnTHuINrC/cW7bnNpgJfbHzuBPheA8zYaiK1/3TzqEgCaPmyn62V6L+u
   CoNyv05ibkw74AYvi0sJjjlIiIedkm10LIsYc6xsTHLTejEHgsU3AK9Jy
   fwEUWz/OzyjWKUpTtHLW3OJB3FHZ7Tya7kg2SQukVEaT7v7cO4M5v9oqP
   DvIuU9acW14RP/gaPanjhd2DiJb5GiJ98vHMpkhwNTKyjQc9MuEae7nqx
   l04NpXgfCsYKUfa8a7/q4MqOSbd3NeuW4aA4cckmennbxsTTDfQB6X6W+
   LpBlIVlDG1qR1a4Kp6W2nkHiLSd6rxFjI5S9MEMgpM2p4matb+c1uxJcK
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10286"; a="256479668"
X-IronPort-AV: E=Sophos;i="5.90,183,1643702400"; 
   d="scan'208";a="256479668"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2022 05:49:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,183,1643702400"; 
   d="scan'208";a="580499979"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 15 Mar 2022 05:49:49 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nU6cX-000AyP-62; Tue, 15 Mar 2022 12:49:49 +0000
Date:   Tue, 15 Mar 2022 20:48:51 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:irq/core] BUILD SUCCESS
 411472ae5bb4ffe1404dc5f1505f07e0f04770a8
Message-ID: <62308b33.8UkgkMRjr/LI873X%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq/core
branch HEAD: 411472ae5bb4ffe1404dc5f1505f07e0f04770a8  Merge tag 'v5.17-rc8' into irq/core, to fix conflicts

elapsed time: 725m

configs tested: 170
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
powerpc                      pasemi_defconfig
arm                       imx_v6_v7_defconfig
xtensa                              defconfig
arm                         nhk8815_defconfig
x86_64                              defconfig
sh                        edosk7760_defconfig
powerpc                     taishan_defconfig
sh                          lboxre2_defconfig
um                           x86_64_defconfig
arm                         lpc18xx_defconfig
arm                       aspeed_g5_defconfig
m68k                        stmark2_defconfig
arc                          axs101_defconfig
openrisc                  or1klitex_defconfig
arm                            xcep_defconfig
riscv             nommu_k210_sdcard_defconfig
sh                            migor_defconfig
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
mips                           jazz_defconfig
sh                   secureedge5410_defconfig
h8300                     edosk2674_defconfig
m68k                         apollo_defconfig
powerpc                      arches_defconfig
m68k                                defconfig
arm                           h5000_defconfig
sh                          rsk7201_defconfig
arc                          axs103_defconfig
parisc                generic-64bit_defconfig
powerpc                 mpc834x_mds_defconfig
sh                         microdev_defconfig
sh                     sh7710voipgw_defconfig
powerpc                     pq2fads_defconfig
sh                          kfr2r09_defconfig
parisc                              defconfig
openrisc                 simple_smp_defconfig
m68k                       m5208evb_defconfig
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
nios2                            allyesconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
xtensa                           allyesconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
s390                             allyesconfig
s390                             allmodconfig
parisc64                            defconfig
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
arc                  randconfig-r043-20220313
riscv                randconfig-r042-20220313
s390                 randconfig-r044-20220313
arc                  randconfig-r043-20220314
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
mips                   sb1250_swarm_defconfig
arm                     davinci_all_defconfig
powerpc                       ebony_defconfig
mips                      bmips_stb_defconfig
arm                       cns3420vb_defconfig
arm                      pxa255-idp_defconfig
arm                        magician_defconfig
powerpc                 mpc8315_rdb_defconfig
arm                          imote2_defconfig
mips                           mtx1_defconfig
powerpc                      pmac32_defconfig
powerpc                          allyesconfig
powerpc               mpc834x_itxgp_defconfig
mips                     cu1000-neo_defconfig
arm                           omap1_defconfig
mips                          ath25_defconfig
i386                             allyesconfig
mips                malta_qemu_32r6_defconfig
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64               randconfig-a014-20220314
x86_64               randconfig-a015-20220314
x86_64               randconfig-a016-20220314
x86_64               randconfig-a012-20220314
x86_64               randconfig-a013-20220314
x86_64               randconfig-a011-20220314
i386                          randconfig-a011
i386                          randconfig-a013
i386                          randconfig-a015
i386                 randconfig-a013-20220314
i386                 randconfig-a015-20220314
i386                 randconfig-a014-20220314
i386                 randconfig-a011-20220314
i386                 randconfig-a016-20220314
i386                 randconfig-a012-20220314
hexagon              randconfig-r045-20220314
hexagon              randconfig-r045-20220313
riscv                randconfig-r042-20220314
hexagon              randconfig-r041-20220313
hexagon              randconfig-r041-20220314
s390                 randconfig-r044-20220314

---
0-DAY CI Kernel Test Service
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
