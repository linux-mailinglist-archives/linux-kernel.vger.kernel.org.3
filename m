Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 970BE50CBBF
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Apr 2022 17:24:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233516AbiDWP1L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Apr 2022 11:27:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233060AbiDWP1D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Apr 2022 11:27:03 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61F4B3585F
        for <linux-kernel@vger.kernel.org>; Sat, 23 Apr 2022 08:24:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650727446; x=1682263446;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=0gYHNO3sTMxAYY550beu+1t55C+cV8skiqgqyqTMLIc=;
  b=cFBUQqysDMM7ULUMgvtsglhzhO7O7UHAxE7IznTgVqOZbQOCns/lqABv
   cv3t59psHQSaOA6v5ql42QrCLjudaK/0jnhUe6kxqQmUyIKmaOuji/ee4
   XjvncLUz0hse0C28NuVxMScwHW+FBpx2sO2hUF9MpVdBstlf7vJfi0yH+
   0K1XIBoSxY2Xwq4VXjUqas78UTq9ph2xLTINmVFN6Zex5+KWHl6pTPSsf
   aEjV5g95BXubYHb64IVaKUlp/kwzwdgOkqwUyTGpvFfMiDwlttVe5+oyS
   r8MsDFmoWYki/MrvuQvSW74IlcEKLqgRDKhzNYbyIrSJFGpZs/IVZM4C9
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10326"; a="327825845"
X-IronPort-AV: E=Sophos;i="5.90,284,1643702400"; 
   d="scan'208";a="327825845"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2022 08:24:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,284,1643702400"; 
   d="scan'208";a="649046495"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 23 Apr 2022 08:24:02 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1niHcA-00009f-33;
        Sat, 23 Apr 2022 15:24:02 +0000
Date:   Sat, 23 Apr 2022 23:23:16 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/merge] BUILD SUCCESS
 05e2e71e31e6ea086f6ef1ce48d7dc49d8c3fbae
Message-ID: <626419e4.wWNaiCiZMI/jA6hc%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/merge
branch HEAD: 05e2e71e31e6ea086f6ef1ce48d7dc49d8c3fbae  Merge branch 'x86/sev' into x86/merge, to fix conflicts

elapsed time: 1799m

configs tested: 129
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
sh                ecovec24-romimage_defconfig
xtensa                    smp_lx200_defconfig
arm                          simpad_defconfig
m68k                        m5407c3_defconfig
um                                  defconfig
powerpc                   currituck_defconfig
powerpc                      pcm030_defconfig
powerpc                       ppc64_defconfig
powerpc                        cell_defconfig
powerpc                    sam440ep_defconfig
openrisc                 simple_smp_defconfig
sh                               alldefconfig
sparc                               defconfig
powerpc                      ppc40x_defconfig
sh                        edosk7760_defconfig
arc                          axs103_defconfig
ia64                        generic_defconfig
mips                        bcm47xx_defconfig
um                               alldefconfig
arm                           viper_defconfig
m68k                          atari_defconfig
sh                          rsk7203_defconfig
mips                     decstation_defconfig
ia64                         bigsur_defconfig
powerpc                      pasemi_defconfig
mips                     loongson1b_defconfig
arc                         haps_hs_defconfig
sh                              ul2_defconfig
ia64                             allyesconfig
sh                        apsh4ad0a_defconfig
sh                           se7705_defconfig
arm                          iop32x_defconfig
arm                         assabet_defconfig
sparc64                             defconfig
m68k                       m5475evb_defconfig
powerpc                 canyonlands_defconfig
powerpc                       holly_defconfig
x86_64                        randconfig-c001
arm                  randconfig-c002-20220422
ia64                             allmodconfig
ia64                                defconfig
m68k                                defconfig
m68k                             allyesconfig
m68k                             allmodconfig
nios2                               defconfig
arc                              allyesconfig
csky                                defconfig
nios2                            allyesconfig
alpha                               defconfig
alpha                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
h8300                            allyesconfig
xtensa                           allyesconfig
s390                                defconfig
s390                             allmodconfig
parisc                              defconfig
parisc64                            defconfig
parisc                           allyesconfig
s390                             allyesconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
i386                                defconfig
i386                             allyesconfig
sparc                            allyesconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                           allnoconfig
powerpc                          allmodconfig
x86_64                        randconfig-a006
x86_64                        randconfig-a004
x86_64                        randconfig-a002
i386                          randconfig-a001
i386                          randconfig-a003
i386                          randconfig-a005
x86_64                        randconfig-a011
x86_64                        randconfig-a013
x86_64                        randconfig-a015
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
arc                  randconfig-r043-20220422
riscv                               defconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
riscv                             allnoconfig
riscv                            allmodconfig
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
powerpc                      acadia_defconfig
mips                           ip27_defconfig
arm                         lpc32xx_defconfig
riscv                    nommu_virt_defconfig
powerpc                  mpc885_ads_defconfig
powerpc                 mpc832x_rdb_defconfig
powerpc                      ppc64e_defconfig
arm                         socfpga_defconfig
mips                       rbtx49xx_defconfig
mips                      maltaaprp_defconfig
powerpc                      walnut_defconfig
mips                         tb0219_defconfig
i386                          randconfig-a002
i386                          randconfig-a004
i386                          randconfig-a006
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
x86_64                        randconfig-a001
x86_64                        randconfig-a003
x86_64                        randconfig-a005
hexagon              randconfig-r041-20220422
riscv                randconfig-r042-20220422
hexagon              randconfig-r045-20220422
s390                 randconfig-r044-20220422

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
