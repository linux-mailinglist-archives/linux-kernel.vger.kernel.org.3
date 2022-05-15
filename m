Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E990B527882
	for <lists+linux-kernel@lfdr.de>; Sun, 15 May 2022 17:38:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237426AbiEOPiQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 May 2022 11:38:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237437AbiEOPiL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 May 2022 11:38:11 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6D0E10FC1
        for <linux-kernel@vger.kernel.org>; Sun, 15 May 2022 08:38:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652629090; x=1684165090;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=B4NepS6EiGVB7+m8iOkyRoeM3XVAlOweIND0hX1xnBo=;
  b=mj2hQb4YfZMvmUncqeKPcin9Yj0vat/L6QZQclA2Am8lpJFtIglXFfQ1
   AI97hF+RxE/WMURI+RUT/G6xMbz05rzxnaBjyS/nOr0VTr4hevugh4OP0
   TZOPXcT90ylVUc1mZfuMzp9EpjCG2LMI6EAAA1OBxC2cgCUbLVjun7AHM
   PxFBPdFltBXH0/KfH4ddJ42QbK0Y/5EZlEYA+esMIHRuwRz/ojs8KRinq
   +/3ZBKn8w7BldGwpufsrt4Y9e11X7v0G7WBUDRz7034odpVvZZTbhf1lf
   8nJU91DJFJk1xOpeRBKgVJgQ/BbLaXyjkBbKL9DrAZ0IM17inRdXF1fy9
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10348"; a="270769132"
X-IronPort-AV: E=Sophos;i="5.91,228,1647327600"; 
   d="scan'208";a="270769132"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2022 08:38:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,228,1647327600"; 
   d="scan'208";a="625589196"
Received: from lkp-server01.sh.intel.com (HELO d1462bc4b09b) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 15 May 2022 08:38:09 -0700
Received: from kbuild by d1462bc4b09b with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nqGJs-0001kj-D4;
        Sun, 15 May 2022 15:38:08 +0000
Date:   Sun, 15 May 2022 23:37:14 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:master] BUILD SUCCESS
 040a86b40a08c76e9fb6783c2646090e1c6c560e
Message-ID: <62811e2a.z9TvZNOdy52QTGN4%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git master
branch HEAD: 040a86b40a08c76e9fb6783c2646090e1c6c560e  Merge branch into tip/master: 'x86/vdso'

elapsed time: 4657m

configs tested: 105
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                              allmodconfig
arm                              allyesconfig
arm                                 defconfig
arm64                               defconfig
arm64                            allyesconfig
i386                          randconfig-c001
h8300                     edosk2674_defconfig
mips                        bcm47xx_defconfig
arm                            hisi_defconfig
sh                      rts7751r2d1_defconfig
sh                              ul2_defconfig
sh                           se7712_defconfig
arc                            hsdk_defconfig
csky                             alldefconfig
arm                         nhk8815_defconfig
xtensa                          iss_defconfig
sh                        sh7763rdp_defconfig
powerpc                     stx_gp3_defconfig
arm                  randconfig-c002-20220512
x86_64                        randconfig-c001
ia64                                defconfig
ia64                             allmodconfig
ia64                             allyesconfig
m68k                                defconfig
m68k                             allyesconfig
m68k                             allmodconfig
alpha                               defconfig
csky                                defconfig
nios2                            allyesconfig
alpha                            allyesconfig
nios2                               defconfig
arc                              allyesconfig
sh                               allmodconfig
arc                                 defconfig
h8300                            allyesconfig
xtensa                           allyesconfig
parisc                              defconfig
s390                             allmodconfig
parisc64                            defconfig
parisc                           allyesconfig
s390                                defconfig
s390                             allyesconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
i386                                defconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                           allnoconfig
powerpc                          allmodconfig
x86_64                        randconfig-a004
x86_64                        randconfig-a002
x86_64                        randconfig-a006
i386                          randconfig-a001
i386                          randconfig-a003
i386                          randconfig-a005
x86_64                        randconfig-a013
x86_64                        randconfig-a011
x86_64                        randconfig-a015
i386                          randconfig-a014
i386                          randconfig-a012
i386                          randconfig-a016
arc                  randconfig-r043-20220512
riscv                randconfig-r042-20220512
s390                 randconfig-r044-20220512
riscv                             allnoconfig
riscv                            allyesconfig
riscv                            allmodconfig
riscv                    nommu_k210_defconfig
riscv                          rv32_defconfig
riscv                    nommu_virt_defconfig
riscv                               defconfig
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                              defconfig
x86_64                           allyesconfig
x86_64                    rhel-8.3-kselftests
x86_64                                  kexec
x86_64                          rhel-8.3-func
x86_64                               rhel-8.3
x86_64                         rhel-8.3-kunit
x86_64                           rhel-8.3-syz

clang tested configs:
arm                  colibri_pxa270_defconfig
arm                        magician_defconfig
arm                      pxa255-idp_defconfig
mips                           rs90_defconfig
x86_64                           allyesconfig
powerpc                   bluestone_defconfig
powerpc                     tqm5200_defconfig
x86_64                        randconfig-a001
x86_64                        randconfig-a003
x86_64                        randconfig-a005
i386                          randconfig-a002
i386                          randconfig-a004
i386                          randconfig-a006
x86_64                        randconfig-a012
x86_64                        randconfig-a016
x86_64                        randconfig-a014
i386                          randconfig-a013
i386                          randconfig-a011
i386                          randconfig-a015
hexagon              randconfig-r041-20220512
hexagon              randconfig-r045-20220512

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
