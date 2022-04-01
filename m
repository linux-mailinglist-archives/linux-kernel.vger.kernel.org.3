Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 909964EEE79
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 15:50:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346482AbiDANwB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 09:52:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230238AbiDANwA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 09:52:00 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F33E18BCFA
        for <linux-kernel@vger.kernel.org>; Fri,  1 Apr 2022 06:50:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648821011; x=1680357011;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=77yhwsYWPsiqHHfA6moAiSeRKcbYgu3opG1tlGvuejE=;
  b=QFXgK5Go24Bxkg1DJ/CqDLXEFE6nhb9gnRUz8Wi5LKzpLBPHmNqaTNci
   ocRj7ji5LN7AVAemBLRwVRnPPMpiEEY8/j7oPoIKSuf3X5+cPLnv81TX/
   Gq7Nu///eD9LazyfOSxQkdEBJNMP3pIfz40l7+IDcapxDOVnN18Wr/m9n
   h7kBVZa65r9G/M5HZdbD+wtPvmekVK+KLUSAgKsRnevPLZ2SU49mQ2cnw
   YC1r8qU0rqzvVQD0JZl4cCgO/HNjgSXzRS8htmCJeIrnELRy1e1ebwoJT
   UC6vjzjiAimyEmwUgcN02WiVgPq9URe4SOnya/vVygktUyvE3hqhb0Shh
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10304"; a="240731965"
X-IronPort-AV: E=Sophos;i="5.90,227,1643702400"; 
   d="scan'208";a="240731965"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2022 06:50:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,227,1643702400"; 
   d="scan'208";a="521408614"
Received: from lkp-server02.sh.intel.com (HELO 3231c491b0e2) ([10.239.97.151])
  by orsmga002.jf.intel.com with ESMTP; 01 Apr 2022 06:50:09 -0700
Received: from kbuild by 3231c491b0e2 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1naHfF-0001Hw-0H;
        Fri, 01 Apr 2022 13:50:09 +0000
Date:   Fri, 01 Apr 2022 21:49:23 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/mm] BUILD SUCCESS
 e1300d97cbc347d319adfa0976be723ada4b582c
Message-ID: <624702e3.gDsgaVv76nwbYq1/%lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/mm
branch HEAD: e1300d97cbc347d319adfa0976be723ada4b582c  x86/mm/tlb: Revert retpoline avoidance approach

elapsed time: 760m

configs tested: 38
configs skipped: 84

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
i386                          randconfig-c001
x86_64                        randconfig-c001
i386                              debian-10.3
i386                                defconfig
i386                   debian-10.3-kselftests
i386                             allyesconfig
x86_64                        randconfig-a004
x86_64                        randconfig-a002
x86_64                        randconfig-a006
i386                          randconfig-a001
i386                          randconfig-a003
i386                          randconfig-a005
x86_64                        randconfig-a013
x86_64                        randconfig-a011
x86_64                        randconfig-a015
i386                          randconfig-a012
i386                          randconfig-a016
i386                          randconfig-a014
x86_64                              defconfig
x86_64                           allyesconfig
x86_64                                  kexec
x86_64                          rhel-8.3-func
x86_64                               rhel-8.3
x86_64                         rhel-8.3-kunit
x86_64                    rhel-8.3-kselftests

clang tested configs:
x86_64                        randconfig-c007
i386                          randconfig-c001
x86_64                        randconfig-a001
x86_64                        randconfig-a003
x86_64                        randconfig-a005
i386                          randconfig-a002
i386                          randconfig-a004
i386                          randconfig-a006
x86_64                        randconfig-a014
x86_64                        randconfig-a012
x86_64                        randconfig-a016
i386                          randconfig-a013
i386                          randconfig-a011
i386                          randconfig-a015

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
