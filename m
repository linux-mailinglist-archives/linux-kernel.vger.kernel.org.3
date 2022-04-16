Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10215503316
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Apr 2022 07:48:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230079AbiDPEwZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Apr 2022 00:52:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230023AbiDPEwX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Apr 2022 00:52:23 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1216D641F
        for <linux-kernel@vger.kernel.org>; Fri, 15 Apr 2022 21:49:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650084591; x=1681620591;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=ZE0FuEH1U8sy+LHGm3mYSEByWihXAOsWmYB6ffNtJdI=;
  b=Kdt+EdA+Xa0i48De6D19N8wUezbzsDqQvy8aYdmp6tZFaAZB28hVDiFK
   m+/4FZgSDQ2RdkPz1IZvhyyqVSLYrl5G34JvkN6GrfTUisU5pd1Xfh0ZP
   Yt2vmYMVvj92SyZMftw6xAuGA2Na7pMb3Z8vp+iE+iw0yccLtAaMsczjU
   nlNrNrOtpKhfd9G4Ge+XsZkarTM2jk3Ax2vaqCeVFgwQBICdAuwG8Wq37
   9LKqZYh/7vO5SXyDFPsgRirBgvtRqXUGldnIblQMQc7WXv/2xJyARp8rk
   W56pBy2F3bUifbINB2c83BqCGTEzlDROQU5n3DcYOJEaSb6HHQKEGyDBM
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10318"; a="260866117"
X-IronPort-AV: E=Sophos;i="5.90,264,1643702400"; 
   d="scan'208";a="260866117"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2022 21:49:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,264,1643702400"; 
   d="scan'208";a="726013779"
Received: from lkp-server01.sh.intel.com (HELO 3abc53900bec) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 15 Apr 2022 21:49:49 -0700
Received: from kbuild by 3abc53900bec with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nfaNY-0002mb-IE;
        Sat, 16 Apr 2022 04:49:48 +0000
Date:   Sat, 16 Apr 2022 12:49:31 +0800
From:   kernel test robot <lkp@intel.com>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [mcgrof:sysctl-testing 21/24] kernel/trace/ftrace.c:7884:2: error:
 use of undeclared identifier 'saved_ftrace_func'
Message-ID: <202204161223.q212wtZL-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux.git sysctl-testing
head:   f219482651c5469dd3a6fab22c7be9fb763c26ef
commit: ae3e836e7177c547d2ae3f51d20208462e623c57 [21/24] ftrace: fix building with SYSCTL=n but DYNAMIC_FTRACE=y
config: x86_64-randconfig-a001 (https://download.01.org/0day-ci/archive/20220416/202204161223.q212wtZL-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 8e43cbab33765c476337571e5ed11b005199dd0d)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux.git/commit/?id=ae3e836e7177c547d2ae3f51d20208462e623c57
        git remote add mcgrof https://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux.git
        git fetch --no-tags mcgrof sysctl-testing
        git checkout ae3e836e7177c547d2ae3f51d20208462e623c57
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> kernel/trace/ftrace.c:7884:2: error: use of undeclared identifier 'saved_ftrace_func'
           saved_ftrace_func = NULL;
           ^
>> kernel/trace/ftrace.c:7886:6: error: use of undeclared identifier 'ftrace_start_up'
           if (ftrace_start_up) {
               ^
>> kernel/trace/ftrace.c:7887:13: error: use of undeclared identifier 'FTRACE_UPDATE_CALLS'
                   command = FTRACE_UPDATE_CALLS;
                             ^
>> kernel/trace/ftrace.c:7889:15: error: use of undeclared identifier 'FTRACE_START_FUNC_RET'
                           command |= FTRACE_START_FUNC_RET;
                                      ^
>> kernel/trace/ftrace.c:7890:3: error: implicit declaration of function 'ftrace_startup_enable' is invalid in C99 [-Werror,-Wimplicit-function-declaration]
                   ftrace_startup_enable(command);
                   ^
   kernel/trace/ftrace.c:7890:3: note: did you mean 'ftrace_startup_all'?
   kernel/trace/ftrace.c:7234:20: note: 'ftrace_startup_all' declared here
   static inline void ftrace_startup_all(int command) { }
                      ^
   kernel/trace/ftrace.c:7902:6: error: use of undeclared identifier 'ftrace_start_up'
           if (ftrace_start_up) {
               ^
>> kernel/trace/ftrace.c:7903:13: error: use of undeclared identifier 'FTRACE_DISABLE_CALLS'
                   command = FTRACE_DISABLE_CALLS;
                             ^
>> kernel/trace/ftrace.c:7905:15: error: use of undeclared identifier 'FTRACE_STOP_FUNC_RET'
                           command |= FTRACE_STOP_FUNC_RET;
                                      ^
>> kernel/trace/ftrace.c:7906:3: error: implicit declaration of function 'ftrace_run_update_code' is invalid in C99 [-Werror,-Wimplicit-function-declaration]
                   ftrace_run_update_code(command);
                   ^
   9 errors generated.


vim +/saved_ftrace_func +7884 kernel/trace/ftrace.c

  7874	
  7875	#ifdef CONFIG_SYSCTL
  7876	static void ftrace_startup_sysctl(void)
  7877	{
  7878		int command;
  7879	
  7880		if (unlikely(ftrace_disabled))
  7881			return;
  7882	
  7883		/* Force update next time */
> 7884		saved_ftrace_func = NULL;
  7885		/* ftrace_start_up is true if we want ftrace running */
> 7886		if (ftrace_start_up) {
> 7887			command = FTRACE_UPDATE_CALLS;
  7888			if (ftrace_graph_active)
> 7889				command |= FTRACE_START_FUNC_RET;
> 7890			ftrace_startup_enable(command);
  7891		}
  7892	}
  7893	
  7894	static void ftrace_shutdown_sysctl(void)
  7895	{
  7896		int command;
  7897	
  7898		if (unlikely(ftrace_disabled))
  7899			return;
  7900	
  7901		/* ftrace_start_up is true if ftrace is running */
  7902		if (ftrace_start_up) {
> 7903			command = FTRACE_DISABLE_CALLS;
  7904			if (ftrace_graph_active)
> 7905				command |= FTRACE_STOP_FUNC_RET;
> 7906			ftrace_run_update_code(command);
  7907		}
  7908	}
  7909	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
