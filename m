Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A2585A1E65
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 03:54:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244122AbiHZByr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 21:54:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243808AbiHZByp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 21:54:45 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EE1318F
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 18:54:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661478884; x=1693014884;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=9uw66TL3EmoWbnJMNC3BAYIJz1CzJLbMnk7HPgCNVLk=;
  b=d/hhWBJhCN1Ul3hm6v0FBZd8Gdoab9RybbrVHKzSUQ/1+aIHuuKQgg+v
   hEPmfaDqC0+JJVC0a/cT4yHZAmXVGcBgawa45wtHqHW7NaB1IvrgwcKCr
   YD3pZboAZR5SJWhnWoqW+7NAUeRqVkkF61938k5PePq0A0YI3uXM+sUwy
   WU+esoh7hBAVvCDVWZWdqzCrNOSttx6098wvxdnLmcfYOHXgN30Do79C0
   A4gV4d7qSY2u0d3iNI5+KFniOrkcGJ2OxsDunTxqUtehq2X7etRu2DGd+
   N8cwSvtOdKjRdUESANqLh0lwtxTszlGY9K6HiyQS7ZsoYKVYV7Bci49eH
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10450"; a="358368196"
X-IronPort-AV: E=Sophos;i="5.93,264,1654585200"; 
   d="scan'208";a="358368196"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2022 18:54:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,264,1654585200"; 
   d="scan'208";a="587123266"
Received: from lkp-server02.sh.intel.com (HELO 34e741d32628) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 25 Aug 2022 18:54:42 -0700
Received: from kbuild by 34e741d32628 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oROYU-0003Eo-0G;
        Fri, 26 Aug 2022 01:54:42 +0000
Date:   Fri, 26 Aug 2022 09:54:23 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:rcu/next] BUILD SUCCESS
 942703b9450e92b05eec4efb1a32ebecff1d2852
Message-ID: <630827cf.3BHuNwxL2ELFnyOz%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git rcu/next
branch HEAD: 942703b9450e92b05eec4efb1a32ebecff1d2852  rcutorture: Limit read-side polling-API testing

elapsed time: 1390m

configs tested: 70
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                             i386_defconfig
um                           x86_64_defconfig
powerpc                           allnoconfig
powerpc                          allmodconfig
mips                             allyesconfig
i386                                defconfig
arc                  randconfig-r043-20220823
sh                               allmodconfig
i386                          randconfig-a001
m68k                             allmodconfig
i386                          randconfig-a003
arc                              allyesconfig
x86_64                        randconfig-a004
x86_64                        randconfig-a013
alpha                            allyesconfig
i386                             allyesconfig
x86_64                        randconfig-a002
x86_64                        randconfig-a011
m68k                             allyesconfig
x86_64                        randconfig-a015
i386                          randconfig-a005
x86_64                        randconfig-a006
loongarch                         allnoconfig
loongarch                           defconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                           allyesconfig
i386                          randconfig-a014
i386                          randconfig-a012
i386                          randconfig-a016
arc                                 defconfig
s390                             allmodconfig
arm                                 defconfig
alpha                               defconfig
s390                                defconfig
s390                             allyesconfig
arm                              allyesconfig
arm64                            allyesconfig
ia64                             allmodconfig
x86_64                          rhel-8.3-func
x86_64                         rhel-8.3-kunit
x86_64                           rhel-8.3-kvm
x86_64                    rhel-8.3-kselftests
arc                  randconfig-r043-20220825
x86_64                           rhel-8.3-syz
arc                  randconfig-r043-20220824
riscv                randconfig-r042-20220824
s390                 randconfig-r044-20220824

clang tested configs:
hexagon              randconfig-r041-20220823
hexagon              randconfig-r045-20220823
riscv                randconfig-r042-20220823
s390                 randconfig-r044-20220823
x86_64                        randconfig-a016
x86_64                        randconfig-a012
x86_64                        randconfig-a001
i386                          randconfig-a002
x86_64                        randconfig-a014
i386                          randconfig-a006
x86_64                        randconfig-a003
i386                          randconfig-a004
x86_64                        randconfig-a005
i386                          randconfig-a013
i386                          randconfig-a011
i386                          randconfig-a015
hexagon              randconfig-r041-20220825
hexagon              randconfig-r045-20220825
riscv                randconfig-r042-20220825
s390                 randconfig-r044-20220825
hexagon              randconfig-r041-20220824
hexagon              randconfig-r045-20220824

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
