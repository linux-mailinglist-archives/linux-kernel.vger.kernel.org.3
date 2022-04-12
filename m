Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CC804FE85F
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 20:59:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358996AbiDLTBU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 15:01:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358925AbiDLTAp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 15:00:45 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B4DB5DA35
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 11:58:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649789900; x=1681325900;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=BFKVrkAZJRfV0poEt2Ib3XcVdvdDEf1a8Zz6CBJAp94=;
  b=IcDYluO79cETRvG49LVCRIRFrkXM+e/qgn96ViR4mOXyQQtuDfJTr+uI
   1KEWARYblS1WjX+fUkZbWxjjeXqc4blXoH0I7nFHrK/Fm7dM6sOrNCfmw
   UX80aVUU/OOoAaOFa643mllGJ6ecttZM/qYXKyF1OjMN8qVx1I0z16jh+
   W558yV/qaoDG2wJu9l5k9/BobP2PGoe1v0PYcF35apUXUXmEoq5HxM9RY
   91eNoDmsTIqtqORSZm2HxQN+26sb6R1LmMVUIlNpeF4BVtMZWPWbni7h6
   AYXT0rQ4o7tC1/Lqx7YdlhmL3iQUhV0THTZV1sNR7qk+1hrbXvQ0d8YJ2
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10315"; a="243063135"
X-IronPort-AV: E=Sophos;i="5.90,254,1643702400"; 
   d="scan'208";a="243063135"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2022 11:58:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,254,1643702400"; 
   d="scan'208";a="854491283"
Received: from lkp-server02.sh.intel.com (HELO d3fc50ef50de) ([10.239.97.151])
  by fmsmga005.fm.intel.com with ESMTP; 12 Apr 2022 11:58:18 -0700
Received: from kbuild by d3fc50ef50de with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1neLiT-00035l-Ld;
        Tue, 12 Apr 2022 18:58:17 +0000
Date:   Wed, 13 Apr 2022 02:57:58 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:fastexp.2022.04.11a] BUILD SUCCESS
 3902dd17a29bd3ed1ead364a331a1761edb7162b
Message-ID: <6255cbb6.N4DIGufWc+o9VsQX%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git fastexp.2022.04.11a
branch HEAD: 3902dd17a29bd3ed1ead364a331a1761edb7162b  EXP rcu: Move expedited grace period (GP) work to RT kthread_worker

elapsed time: 729m

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
arc                           tb10x_defconfig
arm                          gemini_defconfig
arm                            lart_defconfig
i386                                defconfig
sh                               alldefconfig
powerpc                      makalu_defconfig
sh                           se7750_defconfig
powerpc                       eiger_defconfig
arc                    vdk_hs38_smp_defconfig
powerpc                       holly_defconfig
arm                       imx_v6_v7_defconfig
arm                          pxa3xx_defconfig
m68k                       m5475evb_defconfig
sh                 kfr2r09-romimage_defconfig
xtensa                          iss_defconfig
powerpc                     ep8248e_defconfig
arm                        realview_defconfig
sh                          sdk7780_defconfig
parisc64                         alldefconfig
powerpc                     mpc83xx_defconfig
mips                  decstation_64_defconfig
powerpc                      bamboo_defconfig
powerpc                     stx_gp3_defconfig
riscv                               defconfig
arm                       multi_v4t_defconfig
sh                               j2_defconfig
m68k                       m5249evb_defconfig
arm                  randconfig-c002-20220411
x86_64               randconfig-c001-20220411
ia64                                defconfig
ia64                             allmodconfig
ia64                             allyesconfig
m68k                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
arc                              allyesconfig
alpha                               defconfig
csky                                defconfig
alpha                            allyesconfig
nios2                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
h8300                            allyesconfig
xtensa                           allyesconfig
parisc                              defconfig
parisc64                            defconfig
s390                             allmodconfig
parisc                           allyesconfig
s390                                defconfig
s390                             allyesconfig
sparc                               defconfig
i386                             allyesconfig
sparc                            allyesconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
nios2                               defconfig
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
i386                 randconfig-a011-20220411
i386                 randconfig-a012-20220411
i386                 randconfig-a013-20220411
i386                 randconfig-a015-20220411
i386                 randconfig-a014-20220411
i386                 randconfig-a016-20220411
arc                  randconfig-r043-20220411
s390                 randconfig-r044-20220411
riscv                randconfig-r042-20220411
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
powerpc                 xes_mpc85xx_defconfig
mips                        qi_lb60_defconfig
powerpc                     ppa8548_defconfig
x86_64                           allyesconfig
x86_64               randconfig-a003-20220411
x86_64               randconfig-a004-20220411
x86_64               randconfig-a006-20220411
x86_64               randconfig-a001-20220411
x86_64               randconfig-a002-20220411
x86_64               randconfig-a005-20220411
i386                 randconfig-a004-20220411
i386                 randconfig-a001-20220411
i386                 randconfig-a003-20220411
i386                 randconfig-a005-20220411
i386                 randconfig-a006-20220411
i386                 randconfig-a002-20220411
hexagon              randconfig-r041-20220411
hexagon              randconfig-r045-20220411
riscv                randconfig-r042-20220412
hexagon              randconfig-r041-20220412
hexagon              randconfig-r045-20220412

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
