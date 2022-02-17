Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 752EC4BA16D
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 14:40:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241010AbiBQNiW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 08:38:22 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:52030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241000AbiBQNiV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 08:38:21 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75E2115E6EB
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 05:38:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645105086; x=1676641086;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=sG7JVp6thBdfzLc9RXJr4KwIPgLVdLfwW5g5pnYJyqM=;
  b=IqBmR/uJIM5T6iU3U/7qlCeT9xxKA9xLQBZHHykoDZl3plUCyb6I8Nt6
   rOccb2CTMH6Wo0oFOIFb8BC5ylatcqHI8yi70tlMicJAn5VTLe2Mj5/wb
   tNDOV/QiBJaE2nKhsysmix9Sg1+gRqBeYgVuVvKA6E1sQNiVJ9hthdh6c
   hQ3Q8YCfWikHqRwrK9oL3cTQMhCmPZUwD3jE1js5gML1zuh/fOrNJKWnm
   tEVg8URtHUYPZ1aAij3yF3UnpQ7o2wxPOJpeZLUITRQvYidJ0Q0hKkIVf
   CYjOOBYyC6GrJFNUydKibEpMq4aQQcIinJJOkYNL9LZfLbD9sqkhxHxzA
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10260"; a="248469859"
X-IronPort-AV: E=Sophos;i="5.88,375,1635231600"; 
   d="scan'208";a="248469859"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2022 05:37:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,375,1635231600"; 
   d="scan'208";a="604952283"
Received: from lkp-server01.sh.intel.com (HELO 6f05bf9e3301) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 17 Feb 2022 05:37:50 -0800
Received: from kbuild by 6f05bf9e3301 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nKgyj-0000ES-Rk; Thu, 17 Feb 2022 13:37:49 +0000
Date:   Thu, 17 Feb 2022 21:37:24 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:dev.2022.02.14a] BUILD SUCCESS
 1a4f308b3b3841ef10043fe6c3dd12fc872b0400
Message-ID: <620e4f94.1PfvCJJs6s7k1/nv%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev.2022.02.14a
branch HEAD: 1a4f308b3b3841ef10043fe6c3dd12fc872b0400  squash! rcu/nocb: Move rcu_nocb_is_setup to rcu_state

elapsed time: 803m

configs tested: 154
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
m68k                          hp300_defconfig
powerpc                      cm5200_defconfig
powerpc                      makalu_defconfig
powerpc                    amigaone_defconfig
sh                               alldefconfig
sh                          r7780mp_defconfig
powerpc                 mpc834x_mds_defconfig
powerpc                  iss476-smp_defconfig
arc                 nsimosci_hs_smp_defconfig
mips                  maltasmvp_eva_defconfig
ia64                      gensparse_defconfig
sh                            migor_defconfig
xtensa                  audio_kc705_defconfig
arm                           h5000_defconfig
xtensa                       common_defconfig
powerpc                     stx_gp3_defconfig
ia64                             alldefconfig
nios2                            alldefconfig
sh                  sh7785lcr_32bit_defconfig
m68k                          sun3x_defconfig
sh                           se7619_defconfig
mips                         mpc30x_defconfig
sh                        sh7785lcr_defconfig
arm                         nhk8815_defconfig
mips                    maltaup_xpa_defconfig
arc                           tb10x_defconfig
arm                           viper_defconfig
mips                           gcw0_defconfig
openrisc                  or1klitex_defconfig
arc                          axs101_defconfig
sh                            shmin_defconfig
ia64                         bigsur_defconfig
powerpc64                        alldefconfig
m68k                            q40_defconfig
h8300                            alldefconfig
s390                       zfcpdump_defconfig
mips                           jazz_defconfig
sparc                       sparc32_defconfig
powerpc                 canyonlands_defconfig
m68k                        stmark2_defconfig
sh                 kfr2r09-romimage_defconfig
sh                   sh7724_generic_defconfig
sh                           se7712_defconfig
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
arc                                 defconfig
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
i386                          randconfig-a014
i386                          randconfig-a012
i386                          randconfig-a016
s390                 randconfig-r044-20220216
riscv                randconfig-r042-20220216
arc                  randconfig-r043-20220216
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
mips                           ip27_defconfig
mips                     loongson1c_defconfig
arm                          ixp4xx_defconfig
arm                        neponset_defconfig
mips                          malta_defconfig
arm                     davinci_all_defconfig
mips                        workpad_defconfig
mips                     loongson2k_defconfig
powerpc                 mpc8315_rdb_defconfig
powerpc                      ppc44x_defconfig
x86_64                           allyesconfig
powerpc                     ppa8548_defconfig
mips                           ip22_defconfig
arm                          imote2_defconfig
arm                       aspeed_g4_defconfig
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
i386                          randconfig-a011
i386                          randconfig-a013
i386                          randconfig-a015
x86_64                        randconfig-a005
x86_64                        randconfig-a003
x86_64                        randconfig-a001
hexagon              randconfig-r045-20220217
hexagon              randconfig-r041-20220217
riscv                randconfig-r042-20220217
hexagon              randconfig-r045-20220216
hexagon              randconfig-r041-20220216

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
