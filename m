Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B68214FE863
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 20:59:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359020AbiDLTBW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 15:01:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358931AbiDLTAp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 15:00:45 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 530BA5DA49
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 11:58:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649789900; x=1681325900;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=ArM6zdSPrEfub9f8dsOx6ulm8dvmlFlgaT3Do9sqEmg=;
  b=XVccSjkNLcftPsrI56VNYkL9wzstzgiZlxv7Bem+p7V5c/hdC9lF2OxX
   gqZ3IVFbccOfEUGL3MrlW2ieNuSJ9edkLa66RvZQVxz1mrnK0TtkC4IRN
   szTDAaiiltDrEPybEg68DLvR1n3yNsbfJKXBlhCpn+XNj+Se7qFWyH3jA
   Y+SBX7BFUc/uwSndSxRfXmFivEnttclpgSfL42F3RDgfAwX/NXFTv+5Rf
   YC9MgWhrTKh0e7Q9EJQ7vF6IINPDnRPzRGEVFfBCxeFkP/zMFZU/Fcefn
   7/U8KGPG/qoKsf13Rau0odnn7NqDn4Ae9uW4U57sM/e1lvpdO1g3t1WGr
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10315"; a="262230510"
X-IronPort-AV: E=Sophos;i="5.90,254,1643702400"; 
   d="scan'208";a="262230510"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2022 11:58:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,254,1643702400"; 
   d="scan'208";a="611587870"
Received: from lkp-server02.sh.intel.com (HELO d3fc50ef50de) ([10.239.97.151])
  by fmsmga008.fm.intel.com with ESMTP; 12 Apr 2022 11:58:18 -0700
Received: from kbuild by d3fc50ef50de with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1neLiT-00035j-LA;
        Tue, 12 Apr 2022 18:58:17 +0000
Date:   Wed, 13 Apr 2022 02:57:50 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:rcu/next] BUILD SUCCESS
 e912cedc79ae9278ebbc660b07969f953431748d
Message-ID: <6255cbae.o8736nu8CxzA8qzw%lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git rcu/next
branch HEAD: e912cedc79ae9278ebbc660b07969f953431748d  rcu-tasks: Handle sparse cpu_possible_mask in rcu_tasks_invoke_cbs()

elapsed time: 1258m

configs tested: 140
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
arm                            lart_defconfig
arc                           tb10x_defconfig
arm                          gemini_defconfig
i386                                defconfig
sh                               alldefconfig
sh                            migor_defconfig
arm                         cm_x300_defconfig
sparc                       sparc32_defconfig
sh                          rsk7269_defconfig
arm                          badge4_defconfig
arm                     eseries_pxa_defconfig
powerpc                      mgcoge_defconfig
arm                       imx_v6_v7_defconfig
arm                          pxa3xx_defconfig
m68k                       m5475evb_defconfig
sh                 kfr2r09-romimage_defconfig
xtensa                          iss_defconfig
sh                        sh7763rdp_defconfig
arm                         at91_dt_defconfig
powerpc                     ep8248e_defconfig
arm                        realview_defconfig
sh                          sdk7780_defconfig
parisc64                         alldefconfig
um                                  defconfig
arm                           u8500_defconfig
arm                           viper_defconfig
powerpc                      bamboo_defconfig
powerpc                     stx_gp3_defconfig
mips                  decstation_64_defconfig
powerpc                     mpc83xx_defconfig
xtensa                  cadence_csp_defconfig
sh                          rsk7203_defconfig
mips                         cobalt_defconfig
nios2                            alldefconfig
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
riscv                randconfig-r042-20220411
s390                 randconfig-r044-20220411
arc                  randconfig-r043-20220411
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
powerpc              randconfig-c003-20220411
arm                  randconfig-c002-20220411
riscv                randconfig-c006-20220411
x86_64               randconfig-c007-20220411
mips                 randconfig-c004-20220411
i386                 randconfig-c001-20220411
arm                      pxa255-idp_defconfig
arm                        multi_v5_defconfig
powerpc                 mpc8315_rdb_defconfig
powerpc                     mpc512x_defconfig
powerpc                     ppa8548_defconfig
x86_64                           allyesconfig
arm                      tct_hammer_defconfig
arm                         s5pv210_defconfig
powerpc                     tqm8560_defconfig
arm                            mmp2_defconfig
powerpc                 mpc837x_rdb_defconfig
arm                           sama7_defconfig
arm                          pxa168_defconfig
i386                 randconfig-a004-20220411
i386                 randconfig-a001-20220411
i386                 randconfig-a003-20220411
i386                 randconfig-a005-20220411
i386                 randconfig-a006-20220411
i386                 randconfig-a002-20220411
x86_64               randconfig-a003-20220411
x86_64               randconfig-a004-20220411
x86_64               randconfig-a006-20220411
x86_64               randconfig-a001-20220411
x86_64               randconfig-a002-20220411
x86_64               randconfig-a005-20220411
riscv                randconfig-r042-20220412
hexagon              randconfig-r041-20220412
hexagon              randconfig-r045-20220412
hexagon              randconfig-r041-20220411
hexagon              randconfig-r045-20220411

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
