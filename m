Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 489A0576B92
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Jul 2022 06:11:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231443AbiGPELB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Jul 2022 00:11:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbiGPEK7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jul 2022 00:10:59 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDE1337193
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jul 2022 21:10:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657944658; x=1689480658;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=YWaAvI3RoVTErA+cVhmR+Ue0x6XqDE+M1GO4NOCNHfU=;
  b=Hpyj7clcvkVpo5upFnx6wiHIp2xTZ5mI8eTFXoKFzq35HGzHLvK4T3IL
   f1Yr3zLSvKGlvGbIafUHLrBxAe17tRJ8YXgBikjzwmfnHllzCyW0ThWaw
   bEtPsn6eBvovTEck9ZOwOQCftYPS36G7MZM13wpEsj5320s48Ulpnkg9c
   30srs9llueZEckMtA8CVpYfnT764MxFQPG2H6lK5uVILk5fAbr1uZ9wjM
   1V+tWE4Ot6w+5WNplPuUuCXU05HQ6ZRNXlTgzpwQcEjd1jk+UXtnFoZCJ
   WoMPCUSnKzuSrlyfm6OJSQIosSZhbNGQsnW46gIH3pEljPgz0l/+E+gBM
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10409"; a="287084631"
X-IronPort-AV: E=Sophos;i="5.92,275,1650956400"; 
   d="scan'208";a="287084631"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2022 21:10:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,275,1650956400"; 
   d="scan'208";a="546890400"
Received: from lkp-server02.sh.intel.com (HELO ff137eb26ff1) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 15 Jul 2022 21:10:57 -0700
Received: from kbuild by ff137eb26ff1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1oCZ8q-00017s-Qk;
        Sat, 16 Jul 2022 04:10:56 +0000
Date:   Sat, 16 Jul 2022 12:10:37 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/urgent] BUILD SUCCESS
 564d998106397394b6aad260f219b882b3347e62
Message-ID: <62d23a3d.K8yUfqJKgU+H2cX9%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/urgent
branch HEAD: 564d998106397394b6aad260f219b882b3347e62  um: Add missing apply_returns()

elapsed time: 728m

configs tested: 97
configs skipped: 81

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm64                            allyesconfig
arm                                 defconfig
arm                              allyesconfig
i386                          randconfig-c001
arm                      footbridge_defconfig
xtensa                              defconfig
openrisc                    or1ksim_defconfig
arm                        mvebu_v7_defconfig
powerpc                 mpc85xx_cds_defconfig
parisc                generic-32bit_defconfig
arm                           u8500_defconfig
sh                          urquell_defconfig
s390                       zfcpdump_defconfig
m68k                             alldefconfig
mips                           jazz_defconfig
arm                          simpad_defconfig
arm                       multi_v4t_defconfig
powerpc                     ep8248e_defconfig
sh                        sh7763rdp_defconfig
mips                    maltaup_xpa_defconfig
xtensa                    xip_kc705_defconfig
powerpc                     tqm8555_defconfig
sh                        sh7785lcr_defconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
riscv                             allnoconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
csky                              allnoconfig
alpha                             allnoconfig
arc                               allnoconfig
m68k                             allyesconfig
m68k                             allmodconfig
arc                              allyesconfig
alpha                            allyesconfig
powerpc                           allnoconfig
mips                             allyesconfig
powerpc                          allmodconfig
sh                               allmodconfig
i386                                defconfig
i386                             allyesconfig
x86_64                        randconfig-a002
x86_64                        randconfig-a004
x86_64                        randconfig-a006
i386                          randconfig-a001
i386                          randconfig-a003
i386                          randconfig-a005
x86_64                        randconfig-a013
x86_64                        randconfig-a011
x86_64                        randconfig-a015
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
x86_64                    rhel-8.3-kselftests
x86_64                           allyesconfig
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit

clang tested configs:
mips                      pic32mzda_defconfig
mips                           mtx1_defconfig
powerpc                      ppc64e_defconfig
arm                        mvebu_v5_defconfig
arm                         bcm2835_defconfig
powerpc                    socrates_defconfig
powerpc               mpc834x_itxgp_defconfig
arm                       netwinder_defconfig
mips                       lemote2f_defconfig
arm                   milbeaut_m10v_defconfig
powerpc                    ge_imp3a_defconfig
arm                          collie_defconfig
mips                     cu1830-neo_defconfig
powerpc                      obs600_defconfig
arm                            dove_defconfig
x86_64                        randconfig-k001
x86_64                        randconfig-a001
x86_64                        randconfig-a003
x86_64                        randconfig-a005
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
i386                          randconfig-a013
i386                          randconfig-a011
i386                          randconfig-a015
hexagon              randconfig-r045-20220715
s390                 randconfig-r044-20220715
hexagon              randconfig-r041-20220715
riscv                randconfig-r042-20220715
hexagon              randconfig-r045-20220716
hexagon              randconfig-r041-20220716

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
