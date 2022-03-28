Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEE324E931A
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 13:16:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240543AbiC1LRl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 07:17:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233384AbiC1LRi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 07:17:38 -0400
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F3B95523F
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 04:15:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648466157; x=1680002157;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=wrodZFeDW4Z/d0hS+ESXF40ZqVjPhza5GfVoBuF40QU=;
  b=iLJmZf/CUrYM9OUexBA7xjubYkItB0yFhkTrdD49SpND9dY46k6kr9yA
   lYxZ38AXh9UZMIiLzeHzH5wOArfIE0BPoQP0iOk05ng0nO2BqvtB49wqz
   no1rkFzfxIEmcaqYDGkRBUy8t7MUNnjFOVijdz54axgOkMcFyJB/saG0n
   Jo/im5l1IBl3FyHg/1wueDZF83WT9q/K4FMoxtgr2Bssq7CXjYnKwnQNy
   HuZ+8uvT+wTPbUAFD91gHds8LzFbEyd1AO22TV0O4OmZ8Dxw6oJ6fLSI6
   B8jwXWWSQMMNVKoFSQpTGzsDUz8XcwvaLAWclQVGlg8R6BmQtFKD3LSH1
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10299"; a="319674412"
X-IronPort-AV: E=Sophos;i="5.90,217,1643702400"; 
   d="scan'208";a="319674412"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2022 04:15:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,217,1643702400"; 
   d="scan'208";a="520968292"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 28 Mar 2022 04:15:55 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nYnLm-0001zV-NG; Mon, 28 Mar 2022 11:15:54 +0000
Date:   Mon, 28 Mar 2022 19:14:55 +0800
From:   kernel test robot <lkp@intel.com>
To:     Beau Belgrave <beaub@linux.microsoft.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        "Steven Rostedt (Google)" <rostedt@goodmis.org>
Subject: kernel/trace/trace_events_user.c:593:31: sparse: sparse: incorrect
 type in assignment (different address spaces)
Message-ID: <202203281937.Po855SGa-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   ae085d7f9365de7da27ab5c0d16b12d51ea7fca9
commit: 0279400ad38d858ed68f5d787385f6122d4170b2 user_events: Optimize writing events by only copying data once
date:   6 weeks ago
config: i386-randconfig-s001-20220328 (https://download.01.org/0day-ci/archive/20220328/202203281937.Po855SGa-lkp@intel.com/config)
compiler: gcc-9 (Ubuntu 9.4.0-1ubuntu1~20.04.1) 9.4.0
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=0279400ad38d858ed68f5d787385f6122d4170b2
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 0279400ad38d858ed68f5d787385f6122d4170b2
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=i386 SHELL=/bin/bash drivers/acpi/apei/ drivers/gpu/drm/ kernel/trace/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
   kernel/trace/trace_events_user.c:409:38: sparse: sparse: Using plain integer as NULL pointer
   kernel/trace/trace_events_user.c:430:40: sparse: sparse: Using plain integer as NULL pointer
>> kernel/trace/trace_events_user.c:593:31: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void *[assigned] udata @@     got void [noderef] __user * @@
   kernel/trace/trace_events_user.c:593:31: sparse:     expected void *[assigned] udata
   kernel/trace/trace_events_user.c:593:31: sparse:     got void [noderef] __user *
   kernel/trace/trace_events_user.c:1064:16: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/trace/trace_events_user.c:1064:16: sparse:    void [noderef] __rcu *
   kernel/trace/trace_events_user.c:1064:16: sparse:    void *
   kernel/trace/trace_events_user.c:1122:13: sparse: sparse: cast removes address space '__user' of expression
   kernel/trace/trace_events_user.c:1122:13: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __user *buf @@     got char * @@
   kernel/trace/trace_events_user.c:1122:13: sparse:     expected void [noderef] __user *buf
   kernel/trace/trace_events_user.c:1122:13: sparse:     got char *
   kernel/trace/trace_events_user.c:1138:16: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/trace/trace_events_user.c:1138:16: sparse:    void [noderef] __rcu *
   kernel/trace/trace_events_user.c:1138:16: sparse:    void *
   kernel/trace/trace_events_user.c:1165:9: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/trace/trace_events_user.c:1165:9: sparse:    void [noderef] __rcu *
   kernel/trace/trace_events_user.c:1165:9: sparse:    void *

vim +593 kernel/trace/trace_events_user.c

   571	
   572	#ifdef CONFIG_PERF_EVENTS
   573	static void user_event_bpf(struct user_event *user, struct iov_iter *i)
   574	{
   575		struct user_bpf_context context;
   576		struct user_bpf_iter bpf_i;
   577		char fast_data[MAX_STACK_BPF_DATA];
   578		void *temp = NULL;
   579	
   580		if ((user->flags & FLAG_BPF_ITER) && iter_is_iovec(i)) {
   581			/* Raw iterator */
   582			context.data_type = USER_BPF_DATA_ITER;
   583			context.data_len = i->count;
   584			context.iter = &bpf_i;
   585	
   586			bpf_i.iov_offset = i->iov_offset;
   587			bpf_i.iov = i->iov;
   588			bpf_i.nr_segs = i->nr_segs;
   589		} else if (i->nr_segs == 1 && iter_is_iovec(i)) {
   590			/* Single buffer from user */
   591			context.data_type = USER_BPF_DATA_USER;
   592			context.data_len = i->count;
 > 593			context.udata = i->iov->iov_base + i->iov_offset;
   594		} else {
   595			/* Multi buffer from user */
   596			struct iov_iter copy = *i;
   597			size_t copy_size = min_t(size_t, i->count, MAX_BPF_COPY_SIZE);
   598	
   599			context.data_type = USER_BPF_DATA_KERNEL;
   600			context.kdata = fast_data;
   601	
   602			if (unlikely(copy_size > sizeof(fast_data))) {
   603				temp = kmalloc(copy_size, GFP_NOWAIT);
   604	
   605				if (temp)
   606					context.kdata = temp;
   607				else
   608					copy_size = sizeof(fast_data);
   609			}
   610	
   611			context.data_len = copy_nofault(context.kdata,
   612							copy_size, &copy);
   613		}
   614	
   615		trace_call_bpf(&user->call, &context);
   616	
   617		kfree(temp);
   618	}
   619	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
