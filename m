Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E35AD567CE1
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 05:59:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231382AbiGFD71 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 23:59:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230145AbiGFD7Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 23:59:25 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A3C21D321
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jul 2022 20:59:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657079964; x=1688615964;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=6ec6rBH8nREfj/uW5EX1gMMOVg9i3M8k55Ig3SxqezU=;
  b=HhOHzspJXO5FQYCW6YnNQGm3frkfQWmtesG0661O5jAjeip2oG66nGcL
   WAGI6LEmTz94jp4jk3lwk85rcBZ1bujLks8ItSMM+h4tGBEPa//fnc5hR
   Axr1bMb5Pt/xVxM/6Gc1BZJ+ZiNXMurPAC1W3/VnU3jJUd1uKqnjBdtPb
   crlhEvQruJHNwSyr8Y+ZdPhzBhue7VC5yDlVj/KWeKkwKyuwa3HWZ/jnq
   5m5m7x+wuZBIG2PxpwIBLt0sQ9oGqwYSY1gbc0Jf+36rsqINF1JVNWTWZ
   mmc1FHg0tsuF4AqTxp619RFEuQozSfHNMIsSwyaEu1GGyYVJOkJsQqzgl
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10399"; a="266663559"
X-IronPort-AV: E=Sophos;i="5.92,248,1650956400"; 
   d="scan'208";a="266663559"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jul 2022 20:59:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,248,1650956400"; 
   d="scan'208";a="543219118"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 05 Jul 2022 20:59:22 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o8wC9-000JyV-Jv;
        Wed, 06 Jul 2022 03:59:21 +0000
Date:   Wed, 6 Jul 2022 11:58:24 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [jolsa-perf:bpf/tramp_22 8/21] kernel/trace/ftrace.c:5582:22:
 sparse: sparse: incorrect type in assignment (different address spaces)
Message-ID: <202207061143.x1Av3ceC-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git bpf/tramp_22
head:   1d891c46bb689a24985cea58f4eddb053d6b1331
commit: 5b091bc758fd64f7f3748f61c0e43e09b9366a1a [8/21] ftrace: Add set_ftrace_direct function
config: i386-randconfig-s001 (https://download.01.org/0day-ci/archive/20220706/202207061143.x1Av3ceC-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-3) 11.3.0
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.4-39-gce1a6720-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git/commit/?id=5b091bc758fd64f7f3748f61c0e43e09b9366a1a
        git remote add jolsa-perf https://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git
        git fetch --no-tags jolsa-perf bpf/tramp_22
        git checkout 5b091bc758fd64f7f3748f61c0e43e09b9366a1a
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=i386 SHELL=/bin/bash kernel/trace/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
   kernel/trace/ftrace.c:116:59: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct ftrace_ops [noderef] __rcu *[addressable] [toplevel] ftrace_ops_list @@     got struct ftrace_ops * @@
   kernel/trace/ftrace.c:116:59: sparse:     expected struct ftrace_ops [noderef] __rcu *[addressable] [toplevel] ftrace_ops_list
   kernel/trace/ftrace.c:116:59: sparse:     got struct ftrace_ops *
   kernel/trace/ftrace.c:195:49: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct ftrace_ops *ops @@     got struct ftrace_ops [noderef] __rcu *[addressable] [toplevel] ftrace_ops_list @@
   kernel/trace/ftrace.c:195:49: sparse:     expected struct ftrace_ops *ops
   kernel/trace/ftrace.c:195:49: sparse:     got struct ftrace_ops [noderef] __rcu *[addressable] [toplevel] ftrace_ops_list
   kernel/trace/ftrace.c:278:23: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct ftrace_ops [noderef] __rcu * @@     got struct ftrace_ops * @@
   kernel/trace/ftrace.c:278:23: sparse:     expected struct ftrace_ops [noderef] __rcu *
   kernel/trace/ftrace.c:278:23: sparse:     got struct ftrace_ops *
   kernel/trace/ftrace.c:282:16: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct ftrace_ops **p @@     got struct ftrace_ops [noderef] __rcu **list @@
   kernel/trace/ftrace.c:282:16: sparse:     expected struct ftrace_ops **p
   kernel/trace/ftrace.c:282:16: sparse:     got struct ftrace_ops [noderef] __rcu **list
   kernel/trace/ftrace.c:282:50: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct ftrace_ops **p @@     got struct ftrace_ops [noderef] __rcu ** @@
   kernel/trace/ftrace.c:282:50: sparse:     expected struct ftrace_ops **p
   kernel/trace/ftrace.c:282:50: sparse:     got struct ftrace_ops [noderef] __rcu **
   kernel/trace/ftrace.c:289:12: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct ftrace_ops * @@     got struct ftrace_ops [noderef] __rcu *next @@
   kernel/trace/ftrace.c:289:12: sparse:     expected struct ftrace_ops *
   kernel/trace/ftrace.c:289:12: sparse:     got struct ftrace_ops [noderef] __rcu *next
   kernel/trace/ftrace.c:1031:43: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct ftrace_hash [noderef] __rcu *notrace_hash @@     got struct ftrace_hash * @@
   kernel/trace/ftrace.c:1031:43: sparse:     expected struct ftrace_hash [noderef] __rcu *notrace_hash
   kernel/trace/ftrace.c:1031:43: sparse:     got struct ftrace_hash *
   kernel/trace/ftrace.c:1032:43: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct ftrace_hash [noderef] __rcu *filter_hash @@     got struct ftrace_hash * @@
   kernel/trace/ftrace.c:1032:43: sparse:     expected struct ftrace_hash [noderef] __rcu *filter_hash
   kernel/trace/ftrace.c:1032:43: sparse:     got struct ftrace_hash *
   kernel/trace/ftrace.c:1259:40: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct ftrace_hash *hash @@     got struct ftrace_hash [noderef] __rcu *filter_hash @@
   kernel/trace/ftrace.c:1259:40: sparse:     expected struct ftrace_hash *hash
   kernel/trace/ftrace.c:1259:40: sparse:     got struct ftrace_hash [noderef] __rcu *filter_hash
   kernel/trace/ftrace.c:1260:40: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct ftrace_hash *hash @@     got struct ftrace_hash [noderef] __rcu *notrace_hash @@
   kernel/trace/ftrace.c:1260:40: sparse:     expected struct ftrace_hash *hash
   kernel/trace/ftrace.c:1260:40: sparse:     got struct ftrace_hash [noderef] __rcu *notrace_hash
   kernel/trace/ftrace.c:1987:54: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct ftrace_hash *old_hash @@     got struct ftrace_hash [noderef] __rcu *filter_hash @@
   kernel/trace/ftrace.c:1987:54: sparse:     expected struct ftrace_hash *old_hash
   kernel/trace/ftrace.c:1987:54: sparse:     got struct ftrace_hash [noderef] __rcu *filter_hash
   kernel/trace/ftrace.c:1454:9: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/trace/ftrace.c:1454:9: sparse:    struct ftrace_hash [noderef] __rcu *
   kernel/trace/ftrace.c:1454:9: sparse:    struct ftrace_hash *
   kernel/trace/ftrace.c:1470:39: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct ftrace_hash *hash @@     got struct ftrace_hash [noderef] __rcu *filter_hash @@
   kernel/trace/ftrace.c:1471:40: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct ftrace_hash *hash @@     got struct ftrace_hash [noderef] __rcu *filter_hash @@
   kernel/trace/ftrace.c:1472:40: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct ftrace_hash *hash @@     got struct ftrace_hash [noderef] __rcu *notrace_hash @@
   kernel/trace/ftrace.c:1473:42: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct ftrace_hash *hash @@     got struct ftrace_hash [noderef] __rcu *notrace_hash @@
   kernel/trace/ftrace.c:1644:18: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct ftrace_ops *ops @@     got struct ftrace_ops [noderef] __rcu *[addressable] [toplevel] ftrace_ops_list @@
   kernel/trace/ftrace.c:1645:43: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct ftrace_ops *ops @@     got struct ftrace_ops [noderef] __rcu *next @@
   kernel/trace/ftrace.c:1693:22: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct ftrace_hash *hash @@     got struct ftrace_hash [noderef] __rcu *filter_hash @@
   kernel/trace/ftrace.c:1694:28: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct ftrace_hash *other_hash @@     got struct ftrace_hash [noderef] __rcu *notrace_hash @@
   kernel/trace/ftrace.c:1699:22: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct ftrace_hash *hash @@     got struct ftrace_hash [noderef] __rcu *notrace_hash @@
   kernel/trace/ftrace.c:1700:28: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct ftrace_hash *other_hash @@     got struct ftrace_hash [noderef] __rcu *filter_hash @@
   kernel/trace/ftrace.c:1965:50: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct ftrace_hash *hash @@     got struct ftrace_hash [noderef] __rcu *filter_hash @@
   kernel/trace/ftrace.c:1976:50: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct ftrace_hash *hash @@     got struct ftrace_hash [noderef] __rcu *filter_hash @@
   kernel/trace/ftrace.c:3316:14: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct ftrace_hash *hash @@     got struct ftrace_hash [noderef] __rcu *filter_hash @@
   kernel/trace/ftrace.c:3333:22: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct ftrace_hash *hash @@     got struct ftrace_hash [noderef] __rcu *filter_hash @@
   kernel/trace/ftrace.c:3913:22: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct ftrace_hash *hash @@     got struct ftrace_hash [noderef] __rcu *notrace_hash @@
   kernel/trace/ftrace.c:3916:22: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct ftrace_hash *hash @@     got struct ftrace_hash [noderef] __rcu *filter_hash @@
   kernel/trace/ftrace.c:4340:27: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct ftrace_hash **orig_hash @@     got struct ftrace_hash [noderef] __rcu ** @@
   kernel/trace/ftrace.c:4342:27: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct ftrace_hash **orig_hash @@     got struct ftrace_hash [noderef] __rcu ** @@
   kernel/trace/ftrace.c:4715:19: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct ftrace_hash **orig_hash @@     got struct ftrace_hash [noderef] __rcu ** @@
   kernel/trace/ftrace.c:4859:19: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct ftrace_hash **orig_hash @@     got struct ftrace_hash [noderef] __rcu ** @@
   kernel/trace/ftrace.c:4865:34: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct ftrace_hash [noderef] __rcu *filter_hash @@     got struct ftrace_hash *[assigned] old_hash @@
   kernel/trace/ftrace.c:5139:27: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct ftrace_hash **orig_hash @@     got struct ftrace_hash [noderef] __rcu ** @@
   kernel/trace/ftrace.c:5141:27: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct ftrace_hash **orig_hash @@     got struct ftrace_hash [noderef] __rcu ** @@
   kernel/trace/ftrace.c:5383:14: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct ftrace_hash *hash @@     got struct ftrace_hash [noderef] __rcu *filter_hash @@
>> kernel/trace/ftrace.c:5582:22: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct ftrace_hash **orig @@     got struct ftrace_hash [noderef] __rcu ** @@
   kernel/trace/ftrace.c:5584:22: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct ftrace_hash **orig @@     got struct ftrace_hash [noderef] __rcu ** @@
   kernel/trace/ftrace.c:5741:14: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct ftrace_hash *hash @@     got struct ftrace_hash [noderef] __rcu *filter_hash @@
   kernel/trace/ftrace.c:5803:50: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct ftrace_hash *hash @@     got struct ftrace_hash [noderef] __rcu *filter_hash @@
   kernel/trace/ftrace.c:5870:14: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct ftrace_hash *hash @@     got struct ftrace_hash [noderef] __rcu *filter_hash @@
   kernel/trace/ftrace.c:6095:35: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct ftrace_hash [noderef] __rcu *extern [addressable] [toplevel] ftrace_graph_hash @@     got struct ftrace_hash *[assigned] hash @@
   kernel/trace/ftrace.c:6097:43: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct ftrace_hash [noderef] __rcu *extern [addressable] [toplevel] ftrace_graph_notrace_hash @@     got struct ftrace_hash *[assigned] hash @@
   kernel/trace/ftrace.c:6158:35: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct ftrace_hash **orig_hash @@     got struct ftrace_hash [noderef] __rcu ** @@
   kernel/trace/ftrace.c:6162:35: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct ftrace_hash **orig_hash @@     got struct ftrace_hash [noderef] __rcu ** @@
   kernel/trace/ftrace.c:6216:47: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct ftrace_hash [noderef] __rcu *[addressable] [toplevel] ftrace_graph_hash @@     got struct ftrace_hash * @@
   kernel/trace/ftrace.c:6217:55: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct ftrace_hash [noderef] __rcu *[addressable] [toplevel] ftrace_graph_notrace_hash @@     got struct ftrace_hash * @@
   kernel/trace/ftrace.c:6866:18: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct ftrace_ops *ops @@     got struct ftrace_ops [noderef] __rcu *[addressable] [toplevel] ftrace_ops_list @@
   kernel/trace/ftrace.c:6866:66: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct ftrace_ops *ops @@     got struct ftrace_ops [noderef] __rcu *next @@
   kernel/trace/ftrace.c:6918:59: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected struct ftrace_hash *hash @@     got struct ftrace_hash [noderef] __rcu *filter_hash @@
   kernel/trace/ftrace.c:6919:59: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected struct ftrace_hash *hash @@     got struct ftrace_hash [noderef] __rcu *notrace_hash @@
   kernel/trace/ftrace.c:7301:62: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected struct ftrace_hash *hash @@     got struct ftrace_hash [noderef] __rcu *filter_hash @@
   kernel/trace/ftrace.c:7302:62: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected struct ftrace_hash *hash @@     got struct ftrace_hash [noderef] __rcu *notrace_hash @@
   kernel/trace/ftrace.c:7347:36: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/trace/ftrace.c:7347:36: sparse:    struct ftrace_ops [noderef] __rcu *
   kernel/trace/ftrace.c:7347:36: sparse:    struct ftrace_ops *
   kernel/trace/ftrace.c:193:20: sparse: sparse: dereference of noderef expression
   kernel/trace/ftrace.c:193:20: sparse: sparse: dereference of noderef expression
   kernel/trace/ftrace.c:193:20: sparse: sparse: dereference of noderef expression
   kernel/trace/ftrace.c:3111:46: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct ftrace_hash *hash @@     got struct ftrace_hash [noderef] __rcu *filter_hash @@
   kernel/trace/ftrace.c:3111:46: sparse:     expected struct ftrace_hash *hash
   kernel/trace/ftrace.c:3111:46: sparse:     got struct ftrace_hash [noderef] __rcu *filter_hash
   kernel/trace/ftrace.c:3112:47: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct ftrace_hash *hash @@     got struct ftrace_hash [noderef] __rcu *filter_hash @@
   kernel/trace/ftrace.c:3112:47: sparse:     expected struct ftrace_hash *hash
   kernel/trace/ftrace.c:3112:47: sparse:     got struct ftrace_hash [noderef] __rcu *filter_hash
   kernel/trace/ftrace.c:3116:44: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct ftrace_hash *hash @@     got struct ftrace_hash [noderef] __rcu *notrace_hash @@
   kernel/trace/ftrace.c:3116:44: sparse:     expected struct ftrace_hash *hash
   kernel/trace/ftrace.c:3116:44: sparse:     got struct ftrace_hash [noderef] __rcu *notrace_hash
   kernel/trace/ftrace.c:3088:48: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct ftrace_hash *hash @@     got struct ftrace_hash [noderef] __rcu *filter_hash @@
   kernel/trace/ftrace.c:3088:48: sparse:     expected struct ftrace_hash *hash
   kernel/trace/ftrace.c:3088:48: sparse:     got struct ftrace_hash [noderef] __rcu *filter_hash
   kernel/trace/ftrace.c:3089:49: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct ftrace_hash *hash @@     got struct ftrace_hash [noderef] __rcu *notrace_hash @@
   kernel/trace/ftrace.c:3089:49: sparse:     expected struct ftrace_hash *hash
   kernel/trace/ftrace.c:3089:49: sparse:     got struct ftrace_hash [noderef] __rcu *notrace_hash

vim +5582 kernel/trace/ftrace.c

  5565	
  5566	static int set_ftrace_ops(struct ftrace_ops *ops, struct ftrace_hash *set, int enable)
  5567	{
  5568		struct ftrace_func_entry *iter, *entry;
  5569		struct ftrace_hash **orig, *hash = NULL;
  5570		int i, err = -ENOMEM, size;
  5571		unsigned long ip;
  5572		bool enabled;
  5573	
  5574		if (!set)
  5575			return -EINVAL;
  5576		if (unlikely(ftrace_disabled))
  5577			return -ENODEV;
  5578	
  5579		mutex_lock(&direct_mutex);
  5580	
  5581		if (enable)
> 5582			orig = &ops->func_hash->filter_hash;
  5583		else
  5584			orig = &ops->func_hash->notrace_hash;
  5585	
  5586	        hash = dup_hash(*orig, (*orig)->count, false);
  5587		if (!hash)
  5588			goto out_unlock_direct;
  5589	
  5590		err = -EBUSY;
  5591		size = 1 << set->size_bits;
  5592		for (i = 0; i < size; i++) {
  5593			hlist_for_each_entry(iter, &set->buckets[i], hlist) {
  5594				ip = ftrace_location(iter->ip);
  5595				if (!ip) {
  5596					err = -EINVAL;
  5597					goto out_unlock_direct;
  5598				}
  5599				entry = __ftrace_lookup_ip(hash, ip);
  5600				if (!entry) {
  5601					entry = kmalloc(sizeof(*entry), GFP_KERNEL);
  5602					if (!entry) {
  5603						err = -ENOMEM;
  5604						goto out_unlock_direct;
  5605					}
  5606					entry->ip = ip;
  5607					entry->direct = iter->direct;
  5608					ftrace_hash_add_entry(hash, entry);
  5609					continue;
  5610				}
  5611				if (iter->direct)
  5612					entry->direct = iter->direct;
  5613				else
  5614					free_hash_entry(hash, entry);
  5615			}
  5616		}
  5617	
  5618		mutex_lock(&ftrace_lock);
  5619	
  5620		ftrace_ops_init(ops);
  5621		enabled = ops->flags & FTRACE_OPS_FL_ENABLED;
  5622	
  5623		if ((hash->count == 0) && enabled) {
  5624			/* no functions to enable, going down */
  5625			err = ftrace_shutdown(ops, 0);
  5626			if (err)
  5627				goto out_unlock_ftrace;
  5628			err = ftrace_hash_move_and_update_ops(ops, orig, hash, enable);
  5629			ftrace_hash_free(direct_functions);
  5630			direct_functions = NULL;
  5631		} else if (!enabled) {
  5632			/* ops not enabled, starting */
  5633			ftrace_hash_free(direct_functions);
  5634			direct_functions = dup_hash(hash, hash->count, false);
  5635			if (!direct_functions)
  5636				goto out_unlock_ftrace;
  5637	
  5638			err = ftrace_hash_move_and_update_ops(ops, orig, hash, enable);
  5639			if (err)
  5640				goto out_unlock_ftrace;
  5641			err = ftrace_startup(ops, 0);
  5642		} else {
  5643			/* ops enabled, we need to shut it down, change and start again */
  5644			err = ftrace_shutdown(ops, 0);
  5645			if (err)
  5646				goto out_unlock_ftrace;
  5647			err = ftrace_hash_move_and_update_ops(ops, orig, EMPTY_HASH, enable);
  5648			if (err)
  5649				goto out_unlock_ftrace;
  5650	
  5651			ftrace_hash_free(direct_functions);
  5652			direct_functions = dup_hash(hash, hash->count, false);
  5653			if (!direct_functions)
  5654				goto out_unlock_ftrace;
  5655	
  5656			err = ftrace_hash_move_and_update_ops(ops, orig, hash, enable);
  5657			if (err)
  5658				goto out_unlock_ftrace;
  5659			err = ftrace_startup(ops, 0);
  5660		}
  5661	
  5662	out_unlock_ftrace:
  5663		mutex_unlock(&ftrace_lock);
  5664	
  5665	out_unlock_direct:
  5666		mutex_unlock(&direct_mutex);
  5667		ftrace_hash_free(hash);
  5668		return err;
  5669	}
  5670	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
