Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB3054FEC49
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 03:31:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231347AbiDMBdu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 21:33:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbiDMBdp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 21:33:45 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB257F17
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 18:31:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649813485; x=1681349485;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=6zTIkCqjMyqGUHv2Hygl+ab0dObARApK4rLR+Js3Ja8=;
  b=RqFk2jY7yTs+QpGIdKTv+2xFfoPqCBJAn7EEaPvlnhXZfmaBsbj+36cg
   PmTk33GnjIxWbKbaHG7jxRfFFlyKb+7m9T2g61wi1IvMhkY13dUmmaAdR
   DpNZz/4dnpLM0+kVnfyFefBQQpwg3OhQ+vNafzGLzdiPiO1xHXfUPkdlx
   CV2mNi/VldaHpOW7XMldB6SJn63myvpIRN3lWYZxNkgX41X8N2mvDMaMC
   TEULSW+eaiaA4jxAwiCmft4K/QvIer7QvlcBMMgF/wwkL6jzFffFOP7Bu
   xdYde//AYkaqdtM9BVJq7tqe65ZEjao5yY5r7ygOMDlvKglU6avv1ad2H
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10315"; a="242483029"
X-IronPort-AV: E=Sophos;i="5.90,255,1643702400"; 
   d="scan'208";a="242483029"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2022 18:31:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,255,1643702400"; 
   d="scan'208";a="644973445"
Received: from lkp-server02.sh.intel.com (HELO d3fc50ef50de) ([10.239.97.151])
  by FMSMGA003.fm.intel.com with ESMTP; 12 Apr 2022 18:31:24 -0700
Received: from kbuild by d3fc50ef50de with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1neRqt-0003Jw-Mz;
        Wed, 13 Apr 2022 01:31:23 +0000
Date:   Wed, 13 Apr 2022 09:31:14 +0800
From:   kernel test robot <lkp@intel.com>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [mark:stacktrace/testing 1/1] lib/test_stacktrace/kunit.c:54:5:
 warning: no previous prototype for 'st_find_func_idx'
Message-ID: <202204130918.xY2l2rUd-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git stacktrace/testing
head:   a8e8825116626f8c3e8be3bb889b6442a7465cb8
commit: a8e8825116626f8c3e8be3bb889b6442a7465cb8 [1/1] WIP: stacktrace tests
config: alpha-allyesconfig (https://download.01.org/0day-ci/archive/20220413/202204130918.xY2l2rUd-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git/commit/?id=a8e8825116626f8c3e8be3bb889b6442a7465cb8
        git remote add mark https://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git
        git fetch --no-tags mark stacktrace/testing
        git checkout a8e8825116626f8c3e8be3bb889b6442a7465cb8
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=alpha SHELL=/bin/bash lib/test_stacktrace/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   lib/test_stacktrace/kunit.c: In function 'callback_st_save':
   lib/test_stacktrace/kunit.c:35:26: error: implicit declaration of function 'stack_trace_save'; did you mean 'stack_depot_save'? [-Werror=implicit-function-declaration]
      35 |         st->nr_entries = stack_trace_save(st->store, MAX_STACK_ENTRIES, 0);
         |                          ^~~~~~~~~~~~~~~~
         |                          stack_depot_save
   lib/test_stacktrace/kunit.c: At top level:
>> lib/test_stacktrace/kunit.c:54:5: warning: no previous prototype for 'st_find_func_idx' [-Wmissing-prototypes]
      54 | int st_find_func_idx(struct st_data *st, void *func, int start)
         |     ^~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors


vim +/st_find_func_idx +54 lib/test_stacktrace/kunit.c

    49	
    50	/*
    51	 * Find the index of the first instance of `func` within a trace, starting from
    52	 * `start`.
    53	 */
  > 54	int st_find_func_idx(struct st_data *st, void *func, int start)
    55	{
    56		unsigned long size;
    57		unsigned long offset;
    58		unsigned long addr = (unsigned long)func;
    59	
    60		if (!kallsyms_lookup_size_offset(addr, &size, &offset))
    61			return st->nr_entries;
    62	
    63		for (int i = start; i < st->nr_entries; i++) {
    64			unsigned long elem = st->store[i];
    65	
    66			if (elem < addr)
    67				continue;
    68			if (elem >= addr + size)
    69				continue;
    70	
    71			return i;
    72		}
    73	
    74		return st->nr_entries;
    75	}
    76	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
