Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C4CB4E479A
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 21:34:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234007AbiCVUgC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 16:36:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233967AbiCVUgB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 16:36:01 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D95024583
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 13:34:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647981273; x=1679517273;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=F68gsgzQ6q45gRjwkymW50Bm3d+yzytyo4dB8GvA06U=;
  b=DqNcGiobyqniORHIKwIGO1ua4EGLFcHbAU3Uv0KmfR9zkiX9KQ1S1Cp2
   O/lC31FzcnqrgGb3o2lQtlKO0EGCAFgbMCWVfZdI08FCHlMe172pPgDis
   KIyZ6VD/W2Jx2zmqVJegEs+aaV8qZi9AQWyZQukxS3nSmZL80tUp/lLqY
   gmA3Dvx680g7b2euDfPyc8FB6EMYeyTNnV+gx4O3k7fgCrwaLY1QOs0tP
   MLOr64ZKlbyMCNH4d9+D2KP7bZaEc6aa4muY8Q3BwXSMkpZPTiDEbv9Pq
   /DOuVS2tCmc0sarX+ARgnt6GEPpzQVbU/DU+UrMdvvd/vr1OmMQnni2B6
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10294"; a="255505346"
X-IronPort-AV: E=Sophos;i="5.90,202,1643702400"; 
   d="scan'208";a="255505346"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2022 13:34:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,202,1643702400"; 
   d="scan'208";a="717114193"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 22 Mar 2022 13:34:31 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nWlD4-000JGW-Rb; Tue, 22 Mar 2022 20:34:30 +0000
Date:   Wed, 23 Mar 2022 04:33:31 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:master] BUILD SUCCESS
 d40396b363c081b032670eb84965a6922f57742a
Message-ID: <623a329b.U1zab4RHIQDyc9T0%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git master
branch HEAD: d40396b363c081b032670eb84965a6922f57742a  Merge branch into tip/master: 'sched/core'

elapsed time: 724m

configs tested: 121
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
i386                          randconfig-c001
m68k                             alldefconfig
riscv                    nommu_k210_defconfig
arc                        vdk_hs38_defconfig
m68k                         apollo_defconfig
m68k                       m5475evb_defconfig
ia64                             allmodconfig
nios2                               defconfig
arm                             pxa_defconfig
arc                           tb10x_defconfig
parisc64                            defconfig
m68k                            mac_defconfig
powerpc                 mpc837x_rdb_defconfig
sh                           se7712_defconfig
xtensa                  cadence_csp_defconfig
sparc                       sparc64_defconfig
powerpc                 mpc834x_itx_defconfig
sh                             sh03_defconfig
powerpc                     rainier_defconfig
arm                         vf610m4_defconfig
sh                        edosk7705_defconfig
mips                           ci20_defconfig
m68k                        mvme147_defconfig
arm                            hisi_defconfig
nds32                               defconfig
arm                  randconfig-c002-20220321
arm                  randconfig-c002-20220320
ia64                                defconfig
ia64                             allyesconfig
m68k                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
nios2                            allyesconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
xtensa                           allyesconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
parisc                              defconfig
s390                             allyesconfig
s390                             allmodconfig
parisc                           allyesconfig
s390                                defconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
arc                              allyesconfig
nds32                             allnoconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a016-20220321
x86_64               randconfig-a011-20220321
x86_64               randconfig-a012-20220321
x86_64               randconfig-a013-20220321
x86_64               randconfig-a014-20220321
x86_64               randconfig-a015-20220321
i386                 randconfig-a014-20220321
i386                 randconfig-a013-20220321
i386                 randconfig-a016-20220321
i386                 randconfig-a015-20220321
i386                 randconfig-a011-20220321
i386                 randconfig-a012-20220321
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                    rhel-8.3-kselftests
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                           allyesconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                         rhel-8.3-kunit
x86_64                                  kexec

clang tested configs:
x86_64                        randconfig-c007
mips                 randconfig-c004-20220320
arm                  randconfig-c002-20220320
powerpc              randconfig-c003-20220320
riscv                randconfig-c006-20220320
i386                          randconfig-c001
arm                  randconfig-c002-20220322
powerpc              randconfig-c003-20220322
riscv                randconfig-c006-20220322
arm                     am200epdkit_defconfig
arm                        spear3xx_defconfig
mips                         tb0287_defconfig
powerpc                 mpc832x_rdb_defconfig
powerpc                     tqm8540_defconfig
mips                       lemote2f_defconfig
mips                        omega2p_defconfig
i386                 randconfig-a001-20220321
i386                 randconfig-a006-20220321
i386                 randconfig-a003-20220321
i386                 randconfig-a005-20220321
i386                 randconfig-a004-20220321
i386                 randconfig-a002-20220321
x86_64               randconfig-a003-20220321
x86_64               randconfig-a001-20220321
x86_64               randconfig-a002-20220321
x86_64               randconfig-a004-20220321
x86_64               randconfig-a005-20220321
x86_64               randconfig-a006-20220321
riscv                randconfig-r042-20220320
hexagon              randconfig-r045-20220321
hexagon              randconfig-r045-20220320
hexagon              randconfig-r041-20220321
hexagon              randconfig-r041-20220320

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
