Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A80D94E33CA
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 00:11:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231954AbiCUXCT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 19:02:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232615AbiCUW6b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 18:58:31 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10E563B5021
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 15:35:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647902157; x=1679438157;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=RzCf4SJ+k3d46/cwkuqnvoxXNs2VObQiS28QfmiPf+g=;
  b=harJLerrGVxdUI4c9SbWmf8qUE7tfihmWYNkQS+keegFezRU5czyPdaz
   T/nmBH+ral3pX/+Eqw4QQOBNeOaU89x2zON7YQM1ESmZTm5ggZiZiG9i0
   5bCpE1bJIjeGJEY3mNQSRZVuMY8ebd7WBbaC44/f+9asBDThJaLfYXr4Z
   ysTBpgRJkbKE2Q67XpdcGdSrePoVHt8XSl7i4tmlnBxCk/518isWer7sG
   eqWdJ+Hc9X+Y9GVjURab1SyKM+UG1ni11sA6tD9mLGvNDGA5kfmPfk8M+
   dkQyiUOaVDSf8CtLHTFUaxuEA0H6L7opCi5PLIMAgcfWIiTugA22nwgKN
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10293"; a="239821766"
X-IronPort-AV: E=Sophos;i="5.90,199,1643702400"; 
   d="scan'208";a="239821766"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2022 15:35:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,199,1643702400"; 
   d="scan'208";a="500330533"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 21 Mar 2022 15:35:55 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nWQd0-000ID2-6N; Mon, 21 Mar 2022 22:35:54 +0000
Date:   Tue, 22 Mar 2022 06:35:20 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/core] BUILD SUCCESS
 44aba1d9e26641728f33f5834f436dd9ef486b96
Message-ID: <6238fda8.Ui3gXvQw+3Cnm2QF%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/core
branch HEAD: 44aba1d9e26641728f33f5834f436dd9ef486b96  kvm/emulate: Fix SETcc emulation for ENDBR

elapsed time: 728m

configs tested: 126
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                               defconfig
arm64                            allyesconfig
arm                              allmodconfig
arm                              allyesconfig
i386                 randconfig-c001-20220321
powerpc                mpc7448_hpc2_defconfig
arc                         haps_hs_defconfig
sh                            migor_defconfig
m68k                             alldefconfig
arc                        vdk_hs38_defconfig
m68k                         apollo_defconfig
m68k                       m5475evb_defconfig
arm                             pxa_defconfig
powerpc                      pcm030_defconfig
powerpc                    sam440ep_defconfig
nios2                         10m50_defconfig
sh                          rsk7269_defconfig
mips                        bcm47xx_defconfig
sh                          landisk_defconfig
mips                      fuloong2e_defconfig
sh                   secureedge5410_defconfig
powerpc                 mpc834x_itx_defconfig
sh                             sh03_defconfig
sh                        edosk7705_defconfig
arm                         vf610m4_defconfig
powerpc                     rainier_defconfig
m68k                        mvme147_defconfig
arm                            hisi_defconfig
arm                  randconfig-c002-20220320
arm                  randconfig-c002-20220321
ia64                             allmodconfig
ia64                             allyesconfig
ia64                                defconfig
m68k                                defconfig
m68k                             allyesconfig
m68k                             allmodconfig
nds32                             allnoconfig
nios2                               defconfig
arc                              allyesconfig
csky                                defconfig
alpha                               defconfig
nds32                               defconfig
alpha                            allyesconfig
nios2                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
h8300                            allyesconfig
xtensa                           allyesconfig
parisc                              defconfig
s390                                defconfig
parisc64                            defconfig
s390                             allmodconfig
s390                             allyesconfig
parisc                           allyesconfig
i386                             allyesconfig
i386                              debian-10.3
i386                   debian-10.3-kselftests
i386                                defconfig
sparc                            allyesconfig
sparc                               defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                           allnoconfig
powerpc                          allmodconfig
powerpc                          allyesconfig
x86_64               randconfig-a013-20220321
x86_64               randconfig-a012-20220321
x86_64               randconfig-a014-20220321
x86_64               randconfig-a011-20220321
x86_64               randconfig-a016-20220321
x86_64               randconfig-a015-20220321
i386                 randconfig-a013-20220321
i386                 randconfig-a016-20220321
i386                 randconfig-a015-20220321
i386                 randconfig-a011-20220321
i386                 randconfig-a012-20220321
i386                 randconfig-a014-20220321
arc                  randconfig-r043-20220320
riscv                randconfig-r042-20220321
s390                 randconfig-r044-20220321
arc                  randconfig-r043-20220321
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
riscv                    nommu_k210_defconfig
riscv                    nommu_virt_defconfig
riscv                            allyesconfig
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                          rhel-8.3-func
x86_64                         rhel-8.3-kunit
x86_64                    rhel-8.3-kselftests
x86_64                              defconfig
x86_64                           allyesconfig
x86_64                                  kexec
x86_64                               rhel-8.3

clang tested configs:
arm                          ixp4xx_defconfig
arm                     am200epdkit_defconfig
arm                        spear3xx_defconfig
powerpc                     tqm8540_defconfig
arm                  colibri_pxa270_defconfig
powerpc               mpc834x_itxgp_defconfig
riscv                             allnoconfig
powerpc                     pseries_defconfig
mips                     cu1830-neo_defconfig
mips                       lemote2f_defconfig
mips                        omega2p_defconfig
x86_64               randconfig-a003-20220321
x86_64               randconfig-a004-20220321
x86_64               randconfig-a001-20220321
x86_64               randconfig-a002-20220321
x86_64               randconfig-a005-20220321
x86_64               randconfig-a006-20220321
i386                 randconfig-a003-20220321
i386                 randconfig-a001-20220321
i386                 randconfig-a006-20220321
i386                 randconfig-a002-20220321
i386                 randconfig-a004-20220321
i386                 randconfig-a005-20220321
hexagon              randconfig-r041-20220321
hexagon              randconfig-r045-20220321
hexagon              randconfig-r045-20220320
hexagon              randconfig-r041-20220320
s390                 randconfig-r044-20220320
riscv                randconfig-r042-20220320

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
