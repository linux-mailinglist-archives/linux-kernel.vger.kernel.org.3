Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 421785990AC
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 00:42:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344412AbiHRWlU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 18:41:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243822AbiHRWlS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 18:41:18 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67BC4DC0A4
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 15:41:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660862477; x=1692398477;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=v1oyskW2FpLv925v7lM7xelZT4A7QhJ6jHcYLJ62ACs=;
  b=JAshljhqZZydKgoRjONwriua67OPbaoj17PFdD1XAvJ4de1RaSfekGV/
   VuxqHf/9WxP534nz7E7PiUtpjB/wt5wOuFwJhGnsII2ODEKMQ68JYH6B8
   oyBsUiUQDTRydnKhZ4GgCi9DD1PbYngB+NVGznnf7gEJ0ponDT5i9wSpY
   k+nfaSlHv2DlX35Lm5qByjhmOXku0Yji/wvgXQ1ZU57GuQLJ7oR2HvE++
   mqYMfE+5j1Ze88b9PtGj8qx9hikAFMAWmAAkmT8JHS10cm+Xt7JPfSinP
   insfNvs50nMmK1bmIxV8NrH9ASvUrbQDj7ZKM+fiUgEbBbOyg5tjowOzC
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10443"; a="291642415"
X-IronPort-AV: E=Sophos;i="5.93,247,1654585200"; 
   d="scan'208";a="291642415"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2022 15:41:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,247,1654585200"; 
   d="scan'208";a="641037374"
Received: from lkp-server01.sh.intel.com (HELO 44b6dac04a33) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 18 Aug 2022 15:41:15 -0700
Received: from kbuild by 44b6dac04a33 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oOoCR-0000il-0u;
        Thu, 18 Aug 2022 22:41:15 +0000
Date:   Fri, 19 Aug 2022 06:41:03 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/cpu] BUILD SUCCESS
 0db7058e8e23e6bbab1b4747ecabd1784c34f50b
Message-ID: <62febfff.6iPHw5th7VGEUE/w%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/cpu
branch HEAD: 0db7058e8e23e6bbab1b4747ecabd1784c34f50b  x86/clear_user: Make it faster

elapsed time: 721m

configs tested: 128
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arc                  randconfig-r043-20220818
um                             i386_defconfig
riscv                randconfig-r042-20220818
um                           x86_64_defconfig
s390                 randconfig-r044-20220818
powerpc                           allnoconfig
powerpc                          allmodconfig
mips                             allyesconfig
arm                                 defconfig
arm64                            allyesconfig
arm                              allyesconfig
x86_64                              defconfig
x86_64                        randconfig-a004
i386                          randconfig-a001
i386                                defconfig
x86_64                        randconfig-a013
i386                          randconfig-a003
i386                          randconfig-a014
x86_64                        randconfig-a002
x86_64                          rhel-8.3-func
arc                              allyesconfig
x86_64                         rhel-8.3-kunit
x86_64                        randconfig-a011
alpha                            allyesconfig
x86_64                           allyesconfig
x86_64                           rhel-8.3-kvm
m68k                             allyesconfig
arc                               allnoconfig
x86_64                               rhel-8.3
x86_64                        randconfig-a015
m68k                             allmodconfig
i386                          randconfig-a005
x86_64                    rhel-8.3-kselftests
alpha                             allnoconfig
riscv                             allnoconfig
csky                              allnoconfig
x86_64                           rhel-8.3-syz
x86_64                        randconfig-a006
i386                          randconfig-a012
i386                          randconfig-a016
sh                               allmodconfig
ia64                             allmodconfig
i386                             allyesconfig
arc                          axs101_defconfig
sh                   rts7751r2dplus_defconfig
powerpc                 mpc837x_mds_defconfig
powerpc                       maple_defconfig
alpha                            alldefconfig
sh                                  defconfig
m68k                       m5475evb_defconfig
sh                         ecovec24_defconfig
sh                        edosk7705_defconfig
sh                             sh03_defconfig
arm                             ezx_defconfig
sh                           se7712_defconfig
mips                        vocore2_defconfig
arm                        oxnas_v6_defconfig
loongarch                           defconfig
loongarch                         allnoconfig
arm                            zeus_defconfig
nios2                         3c120_defconfig
i386                          randconfig-c001
mips                      loongson3_defconfig
sh                          polaris_defconfig
arc                          axs103_defconfig
powerpc                         wii_defconfig
sh                               j2_defconfig
mips                  decstation_64_defconfig
powerpc                      cm5200_defconfig
mips                            gpr_defconfig
sh                               alldefconfig
arm                           sunxi_defconfig
arc                 nsimosci_hs_smp_defconfig
loongarch                        alldefconfig
m68k                                defconfig
sparc                             allnoconfig
m68k                         amcore_defconfig
xtensa                              defconfig
ia64                                defconfig
arm                           sama5_defconfig
um                                  defconfig
ia64                             alldefconfig
arm                            mps2_defconfig
sparc                       sparc64_defconfig
m68k                        m5307c3_defconfig
m68k                           sun3_defconfig
sh                           sh2007_defconfig
arm                          gemini_defconfig
arm64                               defconfig
m68k                          hp300_defconfig
sh                          landisk_defconfig
openrisc                       virt_defconfig
arm                          pxa910_defconfig
sh                        apsh4ad0a_defconfig
arm                            pleb_defconfig
parisc                generic-64bit_defconfig
sh                          rsk7201_defconfig
mips                         db1xxx_defconfig
mips                       bmips_be_defconfig

clang tested configs:
hexagon              randconfig-r041-20220818
hexagon              randconfig-r045-20220818
i386                          randconfig-a013
i386                          randconfig-a015
i386                          randconfig-a002
x86_64                        randconfig-a005
x86_64                        randconfig-a001
x86_64                        randconfig-a016
x86_64                        randconfig-a012
i386                          randconfig-a006
x86_64                        randconfig-a014
i386                          randconfig-a011
i386                          randconfig-a004
x86_64                        randconfig-a003
arm                        multi_v5_defconfig
mips                      pic32mzda_defconfig
x86_64                        randconfig-k001
arm                          moxart_defconfig
mips                           ip22_defconfig
mips                          ath25_defconfig
powerpc                          allmodconfig
riscv                    nommu_virt_defconfig
mips                        qi_lb60_defconfig
mips                        omega2p_defconfig
arm                             mxs_defconfig
arm                  colibri_pxa270_defconfig
hexagon                             defconfig
arm                         bcm2835_defconfig
arm                         s5pv210_defconfig
arm                         shannon_defconfig

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
