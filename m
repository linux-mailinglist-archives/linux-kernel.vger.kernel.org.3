Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6380E50A2C6
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 16:38:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1389472AbiDUOkO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 10:40:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1389438AbiDUOkM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 10:40:12 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53BC61F616
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 07:37:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650551842; x=1682087842;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Hb/PwdhqxjwBx8LMrby4ubXd6WAreKf8NPHfhjKA0Gk=;
  b=G5JTWaOZEmMe6Fxz25MqfJ1lLEozLnM+W4iKbhL0f6UdW1B18Z4uJaFz
   7tkzG9e63U1jqqDiPjsbSGgtSPimCQvvfad0YlKMZ7IqOwexEJhIKBdri
   t30lCLsGKV8CqeYDgOmbeV19hasYQl5Wz2FNqXlc3Mf+4YYvF2BAyepnc
   /Pn7gQVK1FVxA0hwsfFYVCslufqnKEt/6oZ2dtYAoy0LC3zwyC0yoLW/P
   a07YJ3//p/6Z2xGmGakoG9Tr+fgNY/YKXOjszz1x9Gqeqlv2BPGQXU0vl
   l+3aOf1HIm9fiu9VgWK4g8ccHNz5fStiWPI2KZuoKW1B+cZZzZaDRhZLd
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10324"; a="350806746"
X-IronPort-AV: E=Sophos;i="5.90,278,1643702400"; 
   d="scan'208";a="350806746"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2022 07:37:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,278,1643702400"; 
   d="scan'208";a="703106679"
Received: from lkp-server01.sh.intel.com (HELO 3abc53900bec) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 21 Apr 2022 07:37:20 -0700
Received: from kbuild by 3abc53900bec with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nhXvs-0008U8-4p;
        Thu, 21 Apr 2022 14:37:20 +0000
Date:   Thu, 21 Apr 2022 22:37:08 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [mingo-tip:sched/headers 2150/2579]
 kernel/trace/trace_hwlat.c:175:6: warning: no previous prototype for
 function 'trace_hwlat_callback'
Message-ID: <202204212231.wBlI8L8G-lkp@intel.com>
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
config: i386-randconfig-a013 (https://download.01.org/0day-ci/archive/20220421/202204212231.wBlI8L8G-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project bac6cd5bf85669e3376610cfc4c4f9ca015e7b9b)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git/commit/?id=b0a0ce86322929677661f28bec305c68815c387d
        git remote add mingo-tip git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git
        git fetch --no-tags mingo-tip sched/headers
        git checkout b0a0ce86322929677661f28bec305c68815c387d
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash arch/x86/crypto/ arch/x86/entry/vdso/ arch/x86/events/amd/ arch/x86/kernel/ arch/x86/pci/ kernel/bpf/ kernel/trace/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> kernel/trace/trace_hwlat.c:175:6: warning: no previous prototype for function 'trace_hwlat_callback' [-Wmissing-prototypes]
   void trace_hwlat_callback(bool enter)
        ^
   kernel/trace/trace_hwlat.c:175:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void trace_hwlat_callback(bool enter)
   ^
   static 
   1 warning generated.


vim +/trace_hwlat_callback +175 kernel/trace/trace_hwlat.c

e7c15cd8a11333 Steven Rostedt (Red Hat    2016-06-23  174) 
7b2c86250122de Steven Rostedt (Red Hat    2016-08-04 @175) void trace_hwlat_callback(bool enter)
7b2c86250122de Steven Rostedt (Red Hat    2016-08-04  176) {
f46b16520a087e Daniel Bristot de Oliveira 2021-06-22  177  	struct hwlat_kthread_data *kdata = get_cpu_data();
f46b16520a087e Daniel Bristot de Oliveira 2021-06-22  178  
f46b16520a087e Daniel Bristot de Oliveira 2021-06-22  179  	if (!kdata->kthread)
7b2c86250122de Steven Rostedt (Red Hat    2016-08-04  180) 		return;
7b2c86250122de Steven Rostedt (Red Hat    2016-08-04  181) 
7b2c86250122de Steven Rostedt (Red Hat    2016-08-04  182) 	/*
7b2c86250122de Steven Rostedt (Red Hat    2016-08-04  183) 	 * Currently trace_clock_local() calls sched_clock() and the
7b2c86250122de Steven Rostedt (Red Hat    2016-08-04  184) 	 * generic version is not NMI safe.
7b2c86250122de Steven Rostedt (Red Hat    2016-08-04  185) 	 */
7b2c86250122de Steven Rostedt (Red Hat    2016-08-04  186) 	if (!IS_ENABLED(CONFIG_GENERIC_SCHED_CLOCK)) {
7b2c86250122de Steven Rostedt (Red Hat    2016-08-04  187) 		if (enter)
f46b16520a087e Daniel Bristot de Oliveira 2021-06-22  188  			kdata->nmi_ts_start = time_get();
7b2c86250122de Steven Rostedt (Red Hat    2016-08-04  189) 		else
f46b16520a087e Daniel Bristot de Oliveira 2021-06-22  190  			kdata->nmi_total_ts += time_get() - kdata->nmi_ts_start;
7b2c86250122de Steven Rostedt (Red Hat    2016-08-04  191) 	}
7b2c86250122de Steven Rostedt (Red Hat    2016-08-04  192) 
7b2c86250122de Steven Rostedt (Red Hat    2016-08-04  193) 	if (enter)
f46b16520a087e Daniel Bristot de Oliveira 2021-06-22  194  		kdata->nmi_count++;
7b2c86250122de Steven Rostedt (Red Hat    2016-08-04  195) }
7b2c86250122de Steven Rostedt (Red Hat    2016-08-04  196) 

:::::: The code at line 175 was first introduced by commit
:::::: 7b2c86250122de316cbab8754050622ead04af39 tracing: Add NMI tracing in hwlat detector

:::::: TO: Steven Rostedt (Red Hat) <rostedt@goodmis.org>
:::::: CC: Steven Rostedt <rostedt@goodmis.org>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
