Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D10FC5817C4
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 18:45:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232158AbiGZQo7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 12:44:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229582AbiGZQo5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 12:44:57 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4FCCE70
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 09:44:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658853896; x=1690389896;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=+GNLPmb8N2DNN18Nijglg+wv+YLZkqEl/vszz3FXEo4=;
  b=h06X+QhfjXDbviXE3OiAg+PhYfOa/bWJl+zOVN+bM7bNcMw09hmTKLG6
   KarzrDDX6k3UUo/wumtEi5vbAd14xI0RHvwGM/YORq9kQ4dmGZ50hXn02
   vgBz5T8d3k4rkuzRZV53AHG4ip8qsVIa+mFihQaB2Ho1Rqt7K29WcAWYi
   o1jZWvmn14EAyfx2NBmU4h5cU4dw7GVDm9UxHIa58djd+XT6CYJqkhkWt
   igdEyNeRFstvxlXf9Q7037DV8f8j5E5pCFmKzjyN7AaXsYsrU6kTX0dsW
   p1hmtblkO71Sm7IdNuXyyqRPX1KuQ5ONkqBdsJE3yCFEdMwr5OnJt+hi3
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10420"; a="285550797"
X-IronPort-AV: E=Sophos;i="5.93,194,1654585200"; 
   d="scan'208";a="285550797"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jul 2022 09:44:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,194,1654585200"; 
   d="scan'208";a="575563337"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 26 Jul 2022 09:44:43 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oGNfm-0007FW-1j;
        Tue, 26 Jul 2022 16:44:42 +0000
Date:   Wed, 27 Jul 2022 00:44:18 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: [gustavoars:testing/for-next-fam0] BUILD SUCCESS
 20695c7dc9d1588972b5649f1cda4e5610334230
Message-ID: <62e019e2.SGC+sEqdFPu1LUku%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git testing/for-next-fam0
branch HEAD: 20695c7dc9d1588972b5649f1cda4e5610334230  media: amphion: replace zero-length array with flexible-array member

elapsed time: 727m

configs tested: 130
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm64                            allyesconfig
arm                                 defconfig
arm                              allyesconfig
powerpc              randconfig-c003-20220724
i386                          randconfig-c001
sh                   sh7724_generic_defconfig
arm                         s3c6400_defconfig
m68k                       m5249evb_defconfig
arm                       multi_v4t_defconfig
mips                     loongson1b_defconfig
m68k                          multi_defconfig
xtensa                          iss_defconfig
arc                      axs103_smp_defconfig
m68k                            mac_defconfig
sh                            shmin_defconfig
parisc                generic-32bit_defconfig
mips                         rt305x_defconfig
powerpc                       eiger_defconfig
loongarch                 loongson3_defconfig
alpha                               defconfig
loongarch                           defconfig
powerpc                      makalu_defconfig
powerpc                 mpc85xx_cds_defconfig
arm                             ezx_defconfig
mips                             allmodconfig
powerpc                     ep8248e_defconfig
sh                        sh7763rdp_defconfig
sh                             espt_defconfig
m68k                                defconfig
mips                           gcw0_defconfig
mips                         tb0226_defconfig
sh                     sh7710voipgw_defconfig
powerpc                    adder875_defconfig
arm                           sunxi_defconfig
arm                       aspeed_g5_defconfig
sh                          sdk7780_defconfig
arm                         nhk8815_defconfig
sparc                             allnoconfig
sh                          polaris_defconfig
m68k                          atari_defconfig
mips                 decstation_r4k_defconfig
powerpc                      tqm8xx_defconfig
powerpc                     tqm8555_defconfig
mips                      fuloong2e_defconfig
arm                        oxnas_v6_defconfig
sparc                               defconfig
m68k                         amcore_defconfig
nios2                         10m50_defconfig
s390                                defconfig
s390                             allmodconfig
arc                                 defconfig
s390                             allyesconfig
arm64                               defconfig
ia64                             allyesconfig
arm                              allmodconfig
ia64                                defconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
riscv                             allnoconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
loongarch                         allnoconfig
x86_64                        randconfig-c001
arm                  randconfig-c002-20220724
ia64                             allmodconfig
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
i386                          randconfig-a001
i386                          randconfig-a003
i386                          randconfig-a005
x86_64                        randconfig-a011
x86_64                        randconfig-a013
x86_64                        randconfig-a015
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
s390                 randconfig-r044-20220724
riscv                randconfig-r042-20220724
arc                  randconfig-r043-20220724
s390                 randconfig-r044-20220726
riscv                randconfig-r042-20220726
arc                  randconfig-r043-20220726
x86_64                    rhel-8.3-kselftests
x86_64                           allyesconfig
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                           rhel-8.3-kvm
x86_64                          rhel-8.3-func
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit

clang tested configs:
powerpc                      walnut_defconfig
powerpc                 mpc832x_rdb_defconfig
arm                          moxart_defconfig
mips                         tb0287_defconfig
arm                         shannon_defconfig
powerpc               mpc834x_itxgp_defconfig
powerpc                     powernv_defconfig
arm                      tct_hammer_defconfig
x86_64                           allyesconfig
x86_64                        randconfig-k001
x86_64                        randconfig-a005
x86_64                        randconfig-a003
x86_64                        randconfig-a001
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
i386                          randconfig-a011
i386                          randconfig-a013
i386                          randconfig-a015
hexagon              randconfig-r041-20220724
hexagon              randconfig-r045-20220724

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
