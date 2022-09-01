Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B30F5A8E90
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 08:46:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233264AbiIAGp6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 02:45:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233131AbiIAGpz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 02:45:55 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1484B07E5
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 23:45:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662014753; x=1693550753;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=hsMNK9xOjMb0hqIOQK4CsGKdCYUrUueFT0rtmIk9Wu8=;
  b=mnuKmpukwbFCGEce8JrYpdmqAHkn3YXBpKszueLCk2e7mH2KXRq9wDhA
   gn1gOZuUnZeZU8w4+nQ1Qk4NvsBCNH+KD3svqFloNpShS6qAIhAH00dMl
   EYDorwmfSps65CoFiuRfWKIbJkFN0McOINDqmSaT5hFuq+TN7gBt+gmjx
   PdCAVeS4j2gm2lLAcnHzoL8k+zfmxN7QX17BGYGvA2BClnlfgRscF2Xiy
   nZBs2seoJq2unB83Q8jZBPp9vxTB477dhpVb29nOSbWbPODiiqKAELZS8
   f8Z77kqZMO7sOrSztZB6dpNYwkj5m/UVCaDjLDmUCx9z4TZaHz8p5EuHd
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10456"; a="295636767"
X-IronPort-AV: E=Sophos;i="5.93,280,1654585200"; 
   d="scan'208";a="295636767"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2022 23:45:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,280,1654585200"; 
   d="scan'208";a="857720236"
Received: from lkp-server02.sh.intel.com (HELO 811e2ceaf0e5) ([10.239.97.151])
  by fmsmga006.fm.intel.com with ESMTP; 31 Aug 2022 23:45:52 -0700
Received: from kbuild by 811e2ceaf0e5 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oTdxX-0001Ee-2e;
        Thu, 01 Sep 2022 06:45:51 +0000
Date:   Thu, 01 Sep 2022 14:45:04 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/cache] BUILD SUCCESS
 499c8bb4693d1c8d8f3d6dd38e5bdde3ff5bd906
Message-ID: <631054f0.Eomc2+KRxYcLIKpK%lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/cache
branch HEAD: 499c8bb4693d1c8d8f3d6dd38e5bdde3ff5bd906  x86/resctrl: Fix to restore to original value when re-enabling hardware prefetch register

elapsed time: 720m

configs tested: 87
configs skipped: 87

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                           allyesconfig
i386                                defconfig
x86_64                        randconfig-a013
x86_64                        randconfig-a011
x86_64                        randconfig-a015
i386                             allyesconfig
x86_64                        randconfig-a002
x86_64                          rhel-8.3-func
x86_64                         rhel-8.3-kunit
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                           rhel-8.3-kvm
x86_64                        randconfig-a004
x86_64                    rhel-8.3-kselftests
x86_64                           rhel-8.3-syz
x86_64                        randconfig-a006
powerpc                           allnoconfig
mips                             allyesconfig
powerpc                          allmodconfig
sh                               allmodconfig
m68k                             allyesconfig
m68k                             allmodconfig
arc                              allyesconfig
alpha                            allyesconfig
csky                              allnoconfig
arc                               allnoconfig
riscv                             allnoconfig
arm64                            allyesconfig
arm                                 defconfig
arm                              allyesconfig
arc                        nsim_700_defconfig
parisc                generic-32bit_defconfig
riscv             nommu_k210_sdcard_defconfig
sh                          lboxre2_defconfig
xtensa                         virt_defconfig
powerpc                        warp_defconfig
arm                        multi_v7_defconfig
arm64                            alldefconfig
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
i386                          randconfig-c001
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
s390                 randconfig-r044-20220831
arc                  randconfig-r043-20220831
riscv                randconfig-r042-20220831
sh                   sh7724_generic_defconfig
sparc                       sparc32_defconfig
sh                          rsk7203_defconfig
sh                               alldefconfig
arc                           tb10x_defconfig
arm                       multi_v4t_defconfig
parisc64                            defconfig
powerpc                      cm5200_defconfig
powerpc                      pcm030_defconfig
sh                   rts7751r2dplus_defconfig
powerpc                     rainier_defconfig
arm                      jornada720_defconfig
alpha                             allnoconfig
mips                         cobalt_defconfig
mips                           xway_defconfig
i386                          debian-10.3-kvm
i386                        debian-10.3-kunit
i386                         debian-10.3-func

clang tested configs:
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
x86_64                        randconfig-a001
x86_64                        randconfig-a003
x86_64                        randconfig-a005
powerpc                          allyesconfig
hexagon              randconfig-r045-20220831
hexagon              randconfig-r041-20220831
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
powerpc                     tqm8560_defconfig
powerpc                 xes_mpc85xx_defconfig
arm                         socfpga_defconfig
arm                        vexpress_defconfig
x86_64                        randconfig-k001

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
