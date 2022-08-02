Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 110605875B7
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 05:02:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232665AbiHBDC3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 23:02:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231180AbiHBDCX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 23:02:23 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA92A1900A
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 20:02:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659409342; x=1690945342;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=ojKsdgAlU+AwiBO7QqMHjQ3Y4cvOyJYrRfNpPAstPZ4=;
  b=KO3tN6VeDosT+nBFlrbypQg1gUBpgUrc6bpRAcwOctepchUvczDaCXdM
   CSEN2QnGV2b5Pfk2YrzxSAUcewEb2/csNWJST/o1rtHz+A6GN1dYg0VOz
   yZNQNGHArUTpUmqTRLdxyyBNVD77vkLG7ulc+kGhrpfEVn0qj7VXHaQvw
   6Wj+uI7ytw7r0pmT7UcEbNUFbA0WiDwxLrSKomNGNFjFVDudx/sWE2n5U
   TyXCsgeDDGS9CW+Y6f2Z9eFW382Zxkckacx1pzEhjHv0LAdME53Gz2DB+
   OKdHHz/wJXlaa3tmyZSgLqzDF3SmtmO1vtzUyegyYV9vyeuY6I2NRSgl3
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10426"; a="315143520"
X-IronPort-AV: E=Sophos;i="5.93,209,1654585200"; 
   d="scan'208";a="315143520"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Aug 2022 20:02:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,209,1654585200"; 
   d="scan'208";a="630525076"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 01 Aug 2022 20:02:01 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oIiAS-000FcJ-0w;
        Tue, 02 Aug 2022 03:02:00 +0000
Date:   Tue, 02 Aug 2022 11:01:32 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:sched/core] BUILD SUCCESS
 c17a6ff9321355487d7d5ccaa7d406a0ea06b6c4
Message-ID: <62e8938c.m8JVSS8Vkq2P10yT%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched/core
branch HEAD: c17a6ff9321355487d7d5ccaa7d406a0ea06b6c4  rseq: Kill process when unknown flags are encountered in ABI structures

elapsed time: 721m

configs tested: 74
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                             i386_defconfig
um                           x86_64_defconfig
i386                             allyesconfig
i386                                defconfig
arc                  randconfig-r043-20220801
s390                 randconfig-r044-20220801
riscv                randconfig-r042-20220801
x86_64                           allyesconfig
x86_64                               rhel-8.3
i386                 randconfig-a012-20220801
i386                 randconfig-a013-20220801
x86_64                              defconfig
powerpc                          allmodconfig
i386                 randconfig-a014-20220801
i386                 randconfig-a011-20220801
i386                 randconfig-a016-20220801
mips                             allyesconfig
x86_64                           rhel-8.3-kvm
i386                 randconfig-a015-20220801
ia64                             allmodconfig
powerpc                           allnoconfig
x86_64                    rhel-8.3-kselftests
alpha                            allyesconfig
sh                               allmodconfig
arc                              allyesconfig
x86_64                           rhel-8.3-syz
x86_64                          rhel-8.3-func
x86_64                         rhel-8.3-kunit
arm                                 defconfig
x86_64               randconfig-a011-20220801
x86_64               randconfig-a012-20220801
x86_64               randconfig-a013-20220801
m68k                             allyesconfig
m68k                             allmodconfig
x86_64               randconfig-a015-20220801
x86_64               randconfig-a014-20220801
x86_64               randconfig-a016-20220801
arm                              allyesconfig
arm64                            allyesconfig
powerpc                      ep88xc_defconfig
sh                           se7721_defconfig
powerpc                     tqm8541_defconfig
sh                           sh2007_defconfig
powerpc                   motionpro_defconfig
xtensa                  nommu_kc705_defconfig
sparc64                          alldefconfig
mips                           xway_defconfig
m68k                          amiga_defconfig
powerpc                     tqm8555_defconfig
sh                          urquell_defconfig
csky                              allnoconfig
alpha                             allnoconfig
arc                               allnoconfig
riscv                             allnoconfig
x86_64               randconfig-k001-20220801
i386                 randconfig-c001-20220801
loongarch                           defconfig
loongarch                         allnoconfig

clang tested configs:
hexagon              randconfig-r045-20220801
hexagon              randconfig-r041-20220801
i386                 randconfig-a004-20220801
i386                 randconfig-a006-20220801
i386                 randconfig-a001-20220801
i386                 randconfig-a002-20220801
i386                 randconfig-a003-20220801
x86_64               randconfig-a005-20220801
x86_64               randconfig-a002-20220801
i386                 randconfig-a005-20220801
x86_64               randconfig-a001-20220801
x86_64               randconfig-a003-20220801
x86_64               randconfig-a004-20220801
x86_64               randconfig-a006-20220801
powerpc                     akebono_defconfig
arm                   milbeaut_m10v_defconfig

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
