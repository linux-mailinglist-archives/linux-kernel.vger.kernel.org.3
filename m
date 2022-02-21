Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85E444BEB9D
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 21:11:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233488AbiBUUMH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 15:12:07 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:52178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231211AbiBUUMF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 15:12:05 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87364112C
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 12:11:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645474301; x=1677010301;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=pFSnKfKYw20v0OIP6zahZrkJypyQ/ME2ioIie5iNjfI=;
  b=Acyd9u0nTJl/Ea2IIvi1PMarHA5Jtho7iOSA3nbFcLc/bLwmw714/LKW
   d0RHVJCuVaGOSbGE15FWuxAVdxINVKiXEf01wiX02fzJJdp80QOr3hUpR
   jwT7ZLa4TMaUWY3CNAl9WTyUtyYDR2pqPw3so29o0bFxD8WhVc/rab0kH
   AfOGQBqvzFg/nzHvGoNCG74VmEbtsAEhWE5SCCjEXL5KA9ZdtVl4Tslh3
   R/M4e9z8V8By7SJNSWhXSrg1p40A+rcAwgSecAzRDNRgpK87hYIr26dWi
   sZu+R2VFO+sR08dxG6FPf+9S7uIe82GYtAkEaE3/uA92Y+qJ/1X1SOYbl
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10265"; a="235104247"
X-IronPort-AV: E=Sophos;i="5.88,386,1635231600"; 
   d="scan'208";a="235104247"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2022 12:11:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,386,1635231600"; 
   d="scan'208";a="776084910"
Received: from lkp-server01.sh.intel.com (HELO da3212ac2f54) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 21 Feb 2022 12:11:39 -0800
Received: from kbuild by da3212ac2f54 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nMF22-0001wS-SD; Mon, 21 Feb 2022 20:11:38 +0000
Date:   Tue, 22 Feb 2022 04:10:51 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:irq/urgent] BUILD SUCCESS
 ba1366f3d039e7c3ca1fc29ed00ce3ed2b8fd32f
Message-ID: <6213f1cb.11mRpjwGnIUQDwto%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq/urgent
branch HEAD: ba1366f3d039e7c3ca1fc29ed00ce3ed2b8fd32f  PCI: vmd: Prevent recursive locking on interrupt allocation

elapsed time: 724m

configs tested: 157
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
i386                 randconfig-c001-20220221
powerpc                      chrp32_defconfig
sh                         ap325rxa_defconfig
sh                          kfr2r09_defconfig
powerpc                         wii_defconfig
sh                   rts7751r2dplus_defconfig
arc                     nsimosci_hs_defconfig
arm                          pxa910_defconfig
powerpc                      bamboo_defconfig
sh                 kfr2r09-romimage_defconfig
m68k                        mvme147_defconfig
parisc                              defconfig
mips                        jmr3927_defconfig
powerpc                       eiger_defconfig
arc                              alldefconfig
parisc64                            defconfig
microblaze                      mmu_defconfig
powerpc                       ppc64_defconfig
alpha                            alldefconfig
sh                           se7724_defconfig
powerpc                      mgcoge_defconfig
arc                 nsimosci_hs_smp_defconfig
riscv                               defconfig
mips                 decstation_r4k_defconfig
sh                           se7780_defconfig
sh                     magicpanelr2_defconfig
mips                             allyesconfig
arm                      jornada720_defconfig
arc                          axs101_defconfig
h8300                     edosk2674_defconfig
m68k                          atari_defconfig
mips                         mpc30x_defconfig
arm                             ezx_defconfig
mips                  decstation_64_defconfig
sh                               allmodconfig
powerpc                  storcenter_defconfig
mips                         tb0226_defconfig
mips                           ip32_defconfig
sh                            hp6xx_defconfig
sh                           se7721_defconfig
ia64                          tiger_defconfig
powerpc                        warp_defconfig
m68k                        m5407c3_defconfig
s390                             allyesconfig
arm                          pxa3xx_defconfig
sh                           sh2007_defconfig
powerpc                    amigaone_defconfig
powerpc                     redwood_defconfig
mips                         db1xxx_defconfig
sh                ecovec24-romimage_defconfig
sh                          sdk7780_defconfig
arm                       aspeed_g5_defconfig
powerpc                        cell_defconfig
sh                          lboxre2_defconfig
powerpc                         ps3_defconfig
powerpc                      pcm030_defconfig
sh                           se7751_defconfig
xtensa                           alldefconfig
arm                        trizeps4_defconfig
sparc64                             defconfig
sh                        sh7757lcr_defconfig
s390                                defconfig
powerpc                 linkstation_defconfig
powerpc                     sequoia_defconfig
arm                  randconfig-c002-20220221
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
alpha                               defconfig
alpha                            allyesconfig
xtensa                           allyesconfig
h8300                            allyesconfig
arc                                 defconfig
s390                             allmodconfig
parisc                           allyesconfig
i386                             allyesconfig
i386                              debian-10.3
i386                   debian-10.3-kselftests
i386                                defconfig
sparc                            allyesconfig
sparc                               defconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a002-20220221
x86_64               randconfig-a001-20220221
x86_64               randconfig-a003-20220221
x86_64               randconfig-a006-20220221
x86_64               randconfig-a004-20220221
x86_64               randconfig-a005-20220221
i386                 randconfig-a002-20220221
i386                 randconfig-a001-20220221
i386                 randconfig-a005-20220221
i386                 randconfig-a003-20220221
i386                 randconfig-a006-20220221
i386                 randconfig-a004-20220221
arc                  randconfig-r043-20220221
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
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
powerpc              randconfig-c003-20220221
x86_64               randconfig-c007-20220221
arm                  randconfig-c002-20220221
mips                 randconfig-c004-20220221
i386                 randconfig-c001-20220221
riscv                randconfig-c006-20220221
powerpc                      pmac32_defconfig
mips                           ip22_defconfig
arm                          moxart_defconfig
mips                          ath79_defconfig
powerpc                      katmai_defconfig
arm                  colibri_pxa300_defconfig
powerpc                     tqm5200_defconfig
mips                        omega2p_defconfig
arm                         shannon_defconfig
mips                      pic32mzda_defconfig
arm                            mmp2_defconfig
x86_64               randconfig-a015-20220221
x86_64               randconfig-a011-20220221
x86_64               randconfig-a012-20220221
x86_64               randconfig-a014-20220221
x86_64               randconfig-a013-20220221
x86_64               randconfig-a016-20220221
i386                 randconfig-a016-20220221
i386                 randconfig-a012-20220221
i386                 randconfig-a015-20220221
i386                 randconfig-a011-20220221
i386                 randconfig-a014-20220221
i386                 randconfig-a013-20220221
hexagon              randconfig-r041-20220221
hexagon              randconfig-r045-20220221
riscv                randconfig-r042-20220221
s390                 randconfig-r044-20220221

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
