Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B51F51784C
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 22:39:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381756AbiEBUmi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 16:42:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236153AbiEBUmg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 16:42:36 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA7D9A1A8
        for <linux-kernel@vger.kernel.org>; Mon,  2 May 2022 13:39:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651523946; x=1683059946;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=YlV00rHkt3/lqBWMC8ZTJ1eu+DtwtICYFU8r59KkKkQ=;
  b=YulbQXUF1w5thfRece+u3yY6YnQYBptwEeRdUoSka6TZY+Mk31t2l7iO
   6cXWgqi6PikCaYUFVqSgECMQPyK2HImVWyb8Zy5iFgCIYxnX2atCCoWh6
   RNym/IaUX3DN3JVb+oSUCm5wxizF+wpnV99bEaKCtadSDafVbQdN7PuO3
   hH6Tqj2P0E/UlepBk57zxNwVVTQwCmU+DOcOJGLsvLWWRgdaAG1LPUyNL
   ZUC1/IUUYaRBfykkeyc4m1BgNu5nrjP1KRcRzTnd4aXzzn5i3inIH2l8g
   kuuKBi0im6/Mq6+igH0dTX+yKEfgBxZi0lv51xJW9/g1U/B0B6q6Qd2lf
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10335"; a="264915751"
X-IronPort-AV: E=Sophos;i="5.91,193,1647327600"; 
   d="scan'208";a="264915751"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2022 13:39:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,193,1647327600"; 
   d="scan'208";a="620068587"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 02 May 2022 13:39:05 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nlcoy-0009qx-MJ;
        Mon, 02 May 2022 20:39:04 +0000
Date:   Tue, 03 May 2022 04:38:30 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/fpu] BUILD SUCCESS
 b91c0922bf1ed15b67a6faa404bc64e3ed532ec2
Message-ID: <62704146.ARVWgAor3Ewgm9/h%lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/fpu
branch HEAD: b91c0922bf1ed15b67a6faa404bc64e3ed532ec2  x86/fpu: Cleanup variable shadowing

elapsed time: 735m

configs tested: 134
configs skipped: 76

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm64                               defconfig
arm64                            allyesconfig
arm                              allmodconfig
arm                                 defconfig
arm                              allyesconfig
i386                          randconfig-c001
sh                            shmin_defconfig
mips                  maltasmvp_eva_defconfig
sh                               j2_defconfig
sh                        apsh4ad0a_defconfig
mips                             allyesconfig
powerpc                mpc7448_hpc2_defconfig
sh                        sh7763rdp_defconfig
h8300                    h8300h-sim_defconfig
arm                        oxnas_v6_defconfig
powerpc                       ppc64_defconfig
sh                           sh2007_defconfig
mips                         cobalt_defconfig
h8300                            alldefconfig
m68k                          atari_defconfig
arm                            zeus_defconfig
arm                            mps2_defconfig
xtensa                  audio_kc705_defconfig
sh                   sh7770_generic_defconfig
riscv             nommu_k210_sdcard_defconfig
sh                         ecovec24_defconfig
xtensa                         virt_defconfig
powerpc                    amigaone_defconfig
sh                        sh7785lcr_defconfig
sh                           se7721_defconfig
sh                           se7705_defconfig
x86_64                        randconfig-c001
arm                  randconfig-c002-20220501
m68k                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
nios2                               defconfig
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
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                           allnoconfig
powerpc                          allmodconfig
x86_64                        randconfig-a006
x86_64                        randconfig-a004
x86_64                        randconfig-a002
i386                          randconfig-a001
i386                          randconfig-a003
i386                          randconfig-a005
i386                 randconfig-a004-20220502
i386                 randconfig-a006-20220502
i386                 randconfig-a002-20220502
i386                 randconfig-a003-20220502
i386                 randconfig-a001-20220502
i386                 randconfig-a005-20220502
x86_64               randconfig-a006-20220502
x86_64               randconfig-a002-20220502
x86_64               randconfig-a001-20220502
x86_64               randconfig-a004-20220502
x86_64               randconfig-a005-20220502
x86_64               randconfig-a003-20220502
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
arc                  randconfig-r043-20220501
arc                  randconfig-r043-20220502
s390                 randconfig-r044-20220501
riscv                randconfig-r042-20220501
riscv                               defconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
riscv                             allnoconfig
riscv                            allmodconfig
riscv                            allyesconfig
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                          rhel-8.3-func
x86_64                           rhel-8.3-syz
x86_64                                  kexec
x86_64                              defconfig
x86_64                           allyesconfig
x86_64                    rhel-8.3-kselftests
x86_64                         rhel-8.3-kunit
x86_64                               rhel-8.3

clang tested configs:
x86_64                        randconfig-c007
i386                          randconfig-c001
powerpc              randconfig-c003-20220501
riscv                randconfig-c006-20220501
mips                 randconfig-c004-20220501
arm                  randconfig-c002-20220501
arm                           spitz_defconfig
mips                      maltaaprp_defconfig
arm                         palmz72_defconfig
arm                         socfpga_defconfig
mips                           mtx1_defconfig
riscv                    nommu_virt_defconfig
powerpc                     ksi8560_defconfig
arm                            dove_defconfig
powerpc                   bluestone_defconfig
x86_64                           allyesconfig
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64               randconfig-a011-20220502
x86_64               randconfig-a012-20220502
x86_64               randconfig-a013-20220502
x86_64               randconfig-a016-20220502
x86_64               randconfig-a015-20220502
x86_64               randconfig-a014-20220502
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
i386                          randconfig-a013
i386                          randconfig-a011
i386                          randconfig-a015
x86_64                        randconfig-a001
x86_64                        randconfig-a003
x86_64                        randconfig-a005

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
