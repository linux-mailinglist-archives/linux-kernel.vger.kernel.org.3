Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50F015A5CA4
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 09:14:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230384AbiH3HN6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 03:13:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230105AbiH3HNz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 03:13:55 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1729B07D4
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 00:13:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661843634; x=1693379634;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=bli/F0sDqx/thbvZebaAGrAGHblAq/sJXziiT4syM2A=;
  b=NZJvEHn97vtN9xrFQpMBKZrtN0ORgM4bcitr4l8ZYYILrRJ9w4cIDPqt
   5ffo+i/+NhoRcsnZEPmf3CxxuwnNnffobLT9hHeLgp73pivII/WXn57zH
   xF6AElriJRunCCGmSnApRLqE0a/nxutkZJv/HN/YTsZHJFNm1ZEQTtU8w
   vbJszAIt74bGpCu0mphegyUYsjR8C+KPfGqOzmOZVeqUUK3xYrhA9ue0L
   q0bJU489kunWj2c7eO2+ObisJ4RYz2mV/HTcFWC97QrL/6jQNqhsw5wz/
   b8d16ROdEj3E3Ig+SDSfeAs/8iGi45kbVAE/annk0P1WcUJ231liPOEe3
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10454"; a="381399687"
X-IronPort-AV: E=Sophos;i="5.93,274,1654585200"; 
   d="scan'208";a="381399687"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2022 00:13:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,274,1654585200"; 
   d="scan'208";a="644727555"
Received: from lkp-server02.sh.intel.com (HELO 77b6d4e16fc5) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 30 Aug 2022 00:13:53 -0700
Received: from kbuild by 77b6d4e16fc5 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oSvRY-00001a-1P;
        Tue, 30 Aug 2022 07:13:52 +0000
Date:   Tue, 30 Aug 2022 15:13:42 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: [gustavoars:testing/6.0-rc2-GCC13-fsfa] BUILD REGRESSION
 74417dafb835bd882b504cfbca9de9d936d7ad40
Message-ID: <630db8a6.1ywhzvFfQEqXTTrH%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git testing/6.0-rc2-GCC13-fsfa
branch HEAD: 74417dafb835bd882b504cfbca9de9d936d7ad40  Makefile: Testing GCC-13 and -fstrict-flex-arrays=3

Error/Warning: (recently discovered and may have been fixed)

aarch64-linux-gcc: error: unrecognized command-line option '-fstrict-flex-arrays=3'
alpha-linux-gcc: error: unrecognized command-line option '-fstrict-flex-arrays=3'
arc-elf-gcc: error: unrecognized command-line option '-fstrict-flex-arrays=3'
arceb-elf-gcc: error: unrecognized command-line option '-fstrict-flex-arrays=3'
csky-linux-gcc: error: unrecognized command-line option '-fstrict-flex-arrays=3'
gcc-11: error: unrecognized command-line option '-fstrict-flex-arrays=3'
hppa-linux-gcc: error: unrecognized command-line option '-fstrict-flex-arrays=3'
hppa64-linux-gcc: error: unrecognized command-line option '-fstrict-flex-arrays=3'
loongarch64-linux-gcc: error: unrecognized command-line option '-fstrict-flex-arrays=3'
microblaze-linux-gcc: error: unrecognized command-line option '-fstrict-flex-arrays=3'
mips64el-linux-gcc: error: unrecognized command-line option '-fstrict-flex-arrays=3'
mipsel-linux-gcc: error: unrecognized command-line option '-fstrict-flex-arrays=3'
nios2-linux-gcc: error: unrecognized command-line option '-fstrict-flex-arrays=3'
powerpc-linux-gcc: error: unrecognized command-line option '-fstrict-flex-arrays=3'
riscv32-linux-gcc: error: unrecognized command-line option '-fstrict-flex-arrays=3'
sh4-linux-gcc: error: unrecognized command-line option '-fstrict-flex-arrays=3'
sparc64-linux-gcc: error: unrecognized command-line option '-fstrict-flex-arrays=3'

Error/Warning ids grouped by kconfigs:

gcc_recent_errors
|-- alpha-allyesconfig
|   `-- alpha-linux-gcc:error:unrecognized-command-line-option-fstrict-flex-arrays
|-- arc-allnoconfig
|   `-- arc-elf-gcc:error:unrecognized-command-line-option-fstrict-flex-arrays
|-- arc-allyesconfig
|   `-- arceb-elf-gcc:error:unrecognized-command-line-option-fstrict-flex-arrays
|-- arc-buildonly-randconfig-r002-20220829
|   `-- arc-elf-gcc:error:unrecognized-command-line-option-fstrict-flex-arrays
|-- arc-defconfig
|   `-- arc-elf-gcc:error:unrecognized-command-line-option-fstrict-flex-arrays
|-- arc-randconfig-c041-20220830
|   `-- arc-elf-gcc:error:unrecognized-command-line-option-fstrict-flex-arrays
|-- arc-randconfig-p001-20220830
|   `-- arceb-elf-gcc:error:unrecognized-command-line-option-fstrict-flex-arrays
|-- arc-randconfig-r002-20220829
|   `-- arc-elf-gcc:error:unrecognized-command-line-option-fstrict-flex-arrays
|-- arc-randconfig-r004-20220830
|   `-- arceb-elf-gcc:error:unrecognized-command-line-option-fstrict-flex-arrays
|-- arc-randconfig-r034-20220830
|   `-- arc-elf-gcc:error:unrecognized-command-line-option-fstrict-flex-arrays
|-- arc-randconfig-r043-20220829
|   `-- arceb-elf-gcc:error:unrecognized-command-line-option-fstrict-flex-arrays
|-- arc-randconfig-r043-20220830
|   `-- arceb-elf-gcc:error:unrecognized-command-line-option-fstrict-flex-arrays
|-- arm64-allyesconfig
|   `-- aarch64-linux-gcc:error:unrecognized-command-line-option-fstrict-flex-arrays
|-- arm64-defconfig
|   `-- aarch64-linux-gcc:error:unrecognized-command-line-option-fstrict-flex-arrays
|-- arm64-randconfig-c44-20220830
|   `-- aarch64-linux-gcc:error:unrecognized-command-line-option-fstrict-flex-arrays
|-- csky-buildonly-randconfig-r006-20220830
|   `-- csky-linux-gcc:error:unrecognized-command-line-option-fstrict-flex-arrays
|-- csky-randconfig-r013-20220830
|   `-- csky-linux-gcc:error:unrecognized-command-line-option-fstrict-flex-arrays
|-- csky-randconfig-r021-20220829
|   `-- csky-linux-gcc:error:unrecognized-command-line-option-fstrict-flex-arrays
|-- i386-allyesconfig
|   `-- gcc:error:unrecognized-command-line-option-fstrict-flex-arrays
|-- i386-defconfig
|   `-- gcc:error:unrecognized-command-line-option-fstrict-flex-arrays
|-- i386-randconfig-a001
|   `-- gcc:error:unrecognized-command-line-option-fstrict-flex-arrays
|-- i386-randconfig-a003
|   `-- gcc:error:unrecognized-command-line-option-fstrict-flex-arrays
|-- i386-randconfig-a005
|   `-- gcc:error:unrecognized-command-line-option-fstrict-flex-arrays
|-- i386-randconfig-a012
|   `-- gcc:error:unrecognized-command-line-option-fstrict-flex-arrays
|-- i386-randconfig-a014
|   `-- gcc:error:unrecognized-command-line-option-fstrict-flex-arrays

elapsed time: 729m

configs tested: 161
configs skipped: 4

gcc tested configs:
x86_64               randconfig-a003-20220829
x86_64               randconfig-a004-20220829
x86_64               randconfig-a005-20220829
x86_64               randconfig-a002-20220829
x86_64               randconfig-a001-20220829
x86_64               randconfig-a006-20220829
i386                 randconfig-a001-20220829
i386                 randconfig-a003-20220829
i386                 randconfig-a002-20220829
i386                 randconfig-a004-20220829
i386                 randconfig-a005-20220829
i386                 randconfig-a006-20220829
m68k                             allmodconfig
arc                              allyesconfig
alpha                            allyesconfig
m68k                             allyesconfig
powerpc                          allmodconfig
mips                             allyesconfig
powerpc                           allnoconfig
sh                               allmodconfig
um                             i386_defconfig
um                           x86_64_defconfig
arc                  randconfig-r043-20220829
i386                             allyesconfig
i386                                defconfig
x86_64                              defconfig
x86_64                           allyesconfig
x86_64                               rhel-8.3
x86_64                    rhel-8.3-kselftests
x86_64                          rhel-8.3-func
x86_64                         rhel-8.3-kunit
x86_64                           rhel-8.3-kvm
x86_64                           rhel-8.3-syz
ia64                             allmodconfig
i386                 randconfig-c001-20220829
s390                                defconfig
s390                             allmodconfig
arc                                 defconfig
alpha                               defconfig
s390                             allyesconfig
loongarch                           defconfig
loongarch                         allnoconfig
csky                              allnoconfig
alpha                             allnoconfig
arc                               allnoconfig
riscv                             allnoconfig
xtensa                           alldefconfig
sh                            migor_defconfig
sh                      rts7751r2d1_defconfig
arm64                            allyesconfig
arm                                 defconfig
arm                              allyesconfig
arm                         s3c6400_defconfig
powerpc                      tqm8xx_defconfig
arm                         vf610m4_defconfig
powerpc                     tqm8548_defconfig
arm                  randconfig-c002-20220829
x86_64               randconfig-c001-20220829
m68k                        m5407c3_defconfig
sh                          r7780mp_defconfig
m68k                          multi_defconfig
sh                                  defconfig
sh                        sh7763rdp_defconfig
m68k                          atari_defconfig
mips                  decstation_64_defconfig
m68k                        m5307c3_defconfig
sh                             sh03_defconfig
powerpc                      makalu_defconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
powerpc                         wii_defconfig
powerpc                        cell_defconfig
xtensa                    xip_kc705_defconfig
arm                           h5000_defconfig
arm                        keystone_defconfig
arm64                            alldefconfig
arc                          axs103_defconfig
sh                          lboxre2_defconfig
arm64                               defconfig
ia64                             allyesconfig
arm                              allmodconfig
m68k                                defconfig
ia64                                defconfig
mips                             allmodconfig
nios2                            allyesconfig
nios2                               defconfig
parisc                              defconfig
parisc64                            defconfig
parisc                           allyesconfig
arm                          simpad_defconfig
sh                        apsh4ad0a_defconfig
arm                         lpc18xx_defconfig
sparc                            allyesconfig
arm                       aspeed_g5_defconfig
m68k                       m5475evb_defconfig
i386                          debian-10.3-kvm
i386                        debian-10.3-kunit
i386                         debian-10.3-func
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
sparc                               defconfig
xtensa                           allyesconfig
csky                                defconfig
x86_64                                  kexec
i386                          randconfig-c001
powerpc              randconfig-c003-20220830
mips                 randconfig-c004-20220830
x86_64                        randconfig-c001
arm                  randconfig-c002-20220830
arm                       imx_v6_v7_defconfig
powerpc                       maple_defconfig
mips                    maltaup_xpa_defconfig
arm                         at91_dt_defconfig
arm                          pxa910_defconfig
powerpc                      pasemi_defconfig
mips                  maltasmvp_eva_defconfig
s390                       zfcpdump_defconfig
arm                            mps2_defconfig
powerpc                          allyesconfig
riscv                               defconfig
riscv                            allmodconfig
riscv                            allyesconfig
x86_64                        randconfig-a006
x86_64                        randconfig-a004
x86_64                        randconfig-a002

clang tested configs:
x86_64               randconfig-a011-20220829
x86_64               randconfig-a014-20220829
x86_64               randconfig-a012-20220829
x86_64               randconfig-a013-20220829
x86_64               randconfig-a015-20220829
x86_64               randconfig-a016-20220829
i386                 randconfig-a011-20220829
i386                 randconfig-a014-20220829
i386                 randconfig-a013-20220829
i386                 randconfig-a012-20220829
i386                 randconfig-a015-20220829
i386                 randconfig-a016-20220829
hexagon              randconfig-r041-20220829
riscv                randconfig-r042-20220829
hexagon              randconfig-r045-20220829
s390                 randconfig-r044-20220829
arm                        mvebu_v5_defconfig
powerpc                     kilauea_defconfig
x86_64               randconfig-k001-20220829
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
i386                             allyesconfig
powerpc                     powernv_defconfig
mips                     cu1000-neo_defconfig
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
x86_64                        randconfig-k001
s390                 randconfig-r044-20220830
hexagon              randconfig-r045-20220830
hexagon              randconfig-r041-20220830
riscv                randconfig-r042-20220830

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
