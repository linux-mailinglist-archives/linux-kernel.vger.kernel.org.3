Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAC75585C13
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Jul 2022 22:30:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235754AbiG3Uac (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Jul 2022 16:30:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231281AbiG3Uab (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jul 2022 16:30:31 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ECF4A1AE
        for <linux-kernel@vger.kernel.org>; Sat, 30 Jul 2022 13:30:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659213030; x=1690749030;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=aRQy9hl3JlD65qGNWrsZf/MURh3NqQP5yudEaf4xjMc=;
  b=VGMdSCDkkP9L3M1m4EzFeATHjIh5GbKvNttahWNhmlkEKjMUMC3GC0vF
   TpHRnDKi67Rior6nYoFta26ZKHBCqO0Zk3Bl2OzOcoPtJzdO6A+lA1wB3
   bj7Ny7KDqOurpvLtrHuAwkibPR93wXYr5niJkpglauh7ugqDRq7z3NBm0
   caoDqvvPxB56ymPhBHjTRSJhsTX6RjUSttgSMJupJyRjB+MuhYkrzqmhl
   8WZ82k8bqV6roDL0Kiiz9FdbFjp5gVUoX619EtHTHFSYd0pUMUDENVOVA
   3obndGGdZ7TOa3i6akzb5uhcste9CeAjkYSvWAzd7KiinRDYUfObKnhap
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10424"; a="288959234"
X-IronPort-AV: E=Sophos;i="5.93,204,1654585200"; 
   d="scan'208";a="288959234"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2022 13:30:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,204,1654585200"; 
   d="scan'208";a="634466465"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 30 Jul 2022 13:30:28 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oHt6R-000DIv-2m;
        Sat, 30 Jul 2022 20:30:27 +0000
Date:   Sun, 31 Jul 2022 04:30:00 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:sched/core] BUILD SUCCESS
 8da3d9b8590bc178752d4b72938745e9a6c4c416
Message-ID: <62e594c8.naAlDGWy5tFmDCSY%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched/core
branch HEAD: 8da3d9b8590bc178752d4b72938745e9a6c4c416  rseq: Kill process when unknown flags are encountered in ABI structures

elapsed time: 715m

configs tested: 150
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                              defconfig
i386                                defconfig
x86_64                               rhel-8.3
x86_64                        randconfig-a004
x86_64                        randconfig-a002
i386                          randconfig-a001
i386                          randconfig-a003
x86_64                           allyesconfig
i386                             allyesconfig
x86_64                        randconfig-a006
arm                                 defconfig
i386                          randconfig-a005
x86_64                          rhel-8.3-func
arm                              allyesconfig
x86_64                         rhel-8.3-kunit
x86_64                        randconfig-a015
m68k                             allmodconfig
arm64                            allyesconfig
csky                              allnoconfig
alpha                             allnoconfig
arc                               allnoconfig
riscv                             allnoconfig
arc                  randconfig-r043-20220730
arc                              allyesconfig
x86_64                           rhel-8.3-kvm
arc                  randconfig-r043-20220729
powerpc                          allmodconfig
x86_64                        randconfig-a013
loongarch                           defconfig
loongarch                         allnoconfig
x86_64                    rhel-8.3-kselftests
mips                             allyesconfig
x86_64                           rhel-8.3-syz
powerpc                           allnoconfig
x86_64                        randconfig-a011
alpha                            allyesconfig
arm                         lpc18xx_defconfig
powerpc                 mpc8540_ads_defconfig
xtensa                    xip_kc705_defconfig
ia64                             allmodconfig
sh                               allmodconfig
m68k                             allyesconfig
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
sh                          r7780mp_defconfig
sh                         apsh4a3a_defconfig
powerpc                      mgcoge_defconfig
arm                        shmobile_defconfig
m68k                                defconfig
i386                          randconfig-c001
xtensa                  audio_kc705_defconfig
sh                          r7785rp_defconfig
sh                            hp6xx_defconfig
mips                       bmips_be_defconfig
sh                           se7206_defconfig
powerpc                       eiger_defconfig
arm                           h3600_defconfig
x86_64                           alldefconfig
arm                             ezx_defconfig
powerpc                        cell_defconfig
sh                          kfr2r09_defconfig
mips                          rb532_defconfig
powerpc                      pcm030_defconfig
mips                         tb0226_defconfig
sh                     sh7710voipgw_defconfig
sh                          rsk7201_defconfig
sh                           se7619_defconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
xtensa                    smp_lx200_defconfig
sh                            migor_defconfig
sh                        sh7757lcr_defconfig
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
arm                        clps711x_defconfig
powerpc                  iss476-smp_defconfig
ia64                             alldefconfig
parisc                generic-64bit_defconfig
microblaze                      mmu_defconfig
sh                          rsk7203_defconfig
riscv             nommu_k210_sdcard_defconfig
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
openrisc                         alldefconfig
nios2                            allyesconfig
parisc                              defconfig
parisc64                            defconfig
parisc                           allyesconfig

clang tested configs:
x86_64                        randconfig-a001
x86_64                        randconfig-a003
i386                          randconfig-a002
hexagon              randconfig-r045-20220730
x86_64                        randconfig-a005
i386                          randconfig-a004
hexagon              randconfig-r041-20220729
riscv                randconfig-r042-20220730
i386                          randconfig-a006
riscv                randconfig-r042-20220729
s390                 randconfig-r044-20220730
hexagon              randconfig-r045-20220729
x86_64                        randconfig-a014
x86_64                        randconfig-a016
hexagon              randconfig-r041-20220730
x86_64                        randconfig-a012
s390                 randconfig-r044-20220729
arm                      tct_hammer_defconfig
mips                        maltaup_defconfig
powerpc                 mpc832x_mds_defconfig
mips                      maltaaprp_defconfig
x86_64                        randconfig-k001
mips                          ath25_defconfig
powerpc                    socrates_defconfig
i386                          randconfig-a013
i386                          randconfig-a015
i386                          randconfig-a011
arm                       imx_v4_v5_defconfig
powerpc                      katmai_defconfig
powerpc                          g5_defconfig
mips                           mtx1_defconfig
mips                           ip28_defconfig
powerpc                  mpc866_ads_defconfig
x86_64                           allyesconfig
arm                       spear13xx_defconfig
riscv                             allnoconfig
powerpc                  mpc885_ads_defconfig

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
