Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADCE251592F
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Apr 2022 01:56:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381845AbiD2X7v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 19:59:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345729AbiD2X7t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 19:59:49 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1460F2B1A9
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 16:56:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651276590; x=1682812590;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=h9FcGcVtvJBwLlMdmU+fvN9kgL7m36MVzocVRQWblJs=;
  b=IU2hdeprezFYlwqglqRaMVvpqzvjJCk8Vq1e16CtJoc++xZOciTDQQxt
   9OC8UQ6kOls+vgvkF5p2nHBmW52STmzHG8+JL1loVm1wcKdspnG7ypvhH
   LAouxxOADKIzTMOaWEqel7hxF6ImDbKcqzVrTEeFRrkewiLHlmP/HeyM9
   nYbFfMqSnt9Fkg6p1yePtXmpjcxLzjLxrYPMAZfmIIWDvDCD7oNhl1DDh
   5NbIBxe5cbolnMzJhoV/58NsdeEqU6cnroQWSOpIJnz5ydFUEfgMGlpD9
   f2E/RTfojsFF5NPxWyI4SYK+Uw7KoY4km5uGktGdTefcgw3Jq/pGmZXMa
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10332"; a="264386032"
X-IronPort-AV: E=Sophos;i="5.91,186,1647327600"; 
   d="scan'208";a="264386032"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2022 16:56:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,186,1647327600"; 
   d="scan'208";a="597584611"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 29 Apr 2022 16:56:26 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nkaTK-0006h7-67;
        Fri, 29 Apr 2022 23:56:26 +0000
Date:   Sat, 30 Apr 2022 07:56:13 +0800
From:   kernel test robot <lkp@intel.com>
To:     Chengming Zhou <zhouchengming@bytedance.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>
Subject: [mark:arm64/ftrace/per-callsite-ops 1/6]
 kernel/trace/fgraph.c:37:12: warning: no previous prototype for
 'ftrace_enable_ftrace_graph_caller'
Message-ID: <202204300758.ces9aD6G-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git arm64/ftrace/per-callsite-ops
head:   2aaba224d039a36f7eca5ad68c77686d3546e4fa
commit: 718b0fd1ccf6f04340cb3ad48b667ca05bb7a31c [1/6] ftrace: cleanup ftrace_graph_caller enable and disable
config: sh-buildonly-randconfig-r002-20220428 (https://download.01.org/0day-ci/archive/20220430/202204300758.ces9aD6G-lkp@intel.com/config)
compiler: sh4-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git/commit/?id=718b0fd1ccf6f04340cb3ad48b667ca05bb7a31c
        git remote add mark https://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git
        git fetch --no-tags mark arm64/ftrace/per-callsite-ops
        git checkout 718b0fd1ccf6f04340cb3ad48b667ca05bb7a31c
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=sh SHELL=/bin/bash kernel/trace/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> kernel/trace/fgraph.c:37:12: warning: no previous prototype for 'ftrace_enable_ftrace_graph_caller' [-Wmissing-prototypes]
      37 | int __weak ftrace_enable_ftrace_graph_caller(void)
         |            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> kernel/trace/fgraph.c:46:12: warning: no previous prototype for 'ftrace_disable_ftrace_graph_caller' [-Wmissing-prototypes]
      46 | int __weak ftrace_disable_ftrace_graph_caller(void)
         |            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   kernel/trace/fgraph.c:241:15: warning: no previous prototype for 'ftrace_return_to_handler' [-Wmissing-prototypes]
     241 | unsigned long ftrace_return_to_handler(unsigned long frame_pointer)
         |               ^~~~~~~~~~~~~~~~~~~~~~~~
   kernel/trace/fgraph.c:356:6: warning: no previous prototype for 'ftrace_graph_sleep_time_control' [-Wmissing-prototypes]
     356 | void ftrace_graph_sleep_time_control(bool enable)
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


vim +/ftrace_enable_ftrace_graph_caller +37 kernel/trace/fgraph.c

    32	
    33	/*
    34	 * archs can override this function if they must do something
    35	 * to enable hook for graph tracer.
    36	 */
  > 37	int __weak ftrace_enable_ftrace_graph_caller(void)
    38	{
    39		return 0;
    40	}
    41	
    42	/*
    43	 * archs can override this function if they must do something
    44	 * to disable hook for graph tracer.
    45	 */
  > 46	int __weak ftrace_disable_ftrace_graph_caller(void)
    47	{
    48		return 0;
    49	}
    50	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
