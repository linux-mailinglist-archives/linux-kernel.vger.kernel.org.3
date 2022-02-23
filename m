Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19AAA4C1C52
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 20:36:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242787AbiBWThT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 14:37:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232358AbiBWThQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 14:37:16 -0500
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 933CA344CD
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 11:36:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645645007; x=1677181007;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=2zmfYt4EdwabPNOzPi87WTUglmkIqLUynWqzZQqp2CQ=;
  b=JTq4trmZVK3FLRQdXIUVMMDL9+pAQD8yuBdnqT0pUikN6ZoPwaBYysCR
   vkeqtJgLYUEz0LUVWliW0op+jIjYk5NuPRt2vOvpYZqjS4qnnkHGGCsTJ
   OmA6rOgDugS54BHi8AWKH8qB5Z4WEiYMu+f6S6mm9DNjUZzYBT9xNdGPz
   iwQ4NmwmMSU/0ea/kFltqvm9d+Kow5WS8vQ0E7Zziwd87KEqex3GaIpLm
   V616Zm/jnPhob3MhsJAVz8I+w5q/ccTv2IBCw3IbvaudXiB80JeyeSWje
   9lQEeRemLVjyOkBTJk77Y2Sm62DIwYyCWkjoCE2mjPLYoXvCbmmnjUB8H
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10267"; a="312781512"
X-IronPort-AV: E=Sophos;i="5.88,391,1635231600"; 
   d="scan'208";a="312781512"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2022 11:36:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,391,1635231600"; 
   d="scan'208";a="532819952"
Received: from lkp-server01.sh.intel.com (HELO 788b1cd46f0d) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 23 Feb 2022 11:36:45 -0800
Received: from kbuild by 788b1cd46f0d with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nMxRM-0001kB-Lk; Wed, 23 Feb 2022 19:36:44 +0000
Date:   Thu, 24 Feb 2022 03:36:10 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [mingo-tip:sched/headers 1897/2340] net/smc/smc.h:284:44: error: use
 of undeclared identifier 'SK_USER_DATA_NOCOPY'
Message-ID: <202202240341.mxu0MQrq-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git sched/headers
head:   97c5eeb4de3ad324ed2a4656b46465299cfd010a
commit: 5c5994d6ff9b0f6c42142054bd317726ff1d9ef4 [1897/2340] headers/deps: net: Optimize <net/inet_timewait_sock.h> dependencies
config: i386-randconfig-a013 (https://download.01.org/0day-ci/archive/20220224/202202240341.mxu0MQrq-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project d271fc04d5b97b12e6b797c6067d3c96a8d7470e)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git/commit/?id=5c5994d6ff9b0f6c42142054bd317726ff1d9ef4
        git remote add mingo-tip git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git
        git fetch --no-tags mingo-tip sched/headers
        git checkout 5c5994d6ff9b0f6c42142054bd317726ff1d9ef4
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash net/dsa/ net/smc/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

Note: the mingo-tip/sched/headers HEAD 97c5eeb4de3ad324ed2a4656b46465299cfd010a builds fine.
      It only hurts bisectability.

All errors (new ones prefixed by >>):

   In file included from net/smc/smc_wr.c:40:
>> net/smc/smc.h:284:44: error: use of undeclared identifier 'SK_USER_DATA_NOCOPY'
                  ((uintptr_t)clcsk->sk_user_data & ~SK_USER_DATA_NOCOPY);
                                                     ^
   1 error generated.
--
   In file included from net/smc/smc_tracepoint.c:4:
   In file included from net/smc/smc_tracepoint.h:13:
>> net/smc/smc.h:284:44: error: use of undeclared identifier 'SK_USER_DATA_NOCOPY'
                  ((uintptr_t)clcsk->sk_user_data & ~SK_USER_DATA_NOCOPY);
                                                     ^
   In file included from net/smc/smc_tracepoint.c:4:
   In file included from net/smc/smc_tracepoint.h:125:
   include/trace/define_trace.h:95:10: fatal error: './smc_tracepoint.h' file not found
   #include TRACE_INCLUDE(TRACE_INCLUDE_FILE)
            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/trace/define_trace.h:90:32: note: expanded from macro 'TRACE_INCLUDE'
   # define TRACE_INCLUDE(system) __TRACE_INCLUDE(system)
                                  ^~~~~~~~~~~~~~~~~~~~~~~
   include/trace/define_trace.h:87:34: note: expanded from macro '__TRACE_INCLUDE'
   # define __TRACE_INCLUDE(system) __stringify(TRACE_INCLUDE_PATH/system.h)
                                    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/stringify.h:10:27: note: expanded from macro '__stringify'
   #define __stringify(x...)       __stringify_1(x)
                                   ^~~~~~~~~~~~~~~~
   include/linux/stringify.h:9:29: note: expanded from macro '__stringify_1'
   #define __stringify_1(x...)     #x
                                   ^~
   <scratch space>:113:1: note: expanded from here
   "./smc_tracepoint.h"
   ^~~~~~~~~~~~~~~~~~~~
   2 errors generated.


vim +/SK_USER_DATA_NOCOPY +284 net/smc/smc.h

ac7138746e1413 Ursula Braun 2017-01-09  280  
341adeec9adad0 Wen Gu       2022-01-26  281  static inline struct smc_sock *smc_clcsock_user_data(struct sock *clcsk)
341adeec9adad0 Wen Gu       2022-01-26  282  {
341adeec9adad0 Wen Gu       2022-01-26  283  	return (struct smc_sock *)
341adeec9adad0 Wen Gu       2022-01-26 @284  	       ((uintptr_t)clcsk->sk_user_data & ~SK_USER_DATA_NOCOPY);
341adeec9adad0 Wen Gu       2022-01-26  285  }
341adeec9adad0 Wen Gu       2022-01-26  286  

:::::: The code at line 284 was first introduced by commit
:::::: 341adeec9adad0874f29a0a1af35638207352a39 net/smc: Forward wakeup to smc socket waitqueue after fallback

:::::: TO: Wen Gu <guwen@linux.alibaba.com>
:::::: CC: David S. Miller <davem@davemloft.net>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
