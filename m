Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A11F59568D
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 11:36:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233680AbiHPJfO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 05:35:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233677AbiHPJem (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 05:34:42 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AD8032DB5
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 00:57:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660636672; x=1692172672;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=ZvWB4M8eR4Jbi7It4IXOF+CNiV2Jq8cf+MKyrs3C74M=;
  b=mkurmNIBxQzX/GyJebA64y+jnyisTf97Fm/M84J1kySzbROAnfCvZUt5
   Uj5AS/6a8t+qWHZxQW4WAH16NY4KedERkvDnsZixclXD+Y55EepIYH0q7
   IdA2ChTpaLwH00RRf+q+BYXeduUNyrT3KxcJQYI09E6vgxflm9bflAv3L
   fdQnctslvBLcnJebHqFTHhpWBNy9yPyapk06MXNazzzzXGNA6rgTL1r7m
   h3niYaphz/nbnyoFZiusNFDesl6nvrEGE3eGPYvHBMj4wk+e4WKxTlSYQ
   bx9B+RnRf27fSrGKp60mfEVOH8DiCpXzBexp33dI5uP8ZzIHzAwUdcVvx
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10440"; a="279115522"
X-IronPort-AV: E=Sophos;i="5.93,240,1654585200"; 
   d="scan'208";a="279115522"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2022 00:57:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,240,1654585200"; 
   d="scan'208";a="675121778"
Received: from lkp-server02.sh.intel.com (HELO 3d2a4d02a2a9) ([10.239.97.151])
  by fmsmga004.fm.intel.com with ESMTP; 16 Aug 2022 00:57:50 -0700
Received: from kbuild by 3d2a4d02a2a9 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oNrSQ-0001cB-0F;
        Tue, 16 Aug 2022 07:57:50 +0000
Date:   Tue, 16 Aug 2022 15:57:37 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/microcode] BUILD SUCCESS
 71da8a554f25713964a919311c324e5a32f08239
Message-ID: <62fb4df1.f2njs2LrTsRtYYfW%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/microcode
branch HEAD: 71da8a554f25713964a919311c324e5a32f08239  x86/microcode/AMD: Attempt applying on every logical thread

Unverified Warning (likely false positive, please contact us if interested):

Documentation/admin-guide/tainted-kernels.rst:143: WARNING: Block quote ends without a blank line; unexpected unindent.

Warning ids grouped by kconfigs:

gcc_recent_errors
`-- x86_64-allnoconfig
    `-- Documentation-admin-guide-tainted-kernels.rst:WARNING:Block-quote-ends-without-a-blank-line-unexpected-unindent.

elapsed time: 709m

configs tested: 110
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                              defconfig
x86_64                           allyesconfig
x86_64                               rhel-8.3
i386                             allyesconfig
i386                                defconfig
csky                              allnoconfig
alpha                             allnoconfig
arc                               allnoconfig
riscv                             allnoconfig
arm                      integrator_defconfig
sh                            shmin_defconfig
xtensa                              defconfig
arm                         at91_dt_defconfig
m68k                        m5307c3_defconfig
i386                 randconfig-a001-20220815
i386                 randconfig-a005-20220815
i386                 randconfig-a004-20220815
i386                 randconfig-a006-20220815
i386                 randconfig-a003-20220815
i386                 randconfig-a002-20220815
m68k                             allmodconfig
arc                              allyesconfig
alpha                            allyesconfig
x86_64               randconfig-a006-20220815
x86_64               randconfig-a003-20220815
x86_64               randconfig-a005-20220815
x86_64               randconfig-a004-20220815
x86_64               randconfig-a001-20220815
x86_64               randconfig-a002-20220815
x86_64                           rhel-8.3-kvm
x86_64                          rhel-8.3-func
x86_64                           rhel-8.3-syz
x86_64                    rhel-8.3-kselftests
x86_64                         rhel-8.3-kunit
i386                 randconfig-c001-20220815
sh                            hp6xx_defconfig
powerpc                   currituck_defconfig
powerpc                           allnoconfig
mips                             allyesconfig
powerpc                          allmodconfig
sh                               allmodconfig
s390                       zfcpdump_defconfig
m68k                             allyesconfig
powerpc                 mpc8540_ads_defconfig
arm64                            allyesconfig
arm                                 defconfig
arm                              allyesconfig
xtensa                  nommu_kc705_defconfig
riscv                    nommu_k210_defconfig
mips                         bigsur_defconfig
powerpc                      chrp32_defconfig
arm                           h3600_defconfig
powerpc                     redwood_defconfig
powerpc                     sequoia_defconfig
ia64                      gensparse_defconfig
arm                           corgi_defconfig
sh                        sh7785lcr_defconfig
arm                      footbridge_defconfig
powerpc                     stx_gp3_defconfig
nios2                               defconfig
arm                         vf610m4_defconfig
i386                          debian-10.3-kvm
i386                        debian-10.3-kunit
i386                         debian-10.3-func
powerpc              randconfig-c003-20220815
m68k                            q40_defconfig
arm                         s3c6400_defconfig
powerpc                      makalu_defconfig
arc                            hsdk_defconfig
powerpc                    klondike_defconfig
loongarch                           defconfig
loongarch                         allnoconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
s390                                defconfig
s390                             allmodconfig
arc                                 defconfig
alpha                               defconfig
s390                             allyesconfig
xtensa                         virt_defconfig
powerpc                       eiger_defconfig
arm                          iop32x_defconfig
m68k                       m5208evb_defconfig
m68k                         amcore_defconfig
arc                           tb10x_defconfig

clang tested configs:
riscv                randconfig-r042-20220815
s390                 randconfig-r044-20220815
hexagon              randconfig-r045-20220815
hexagon              randconfig-r041-20220815
x86_64               randconfig-a016-20220815
x86_64               randconfig-a013-20220815
x86_64               randconfig-a015-20220815
x86_64               randconfig-a014-20220815
x86_64               randconfig-a012-20220815
i386                 randconfig-a011-20220815
i386                 randconfig-a012-20220815
i386                 randconfig-a014-20220815
i386                 randconfig-a016-20220815
i386                 randconfig-a015-20220815
i386                 randconfig-a013-20220815
x86_64               randconfig-a011-20220815
arm                        multi_v5_defconfig
arm                          collie_defconfig
x86_64               randconfig-k001-20220815
powerpc                          g5_defconfig
powerpc                          allmodconfig
powerpc                 mpc836x_mds_defconfig

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
