Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6B764BCCF4
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Feb 2022 08:18:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235425AbiBTHR7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Feb 2022 02:17:59 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:58502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229705AbiBTHR4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Feb 2022 02:17:56 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57F39112A
        for <linux-kernel@vger.kernel.org>; Sat, 19 Feb 2022 23:17:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645341456; x=1676877456;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=T12FtAVmruRZaWPKWh0V6W8D3yBBDwGkjS2Sf6u43EU=;
  b=Q/cub1uMwL8G5vdnNLdF9XcstSpZwX6DrKCtwmx7goB8nRubPcDevKig
   9+tE5w5yYf0t1KUabwaRE/jWeEX5hSrq6VZcXVzAgknvCvrqWRSS8sMTo
   g44JrKogcnrxtBmMnxrvfsZELbgq/Y2cah69scDPR0HrfQ9Oj4dTW1s7M
   BrMtbPJN0lfSr6urbvFeB+5/tCMaXHrCsqShM9m9m8d08dd+rXmkxuDvg
   AhDXJ9LiwbVVA7AR2MZ4OI+o6AHfOiloR+oBN0zDhoDwC09nqhkY5rS/B
   Fpn5ZJkjtEgukwA4zfbTJezg9sXEuHS6QHMZBlVyCJx6cblK3W9PIr/AT
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10263"; a="337782338"
X-IronPort-AV: E=Sophos;i="5.88,383,1635231600"; 
   d="scan'208";a="337782338"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2022 23:17:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,383,1635231600"; 
   d="scan'208";a="627042879"
Received: from lkp-server01.sh.intel.com (HELO da3212ac2f54) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 19 Feb 2022 23:17:34 -0800
Received: from kbuild by da3212ac2f54 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nLgTO-00004x-3o; Sun, 20 Feb 2022 07:17:34 +0000
Date:   Sun, 20 Feb 2022 15:16:57 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/sgx] BUILD SUCCESS
 6170abb21e2380477080b25145da9747ad467d3d
Message-ID: <6211eae9.WhxZaGeHnQjxHtBz%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/sgx
branch HEAD: 6170abb21e2380477080b25145da9747ad467d3d  selftests/sgx: Treat CC as one argument

elapsed time: 3507m

configs tested: 135
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
i386                          randconfig-c001
arm                       omap2plus_defconfig
nios2                         3c120_defconfig
arm                            xcep_defconfig
mips                         mpc30x_defconfig
powerpc                       maple_defconfig
arc                                 defconfig
sh                         microdev_defconfig
mips                  decstation_64_defconfig
parisc                generic-32bit_defconfig
m68k                            mac_defconfig
ia64                         bigsur_defconfig
powerpc                        cell_defconfig
arc                          axs101_defconfig
arc                        vdk_hs38_defconfig
arc                    vdk_hs38_smp_defconfig
xtensa                generic_kc705_defconfig
powerpc                 mpc834x_itx_defconfig
powerpc                       eiger_defconfig
h8300                               defconfig
microblaze                      mmu_defconfig
m68k                       m5475evb_defconfig
arm                        spear6xx_defconfig
arm                            lart_defconfig
sh                            titan_defconfig
h8300                            alldefconfig
powerpc                      pasemi_defconfig
x86_64                           alldefconfig
alpha                               defconfig
arc                         haps_hs_defconfig
xtensa                           alldefconfig
powerpc                 mpc8540_ads_defconfig
sh                     sh7710voipgw_defconfig
arm                           corgi_defconfig
sh                          sdk7780_defconfig
m68k                        m5272c3_defconfig
arm                           h5000_defconfig
m68k                       m5208evb_defconfig
arm                             ezx_defconfig
sparc                       sparc32_defconfig
parisc64                            defconfig
microblaze                          defconfig
arm                  randconfig-c002-20220217
arm                  randconfig-c002-20220218
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
nds32                               defconfig
nios2                            allyesconfig
csky                                defconfig
alpha                            allyesconfig
xtensa                           allyesconfig
h8300                            allyesconfig
sh                               allmodconfig
parisc                              defconfig
s390                             allyesconfig
s390                             allmodconfig
parisc                           allyesconfig
s390                                defconfig
i386                             allyesconfig
sparc                            allyesconfig
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
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
riscv                randconfig-r042-20220218
arc                  randconfig-r043-20220217
s390                 randconfig-r044-20220218
arc                  randconfig-r043-20220218
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                    rhel-8.3-kselftests
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                           allyesconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                                  kexec

clang tested configs:
riscv                randconfig-c006-20220217
x86_64                        randconfig-c007
powerpc              randconfig-c003-20220217
arm                  randconfig-c002-20220217
i386                          randconfig-c001
mips                 randconfig-c004-20220217
mips                          ath79_defconfig
mips                           ip22_defconfig
arm                     davinci_all_defconfig
arm                      tct_hammer_defconfig
riscv                            alldefconfig
mips                         tb0287_defconfig
arm                        spear3xx_defconfig
arm                     am200epdkit_defconfig
powerpc                     tqm5200_defconfig
arm                        magician_defconfig
x86_64                        randconfig-a005
x86_64                        randconfig-a003
x86_64                        randconfig-a001
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
i386                          randconfig-a011
i386                          randconfig-a013
i386                          randconfig-a015
hexagon              randconfig-r045-20220217
hexagon              randconfig-r041-20220217
riscv                randconfig-r042-20220217

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
