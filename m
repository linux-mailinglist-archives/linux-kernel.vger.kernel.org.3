Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E07CA5AC07A
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Sep 2022 20:04:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232313AbiICSEE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Sep 2022 14:04:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231518AbiICSEB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Sep 2022 14:04:01 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C35EF4AD5A
        for <linux-kernel@vger.kernel.org>; Sat,  3 Sep 2022 11:03:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662228239; x=1693764239;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=GJyW9Ah4DVm7zRFlwy/uEwtjL86dBqZzcZ7SzWA0nps=;
  b=JDeCwZSoiF3PTVv71EDV979OU+0FsgrxVuBgsntZWZ1gP+Ev9OTkQABA
   FAGF1DxkeiwSko2zriH94nMrTNGNgAac1fAk4P6eF17X5sQd5bWSG0PNV
   XbeyxxvTPbpl/M/o1TmroADB9JYNFsmfYBXzyS5Dlvd42eGeqTOxdPV6s
   4kUh2O0OX3otsxYM7gxnyOQTp1kLmbWEQMwOPA+fEXtwZ1W70Q5gh9DRs
   YFdj3FO6LIjRED8+fOjggRLV7Hk10w9dlyA7A/JGym49K94lMJAE2o1lI
   esR1xxy7PvDK2bVs3BwdrN+ViSPtu20toFnoJvCrP1s5kr+8+0yFaPgHr
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10459"; a="276573989"
X-IronPort-AV: E=Sophos;i="5.93,287,1654585200"; 
   d="scan'208";a="276573989"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2022 11:03:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,287,1654585200"; 
   d="scan'208";a="643310654"
Received: from lkp-server02.sh.intel.com (HELO 95dfd251caa2) ([10.239.97.151])
  by orsmga008.jf.intel.com with ESMTP; 03 Sep 2022 11:03:58 -0700
Received: from kbuild by 95dfd251caa2 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oUXUr-00020L-1d;
        Sat, 03 Sep 2022 18:03:57 +0000
Date:   Sun, 04 Sep 2022 02:03:47 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:rcu/next] BUILD SUCCESS
 5951fa40eb5f082ad042bec6dc7f574f660a020d
Message-ID: <63139703.pyKddepAXufnnoqG%lkp@intel.com>
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
branch HEAD: 5951fa40eb5f082ad042bec6dc7f574f660a020d  rcu: Remove duplicate RCU exp QS report from rcu_report_dead()

elapsed time: 2844m

configs tested: 58
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                              defconfig
arc                  randconfig-r043-20220901
powerpc                          allmodconfig
sh                               allmodconfig
arc                              allyesconfig
mips                             allyesconfig
x86_64                               rhel-8.3
alpha                            allyesconfig
powerpc                           allnoconfig
m68k                             allyesconfig
m68k                             allmodconfig
x86_64                           allyesconfig
x86_64                        randconfig-a013
x86_64                        randconfig-a011
i386                          randconfig-a014
x86_64                        randconfig-a015
i386                          randconfig-a001
i386                          randconfig-a012
x86_64                          rhel-8.3-func
x86_64                         rhel-8.3-kunit
x86_64                    rhel-8.3-kselftests
x86_64                           rhel-8.3-syz
i386                          randconfig-a003
x86_64                           rhel-8.3-kvm
i386                          randconfig-a005
i386                          randconfig-a016
x86_64                        randconfig-a004
x86_64                        randconfig-a002
x86_64                        randconfig-a006
i386                                defconfig
i386                             allyesconfig
arm                                 defconfig
arm                              allyesconfig
arm64                            allyesconfig
arc                  randconfig-r043-20220904
riscv                randconfig-r042-20220904
s390                 randconfig-r044-20220904
ia64                             allmodconfig

clang tested configs:
riscv                randconfig-r042-20220901
hexagon              randconfig-r045-20220901
hexagon              randconfig-r041-20220901
s390                 randconfig-r044-20220901
x86_64                        randconfig-a012
x86_64                        randconfig-a016
x86_64                        randconfig-a014
i386                          randconfig-a002
i386                          randconfig-a013
i386                          randconfig-a004
i386                          randconfig-a006
i386                          randconfig-a015
i386                          randconfig-a011
x86_64                        randconfig-a001
x86_64                        randconfig-a003
x86_64                        randconfig-a005
hexagon              randconfig-r045-20220904
hexagon              randconfig-r041-20220904

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
