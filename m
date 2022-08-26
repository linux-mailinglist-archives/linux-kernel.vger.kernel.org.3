Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 488FD5A3209
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Aug 2022 00:27:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345256AbiHZW1Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 18:27:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345225AbiHZW1V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 18:27:21 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE928786CD
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 15:27:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661552840; x=1693088840;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=32vbawqXYw7X6c10pnU4kHjy860Sr+Gt+/2LTOTFeuU=;
  b=hVjgH4h+Qzn0T0YiHULbdZfndX34TABkqijrgOuIAS1vtRB4dV/K7Foq
   pZCe8dNppATEtAeLdh81Odx/OGfMgxMclFQ2Hd6AUPqfnm/oiZTXKSuff
   0mhwNMKujndzZMaWLXdUIJtx7mIn2ZhlTok5F8TWDsyJBXaxAJNqR/NM+
   veqvwNrIOWO27IoKNtpYZVhmfPvtFoXuBFnkRabGRcx3eczXKUUfKudik
   Hwk3Z60HfGMecRHPHOHQYPXwctWqFpAiA9bhJPMSdXV9XrEr1doboS5t4
   n+sREEgy//7RoXzb4bffL0geZvLouJqmRi2Ya8QSsQEzR4ttzdm8Dc1q+
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10451"; a="292184552"
X-IronPort-AV: E=Sophos;i="5.93,266,1654585200"; 
   d="scan'208";a="292184552"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2022 15:27:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,266,1654585200"; 
   d="scan'208";a="587458005"
Received: from lkp-server01.sh.intel.com (HELO 71b0d3b5b1bc) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 26 Aug 2022 15:27:19 -0700
Received: from kbuild by 71b0d3b5b1bc with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oRhnK-0000X5-21;
        Fri, 26 Aug 2022 22:27:18 +0000
Date:   Sat, 27 Aug 2022 06:26:32 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/microcode] BUILD SUCCESS
 8c61eafd22d7207039bff85c6e1d386f15abd17e
Message-ID: <63094898.OGyNlWh+pxjDt8vR%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/microcode
branch HEAD: 8c61eafd22d7207039bff85c6e1d386f15abd17e  x86/microcode: Remove ->request_microcode_user()

elapsed time: 723m

configs tested: 115
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                             i386_defconfig
um                           x86_64_defconfig
i386                                defconfig
loongarch                         allnoconfig
loongarch                           defconfig
x86_64                              defconfig
arc                                 defconfig
i386                          randconfig-a016
x86_64                        randconfig-a013
i386                          randconfig-a005
x86_64                          rhel-8.3-func
x86_64                        randconfig-a006
sh                               allmodconfig
x86_64                        randconfig-a015
x86_64                         rhel-8.3-kunit
s390                             allmodconfig
i386                             allyesconfig
powerpc                           allnoconfig
i386                          randconfig-a001
x86_64                        randconfig-a011
x86_64                               rhel-8.3
x86_64                        randconfig-a002
alpha                               defconfig
i386                          randconfig-a003
x86_64                           rhel-8.3-kvm
s390                             allyesconfig
i386                          randconfig-a014
x86_64                    rhel-8.3-kselftests
x86_64                        randconfig-a004
x86_64                           rhel-8.3-syz
s390                                defconfig
arm                                 defconfig
arc                  randconfig-r043-20220824
m68k                             allmodconfig
i386                          randconfig-a012
alpha                            allyesconfig
riscv                randconfig-r042-20220824
arc                  randconfig-r043-20220823
s390                 randconfig-r044-20220824
m68k                             allyesconfig
riscv                randconfig-r042-20220826
arc                              allyesconfig
powerpc                          allmodconfig
x86_64                           allyesconfig
mips                             allyesconfig
s390                 randconfig-r044-20220826
arc                  randconfig-r043-20220826
arc                  randconfig-r043-20220825
arm                              allyesconfig
arm64                            allyesconfig
ia64                             allmodconfig
parisc                              defconfig
nios2                               defconfig
parisc64                            defconfig
i386                          debian-10.3-kvm
i386                        debian-10.3-kunit
i386                         debian-10.3-func
nios2                            allyesconfig
parisc                           allyesconfig
powerpc                          allyesconfig
riscv                               defconfig
riscv                            allmodconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
riscv                             allnoconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
sparc                               defconfig
xtensa                           allyesconfig
csky                                defconfig
sparc                            allyesconfig
x86_64                                  kexec
s390                       zfcpdump_defconfig
sh                ecovec24-romimage_defconfig
powerpc                 mpc8540_ads_defconfig
arm                           sama5_defconfig
csky                              allnoconfig
alpha                             allnoconfig
arc                               allnoconfig
sh                        apsh4ad0a_defconfig
openrisc                    or1ksim_defconfig
i386                          randconfig-c001
sh                          landisk_defconfig

clang tested configs:
x86_64                        randconfig-a016
i386                          randconfig-a013
x86_64                        randconfig-a005
i386                          randconfig-a006
x86_64                        randconfig-a001
x86_64                        randconfig-a012
hexagon              randconfig-r041-20220825
i386                          randconfig-a011
x86_64                        randconfig-a003
i386                          randconfig-a002
hexagon              randconfig-r041-20220823
hexagon              randconfig-r045-20220825
i386                          randconfig-a015
x86_64                        randconfig-a014
i386                          randconfig-a004
hexagon              randconfig-r041-20220824
hexagon              randconfig-r045-20220824
s390                 randconfig-r044-20220823
hexagon              randconfig-r045-20220826
hexagon              randconfig-r041-20220826
s390                 randconfig-r044-20220825
riscv                randconfig-r042-20220825
riscv                randconfig-r042-20220823
hexagon              randconfig-r045-20220823
x86_64                        randconfig-k001
hexagon              randconfig-r045-20220827
riscv                randconfig-r042-20220827
hexagon              randconfig-r041-20220827
s390                 randconfig-r044-20220827
arm                                 defconfig
arm                         bcm2835_defconfig

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
