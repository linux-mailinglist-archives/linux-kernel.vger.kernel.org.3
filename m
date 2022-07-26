Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9F77581A6A
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 21:43:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239594AbiGZTnJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 15:43:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230056AbiGZTnH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 15:43:07 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F41F2A733
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 12:43:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658864586; x=1690400586;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=TsqcCU3tbkHJ5N96sKgNIfYArCjbbIhyuZdxHy/oKx0=;
  b=A5xeJy0lejaNs1XUE4zyS3bX+Z/rgZqzBr6I+BakFVuqZ/lEvUYjq/oB
   8lMW760TaACg0+SH/f7fwMqOq7TZEO371RjhRwXKJo2cEqYJ5lfK9RVYQ
   UOFbsDNQmH/4dDA9+MC+f1gnaH6vrx1C0Oi/ycfZKOOIwjJlipa/GZDG1
   oEsjeNw2rgHzH5wEyR0MTL4vnPHeinY/lY8g+b6PTfXItYRQDXvAdAUvq
   HSWTnI4ZeR7lv8voJ8f4W8iuz/TOmIZlDgv2biSuuTtc1fItNQiAe2qhV
   MGc0mxexbjPXrZQrV+6o72RnrpY5pkCsYKEmOgJjGXW2Br8q5mfzDxOq8
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10420"; a="289233053"
X-IronPort-AV: E=Sophos;i="5.93,194,1654585200"; 
   d="scan'208";a="289233053"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jul 2022 12:43:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,194,1654585200"; 
   d="scan'208";a="726650429"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 26 Jul 2022 12:43:04 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oGQSO-0007da-0f;
        Tue, 26 Jul 2022 19:43:04 +0000
Date:   Wed, 27 Jul 2022 03:42:44 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/sgx] BUILD SUCCESS
 038ef9928e1acb37bbe808c23a421189f1fd96cb
Message-ID: <62e043b4.A/3QhXOI6A7jOtqE%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/sgx
branch HEAD: 038ef9928e1acb37bbe808c23a421189f1fd96cb  Merge tag 'v5.19-rc8' into x86/sgx, to resolve conflicts

elapsed time: 724m

configs tested: 138
configs skipped: 3

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
m68k                          multi_defconfig
xtensa                          iss_defconfig
arc                      axs103_smp_defconfig
m68k                            mac_defconfig
sh                            shmin_defconfig
powerpc                       eiger_defconfig
parisc                generic-32bit_defconfig
mips                         rt305x_defconfig
powerpc                      makalu_defconfig
loongarch                 loongson3_defconfig
alpha                               defconfig
loongarch                           defconfig
m68k                        m5272c3_defconfig
ia64                      gensparse_defconfig
alpha                            alldefconfig
arc                     nsimosci_hs_defconfig
xtensa                         virt_defconfig
arm                           h5000_defconfig
arm                           sama5_defconfig
arm                         vf610m4_defconfig
powerpc                 mpc834x_mds_defconfig
powerpc                 mpc85xx_cds_defconfig
arm                             ezx_defconfig
mips                             allmodconfig
powerpc                     ep8248e_defconfig
sh                        sh7763rdp_defconfig
mips                     loongson1b_defconfig
powerpc                         ps3_defconfig
arm                        keystone_defconfig
sh                          rsk7264_defconfig
powerpc                     rainier_defconfig
m68k                           virt_defconfig
sh                             espt_defconfig
m68k                                defconfig
mips                           gcw0_defconfig
mips                         tb0226_defconfig
sh                     sh7710voipgw_defconfig
m68k                       m5275evb_defconfig
arm                        shmobile_defconfig
mips                         mpc30x_defconfig
powerpc                 mpc837x_rdb_defconfig
powerpc                    adder875_defconfig
arm                           sunxi_defconfig
arm                       aspeed_g5_defconfig
sh                          sdk7780_defconfig
arm                         nhk8815_defconfig
nios2                            allyesconfig
arc                          axs103_defconfig
nios2                               defconfig
m68k                          atari_defconfig
mips                 decstation_r4k_defconfig
powerpc                      tqm8xx_defconfig
powerpc                     tqm8555_defconfig
mips                      fuloong2e_defconfig
arm                        oxnas_v6_defconfig
sparc                               defconfig
m68k                         amcore_defconfig
nios2                         10m50_defconfig
loongarch                         allnoconfig
i386                          debian-10.3-kvm
i386                        debian-10.3-kunit
i386                         debian-10.3-func
ia64                             allmodconfig
csky                              allnoconfig
alpha                             allnoconfig
arc                               allnoconfig
riscv                             allnoconfig
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
x86_64                        randconfig-a013
x86_64                        randconfig-a011
x86_64                        randconfig-a015
i386                          randconfig-a014
i386                          randconfig-a012
i386                          randconfig-a016
s390                 randconfig-r044-20220724
riscv                randconfig-r042-20220724
arc                  randconfig-r043-20220724
s390                 randconfig-r044-20220726
riscv                randconfig-r042-20220726
arc                  randconfig-r043-20220726
x86_64                    rhel-8.3-kselftests
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                              defconfig
x86_64                           allyesconfig
x86_64                               rhel-8.3
x86_64                           rhel-8.3-kvm
x86_64                           rhel-8.3-syz
x86_64                          rhel-8.3-func
x86_64                         rhel-8.3-kunit

clang tested configs:
powerpc                      walnut_defconfig
powerpc                 mpc832x_rdb_defconfig
arm                          moxart_defconfig
arm                         shannon_defconfig
powerpc               mpc834x_itxgp_defconfig
arm                      tct_hammer_defconfig
x86_64                           allyesconfig
arm                  colibri_pxa300_defconfig
powerpc                     powernv_defconfig
powerpc                  mpc885_ads_defconfig
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
i386                          randconfig-a013
i386                          randconfig-a015
i386                          randconfig-a011
hexagon              randconfig-r041-20220724
hexagon              randconfig-r045-20220724

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
