Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FD3D584917
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 02:33:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233656AbiG2AdF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 20:33:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231925AbiG2AdE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 20:33:04 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14A3B77577
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 17:33:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659054782; x=1690590782;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=Yp5hySB5kAEslrP72R9mFVTZFlnhCQw2Z5NXj4Ibf9M=;
  b=mImSdRhgvqhw6RyYyr8cqmYxBfaMPrmUBI9gRFa3g3L5aKXzcdQazJt1
   XDqGaIX/w6dmqX3Svdah/vFlpbRn97+YhEdfXlhZgqGqfElHuPajbApPZ
   mz53EwTlZZQfUZ5jvBgORo6SUte2n18ILMnHHlx88Qps7fOECbJ94efal
   b4b0B+d7nenaKXBkPG2htuTH5rBz3d0wJE6/ascDc5WGV2uV+tZQLeSv1
   NVHzVqLdzpPjwgWvAT2WLF1eBXY+e0cUFZYndE9tzU+08rwjW8QMYx0Cl
   mP/TeKgizh5Q90u5cIoGAIiT/38pH0RY4ls9kbtcb0Lj2lHzwonggUYsw
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10422"; a="350362209"
X-IronPort-AV: E=Sophos;i="5.93,199,1654585200"; 
   d="scan'208";a="350362209"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2022 17:33:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,199,1654585200"; 
   d="scan'208";a="629163006"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 28 Jul 2022 17:33:00 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oHDw3-000AmU-2n;
        Fri, 29 Jul 2022 00:32:59 +0000
Date:   Fri, 29 Jul 2022 08:32:46 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:timers/core] BUILD SUCCESS
 cceeeb6a6d02e7b9a74ddd27a3225013b34174aa
Message-ID: <62e32aae.hpvJURbGdNPYbpXO%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers/core
branch HEAD: cceeeb6a6d02e7b9a74ddd27a3225013b34174aa  wait: Fix __wait_event_hrtimeout for RT/DL tasks

elapsed time: 819m

configs tested: 119
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                             i386_defconfig
um                           x86_64_defconfig
i386                          randconfig-a014
i386                          randconfig-a012
i386                          randconfig-a016
i386                                defconfig
x86_64                    rhel-8.3-kselftests
x86_64                          rhel-8.3-func
i386                          randconfig-a001
x86_64                         rhel-8.3-kunit
x86_64                        randconfig-a015
x86_64                           rhel-8.3-kvm
arc                  randconfig-r043-20220728
x86_64                           rhel-8.3-syz
x86_64                        randconfig-a013
x86_64                        randconfig-a011
riscv                randconfig-r042-20220728
i386                          randconfig-a003
s390                 randconfig-r044-20220728
i386                          randconfig-a005
powerpc                           allnoconfig
i386                             allyesconfig
powerpc                          allmodconfig
x86_64                        randconfig-a002
sh                               allmodconfig
x86_64                        randconfig-a006
x86_64                              defconfig
x86_64                           allyesconfig
x86_64                               rhel-8.3
x86_64                        randconfig-a004
mips                             allyesconfig
arm                                 defconfig
m68k                             allyesconfig
m68k                             allmodconfig
arc                              allyesconfig
alpha                            allyesconfig
m68k                         amcore_defconfig
powerpc                 mpc837x_rdb_defconfig
csky                              allnoconfig
alpha                             allnoconfig
arc                               allnoconfig
riscv                             allnoconfig
loongarch                         allnoconfig
arm64                            allyesconfig
arm                              allyesconfig
arm                            hisi_defconfig
m68k                        m5272c3_defconfig
ia64                             allmodconfig
loongarch                           defconfig
i386                          randconfig-c001
arc                           tb10x_defconfig
powerpc                 mpc8540_ads_defconfig
m68k                       m5475evb_defconfig
powerpc                      pasemi_defconfig
sparc                       sparc64_defconfig
arm                           sama5_defconfig
sh                         ecovec24_defconfig
arm                            qcom_defconfig
s390                       zfcpdump_defconfig
openrisc                         alldefconfig
ia64                        generic_defconfig
sh                           se7343_defconfig
arm                            mps2_defconfig
openrisc                    or1ksim_defconfig
i386                          debian-10.3-kvm
i386                        debian-10.3-kunit
i386                         debian-10.3-func
xtensa                  cadence_csp_defconfig
mips                           ip32_defconfig
arc                            hsdk_defconfig
sh                 kfr2r09-romimage_defconfig
sh                     sh7710voipgw_defconfig
m68k                        m5407c3_defconfig
powerpc                     taishan_defconfig
sh                         ap325rxa_defconfig
powerpc                      tqm8xx_defconfig
arm                          lpd270_defconfig
x86_64                        randconfig-c001
arm                  randconfig-c002-20220728
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
sparc                               defconfig
xtensa                           allyesconfig
csky                                defconfig
sparc                            allyesconfig
x86_64                                  kexec

clang tested configs:
i386                          randconfig-a013
i386                          randconfig-a011
i386                          randconfig-a015
hexagon              randconfig-r045-20220728
hexagon              randconfig-r041-20220728
x86_64                        randconfig-a014
x86_64                        randconfig-a016
i386                          randconfig-a002
x86_64                        randconfig-a012
i386                          randconfig-a006
i386                          randconfig-a004
x86_64                        randconfig-a005
x86_64                        randconfig-a001
x86_64                        randconfig-a003
mips                malta_qemu_32r6_defconfig
powerpc                    gamecube_defconfig
arm                          collie_defconfig
x86_64                        randconfig-k001
arm                       imx_v4_v5_defconfig
arm                       versatile_defconfig
powerpc                      obs600_defconfig
arm                     davinci_all_defconfig
powerpc                 mpc836x_mds_defconfig
riscv                             allnoconfig
powerpc                     tqm5200_defconfig
powerpc                        fsp2_defconfig
powerpc                      katmai_defconfig
powerpc                   microwatt_defconfig
powerpc                      ppc64e_defconfig
mips                          rm200_defconfig
arm                  colibri_pxa270_defconfig

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
