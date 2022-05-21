Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C4D252FE1F
	for <lists+linux-kernel@lfdr.de>; Sat, 21 May 2022 18:32:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245590AbiEUQbv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 May 2022 12:31:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230071AbiEUQbt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 May 2022 12:31:49 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 259EC5DD1E
        for <linux-kernel@vger.kernel.org>; Sat, 21 May 2022 09:31:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653150708; x=1684686708;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=PB0LVkRhNYxLHkmCHC4bTytsuw+bRI1tm3gD2okPrec=;
  b=CgILwIZ+gCiEAxGjCRLfVy1Mf2K6rUbCgkDdbeq5tJ4nhjYafoVGYlXj
   vOeQTzfNru3pnzAFBe3aHGiWwmPPnY08DPn9TLXgcvQ0QRdD/vCAS1unv
   xpu7Bb3y9DleDe/uXneMytAnNtwAXXZN/K696mc0GSCsISbajuEpjOaSE
   8G9abXmuCJlpt1TrXKh0L6j42RQ7dB+KeIDO6V5zhnBQzlPzE3Td7vRkz
   Bc8u7Zc0Ha/Iwb4O6MNxeYcRcFZm90141Fgc9hWZBOq7LEFWo9WIhglEj
   EHrZUqsVNUcE1jPVsaKUfmqfM8lJPT9eHoyjtVTnqixHhMX8PjR9jyNPl
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10354"; a="333503856"
X-IronPort-AV: E=Sophos;i="5.91,242,1647327600"; 
   d="scan'208";a="333503856"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2022 09:31:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,242,1647327600"; 
   d="scan'208";a="628644032"
Received: from lkp-server02.sh.intel.com (HELO 242b25809ac7) ([10.239.97.151])
  by fmsmga008.fm.intel.com with ESMTP; 21 May 2022 09:31:46 -0700
Received: from kbuild by 242b25809ac7 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nsS13-0006Ri-I1;
        Sat, 21 May 2022 16:31:45 +0000
Date:   Sun, 22 May 2022 00:31:07 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:auto-latest] BUILD SUCCESS
 10edb53c5d7c67a9fe09c492288d752e17172909
Message-ID: <628913cb.8o8vjqmwkFRWyx+U%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git auto-latest
branch HEAD: 10edb53c5d7c67a9fe09c492288d752e17172909  Merge branch into tip/master: 'x86/sev'

elapsed time: 3345m

configs tested: 162
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
m68k                          hp300_defconfig
m68k                             alldefconfig
openrisc                 simple_smp_defconfig
sh                         microdev_defconfig
xtensa                generic_kc705_defconfig
riscv                               defconfig
mips                           ci20_defconfig
x86_64                              defconfig
s390                       zfcpdump_defconfig
arm                         axm55xx_defconfig
ia64                      gensparse_defconfig
arm                         s3c6400_defconfig
powerpc                     taishan_defconfig
ia64                        generic_defconfig
powerpc                      chrp32_defconfig
s390                          debug_defconfig
mips                  maltasmvp_eva_defconfig
powerpc                     mpc83xx_defconfig
sh                           se7705_defconfig
arm                        mini2440_defconfig
xtensa                           allyesconfig
m68k                            q40_defconfig
sh                           se7721_defconfig
arm                           tegra_defconfig
arm                        cerfcube_defconfig
arm                           corgi_defconfig
xtensa                          iss_defconfig
um                                  defconfig
powerpc                        cell_defconfig
sh                                  defconfig
arm                        realview_defconfig
xtensa                    smp_lx200_defconfig
xtensa                       common_defconfig
alpha                               defconfig
arm                           h5000_defconfig
arm                        multi_v7_defconfig
ia64                         bigsur_defconfig
sh                          landisk_defconfig
arc                            hsdk_defconfig
mips                    maltaup_xpa_defconfig
arc                      axs103_smp_defconfig
powerpc                 mpc834x_mds_defconfig
h8300                       h8s-sim_defconfig
powerpc                      ep88xc_defconfig
arm                            lart_defconfig
sh                          urquell_defconfig
x86_64                           alldefconfig
powerpc                 canyonlands_defconfig
arm                      footbridge_defconfig
sh                          sdk7786_defconfig
mips                 decstation_r4k_defconfig
mips                         mpc30x_defconfig
powerpc                 mpc837x_mds_defconfig
arm                           viper_defconfig
xtensa                         virt_defconfig
parisc                           alldefconfig
mips                         rt305x_defconfig
m68k                           sun3_defconfig
arm                           sama5_defconfig
arc                         haps_hs_defconfig
x86_64                        randconfig-c001
arm                  randconfig-c002-20220519
ia64                             allmodconfig
ia64                             allyesconfig
ia64                                defconfig
riscv                             allnoconfig
m68k                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
nios2                               defconfig
arc                              allyesconfig
csky                                defconfig
nios2                            allyesconfig
alpha                            allyesconfig
h8300                            allyesconfig
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
powerpc                           allnoconfig
powerpc                          allmodconfig
powerpc                          allyesconfig
i386                          randconfig-a003
i386                          randconfig-a005
i386                          randconfig-a001
x86_64                        randconfig-a006
x86_64                        randconfig-a004
x86_64                        randconfig-a002
x86_64                        randconfig-a013
x86_64                        randconfig-a015
x86_64                        randconfig-a011
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
arc                  randconfig-r043-20220519
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
riscv                            allmodconfig
riscv                            allyesconfig
x86_64                    rhel-8.3-kselftests
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                                  kexec
x86_64                           allyesconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit

clang tested configs:
powerpc              randconfig-c003-20220519
x86_64                        randconfig-c007
riscv                randconfig-c006-20220519
mips                 randconfig-c004-20220519
i386                          randconfig-c001
arm                  randconfig-c002-20220519
mips                      malta_kvm_defconfig
arm                          ixp4xx_defconfig
arm                              alldefconfig
arm                          pxa168_defconfig
powerpc                   bluestone_defconfig
powerpc                        icon_defconfig
powerpc                      katmai_defconfig
powerpc                      ppc44x_defconfig
arm                       spear13xx_defconfig
mips                           rs90_defconfig
arm                         shannon_defconfig
powerpc                       ebony_defconfig
arm                         orion5x_defconfig
powerpc                          allmodconfig
arm                         palmz72_defconfig
mips                            e55_defconfig
arm                        mvebu_v5_defconfig
powerpc                  mpc885_ads_defconfig
powerpc                    gamecube_defconfig
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64                        randconfig-a005
x86_64                        randconfig-a003
x86_64                        randconfig-a001
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
s390                 randconfig-r044-20220519
hexagon              randconfig-r045-20220519
hexagon              randconfig-r041-20220519
riscv                randconfig-r042-20220519

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
