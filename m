Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AA5C5858EF
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Jul 2022 09:13:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230461AbiG3HM7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Jul 2022 03:12:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229573AbiG3HM5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jul 2022 03:12:57 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A88591057D
        for <linux-kernel@vger.kernel.org>; Sat, 30 Jul 2022 00:12:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659165176; x=1690701176;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=BjTz33VUCpSWyNzU1m6MbUil6IHpSrNpZrg6F4zTKwU=;
  b=Gyj52Ji08ZYENfO3H2Tidx3iLVKEfSfeutGF/JtVNhnZu6Ek1rkFB+vE
   WeLZxzJSEg8aYQGWp2F29HEZEqqayakGKm/C7dFOgJV+Fm4wD/GxBrtV1
   O2Y7vdtoiYMUXTM8LqCSbU8h//68kBQfAkaiEp9Rwz80SOfYLBS+0coDl
   sZM0x/mi59ERgGbPSZAuDHS16BaYsblOvQPwzc+9brGPLvexZy9p1l/IZ
   EjcLYJQNW7GvCJoRxV+paS6F7AGHwQR+hkx+3s8Y/LtB1XkKV+WoGiQVT
   XmlrbdHjCcfK882DSqJYSGHi4VGwIpN6UZC1NBtQsle4tFMdvitx3jYPc
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10423"; a="350602529"
X-IronPort-AV: E=Sophos;i="5.93,203,1654585200"; 
   d="scan'208";a="350602529"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2022 00:12:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,203,1654585200"; 
   d="scan'208";a="743760428"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 30 Jul 2022 00:12:55 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oHgec-000CaD-2A;
        Sat, 30 Jul 2022 07:12:54 +0000
Date:   Sat, 30 Jul 2022 15:12:53 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/urgent] BUILD SUCCESS
 ea304a8b89fd0d6cf94ee30cb139dc23d9f1a62f
Message-ID: <62e4d9f5.c6yiRVhprsJgCM+5%lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/urgent
branch HEAD: ea304a8b89fd0d6cf94ee30cb139dc23d9f1a62f  docs/kernel-parameters: Update descriptions for "mitigations=" param with retbleed

elapsed time: 712m

configs tested: 75
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                              defconfig
i386                                defconfig
x86_64                               rhel-8.3
powerpc                           allnoconfig
powerpc                          allmodconfig
mips                             allyesconfig
x86_64                           allyesconfig
arc                  randconfig-r043-20220729
i386                             allyesconfig
sh                               allmodconfig
x86_64                          rhel-8.3-func
x86_64                        randconfig-a015
x86_64                         rhel-8.3-kunit
i386                          randconfig-a001
x86_64                        randconfig-a004
x86_64                    rhel-8.3-kselftests
x86_64                        randconfig-a002
x86_64                           rhel-8.3-syz
i386                          randconfig-a014
i386                          randconfig-a012
i386                          randconfig-a016
x86_64                        randconfig-a013
i386                          randconfig-a003
x86_64                           rhel-8.3-kvm
i386                          randconfig-a005
x86_64                        randconfig-a011
x86_64                        randconfig-a006
arm                                 defconfig
ia64                             allmodconfig
arm                              allyesconfig
alpha                            allyesconfig
arm64                            allyesconfig
m68k                             allmodconfig
arc                              allyesconfig
m68k                             allyesconfig
powerpc                      bamboo_defconfig
m68k                          hp300_defconfig
sh                              ul2_defconfig
nios2                               defconfig
sh                         ecovec24_defconfig
csky                              allnoconfig
alpha                             allnoconfig
arc                               allnoconfig
riscv                             allnoconfig
arm                         lpc18xx_defconfig
powerpc                 mpc8540_ads_defconfig
xtensa                    xip_kc705_defconfig
i386                          randconfig-c001
powerpc                      pcm030_defconfig
m68k                                defconfig
mips                         tb0226_defconfig
sh                     sh7710voipgw_defconfig
loongarch                           defconfig
loongarch                         allnoconfig

clang tested configs:
hexagon              randconfig-r041-20220729
riscv                randconfig-r042-20220729
s390                 randconfig-r044-20220729
i386                          randconfig-a013
x86_64                        randconfig-a014
i386                          randconfig-a011
i386                          randconfig-a015
i386                          randconfig-a002
x86_64                        randconfig-a005
i386                          randconfig-a004
i386                          randconfig-a006
x86_64                        randconfig-a001
x86_64                        randconfig-a003
x86_64                        randconfig-a016
x86_64                        randconfig-a012
hexagon              randconfig-r045-20220729
x86_64                        randconfig-k001
mips                     loongson1c_defconfig
arm                         palmz72_defconfig

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
