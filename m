Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A2444D756F
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Mar 2022 14:21:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233942AbiCMNWJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Mar 2022 09:22:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229691AbiCMNWI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Mar 2022 09:22:08 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E36508B6F8
        for <linux-kernel@vger.kernel.org>; Sun, 13 Mar 2022 06:20:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647177659; x=1678713659;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=QERviCwVSAoQUHrhQVWEoX3/4nvWnf7i/kUx7bBVXwQ=;
  b=hYrXlcaKkjg9vBk6qE0e+XYGJ0nnk6sByNdMJB1uEC8zwHDankzmzN5Z
   X/M8jDqZAaJ3OfWbVZjJ58e7xwRIVkWpUlMQ2Vpi9lphEr3xBSqNmhIO5
   K7gkI0lxB9Pdn5xP6XdeBpKNycBA7PCVBqxBJSC5d/BE6JWL2wKSb9Cl9
   2J42W701g4xcIVpB9AHkc0s7z/XdfA0Uwg2MZRZiX9c2Ye4ZpUquJsmrz
   lus2UrLnBPsK44+guF02M1bucDnrtsJesG01yHvrScRbwK9zQRgqlbHGW
   k0BDd7rVafcSbPYQv7RdRuWGoX/2K8RLgK4iOUPggKzVJa1FycGmSld8F
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10284"; a="280623157"
X-IronPort-AV: E=Sophos;i="5.90,178,1643702400"; 
   d="scan'208";a="280623157"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2022 06:20:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,178,1643702400"; 
   d="scan'208";a="515099504"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 13 Mar 2022 06:20:58 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nTO9Z-0008yw-EH; Sun, 13 Mar 2022 13:20:57 +0000
Date:   Sun, 13 Mar 2022 21:20:13 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:dev.2022.03.09a] BUILD SUCCESS
 59608584999a8d3ddfb82cd7cb71593a910e689a
Message-ID: <622def8d.GVp583XIJUp+keYM%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev.2022.03.09a
branch HEAD: 59608584999a8d3ddfb82cd7cb71593a910e689a  fixup! rcu: Make UP-vacuous normal grace period advance sequence

elapsed time: 963m

configs tested: 144
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
mips                 randconfig-c004-20220313
i386                          randconfig-c001
nios2                               defconfig
sh                          polaris_defconfig
sh                         microdev_defconfig
powerpc                     tqm8555_defconfig
powerpc                         wii_defconfig
mips                        vocore2_defconfig
openrisc                 simple_smp_defconfig
sh                           sh2007_defconfig
parisc                generic-32bit_defconfig
arc                        vdk_hs38_defconfig
m68k                          atari_defconfig
arc                            hsdk_defconfig
sh                        sh7785lcr_defconfig
xtensa                  cadence_csp_defconfig
sh                   sh7724_generic_defconfig
m68k                       bvme6000_defconfig
s390                             allmodconfig
powerpc                 mpc837x_rdb_defconfig
mips                       capcella_defconfig
arm                            mps2_defconfig
ia64                            zx1_defconfig
mips                  maltasmvp_eva_defconfig
sh                          sdk7780_defconfig
arm                        oxnas_v6_defconfig
mips                           ip32_defconfig
sh                            titan_defconfig
m68k                          hp300_defconfig
nios2                            alldefconfig
sh                          rsk7269_defconfig
arm                            pleb_defconfig
ia64                         bigsur_defconfig
arm                          simpad_defconfig
m68k                        stmark2_defconfig
sh                          r7785rp_defconfig
mips                         tb0226_defconfig
powerpc                        cell_defconfig
arm                  randconfig-c002-20220313
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
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
parisc64                            defconfig
parisc                           allyesconfig
s390                                defconfig
sparc                               defconfig
sparc                            allyesconfig
i386                             allyesconfig
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
i386                          randconfig-a003
i386                          randconfig-a001
i386                          randconfig-a005
x86_64                        randconfig-a013
x86_64                        randconfig-a015
x86_64                        randconfig-a011
i386                          randconfig-a014
i386                          randconfig-a012
i386                          randconfig-a016
arc                  randconfig-r043-20220313
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
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                           allyesconfig
x86_64                              defconfig
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
arm                        mvebu_v5_defconfig
powerpc                      walnut_defconfig
mips                       rbtx49xx_defconfig
powerpc                     kmeter1_defconfig
arm                        spear3xx_defconfig
mips                          rm200_defconfig
powerpc                 mpc8560_ads_defconfig
arm                   milbeaut_m10v_defconfig
arm                       aspeed_g4_defconfig
arm                         s5pv210_defconfig
powerpc                 xes_mpc85xx_defconfig
arm                          collie_defconfig
powerpc               mpc834x_itxgp_defconfig
arm                          pcm027_defconfig
arm                           spitz_defconfig
powerpc                      pmac32_defconfig
mips                           ip28_defconfig
powerpc                      ppc64e_defconfig
mips                        bcm63xx_defconfig
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
i386                          randconfig-a011
i386                          randconfig-a013
i386                          randconfig-a015
x86_64                        randconfig-a001
x86_64                        randconfig-a005
x86_64                        randconfig-a003
hexagon              randconfig-r041-20220313
hexagon              randconfig-r045-20220313

---
0-DAY CI Kernel Test Service
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
