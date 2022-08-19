Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 829025992FC
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 04:13:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244766AbiHSCNc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 22:13:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236204AbiHSCN2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 22:13:28 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A705101DA
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 19:13:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660875206; x=1692411206;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=NKpAbQ+AVGVt9ysQpVgJa3YSrlGCTZmDKo+gQ+6ASeo=;
  b=W9OCclJyXDWlxglqJpIKdi/Rf2ddc/nKWpTEk0bqyP3z7S9xBLPQWA9/
   5Wex7ICSJkezLl7TAh1SY60Yf8rjY6/qFv/9NnMNJuxZrQSxQCz4gyAv0
   9Iww2ercirJkU14DEzgngZnRrGr2TzRppc9dZxjCBOBg24zz4dQD2fbaf
   YBZsLIBMiWRUVKJ2VwA2WCvXMZMxY4l/IUTeTKWg53CYBOW058ai751NZ
   wTIIGMcmFEiRdQzkVFJl6lBbdv4hQkZBJ2tw6rxEPCocq/CQWgKMVZ7BK
   UOnnj9qLVggWymhUQhmugWvXnZtVDiAWUr4lHSR+7RnzugfKn0TaFhLnc
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10443"; a="272686765"
X-IronPort-AV: E=Sophos;i="5.93,247,1654585200"; 
   d="scan'208";a="272686765"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2022 19:13:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,247,1654585200"; 
   d="scan'208";a="558774268"
Received: from lkp-server01.sh.intel.com (HELO 44b6dac04a33) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 18 Aug 2022 19:13:23 -0700
Received: from kbuild by 44b6dac04a33 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oOrVi-0000vT-2b;
        Fri, 19 Aug 2022 02:13:22 +0000
Date:   Fri, 19 Aug 2022 10:12:39 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/urgent] BUILD SUCCESS
 7df548840c496b0141fb2404b889c346380c2b22
Message-ID: <62fef197.ekY1ViFuUELlpcHc%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/urgent
branch HEAD: 7df548840c496b0141fb2404b889c346380c2b22  x86/bugs: Add "unknown" reporting for MMIO Stale Data

elapsed time: 721m

configs tested: 125
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
powerpc                          allmodconfig
mips                             allyesconfig
powerpc                           allnoconfig
arc                  randconfig-r043-20220818
riscv                randconfig-r042-20220818
sh                               allmodconfig
s390                 randconfig-r044-20220818
um                             i386_defconfig
um                           x86_64_defconfig
i386                                defconfig
x86_64                              defconfig
x86_64                        randconfig-a013
x86_64                        randconfig-a011
m68k                             allmodconfig
arc                              allyesconfig
ia64                             allmodconfig
arm                                 defconfig
x86_64                        randconfig-a015
alpha                            allyesconfig
m68k                             allyesconfig
x86_64                           allyesconfig
x86_64                        randconfig-a006
x86_64                               rhel-8.3
i386                             allyesconfig
i386                          randconfig-a001
i386                          randconfig-a003
arm64                            allyesconfig
arm                              allyesconfig
i386                          randconfig-a014
x86_64                           rhel-8.3-kvm
x86_64                          rhel-8.3-func
x86_64                           rhel-8.3-syz
x86_64                    rhel-8.3-kselftests
x86_64                         rhel-8.3-kunit
csky                              allnoconfig
alpha                             allnoconfig
arc                               allnoconfig
riscv                             allnoconfig
i386                          randconfig-a012
i386                          randconfig-a016
i386                          randconfig-a005
mips                      loongson3_defconfig
sh                          polaris_defconfig
arc                          axs103_defconfig
powerpc                       maple_defconfig
sh                        edosk7705_defconfig
x86_64                        randconfig-a004
powerpc                         wii_defconfig
sh                               j2_defconfig
mips                  decstation_64_defconfig
powerpc                      cm5200_defconfig
mips                            gpr_defconfig
x86_64                        randconfig-a002
sh                   rts7751r2dplus_defconfig
sh                                  defconfig
sh                               alldefconfig
arm                           sunxi_defconfig
arc                 nsimosci_hs_smp_defconfig
loongarch                        alldefconfig
m68k                                defconfig
loongarch                           defconfig
loongarch                         allnoconfig
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
i386                          randconfig-c001
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
arm                        clps711x_defconfig
arm                      footbridge_defconfig
arm                            qcom_defconfig
nios2                            allyesconfig
nios2                               defconfig
parisc                              defconfig
parisc64                            defconfig
parisc                           allyesconfig
arm                        realview_defconfig
arm                        keystone_defconfig
arm                             ezx_defconfig

clang tested configs:
hexagon              randconfig-r041-20220818
hexagon              randconfig-r045-20220818
x86_64                        randconfig-a016
x86_64                        randconfig-a012
x86_64                        randconfig-a014
i386                          randconfig-a013
i386                          randconfig-a015
i386                          randconfig-a002
i386                          randconfig-a004
i386                          randconfig-a011
i386                          randconfig-a006
x86_64                        randconfig-a005
x86_64                        randconfig-a003
x86_64                        randconfig-a001
mips                          ath25_defconfig
powerpc                          allmodconfig
mips                        omega2p_defconfig
arm                             mxs_defconfig
x86_64                        randconfig-k001
arm                  colibri_pxa270_defconfig
hexagon                             defconfig
arm                         bcm2835_defconfig
arm                         s5pv210_defconfig
arm                         shannon_defconfig
riscv                randconfig-r042-20220819
s390                 randconfig-r044-20220819
hexagon              randconfig-r045-20220819
hexagon              randconfig-r041-20220819
arm64                            allyesconfig

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
