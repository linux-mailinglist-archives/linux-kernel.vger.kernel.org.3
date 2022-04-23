Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3C4850CBBC
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Apr 2022 17:24:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233280AbiDWP1H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Apr 2022 11:27:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232983AbiDWP1C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Apr 2022 11:27:02 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30D5B34B98
        for <linux-kernel@vger.kernel.org>; Sat, 23 Apr 2022 08:24:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650727445; x=1682263445;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=5KVGirb0yOM5x2FAxEWiWPezDotCYaNdCx2veTtscjk=;
  b=YBO7DkolUE7cPScwVYAiHqZtW6om0+HlclM4b4RA3zoVpSQjJc4SaDJP
   xYcMbevPT1AO4XSOCmwaP0WFHqwOBMYt8YXoyw6z1f0QLBTrFGTBRJeWx
   iEA4Ysb30zlJh1JFyTL6P1N6E3PqGIzL+HWb4Fw2yaalUJgiBdB0+UONO
   CsL33MCu29IAeB0rs8pvZrTADpqK+AoQdSA1hk0ZVVlMLBpB4IL+4Dodn
   iQcg28G7ihibjAfluFrSYZx+XiSU6vNaxEqRNXXJsUKDst6gUxNLnKK3j
   pBoPCRzMjpjQ/EPcl5wxfRCAhvLyeMUbInLr1WPqmr5issyIpTMaI5UrE
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10326"; a="327825844"
X-IronPort-AV: E=Sophos;i="5.90,284,1643702400"; 
   d="scan'208";a="327825844"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2022 08:24:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,284,1643702400"; 
   d="scan'208";a="594570622"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 23 Apr 2022 08:24:02 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1niHcA-00009d-24;
        Sat, 23 Apr 2022 15:24:02 +0000
Date:   Sat, 23 Apr 2022 23:23:28 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:master] BUILD SUCCESS
 1912a07f8a0551583be3716532b01e6f224f06db
Message-ID: <626419f0.MQZeL2bjyun19/DK%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git master
branch HEAD: 1912a07f8a0551583be3716532b01e6f224f06db  Merge branch into tip/master: 'locking/urgent'

elapsed time: 1800m

configs tested: 107
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm64                               defconfig
arm64                            allyesconfig
arm                              allmodconfig
arm                                 defconfig
arm                              allyesconfig
i386                          randconfig-c001
sh                ecovec24-romimage_defconfig
xtensa                    smp_lx200_defconfig
powerpc                    sam440ep_defconfig
powerpc                        cell_defconfig
openrisc                 simple_smp_defconfig
powerpc                       ppc64_defconfig
sh                               alldefconfig
m68k                        m5407c3_defconfig
m68k                          atari_defconfig
sh                          rsk7203_defconfig
ia64                         bigsur_defconfig
arm                           sama5_defconfig
sh                        apsh4ad0a_defconfig
m68k                             allyesconfig
sh                           se7705_defconfig
microblaze                          defconfig
mips                        bcm47xx_defconfig
powerpc                      arches_defconfig
xtensa                  cadence_csp_defconfig
x86_64                        randconfig-c001
arm                  randconfig-c002-20220422
ia64                                defconfig
ia64                             allmodconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
alpha                               defconfig
csky                                defconfig
nios2                            allyesconfig
alpha                            allyesconfig
h8300                            allyesconfig
xtensa                           allyesconfig
arc                                 defconfig
sh                               allmodconfig
parisc                              defconfig
parisc64                            defconfig
s390                             allmodconfig
parisc                           allyesconfig
s390                                defconfig
s390                             allyesconfig
sparc                               defconfig
i386                             allyesconfig
sparc                            allyesconfig
i386                                defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
nios2                               defconfig
arc                              allyesconfig
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
x86_64                        randconfig-a002
i386                          randconfig-a014
i386                          randconfig-a012
i386                          randconfig-a016
arc                  randconfig-r043-20220422
riscv                               defconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
riscv                             allnoconfig
riscv                            allmodconfig
riscv                            allyesconfig
x86_64                    rhel-8.3-kselftests
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                          rhel-8.3-func
x86_64                                  kexec
x86_64                              defconfig
x86_64                           allyesconfig
x86_64                         rhel-8.3-kunit
x86_64                               rhel-8.3

clang tested configs:
mips                           ip27_defconfig
arm                      tct_hammer_defconfig
powerpc                 mpc836x_mds_defconfig
arm                          ep93xx_defconfig
powerpc                    gamecube_defconfig
arm                              alldefconfig
i386                          randconfig-a002
i386                          randconfig-a004
i386                          randconfig-a006
x86_64                        randconfig-a012
x86_64                        randconfig-a016
x86_64                        randconfig-a014
x86_64                        randconfig-a001
x86_64                        randconfig-a003
i386                          randconfig-a013
i386                          randconfig-a011
i386                          randconfig-a015
hexagon              randconfig-r041-20220422
hexagon              randconfig-r045-20220422
riscv                randconfig-r042-20220422
s390                 randconfig-r044-20220422

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
