Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDADD54A11C
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 23:15:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352017AbiFMVPd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 17:15:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352214AbiFMVPJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 17:15:09 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 192FE433A6
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 13:57:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655153823; x=1686689823;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=ShsybPIkxoehtycS2igKxfxQJq3VGQu2ggfJOgRl4oM=;
  b=KeaBp3abG72z4UlXQDhWkKzYOZfpn5RyNUdEiITrZ9LsBKqGK1TnwhKm
   Dn4MRjmOvxMB2aEHGG5abSiRV5iEduuESJ6OSLzU+fWZF/TBMZiM1VRMR
   Bv70GRKQSJvSP73Pw9pjZgoeaGF60Jj5Lfcfux/VIHOJtvcAElUcy74dP
   uAJknVs14ZYrvsjHFXpnuN4egcJh3EdXVtLBm6PC+UpcHKKDqmTXCrtnl
   f1Cx2YXZ6k3eyiNEK4k/49zmnRqvf4uLBmXYw+oMpcMivL5YQwxFIDgYW
   2T1OcqQYYu985sOxIlJ1z7UYTvSxXfxb9Of9pPCvDbsVZ2c7LOXO5b5zY
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10377"; a="278444227"
X-IronPort-AV: E=Sophos;i="5.91,298,1647327600"; 
   d="scan'208";a="278444227"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2022 13:57:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,298,1647327600"; 
   d="scan'208";a="617669928"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 13 Jun 2022 13:57:01 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o0r7M-000L90-GG;
        Mon, 13 Jun 2022 20:57:00 +0000
Date:   Tue, 14 Jun 2022 04:56:50 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:sched/core] BUILD SUCCESS
 f3dd3f674555bd9455c5ae7fafce0696bd9931b3
Message-ID: <62a7a492.Tv0mYBrrhkqIsgc6%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched/core
branch HEAD: f3dd3f674555bd9455c5ae7fafce0696bd9931b3  sched: Remove the limitation of WF_ON_CPU on wakelist if wakee cpu is idle

elapsed time: 727m

configs tested: 112
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm64                               defconfig
arm64                            allyesconfig
arm                              allmodconfig
arm                                 defconfig
arm                              allyesconfig
i386                 randconfig-c001-20220613
arm                        trizeps4_defconfig
arm                       aspeed_g5_defconfig
arm                            mps2_defconfig
sh                        edosk7705_defconfig
sh                         apsh4a3a_defconfig
arm                           h3600_defconfig
powerpc                     mpc83xx_defconfig
mips                          rb532_defconfig
powerpc                         ps3_defconfig
sh                   rts7751r2dplus_defconfig
sh                          rsk7203_defconfig
sh                      rts7751r2d1_defconfig
powerpc                     tqm8555_defconfig
powerpc                      cm5200_defconfig
xtensa                    smp_lx200_defconfig
ia64                      gensparse_defconfig
mips                     loongson1b_defconfig
openrisc                         alldefconfig
ia64                                defconfig
ia64                             allmodconfig
x86_64               randconfig-k001-20220613
m68k                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
nios2                               defconfig
arc                              allyesconfig
csky                                defconfig
nios2                            allyesconfig
alpha                               defconfig
alpha                            allyesconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
xtensa                           allyesconfig
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
powerpc                          allyesconfig
powerpc                           allnoconfig
powerpc                          allmodconfig
x86_64               randconfig-a012-20220613
x86_64               randconfig-a011-20220613
x86_64               randconfig-a013-20220613
x86_64               randconfig-a014-20220613
x86_64               randconfig-a016-20220613
x86_64               randconfig-a015-20220613
i386                 randconfig-a012-20220613
i386                 randconfig-a011-20220613
i386                 randconfig-a013-20220613
i386                 randconfig-a014-20220613
i386                 randconfig-a016-20220613
i386                 randconfig-a015-20220613
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
arc                  randconfig-r043-20220613
riscv                randconfig-r042-20220613
s390                 randconfig-r044-20220613
riscv                               defconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
riscv                             allnoconfig
riscv                            allmodconfig
riscv                            allyesconfig
x86_64                    rhel-8.3-kselftests
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                                  kexec
x86_64                              defconfig
x86_64                           allyesconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                         rhel-8.3-kunit
x86_64                           rhel-8.3-syz

clang tested configs:
arm                        mvebu_v5_defconfig
arm                         lpc32xx_defconfig
mips                           mtx1_defconfig
x86_64               randconfig-a003-20220613
x86_64               randconfig-a006-20220613
x86_64               randconfig-a001-20220613
x86_64               randconfig-a005-20220613
x86_64               randconfig-a002-20220613
x86_64               randconfig-a004-20220613
i386                 randconfig-a001-20220613
i386                 randconfig-a004-20220613
i386                 randconfig-a002-20220613
i386                 randconfig-a003-20220613
i386                 randconfig-a006-20220613
i386                 randconfig-a005-20220613
i386                          randconfig-a013
i386                          randconfig-a011
i386                          randconfig-a015
hexagon              randconfig-r041-20220613
hexagon              randconfig-r045-20220613

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
