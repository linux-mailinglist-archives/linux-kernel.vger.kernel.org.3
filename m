Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E20A4F6DC3
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 00:17:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232412AbiDFWSz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 18:18:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229854AbiDFWSx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 18:18:53 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 720CFA8895
        for <linux-kernel@vger.kernel.org>; Wed,  6 Apr 2022 15:16:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649283415; x=1680819415;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=dRvzuLya0ddCSZ6ADoo00YFmaT/vGtghArBCCGYqqbA=;
  b=IyGwgDqixbW/uReptOeukdi3GqKq2nsCYYGlyv4ZBxmNyTo1RI/3G6/w
   npD3B0jsWeyn+dIa6B0wLoo150llAorUh9qEkmFF1HlVyZs5tJ2KrcBpU
   XwBFXwEzWiTpZLPlWKUIwpGz+VAF0+PBV8UchAZWyFlk1D+NcZejA7kM2
   6bJMcS+mYrHONk39PWOnNccaJlLQf3AoJIBkffUnk2p7J00UaGw0jKjDi
   cTijWfaYobRTcG9HBfCATh3/0XjfrteEN+7bJWmdu8aa7474tXGcRPXOm
   i66zUxjcEa6+7Qc3vU3kMm781j+TMtliu8HIlStz5sa4Vth5ovjMuvh0U
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10309"; a="260002623"
X-IronPort-AV: E=Sophos;i="5.90,240,1643702400"; 
   d="scan'208";a="260002623"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2022 15:16:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,240,1643702400"; 
   d="scan'208";a="524659627"
Received: from lkp-server02.sh.intel.com (HELO a44fdfb70b94) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 06 Apr 2022 15:16:53 -0700
Received: from kbuild by a44fdfb70b94 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1ncDxM-0004oI-TB;
        Wed, 06 Apr 2022 22:16:52 +0000
Date:   Thu, 07 Apr 2022 06:16:11 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:master] BUILD SUCCESS
 7bcafc1e843a4e3ac53b61c2e72ae5985e6b44e4
Message-ID: <624e112b.rckT5OgaYN1vcCmx%lkp@intel.com>
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
branch HEAD: 7bcafc1e843a4e3ac53b61c2e72ae5985e6b44e4  Merge x86/cpu into tip/master

elapsed time: 734m

configs tested: 148
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm64                               defconfig
arm64                            allyesconfig
arm                              allmodconfig
arm                                 defconfig
arm                              allyesconfig
i386                          randconfig-c001
arm                        spear6xx_defconfig
sh                        sh7757lcr_defconfig
xtensa                generic_kc705_defconfig
sh                           se7712_defconfig
arc                        nsim_700_defconfig
powerpc                        warp_defconfig
mips                           ci20_defconfig
arm                             rpc_defconfig
powerpc                 linkstation_defconfig
sh                           se7343_defconfig
openrisc                            defconfig
openrisc                         alldefconfig
sh                        edosk7705_defconfig
arm                        multi_v7_defconfig
arm                        keystone_defconfig
powerpc                     sequoia_defconfig
sh                          sdk7780_defconfig
s390                             allyesconfig
h8300                    h8300h-sim_defconfig
sh                          landisk_defconfig
arc                          axs101_defconfig
xtensa                       common_defconfig
arm                           viper_defconfig
m68k                          atari_defconfig
arm                           stm32_defconfig
powerpc                     stx_gp3_defconfig
parisc                              defconfig
powerpc                      cm5200_defconfig
ia64                             allmodconfig
m68k                        m5407c3_defconfig
powerpc                         wii_defconfig
arc                        vdk_hs38_defconfig
arm                            pleb_defconfig
um                           x86_64_defconfig
m68k                       m5275evb_defconfig
ia64                          tiger_defconfig
m68k                        mvme147_defconfig
sh                        dreamcast_defconfig
arc                         haps_hs_defconfig
mips                       capcella_defconfig
powerpc                     tqm8541_defconfig
sh                           se7780_defconfig
ia64                         bigsur_defconfig
sh                          rsk7201_defconfig
sh                          lboxre2_defconfig
powerpc                    adder875_defconfig
parisc                           alldefconfig
sh                           se7619_defconfig
arc                      axs103_smp_defconfig
arm                         s3c6400_defconfig
m68k                        stmark2_defconfig
m68k                            mac_defconfig
mips                      loongson3_defconfig
mips                         db1xxx_defconfig
x86_64                           alldefconfig
x86_64                        randconfig-c001
arm                  randconfig-c002-20220406
ia64                             allyesconfig
ia64                                defconfig
m68k                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
csky                                defconfig
nios2                            allyesconfig
alpha                               defconfig
alpha                            allyesconfig
nios2                               defconfig
arc                              allyesconfig
h8300                            allyesconfig
xtensa                           allyesconfig
arc                                 defconfig
sh                               allmodconfig
s390                                defconfig
s390                             allmodconfig
parisc64                            defconfig
parisc                           allyesconfig
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
x86_64                        randconfig-a004
x86_64                        randconfig-a002
x86_64                        randconfig-a006
i386                          randconfig-a001
i386                          randconfig-a003
i386                          randconfig-a005
x86_64                        randconfig-a013
x86_64                        randconfig-a011
x86_64                        randconfig-a015
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
arc                  randconfig-r043-20220406
s390                 randconfig-r044-20220406
riscv                randconfig-r042-20220406
riscv                               defconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
riscv                             allnoconfig
riscv                            allmodconfig
riscv                            allyesconfig
x86_64                    rhel-8.3-kselftests
um                             i386_defconfig
x86_64                          rhel-8.3-func
x86_64                                  kexec
x86_64                              defconfig
x86_64                           allyesconfig
x86_64                         rhel-8.3-kunit
x86_64                               rhel-8.3

clang tested configs:
x86_64                        randconfig-c007
i386                          randconfig-c001
powerpc              randconfig-c003-20220406
riscv                randconfig-c006-20220406
mips                 randconfig-c004-20220406
arm                  randconfig-c002-20220406
arm                       netwinder_defconfig
powerpc                     powernv_defconfig
powerpc                     ksi8560_defconfig
arm                          collie_defconfig
powerpc                 mpc832x_mds_defconfig
mips                   sb1250_swarm_defconfig
powerpc                     mpc512x_defconfig
arm                    vt8500_v6_v7_defconfig
powerpc                 mpc8560_ads_defconfig
arm                          pcm027_defconfig
x86_64                        randconfig-a001
x86_64                        randconfig-a003
x86_64                        randconfig-a005
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
hexagon              randconfig-r041-20220406
hexagon              randconfig-r045-20220406

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
