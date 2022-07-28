Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95A48583805
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 06:50:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232358AbiG1Etq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 00:49:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230180AbiG1Eto (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 00:49:44 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A999658B41
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 21:49:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658983783; x=1690519783;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=KssGZc6oIA9+vGGPWK2U9I+Cn2rWRyTmEEngtH2RbWA=;
  b=MeTICfU0Y90gYc1XhI5s6OIfKq1lQ+qp/FmN01fFYuQFuisof46O2o8K
   3lDgY2HF6ghK6olJqFhj0bcRjTUqqDt4/P+UHiQZkOVYfhtDOH9A/2VI7
   ATHMvl7L4jDyAgY9i8HKf4xvlIqLI7EFFLl9zfLJJ9atVjEZ+QDH+QLXA
   1PjcMbXPV010Qa8gL7Ss4mUirmAWZQmvCDR8MMRuClvqp57acI2e3NNlS
   JRjLNqsv/FC8anZ1W4aILFVnn8G20oaWz4+k7ejI/eee/ylSq5JQ6pYNF
   o/wMeyv3PbBnNhWxBHzwdAE9ZMD0VI9zzxPvXIQ10aF/P/Yz3RdiH1bfe
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10421"; a="289616226"
X-IronPort-AV: E=Sophos;i="5.93,196,1654585200"; 
   d="scan'208";a="289616226"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2022 21:49:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,196,1654585200"; 
   d="scan'208";a="551133312"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 27 Jul 2022 21:49:42 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oGvSv-0009go-2R;
        Thu, 28 Jul 2022 04:49:41 +0000
Date:   Thu, 28 Jul 2022 12:49:04 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [jolsa-perf:bpf/tracing_multi_4 33/34] kernel/trace/ftrace.c:5266:1:
 warning: no previous prototype for 'ftrace_find_direct_func_list'
Message-ID: <202207281208.EogzobID-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git bpf/tracing_multi_4
head:   1637b6b5bec11596e52cdc0a6eadfa45a15276c3
commit: f593767b216bc743e441c394e560546dcaaacc05 [33/34] ftrace: Factor list functions for ftrace_direct_func find and alloc
config: s390-randconfig-r044-20220728 (https://download.01.org/0day-ci/archive/20220728/202207281208.EogzobID-lkp@intel.com/config)
compiler: s390-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git/commit/?id=f593767b216bc743e441c394e560546dcaaacc05
        git remote add jolsa-perf https://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git
        git fetch --no-tags jolsa-perf bpf/tracing_multi_4
        git checkout f593767b216bc743e441c394e560546dcaaacc05
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=s390 SHELL=/bin/bash kernel/trace/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   kernel/trace/ftrace.c:295:5: warning: no previous prototype for '__register_ftrace_function' [-Wmissing-prototypes]
     295 | int __register_ftrace_function(struct ftrace_ops *ops)
         |     ^~~~~~~~~~~~~~~~~~~~~~~~~~
   kernel/trace/ftrace.c:338:5: warning: no previous prototype for '__unregister_ftrace_function' [-Wmissing-prototypes]
     338 | int __unregister_ftrace_function(struct ftrace_ops *ops)
         |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   kernel/trace/ftrace.c:4051:15: warning: no previous prototype for 'arch_ftrace_match_adjust' [-Wmissing-prototypes]
    4051 | char * __weak arch_ftrace_match_adjust(char *str, const char *search)
         |               ^~~~~~~~~~~~~~~~~~~~~~~~
>> kernel/trace/ftrace.c:5266:1: warning: no previous prototype for 'ftrace_find_direct_func_list' [-Wmissing-prototypes]
    5266 | ftrace_find_direct_func_list(struct ftrace_direct_list *list, unsigned long addr)
         | ^~~~~~~~~~~~~~~~~~~~~~~~~~~~


vim +/ftrace_find_direct_func_list +5266 kernel/trace/ftrace.c

  5251	
  5252	/**
  5253	 * ftrace_find_direct_func - test an address if it is a registered direct caller
  5254	 * @addr: The address of a registered direct caller
  5255	 *
  5256	 * This searches to see if a ftrace direct caller has been registered
  5257	 * at a specific address, and if so, it returns a descriptor for it.
  5258	 *
  5259	 * This can be used by architecture code to see if an address is
  5260	 * a direct caller (trampoline) attached to a fentry/mcount location.
  5261	 * This is useful for the function_graph tracer, as it may need to
  5262	 * do adjustments if it traced a location that also has a direct
  5263	 * trampoline attached to it.
  5264	 */
  5265	struct ftrace_direct_func *
> 5266	ftrace_find_direct_func_list(struct ftrace_direct_list *list, unsigned long addr)
  5267	{
  5268		struct ftrace_direct_func *entry;
  5269		bool found = false;
  5270	
  5271		/* May be called by fgraph trampoline (protected by rcu tasks) */
  5272		list_for_each_entry_rcu(entry, &list->funcs, next) {
  5273			if (entry->addr == addr) {
  5274				found = true;
  5275				break;
  5276			}
  5277		}
  5278		if (found)
  5279			return entry;
  5280	
  5281		return NULL;
  5282	}
  5283	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
