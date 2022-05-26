Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30DE453486D
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 03:55:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344930AbiEZBzm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 21:55:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345843AbiEZBz2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 21:55:28 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BB21B41C3
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 18:55:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653530127; x=1685066127;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=P/NghkjHpuPIcqeLRTKNCAEhE3en/f+6JiG9RCqPuNA=;
  b=IM2cNeHFde66bNO6pFR/CTSleRxICn+6/QGzPiNn6Fgg3MP4fydS6hPW
   abMb5ShwEdc7BLrmVqoO/1g4qLEkmPJVZEhwmgwp2Iw1xqIRs1YzPQvDY
   2OEgDksG6VX90nI5rCX97qAVXUutbtv6UjyraLOeeChCzcX4qDm0FWRRC
   ajyEq1Okg8WGAOHBk7OOsRI5LZaayZfLzLIT8LKBIBbI25tQ6Dx0t3Ltr
   G4MgcSlDkkfEojFqgVA38UacYrRsnjHYMaKea2Woc+gAhUm9rcD7JZxmP
   xidd+dIGMcDM3jwc6NOKtmG3QyJ2UPodf23tlJBij6gaqqzvFwqv2liOk
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10358"; a="299330289"
X-IronPort-AV: E=Sophos;i="5.91,252,1647327600"; 
   d="scan'208";a="299330289"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 May 2022 18:55:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,252,1647327600"; 
   d="scan'208";a="630646675"
Received: from lkp-server01.sh.intel.com (HELO db63a1be7222) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 25 May 2022 18:55:25 -0700
Received: from kbuild by db63a1be7222 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nu2ij-0003Um-5u;
        Thu, 26 May 2022 01:55:25 +0000
Date:   Thu, 26 May 2022 09:54:24 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/boot] BUILD SUCCESS
 8a33d96bd178d5f49cc5c1898e4cda08e221d2db
Message-ID: <628eddd0.0wll48G8zTQ7fYDx%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/boot
branch HEAD: 8a33d96bd178d5f49cc5c1898e4cda08e221d2db  x86/setup: Use strscpy() to replace deprecated strlcpy()

elapsed time: 723m

configs tested: 81
configs skipped: 65

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm64                               defconfig
arm64                            allyesconfig
arm                              allmodconfig
arm                                 defconfig
arm                              allyesconfig
sh                              ul2_defconfig
m68k                            mac_defconfig
sh                         apsh4a3a_defconfig
nios2                               defconfig
sh                         ecovec24_defconfig
sh                           se7712_defconfig
arm                           h3600_defconfig
sh                          rsk7201_defconfig
powerpc                 mpc834x_mds_defconfig
m68k                           sun3_defconfig
powerpc                 mpc85xx_cds_defconfig
ia64                                defconfig
m68k                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
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
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
arc                  randconfig-r043-20220524
s390                 randconfig-r044-20220524
riscv                randconfig-r042-20220524
riscv                               defconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
riscv                             allnoconfig
riscv                            allmodconfig
riscv                            allyesconfig
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                                  kexec
x86_64                              defconfig
x86_64                           allyesconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                           rhel-8.3-syz
x86_64                    rhel-8.3-kselftests
x86_64                         rhel-8.3-kunit

clang tested configs:
x86_64                        randconfig-a005
x86_64                        randconfig-a003
x86_64                        randconfig-a001
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
