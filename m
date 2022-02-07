Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB58C4ACB2B
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 22:20:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238178AbiBGVUB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 16:20:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238009AbiBGVT5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 16:19:57 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54390C0612A4
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 13:19:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644268797; x=1675804797;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=b21Vh4m+bvG1jSyxY7nQdb0mZd8V48tV0+qDzE0s0Wg=;
  b=OhxM1GvG+TzaKRJAE2E01Bb4mrbVBMrWJNmR+04IE3RqVqH7QDmuksbs
   GbJF8PapNVGe2Gsu9jiJLaGAhzHJfkHWu1cW37m+Jps7cK9ENUMl+gALZ
   Chr/3qfc3KQK284YSJfNobuwwLV9qXMa9Qem/ZVVYcdZ03Tm3Ri8gV/WO
   7YnQ4xepC7Nku4yMGI6hSxtc7LHmfBxQ+nTfiYzDnHBlYReK+owTQLbv+
   uk/uslxQa+0j6b6oFZ4mewKUsG4QZUzcGOq/G1Jr3bVNU8GM/Vk+c7hnj
   vXZrTZjCs4vuaMDTHpfe4imnwszbRM0BUMflN0YWJAxf9DSDjtANFJxhx
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10251"; a="312109203"
X-IronPort-AV: E=Sophos;i="5.88,350,1635231600"; 
   d="scan'208";a="312109203"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2022 13:19:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,350,1635231600"; 
   d="scan'208";a="484569101"
Received: from lkp-server01.sh.intel.com (HELO 9dd77a123018) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 07 Feb 2022 13:19:55 -0800
Received: from kbuild by 9dd77a123018 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nHBQQ-0000z3-Cr; Mon, 07 Feb 2022 21:19:54 +0000
Date:   Tue, 08 Feb 2022 05:19:24 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:master] BUILD SUCCESS
 163812a9c80a7323c40361e822c3c54be17fa38a
Message-ID: <62018cdc.JYiVUuzVVUdmjkqG%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git master
branch HEAD: 163812a9c80a7323c40361e822c3c54be17fa38a  Merge x86/cpu into tip/master

elapsed time: 728m

configs tested: 184
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                              allyesconfig
arm                              allmodconfig
arm                                 defconfig
arm64                               defconfig
arm64                            allyesconfig
i386                 randconfig-c001-20220207
arm                             pxa_defconfig
arm                          iop32x_defconfig
arm                          exynos_defconfig
sparc                       sparc32_defconfig
sh                           se7750_defconfig
sh                          landisk_defconfig
arm                        cerfcube_defconfig
arc                     nsimosci_hs_defconfig
s390                          debug_defconfig
sh                          kfr2r09_defconfig
powerpc                      arches_defconfig
um                               alldefconfig
mips                      loongson3_defconfig
arc                        nsimosci_defconfig
mips                         rt305x_defconfig
arc                     haps_hs_smp_defconfig
arm                        trizeps4_defconfig
sh                     magicpanelr2_defconfig
sh                               alldefconfig
sh                           se7751_defconfig
mips                            ar7_defconfig
powerpc                mpc7448_hpc2_defconfig
powerpc                        cell_defconfig
sh                         ecovec24_defconfig
nios2                            alldefconfig
arm                           stm32_defconfig
powerpc                      ep88xc_defconfig
powerpc                     ep8248e_defconfig
m68k                       m5249evb_defconfig
xtensa                    xip_kc705_defconfig
powerpc                  storcenter_defconfig
mips                         tb0226_defconfig
ia64                         bigsur_defconfig
arm                        multi_v7_defconfig
nds32                            alldefconfig
sparc64                             defconfig
sh                            migor_defconfig
arm                            hisi_defconfig
arm                           tegra_defconfig
arm                         at91_dt_defconfig
mips                         cobalt_defconfig
ia64                        generic_defconfig
sh                               allmodconfig
sh                           se7724_defconfig
powerpc                     taishan_defconfig
mips                      maltasmvp_defconfig
parisc                generic-32bit_defconfig
sh                          sdk7786_defconfig
arm                          lpd270_defconfig
mips                         bigsur_defconfig
arm                        realview_defconfig
arm                        mvebu_v7_defconfig
m68k                       m5208evb_defconfig
arm                         lubbock_defconfig
powerpc                     sequoia_defconfig
h8300                       h8s-sim_defconfig
sh                   sh7724_generic_defconfig
m68k                        m5307c3_defconfig
m68k                       m5275evb_defconfig
sh                          rsk7201_defconfig
m68k                       m5475evb_defconfig
m68k                        m5407c3_defconfig
sh                           se7343_defconfig
nds32                             allnoconfig
sh                               j2_defconfig
sh                          r7785rp_defconfig
x86_64                              defconfig
arm                      jornada720_defconfig
arm                            zeus_defconfig
mips                      fuloong2e_defconfig
sh                          rsk7264_defconfig
powerpc                      ppc6xx_defconfig
i386                                defconfig
arm                             ezx_defconfig
powerpc                       maple_defconfig
mips                     loongson1b_defconfig
sh                           se7721_defconfig
riscv                            allyesconfig
arm                     eseries_pxa_defconfig
mips                        jmr3927_defconfig
arm                          pxa910_defconfig
powerpc                    amigaone_defconfig
powerpc                     rainier_defconfig
mips                        bcm47xx_defconfig
arm                  randconfig-c002-20220207
arm                  randconfig-c002-20220208
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
nds32                               defconfig
nios2                            allyesconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
xtensa                           allyesconfig
h8300                            allyesconfig
arc                                 defconfig
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
x86_64               randconfig-a013-20220207
x86_64               randconfig-a016-20220207
x86_64               randconfig-a015-20220207
x86_64               randconfig-a012-20220207
x86_64               randconfig-a014-20220207
x86_64               randconfig-a011-20220207
i386                 randconfig-a012-20220207
i386                 randconfig-a013-20220207
i386                 randconfig-a015-20220207
i386                 randconfig-a014-20220207
i386                 randconfig-a011-20220207
i386                 randconfig-a016-20220207
arc                  randconfig-r043-20220207
s390                 randconfig-r044-20220207
riscv                randconfig-r042-20220207
riscv                    nommu_k210_defconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                    rhel-8.3-kselftests
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                               rhel-8.3
x86_64                                  kexec
x86_64                           allyesconfig
x86_64                          rhel-8.3-func

clang tested configs:
powerpc              randconfig-c003-20220207
x86_64               randconfig-c007-20220207
mips                 randconfig-c004-20220207
arm                  randconfig-c002-20220207
s390                 randconfig-c005-20220207
riscv                randconfig-c006-20220207
i386                 randconfig-c001-20220207
arm                        multi_v5_defconfig
mips                           ip22_defconfig
mips                        maltaup_defconfig
powerpc                 mpc8272_ads_defconfig
mips                           rs90_defconfig
mips                     loongson2k_defconfig
mips                      pic32mzda_defconfig
arm                        magician_defconfig
mips                           mtx1_defconfig
arm                            dove_defconfig
mips                          malta_defconfig
arm                  colibri_pxa300_defconfig
powerpc                     kmeter1_defconfig
mips                           ip27_defconfig
riscv                          rv32_defconfig
arm                                 defconfig
x86_64               randconfig-a006-20220207
x86_64               randconfig-a004-20220207
x86_64               randconfig-a005-20220207
x86_64               randconfig-a003-20220207
x86_64               randconfig-a002-20220207
x86_64               randconfig-a001-20220207
i386                 randconfig-a005-20220207
i386                 randconfig-a004-20220207
i386                 randconfig-a003-20220207
i386                 randconfig-a006-20220207
i386                 randconfig-a001-20220207
i386                 randconfig-a002-20220207
hexagon              randconfig-r045-20220207
hexagon              randconfig-r041-20220207

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
