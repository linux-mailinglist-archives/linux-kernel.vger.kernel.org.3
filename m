Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88359506195
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 03:12:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244947AbiDSBOx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 21:14:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236531AbiDSBOw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 21:14:52 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41C4C2D1EB
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 18:12:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650330731; x=1681866731;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=HdMkCTRcYKs1JfEk+YkUdEuA9BOO2m5Z5/dK/lgBlO4=;
  b=lYntPjLjViQ0W783YOiZ8c70WZ/IIARwwG4RcqE3sCfG2o6vF+WVXXW9
   U440ef2RsN4xKTv+pz+F2T2V6m4zrmWJXt1DvFWQQctTy9bAmDgscc8Ru
   xoSnZ8QWLvh7xlzUJBmVj9Ptpwp8CljRwY9ymF7h0+/shbv4Z04TpYo2d
   bZ5rdeTEvgspi8d0lzK/vYY4/yUNY6+voSxMZSFLEtR1nCgnyCXUmnoYB
   tCikMO8B7JpZaqMLydXQX8o4bp1ssq39n2YBCQNIcKEsQN1r3x4j2fWoT
   vojHiW2MnTlpy3SY8+Su+8uDxU3daaOf9wI+3ujkRrb3OfmU/tOtDLBoZ
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10321"; a="350095036"
X-IronPort-AV: E=Sophos;i="5.90,271,1643702400"; 
   d="scan'208";a="350095036"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2022 18:12:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,271,1643702400"; 
   d="scan'208";a="529830718"
Received: from lkp-server01.sh.intel.com (HELO 3abc53900bec) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 18 Apr 2022 18:12:09 -0700
Received: from kbuild by 3abc53900bec with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1ngcPY-00059O-R3;
        Tue, 19 Apr 2022 01:12:08 +0000
Date:   Tue, 19 Apr 2022 09:11:53 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [mingo-tip:sched/headers 2010/2356]
 kernel/trace/trace_hwlat.c:174:6: warning: no previous prototype for
 function 'trace_hwlat_callback'
Message-ID: <202204190949.0dYaK59p-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git sched/headers
head:   af93551cf39027d176f30b9beafc60a4c130998a
commit: 5fee58017c43400c6eb3db270e91501a39fd1a4e [2010/2356] headers/deps: Remove <linux/hardirq.h> inclusions from headers that don't need it anymore
config: x86_64-randconfig-a016-20220418 (https://download.01.org/0day-ci/archive/20220419/202204190949.0dYaK59p-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 429cbac0390654f90bba18a41799464adf31a5ec)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git/commit/?id=5fee58017c43400c6eb3db270e91501a39fd1a4e
        git remote add mingo-tip git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git
        git fetch --no-tags mingo-tip sched/headers
        git checkout 5fee58017c43400c6eb3db270e91501a39fd1a4e
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash kernel/trace/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> kernel/trace/trace_hwlat.c:174:6: warning: no previous prototype for function 'trace_hwlat_callback' [-Wmissing-prototypes]
   void trace_hwlat_callback(bool enter)
        ^
   kernel/trace/trace_hwlat.c:174:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void trace_hwlat_callback(bool enter)
   ^
   static 
   1 warning generated.


vim +/trace_hwlat_callback +174 kernel/trace/trace_hwlat.c

e7c15cd8a11333 Steven Rostedt (Red Hat    2016-06-23  173) 
7b2c86250122de Steven Rostedt (Red Hat    2016-08-04 @174) void trace_hwlat_callback(bool enter)
7b2c86250122de Steven Rostedt (Red Hat    2016-08-04  175) {
f46b16520a087e Daniel Bristot de Oliveira 2021-06-22  176  	struct hwlat_kthread_data *kdata = get_cpu_data();
f46b16520a087e Daniel Bristot de Oliveira 2021-06-22  177  
f46b16520a087e Daniel Bristot de Oliveira 2021-06-22  178  	if (!kdata->kthread)
7b2c86250122de Steven Rostedt (Red Hat    2016-08-04  179) 		return;
7b2c86250122de Steven Rostedt (Red Hat    2016-08-04  180) 
7b2c86250122de Steven Rostedt (Red Hat    2016-08-04  181) 	/*
7b2c86250122de Steven Rostedt (Red Hat    2016-08-04  182) 	 * Currently trace_clock_local() calls sched_clock() and the
7b2c86250122de Steven Rostedt (Red Hat    2016-08-04  183) 	 * generic version is not NMI safe.
7b2c86250122de Steven Rostedt (Red Hat    2016-08-04  184) 	 */
7b2c86250122de Steven Rostedt (Red Hat    2016-08-04  185) 	if (!IS_ENABLED(CONFIG_GENERIC_SCHED_CLOCK)) {
7b2c86250122de Steven Rostedt (Red Hat    2016-08-04  186) 		if (enter)
f46b16520a087e Daniel Bristot de Oliveira 2021-06-22  187  			kdata->nmi_ts_start = time_get();
7b2c86250122de Steven Rostedt (Red Hat    2016-08-04  188) 		else
f46b16520a087e Daniel Bristot de Oliveira 2021-06-22  189  			kdata->nmi_total_ts += time_get() - kdata->nmi_ts_start;
7b2c86250122de Steven Rostedt (Red Hat    2016-08-04  190) 	}
7b2c86250122de Steven Rostedt (Red Hat    2016-08-04  191) 
7b2c86250122de Steven Rostedt (Red Hat    2016-08-04  192) 	if (enter)
f46b16520a087e Daniel Bristot de Oliveira 2021-06-22  193  		kdata->nmi_count++;
7b2c86250122de Steven Rostedt (Red Hat    2016-08-04  194) }
7b2c86250122de Steven Rostedt (Red Hat    2016-08-04  195) 

:::::: The code at line 174 was first introduced by commit
:::::: 7b2c86250122de316cbab8754050622ead04af39 tracing: Add NMI tracing in hwlat detector

:::::: TO: Steven Rostedt (Red Hat) <rostedt@goodmis.org>
:::::: CC: Steven Rostedt <rostedt@goodmis.org>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
