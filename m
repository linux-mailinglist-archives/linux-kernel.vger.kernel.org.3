Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0993526310
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 15:52:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349046AbiEMNuq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 09:50:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232221AbiEMNkr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 09:40:47 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5912E1DA61
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 06:40:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652449246; x=1683985246;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=luzbh+YeXGpT/r2UcJTQVkNi7MLOqLPcULuFtpkZO0M=;
  b=iyqB+2IfJ8dkU5nlIfHfn8MxpB6tBzncjk4OeZDZkJPT47ISUknSq6al
   QgygXZihQ7p0rOfO2BeqFBsH1poaXyhI5KuqduK4fO1m2kYFILeW0ZLIw
   lKtbF75DXdEahlCPy/CGnVSefjUrIvkMvbChYDilSlKJgoSf1jWnyq1az
   9Z+km4zOpKZs0EvXHKS9Dk1oU/R3bpV33shAZWjYyYJVPlDDwBG1p9oNj
   42zLmo38GGXU4fygmjS5plxGEwnd0FwiTY/tVUly2jdItVW23ab2cOjb1
   wSJnIRmmCCvok3CM7+Q6QDky416nZEFZXEXwXpXNFZKbGRNp/SjC+EILN
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10345"; a="269977517"
X-IronPort-AV: E=Sophos;i="5.91,223,1647327600"; 
   d="scan'208";a="269977517"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2022 06:40:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,223,1647327600"; 
   d="scan'208";a="521421639"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 13 May 2022 06:40:44 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1npVX9-000Lni-N8;
        Fri, 13 May 2022 13:40:43 +0000
Date:   Fri, 13 May 2022 21:39:43 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:dev.2022.04.26a] BUILD SUCCESS
 a72d27598150936800e6aa313c507c6903f8ed9c
Message-ID: <627e5f9f.N75pN3+JFEyTYuM4%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev.2022.04.26a
branch HEAD: a72d27598150936800e6aa313c507c6903f8ed9c  rcu: Add nocb_cb_kthread check to rcu_is_callbacks_kthread()

elapsed time: 15219m

configs tested: 253
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
mips                         tb0226_defconfig
powerpc                      cm5200_defconfig
powerpc                       holly_defconfig
powerpc                         ps3_defconfig
xtensa                           allyesconfig
arc                     haps_hs_smp_defconfig
arc                            hsdk_defconfig
arm                         vf610m4_defconfig
powerpc                     ep8248e_defconfig
nios2                            allyesconfig
s390                       zfcpdump_defconfig
arm                        realview_defconfig
arm                       multi_v4t_defconfig
xtensa                  nommu_kc705_defconfig
sparc64                          alldefconfig
mips                           jazz_defconfig
sh                            titan_defconfig
ia64                        generic_defconfig
parisc                              defconfig
sh                         microdev_defconfig
powerpc                     taishan_defconfig
m68k                           sun3_defconfig
powerpc                      pcm030_defconfig
parisc                           allyesconfig
arm                     eseries_pxa_defconfig
sh                           se7780_defconfig
powerpc                     pq2fads_defconfig
m68k                          hp300_defconfig
ia64                          tiger_defconfig
m68k                          atari_defconfig
powerpc                           allnoconfig
powerpc                     tqm8555_defconfig
h8300                               defconfig
sh                          rsk7264_defconfig
sparc                            alldefconfig
sh                           se7619_defconfig
arm                      integrator_defconfig
microblaze                          defconfig
mips                         cobalt_defconfig
mips                        bcm47xx_defconfig
sh                        apsh4ad0a_defconfig
arm                        keystone_defconfig
i386                                defconfig
mips                         rt305x_defconfig
alpha                            alldefconfig
powerpc                      ep88xc_defconfig
arm                           imxrt_defconfig
mips                  maltasmvp_eva_defconfig
powerpc                    klondike_defconfig
arc                          axs103_defconfig
m68k                       m5275evb_defconfig
sh                         ap325rxa_defconfig
powerpc                mpc7448_hpc2_defconfig
xtensa                              defconfig
parisc                generic-64bit_defconfig
sh                          lboxre2_defconfig
sparc64                             defconfig
arm                           sunxi_defconfig
powerpc                       maple_defconfig
m68k                       m5249evb_defconfig
arc                 nsimosci_hs_smp_defconfig
mips                           ip32_defconfig
powerpc                     asp8347_defconfig
arc                           tb10x_defconfig
mips                       bmips_be_defconfig
sh                 kfr2r09-romimage_defconfig
arm                         nhk8815_defconfig
sh                            migor_defconfig
arm                       omap2plus_defconfig
mips                  decstation_64_defconfig
sh                          kfr2r09_defconfig
mips                      fuloong2e_defconfig
nios2                         3c120_defconfig
m68k                        stmark2_defconfig
powerpc64                           defconfig
sh                        edosk7760_defconfig
s390                          debug_defconfig
sh                      rts7751r2d1_defconfig
sh                   sh7724_generic_defconfig
sh                        sh7785lcr_defconfig
powerpc                        cell_defconfig
riscv             nommu_k210_sdcard_defconfig
openrisc                  or1klitex_defconfig
powerpc                     sequoia_defconfig
sh                        sh7757lcr_defconfig
mips                     decstation_defconfig
powerpc                         wii_defconfig
powerpc                 mpc8540_ads_defconfig
powerpc                     mpc83xx_defconfig
powerpc                    amigaone_defconfig
mips                      maltasmvp_defconfig
um                           x86_64_defconfig
sh                             espt_defconfig
xtensa                    smp_lx200_defconfig
openrisc                            defconfig
sh                          urquell_defconfig
powerpc                      ppc40x_defconfig
arm                            lart_defconfig
powerpc                      arches_defconfig
sh                                  defconfig
arm                         at91_dt_defconfig
m68k                             alldefconfig
arm                            qcom_defconfig
sparc                       sparc64_defconfig
sh                           se7721_defconfig
sh                           se7705_defconfig
sh                          polaris_defconfig
arm                        mini2440_defconfig
m68k                             allyesconfig
microblaze                      mmu_defconfig
arc                                 defconfig
arm                            hisi_defconfig
mips                       capcella_defconfig
alpha                            allyesconfig
arm                            mps2_defconfig
x86_64                        randconfig-c001
arm                  randconfig-c002-20220501
arm                  randconfig-c002-20220505
x86_64               randconfig-c001-20220502
i386                 randconfig-c001-20220502
arm                  randconfig-c002-20220502
ia64                                defconfig
ia64                             allmodconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
nios2                               defconfig
arc                              allyesconfig
csky                                defconfig
alpha                               defconfig
h8300                            allyesconfig
sh                               allmodconfig
s390                                defconfig
s390                             allmodconfig
parisc64                            defconfig
s390                             allyesconfig
sparc                               defconfig
i386                             allyesconfig
sparc                            allyesconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
x86_64               randconfig-a006-20220502
x86_64               randconfig-a001-20220502
x86_64               randconfig-a003-20220502
x86_64               randconfig-a002-20220502
x86_64               randconfig-a004-20220502
x86_64               randconfig-a005-20220502
x86_64                        randconfig-a006
x86_64                        randconfig-a004
x86_64                        randconfig-a002
i386                 randconfig-a004-20220502
i386                 randconfig-a006-20220502
i386                 randconfig-a002-20220502
i386                 randconfig-a003-20220502
i386                 randconfig-a001-20220502
x86_64                        randconfig-a011
x86_64                        randconfig-a013
x86_64                        randconfig-a015
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
arc                  randconfig-r043-20220501
s390                 randconfig-r044-20220501
riscv                randconfig-r042-20220501
arc                  randconfig-r043-20220502
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
x86_64                           rhel-8.3-syz
x86_64                                  kexec
x86_64                              defconfig
x86_64                         rhel-8.3-kunit
x86_64                               rhel-8.3
x86_64                           allyesconfig

clang tested configs:
x86_64                        randconfig-c007
i386                          randconfig-c001
powerpc              randconfig-c003-20220501
riscv                randconfig-c006-20220501
mips                 randconfig-c004-20220501
arm                  randconfig-c002-20220501
powerpc              randconfig-c003-20220505
riscv                randconfig-c006-20220505
arm                  randconfig-c002-20220505
mips                     loongson2k_defconfig
arm                   milbeaut_m10v_defconfig
powerpc                    ge_imp3a_defconfig
mips                          malta_defconfig
powerpc                      pmac32_defconfig
arm                         lpc32xx_defconfig
powerpc                    socrates_defconfig
mips                     cu1830-neo_defconfig
riscv                    nommu_virt_defconfig
powerpc                  mpc866_ads_defconfig
mips                  cavium_octeon_defconfig
arm                          ep93xx_defconfig
arm                        neponset_defconfig
arm                          moxart_defconfig
powerpc                        fsp2_defconfig
powerpc                   microwatt_defconfig
mips                       lemote2f_defconfig
arm                         bcm2835_defconfig
arm                       spear13xx_defconfig
arm                  colibri_pxa270_defconfig
powerpc                 mpc8315_rdb_defconfig
arm                         shannon_defconfig
powerpc               mpc834x_itxgp_defconfig
arm                            dove_defconfig
powerpc                     ksi8560_defconfig
powerpc                      katmai_defconfig
powerpc                 mpc8560_ads_defconfig
powerpc                     tqm8540_defconfig
arm                        multi_v5_defconfig
powerpc                     kmeter1_defconfig
powerpc                     powernv_defconfig
x86_64                        randconfig-a005
x86_64                        randconfig-a003
x86_64                        randconfig-a001
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
x86_64               randconfig-a015-20220502
x86_64               randconfig-a012-20220502
x86_64               randconfig-a016-20220502
x86_64               randconfig-a014-20220502
x86_64               randconfig-a013-20220502
x86_64               randconfig-a011-20220502
i386                 randconfig-a011-20220502
i386                 randconfig-a013-20220502
i386                 randconfig-a016-20220502
i386                 randconfig-a015-20220502
i386                 randconfig-a014-20220502
i386                 randconfig-a012-20220502
hexagon              randconfig-r045-20220502
hexagon              randconfig-r045-20220501
riscv                randconfig-r042-20220502
hexagon              randconfig-r041-20220502
hexagon              randconfig-r041-20220501

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
