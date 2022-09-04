Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D509F5AC248
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Sep 2022 06:17:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230163AbiIDERi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Sep 2022 00:17:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232159AbiIDERd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Sep 2022 00:17:33 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CADE94B4AF
        for <linux-kernel@vger.kernel.org>; Sat,  3 Sep 2022 21:17:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662265052; x=1693801052;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=a85wHFq24sgpdmFzHzJbK2vyXsHJm0xE+DbbfAA2qoA=;
  b=Nkw2griYSAPtlvVIgsJH1VUVLxEGE6z4zIdula/0Cp0ZxBScoHtdVTH8
   BvSqP+jOBtUdSw038j8G1UNAnCuDMDhMPk4vPX8hkkpcCPRAWt5uWvh1I
   oW0UrnhFo2G/iOeaNW6ObaSvyoLDsl72CV/hQVl393OcfszN5NGrZ8QF0
   ddWcNLN6Uq6Cb9sU7KqlFU0vmERpvFGaFnW71Pw0X7O7ZfmfWR5lujHwB
   5ITK/JfWer4QtfGK6KOHB4fjcXiDflGtE5Wye8TmIby1qLH+0jgNxYMhY
   vDgOJjHusv37K+myfXn/Pxabf1pPu7c5zBQktW6jh8c+sYmAnKmm7J+am
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10459"; a="360164244"
X-IronPort-AV: E=Sophos;i="5.93,288,1654585200"; 
   d="scan'208";a="360164244"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2022 21:17:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,288,1654585200"; 
   d="scan'208";a="564382709"
Received: from lkp-server02.sh.intel.com (HELO 95dfd251caa2) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 03 Sep 2022 21:17:31 -0700
Received: from kbuild by 95dfd251caa2 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oUh4c-0002YE-2B;
        Sun, 04 Sep 2022 04:17:30 +0000
Date:   Sun, 04 Sep 2022 12:16:43 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:lazy.2022.09.03b] BUILD SUCCESS
 485ca0ab99b3e10ff521fff226c3c8fe48fad488
Message-ID: <631426ab.KN0Np3giE+pyBkEK%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git lazy.2022.09.03b
branch HEAD: 485ca0ab99b3e10ff521fff226c3c8fe48fad488  rcutorture: Add test code for call_rcu_lazy()

elapsed time: 720m

configs tested: 80
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                             i386_defconfig
um                           x86_64_defconfig
i386                                defconfig
arm                                 defconfig
i386                             allyesconfig
arc                  randconfig-r043-20220904
x86_64                    rhel-8.3-kselftests
x86_64                          rhel-8.3-func
i386                          randconfig-a005
x86_64                              defconfig
i386                          randconfig-a014
x86_64                        randconfig-a013
arm                              allyesconfig
x86_64                        randconfig-a004
x86_64                         rhel-8.3-kunit
riscv                randconfig-r042-20220904
arm64                            allyesconfig
s390                 randconfig-r044-20220904
i386                          randconfig-a016
x86_64                           rhel-8.3-kvm
arc                              allyesconfig
x86_64                               rhel-8.3
x86_64                        randconfig-a002
powerpc                          allmodconfig
i386                          randconfig-a001
sh                               allmodconfig
alpha                            allyesconfig
x86_64                        randconfig-a011
x86_64                           rhel-8.3-syz
x86_64                           allyesconfig
mips                             allyesconfig
i386                          randconfig-a003
x86_64                        randconfig-a006
powerpc                           allnoconfig
i386                          randconfig-a012
x86_64                        randconfig-a015
ia64                             allmodconfig
m68k                             allyesconfig
microblaze                          defconfig
powerpc                         wii_defconfig
arc                               allnoconfig
m68k                             allmodconfig
sh                          r7785rp_defconfig
sh                           se7206_defconfig
alpha                             allnoconfig
arc                      axs103_smp_defconfig
riscv                             allnoconfig
csky                              allnoconfig
microblaze                      mmu_defconfig
arm                         lpc18xx_defconfig
sparc                               defconfig
sh                           se7722_defconfig
arm                           u8500_defconfig
sh                           se7712_defconfig
m68k                       m5475evb_defconfig
mips                      fuloong2e_defconfig
sparc64                          alldefconfig
mips                  maltasmvp_eva_defconfig
sh                   rts7751r2dplus_defconfig
sh                           se7721_defconfig
i386                          randconfig-c001

clang tested configs:
i386                          randconfig-a013
x86_64                        randconfig-a016
hexagon              randconfig-r045-20220904
i386                          randconfig-a006
hexagon              randconfig-r041-20220904
i386                          randconfig-a011
i386                          randconfig-a015
x86_64                        randconfig-a005
x86_64                        randconfig-a001
x86_64                        randconfig-a012
i386                          randconfig-a002
x86_64                        randconfig-a003
x86_64                        randconfig-a014
i386                          randconfig-a004
arm                        multi_v5_defconfig
powerpc                 mpc8272_ads_defconfig
arm                   milbeaut_m10v_defconfig
arm                            mmp2_defconfig
x86_64                        randconfig-k001

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
