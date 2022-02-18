Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26BBC4BAF31
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 02:44:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231288AbiBRBo2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 20:44:28 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:51372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231156AbiBRBo0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 20:44:26 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8206F673CD
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 17:44:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645148650; x=1676684650;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=8GWz5ucNz+/A+WuLCYebshSzW0dvHmqhyyhAmPSllNI=;
  b=bJPdUDMDaj9LvYJRDZry5uXgzsunV++5Ez8p3Ms/VcDVIs7t1wPVEaal
   VGNFpCCUMH6U9uBZD4WYM27gvKDssUT0rO1yPe47R9FspGMUJVVwhO25A
   ef1Y6GOQTg3lbbiRG7Dg53VW+7M92zDM/BBUOH62bcvIEvL+zuYbxqono
   b8tRjWWU9s9+pGEJJidhPuy6k+fh1pyYMljwNotHEkl5I6bLZevqlbM1U
   yjHtEWSuUfNEqpNQ0mlRAYuwhEBzO4fBXL+yIb6j2EWkKtF7erv5bhv7a
   ajtcnn2NQt+mA+2BUa1ZUvD0JRuJCqiQtgwR002FLzrqQaKsWeBNhXcH+
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10261"; a="251225962"
X-IronPort-AV: E=Sophos;i="5.88,377,1635231600"; 
   d="scan'208";a="251225962"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2022 17:44:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,377,1635231600"; 
   d="scan'208";a="637520539"
Received: from lkp-server01.sh.intel.com (HELO 6f05bf9e3301) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 17 Feb 2022 17:44:08 -0800
Received: from kbuild by 6f05bf9e3301 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nKsJb-0000nq-W1; Fri, 18 Feb 2022 01:44:07 +0000
Date:   Fri, 18 Feb 2022 09:43:13 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: [gustavoars:for-next/kspp-fam0] BUILD SUCCESS
 5224f79096170bf7b92cc8fe42a12f44b91e5f62
Message-ID: <620ef9b1.dsG5qgpNOV49X8xn%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git for-next/kspp-fam0
branch HEAD: 5224f79096170bf7b92cc8fe42a12f44b91e5f62  treewide: Replace zero-length arrays with flexible-array members

elapsed time: 728m

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
powerpc                       ppc64_defconfig
arm                           viper_defconfig
powerpc                       maple_defconfig
arc                                 defconfig
sh                         microdev_defconfig
mips                  decstation_64_defconfig
riscv                            allyesconfig
xtensa                  nommu_kc705_defconfig
xtensa                    xip_kc705_defconfig
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
nios2                         3c120_defconfig
m68k                         apollo_defconfig
sh                           se7343_defconfig
sh                     sh7710voipgw_defconfig
powerpc                      pasemi_defconfig
arc                    vdk_hs38_smp_defconfig
x86_64                           alldefconfig
mips                           ip32_defconfig
mips                            gpr_defconfig
arm                             pxa_defconfig
powerpc64                           defconfig
powerpc                    klondike_defconfig
sh                               j2_defconfig
arc                         haps_hs_defconfig
xtensa                           alldefconfig
arm                           corgi_defconfig
sh                          sdk7780_defconfig
m68k                        m5272c3_defconfig
arm                           h5000_defconfig
ia64                         bigsur_defconfig
powerpc                      tqm8xx_defconfig
um                             i386_defconfig
m68k                         amcore_defconfig
arm                          pxa3xx_defconfig
ia64                          tiger_defconfig
m68k                           sun3_defconfig
powerpc                        cell_defconfig
powerpc                      makalu_defconfig
m68k                       m5208evb_defconfig
arm                             ezx_defconfig
sparc                       sparc32_defconfig
microblaze                          defconfig
arm                  randconfig-c002-20220217
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
sh                               allmodconfig
parisc                              defconfig
s390                             allyesconfig
s390                             allmodconfig
parisc64                            defconfig
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
i386                          randconfig-a003
i386                          randconfig-a001
i386                          randconfig-a005
riscv                    nommu_k210_defconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                    rhel-8.3-kselftests
um                           x86_64_defconfig
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
arm                     am200epdkit_defconfig
powerpc                     tqm5200_defconfig
arm                        magician_defconfig
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
