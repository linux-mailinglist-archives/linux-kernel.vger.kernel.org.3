Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E97FC5ABE78
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Sep 2022 12:30:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230299AbiICKaV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Sep 2022 06:30:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbiICKaS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Sep 2022 06:30:18 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A35C731232
        for <linux-kernel@vger.kernel.org>; Sat,  3 Sep 2022 03:30:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662201017; x=1693737017;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=fijWmaknD15Cx5WFZkn+0YdBVkLGxsogMnh2duoMjXA=;
  b=dY09RqEVI5IBnJWzgW8+EQDFNyfd/isa4aJ5+04h90X1JmckzTxsRoo4
   8xHPg5BgxYQnzs30GXHxYc7HE9A4UC5fFIzFCsqm1YI2tRpJic4JRuRVm
   xv93QIOG6ghPIoQM3avGb2TgRobUbVoCVKFtckPr6X3BscSZt8R4I0JEn
   bSFZ2/3b39C9yT3A9kB1g5zvDCz/yor3Ggwhqqh99xqfJCDVQUPDc+Qg7
   vwofA2G3fAP5zQI9ZFpW16mnpjRk22JgxnawPeT62LwXu9eLj747wzPql
   iaZd/2AiLRgxXl6yZkAKO332WXYrAegh6KS5kufU72H2342L6niIaxGB6
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10458"; a="276546727"
X-IronPort-AV: E=Sophos;i="5.93,287,1654585200"; 
   d="scan'208";a="276546727"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2022 03:30:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,287,1654585200"; 
   d="scan'208";a="613299572"
Received: from lkp-server02.sh.intel.com (HELO 95dfd251caa2) ([10.239.97.151])
  by orsmga002.jf.intel.com with ESMTP; 03 Sep 2022 03:30:15 -0700
Received: from kbuild by 95dfd251caa2 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oUQPn-0001T9-0z;
        Sat, 03 Sep 2022 10:30:15 +0000
Date:   Sat, 3 Sep 2022 18:30:04 +0800
From:   kernel test robot <lkp@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [peterz-queue:perf/core 38/46] include/linux/perf_event.h:643:22:
 error: '__lockdep_enabled' undeclared
Message-ID: <202209031847.nxAniAUH-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git perf/core
head:   9cbc59d1cbddfa6ecbd8fadd3205c8f21703071d
commit: 813fd841611afc9a4aba13e239e33ed0062ec673 [38/46] perf: Add a few assertions
config: arm-randconfig-s053-20220901 (https://download.01.org/0day-ci/archive/20220903/202209031847.nxAniAUH-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 12.1.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-39-gce1a6720-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git/commit/?id=813fd841611afc9a4aba13e239e33ed0062ec673
        git remote add peterz-queue https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git
        git fetch --no-tags peterz-queue perf/core
        git checkout 813fd841611afc9a4aba13e239e33ed0062ec673
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=arm SHELL=/bin/bash drivers/perf/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from arch/arm/include/asm/bug.h:60,
                    from include/linux/ktime.h:26,
                    from include/linux/hrtimer_defs.h:5,
                    from include/linux/hrtimer.h:15,
                    from drivers/perf/arm-ccn.c:8:
   drivers/perf/arm-ccn.c: In function 'arm_ccn_pmu_event_init':
>> include/linux/perf_event.h:643:22: error: '__lockdep_enabled' undeclared (first use in this function)
     643 |         WARN_ON_ONCE(__lockdep_enabled &&                       \
         |                      ^~~~~~~~~~~~~~~~~
   include/asm-generic/bug.h:167:32: note: in definition of macro 'WARN_ON'
     167 |         int __ret_warn_on = !!(condition);                              \
         |                                ^~~~~~~~~
   include/linux/perf_event.h:643:9: note: in expansion of macro 'WARN_ON_ONCE'
     643 |         WARN_ON_ONCE(__lockdep_enabled &&                       \
         |         ^~~~~~~~~~~~
   include/linux/perf_event.h:651:9: note: in expansion of macro 'lockdep_assert_event_ctx'
     651 |         lockdep_assert_event_ctx(event);                        \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~
   drivers/perf/arm-ccn.c:835:9: note: in expansion of macro 'for_each_sibling_event'
     835 |         for_each_sibling_event(sibling, event->group_leader) {
         |         ^~~~~~~~~~~~~~~~~~~~~~
   include/linux/perf_event.h:643:22: note: each undeclared identifier is reported only once for each function it appears in
     643 |         WARN_ON_ONCE(__lockdep_enabled &&                       \
         |                      ^~~~~~~~~~~~~~~~~
   include/asm-generic/bug.h:167:32: note: in definition of macro 'WARN_ON'
     167 |         int __ret_warn_on = !!(condition);                              \
         |                                ^~~~~~~~~
   include/linux/perf_event.h:643:9: note: in expansion of macro 'WARN_ON_ONCE'
     643 |         WARN_ON_ONCE(__lockdep_enabled &&                       \
         |         ^~~~~~~~~~~~
   include/linux/perf_event.h:651:9: note: in expansion of macro 'lockdep_assert_event_ctx'
     651 |         lockdep_assert_event_ctx(event);                        \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~
   drivers/perf/arm-ccn.c:835:9: note: in expansion of macro 'for_each_sibling_event'
     835 |         for_each_sibling_event(sibling, event->group_leader) {
         |         ^~~~~~~~~~~~~~~~~~~~~~
>> include/linux/perf_event.h:644:37: error: 'hardirqs_enabled' undeclared (first use in this function)
     644 |                      (this_cpu_read(hardirqs_enabled) ||        \
         |                                     ^~~~~~~~~~~~~~~~
   include/asm-generic/bug.h:167:32: note: in definition of macro 'WARN_ON'
     167 |         int __ret_warn_on = !!(condition);                              \
         |                                ^~~~~~~~~
   include/linux/perf_event.h:643:9: note: in expansion of macro 'WARN_ON_ONCE'
     643 |         WARN_ON_ONCE(__lockdep_enabled &&                       \
         |         ^~~~~~~~~~~~
   include/linux/percpu-defs.h:507:41: note: in expansion of macro '__pcpu_size_call_return'
     507 | #define this_cpu_read(pcp)              __pcpu_size_call_return(this_cpu_read_, pcp)
         |                                         ^~~~~~~~~~~~~~~~~~~~~~~
   include/linux/perf_event.h:644:23: note: in expansion of macro 'this_cpu_read'
     644 |                      (this_cpu_read(hardirqs_enabled) ||        \
         |                       ^~~~~~~~~~~~~
   include/linux/perf_event.h:651:9: note: in expansion of macro 'lockdep_assert_event_ctx'
     651 |         lockdep_assert_event_ctx(event);                        \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~
   drivers/perf/arm-ccn.c:835:9: note: in expansion of macro 'for_each_sibling_event'
     835 |         for_each_sibling_event(sibling, event->group_leader) {
         |         ^~~~~~~~~~~~~~~~~~~~~~


vim +/__lockdep_enabled +643 include/linux/perf_event.h

   634	
   635	/*
   636	 * event->sibling_list is modified whole holding both ctx->lock and ctx->mutex
   637	 * as such iteration must hold either lock. However, since ctx->lock is an IRQ
   638	 * safe lock, and is only held by the CPU doing the modification, having IRQs
   639	 * disabled is sufficient since it will hold-off the IPIs.
   640	 */
   641	#ifdef CONFIG_LOCKDEP
   642	#define lockdep_assert_event_ctx(event)				\
 > 643		WARN_ON_ONCE(__lockdep_enabled &&			\
 > 644			     (this_cpu_read(hardirqs_enabled) ||	\
   645			      lockdep_is_held(&(event)->ctx->mutex) != LOCK_STATE_HELD))
   646	#else
   647	#define lockdep_assert_event_ctx(event)
   648	#endif
   649	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
