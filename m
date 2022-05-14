Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 312A35270D3
	for <lists+linux-kernel@lfdr.de>; Sat, 14 May 2022 13:31:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231361AbiENLbP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 May 2022 07:31:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230266AbiENLbN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 May 2022 07:31:13 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE4621BB
        for <linux-kernel@vger.kernel.org>; Sat, 14 May 2022 04:31:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652527871; x=1684063871;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=61UHzhnvKzWsc1eNzr9n4hW4DuV/qX/pbkM2NmWEp3g=;
  b=EZ6m2F3gKu8we3v7YXtB3txYyKRkKINfnmMasYpfzEF0vGcug/hWbGKg
   AuWlpKb8N2oUsmbUJQGC1oy+sjzIozvU6q2uv3M32bgGkX7FzIxvjQvts
   M8z+v4jfmEkPunFOvW5GHjhBaaqFEZt1L36O7aIOabLiUYSNUsP3PivYz
   rWxNJeU/rLmyh9zNY6NE5wjBRzQChLbn7+SVNoOMFam7FEhSITmgJBzSd
   r84rf1hVCl1LZafzcEyDEXi91hEcNauddGKbMPOsKgztsS1zUeeDZaExg
   0+AdFqFnQt/P16284Tdcgf0FqEAcabL+otON+8fghBReRFpTKNSsZ+Df+
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10346"; a="268088230"
X-IronPort-AV: E=Sophos;i="5.91,226,1647327600"; 
   d="scan'208";a="268088230"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2022 04:31:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,226,1647327600"; 
   d="scan'208";a="554565785"
Received: from lkp-server01.sh.intel.com (HELO d1462bc4b09b) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 14 May 2022 04:31:09 -0700
Received: from kbuild by d1462bc4b09b with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nppzI-0000ZQ-17;
        Sat, 14 May 2022 11:31:08 +0000
Date:   Sat, 14 May 2022 19:30:55 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: [gustavoars:for-next/kspp] BUILD SUCCESS
 0cf2b91d74b7ec0e971dcd00de875e2d04b56350
Message-ID: <627f92ef.upN0G+bCpHComWxr%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git for-next/kspp
branch HEAD: 0cf2b91d74b7ec0e971dcd00de875e2d04b56350  Merge branch 'for-next/kspp-stringop-overflow' into for-next/kspp

elapsed time: 13884m

configs tested: 153
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                              allmodconfig
arm                                 defconfig
arm                              allyesconfig
arm64                               defconfig
arm64                            allyesconfig
i386                          randconfig-c001
mips                 randconfig-c004-20220505
powerpc                     ep8248e_defconfig
nios2                            allyesconfig
arm                     eseries_pxa_defconfig
sh                           se7780_defconfig
powerpc                     pq2fads_defconfig
m68k                          hp300_defconfig
ia64                          tiger_defconfig
m68k                          atari_defconfig
powerpc                           allnoconfig
powerpc                     tqm8555_defconfig
mips                        bcm47xx_defconfig
sh                        apsh4ad0a_defconfig
arm                        keystone_defconfig
i386                                defconfig
mips                         rt305x_defconfig
alpha                            alldefconfig
xtensa                  cadence_csp_defconfig
m68k                          multi_defconfig
arm                         lpc18xx_defconfig
parisc64                            defconfig
powerpc                    klondike_defconfig
sh                 kfr2r09-romimage_defconfig
powerpc                      cm5200_defconfig
arm                         nhk8815_defconfig
sh                          rsk7269_defconfig
xtensa                    xip_kc705_defconfig
parisc                              defconfig
sh                        sh7757lcr_defconfig
sh                             shx3_defconfig
powerpc                      chrp32_defconfig
sh                         ap325rxa_defconfig
sh                                  defconfig
powerpc                mpc7448_hpc2_defconfig
arm                         at91_dt_defconfig
m68k                             alldefconfig
arm                            qcom_defconfig
arm                           imxrt_defconfig
mips                           gcw0_defconfig
mips                          rb532_defconfig
sh                             sh03_defconfig
powerpc64                           defconfig
sh                               j2_defconfig
x86_64                        randconfig-c001
arm                  randconfig-c002-20220501
arm                  randconfig-c002-20220505
arm                  randconfig-c002-20220506
ia64                                defconfig
ia64                             allmodconfig
ia64                             allyesconfig
m68k                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
nios2                               defconfig
arc                              allyesconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
h8300                            allyesconfig
xtensa                           allyesconfig
arc                                 defconfig
sh                               allmodconfig
s390                                defconfig
s390                             allmodconfig
parisc                           allyesconfig
s390                             allyesconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
x86_64                        randconfig-a006
x86_64                        randconfig-a004
x86_64                        randconfig-a002
i386                 randconfig-a004-20220502
i386                 randconfig-a006-20220502
i386                 randconfig-a002-20220502
i386                 randconfig-a003-20220502
i386                 randconfig-a001-20220502
i386                 randconfig-a005-20220502
i386                          randconfig-a001
i386                          randconfig-a003
i386                          randconfig-a005
x86_64                        randconfig-a015
x86_64                        randconfig-a013
x86_64                        randconfig-a011
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
arc                  randconfig-r043-20220505
s390                 randconfig-r044-20220505
riscv                randconfig-r042-20220505
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
x86_64                          rhel-8.3-func
x86_64                           rhel-8.3-syz
x86_64                                  kexec
x86_64                              defconfig
x86_64                           allyesconfig
x86_64                         rhel-8.3-kunit
x86_64                               rhel-8.3

clang tested configs:
x86_64                        randconfig-c007
i386                          randconfig-c001
powerpc              randconfig-c003-20220505
riscv                randconfig-c006-20220505
arm                  randconfig-c002-20220505
arm                         palmz72_defconfig
powerpc                    mvme5100_defconfig
powerpc                          g5_defconfig
arm                          ep93xx_defconfig
mips                      maltaaprp_defconfig
powerpc                 mpc836x_rdk_defconfig
arm                       mainstone_defconfig
powerpc                 mpc832x_rdb_defconfig
powerpc               mpc834x_itxgp_defconfig
arm                            dove_defconfig
arm                      pxa255-idp_defconfig
mips                     cu1000-neo_defconfig
mips                           mtx1_defconfig
mips                      bmips_stb_defconfig
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
hexagon              randconfig-r045-20220501
hexagon              randconfig-r041-20220501
hexagon              randconfig-r045-20220502
riscv                randconfig-r042-20220502
hexagon              randconfig-r041-20220502

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
