Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CABF64EFF16
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Apr 2022 08:00:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237647AbiDBGCa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Apr 2022 02:02:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229714AbiDBGC3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Apr 2022 02:02:29 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E74322B26
        for <linux-kernel@vger.kernel.org>; Fri,  1 Apr 2022 23:00:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648879238; x=1680415238;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=h66IEmC+IQhgkQLN4MG83YwdDJDQ6InnucekNA33FHw=;
  b=IO8kWu25k2MarqWyL8knigtuv6Ikj/Ao1kzs/BsnHK3T/3OKoK8pYoSo
   n7d+WDYqwnDMkq8ncEJhnDiFX+jUPl+fwAhZIDcDew3z6iDP/YL2on9hg
   oHKtCzPgONGdI7vJpAvZM+/46lchxqBIuR//dubvb/zKJ+Mg2Q/dj/oVk
   CCoMAZeDbZ8NSCX7Y8aYUpAjg/L3fw4ieLE4/5TKXNKvJk6jub4vJhVTZ
   zpmmleW+B0qgzCI7bzeJp4SDNfuFbH6uubGk4M8fqxB/uTqa2eSOmGilu
   QZoYSWBMXYo50yfKomjlG47KRbtw2XpIVmbSEGWHmhbz+p+Y5JyxCy4KM
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10304"; a="259108495"
X-IronPort-AV: E=Sophos;i="5.90,229,1643702400"; 
   d="scan'208";a="259108495"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2022 23:00:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,229,1643702400"; 
   d="scan'208";a="640750862"
Received: from lkp-server02.sh.intel.com (HELO 3231c491b0e2) ([10.239.97.151])
  by FMSMGA003.fm.intel.com with ESMTP; 01 Apr 2022 23:00:36 -0700
Received: from kbuild by 3231c491b0e2 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1naWoO-0001mT-4l;
        Sat, 02 Apr 2022 06:00:36 +0000
Date:   Sat, 02 Apr 2022 13:59:54 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:korg-tip/x86/cleanups] BUILD SUCCESS
 efb24842efcf80da8352de7c40eeacb06e583140
Message-ID: <6247e65a.a94pffRF1D00xDOx%lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git korg-tip/x86/cleanups
branch HEAD: efb24842efcf80da8352de7c40eeacb06e583140  x86/pkeys: Remove __arch_set_user_pkey_access() declaration

elapsed time: 721m

configs tested: 87
configs skipped: 90

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
i386                          randconfig-c001
m68k                        m5407c3_defconfig
arm                          pxa3xx_defconfig
microblaze                      mmu_defconfig
arm                             pxa_defconfig
arm                          simpad_defconfig
mips                  decstation_64_defconfig
arm                            qcom_defconfig
sh                            hp6xx_defconfig
powerpc                 mpc834x_mds_defconfig
x86_64                        randconfig-c001
arm                  randconfig-c002-20220331
arm                  randconfig-c002-20220402
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
nios2                               defconfig
arc                              allyesconfig
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
i386                          randconfig-a001
i386                          randconfig-a003
i386                          randconfig-a005
x86_64                        randconfig-a013
x86_64                        randconfig-a011
x86_64                        randconfig-a015
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
x86_64                        randconfig-a004
x86_64                        randconfig-a002
x86_64                        randconfig-a006
arc                  randconfig-r043-20220402
s390                 randconfig-r044-20220402
riscv                randconfig-r042-20220402
riscv                               defconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
riscv                             allnoconfig
riscv                            allmodconfig
riscv                            allyesconfig
x86_64                    rhel-8.3-kselftests
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                         rhel-8.3-kunit
x86_64                          rhel-8.3-func
x86_64                              defconfig
x86_64                           allyesconfig
x86_64                                  kexec
x86_64                               rhel-8.3

clang tested configs:
powerpc                     mpc512x_defconfig
arm                           spitz_defconfig
x86_64                        randconfig-a005
x86_64                        randconfig-a003
x86_64                        randconfig-a001
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
i386                          randconfig-a013
i386                          randconfig-a011
i386                          randconfig-a015

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
