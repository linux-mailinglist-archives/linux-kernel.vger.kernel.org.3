Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BFFF585C56
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Jul 2022 23:38:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236105AbiG3Viy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Jul 2022 17:38:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232597AbiG3Viv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jul 2022 17:38:51 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57BBD13FA1
        for <linux-kernel@vger.kernel.org>; Sat, 30 Jul 2022 14:38:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659217130; x=1690753130;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=YLTx4YP5cHC4JUy37SG1gEfJaptn7DXlmcL+5ZCD4x8=;
  b=OlfsvH8jLCe6tdTQy9tX4jyXmA9ckCcb74vAZGBkhe7YdqtHockWn8bF
   GBxOA/xZwz7Ob9T/emJqFCzw1tSX+GwUxXNJZV1ZSfAj4hr79HgmDa9b5
   FfYbnqW0fH46ew/sKQni+mIJWyROFoNVTqeEgGkbhW2isYE/Vb1YirnBR
   Y5KClkUdMYP6r9fWxOuXOiruOaC27oz2VVHj/RlV8TFGT1xeL+WY1eBwO
   3sKi8du3fbHxh003atnZR/pC5DdOctbaEUbAbC6WdPxZm7CcdxCGX9K0b
   ocHMYSqlDxGLPrGf5lmDJq0uVb8ZFpmtd9awXkP33gmR7oDaK/TCCr1Bc
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10424"; a="352952684"
X-IronPort-AV: E=Sophos;i="5.93,205,1654585200"; 
   d="scan'208";a="352952684"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2022 14:38:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,205,1654585200"; 
   d="scan'208";a="629775039"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 30 Jul 2022 14:38:48 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oHuAa-000DMx-0Z;
        Sat, 30 Jul 2022 21:38:48 +0000
Date:   Sun, 31 Jul 2022 05:38:17 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:locking/urgent] BUILD SUCCESS
 6eebd5fb20838f5971ba17df9f55cc4f84a31053
Message-ID: <62e5a4c9.FSsnFzbRIf7hExrj%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git locking/urgent
branch HEAD: 6eebd5fb20838f5971ba17df9f55cc4f84a31053  locking/rwsem: Allow slowpath writer to ignore handoff bit if not set by first waiter

elapsed time: 713m

configs tested: 132
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
i386                                defconfig
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                        randconfig-a002
x86_64                        randconfig-a004
x86_64                        randconfig-a006
i386                             allyesconfig
x86_64                        randconfig-a013
x86_64                        randconfig-a011
x86_64                        randconfig-a015
x86_64                              defconfig
arc                  randconfig-r043-20220730
arc                  randconfig-r043-20220729
arc                               allnoconfig
alpha                             allnoconfig
x86_64                               rhel-8.3
x86_64                           allyesconfig
csky                              allnoconfig
riscv                             allnoconfig
x86_64                    rhel-8.3-kselftests
x86_64                          rhel-8.3-func
x86_64                         rhel-8.3-kunit
i386                          randconfig-a001
m68k                             allmodconfig
x86_64                           rhel-8.3-syz
x86_64                           rhel-8.3-kvm
arm                                 defconfig
i386                          randconfig-a003
i386                          randconfig-a014
arc                              allyesconfig
alpha                            allyesconfig
i386                          randconfig-a012
i386                          randconfig-a005
m68k                             allyesconfig
i386                          randconfig-a016
powerpc                        cell_defconfig
sh                          kfr2r09_defconfig
mips                          rb532_defconfig
powerpc                          allmodconfig
arm                              allyesconfig
sh                               allmodconfig
ia64                             allmodconfig
mips                             allyesconfig
arm64                            allyesconfig
powerpc                           allnoconfig
xtensa                  audio_kc705_defconfig
sh                          r7785rp_defconfig
sh                            hp6xx_defconfig
mips                       bmips_be_defconfig
sh                          rsk7201_defconfig
sh                           se7619_defconfig
loongarch                           defconfig
loongarch                         allnoconfig
i386                          randconfig-c001
arm                         lpc18xx_defconfig
powerpc                 mpc8540_ads_defconfig
xtensa                    xip_kc705_defconfig
mips                     decstation_defconfig
m68k                         amcore_defconfig
arm                       aspeed_g5_defconfig
powerpc                     pq2fads_defconfig
arm                            qcom_defconfig
mips                        vocore2_defconfig
powerpc                      bamboo_defconfig
m68k                          hp300_defconfig
sh                              ul2_defconfig
nios2                               defconfig
sh                         ecovec24_defconfig
sh                          r7780mp_defconfig
sh                         apsh4a3a_defconfig
powerpc                      mgcoge_defconfig
arm                        shmobile_defconfig
m68k                                defconfig
microblaze                      mmu_defconfig
sh                          rsk7203_defconfig
riscv             nommu_k210_sdcard_defconfig
xtensa                    smp_lx200_defconfig
sh                            migor_defconfig
sh                        sh7757lcr_defconfig
i386                             alldefconfig
sh                             sh03_defconfig
powerpc                     rainier_defconfig
s390                                defconfig
s390                             allmodconfig
arc                                 defconfig
alpha                               defconfig
s390                             allyesconfig
sh                        dreamcast_defconfig
sh                           se7722_defconfig
arm                           sama5_defconfig
xtensa                generic_kc705_defconfig
arm                        trizeps4_defconfig
sparc                       sparc32_defconfig
powerpc                       eiger_defconfig
openrisc                         alldefconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3

clang tested configs:
x86_64                        randconfig-a005
x86_64                        randconfig-a001
x86_64                        randconfig-a003
x86_64                        randconfig-a012
x86_64                        randconfig-a014
hexagon              randconfig-r045-20220730
x86_64                        randconfig-a016
hexagon              randconfig-r041-20220729
riscv                randconfig-r042-20220730
riscv                randconfig-r042-20220729
hexagon              randconfig-r045-20220729
hexagon              randconfig-r041-20220730
s390                 randconfig-r044-20220729
s390                 randconfig-r044-20220730
i386                          randconfig-a013
i386                          randconfig-a002
i386                          randconfig-a011
i386                          randconfig-a006
i386                          randconfig-a004
i386                          randconfig-a015
x86_64                        randconfig-k001
powerpc                          g5_defconfig
mips                           mtx1_defconfig
mips                           ip28_defconfig
powerpc                  mpc866_ads_defconfig
arm                      tct_hammer_defconfig
mips                        maltaup_defconfig
powerpc                 mpc832x_mds_defconfig
mips                      maltaaprp_defconfig
arm                       spear13xx_defconfig
powerpc                  mpc885_ads_defconfig
riscv                          rv32_defconfig
powerpc                 mpc8560_ads_defconfig

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
