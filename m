Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A8DA57B1D3
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 09:36:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239793AbiGTHgU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 03:36:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231389AbiGTHgT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 03:36:19 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9DDE299
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 00:36:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658302578; x=1689838578;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=Pyz6vzvgtI5GA+yFpVkJq/rQP50xlU8sDDdNDLDy5cs=;
  b=KfimpRi08GmnEv58UzPnk5eKlWTFsoA0FtPlRm6A9n6YOwvH+FNf/5AP
   4unf0dAbhmUH6U/3SKaZiX6s6GmqJCVKRok+iuiLKrgDFzrGicNDOoNCK
   eSaCRRshHv/1EAL+OgzMwnn0f6ydAYm8Onw6nA8pHlL5cbHlEFAJT5j8U
   YHuP2DWMXPSXSFSE4xi2Xd4cEQaAFsPc8yGz/wSPNtyKkXIB89+YYv/Fg
   NLbpZSEeSHSmftkI0f+luwOZudlHqE6JA/kRzJzLxQSO1eigFrnzYJo4e
   WsV21fKp1nH4tlEXVL1UiSnR++m0+jsej3LPYmtcUFp9r5VUgeta4/fwB
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10413"; a="273541399"
X-IronPort-AV: E=Sophos;i="5.92,286,1650956400"; 
   d="scan'208";a="273541399"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2022 00:36:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,286,1650956400"; 
   d="scan'208";a="548247603"
Received: from lkp-server01.sh.intel.com (HELO 7dfbdc7c7900) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 20 Jul 2022 00:36:16 -0700
Received: from kbuild by 7dfbdc7c7900 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1oE4Fj-0000Bp-19;
        Wed, 20 Jul 2022 07:36:15 +0000
Date:   Wed, 20 Jul 2022 15:35:27 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:dev.2022.07.05a] BUILD SUCCESS
 ce03eb7041c8463f1d49113f89b204a576686b17
Message-ID: <62d7b03f.XtAsAFfF5ZdRUONO%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev.2022.07.05a
branch HEAD: ce03eb7041c8463f1d49113f89b204a576686b17  rcu-tasks: Ensure RCU Tasks Trace loops have quiescent states

elapsed time: 2221m

configs tested: 18
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
m68k                             allmodconfig
alpha                            allyesconfig
arc                              allyesconfig
m68k                             allyesconfig
powerpc                           allnoconfig
powerpc                          allmodconfig
mips                             allyesconfig
sh                               allmodconfig
arc                  randconfig-r043-20220718
riscv                randconfig-r042-20220718
s390                 randconfig-r044-20220718
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                           allyesconfig

clang tested configs:
hexagon              randconfig-r041-20220718
hexagon              randconfig-r045-20220718

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
