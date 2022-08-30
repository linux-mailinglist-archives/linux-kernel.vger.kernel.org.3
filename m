Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F2265A70E5
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 00:38:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229522AbiH3Wil (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 18:38:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229647AbiH3Wii (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 18:38:38 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C09871713
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 15:38:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661899117; x=1693435117;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=HPxyZKTMsiKXWdjL1MbAMYRpw7MR2SlJZoRdCEDByeE=;
  b=ESqg6EPdhday1q6vSPxu2WPGNoV8UQwSfWFnOYDX4ivm88nQy8k09uPM
   05jr+M6iojx9XUraboXX4M0x478bsQPMYYRGv2uCdIedCApcWvbpFi8vR
   4KLDFfDf1s7DAwDSg0yTAG0gxIlW3TOf+6UoT8rznQKyygN6Ftq4CXkyX
   ujpQeAWzk9H9mIZeUb4OPcyqP3gyDLL5NyCqev34xcGcRm5+jvzzNBpiz
   cRTTltVvPn9u2emJ67Pq98gLQzDRbW4IuLwVMxeMaqprQ2BLDdqHRtupO
   xSjemeetIHOwjOoZCSCZtU8/qSQzsdmtaZrmLZXwRUcLZjzM34ucZUEnA
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10455"; a="357039272"
X-IronPort-AV: E=Sophos;i="5.93,276,1654585200"; 
   d="scan'208";a="357039272"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2022 15:38:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,276,1654585200"; 
   d="scan'208";a="940220772"
Received: from lkp-server02.sh.intel.com (HELO 77b6d4e16fc5) ([10.239.97.151])
  by fmsmga005.fm.intel.com with ESMTP; 30 Aug 2022 15:38:35 -0700
Received: from kbuild by 77b6d4e16fc5 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oT9sQ-0000hC-2C;
        Tue, 30 Aug 2022 22:38:34 +0000
Date:   Wed, 31 Aug 2022 06:37:46 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:master] BUILD SUCCESS
 f9c08c27f19683bdb965f6a26edc05358a751826
Message-ID: <630e913a.wgdKzBNqMPkzhTgR%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git master
branch HEAD: f9c08c27f19683bdb965f6a26edc05358a751826  Merge branch into tip/master: 'x86/timers'

elapsed time: 839m

configs tested: 122
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                             i386_defconfig
um                           x86_64_defconfig
powerpc                           allnoconfig
x86_64                              defconfig
arm                                 defconfig
i386                                defconfig
x86_64                               rhel-8.3
x86_64                           allyesconfig
x86_64                        randconfig-a013
x86_64                        randconfig-a011
sh                               allmodconfig
arm                              allyesconfig
x86_64                        randconfig-a015
i386                          randconfig-a001
arc                  randconfig-r043-20220830
x86_64                        randconfig-a004
x86_64                           rhel-8.3-kvm
mips                             allyesconfig
arm64                            allyesconfig
x86_64                    rhel-8.3-kselftests
x86_64                        randconfig-a002
powerpc                          allmodconfig
x86_64                           rhel-8.3-syz
i386                          randconfig-a003
x86_64                          rhel-8.3-func
x86_64                         rhel-8.3-kunit
i386                          randconfig-a005
i386                          randconfig-a014
i386                          randconfig-a012
x86_64                        randconfig-a006
i386                          randconfig-a016
m68k                             allmodconfig
arc                              allyesconfig
alpha                            allyesconfig
i386                             allyesconfig
m68k                             allyesconfig
loongarch                           defconfig
loongarch                         allnoconfig
csky                              allnoconfig
alpha                             allnoconfig
arc                               allnoconfig
riscv                             allnoconfig
arc                        nsimosci_defconfig
arm                            xcep_defconfig
powerpc                 mpc837x_mds_defconfig
sh                           se7705_defconfig
arm                          pxa910_defconfig
riscv                    nommu_k210_defconfig
arc                         haps_hs_defconfig
mips                      fuloong2e_defconfig
arc                                 defconfig
sh                            hp6xx_defconfig
arm                            pleb_defconfig
openrisc                       virt_defconfig
arm64                               defconfig
s390                                defconfig
sh                          rsk7264_defconfig
arm                            zeus_defconfig
parisc                generic-64bit_defconfig
arm                         lubbock_defconfig
arc                           tb10x_defconfig
arc                          axs101_defconfig
xtensa                          iss_defconfig
arm                       imx_v6_v7_defconfig
mips                           jazz_defconfig
powerpc                     stx_gp3_defconfig
powerpc                     asp8347_defconfig
sh                           se7619_defconfig
i386                          randconfig-c001
sparc                               defconfig
mips                      loongson3_defconfig
m68k                       m5475evb_defconfig
xtensa                  nommu_kc705_defconfig
mips                       bmips_be_defconfig
mips                        bcm47xx_defconfig
powerpc                       eiger_defconfig
arc                 nsimosci_hs_smp_defconfig
sparc                             allnoconfig
sh                           se7721_defconfig
sh                        edosk7760_defconfig
m68k                            mac_defconfig
arm                      integrator_defconfig
sh                          kfr2r09_defconfig
arm                         cm_x300_defconfig
nios2                            alldefconfig
openrisc                  or1klitex_defconfig
ia64                             allmodconfig
arc                        nsim_700_defconfig
microblaze                      mmu_defconfig
arm                        realview_defconfig
ia64                      gensparse_defconfig
arm                        oxnas_v6_defconfig
mips                         bigsur_defconfig
m68k                          multi_defconfig
xtensa                              defconfig
powerpc                 mpc834x_itx_defconfig
arm                     eseries_pxa_defconfig
powerpc                 mpc8540_ads_defconfig
xtensa                    smp_lx200_defconfig
arm                          lpd270_defconfig
openrisc                         alldefconfig
xtensa                  cadence_csp_defconfig
x86_64                           alldefconfig
arm                         nhk8815_defconfig

clang tested configs:
hexagon              randconfig-r045-20220830
x86_64                        randconfig-a014
x86_64                        randconfig-a012
x86_64                        randconfig-a016
hexagon              randconfig-r041-20220830
s390                 randconfig-r044-20220830
riscv                randconfig-r042-20220830
x86_64                        randconfig-a005
i386                          randconfig-a013
i386                          randconfig-a002
i386                          randconfig-a015
i386                          randconfig-a004
i386                          randconfig-a011
x86_64                        randconfig-a001
x86_64                        randconfig-a003
i386                          randconfig-a006
x86_64                        randconfig-k001
arm                          pcm027_defconfig

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
