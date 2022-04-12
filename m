Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7895C4FDED5
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 13:58:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346691AbiDLMAa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 08:00:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349823AbiDLL5v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 07:57:51 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81C1D61A37
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 03:47:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649760431; x=1681296431;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=FITyXe8MFzXWfnxQq+a0yZeb4zzQpQ1NJfmontvv7vY=;
  b=kwrVKOoZo6+cmn+oZQD5w1mCyaeX4d9JF0/A5si6jSS+RoYWalP27B6/
   6J8bbJRad4k7yyru4mH5Jlfu2h0IeNAV/MiHbuYYAGscKWW/KFVAEoAig
   NvUHog6N3FjHjgDBSE2clxxzQCaPLPhtRAkqTMTQhBnmdlTo4rRpoLCGt
   R05fv6Y45iu00osfnq0gOgJoBF/edE+eUQDJEGbFllgMJNfxPK2R+ceus
   NvIlV3iuUVh25+CGg+YfxXJ9erF/f8+H/sv7e23ubq/M74XkZngW2u3AI
   ZrmOOBV3tq20l/gsfnGbP1YvnsuCvye+x+/qWoJq5dGsHSw/EHtNEArQs
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10314"; a="322789591"
X-IronPort-AV: E=Sophos;i="5.90,253,1643702400"; 
   d="scan'208";a="322789591"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2022 03:47:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,253,1643702400"; 
   d="scan'208";a="660439703"
Received: from lkp-server02.sh.intel.com (HELO d3fc50ef50de) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 12 Apr 2022 03:47:09 -0700
Received: from kbuild by d3fc50ef50de with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1neE3B-0002mN-1t;
        Tue, 12 Apr 2022 10:47:09 +0000
Date:   Tue, 12 Apr 2022 18:47:02 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:dev.2022.04.10a] BUILD SUCCESS
 6503dafd28b7bea4cf83261b053b76f151f2eee1
Message-ID: <625558a6.wmYjSNcxBl78lyfO%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev.2022.04.10a
branch HEAD: 6503dafd28b7bea4cf83261b053b76f151f2eee1  rcu-tasks: Handle sparse cpu_possible_mask in rcu_tasks_invoke_cbs()

elapsed time: 771m

configs tested: 121
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm64                               defconfig
arm64                            allyesconfig
arm                              allmodconfig
arm                                 defconfig
arm                              allyesconfig
i386                 randconfig-c001-20220411
powerpc                      mgcoge_defconfig
mips                  decstation_64_defconfig
arm                     eseries_pxa_defconfig
arm                       imx_v6_v7_defconfig
arm                          pxa3xx_defconfig
m68k                       m5475evb_defconfig
sh                 kfr2r09-romimage_defconfig
xtensa                          iss_defconfig
parisc64                         alldefconfig
powerpc                     ep8248e_defconfig
arm                        realview_defconfig
sh                          sdk7780_defconfig
powerpc                      ppc40x_defconfig
powerpc                      bamboo_defconfig
powerpc                     stx_gp3_defconfig
powerpc                     mpc83xx_defconfig
ia64                      gensparse_defconfig
powerpc                 mpc837x_rdb_defconfig
sh                               j2_defconfig
m68k                       m5249evb_defconfig
riscv                               defconfig
arm                  randconfig-c002-20220411
x86_64               randconfig-c001-20220411
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
h8300                            allyesconfig
xtensa                           allyesconfig
arc                                 defconfig
sh                               allmodconfig
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
powerpc                           allnoconfig
powerpc                          allmodconfig
powerpc                          allyesconfig
x86_64               randconfig-a016-20220411
x86_64               randconfig-a012-20220411
x86_64               randconfig-a013-20220411
x86_64               randconfig-a014-20220411
x86_64               randconfig-a015-20220411
x86_64               randconfig-a011-20220411
i386                 randconfig-a015-20220411
i386                 randconfig-a011-20220411
i386                 randconfig-a016-20220411
i386                 randconfig-a012-20220411
i386                 randconfig-a013-20220411
i386                 randconfig-a014-20220411
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
arc                  randconfig-r043-20220411
s390                 randconfig-r044-20220411
riscv                randconfig-r042-20220411
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
riscv                             allnoconfig
riscv                            allmodconfig
riscv                            allyesconfig
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                          rhel-8.3-func
x86_64                                  kexec
x86_64                              defconfig
x86_64                           allyesconfig
x86_64                    rhel-8.3-kselftests
x86_64                         rhel-8.3-kunit
x86_64                               rhel-8.3

clang tested configs:
powerpc              randconfig-c003-20220411
arm                  randconfig-c002-20220411
riscv                randconfig-c006-20220411
x86_64               randconfig-c007-20220411
mips                 randconfig-c004-20220411
i386                 randconfig-c001-20220411
mips                       lemote2f_defconfig
powerpc                    mvme5100_defconfig
arm                        multi_v5_defconfig
powerpc                 mpc8315_rdb_defconfig
powerpc                     mpc512x_defconfig
powerpc                     ppa8548_defconfig
x86_64                           allyesconfig
arm                           sama7_defconfig
arm                          pxa168_defconfig
x86_64               randconfig-a003-20220411
x86_64               randconfig-a001-20220411
x86_64               randconfig-a002-20220411
x86_64               randconfig-a005-20220411
x86_64               randconfig-a004-20220411
x86_64               randconfig-a006-20220411
i386                 randconfig-a004-20220411
i386                 randconfig-a001-20220411
i386                 randconfig-a003-20220411
i386                 randconfig-a005-20220411
i386                 randconfig-a006-20220411
i386                 randconfig-a002-20220411
hexagon              randconfig-r041-20220411
hexagon              randconfig-r045-20220411

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
