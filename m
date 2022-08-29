Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4BBD5A555A
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 22:11:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230045AbiH2ULt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 16:11:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229557AbiH2ULr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 16:11:47 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED4E36AA1E
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 13:11:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661803905; x=1693339905;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=Q6lH9G8Ws42A09Nwn7tP2fkS4FnRmPYNxdIIM7fo8ME=;
  b=Hh6uDVA0IIbTCuZsfDztwFFbvSkAwyqTCHE0QEKv5TRjmuGbXrpnRqYD
   b8knaiwcPXzg8eyKMNVkMhCrF7Gry0Qr/BtcITdYNwyE0+PefOZ+1MH/s
   jg/V/Acvm/pgZH95HncwN588hjlbWBAOFNPxDJ9w37IwvBpebIavBU2yc
   NEnhG54Zh8/wElwh87wFvrzeJ5MC711SGvpjP3hjjLi+Ikx+Fec3p8HOY
   JgYRIu/NBiHCt76gu+dWw1qM7NyFI+yg175RffsTxD77tQ9A5PNVrbvez
   XXSWFgLCAB5DU4Ua+1ZMzlkns3p9hNvCv+eun0TGU7knJo2M25tvgtZj3
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10454"; a="281961281"
X-IronPort-AV: E=Sophos;i="5.93,273,1654585200"; 
   d="scan'208";a="281961281"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2022 13:11:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,273,1654585200"; 
   d="scan'208";a="644554516"
Received: from lkp-server02.sh.intel.com (HELO e45bc14ccf4d) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 29 Aug 2022 13:11:44 -0700
Received: from kbuild by e45bc14ccf4d with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oSl6l-0000CV-2i;
        Mon, 29 Aug 2022 20:11:43 +0000
Date:   Tue, 30 Aug 2022 04:11:23 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:perf/core] BUILD SUCCESS
 f4054e522531038354bea5c924f286fdd8ae77b5
Message-ID: <630d1d6b.QuP4Cl2gkvKMom2n%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf/core
branch HEAD: f4054e522531038354bea5c924f286fdd8ae77b5  perf: Add PERF_BR_NEW_ARCH_[N] map for BRBE on arm64 platform

elapsed time: 727m

configs tested: 97
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                             i386_defconfig
um                           x86_64_defconfig
loongarch                         allnoconfig
x86_64                    rhel-8.3-kselftests
x86_64                          rhel-8.3-func
x86_64                         rhel-8.3-kunit
x86_64                           rhel-8.3-kvm
x86_64                           rhel-8.3-syz
sh                               allmodconfig
i386                                defconfig
x86_64               randconfig-a004-20220829
x86_64               randconfig-a005-20220829
powerpc                           allnoconfig
mips                             allyesconfig
powerpc                          allmodconfig
m68k                             allyesconfig
m68k                             allmodconfig
arc                              allyesconfig
alpha                            allyesconfig
x86_64               randconfig-a006-20220829
arc                  randconfig-r043-20220829
i386                 randconfig-a004-20220829
arm                                 defconfig
i386                 randconfig-a005-20220829
i386                             allyesconfig
i386                 randconfig-a006-20220829
i386                 randconfig-a001-20220829
i386                 randconfig-a003-20220829
i386                 randconfig-a002-20220829
arm64                            allyesconfig
arm                              allyesconfig
x86_64                              defconfig
x86_64                               rhel-8.3
ia64                             allmodconfig
x86_64               randconfig-a002-20220829
x86_64               randconfig-a003-20220829
x86_64               randconfig-a001-20220829
x86_64                           allyesconfig
microblaze                      mmu_defconfig
arm                         lpc18xx_defconfig
powerpc                  storcenter_defconfig
csky                              allnoconfig
alpha                             allnoconfig
arc                               allnoconfig
riscv                             allnoconfig
riscv                               defconfig
powerpc                       eiger_defconfig
arc                 nsimosci_hs_smp_defconfig
ia64                                defconfig
i386                        debian-10.3-kunit
i386                         debian-10.3-func
i386                          debian-10.3-kvm
i386                 randconfig-c001-20220829
loongarch                           defconfig
sh                           se7722_defconfig
xtensa                  nommu_kc705_defconfig
arm                             ezx_defconfig
arm                            mps2_defconfig
xtensa                           allyesconfig
xtensa                           alldefconfig
sh                            migor_defconfig
sh                      rts7751r2d1_defconfig
m68k                        m5407c3_defconfig
sh                          r7780mp_defconfig
m68k                          multi_defconfig
sh                                  defconfig
sh                          r7785rp_defconfig
sh                             shx3_defconfig
mips                       bmips_be_defconfig
arm                           h5000_defconfig
arm                        keystone_defconfig
arm64                            alldefconfig
arc                          axs103_defconfig
sh                          lboxre2_defconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3

clang tested configs:
x86_64               randconfig-a011-20220829
hexagon              randconfig-r041-20220829
riscv                randconfig-r042-20220829
s390                 randconfig-r044-20220829
hexagon              randconfig-r045-20220829
x86_64               randconfig-a014-20220829
x86_64               randconfig-a016-20220829
x86_64               randconfig-a015-20220829
x86_64               randconfig-a012-20220829
x86_64               randconfig-a013-20220829
i386                 randconfig-a011-20220829
i386                 randconfig-a014-20220829
i386                 randconfig-a013-20220829
i386                 randconfig-a012-20220829
i386                 randconfig-a015-20220829
i386                 randconfig-a016-20220829
arm                        mvebu_v5_defconfig
x86_64               randconfig-k001-20220829

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
