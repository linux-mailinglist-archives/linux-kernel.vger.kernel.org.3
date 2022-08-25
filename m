Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51CC65A07C1
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 06:08:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230165AbiHYEG3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 00:06:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbiHYEG1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 00:06:27 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49C4E9C539
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 21:06:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661400386; x=1692936386;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=oRbbgV3qwhhduxBpRpTG+ttrEHOI0Nykarizza8alQg=;
  b=VZ8iNM9yuceQZ5gk4hElMO/IYj4YZcPowdq3QvH56OdZtZWAs1EtMoLk
   5Z+WbGwDrUlxvWlL/QJMA1dzP7U8Yp8RwDc0fYVj59lX5s/28Bra30fA8
   Ds6lINUG+78JmZI1jHz9BrGcVyzLkCih6TkfAwJkW7t9wlgXV2M6LrxtW
   ZPntiMyx5OiFQUeyLc1J9ujIMsZkkz/WsPAskKQd7M7abGCrFQeu2vRDx
   o7hbJpOZ/54HycJ9bm598ltlJsMt/1H72Y8RqmKmyF5Sxp9MMO1/DF+p5
   mx/Vsj77HaG/4MSoF67bdg6Ce1xXRk/2n7I1Nncv1MysWKKDK/JgNhgd9
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10449"; a="281110663"
X-IronPort-AV: E=Sophos;i="5.93,262,1654585200"; 
   d="scan'208";a="281110663"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2022 21:06:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,262,1654585200"; 
   d="scan'208";a="586701923"
Received: from lkp-server02.sh.intel.com (HELO 34e741d32628) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 24 Aug 2022 21:06:16 -0700
Received: from kbuild by 34e741d32628 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oR48F-0001hP-39;
        Thu, 25 Aug 2022 04:06:15 +0000
Date:   Thu, 25 Aug 2022 12:06:07 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/urgent] BUILD SUCCESS
 cdaa0a407f1acd3a44861e3aea6e3c7349e668f1
Message-ID: <6306f52f.O8kd5d0FRsVDRgix%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/urgent
branch HEAD: cdaa0a407f1acd3a44861e3aea6e3c7349e668f1  x86/sev: Don't use cc_platform_has() for early SEV-SNP calls

elapsed time: 1194m

configs tested: 171
configs skipped: 77

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
i386                                defconfig
x86_64                              defconfig
x86_64                        randconfig-a006
x86_64                               rhel-8.3
x86_64                           allyesconfig
i386                             allyesconfig
i386                          randconfig-a014
x86_64                        randconfig-a002
x86_64                        randconfig-a015
i386                          randconfig-a012
i386                          randconfig-a016
x86_64                        randconfig-a013
x86_64                        randconfig-a011
x86_64                        randconfig-a004
i386                          randconfig-a001
i386                          randconfig-a003
i386                          randconfig-a005
um                           x86_64_defconfig
um                             i386_defconfig
loongarch                           defconfig
loongarch                         allnoconfig
powerpc                           allnoconfig
mips                             allyesconfig
powerpc                          allmodconfig
sh                               allmodconfig
csky                              allnoconfig
riscv                             allnoconfig
s390                                defconfig
s390                             allmodconfig
arc                                 defconfig
alpha                               defconfig
s390                             allyesconfig
nios2                               defconfig
parisc                              defconfig
parisc64                            defconfig
parisc                           allyesconfig
i386                          debian-10.3-kvm
i386                        debian-10.3-kunit
i386                         debian-10.3-func
arm                       omap2plus_defconfig
arc                          axs101_defconfig
arc                         haps_hs_defconfig
alpha                             allnoconfig
arc                               allnoconfig
powerpc                          allyesconfig
riscv                               defconfig
riscv                            allmodconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
sparc                             allnoconfig
microblaze                          defconfig
m68k                        mvme16x_defconfig
m68k                            mac_defconfig
m68k                         apollo_defconfig
sh                          sdk7786_defconfig
arm                        shmobile_defconfig
parisc64                         alldefconfig
x86_64                           rhel-8.3-kvm
x86_64                          rhel-8.3-func
x86_64                           rhel-8.3-syz
x86_64                    rhel-8.3-kselftests
x86_64                         rhel-8.3-kunit
sh                          kfr2r09_defconfig
xtensa                          iss_defconfig
i386                          randconfig-c001
m68k                             allyesconfig
m68k                             allmodconfig
arc                              allyesconfig
alpha                            allyesconfig
arm64                            allyesconfig
arm                                 defconfig
arm                              allyesconfig
arm                            hisi_defconfig
ia64                          tiger_defconfig
mips                      loongson3_defconfig
arm                             rpc_defconfig
arc                      axs103_smp_defconfig
sparc                               defconfig
xtensa                           allyesconfig
csky                                defconfig
sparc                            allyesconfig
x86_64                                  kexec
nios2                            allyesconfig
sh                        sh7763rdp_defconfig
m68k                          multi_defconfig
arc                        nsim_700_defconfig
sh                   sh7770_generic_defconfig
arm                          gemini_defconfig
arm                            lart_defconfig
m68k                       m5249evb_defconfig
sh                             espt_defconfig
m68k                                defconfig
ia64                                defconfig
mips                             allmodconfig
m68k                            q40_defconfig
ia64                        generic_defconfig
sh                             shx3_defconfig
um                                  defconfig
microblaze                      mmu_defconfig
arm                        realview_defconfig
arm64                               defconfig
arm                              allmodconfig
sh                          r7780mp_defconfig
sh                        edosk7760_defconfig
sh                           se7751_defconfig
powerpc                      arches_defconfig
m68k                        stmark2_defconfig
sh                           se7721_defconfig
powerpc                      pcm030_defconfig
arc                    vdk_hs38_smp_defconfig
arm                            zeus_defconfig
s390                          debug_defconfig
ia64                            zx1_defconfig
sh                          rsk7269_defconfig
xtensa                         virt_defconfig
sh                   sh7724_generic_defconfig
powerpc                      makalu_defconfig
arm                            pleb_defconfig
mips                        bcm47xx_defconfig
csky                             alldefconfig
ia64                      gensparse_defconfig
arm                      integrator_defconfig
sh                         apsh4a3a_defconfig
sh                           se7722_defconfig
arm                           viper_defconfig
riscv                randconfig-r042-20220824
s390                 randconfig-r044-20220824
arc                  randconfig-r043-20220824
sh                   secureedge5410_defconfig
sh                         ap325rxa_defconfig
xtensa                    smp_lx200_defconfig
sh                      rts7751r2d1_defconfig
sh                            titan_defconfig
mips                         cobalt_defconfig
powerpc                      tqm8xx_defconfig
x86_64                        randconfig-c001
arm                  randconfig-c002-20220824

clang tested configs:
x86_64                        randconfig-a005
i386                          randconfig-a013
i386                          randconfig-a011
x86_64                        randconfig-a001
x86_64                        randconfig-a014
i386                          randconfig-a015
x86_64                        randconfig-a012
x86_64                        randconfig-a016
x86_64                        randconfig-a003
i386                          randconfig-a002
i386                          randconfig-a004
i386                          randconfig-a006
x86_64                        randconfig-k001
hexagon              randconfig-r045-20220824
hexagon              randconfig-r041-20220824
mips                     cu1000-neo_defconfig
powerpc                    gamecube_defconfig
mips                     decstation_defconfig
mips                           ci20_defconfig
hexagon              randconfig-r045-20220823
riscv                randconfig-r042-20220823
hexagon              randconfig-r041-20220823
s390                 randconfig-r044-20220823
riscv                            alldefconfig
powerpc                      ppc64e_defconfig
powerpc                 mpc8560_ads_defconfig
powerpc                 mpc832x_rdb_defconfig
powerpc                    ge_imp3a_defconfig
powerpc                     tqm8540_defconfig
arm                      pxa255-idp_defconfig

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
