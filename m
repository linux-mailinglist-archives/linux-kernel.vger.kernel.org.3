Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEEA757B33A
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 10:50:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233670AbiGTIu3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 04:50:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229714AbiGTIuY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 04:50:24 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2AEF21801
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 01:50:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658307021; x=1689843021;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=yR2qNe3Ce+3Dk3Fg2E30JpDDQ8bOKzo2Aext0N1ZWwE=;
  b=lhEdITUOmcA/rsl6OXWJmijPh26FFrrUBoRbRjFbbMk0S8CRRsJswejF
   a9hgbDCODpi5mDYVxa0x8ISmHYZBtnZaoyAgWlWzfvyzQkqMxA0xAPMgo
   hXV924f+fceYNKFWPamtSCJOq8MUiHuzURbp3WlVB5U3mAhGYL8IqLT4T
   tCzI+gBuHF9VSr0DXYyRUayRRYum66HQWKzhl8sI47tMvzRlt2sb03upo
   +njK19BeMVlEAgarJ9YLjwPblWCETgXS0yDyUtlheUz3mXISFDelEoYMr
   WwHHuWJ1a9/24xt8KX8Zju4oUWU43+gBSsjrO4l/bh5BqY7oPGZrLl+1i
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10413"; a="266496649"
X-IronPort-AV: E=Sophos;i="5.92,286,1650956400"; 
   d="scan'208";a="266496649"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2022 01:50:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,286,1650956400"; 
   d="scan'208";a="740211890"
Received: from lkp-server01.sh.intel.com (HELO 7dfbdc7c7900) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 20 Jul 2022 01:50:20 -0700
Received: from kbuild by 7dfbdc7c7900 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1oE5PP-0000Iz-CS;
        Wed, 20 Jul 2022 08:50:19 +0000
Date:   Wed, 20 Jul 2022 16:49:24 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:master] BUILD SUCCESS
 96ff3a14815bb66a2c29cf473c345f73bbc071d8
Message-ID: <62d7c194.ZBn8Yc2qmC8BiQRu%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git master
branch HEAD: 96ff3a14815bb66a2c29cf473c345f73bbc071d8  Merge x86/urgent into tip/master

elapsed time: 725m

configs tested: 68
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm                              allyesconfig
arm64                            allyesconfig
powerpc                      ep88xc_defconfig
arm                      footbridge_defconfig
x86_64                              defconfig
sh                        sh7757lcr_defconfig
loongarch                           defconfig
loongarch                         allnoconfig
ia64                             allmodconfig
csky                              allnoconfig
alpha                             allnoconfig
arc                               allnoconfig
riscv                             allnoconfig
arc                              allyesconfig
alpha                            allyesconfig
m68k                             allmodconfig
m68k                             allyesconfig
powerpc                          allmodconfig
mips                             allyesconfig
powerpc                           allnoconfig
sh                               allmodconfig
i386                                defconfig
i386                             allyesconfig
x86_64                        randconfig-a004
x86_64                        randconfig-a002
x86_64                        randconfig-a006
x86_64               randconfig-a014-20220718
x86_64               randconfig-a016-20220718
x86_64               randconfig-a012-20220718
x86_64               randconfig-a013-20220718
x86_64               randconfig-a015-20220718
x86_64               randconfig-a011-20220718
x86_64                        randconfig-a013
x86_64                        randconfig-a011
x86_64                        randconfig-a015
i386                 randconfig-a011-20220718
i386                 randconfig-a013-20220718
i386                 randconfig-a012-20220718
i386                 randconfig-a015-20220718
i386                 randconfig-a014-20220718
i386                 randconfig-a016-20220718
s390                 randconfig-r044-20220718
riscv                randconfig-r042-20220718
arc                  randconfig-r043-20220718
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                           rhel-8.3-syz
x86_64                          rhel-8.3-func
x86_64                         rhel-8.3-kunit
x86_64                    rhel-8.3-kselftests
x86_64                           allyesconfig
x86_64                               rhel-8.3

clang tested configs:
x86_64                        randconfig-k001
x86_64                        randconfig-a005
x86_64                        randconfig-a003
x86_64                        randconfig-a001
i386                 randconfig-a003-20220718
i386                 randconfig-a001-20220718
i386                 randconfig-a002-20220718
i386                 randconfig-a004-20220718
i386                 randconfig-a005-20220718
i386                 randconfig-a006-20220718
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
hexagon              randconfig-r041-20220718
hexagon              randconfig-r045-20220718

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
