Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2B874BD836
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 09:40:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231220AbiBUHze (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 02:55:34 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:40152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231187AbiBUHzd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 02:55:33 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93FFA1C138
        for <linux-kernel@vger.kernel.org>; Sun, 20 Feb 2022 23:55:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645430110; x=1676966110;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=6q38bKOqFfyNxLqkjpHkLDgq6iK4qAGDMQu7XOWSces=;
  b=cBakZBTOkzlrqrlTUOWxtTczln9QPInANUdOGB5wDxbZ4K5l4kRV91dA
   s+GOjYNLFGBkENILRFbkQIEnTKA+v9+TLwTd4oxMtllkxIHydWwY1h6Qc
   xeOlf2D7ZWJVXcB1fkubunsKO/GzdHhjCZsCQGa0AgAKt472DwChogTrv
   cpM9p8GLvCynmEKJc1MhActVl9owA0+feHZhg6X3lWonLrrj+Cv6rxI9f
   +p5X76GVcj3ZbxXFgrNSQsIM+5l9+67jS4AcH8lsKDas/rXaEdppqvSf5
   A10a40SmuFTKmMegg84kiMEBdG0ed56VBibtZrj/DWiSJo3akv7t1Yylx
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10264"; a="249037322"
X-IronPort-AV: E=Sophos;i="5.88,385,1635231600"; 
   d="scan'208";a="249037322"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2022 23:55:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,385,1635231600"; 
   d="scan'208";a="504916347"
Received: from lkp-server01.sh.intel.com (HELO da3212ac2f54) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 20 Feb 2022 23:55:08 -0800
Received: from kbuild by da3212ac2f54 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nM3XH-0001ON-RR; Mon, 21 Feb 2022 07:55:07 +0000
Date:   Mon, 21 Feb 2022 15:54:16 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:dev.2022.02.17a] BUILD SUCCESS
 f5b2eaf791ebbd6af881947ab7c40ed70681e534
Message-ID: <62134528.3+fHfGBwUHAC9iyM%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev.2022.02.17a
branch HEAD: f5b2eaf791ebbd6af881947ab7c40ed70681e534  EXP torture: Add tests demoing SLAB_TYPESAFE_BY_RCU

elapsed time: 726m

configs tested: 162
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
i386                 randconfig-c001-20220221
i386                          randconfig-c001
sh                          landisk_defconfig
powerpc                     redwood_defconfig
arm                          badge4_defconfig
arm                         lpc18xx_defconfig
powerpc                     pq2fads_defconfig
ia64                         bigsur_defconfig
mips                      maltasmvp_defconfig
mips                     decstation_defconfig
arm                           u8500_defconfig
m68k                        stmark2_defconfig
sh                        edosk7760_defconfig
powerpc                       ppc64_defconfig
powerpc                     tqm8555_defconfig
arm                       multi_v4t_defconfig
sh                          rsk7269_defconfig
mips                            gpr_defconfig
sh                                  defconfig
ia64                                defconfig
sh                         apsh4a3a_defconfig
sh                   sh7770_generic_defconfig
powerpc                    klondike_defconfig
alpha                               defconfig
m68k                        m5272c3_defconfig
xtensa                              defconfig
powerpc                      pcm030_defconfig
mips                       bmips_be_defconfig
h8300                            alldefconfig
sh                           se7705_defconfig
sh                          r7780mp_defconfig
xtensa                          iss_defconfig
arm                            mps2_defconfig
powerpc                    sam440ep_defconfig
powerpc                   motionpro_defconfig
sh                             espt_defconfig
sh                           se7343_defconfig
sh                   rts7751r2dplus_defconfig
nios2                         10m50_defconfig
arm                         lubbock_defconfig
sh                         ecovec24_defconfig
mips                           xway_defconfig
mips                      loongson3_defconfig
powerpc                       maple_defconfig
xtensa                         virt_defconfig
openrisc                            defconfig
xtensa                    smp_lx200_defconfig
powerpc                 canyonlands_defconfig
sh                          sdk7780_defconfig
arm                       aspeed_g5_defconfig
powerpc                        cell_defconfig
sh                          lboxre2_defconfig
sh                           se7750_defconfig
sparc64                             defconfig
nios2                            allyesconfig
arm                            zeus_defconfig
sh                        sh7763rdp_defconfig
powerpc                      bamboo_defconfig
m68k                       m5475evb_defconfig
powerpc                     ep8248e_defconfig
sh                     sh7710voipgw_defconfig
powerpc                      ppc6xx_defconfig
x86_64                        randconfig-c001
arm                  randconfig-c002-20220220
arm                  randconfig-c002-20220221
x86_64               randconfig-c001-20220221
ia64                             allmodconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
nds32                               defconfig
csky                                defconfig
alpha                            allyesconfig
xtensa                           allyesconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
parisc                              defconfig
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
i386                          randconfig-a003
i386                          randconfig-a005
i386                          randconfig-a001
i386                 randconfig-a002-20220221
i386                 randconfig-a001-20220221
i386                 randconfig-a005-20220221
i386                 randconfig-a003-20220221
i386                 randconfig-a006-20220221
i386                 randconfig-a004-20220221
x86_64                        randconfig-a011
x86_64                        randconfig-a015
x86_64                        randconfig-a013
x86_64                        randconfig-a004
x86_64                        randconfig-a002
x86_64                        randconfig-a006
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
arc                  randconfig-r043-20220220
riscv                randconfig-r042-20220220
s390                 randconfig-r044-20220220
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
powerpc              randconfig-c003-20220220
x86_64                        randconfig-c007
arm                  randconfig-c002-20220220
mips                 randconfig-c004-20220220
i386                          randconfig-c001
riscv                randconfig-c006-20220220
powerpc                    mvme5100_defconfig
powerpc                        fsp2_defconfig
powerpc                 mpc836x_mds_defconfig
mips                        workpad_defconfig
powerpc                   bluestone_defconfig
x86_64                        randconfig-a005
x86_64                        randconfig-a003
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
x86_64                        randconfig-a001
i386                          randconfig-a011
i386                          randconfig-a013
i386                          randconfig-a015
hexagon              randconfig-r045-20220220
hexagon              randconfig-r041-20220220

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
