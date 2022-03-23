Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15A3C4E5498
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 15:52:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244888AbiCWOyF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 10:54:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235859AbiCWOyE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 10:54:04 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66873814B7
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 07:52:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648047154; x=1679583154;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=PzKq4AtB8zaWtwWr9QvAa5xfyO3Qb86QsTECPlbYBEI=;
  b=VzuhDfV8VNCnqvewITWWwYystJkyNUphGEsZlZ3tmhHWypsWpJzsmmgS
   luaZd5BmO3WkXOpq/WMzifw47IXIYRpvTBEMjZS9kT/1G+EjFk2OpQCdH
   xujPDscve9cH5FXdV+8uKTyt6LYqYZ/37g26nVKRDYR6YqCxhTovc0CGN
   fghhkfD7m+pVl52Ru1hycUpXmJiAhKX8O+bXn50VPnYrXMlVR7/9313B9
   v5X63PXASkPOkpM0cLxdTjV8K2ZaBJkl95v82mP1kVIv+FYm1JiXDaOHD
   H6bx42wOzahi4+vl8QKuGfmyhdG3xRZRFWKdYuj0oJZSVez5+u/IZI1nf
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10295"; a="258080180"
X-IronPort-AV: E=Sophos;i="5.90,204,1643702400"; 
   d="scan'208";a="258080180"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2022 07:52:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,204,1643702400"; 
   d="scan'208";a="649453647"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 23 Mar 2022 07:52:32 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nX2Lf-000K9N-Sf; Wed, 23 Mar 2022 14:52:31 +0000
Date:   Wed, 23 Mar 2022 22:51:44 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:master] BUILD SUCCESS
 4bc2b7caa59fcaae540e6e7b86065e1d4d58c739
Message-ID: <623b3400.zIlQwC6Pi2EgNTu5%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git master
branch HEAD: 4bc2b7caa59fcaae540e6e7b86065e1d4d58c739  Merge x86/core into tip/master

elapsed time: 729m

configs tested: 106
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm                              allmodconfig
arm                              allyesconfig
arm64                               defconfig
arm64                            allyesconfig
i386                          randconfig-c001
ia64                            zx1_defconfig
m68k                            mac_defconfig
arm                      integrator_defconfig
arm                            mps2_defconfig
arm                           h3600_defconfig
powerpc                      pasemi_defconfig
sh                   sh7770_generic_defconfig
sh                            hp6xx_defconfig
arm                         axm55xx_defconfig
powerpc                 mpc837x_rdb_defconfig
openrisc                         alldefconfig
powerpc                    klondike_defconfig
arm                           u8500_defconfig
arm                     eseries_pxa_defconfig
arm                  randconfig-c002-20220323
ia64                             allmodconfig
ia64                             allyesconfig
ia64                                defconfig
m68k                                defconfig
m68k                             allyesconfig
m68k                             allmodconfig
csky                                defconfig
alpha                               defconfig
nds32                               defconfig
alpha                            allyesconfig
nios2                            allyesconfig
arc                                 defconfig
h8300                            allyesconfig
sh                               allmodconfig
xtensa                           allyesconfig
nds32                             allnoconfig
nios2                               defconfig
arc                              allyesconfig
parisc                              defconfig
parisc64                            defconfig
s390                             allmodconfig
s390                             allyesconfig
parisc                           allyesconfig
s390                                defconfig
i386                             allyesconfig
i386                              debian-10.3
i386                   debian-10.3-kselftests
i386                                defconfig
sparc                            allyesconfig
sparc                               defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                           allnoconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
x86_64                        randconfig-a002
x86_64                        randconfig-a004
x86_64                        randconfig-a006
i386                          randconfig-a001
i386                          randconfig-a005
i386                          randconfig-a003
x86_64                        randconfig-a015
x86_64                        randconfig-a013
x86_64                        randconfig-a011
i386                          randconfig-a014
i386                          randconfig-a012
i386                          randconfig-a016
arc                  randconfig-r043-20220323
riscv                randconfig-r042-20220323
s390                 randconfig-r044-20220323
riscv                    nommu_k210_defconfig
riscv                    nommu_virt_defconfig
riscv                            allyesconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                              defconfig
x86_64                           allyesconfig
x86_64                                  kexec
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                         rhel-8.3-kunit
x86_64                    rhel-8.3-kselftests

clang tested configs:
mips                      maltaaprp_defconfig
mips                   sb1250_swarm_defconfig
powerpc                     kilauea_defconfig
mips                        workpad_defconfig
powerpc                   lite5200b_defconfig
x86_64                        randconfig-a001
x86_64                        randconfig-a003
x86_64                        randconfig-a005
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64                        randconfig-a014
x86_64                        randconfig-a012
x86_64                        randconfig-a016
i386                          randconfig-a013
i386                          randconfig-a011
i386                          randconfig-a015
hexagon              randconfig-r041-20220323
hexagon              randconfig-r045-20220323

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
