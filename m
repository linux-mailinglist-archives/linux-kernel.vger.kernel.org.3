Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F3344E4F66
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 10:29:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239549AbiCWJbW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 05:31:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239623AbiCWJbR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 05:31:17 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2A5C652D5
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 02:29:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648027788; x=1679563788;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=TSiLA/Kh1zWmmj838xkWAxM1VraT6wr6sFSp1gPGX54=;
  b=Lg/xQPgzTrHxe6Xlih5DPOkiPxtcnp3CRPLwOYXa2bgrdFoNFW6IKSpc
   sxmq8kAY42TpjDP+SNIcilSgDhh6r6nUS2+AlRLS5h+vKEjfuFA7afMUg
   ZHZ43sb0MH1h5DDF2p1xjJP3MKgDbFUwKvBds6ZyDR0Y55q4nj8iTPg6T
   7V3KqjWevHqo48jRZ6Tx+rm8mLMWdP33Bo+0DRyMzVq1XzNGD+0IzF6w7
   Zl4bPfS63m6VIQx/TkbMf//OhpYuwsaBlc3HYJbK271gDX8iu3QTV1Vxu
   hTL4uRAsGFa1PH7yYq1dPF3qtwlI7jrFzlDopWqSaZRFGi/pSL/dmzkOY
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10294"; a="258256353"
X-IronPort-AV: E=Sophos;i="5.90,203,1643702400"; 
   d="scan'208";a="258256353"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2022 02:29:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,203,1643702400"; 
   d="scan'208";a="717328650"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 23 Mar 2022 02:29:24 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nWxIy-000JtV-1V; Wed, 23 Mar 2022 09:29:24 +0000
Date:   Wed, 23 Mar 2022 17:28:21 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/core] BUILD SUCCESS
 3986f65d4f408ce9d0a361e3226a3246a5fb701c
Message-ID: <623ae835.Zxs5XOJn8GsDsIXP%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/core
branch HEAD: 3986f65d4f408ce9d0a361e3226a3246a5fb701c  kvm/emulate: Fix SETcc emulation for ENDBR

elapsed time: 723m

configs tested: 144
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm                              allmodconfig
arm                              allyesconfig
arm64                            allyesconfig
arm64                               defconfig
i386                          randconfig-c001
mips                 randconfig-c004-20220323
arm                        shmobile_defconfig
ia64                          tiger_defconfig
ia64                         bigsur_defconfig
sh                 kfr2r09-romimage_defconfig
arm                        keystone_defconfig
mips                      loongson3_defconfig
powerpc                      makalu_defconfig
powerpc                      pasemi_defconfig
arm                           h3600_defconfig
sh                   sh7770_generic_defconfig
sh                            hp6xx_defconfig
arm                       omap2plus_defconfig
alpha                               defconfig
powerpc                     tqm8548_defconfig
ia64                             alldefconfig
m68k                          sun3x_defconfig
powerpc                     taishan_defconfig
sh                      rts7751r2d1_defconfig
sh                             sh03_defconfig
m68k                        mvme16x_defconfig
arm                            xcep_defconfig
s390                             allmodconfig
mips                         tb0226_defconfig
powerpc                 canyonlands_defconfig
mips                      maltasmvp_defconfig
sh                          rsk7264_defconfig
arc                          axs101_defconfig
m68k                         apollo_defconfig
powerpc                 linkstation_defconfig
arm                        realview_defconfig
powerpc                  iss476-smp_defconfig
openrisc                  or1klitex_defconfig
mips                     loongson1b_defconfig
arm                            hisi_defconfig
arm                          iop32x_defconfig
sh                         apsh4a3a_defconfig
xtensa                    smp_lx200_defconfig
mips                       bmips_be_defconfig
arm                      jornada720_defconfig
m68k                        mvme147_defconfig
arm                            mps2_defconfig
powerpc                     pq2fads_defconfig
arm                         assabet_defconfig
um                               alldefconfig
alpha                            alldefconfig
mips                      fuloong2e_defconfig
powerpc                        warp_defconfig
sh                         ecovec24_defconfig
arm                             rpc_defconfig
riscv                               defconfig
sh                  sh7785lcr_32bit_defconfig
arm                  randconfig-c002-20220323
arm                  randconfig-c002-20220321
arm                  randconfig-c002-20220322
arm                  randconfig-c002-20220320
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
alpha                            allyesconfig
xtensa                           allyesconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
parisc                              defconfig
s390                             allyesconfig
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
x86_64               randconfig-a016-20220321
x86_64               randconfig-a011-20220321
x86_64               randconfig-a012-20220321
x86_64               randconfig-a013-20220321
x86_64               randconfig-a014-20220321
x86_64               randconfig-a015-20220321
riscv                randconfig-r042-20220323
s390                 randconfig-r044-20220323
arc                  randconfig-r043-20220323
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                            allmodconfig
x86_64                    rhel-8.3-kselftests
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                           allyesconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                         rhel-8.3-kunit
x86_64                                  kexec

clang tested configs:
x86_64                        randconfig-c007
mips                 randconfig-c004-20220323
arm                  randconfig-c002-20220323
powerpc              randconfig-c003-20220323
riscv                randconfig-c006-20220323
i386                          randconfig-c001
mips                           ip27_defconfig
arm                              alldefconfig
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
i386                 randconfig-a001-20220321
i386                 randconfig-a006-20220321
i386                 randconfig-a003-20220321
i386                 randconfig-a005-20220321
i386                 randconfig-a004-20220321
i386                 randconfig-a002-20220321
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
i386                          randconfig-a011
i386                          randconfig-a013
i386                          randconfig-a015
riscv                randconfig-r042-20220322
hexagon              randconfig-r045-20220322
hexagon              randconfig-r041-20220322

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
