Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CCC65097DB
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 08:44:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385034AbiDUGoB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 02:44:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384984AbiDUGno (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 02:43:44 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0438A13F9C
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 23:40:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650523254; x=1682059254;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=5ZaRSNjHztn1ZJQvxu4YNLdMJyOv1fW1zFXsEI2+yOk=;
  b=K4fcbH3748P1egOc0rd6jdm4Ndo7fwEHdXO66d3CVq4pI1wf8ssbFXB/
   C7ufmgsl6najAYEOXTzai01l0kIWWEwu0bnLdcOl3nRFmY0HUrEkwTe/9
   RkPnbPfXxkc7faHzHCHSmM3pA2Vy2j3YFkIkD1z+DwdHFeEeix5efOtvY
   b1I98KY08tkJnPvznvd36PbuXskzY0S3jsmZ4sifTA3ANeWyLcgdSUh7u
   3fEq2f6m1iqGUtHV8d5GJm6OSkLub2HOrLFHDMdRqAl6nx3SfPWTglfAl
   LGAfWuXNdVu1te/HUjB14tNcKTbBF7N2xg7o1RAP8U2NwCecxuqOTeZOW
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10323"; a="327160557"
X-IronPort-AV: E=Sophos;i="5.90,278,1643702400"; 
   d="scan'208";a="327160557"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2022 23:40:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,278,1643702400"; 
   d="scan'208";a="532790134"
Received: from lkp-server01.sh.intel.com (HELO 3abc53900bec) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 20 Apr 2022 23:40:50 -0700
Received: from kbuild by 3abc53900bec with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nhQUj-0007y5-N3;
        Thu, 21 Apr 2022 06:40:49 +0000
Date:   Thu, 21 Apr 2022 14:40:16 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [mingo-tip:sched/headers 2150/2579]
 kernel/trace/trace_hwlat.c:175:6: warning: no previous prototype for
 'trace_hwlat_callback'
Message-ID: <202204202225.RdSY9Rvx-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git sched/headers
head:   49e1ec6c70a6eb4b7de9250a455b8b63eb42afbe
commit: b0a0ce86322929677661f28bec305c68815c387d [2150/2579] headers/deps: Remove <linux/hardirq.h> inclusions from headers that don't need it anymore
config: x86_64-randconfig-a011 (https://download.01.org/0day-ci/archive/20220420/202204202225.RdSY9Rvx-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.2.0-20) 11.2.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git/commit/?id=b0a0ce86322929677661f28bec305c68815c387d
        git remote add mingo-tip git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git
        git fetch --no-tags mingo-tip sched/headers
        git checkout b0a0ce86322929677661f28bec305c68815c387d
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash arch/x86/kernel/cpu/mtrr/ kernel/trace/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> kernel/trace/trace_hwlat.c:175:6: warning: no previous prototype for 'trace_hwlat_callback' [-Wmissing-prototypes]
     175 | void trace_hwlat_callback(bool enter)
         |      ^~~~~~~~~~~~~~~~~~~~


vim +/trace_hwlat_callback +175 kernel/trace/trace_hwlat.c

e7c15cd8a113335c Steven Rostedt (Red Hat    2016-06-23  174) 
7b2c86250122de31 Steven Rostedt (Red Hat    2016-08-04 @175) void trace_hwlat_callback(bool enter)
7b2c86250122de31 Steven Rostedt (Red Hat    2016-08-04  176) {
f46b16520a087e89 Daniel Bristot de Oliveira 2021-06-22  177  	struct hwlat_kthread_data *kdata = get_cpu_data();
f46b16520a087e89 Daniel Bristot de Oliveira 2021-06-22  178  
f46b16520a087e89 Daniel Bristot de Oliveira 2021-06-22  179  	if (!kdata->kthread)
7b2c86250122de31 Steven Rostedt (Red Hat    2016-08-04  180) 		return;
7b2c86250122de31 Steven Rostedt (Red Hat    2016-08-04  181) 
7b2c86250122de31 Steven Rostedt (Red Hat    2016-08-04  182) 	/*
7b2c86250122de31 Steven Rostedt (Red Hat    2016-08-04  183) 	 * Currently trace_clock_local() calls sched_clock() and the
7b2c86250122de31 Steven Rostedt (Red Hat    2016-08-04  184) 	 * generic version is not NMI safe.
7b2c86250122de31 Steven Rostedt (Red Hat    2016-08-04  185) 	 */
7b2c86250122de31 Steven Rostedt (Red Hat    2016-08-04  186) 	if (!IS_ENABLED(CONFIG_GENERIC_SCHED_CLOCK)) {
7b2c86250122de31 Steven Rostedt (Red Hat    2016-08-04  187) 		if (enter)
f46b16520a087e89 Daniel Bristot de Oliveira 2021-06-22  188  			kdata->nmi_ts_start = time_get();
7b2c86250122de31 Steven Rostedt (Red Hat    2016-08-04  189) 		else
f46b16520a087e89 Daniel Bristot de Oliveira 2021-06-22  190  			kdata->nmi_total_ts += time_get() - kdata->nmi_ts_start;
7b2c86250122de31 Steven Rostedt (Red Hat    2016-08-04  191) 	}
7b2c86250122de31 Steven Rostedt (Red Hat    2016-08-04  192) 
7b2c86250122de31 Steven Rostedt (Red Hat    2016-08-04  193) 	if (enter)
f46b16520a087e89 Daniel Bristot de Oliveira 2021-06-22  194  		kdata->nmi_count++;
7b2c86250122de31 Steven Rostedt (Red Hat    2016-08-04  195) }
7b2c86250122de31 Steven Rostedt (Red Hat    2016-08-04  196) 

:::::: The code at line 175 was first introduced by commit
:::::: 7b2c86250122de316cbab8754050622ead04af39 tracing: Add NMI tracing in hwlat detector

:::::: TO: Steven Rostedt (Red Hat) <rostedt@goodmis.org>
:::::: CC: Steven Rostedt <rostedt@goodmis.org>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
