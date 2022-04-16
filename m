Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C15750335E
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Apr 2022 07:48:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230095AbiDPEe1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Apr 2022 00:34:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230024AbiDPEeU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Apr 2022 00:34:20 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55F6F5F54
        for <linux-kernel@vger.kernel.org>; Fri, 15 Apr 2022 21:31:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650083510; x=1681619510;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=xX/oOsAAWB0bR76btmtu7h3T848IFJe2Mj+NKJjjZRg=;
  b=mgD/pm20hvSEDpJ7WaF4Ot2eZ6ezstClmA1vUgJEerT+aMEk8znFS3wW
   kZNDXCABg5FETXR+ZaIcM3d6gcEDO92F5T59rqblymr7UPYVvFslbEEEN
   UYYB2FSiVQ5HccvMbM5etGiGoVHrqH+77Lgn0Ur8hITGI/PXCH0M6K5bU
   2laVyILqE2gQf2alCpqCU4v6HFneduasIt33B2Bbx2HzEEvguJQmQdYvq
   Jf+4nZcZBCGHT31A3of63unOefHm2BSOaBAaixORk8rU74aIftDGh/kry
   wmAResT5buEwq1vVtAkLorJauKlRuckO17LXb6oNT4MMKAgS730QRb2pG
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10318"; a="349717866"
X-IronPort-AV: E=Sophos;i="5.90,264,1643702400"; 
   d="scan'208";a="349717866"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2022 21:31:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,264,1643702400"; 
   d="scan'208";a="528170939"
Received: from lkp-server01.sh.intel.com (HELO 3abc53900bec) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 15 Apr 2022 21:31:48 -0700
Received: from kbuild by 3abc53900bec with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nfa67-0002lx-R7;
        Sat, 16 Apr 2022 04:31:47 +0000
Date:   Sat, 16 Apr 2022 12:30:45 +0800
From:   kernel test robot <lkp@intel.com>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [mcgrof:sysctl-testing 21/24] kernel/trace/ftrace.c:7884:9: error:
 'saved_ftrace_func' undeclared
Message-ID: <202204161203.6dSlgKJX-lkp@intel.com>
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

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux.git sysctl-testing
head:   f219482651c5469dd3a6fab22c7be9fb763c26ef
commit: ae3e836e7177c547d2ae3f51d20208462e623c57 [21/24] ftrace: fix building with SYSCTL=n but DYNAMIC_FTRACE=y
config: xtensa-allyesconfig (https://download.01.org/0day-ci/archive/20220416/202204161203.6dSlgKJX-lkp@intel.com/config)
compiler: xtensa-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux.git/commit/?id=ae3e836e7177c547d2ae3f51d20208462e623c57
        git remote add mcgrof https://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux.git
        git fetch --no-tags mcgrof sysctl-testing
        git checkout ae3e836e7177c547d2ae3f51d20208462e623c57
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=xtensa SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   kernel/trace/ftrace.c: In function 'ftrace_startup_sysctl':
>> kernel/trace/ftrace.c:7884:9: error: 'saved_ftrace_func' undeclared (first use in this function)
    7884 |         saved_ftrace_func = NULL;
         |         ^~~~~~~~~~~~~~~~~
   kernel/trace/ftrace.c:7884:9: note: each undeclared identifier is reported only once for each function it appears in
>> kernel/trace/ftrace.c:7886:13: error: 'ftrace_start_up' undeclared (first use in this function); did you mean 'ftrace_startup'?
    7886 |         if (ftrace_start_up) {
         |             ^~~~~~~~~~~~~~~
         |             ftrace_startup
>> kernel/trace/ftrace.c:7887:27: error: 'FTRACE_UPDATE_CALLS' undeclared (first use in this function)
    7887 |                 command = FTRACE_UPDATE_CALLS;
         |                           ^~~~~~~~~~~~~~~~~~~
>> kernel/trace/ftrace.c:7889:36: error: 'FTRACE_START_FUNC_RET' undeclared (first use in this function)
    7889 |                         command |= FTRACE_START_FUNC_RET;
         |                                    ^~~~~~~~~~~~~~~~~~~~~
>> kernel/trace/ftrace.c:7890:17: error: implicit declaration of function 'ftrace_startup_enable'; did you mean 'ftrace_startup_all'? [-Werror=implicit-function-declaration]
    7890 |                 ftrace_startup_enable(command);
         |                 ^~~~~~~~~~~~~~~~~~~~~
         |                 ftrace_startup_all
   kernel/trace/ftrace.c: In function 'ftrace_shutdown_sysctl':
   kernel/trace/ftrace.c:7902:13: error: 'ftrace_start_up' undeclared (first use in this function); did you mean 'ftrace_startup'?
    7902 |         if (ftrace_start_up) {
         |             ^~~~~~~~~~~~~~~
         |             ftrace_startup
>> kernel/trace/ftrace.c:7903:27: error: 'FTRACE_DISABLE_CALLS' undeclared (first use in this function)
    7903 |                 command = FTRACE_DISABLE_CALLS;
         |                           ^~~~~~~~~~~~~~~~~~~~
>> kernel/trace/ftrace.c:7905:36: error: 'FTRACE_STOP_FUNC_RET' undeclared (first use in this function)
    7905 |                         command |= FTRACE_STOP_FUNC_RET;
         |                                    ^~~~~~~~~~~~~~~~~~~~
>> kernel/trace/ftrace.c:7906:17: error: implicit declaration of function 'ftrace_run_update_code' [-Werror=implicit-function-declaration]
    7906 |                 ftrace_run_update_code(command);
         |                 ^~~~~~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors


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
> 7902		if (ftrace_start_up) {
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
