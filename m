Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B17784D1319
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 10:13:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345215AbiCHJOR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 04:14:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345151AbiCHJOP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 04:14:15 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E8552AE03
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 01:13:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646730799; x=1678266799;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=O3wlMqhAejd6eICfJLpFZE9LRn9rvXs35rNhs/ZRfIY=;
  b=XEexGL/JgCOPZ3TDZyJApatccMtZwoHcIpd2BvgP87JOLAXRawtbH8lI
   CGkDKcwBceIM3+9FOcf2VYUfDB+ARB0qze3c2eCMqnMxT1QQtwtIAukkV
   Jp4oKXAD54LQJtQP539WSsaaW70+3iP3t+gWx9CuuyP/q87p7fK/Ln8y5
   qKDDg1YmM4k4a8WWE23RDpWvX379WmfyPvq2qflRS4JMD058eQACjVLXf
   OcXzaWcgCDLqLylcLNvbdYaWH+H9Nsl3Ylar/hvV2bgzt63KJQuxmPqLt
   gaX1skQfg7K+URWf8LOKLOedoz2Q0yBO7rpPVt+HuGouIliq9gM11IxjL
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10279"; a="253465098"
X-IronPort-AV: E=Sophos;i="5.90,164,1643702400"; 
   d="scan'208";a="253465098"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2022 01:13:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,164,1643702400"; 
   d="scan'208";a="632170162"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by FMSMGA003.fm.intel.com with ESMTP; 08 Mar 2022 01:13:17 -0800
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nRVu9-0001Bt-86; Tue, 08 Mar 2022 09:13:17 +0000
Date:   Tue, 08 Mar 2022 17:13:03 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:timers/core] BUILD SUCCESS
 58dedf0a4782ce42b4d31f1f62e5ad80a1b73d72
Message-ID: <62271e1f.KiRYb8crJpZiGC9r%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers/core
branch HEAD: 58dedf0a4782ce42b4d31f1f62e5ad80a1b73d72  Merge branch 'clocksource.2022.02.01b' of git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu into timers/core

elapsed time: 732m

configs tested: 182
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
i386                          randconfig-c001
i386                 randconfig-c001-20220307
alpha                            alldefconfig
arm                      footbridge_defconfig
m68k                           sun3_defconfig
sh                           se7722_defconfig
sh                          urquell_defconfig
powerpc                      ep88xc_defconfig
arm                         nhk8815_defconfig
powerpc                     asp8347_defconfig
arm                        realview_defconfig
sh                           se7780_defconfig
sh                          landisk_defconfig
mips                           ip32_defconfig
nios2                               defconfig
m68k                          sun3x_defconfig
arm                         assabet_defconfig
mips                       bmips_be_defconfig
m68k                        m5307c3_defconfig
mips                     loongson1b_defconfig
powerpc64                           defconfig
xtensa                  cadence_csp_defconfig
arm                          pxa3xx_defconfig
arm                           sama5_defconfig
arc                            hsdk_defconfig
x86_64                           alldefconfig
mips                     decstation_defconfig
ia64                          tiger_defconfig
x86_64                              defconfig
sparc                       sparc32_defconfig
mips                      fuloong2e_defconfig
m68k                          atari_defconfig
mips                    maltaup_xpa_defconfig
openrisc                 simple_smp_defconfig
sh                        edosk7705_defconfig
arm                             rpc_defconfig
arc                           tb10x_defconfig
parisc64                         alldefconfig
sh                           se7750_defconfig
sh                             sh03_defconfig
sh                          r7785rp_defconfig
nios2                         3c120_defconfig
powerpc                     ep8248e_defconfig
powerpc                        warp_defconfig
arm                      jornada720_defconfig
arm                            zeus_defconfig
powerpc                   currituck_defconfig
powerpc                      ppc40x_defconfig
xtensa                           alldefconfig
microblaze                          defconfig
sh                           se7712_defconfig
alpha                               defconfig
microblaze                      mmu_defconfig
sh                         ecovec24_defconfig
sh                          rsk7201_defconfig
arm                        shmobile_defconfig
mips                         tb0226_defconfig
mips                  decstation_64_defconfig
arm                         s3c6400_defconfig
sh                            titan_defconfig
arm                            xcep_defconfig
xtensa                          iss_defconfig
powerpc                 mpc834x_itx_defconfig
m68k                       m5249evb_defconfig
arm                            hisi_defconfig
riscv                               defconfig
um                           x86_64_defconfig
arc                          axs101_defconfig
sh                           se7751_defconfig
sparc                            allyesconfig
mips                      maltasmvp_defconfig
powerpc                  iss476-smp_defconfig
arm                  randconfig-c002-20220308
arm                  randconfig-c002-20220307
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
i386                 randconfig-a005-20220307
i386                 randconfig-a004-20220307
i386                 randconfig-a003-20220307
i386                 randconfig-a006-20220307
i386                 randconfig-a002-20220307
i386                 randconfig-a001-20220307
x86_64               randconfig-a006-20220307
x86_64               randconfig-a004-20220307
x86_64               randconfig-a005-20220307
x86_64               randconfig-a001-20220307
x86_64               randconfig-a003-20220307
x86_64               randconfig-a002-20220307
arc                  randconfig-r043-20220308
riscv                randconfig-r042-20220308
s390                 randconfig-r044-20220308
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
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
x86_64                        randconfig-c007
riscv                randconfig-c006-20220308
powerpc              randconfig-c003-20220308
i386                          randconfig-c001
arm                  randconfig-c002-20220308
mips                 randconfig-c004-20220308
x86_64               randconfig-c007-20220307
i386                 randconfig-c001-20220307
powerpc              randconfig-c003-20220307
riscv                randconfig-c006-20220307
mips                 randconfig-c004-20220307
arm                  randconfig-c002-20220307
s390                 randconfig-c005-20220307
powerpc                      walnut_defconfig
mips                        qi_lb60_defconfig
powerpc                     skiroot_defconfig
mips                           mtx1_defconfig
mips                     loongson2k_defconfig
arm                         bcm2835_defconfig
powerpc                      ppc44x_defconfig
arm                         socfpga_defconfig
arm                        vexpress_defconfig
hexagon                             defconfig
mips                           ip22_defconfig
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
i386                 randconfig-a012-20220307
i386                 randconfig-a013-20220307
i386                 randconfig-a015-20220307
i386                 randconfig-a011-20220307
i386                 randconfig-a014-20220307
i386                 randconfig-a016-20220307
i386                          randconfig-a011
i386                          randconfig-a013
i386                          randconfig-a015
hexagon              randconfig-r045-20220307
hexagon              randconfig-r045-20220308
hexagon              randconfig-r041-20220308
riscv                randconfig-r042-20220307
hexagon              randconfig-r041-20220307

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
