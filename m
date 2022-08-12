Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCDC1590DFF
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 11:22:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237915AbiHLJWn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 05:22:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229739AbiHLJWk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 05:22:40 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42741A347B
        for <linux-kernel@vger.kernel.org>; Fri, 12 Aug 2022 02:22:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660296160; x=1691832160;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=wK4nFMJHMdVAATrGJ7K8fXP3aVe9nk4rsvj9chrhzG8=;
  b=V3T9HnpdhFF1MIzJuFhlENQ9LQpQq92WdSQRKpSHFPx0+sU2UmoapeWx
   u3kMt5XMrujZ5HlqwM9ThvDVwsTnNlbpJ581wBzgKn/VwFF/7obwxvHj8
   8IAUJXJmLuJdTzECLHUx06n3WJire0ZYFPINLdGMSUOMoVFylp/S1XMwQ
   fprE/e+gE3cIP+m9tQwWn7jpMVCIT1XzVXHubWllGaZ4I0KSQmwf/E6xw
   4rhb9xDL3GixT1C39H7Vfu3bMcZ5aRk5ytOWJnTm7FEeVIGRb/w+WgD6Z
   Oxn1QU05OEVirC31XYuChFQ/PpMXHuxotTg+GYE43u9tha/xE4EkSu64h
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10436"; a="271944036"
X-IronPort-AV: E=Sophos;i="5.93,231,1654585200"; 
   d="scan'208";a="271944036"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2022 02:22:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,231,1654585200"; 
   d="scan'208";a="582022474"
Received: from lkp-server02.sh.intel.com (HELO 8745164cafc7) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 12 Aug 2022 02:22:38 -0700
Received: from kbuild by 8745164cafc7 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oMQsH-0000OF-2r;
        Fri, 12 Aug 2022 09:22:37 +0000
Date:   Fri, 12 Aug 2022 17:22:05 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: [gustavoars:totally-untested/remaining-fam0] BUILD SUCCESS
 b0684d2f714f4ae515c283697c48d14e3ccef21b
Message-ID: <62f61bbd.gN27O8Cbl8z5VxS9%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git totally-untested/remaining-fam0
branch HEAD: b0684d2f714f4ae515c283697c48d14e3ccef21b  totally-untested: remaining zero-length arrays in structs in next-20220811

elapsed time: 719m

configs tested: 53
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                             i386_defconfig
um                           x86_64_defconfig
i386                          randconfig-a001
i386                          randconfig-a003
i386                          randconfig-a005
i386                                defconfig
arm                                 defconfig
arc                  randconfig-r043-20220811
arm                              allyesconfig
x86_64                        randconfig-a002
x86_64                        randconfig-a013
x86_64                        randconfig-a011
m68k                             allyesconfig
i386                             allyesconfig
x86_64                              defconfig
x86_64                        randconfig-a006
i386                          randconfig-a014
x86_64                        randconfig-a015
arm64                            allyesconfig
x86_64                           rhel-8.3-kvm
powerpc                           allnoconfig
x86_64                        randconfig-a004
x86_64                               rhel-8.3
m68k                             allmodconfig
x86_64                    rhel-8.3-kselftests
x86_64                           allyesconfig
i386                          randconfig-a012
arc                              allyesconfig
x86_64                           rhel-8.3-syz
i386                          randconfig-a016
x86_64                          rhel-8.3-func
alpha                            allyesconfig
x86_64                         rhel-8.3-kunit
sh                               allmodconfig
mips                             allyesconfig
powerpc                          allmodconfig
ia64                             allmodconfig

clang tested configs:
i386                          randconfig-a002
i386                          randconfig-a004
i386                          randconfig-a006
hexagon              randconfig-r045-20220811
hexagon              randconfig-r041-20220811
riscv                randconfig-r042-20220811
i386                          randconfig-a013
x86_64                        randconfig-a014
s390                 randconfig-r044-20220811
x86_64                        randconfig-a012
x86_64                        randconfig-a001
x86_64                        randconfig-a016
x86_64                        randconfig-a003
i386                          randconfig-a011
x86_64                        randconfig-a005
i386                          randconfig-a015

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
