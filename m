Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34D6755EDD3
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 21:29:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230016AbiF1T2Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 15:28:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231252AbiF1T1G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 15:27:06 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70E4C2F6
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 12:25:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656444331; x=1687980331;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=XKO1O2JaQBQyKUjcq5oTvNhtKJLLW78qPNkpHlDvDZk=;
  b=XOCuWyXR8ffRFovyr2wvY3bbv831vE2pO3e1nX4k+/yqVe/hlunnOVae
   IE23NwwMOdfcTgU8OoF5QEFxviv/bOLWc0sHh7Ne1HX2KG8m6M393q29N
   PA2uAg2VuhW8jI7gDld3rJ0hDKxy+O9JlKn+lSNKrf9+UlnqKOaPeFRLO
   6VVqWgj8XXa0uy3P1/wsNZBEAqXVGYeAm4bT7PsZy2Sf1qATvF1vIIKDj
   eec5syC3ujFSK3ChRSShaC4JZvBr64jv9iUKT7a+9ISz6UtEj1WfdWHMh
   vx1FppywOFfCdIUxMLHQJrQEgsxBJ4xU8n4pjnIv1RrEumy4gXyNaeL3u
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10392"; a="279374736"
X-IronPort-AV: E=Sophos;i="5.92,229,1650956400"; 
   d="scan'208";a="279374736"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2022 12:25:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,229,1650956400"; 
   d="scan'208";a="647050362"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 28 Jun 2022 12:25:30 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o6Gq1-000AYQ-Ik;
        Tue, 28 Jun 2022 19:25:29 +0000
Date:   Wed, 29 Jun 2022 03:25:03 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:perf/core] BUILD SUCCESS
 119a784c81270eb88e573174ed2209225d646656
Message-ID: <62bb558f.QXeNTUpZkct/xmcN%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git perf/core
branch HEAD: 119a784c81270eb88e573174ed2209225d646656  perf/core: Add a new read format to get a number of lost samples

i386-tinyconfig vmlinux size:

===========================================================================================================================================
 TOTAL  TEXT  __perf_read_group_add()  perf_output_read_group()                                                                            
===========================================================================================================================================
  +310  +309                      +98                       +78  119a784c8127 perf/core: Add a new read format to get a number of lost sam 
  +310  +309                      +98                       +78  b13baccc3850..119a784c8127 (ALL COMMITS)                                  
===========================================================================================================================================

elapsed time: 722m

configs tested: 84
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm                              allyesconfig
arm64                            allyesconfig
i386                 randconfig-c001-20220627
arm                          pxa910_defconfig
mips                      maltasmvp_defconfig
mips                           ip32_defconfig
arm                         vf610m4_defconfig
mips                        vocore2_defconfig
sh                           se7750_defconfig
sh                         ap325rxa_defconfig
openrisc                 simple_smp_defconfig
sh                          rsk7201_defconfig
sh                          sdk7780_defconfig
sh                 kfr2r09-romimage_defconfig
mips                         tb0226_defconfig
m68k                       bvme6000_defconfig
arm                        mini2440_defconfig
arm                      integrator_defconfig
arm                          simpad_defconfig
sh                         apsh4a3a_defconfig
arm                          exynos_defconfig
ia64                             allmodconfig
x86_64               randconfig-k001-20220627
arc                              allyesconfig
alpha                            allyesconfig
m68k                             allmodconfig
m68k                             allyesconfig
mips                             allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
sh                               allmodconfig
i386                                defconfig
i386                             allyesconfig
x86_64               randconfig-a013-20220627
x86_64               randconfig-a012-20220627
x86_64               randconfig-a016-20220627
x86_64               randconfig-a015-20220627
x86_64               randconfig-a011-20220627
x86_64               randconfig-a014-20220627
i386                 randconfig-a012-20220627
i386                 randconfig-a011-20220627
i386                 randconfig-a013-20220627
i386                 randconfig-a014-20220627
i386                 randconfig-a015-20220627
i386                 randconfig-a016-20220627
s390                 randconfig-r044-20220627
riscv                randconfig-r042-20220627
arc                  randconfig-r043-20220627
x86_64                    rhel-8.3-kselftests
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                              defconfig
x86_64                           allyesconfig
x86_64                               rhel-8.3
x86_64                           rhel-8.3-syz
x86_64                          rhel-8.3-func
x86_64                         rhel-8.3-kunit

clang tested configs:
arm                        multi_v5_defconfig
powerpc                     skiroot_defconfig
powerpc                     ppa8548_defconfig
mips                           rs90_defconfig
arm                           spitz_defconfig
powerpc                     tqm5200_defconfig
mips                        bcm63xx_defconfig
arm                     am200epdkit_defconfig
powerpc                      acadia_defconfig
mips                           ip27_defconfig
arm                        neponset_defconfig
powerpc                     ksi8560_defconfig
i386                 randconfig-a002-20220627
i386                 randconfig-a004-20220627
i386                 randconfig-a003-20220627
i386                 randconfig-a001-20220627
i386                 randconfig-a005-20220627
i386                 randconfig-a006-20220627
x86_64               randconfig-a002-20220627
x86_64               randconfig-a003-20220627
x86_64               randconfig-a001-20220627
x86_64               randconfig-a005-20220627
x86_64               randconfig-a004-20220627
x86_64               randconfig-a006-20220627
hexagon              randconfig-r041-20220627
hexagon              randconfig-r045-20220627

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
