Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 161EB5278E9
	for <lists+linux-kernel@lfdr.de>; Sun, 15 May 2022 19:25:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237887AbiEORZV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 May 2022 13:25:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230196AbiEORZT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 May 2022 13:25:19 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 188DE13CFD
        for <linux-kernel@vger.kernel.org>; Sun, 15 May 2022 10:25:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652635518; x=1684171518;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=Cu3JyDPlu3Q3C7ei4uG0of84Y7YQV4PS62FBHyxkchI=;
  b=B/lN3VhLY6z20Vkm/0GldnFQTn5GQHPg/XUkJkIqPdxWo/6ouLK173HP
   l7fwyCgTo0Q6S0SOsAp1QXehUsqjzlAtvucJzGxN3I78PWHNEVUjqInYC
   j+oAklsS/3uVIcqBO9bS+apir9iC5akxqYGCWmo3RG/f7usXfl0WPbRmc
   /3v4ZeiEfbHj6BuEVz40gGsZtv04uwq3PvRVnyRA+RuW7tyi4QwPZFXvM
   Z2H1+SzuzrIATmpe41gIQljqIOo4KWB97z0vhFKRwUWQfFwFLKf/ucDlO
   gph6HvrAG038zfYfvS8qFt1zVRDRZhNWdmymJwAdVW7QemDS/QKT+xfiK
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10348"; a="252731292"
X-IronPort-AV: E=Sophos;i="5.91,228,1647327600"; 
   d="scan'208";a="252731292"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2022 10:25:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,228,1647327600"; 
   d="scan'208";a="672038591"
Received: from lkp-server01.sh.intel.com (HELO d1462bc4b09b) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 15 May 2022 10:25:13 -0700
Received: from kbuild by d1462bc4b09b with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nqHzV-0001qJ-8U;
        Sun, 15 May 2022 17:25:13 +0000
Date:   Mon, 16 May 2022 01:24:33 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:core/debugobjects] BUILD SUCCESS
 9e4a51ad8eee1d263666fd31ced39bd8e3770822
Message-ID: <62813751.VV2pp0w2CDn9Pydz%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git core/debugobjects
branch HEAD: 9e4a51ad8eee1d263666fd31ced39bd8e3770822  debugobjects: Convert to SPDX license identifier

elapsed time: 3283m

configs tested: 150
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
arm                          simpad_defconfig
arm                        cerfcube_defconfig
sh                          r7785rp_defconfig
sh                          urquell_defconfig
h8300                     edosk2674_defconfig
arm                            hisi_defconfig
mips                        bcm47xx_defconfig
sh                              ul2_defconfig
sh                      rts7751r2d1_defconfig
sh                           se7712_defconfig
mips                             allyesconfig
mips                         tb0226_defconfig
xtensa                         virt_defconfig
m68k                            q40_defconfig
arm                        keystone_defconfig
powerpc                 mpc85xx_cds_defconfig
parisc                generic-64bit_defconfig
sh                   secureedge5410_defconfig
arc                                 defconfig
mips                             allmodconfig
ia64                          tiger_defconfig
m68k                           sun3_defconfig
powerpc                       eiger_defconfig
openrisc                            defconfig
arm                        trizeps4_defconfig
arm                         cm_x300_defconfig
sh                         ecovec24_defconfig
nios2                         3c120_defconfig
m68k                       bvme6000_defconfig
arc                        nsim_700_defconfig
arm                     eseries_pxa_defconfig
sh                 kfr2r09-romimage_defconfig
powerpc                     taishan_defconfig
sparc                       sparc32_defconfig
arm                             ezx_defconfig
sh                          lboxre2_defconfig
powerpc                     stx_gp3_defconfig
xtensa                  cadence_csp_defconfig
riscv             nommu_k210_sdcard_defconfig
arm                        oxnas_v6_defconfig
sh                  sh7785lcr_32bit_defconfig
xtensa                  nommu_kc705_defconfig
mips                 decstation_r4k_defconfig
openrisc                  or1klitex_defconfig
powerpc                    amigaone_defconfig
sh                          landisk_defconfig
powerpc                           allnoconfig
powerpc                         wii_defconfig
um                                  defconfig
arc                        nsimosci_defconfig
sh                           se7750_defconfig
arc                          axs101_defconfig
arm                         s3c6400_defconfig
sh                   rts7751r2dplus_defconfig
mips                         mpc30x_defconfig
sh                          rsk7264_defconfig
sh                           se7751_defconfig
parisc                generic-32bit_defconfig
sh                            hp6xx_defconfig
sh                        sh7763rdp_defconfig
x86_64                        randconfig-c001
arm                  randconfig-c002-20220512
ia64                                defconfig
ia64                             allmodconfig
ia64                             allyesconfig
m68k                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
csky                                defconfig
nios2                            allyesconfig
alpha                               defconfig
alpha                            allyesconfig
h8300                            allyesconfig
xtensa                           allyesconfig
sh                               allmodconfig
s390                                defconfig
s390                             allmodconfig
parisc                              defconfig
parisc64                            defconfig
parisc                           allyesconfig
s390                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
sparc                               defconfig
i386                             allyesconfig
sparc                            allyesconfig
i386                                defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
powerpc                          allyesconfig
powerpc                          allmodconfig
x86_64                        randconfig-a006
x86_64                        randconfig-a004
x86_64                        randconfig-a002
x86_64                        randconfig-a011
x86_64                        randconfig-a013
x86_64                        randconfig-a015
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
s390                 randconfig-r044-20220512
riscv                randconfig-r042-20220512
arc                  randconfig-r043-20220512
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
x86_64                           rhel-8.3-syz
x86_64                                  kexec
x86_64                              defconfig
x86_64                           allyesconfig
x86_64                         rhel-8.3-kunit
x86_64                               rhel-8.3

clang tested configs:
powerpc              randconfig-c003-20220512
x86_64                        randconfig-c007
riscv                randconfig-c006-20220512
mips                 randconfig-c004-20220512
i386                          randconfig-c001
arm                  randconfig-c002-20220512
arm                       netwinder_defconfig
riscv                    nommu_virt_defconfig
arm                           spitz_defconfig
mips                  cavium_octeon_defconfig
powerpc                     tqm8540_defconfig
riscv                             allnoconfig
arm                        mvebu_v5_defconfig
powerpc                 mpc8315_rdb_defconfig
arm                          moxart_defconfig
powerpc                   lite5200b_defconfig
powerpc                 mpc8272_ads_defconfig
x86_64                        randconfig-a005
x86_64                        randconfig-a003
x86_64                        randconfig-a001
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
hexagon              randconfig-r045-20220512
hexagon              randconfig-r041-20220512

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
