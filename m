Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BB89517FAF
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 10:24:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232762AbiECI2G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 04:28:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232756AbiECI2C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 04:28:02 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D4082980A
        for <linux-kernel@vger.kernel.org>; Tue,  3 May 2022 01:24:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651566270; x=1683102270;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=3ABJnAVg2L4eBLYL/Z4R29d+29BblvQXHFIuUoPejQw=;
  b=j3cvRk+kD5uy6V5fZr1wemRadznYQvROHGKQmVEAD8KBdNrQ/CnQ+whl
   Hka8hDSdM5QHOB7ZxWHHICzjnfwpyv2IF1BCdcMKm/GWKyalfSXdQCBiw
   dCMxxE/FMOAdnDqzYLK82hjLV6WGEb7gQN28YXJ7zmiKxH9mSmPd8PvUT
   nZw12eKu/X8CVq9HvAXixKBZ8GtIkSKpSkJdI2xTVmENve7HjA5i8k7zy
   ljSKoVi1oZBaSvdAZDCNx31nkPRt/Dqm76QaT9js7XyxqdlZUbZbRmBQv
   d1W0TgeY64hd+IGjCDRFKSu9XcwpFcNctkBCvJKi+UIYnsbK3WFd/4ZD6
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10335"; a="247334858"
X-IronPort-AV: E=Sophos;i="5.91,194,1647327600"; 
   d="scan'208";a="247334858"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 May 2022 01:24:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,194,1647327600"; 
   d="scan'208";a="707953720"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 03 May 2022 01:24:28 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nlnpc-000AHX-6N;
        Tue, 03 May 2022 08:24:28 +0000
Date:   Tue, 03 May 2022 16:23:34 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:irq/urgent] BUILD SUCCESS
 9b83d81acad9d29234b336dc57c84d87a617d358
Message-ID: <6270e686.FFlJWVeaMkMozpF1%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq/urgent
branch HEAD: 9b83d81acad9d29234b336dc57c84d87a617d358  genirq: Synchronize interrupt thread startup

i386-tinyconfig vmlinux size:

=================================================================================================================
 TOTAL  TEXT  wake_up_and_wait_for_irq_thread_ready()                                                            
=================================================================================================================
  +120  +118                                      +90  9b83d81acad9 genirq: Synchronize interrupt thread startup 
  +120  +118                                      +90  672c0c517342..9b83d81acad9 (ALL COMMITS)                  
=================================================================================================================

elapsed time: 773m

configs tested: 134
configs skipped: 5

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm64                               defconfig
arm64                            allyesconfig
arm                              allmodconfig
arm                                 defconfig
arm                              allyesconfig
i386                          randconfig-c001
mips                         tb0226_defconfig
powerpc                         ps3_defconfig
powerpc                      cm5200_defconfig
powerpc                       holly_defconfig
h8300                               defconfig
sh                          rsk7264_defconfig
sparc                            alldefconfig
sh                           se7619_defconfig
powerpc                      ep88xc_defconfig
arm                           imxrt_defconfig
arm                       multi_v4t_defconfig
arc                          axs103_defconfig
mips                  maltasmvp_eva_defconfig
sh                            migor_defconfig
sh                           sh2007_defconfig
powerpc                     mpc83xx_defconfig
sparc                       sparc64_defconfig
s390                          debug_defconfig
powerpc                     asp8347_defconfig
mips                       bmips_be_defconfig
sh                           se7721_defconfig
sh                           se7705_defconfig
x86_64                        randconfig-c001
arm                  randconfig-c002-20220501
ia64                                defconfig
ia64                             allmodconfig
ia64                             allyesconfig
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
powerpc                          allyesconfig
powerpc                           allnoconfig
powerpc                          allmodconfig
x86_64                        randconfig-a006
x86_64                        randconfig-a004
x86_64                        randconfig-a002
i386                 randconfig-a003-20220502
i386                 randconfig-a002-20220502
i386                 randconfig-a001-20220502
i386                 randconfig-a004-20220502
i386                 randconfig-a006-20220502
i386                 randconfig-a005-20220502
x86_64                        randconfig-a011
x86_64                        randconfig-a013
x86_64                        randconfig-a015
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
arc                  randconfig-r043-20220501
arc                  randconfig-r043-20220502
s390                 randconfig-r044-20220501
riscv                randconfig-r042-20220501
riscv                               defconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
riscv                             allnoconfig
riscv                            allmodconfig
riscv                            allyesconfig
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                          rhel-8.3-func
x86_64                           rhel-8.3-syz
x86_64                                  kexec
x86_64                              defconfig
x86_64                           allyesconfig
x86_64                    rhel-8.3-kselftests
x86_64                         rhel-8.3-kunit
x86_64                               rhel-8.3

clang tested configs:
arm                         lpc32xx_defconfig
mips                     cu1830-neo_defconfig
arm                  colibri_pxa270_defconfig
powerpc                 mpc8315_rdb_defconfig
powerpc                      ppc44x_defconfig
powerpc                     powernv_defconfig
x86_64                        randconfig-a005
x86_64                        randconfig-a001
x86_64                        randconfig-a003
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
x86_64               randconfig-a015-20220502
x86_64               randconfig-a012-20220502
x86_64               randconfig-a016-20220502
x86_64               randconfig-a014-20220502
x86_64               randconfig-a013-20220502
x86_64               randconfig-a011-20220502
i386                 randconfig-a011-20220502
i386                 randconfig-a013-20220502
i386                 randconfig-a016-20220502
i386                 randconfig-a015-20220502
i386                 randconfig-a014-20220502
i386                 randconfig-a012-20220502
i386                          randconfig-a011
i386                          randconfig-a013
i386                          randconfig-a015
hexagon              randconfig-r045-20220502
riscv                randconfig-r042-20220502
hexagon              randconfig-r041-20220502
hexagon              randconfig-r045-20220501
hexagon              randconfig-r041-20220501

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
