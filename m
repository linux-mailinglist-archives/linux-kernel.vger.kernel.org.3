Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 882974F6124
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 16:15:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234739AbiDFOPr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 10:15:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234648AbiDFOP2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 10:15:28 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B72AF58049C
        for <linux-kernel@vger.kernel.org>; Wed,  6 Apr 2022 03:16:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649240186; x=1680776186;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=6GizAQMbkbxuJ2LyNHkWHRdcu08MFq/YD+5rvP7Rido=;
  b=SNEN91G57yN/BBDsnCkbdaBGM67952Baa89L/Kj6tPIRA18UUgwhP3/D
   BRuc7RyWF/KkZXBydFv9p6mUaqBuFrWno6RAFAl4+7gimTuU6zNpEBwiB
   rGcOOcVgsLV/wIbPIVF64zOj5mYTif8VQW4vMonZdC62LTzchf9LC8yGR
   8rEqX0I0D7MpOkgfbsm/LoJxNNnmuG6RYltWk8aaz5RX2+s+n/8kIvmAv
   YS/RF+O2GoUb0HrhM+tUhv88FJBXiqe5yEtNmLtnIYZKRnZeiQLhFII96
   cS+f0Mkmqk/Wm3+j/NiP2We6DJKslYIMFaoFkrLrJthJNxVWr3VttD+FX
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10308"; a="241590668"
X-IronPort-AV: E=Sophos;i="5.90,239,1643702400"; 
   d="scan'208";a="241590668"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2022 03:07:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,239,1643702400"; 
   d="scan'208";a="658468322"
Received: from lkp-server02.sh.intel.com (HELO a44fdfb70b94) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 06 Apr 2022 03:07:57 -0700
Received: from kbuild by a44fdfb70b94 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nc2Zx-0004If-7D;
        Wed, 06 Apr 2022 10:07:57 +0000
Date:   Wed, 06 Apr 2022 18:07:15 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/build] BUILD SUCCESS
 9f61ccc85afb061f65dd8ede7b8d4845b2f2dfce
Message-ID: <624d6653.DHSKpkWzjey8gX8d%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/build
branch HEAD: 9f61ccc85afb061f65dd8ede7b8d4845b2f2dfce  x86/configs: Add x86 debugging Kconfig fragment plus docs

elapsed time: 733m

configs tested: 120
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm64                               defconfig
arm64                            allyesconfig
arm                              allmodconfig
arm                                 defconfig
arm                              allyesconfig
i386                          randconfig-c001
m68k                        m5407c3_defconfig
powerpc                     pq2fads_defconfig
sparc64                          alldefconfig
m68k                            q40_defconfig
arm                           tegra_defconfig
arc                            hsdk_defconfig
arm                        shmobile_defconfig
m68k                        mvme16x_defconfig
riscv                            allmodconfig
mips                  maltasmvp_eva_defconfig
mips                      loongson3_defconfig
mips                           gcw0_defconfig
m68k                       bvme6000_defconfig
i386                             alldefconfig
arm                        spear6xx_defconfig
sh                     sh7710voipgw_defconfig
sh                        sh7757lcr_defconfig
arm                          badge4_defconfig
sh                            shmin_defconfig
sh                            migor_defconfig
sh                      rts7751r2d1_defconfig
openrisc                  or1klitex_defconfig
mips                         mpc30x_defconfig
xtensa                  nommu_kc705_defconfig
sparc                       sparc64_defconfig
arm                          iop32x_defconfig
riscv             nommu_k210_sdcard_defconfig
arm                        mvebu_v7_defconfig
sh                 kfr2r09-romimage_defconfig
mips                           xway_defconfig
xtensa                    xip_kc705_defconfig
mips                          rb532_defconfig
m68k                        m5307c3_defconfig
x86_64                        randconfig-c001
arm                  randconfig-c002-20220405
ia64                             allmodconfig
ia64                             allyesconfig
ia64                                defconfig
m68k                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
nios2                               defconfig
arc                              allyesconfig
csky                                defconfig
nios2                            allyesconfig
alpha                               defconfig
alpha                            allyesconfig
xtensa                           allyesconfig
arc                                 defconfig
sh                               allmodconfig
h8300                            allyesconfig
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
x86_64                        randconfig-a006
x86_64                        randconfig-a004
x86_64                        randconfig-a002
x86_64                        randconfig-a011
x86_64                        randconfig-a013
x86_64                        randconfig-a015
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
arc                  randconfig-r043-20220406
s390                 randconfig-r044-20220406
riscv                randconfig-r042-20220406
riscv                               defconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
riscv                             allnoconfig
riscv                            allyesconfig
x86_64                    rhel-8.3-kselftests
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                          rhel-8.3-func
x86_64                                  kexec
x86_64                              defconfig
x86_64                           allyesconfig
x86_64                         rhel-8.3-kunit
x86_64                               rhel-8.3

clang tested configs:
x86_64                        randconfig-c007
i386                          randconfig-c001
powerpc              randconfig-c003-20220405
riscv                randconfig-c006-20220405
mips                 randconfig-c004-20220405
arm                  randconfig-c002-20220405
powerpc                        fsp2_defconfig
arm                       spear13xx_defconfig
arm                         palmz72_defconfig
x86_64                        randconfig-a005
x86_64                        randconfig-a003
x86_64                        randconfig-a001
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
hexagon              randconfig-r045-20220405
riscv                randconfig-r042-20220405
hexagon              randconfig-r041-20220405

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
