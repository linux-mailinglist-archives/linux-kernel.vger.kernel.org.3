Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 915DE4FDE44
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 13:44:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233122AbiDLLeF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 07:34:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352425AbiDLLb5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 07:31:57 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E446870F48
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 03:10:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649758256; x=1681294256;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=jrmf8r0dOIxBfA2X/ZAbKEjI7p1658h9DZ/rRwxjGPM=;
  b=biL9kS77TD1yJr+q1s1Byo97vMCRBOcFJevoV2QUNMMTU5WCwWP5QEhR
   XKgIMgPnnptCxvHgRnFqLo9x1yfHug8NTRPVfqUPScAvG83v2M+6QRp0Z
   wTf0wT0W90Mism7vvjqzhKCVdVGN7IbaV+d1/TBtcdIFdQ5hW6U3uNxYX
   kAsH7NlZV0CwfN10ryboW2GjmCj8dkRXlFMLiCx2MelEp1SVK/vn0nkpf
   h/jf8RZfYp8o7ZhBCZFyRA3gnbc3Mz3ztFP1n1P6zQm3RFfrvGvkTkP6a
   sq0+0BruN2frUx24wdYT78MEWBcB1wQ5YchMrRqvpbOUFwCaxFRdcdjUU
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10314"; a="348774988"
X-IronPort-AV: E=Sophos;i="5.90,253,1643702400"; 
   d="scan'208";a="348774988"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2022 03:10:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,253,1643702400"; 
   d="scan'208";a="611372358"
Received: from lkp-server02.sh.intel.com (HELO d3fc50ef50de) ([10.239.97.151])
  by fmsmga008.fm.intel.com with ESMTP; 12 Apr 2022 03:10:55 -0700
Received: from kbuild by d3fc50ef50de with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1neDU6-0002jk-Qa;
        Tue, 12 Apr 2022 10:10:54 +0000
Date:   Tue, 12 Apr 2022 18:10:18 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:dev.2022.04.08a] BUILD SUCCESS
 96d35f716a63bc46750d66a5daec804997ff7cc6
Message-ID: <6255500a.7uRxuN5AFXqKOcCo%lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev.2022.04.08a
branch HEAD: 96d35f716a63bc46750d66a5daec804997ff7cc6  squash! rcu: Fix preemption mode check on synchronize_rcu[_expedited]()

elapsed time: 1558m

configs tested: 137
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
powerpc                     ep8248e_defconfig
microblaze                          defconfig
arm                            lart_defconfig
arc                           tb10x_defconfig
arm                          gemini_defconfig
sh                               alldefconfig
arm                     eseries_pxa_defconfig
powerpc                      mgcoge_defconfig
mips                  decstation_64_defconfig
sh                 kfr2r09-romimage_defconfig
arm                       imx_v6_v7_defconfig
m68k                       m5475evb_defconfig
xtensa                          iss_defconfig
arm                          pxa3xx_defconfig
arm                         s3c6400_defconfig
sh                          r7780mp_defconfig
m68k                       bvme6000_defconfig
arm                        realview_defconfig
parisc64                         alldefconfig
sh                          sdk7780_defconfig
i386                                defconfig
powerpc                 mpc834x_itx_defconfig
powerpc                      ppc40x_defconfig
sparc                       sparc64_defconfig
nios2                         3c120_defconfig
arm                           viper_defconfig
xtensa                  cadence_csp_defconfig
sh                          rsk7203_defconfig
mips                         cobalt_defconfig
nios2                            alldefconfig
ia64                      gensparse_defconfig
powerpc                 mpc837x_rdb_defconfig
sh                               j2_defconfig
m68k                       m5249evb_defconfig
powerpc                     stx_gp3_defconfig
riscv                               defconfig
arm                  randconfig-c002-20220411
x86_64               randconfig-c001-20220411
ia64                             allmodconfig
ia64                             allyesconfig
ia64                                defconfig
m68k                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
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
nios2                               defconfig
arc                              allyesconfig
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
powerpc                 mpc8272_ads_defconfig
mips                malta_qemu_32r6_defconfig
powerpc                 mpc832x_mds_defconfig
hexagon                             defconfig
powerpc                     ppa8548_defconfig
x86_64                           allyesconfig
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
i386                          randconfig-a013
i386                          randconfig-a011
i386                          randconfig-a015
hexagon              randconfig-r045-20220411
hexagon              randconfig-r041-20220411

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
