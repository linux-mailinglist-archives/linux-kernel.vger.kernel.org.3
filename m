Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E87BE5ABD7B
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Sep 2022 08:41:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232458AbiICGlA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Sep 2022 02:41:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231520AbiICGk5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Sep 2022 02:40:57 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 752E683F1C
        for <linux-kernel@vger.kernel.org>; Fri,  2 Sep 2022 23:40:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662187256; x=1693723256;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=GLkS8X/L6JyR/IBCAjWP7fA2pbEBDyBvO/x518Ie630=;
  b=nppvNkhWJYOS98g57VmdA8p9EQgB/VEGBt3K6Lx1/aEELNrOeOrGRZ//
   DHvaAijfUnxUQ6t9CE5dOWNkvvdxHz0Vs/+CXRdWFh1PTuSpw0cK0LQUo
   OE4e085kSmQT7042Cuq0qOylMVpeTnM6YYbQ7fY03uDlzwc42JmWrt50o
   lKzlaZu9NMwiUvcwuhjZvr5kLrNBZZEIluH0kqqsd9EJbY8ly0KAhZBhw
   dLeE0ha7I78/JTNByx8JmVNJJcMMpI8K1FVjmQkuyjkln+ENQt+jC3Hp7
   2PMVND7e3I21LNQtaTVZh/UlV6AAlQsbHkecg65oj8DIYpHl+sKrlOfuc
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10458"; a="283125227"
X-IronPort-AV: E=Sophos;i="5.93,286,1654585200"; 
   d="scan'208";a="283125227"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2022 23:40:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,286,1654585200"; 
   d="scan'208";a="564196882"
Received: from lkp-server02.sh.intel.com (HELO 95dfd251caa2) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 02 Sep 2022 23:40:54 -0700
Received: from kbuild by 95dfd251caa2 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oUMpq-0001BY-0n;
        Sat, 03 Sep 2022 06:40:54 +0000
Date:   Sat, 03 Sep 2022 14:40:37 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/mm] BUILD SUCCESS
 c0d2e63d4c618185cdd92faae10bdde33a00c25d
Message-ID: <6312f6e5.bXP/pfoHt6oYDRmV%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/mm
branch HEAD: c0d2e63d4c618185cdd92faae10bdde33a00c25d  x86/defconfig: Enable CONFIG_DEBUG_WX=y

elapsed time: 1071m

configs tested: 57
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
alpha                            allyesconfig
arc                              allyesconfig
um                             i386_defconfig
m68k                             allmodconfig
um                           x86_64_defconfig
m68k                             allyesconfig
powerpc                           allnoconfig
arc                  randconfig-r043-20220901
powerpc                          allmodconfig
mips                             allyesconfig
sh                               allmodconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                        randconfig-a002
x86_64                           allyesconfig
i386                                defconfig
x86_64                        randconfig-a013
x86_64                        randconfig-a006
x86_64                        randconfig-a011
x86_64                        randconfig-a004
x86_64                        randconfig-a015
x86_64                          rhel-8.3-func
x86_64                         rhel-8.3-kunit
x86_64                    rhel-8.3-kselftests
i386                          randconfig-a014
x86_64                           rhel-8.3-syz
i386                             allyesconfig
i386                          randconfig-a001
x86_64                           rhel-8.3-kvm
i386                          randconfig-a012
i386                          randconfig-a003
i386                          randconfig-a016
i386                          randconfig-a005
csky                              allnoconfig
alpha                             allnoconfig
arc                               allnoconfig
riscv                             allnoconfig
arm64                            allyesconfig
arm                                 defconfig
arm                              allyesconfig
ia64                             allmodconfig

clang tested configs:
hexagon              randconfig-r041-20220901
hexagon              randconfig-r045-20220901
riscv                randconfig-r042-20220901
s390                 randconfig-r044-20220901
x86_64                        randconfig-a005
x86_64                        randconfig-a001
x86_64                        randconfig-a003
x86_64                        randconfig-a016
x86_64                        randconfig-a012
x86_64                        randconfig-a014
i386                          randconfig-a011
i386                          randconfig-a013
i386                          randconfig-a002
i386                          randconfig-a015
i386                          randconfig-a006
i386                          randconfig-a004

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
