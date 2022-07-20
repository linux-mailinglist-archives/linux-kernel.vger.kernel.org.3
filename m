Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E59E357B184
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 09:16:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231592AbiGTHQT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 03:16:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230268AbiGTHQR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 03:16:17 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB54B64E0A
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 00:16:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658301376; x=1689837376;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=/8L3obda0Lda9rzpfD1VtSX9r9oE8lnyQvWrd3c3dDQ=;
  b=ikfUTCHvPBs+QV3OfXDDPHh7st5wBLHfIaKP07m7bq07CWV5VCMsMiac
   lgHPfGS3PF6ijB0deRg6D2fukSmKanP7zBfQ6QDdC5+xcq1HiePvkGQqu
   LKW1p9VfMuszupLnxsxqPWpbYl2MZ3zAv0Vl9Qx0RktYeZHK+vna0duPe
   7ASlrEEGVz6VJkXuB0DnAAK5lIzDgggYahuTqAPvq0AoM9WLDcKJWKdpF
   IaeLZElDOks921WkWtyi9pdLuzwg/8c5d6isjpuRf4t2zMZTXx4z6tXqW
   koeXHGXLSsuHVElB/uAq2ERs4ZEXGbPz91pOkWN3+CaeTTE3RFMMmczTQ
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10413"; a="286710502"
X-IronPort-AV: E=Sophos;i="5.92,286,1650956400"; 
   d="scan'208";a="286710502"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2022 00:16:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,286,1650956400"; 
   d="scan'208";a="573185107"
Received: from lkp-server01.sh.intel.com (HELO 7dfbdc7c7900) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 20 Jul 2022 00:16:14 -0700
Received: from kbuild by 7dfbdc7c7900 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1oE3wM-0000Af-96;
        Wed, 20 Jul 2022 07:16:14 +0000
Date:   Wed, 20 Jul 2022 15:15:28 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/cpu] BUILD SUCCESS
 3f2adf00f52b5f2e9e9f23bb5c77608fc9ee297c
Message-ID: <62d7ab90.cCNoyWgUN7+A93cx%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/cpu
branch HEAD: 3f2adf00f52b5f2e9e9f23bb5c77608fc9ee297c  x86/cpu: Use MSR_IA32_MISC_ENABLE constants

elapsed time: 720m

configs tested: 100
configs skipped: 74

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm64                            allyesconfig
arm                                 defconfig
arm                              allyesconfig
i386                          randconfig-c001
i386                 randconfig-c001-20220718
arm                          pxa3xx_defconfig
arm                        realview_defconfig
powerpc                       maple_defconfig
m68k                        m5307c3_defconfig
m68k                             alldefconfig
arc                     haps_hs_smp_defconfig
powerpc                     pq2fads_defconfig
sh                         microdev_defconfig
arc                     nsimosci_hs_defconfig
sh                        dreamcast_defconfig
arm                            xcep_defconfig
powerpc                     mpc83xx_defconfig
powerpc                      ep88xc_defconfig
arm                      footbridge_defconfig
powerpc                     ep8248e_defconfig
arc                        nsimosci_defconfig
sh                             shx3_defconfig
mips                      loongson3_defconfig
xtensa                       common_defconfig
mips                            gpr_defconfig
sh                          lboxre2_defconfig
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
i386                             allyesconfig
i386                                defconfig
x86_64                        randconfig-a006
x86_64                        randconfig-a004
x86_64                        randconfig-a002
x86_64               randconfig-a014-20220718
x86_64               randconfig-a016-20220718
x86_64               randconfig-a012-20220718
x86_64               randconfig-a013-20220718
x86_64               randconfig-a015-20220718
x86_64               randconfig-a011-20220718
i386                 randconfig-a015-20220718
i386                 randconfig-a011-20220718
i386                 randconfig-a012-20220718
i386                 randconfig-a014-20220718
i386                 randconfig-a016-20220718
i386                 randconfig-a013-20220718
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
s390                 randconfig-r044-20220718
riscv                randconfig-r042-20220718
arc                  randconfig-r043-20220718
x86_64                    rhel-8.3-kselftests
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                              defconfig
x86_64                           allyesconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit

clang tested configs:
arm                     am200epdkit_defconfig
riscv                            alldefconfig
arm                        magician_defconfig
powerpc                 mpc832x_rdb_defconfig
arm                          pcm027_defconfig
mips                          malta_defconfig
hexagon                          alldefconfig
powerpc                    gamecube_defconfig
mips                      maltaaprp_defconfig
mips                        maltaup_defconfig
powerpc                     mpc5200_defconfig
mips                          ath25_defconfig
x86_64                        randconfig-k001
x86_64                        randconfig-a005
x86_64                        randconfig-a003
x86_64                        randconfig-a001
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
i386                 randconfig-a004-20220718
i386                 randconfig-a001-20220718
i386                 randconfig-a005-20220718
i386                 randconfig-a006-20220718
i386                 randconfig-a002-20220718
i386                 randconfig-a003-20220718

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
