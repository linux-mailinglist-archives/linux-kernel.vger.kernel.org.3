Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82BBB4FDDB2
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 13:43:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230381AbiDLLdz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 07:33:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352795AbiDLLb5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 07:31:57 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A14D70F57
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 03:10:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649758257; x=1681294257;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=L9nl1LE8wmXe0EioJqHYeRkDmNRZ+zce0uGC1pVxDU0=;
  b=kLXeK8H85LdBs6zyw6gyv3VLkive0NMMJwNEsRCmPZsOtp1YmG0sI0/S
   jmDPezmtDjDzqQ6HHtvwNcVjnF01qOV37DswVwEXJNOZhFNtbV40LfY9r
   vjy1HpBXMSXUNxDnCdjo5y+rqqHHHjsg3WEmoLK6QPuDq1ydLEfQAlwLh
   nVQL1dZnafoLYPRqDYqnbNd+D2aXt+CaAqmioT8lE9rygof0kJA8A+Pdc
   2xtB0HhzkundLY9sBu0A8Q3sWh2KknJ85e9p8kMpWISW60sHEWWcqVQa6
   pM8p7qI93q292zI66QjKJzqoArNPjhEcidxv9sjy+xkP0r/XpjwRj4efv
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10314"; a="262517559"
X-IronPort-AV: E=Sophos;i="5.90,253,1643702400"; 
   d="scan'208";a="262517559"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2022 03:10:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,253,1643702400"; 
   d="scan'208";a="724383469"
Received: from lkp-server02.sh.intel.com (HELO d3fc50ef50de) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 12 Apr 2022 03:10:55 -0700
Received: from kbuild by d3fc50ef50de with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1neDU7-0002jw-2m;
        Tue, 12 Apr 2022 10:10:55 +0000
Date:   Tue, 12 Apr 2022 18:10:31 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/sev] BUILD SUCCESS
 e50abbf788c239d529f9ab81e325f8e8f8432c9d
Message-ID: <62555017.xd1SRkcAmw+UGoMu%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/sev
branch HEAD: e50abbf788c239d529f9ab81e325f8e8f8432c9d  virt: sevguest: Fix return value check in alloc_shared_pages()

elapsed time: 736m

configs tested: 121
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm64                               defconfig
arm64                            allyesconfig
arm                              allmodconfig
arm                                 defconfig
arm                              allyesconfig
i386                 randconfig-c001-20220411
arm                     eseries_pxa_defconfig
powerpc                      mgcoge_defconfig
mips                  decstation_64_defconfig
arm                       imx_v6_v7_defconfig
arm                          pxa3xx_defconfig
m68k                       m5475evb_defconfig
sh                 kfr2r09-romimage_defconfig
xtensa                          iss_defconfig
powerpc                     ep8248e_defconfig
arm                        realview_defconfig
sh                          sdk7780_defconfig
parisc64                         alldefconfig
powerpc                      ppc40x_defconfig
powerpc                      bamboo_defconfig
powerpc                     stx_gp3_defconfig
powerpc                     mpc83xx_defconfig
ia64                      gensparse_defconfig
powerpc                 mpc837x_rdb_defconfig
sh                               j2_defconfig
m68k                       m5249evb_defconfig
riscv                               defconfig
openrisc                         alldefconfig
arm                      jornada720_defconfig
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
parisc                              defconfig
parisc64                            defconfig
s390                             allmodconfig
parisc                           allyesconfig
s390                                defconfig
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
riscv                randconfig-r042-20220411
arc                  randconfig-r043-20220411
s390                 randconfig-r044-20220411
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
riscv                             allnoconfig
riscv                            allmodconfig
riscv                            allyesconfig
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                          rhel-8.3-func
x86_64                                  kexec
x86_64                           allyesconfig
x86_64                    rhel-8.3-kselftests
x86_64                         rhel-8.3-kunit
x86_64                               rhel-8.3
x86_64                              defconfig

clang tested configs:
powerpc              randconfig-c003-20220411
arm                  randconfig-c002-20220411
riscv                randconfig-c006-20220411
x86_64               randconfig-c007-20220411
mips                 randconfig-c004-20220411
i386                 randconfig-c001-20220411
arm                        multi_v5_defconfig
powerpc                 mpc8315_rdb_defconfig
powerpc                     mpc512x_defconfig
powerpc                     ppa8548_defconfig
x86_64                           allyesconfig
powerpc                 mpc837x_rdb_defconfig
arm                           sama7_defconfig
arm                          pxa168_defconfig
x86_64               randconfig-a003-20220411
x86_64               randconfig-a004-20220411
x86_64               randconfig-a006-20220411
x86_64               randconfig-a001-20220411
x86_64               randconfig-a002-20220411
x86_64               randconfig-a005-20220411
i386                 randconfig-a003-20220411
i386                 randconfig-a001-20220411
i386                 randconfig-a002-20220411
i386                 randconfig-a006-20220411
i386                 randconfig-a004-20220411
i386                 randconfig-a005-20220411
hexagon              randconfig-r041-20220411
hexagon              randconfig-r045-20220411

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
