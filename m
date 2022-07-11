Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 311D0570CED
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 23:42:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231310AbiGKVmr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 17:42:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230503AbiGKVmp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 17:42:45 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4441A82476
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 14:42:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657575764; x=1689111764;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=iaO0MGwN2iH5KPNILjDnJ16mGNe5ztpOBLPSvB47zeg=;
  b=gJM6H8ng71FIasxhsyfq55e/wzlXfPCDWI3DF1wpx/ysDzSzzI8ZPjfl
   po2m+m1i5jHdngmjqKIPsLqN+V7ab5QiaEC0jE86sT4T8K0W8epFJ47BF
   syrw+IYMQZoaNDPfJ75jKzZ34fhuQ3vvFg37UcpaaJLXs8FMOtu61X6+7
   XUihbr3ohveX1NnzPa5r/IEyM33L0uRzf6R6Ng7xcm4bBA3TV9SFO5kcs
   k2asyT0ofc0wphbOjxNe4V5JMgclUW81wUWXlztCLC6Ez5YFiNKweS0oX
   DJhc53qyg80kzwpA8fsJg23g6qVOUaOxN7Ejd/omPHL7f/79b//TFjhwn
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10405"; a="285517899"
X-IronPort-AV: E=Sophos;i="5.92,263,1650956400"; 
   d="scan'208";a="285517899"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2022 14:42:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,263,1650956400"; 
   d="scan'208";a="627655042"
Received: from lkp-server02.sh.intel.com (HELO 8708c84be1ad) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 11 Jul 2022 14:42:42 -0700
Received: from kbuild by 8708c84be1ad with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1oB1Av-0001FZ-WD;
        Mon, 11 Jul 2022 21:42:41 +0000
Date:   Tue, 12 Jul 2022 05:41:49 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [jolsa-perf:bpf/tramp_29 25/32] kernel/bpf/trampoline.c:948:16:
 error: implicit declaration of function 'ftrace_hash_alloc'
Message-ID: <202207120532.8OjZqfrT-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git bpf/tramp_29
head:   ec522c20e55e48f561146afbb81513e20870ee12
commit: f8f16c805972e534643c5a5d23709766f7af22e4 [25/32] bpf: Add support to attach multi trampolines
config: x86_64-randconfig-a006 (https://download.01.org/0day-ci/archive/20220712/202207120532.8OjZqfrT-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-3) 11.3.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git/commit/?id=f8f16c805972e534643c5a5d23709766f7af22e4
        git remote add jolsa-perf https://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git
        git fetch --no-tags jolsa-perf bpf/tramp_29
        git checkout f8f16c805972e534643c5a5d23709766f7af22e4
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   kernel/bpf/trampoline.c: In function 'bpf_tramp_update_set':
>> kernel/bpf/trampoline.c:948:16: error: implicit declaration of function 'ftrace_hash_alloc' [-Werror=implicit-function-declaration]
     948 |         hash = ftrace_hash_alloc(FTRACE_HASH_MAX_BITS);
         |                ^~~~~~~~~~~~~~~~~
>> kernel/bpf/trampoline.c:948:34: error: 'FTRACE_HASH_MAX_BITS' undeclared (first use in this function)
     948 |         hash = ftrace_hash_alloc(FTRACE_HASH_MAX_BITS);
         |                                  ^~~~~~~~~~~~~~~~~~~~
   kernel/bpf/trampoline.c:948:34: note: each undeclared identifier is reported only once for each function it appears in
>> kernel/bpf/trampoline.c:975:33: error: implicit declaration of function 'ftrace_hash_add_entry' [-Werror=implicit-function-declaration]
     975 |                                 ftrace_hash_add_entry(hash, entry);
         |                                 ^~~~~~~~~~~~~~~~~~~~~
>> kernel/bpf/trampoline.c:989:15: error: implicit declaration of function 'set_ftrace_direct'; did you mean 'modify_ftrace_direct'? [-Werror=implicit-function-declaration]
     989 |         err = set_ftrace_direct(hash);
         |               ^~~~~~~~~~~~~~~~~
         |               modify_ftrace_direct
>> kernel/bpf/trampoline.c:991:9: error: implicit declaration of function 'ftrace_hash_free' [-Werror=implicit-function-declaration]
     991 |         ftrace_hash_free(hash);
         |         ^~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors


vim +/ftrace_hash_alloc +948 kernel/bpf/trampoline.c

   941	
   942	static int bpf_tramp_update_set(struct list_head *upd)
   943	{
   944		struct bpf_trampoline *tr;
   945		struct ftrace_hash *hash;
   946		int i, err;
   947	
 > 948		hash = ftrace_hash_alloc(FTRACE_HASH_MAX_BITS);
   949		if (!hash)
   950			return -ENOMEM;
   951	
   952		list_for_each_entry(tr, upd, update.list) {
   953			struct ftrace_func_entry *entry;
   954			unsigned long direct;
   955	
   956			switch (tr->update.action) {
   957			case BPF_TRAMP_UPDATE_REG:
   958			case BPF_TRAMP_UPDATE_MODIFY:
   959				direct = (unsigned long) tr->update.im->image;
   960				break;
   961			case BPF_TRAMP_UPDATE_UNREG:
   962				direct = 0;
   963				break;
   964			}
   965	
   966			if (tr->multi.id_multi) {
   967				for (i = 0; i < tr->multi.id_multi->cnt; i++) {
   968					entry = kmalloc(sizeof(*entry), GFP_KERNEL);
   969					if (!entry) {
   970						err = -ENOMEM;
   971						goto out_free;
   972					}
   973					entry->ip = (unsigned long) tr->multi.id_multi->addr[i];
   974					entry->direct = direct;
 > 975					ftrace_hash_add_entry(hash, entry);
   976				}
   977			} else {
   978				entry = kmalloc(sizeof(*entry), GFP_KERNEL);
   979				if (!entry) {
   980					err = -ENOMEM;
   981					goto out_free;
   982				}
   983				entry->ip = (unsigned long) tr->func.addr;
   984				entry->direct = direct;
   985				ftrace_hash_add_entry(hash, entry);
   986			}
   987		}
   988	
 > 989		err = set_ftrace_direct(hash);
   990	out_free:
 > 991		ftrace_hash_free(hash);
   992		return err;
   993	}
   994	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
