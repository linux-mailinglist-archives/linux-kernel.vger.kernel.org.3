Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A48DD50C8FB
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Apr 2022 12:06:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234806AbiDWKGR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Apr 2022 06:06:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234807AbiDWKGO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Apr 2022 06:06:14 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C17D18E1B8
        for <linux-kernel@vger.kernel.org>; Sat, 23 Apr 2022 03:03:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650708197; x=1682244197;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=jKVpPTxKS1UMykMk7NWQmZ9dRaXePL5IP5qF+/YRC4o=;
  b=d3SSBvxbDAc+LSVBgEbXf+B+A0Y6BNpENr8hgAh0TLlwdTa/i0lv8WfT
   DQJjHyI3B3qgIgTihetplTlJJ+xwsLLijUONTmZR1paaXQjuxfjkqKXKW
   mhWAQtmCKFB6yOaUIlBeFbd21Gkn4SSFqPpg8Am3gl9cwFMVVn59sWJ7B
   5T4PN+WIgClPbhIOkBYu4mEXBf7ExGNzW0O1up/1Z3X2NIcj5sRhHnsnh
   C3DAlM1IIYu4aZ16EoEzZNH+2DMQEzyCcQ2QyFs/1zB7nzVPdCMrOR708
   pTQ/N+lt9iAbVsk0DIbQOj5NS5eUtiPoLmtrUeMgWgZoUiZq1laswt5EV
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10324"; a="351325276"
X-IronPort-AV: E=Sophos;i="5.90,284,1643702400"; 
   d="scan'208";a="351325276"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2022 03:03:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,284,1643702400"; 
   d="scan'208";a="806335389"
Received: from lkp-server01.sh.intel.com (HELO dd58949a6e39) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 23 Apr 2022 03:03:15 -0700
Received: from kbuild by dd58949a6e39 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1niCbj-00009D-76;
        Sat, 23 Apr 2022 10:03:15 +0000
Date:   Sat, 23 Apr 2022 18:02:41 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:timers/urgent] BUILD SUCCESS
 214cab6f8020a9ad4a5e9862a4e68088d5a79f08
Message-ID: <6263cec1.GW4DFaVrr0MuCaY/%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers/urgent
branch HEAD: 214cab6f8020a9ad4a5e9862a4e68088d5a79f08  MAINTAINERS: Update email address for John Stultz

elapsed time: 1512m

configs tested: 141
configs skipped: 5

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm64                               defconfig
arm64                            allyesconfig
arm                              allmodconfig
arm                                 defconfig
arm                              allyesconfig
i386                          randconfig-c001
m68k                        m5407c3_defconfig
um                                  defconfig
arm                          simpad_defconfig
powerpc                      pcm030_defconfig
powerpc                   currituck_defconfig
powerpc                       ppc64_defconfig
powerpc                        cell_defconfig
powerpc                    sam440ep_defconfig
openrisc                 simple_smp_defconfig
sh                               alldefconfig
arm                        shmobile_defconfig
powerpc                       holly_defconfig
mips                        bcm47xx_defconfig
sparc64                             defconfig
um                               alldefconfig
ia64                        generic_defconfig
arm                           viper_defconfig
m68k                          atari_defconfig
sh                          rsk7203_defconfig
m68k                             allyesconfig
ia64                         bigsur_defconfig
sh                        apsh4ad0a_defconfig
arm                           sama5_defconfig
sh                              ul2_defconfig
ia64                             allyesconfig
mips                     loongson1b_defconfig
arc                         haps_hs_defconfig
m68k                         apollo_defconfig
arm                           sunxi_defconfig
arm                           h3600_defconfig
sh                           se7705_defconfig
sh                           se7722_defconfig
arm                            xcep_defconfig
sh                           se7619_defconfig
mips                           xway_defconfig
xtensa                    smp_lx200_defconfig
arm                           stm32_defconfig
xtensa                          iss_defconfig
m68k                       m5475evb_defconfig
powerpc                 canyonlands_defconfig
arm                        trizeps4_defconfig
sh                           se7751_defconfig
arc                          axs103_defconfig
x86_64                        randconfig-c001
arm                  randconfig-c002-20220422
ia64                             allmodconfig
ia64                                defconfig
m68k                             allmodconfig
m68k                                defconfig
nios2                               defconfig
arc                              allyesconfig
csky                                defconfig
nios2                            allyesconfig
alpha                               defconfig
alpha                            allyesconfig
h8300                            allyesconfig
xtensa                           allyesconfig
arc                                 defconfig
sh                               allmodconfig
s390                                defconfig
s390                             allmodconfig
parisc                              defconfig
parisc64                            defconfig
parisc                           allyesconfig
s390                             allyesconfig
sparc                               defconfig
i386                             allyesconfig
sparc                            allyesconfig
i386                                defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                           allnoconfig
powerpc                          allmodconfig
x86_64                        randconfig-a006
x86_64                        randconfig-a004
x86_64                        randconfig-a002
i386                          randconfig-a001
i386                          randconfig-a003
i386                          randconfig-a005
x86_64                        randconfig-a015
x86_64                        randconfig-a013
x86_64                        randconfig-a011
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
arc                  randconfig-r043-20220422
riscv                               defconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
riscv                             allnoconfig
riscv                            allmodconfig
riscv                            allyesconfig
x86_64                    rhel-8.3-kselftests
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                          rhel-8.3-func
x86_64                                  kexec
x86_64                              defconfig
x86_64                           allyesconfig
x86_64                         rhel-8.3-kunit
x86_64                               rhel-8.3

clang tested configs:
riscv                randconfig-c006-20220422
mips                 randconfig-c004-20220422
x86_64                        randconfig-c007
i386                          randconfig-c001
arm                  randconfig-c002-20220422
powerpc              randconfig-c003-20220422
powerpc                      acadia_defconfig
mips                           ip27_defconfig
mips                malta_qemu_32r6_defconfig
powerpc                 mpc836x_mds_defconfig
arm                      tct_hammer_defconfig
arm                       versatile_defconfig
x86_64                           allyesconfig
riscv                    nommu_virt_defconfig
powerpc                 mpc8315_rdb_defconfig
powerpc                       ebony_defconfig
arm                       mainstone_defconfig
powerpc                      ppc64e_defconfig
x86_64                        randconfig-a005
x86_64                        randconfig-a003
x86_64                        randconfig-a001
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64                        randconfig-a014
x86_64                        randconfig-a016
x86_64                        randconfig-a012
i386                          randconfig-a015
i386                          randconfig-a011
i386                          randconfig-a013
hexagon              randconfig-r041-20220422
s390                 randconfig-r044-20220422
riscv                randconfig-r042-20220422
hexagon              randconfig-r045-20220422

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
