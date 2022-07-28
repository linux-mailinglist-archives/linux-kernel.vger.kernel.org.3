Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65686583840
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 07:51:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232577AbiG1Fu4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 01:50:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229975AbiG1Fuy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 01:50:54 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40C86B87F
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 22:50:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658987453; x=1690523453;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=PmWzIIoAKbuqWH0Bqz5qpeIdzBxgkCFhOC1syxvSurQ=;
  b=Qj89heh61zOoPZbi/cpPGVDpJ+1g/uXcaMBcKvLRJFavW5cV0IHavXkj
   q0FGXbamyMQQBC6D7x6fTtJ4AeXAtlaemy+JewOgHlRtsXA3wG/RN0d/z
   FI4s6DFA/Q5zBMtPAzXPBNUXF24iMOrRMk/LJD3RYHMABxXBvHwzHHA3a
   kZDagYoa8L05mdnYZMtXAxP+6L6F+ITd3UsvbE0pRvqJc30Ck6ZJg5S89
   jiAZ8V8lur4o13E9kFsec3H6KSsipLhU/2qKnouawXnJyGiqt4Us/fhwl
   E3eLWH8vMveZOwA/KDMb6eRT4KTF+yQY7xiSsojlCeP6OZ64ZFymIBczr
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10421"; a="288439653"
X-IronPort-AV: E=Sophos;i="5.93,196,1654585200"; 
   d="scan'208";a="288439653"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2022 22:50:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,196,1654585200"; 
   d="scan'208";a="576300547"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 27 Jul 2022 22:50:51 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oGwQ6-0009jC-2Z;
        Thu, 28 Jul 2022 05:50:50 +0000
Date:   Thu, 28 Jul 2022 13:50:34 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [jolsa-perf:bpf/tracing_multi_4 33/34] kernel/trace/ftrace.c:5267:
 warning: expecting prototype for ftrace_find_direct_func(). Prototype was
 for ftrace_find_direct_func_list() instead
Message-ID: <202207281352.OqEbh6Vq-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git bpf/tracing_multi_4
head:   1637b6b5bec11596e52cdc0a6eadfa45a15276c3
commit: f593767b216bc743e441c394e560546dcaaacc05 [33/34] ftrace: Factor list functions for ftrace_direct_func find and alloc
config: riscv-randconfig-r042-20220728 (https://download.01.org/0day-ci/archive/20220728/202207281352.OqEbh6Vq-lkp@intel.com/config)
compiler: riscv64-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git/commit/?id=f593767b216bc743e441c394e560546dcaaacc05
        git remote add jolsa-perf https://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git
        git fetch --no-tags jolsa-perf bpf/tracing_multi_4
        git checkout f593767b216bc743e441c394e560546dcaaacc05
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=riscv SHELL=/bin/bash kernel/trace/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   kernel/trace/ftrace.c:5267: warning: Function parameter or member 'list' not described in 'ftrace_find_direct_func_list'
>> kernel/trace/ftrace.c:5267: warning: expecting prototype for ftrace_find_direct_func(). Prototype was for ftrace_find_direct_func_list() instead
   kernel/trace/ftrace.c:5876: warning: Function parameter or member 'addr' not described in 'unregister_ftrace_direct_multi'
   kernel/trace/ftrace.c:6017: warning: Function parameter or member 'ops' not described in 'ftrace_set_filter_ip'
   kernel/trace/ftrace.c:6017: warning: Function parameter or member 'ip' not described in 'ftrace_set_filter_ip'
   kernel/trace/ftrace.c:6017: warning: Function parameter or member 'remove' not described in 'ftrace_set_filter_ip'
   kernel/trace/ftrace.c:6017: warning: Function parameter or member 'reset' not described in 'ftrace_set_filter_ip'
   kernel/trace/ftrace.c:6036: warning: Function parameter or member 'ops' not described in 'ftrace_set_filter_ips'
   kernel/trace/ftrace.c:6036: warning: Function parameter or member 'ips' not described in 'ftrace_set_filter_ips'
   kernel/trace/ftrace.c:6036: warning: Function parameter or member 'cnt' not described in 'ftrace_set_filter_ips'
   kernel/trace/ftrace.c:6036: warning: Function parameter or member 'remove' not described in 'ftrace_set_filter_ips'
   kernel/trace/ftrace.c:6036: warning: Function parameter or member 'reset' not described in 'ftrace_set_filter_ips'
   kernel/trace/ftrace.c:6050: warning: Function parameter or member 'ops' not described in 'ftrace_ops_set_global_filter'
   kernel/trace/ftrace.c:6078: warning: Function parameter or member 'ops' not described in 'ftrace_set_filter'
   kernel/trace/ftrace.c:6078: warning: Function parameter or member 'buf' not described in 'ftrace_set_filter'
   kernel/trace/ftrace.c:6078: warning: Function parameter or member 'len' not described in 'ftrace_set_filter'
   kernel/trace/ftrace.c:6078: warning: Function parameter or member 'reset' not described in 'ftrace_set_filter'
   kernel/trace/ftrace.c:6097: warning: Function parameter or member 'ops' not described in 'ftrace_set_notrace'
   kernel/trace/ftrace.c:6097: warning: Function parameter or member 'buf' not described in 'ftrace_set_notrace'
   kernel/trace/ftrace.c:6097: warning: Function parameter or member 'len' not described in 'ftrace_set_notrace'
   kernel/trace/ftrace.c:6097: warning: Function parameter or member 'reset' not described in 'ftrace_set_notrace'
   kernel/trace/ftrace.c:6112: warning: Function parameter or member 'buf' not described in 'ftrace_set_global_filter'
   kernel/trace/ftrace.c:6112: warning: Function parameter or member 'len' not described in 'ftrace_set_global_filter'
   kernel/trace/ftrace.c:6112: warning: Function parameter or member 'reset' not described in 'ftrace_set_global_filter'
   kernel/trace/ftrace.c:6128: warning: Function parameter or member 'buf' not described in 'ftrace_set_global_notrace'
   kernel/trace/ftrace.c:6128: warning: Function parameter or member 'len' not described in 'ftrace_set_global_notrace'
   kernel/trace/ftrace.c:6128: warning: Function parameter or member 'reset' not described in 'ftrace_set_global_notrace'


vim +5267 kernel/trace/ftrace.c

577d904d31d059 Jiri Olsa               2022-07-27  5251  
013bf0da047481 Steven Rostedt (VMware  2019-11-08  5252) /**
013bf0da047481 Steven Rostedt (VMware  2019-11-08  5253)  * ftrace_find_direct_func - test an address if it is a registered direct caller
013bf0da047481 Steven Rostedt (VMware  2019-11-08  5254)  * @addr: The address of a registered direct caller
013bf0da047481 Steven Rostedt (VMware  2019-11-08  5255)  *
013bf0da047481 Steven Rostedt (VMware  2019-11-08  5256)  * This searches to see if a ftrace direct caller has been registered
013bf0da047481 Steven Rostedt (VMware  2019-11-08  5257)  * at a specific address, and if so, it returns a descriptor for it.
013bf0da047481 Steven Rostedt (VMware  2019-11-08  5258)  *
013bf0da047481 Steven Rostedt (VMware  2019-11-08  5259)  * This can be used by architecture code to see if an address is
013bf0da047481 Steven Rostedt (VMware  2019-11-08  5260)  * a direct caller (trampoline) attached to a fentry/mcount location.
013bf0da047481 Steven Rostedt (VMware  2019-11-08  5261)  * This is useful for the function_graph tracer, as it may need to
013bf0da047481 Steven Rostedt (VMware  2019-11-08  5262)  * do adjustments if it traced a location that also has a direct
013bf0da047481 Steven Rostedt (VMware  2019-11-08  5263)  * trampoline attached to it.
013bf0da047481 Steven Rostedt (VMware  2019-11-08  5264)  */
f593767b216bc7 Jiri Olsa               2022-07-27  5265  struct ftrace_direct_func *
f593767b216bc7 Jiri Olsa               2022-07-27  5266  ftrace_find_direct_func_list(struct ftrace_direct_list *list, unsigned long addr)
013bf0da047481 Steven Rostedt (VMware  2019-11-08 @5267) {
013bf0da047481 Steven Rostedt (VMware  2019-11-08  5268) 	struct ftrace_direct_func *entry;
013bf0da047481 Steven Rostedt (VMware  2019-11-08  5269) 	bool found = false;
013bf0da047481 Steven Rostedt (VMware  2019-11-08  5270) 
013bf0da047481 Steven Rostedt (VMware  2019-11-08  5271) 	/* May be called by fgraph trampoline (protected by rcu tasks) */
f593767b216bc7 Jiri Olsa               2022-07-27  5272  	list_for_each_entry_rcu(entry, &list->funcs, next) {
013bf0da047481 Steven Rostedt (VMware  2019-11-08  5273) 		if (entry->addr == addr) {
013bf0da047481 Steven Rostedt (VMware  2019-11-08  5274) 			found = true;
013bf0da047481 Steven Rostedt (VMware  2019-11-08  5275) 			break;
013bf0da047481 Steven Rostedt (VMware  2019-11-08  5276) 		}
013bf0da047481 Steven Rostedt (VMware  2019-11-08  5277) 	}
013bf0da047481 Steven Rostedt (VMware  2019-11-08  5278) 	if (found)
013bf0da047481 Steven Rostedt (VMware  2019-11-08  5279) 		return entry;
013bf0da047481 Steven Rostedt (VMware  2019-11-08  5280) 
013bf0da047481 Steven Rostedt (VMware  2019-11-08  5281) 	return NULL;
013bf0da047481 Steven Rostedt (VMware  2019-11-08  5282) }
013bf0da047481 Steven Rostedt (VMware  2019-11-08  5283) 

:::::: The code at line 5267 was first introduced by commit
:::::: 013bf0da0474816f57739daa006c8564ad7396a3 ftrace: Add ftrace_find_direct_func()

:::::: TO: Steven Rostedt (VMware) <rostedt@goodmis.org>
:::::: CC: Steven Rostedt (VMware) <rostedt@goodmis.org>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
