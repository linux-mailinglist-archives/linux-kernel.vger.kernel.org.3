Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39092581A66
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 21:42:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239569AbiGZTmK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 15:42:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239603AbiGZTmH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 15:42:07 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A4982C67B
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 12:42:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658864526; x=1690400526;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=EFclX0BSGC1xT7WAib3flDtPyhXrwizkShnLj+pHRcY=;
  b=arYNjB8RdM4AxMKd/nWjMvlk7LNO2Gf3GnUOwFmUZQP144sZkqZ05MuP
   sfX+IOuSa8zxOiM8HC+1dxwvfuWFgqRITIezHti3NvCc1KxusyWYDS869
   ijPKxkmVotdSUPiDQq7rbQ4Elcz00u6XK6PHDy62XCz6Yeml34gs9aOl+
   r+hAIn/GgiFPANzT3y5eZPnnei9eNef1OsycHZWKMQbeNJiH38mHexp90
   r9JTCXv1qdMD9jpoFR+Tin9mj9xszsgzbMOxXZVJ8ggGaGwKrn9vt17Z2
   0LVHS7k2HOxjoXMjCAwRVYi/a4vuCJWuBwcu8xmL+9gL9llz+E21E3CYP
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10420"; a="374339432"
X-IronPort-AV: E=Sophos;i="5.93,194,1654585200"; 
   d="scan'208";a="374339432"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jul 2022 12:42:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,194,1654585200"; 
   d="scan'208";a="550536180"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 26 Jul 2022 12:42:04 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oGQRQ-0007dQ-0W;
        Tue, 26 Jul 2022 19:42:04 +0000
Date:   Wed, 27 Jul 2022 03:41:59 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/kdump] BUILD SUCCESS
 b9887d0fb9dd2e06891f35f441e4cddca9ee078d
Message-ID: <62e04387.5GnfwhBHI2UdK1QA%lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/kdump
branch HEAD: b9887d0fb9dd2e06891f35f441e4cddca9ee078d  Merge branch 'x86/build' into x86/kdump, to resolve conflict

elapsed time: 724m

configs tested: 154
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
mips                     loongson1b_defconfig
m68k                          multi_defconfig
xtensa                          iss_defconfig
arc                      axs103_smp_defconfig
m68k                            mac_defconfig
sh                            shmin_defconfig
powerpc                       eiger_defconfig
parisc                generic-32bit_defconfig
mips                         rt305x_defconfig
loongarch                 loongson3_defconfig
alpha                               defconfig
loongarch                           defconfig
powerpc                      makalu_defconfig
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
sparc                             allnoconfig
sh                          polaris_defconfig
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
i386                          debian-10.3-kvm
i386                        debian-10.3-kunit
i386                         debian-10.3-func
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
i386                          randconfig-a003
i386                          randconfig-a001
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
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                              defconfig
x86_64                           allyesconfig
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
i386                          randconfig-a011
i386                          randconfig-a013
i386                          randconfig-a015

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
