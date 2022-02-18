Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB5224BB0F2
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 05:53:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230071AbiBRExd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 23:53:33 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:51504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229645AbiBRExa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 23:53:30 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84A076580
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 20:53:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645159994; x=1676695994;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=YzhlzeCExCO59G1Z7/40cxwY3nWas+LjB2Rnfev9e1Y=;
  b=VntZSYcYU0NA0Zlj7EmZs+y/Xr5Ny/SM2wJaTnj+iKVrDsKiunDWYGxs
   M9fNB5I8DIQ647ZdjDFHUkF/5BnrGGM0+vdCjeU8En8bDttcl5E4hfU1X
   pZd3wkv5j2i24gLSK9gS6uYPFoxiLpho8hA76VDciNiGJ55wIr6FZAGhD
   xpajfxxriuX4C7pdr48mRL29sB3avUbnbtvCOYsT00xLyjg9qNEXykKL3
   q9NKaZKc1Eehk2unOYUYNrSKMIX2HFFTrt0y+Juxy6lJCnimhusEL/Ag6
   QAtd1WWzD3c7jpgks3AZEp4U5CGZT7tIPsGXN4ETredExP2vGYs+/+77r
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10261"; a="238455545"
X-IronPort-AV: E=Sophos;i="5.88,377,1635231600"; 
   d="scan'208";a="238455545"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2022 20:53:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,377,1635231600"; 
   d="scan'208";a="489146834"
Received: from lkp-server01.sh.intel.com (HELO 6f05bf9e3301) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 17 Feb 2022 20:53:12 -0800
Received: from kbuild by 6f05bf9e3301 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nKvGa-0000x7-53; Fri, 18 Feb 2022 04:53:12 +0000
Date:   Fri, 18 Feb 2022 12:53:05 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:dev.2022.02.16a] BUILD SUCCESS
 a8a211791f8c93c42529755fa12e85cbc3461db7
Message-ID: <620f2631.4WrSMauQ3QQAQUzc%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev.2022.02.16a
branch HEAD: a8a211791f8c93c42529755fa12e85cbc3461db7  rcu/nocb: Initialize nocb kthreads only for boot CPU prior SMP initialization

elapsed time: 1606m

configs tested: 173
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
arm                        cerfcube_defconfig
arm                          exynos_defconfig
arc                          axs103_defconfig
arm                           corgi_defconfig
powerpc                      ep88xc_defconfig
sh                ecovec24-romimage_defconfig
sh                        dreamcast_defconfig
powerpc                 mpc85xx_cds_defconfig
xtensa                generic_kc705_defconfig
arc                      axs103_smp_defconfig
powerpc                       maple_defconfig
sh                         microdev_defconfig
mips                  decstation_64_defconfig
arc                                 defconfig
m68k                          hp300_defconfig
powerpc                      cm5200_defconfig
powerpc                      makalu_defconfig
parisc                generic-32bit_defconfig
m68k                            mac_defconfig
ia64                         bigsur_defconfig
powerpc                        cell_defconfig
riscv                            allyesconfig
xtensa                  nommu_kc705_defconfig
xtensa                    xip_kc705_defconfig
arc                          axs101_defconfig
arc                        vdk_hs38_defconfig
arc                    vdk_hs38_smp_defconfig
powerpc64                           defconfig
mips                            ar7_defconfig
arc                           tb10x_defconfig
powerpc                 mpc834x_itx_defconfig
powerpc                       eiger_defconfig
h8300                               defconfig
microblaze                      mmu_defconfig
sh                 kfr2r09-romimage_defconfig
openrisc                            defconfig
m68k                       m5475evb_defconfig
arm                        spear6xx_defconfig
arm                            lart_defconfig
sh                            titan_defconfig
h8300                            alldefconfig
powerpc                       ppc64_defconfig
arm                        keystone_defconfig
powerpc                      pasemi_defconfig
x86_64                           alldefconfig
nios2                            alldefconfig
xtensa                  audio_kc705_defconfig
sh                  sh7785lcr_32bit_defconfig
m68k                          sun3x_defconfig
sh                           se7619_defconfig
mips                  maltasmvp_eva_defconfig
mips                         mpc30x_defconfig
sh                        sh7785lcr_defconfig
arm                         nhk8815_defconfig
arm                             pxa_defconfig
powerpc                    klondike_defconfig
sh                               j2_defconfig
mips                           gcw0_defconfig
openrisc                  or1klitex_defconfig
mips                    maltaup_xpa_defconfig
arm                           viper_defconfig
sh                            shmin_defconfig
powerpc                 mpc8540_ads_defconfig
sh                     sh7710voipgw_defconfig
powerpc64                        alldefconfig
m68k                            q40_defconfig
arm                           h5000_defconfig
s390                       zfcpdump_defconfig
mips                           jazz_defconfig
sh                            migor_defconfig
arm                          pxa3xx_defconfig
ia64                          tiger_defconfig
m68k                           sun3_defconfig
sh                   sh7724_generic_defconfig
sh                           se7712_defconfig
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
riscv                    nommu_k210_defconfig
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
mips                          malta_defconfig
arm                     davinci_all_defconfig
mips                        workpad_defconfig
mips                     loongson2k_defconfig
powerpc                 mpc8315_rdb_defconfig
x86_64                           allyesconfig
powerpc                 mpc832x_mds_defconfig
arm                        spear3xx_defconfig
mips                      malta_kvm_defconfig
mips                           mtx1_defconfig
arm                     am200epdkit_defconfig
arm                      tct_hammer_defconfig
riscv                            alldefconfig
powerpc                        fsp2_defconfig
arm                        vexpress_defconfig
arm                        multi_v5_defconfig
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
