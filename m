Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8399A58978C
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 07:51:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238951AbiHDFvt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 01:51:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237036AbiHDFvq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 01:51:46 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 206CA37191
        for <linux-kernel@vger.kernel.org>; Wed,  3 Aug 2022 22:51:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659592306; x=1691128306;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=8fB1D09AZdrP7jqodd3rBMtmcpn/1XHVNAJM4ldqsyM=;
  b=eOEZ/JAKMaTHrWrLH3Skebzr7aosrYUCH0NC+Og1C897RRyj27zxYdvo
   JMfIKhRGOPxYhcDZRe7Yopkz+NocCzK3Iyq1nCms8DWI97vS/pUSrCJtz
   6zTOFPzrgovCIvw7Uj6iQ2vG5jGhobcSZ6EJONWpqT4BnQHamDWq8LkE2
   0w/noDMo/s45z4bCFhQ44O1FZ9qxKYmWdXZJ9HhPe8rhKBuZjtdzOVV9Q
   JZBwHhLMU+Rk/Kadm3ZfiZud6wd7x46VFFAc6wHTcD05seAKxrmvHQ4Vx
   7ky6ZsqSfRDFykGPTREWcKWK+/CMLAJoWP3g9gLtbOWNo6y7chPCX/ws/
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10428"; a="290620422"
X-IronPort-AV: E=Sophos;i="5.93,214,1654585200"; 
   d="scan'208";a="290620422"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2022 22:51:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,214,1654585200"; 
   d="scan'208";a="745334307"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 03 Aug 2022 22:51:40 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oJTlj-000I4K-2W;
        Thu, 04 Aug 2022 05:51:39 +0000
Date:   Thu, 04 Aug 2022 13:50:58 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:master] BUILD SUCCESS
 7f8c1679960a1057e0573a846887d54396396910
Message-ID: <62eb5e42.aPzWp7yFwgvr7EXU%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git master
branch HEAD: 7f8c1679960a1057e0573a846887d54396396910  Merge branch into tip/master: 'x86/sgx'

elapsed time: 719m

configs tested: 54
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                             i386_defconfig
um                           x86_64_defconfig
m68k                             allmodconfig
arc                              allyesconfig
alpha                            allyesconfig
m68k                             allyesconfig
i386                                defconfig
x86_64                           rhel-8.3-kvm
x86_64                    rhel-8.3-kselftests
i386                             allyesconfig
x86_64                           rhel-8.3-syz
x86_64                          rhel-8.3-func
powerpc                           allnoconfig
x86_64                         rhel-8.3-kunit
arc                  randconfig-r043-20220803
x86_64                        randconfig-a013
x86_64                              defconfig
x86_64                        randconfig-a011
riscv                randconfig-r042-20220803
x86_64                           allyesconfig
x86_64                        randconfig-a015
x86_64                               rhel-8.3
s390                 randconfig-r044-20220803
x86_64                        randconfig-a004
x86_64                        randconfig-a002
sh                               allmodconfig
x86_64                        randconfig-a006
mips                             allyesconfig
i386                          randconfig-a001
arm                                 defconfig
i386                          randconfig-a003
i386                          randconfig-a005
ia64                             allmodconfig
i386                          randconfig-a014
i386                          randconfig-a012
i386                          randconfig-a016
arm                              allyesconfig
arm64                            allyesconfig
powerpc                          allmodconfig
arc                  randconfig-r043-20220804

clang tested configs:
x86_64                        randconfig-a012
hexagon              randconfig-r041-20220803
hexagon              randconfig-r045-20220803
x86_64                        randconfig-a014
x86_64                        randconfig-a016
x86_64                        randconfig-a001
x86_64                        randconfig-a003
x86_64                        randconfig-a005
i386                          randconfig-a002
i386                          randconfig-a004
i386                          randconfig-a013
i386                          randconfig-a006
i386                          randconfig-a011
i386                          randconfig-a015

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
