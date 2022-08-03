Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 294A2588EFA
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 16:56:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236249AbiHCO4R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 10:56:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233526AbiHCO4P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 10:56:15 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FF1A1B7AB
        for <linux-kernel@vger.kernel.org>; Wed,  3 Aug 2022 07:56:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659538572; x=1691074572;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=bvyeMXmWWbLOeO58CzINXZ97GXGO/xGzW2Bg3rGoqNE=;
  b=C/17Z5ZgZk8da4LDcNUeoe2w0HWVFfiHk27dA/OB2X9BfvrsRLWhZ16z
   G01TdMjt1qMt51llR7UqyWUSQvV32I4M4vqIAiECVA8IwRIPilsYO5ybs
   PERIyRlkHj/vTjvzMAd6hWUq1/ti+IjgI37zPrk62hEsy9Sj2dc/ejMSZ
   FPYfdMuqRcW/yBCR5AP/mwetk/LM8WsryzCdY/swtEeklM+P97974ETDS
   +c8FxT3ksE7azFA1Pz4kRAyfbgi6bkW9nxJaJSDrtid9oTglylKKHufBe
   WemOwBxu+XTXDtXXMZUd4cAV7h61CS3iVlMIR08CKzBZ8HN0ZAOP0ZtPD
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10428"; a="288447253"
X-IronPort-AV: E=Sophos;i="5.93,214,1654585200"; 
   d="scan'208";a="288447253"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2022 07:56:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,214,1654585200"; 
   d="scan'208";a="930411517"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 03 Aug 2022 07:56:10 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oJFn8-000HNs-0g;
        Wed, 03 Aug 2022 14:56:10 +0000
Date:   Wed, 3 Aug 2022 22:55:16 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [jolsa-perf:bpf/tracing_multi_4 8/35] kernel/trace/ftrace.c:5636:22:
 sparse: sparse: incorrect type in assignment (different address spaces)
Message-ID: <202208032229.zPwzxkjq-lkp@intel.com>
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
head:   a63fc296e166a76b3f7250a966df4651e3a846f1
commit: 0684ed1bd5511a50ab8f70973fe310d711027dc9 [8/35] ftrace: Add set_ftrace_direct function
config: i386-randconfig-s003-20220801 (https://download.01.org/0day-ci/archive/20220803/202208032229.zPwzxkjq-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-3) 11.3.0
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.4-39-gce1a6720-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git/commit/?id=0684ed1bd5511a50ab8f70973fe310d711027dc9
        git remote add jolsa-perf https://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git
        git fetch --no-tags jolsa-perf bpf/tracing_multi_4
        git checkout 0684ed1bd5511a50ab8f70973fe310d711027dc9
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
   kernel/trace/ftrace.c:2025:54: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct ftrace_hash *old_hash @@     got struct ftrace_hash [noderef] __rcu *filter_hash @@
   kernel/trace/ftrace.c:2025:54: sparse:     expected struct ftrace_hash *old_hash
   kernel/trace/ftrace.c:2025:54: sparse:     got struct ftrace_hash [noderef] __rcu *filter_hash
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
   kernel/trace/ftrace.c:3148:46: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct ftrace_hash *hash @@     got struct ftrace_hash [noderef] __rcu *filter_hash @@
   kernel/trace/ftrace.c:3149:47: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct ftrace_hash *hash @@     got struct ftrace_hash [noderef] __rcu *filter_hash @@
   kernel/trace/ftrace.c:3153:44: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct ftrace_hash *hash @@     got struct ftrace_hash [noderef] __rcu *notrace_hash @@
   kernel/trace/ftrace.c:2003:50: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct ftrace_hash *hash @@     got struct ftrace_hash [noderef] __rcu *filter_hash @@
   kernel/trace/ftrace.c:2014:50: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct ftrace_hash *hash @@     got struct ftrace_hash [noderef] __rcu *filter_hash @@
   kernel/trace/ftrace.c:3366:14: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct ftrace_hash *hash @@     got struct ftrace_hash [noderef] __rcu *filter_hash @@
   kernel/trace/ftrace.c:3383:22: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct ftrace_hash *hash @@     got struct ftrace_hash [noderef] __rcu *filter_hash @@
   kernel/trace/ftrace.c:3963:22: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct ftrace_hash *hash @@     got struct ftrace_hash [noderef] __rcu *notrace_hash @@
   kernel/trace/ftrace.c:3966:22: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct ftrace_hash *hash @@     got struct ftrace_hash [noderef] __rcu *filter_hash @@
   kernel/trace/ftrace.c:4390:27: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct ftrace_hash **orig_hash @@     got struct ftrace_hash [noderef] __rcu ** @@
   kernel/trace/ftrace.c:4392:27: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct ftrace_hash **orig_hash @@     got struct ftrace_hash [noderef] __rcu ** @@
   kernel/trace/ftrace.c:4765:19: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct ftrace_hash **orig_hash @@     got struct ftrace_hash [noderef] __rcu ** @@
   kernel/trace/ftrace.c:4909:19: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct ftrace_hash **orig_hash @@     got struct ftrace_hash [noderef] __rcu ** @@
   kernel/trace/ftrace.c:4915:34: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct ftrace_hash [noderef] __rcu *filter_hash @@     got struct ftrace_hash *[assigned] old_hash @@
   kernel/trace/ftrace.c:5189:27: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct ftrace_hash **orig_hash @@     got struct ftrace_hash [noderef] __rcu ** @@
   kernel/trace/ftrace.c:5191:27: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct ftrace_hash **orig_hash @@     got struct ftrace_hash [noderef] __rcu ** @@
   kernel/trace/ftrace.c:5435:14: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct ftrace_hash *hash @@     got struct ftrace_hash [noderef] __rcu *filter_hash @@
>> kernel/trace/ftrace.c:5636:22: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct ftrace_hash **orig @@     got struct ftrace_hash [noderef] __rcu ** @@
   kernel/trace/ftrace.c:5638:22: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct ftrace_hash **orig @@     got struct ftrace_hash [noderef] __rcu ** @@
   kernel/trace/ftrace.c:5792:14: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct ftrace_hash *hash @@     got struct ftrace_hash [noderef] __rcu *filter_hash @@
   kernel/trace/ftrace.c:5854:50: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct ftrace_hash *hash @@     got struct ftrace_hash [noderef] __rcu *filter_hash @@
   kernel/trace/ftrace.c:5902:14: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct ftrace_hash *hash @@     got struct ftrace_hash [noderef] __rcu *filter_hash @@
   kernel/trace/ftrace.c:6247:35: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct ftrace_hash **orig_hash @@     got struct ftrace_hash [noderef] __rcu ** @@
   kernel/trace/ftrace.c:6251:35: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct ftrace_hash **orig_hash @@     got struct ftrace_hash [noderef] __rcu ** @@
   kernel/trace/ftrace.c:6955:18: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct ftrace_ops *ops @@     got struct ftrace_ops [noderef] __rcu *[addressable] [toplevel] ftrace_ops_list @@
   kernel/trace/ftrace.c:6955:66: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct ftrace_ops *ops @@     got struct ftrace_ops [noderef] __rcu *next @@
   kernel/trace/ftrace.c:7007:59: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected struct ftrace_hash *hash @@     got struct ftrace_hash [noderef] __rcu *filter_hash @@
   kernel/trace/ftrace.c:7008:59: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected struct ftrace_hash *hash @@     got struct ftrace_hash [noderef] __rcu *notrace_hash @@
   kernel/trace/ftrace.c:7390:62: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected struct ftrace_hash *hash @@     got struct ftrace_hash [noderef] __rcu *filter_hash @@
   kernel/trace/ftrace.c:7391:62: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected struct ftrace_hash *hash @@     got struct ftrace_hash [noderef] __rcu *notrace_hash @@
   kernel/trace/ftrace.c:7436:36: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/trace/ftrace.c:7436:36: sparse:    struct ftrace_ops [noderef] __rcu *
   kernel/trace/ftrace.c:7436:36: sparse:    struct ftrace_ops *
   kernel/trace/ftrace.c:8211:14: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct ftrace_hash *hash @@     got struct ftrace_hash [noderef] __rcu *filter_hash @@
   kernel/trace/ftrace.c:8211:14: sparse:     expected struct ftrace_hash *hash
   kernel/trace/ftrace.c:8211:14: sparse:     got struct ftrace_hash [noderef] __rcu *filter_hash
   kernel/trace/ftrace.c:8260:14: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct ftrace_hash *hash @@     got struct ftrace_hash [noderef] __rcu *filter_hash @@
   kernel/trace/ftrace.c:8260:14: sparse:     expected struct ftrace_hash *hash
   kernel/trace/ftrace.c:8260:14: sparse:     got struct ftrace_hash [noderef] __rcu *filter_hash
   kernel/trace/ftrace.c:193:20: sparse: sparse: dereference of noderef expression
   kernel/trace/ftrace.c:193:20: sparse: sparse: dereference of noderef expression
   kernel/trace/ftrace.c:193:20: sparse: sparse: dereference of noderef expression
   kernel/trace/ftrace.c:3125:48: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct ftrace_hash *hash @@     got struct ftrace_hash [noderef] __rcu *filter_hash @@
   kernel/trace/ftrace.c:3125:48: sparse:     expected struct ftrace_hash *hash
   kernel/trace/ftrace.c:3125:48: sparse:     got struct ftrace_hash [noderef] __rcu *filter_hash
   kernel/trace/ftrace.c:3126:49: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct ftrace_hash *hash @@     got struct ftrace_hash [noderef] __rcu *notrace_hash @@
   kernel/trace/ftrace.c:3126:49: sparse:     expected struct ftrace_hash *hash
   kernel/trace/ftrace.c:3126:49: sparse:     got struct ftrace_hash [noderef] __rcu *notrace_hash

vim +5636 kernel/trace/ftrace.c

  5617	
  5618	static int set_ftrace_ops(struct ftrace_ops *ops, struct ftrace_hash *set, int enable)
  5619	{
  5620		struct ftrace_func_entry *iter, *entry;
  5621		struct ftrace_hash **orig, *hash = NULL;
  5622		int i, err = -ENOMEM, size;
  5623		unsigned long ip;
  5624		bool enabled;
  5625	
  5626		if (!set)
  5627			return -EINVAL;
  5628		if (unlikely(ftrace_disabled))
  5629			return -ENODEV;
  5630	
  5631		mutex_lock(&direct_mutex);
  5632	
  5633		ftrace_ops_init(ops);
  5634	
  5635		if (enable)
> 5636			orig = &ops->func_hash->filter_hash;
  5637		else
  5638			orig = &ops->func_hash->notrace_hash;
  5639	
  5640		hash = *orig ?: EMPTY_HASH;
  5641		hash = dup_hash(hash, hash->count, false);
  5642		if (!hash)
  5643			goto out_unlock_direct;
  5644	
  5645		err = -EBUSY;
  5646		size = 1 << set->size_bits;
  5647		for (i = 0; i < size; i++) {
  5648			hlist_for_each_entry(iter, &set->buckets[i], hlist) {
  5649				ip = ftrace_location(iter->ip);
  5650				if (!ip) {
  5651					err = -EINVAL;
  5652					goto out_unlock_direct;
  5653				}
  5654				entry = __ftrace_lookup_ip(hash, ip);
  5655				if (!entry) {
  5656					entry = kmalloc(sizeof(*entry), GFP_KERNEL);
  5657					if (!entry) {
  5658						err = -ENOMEM;
  5659						goto out_unlock_direct;
  5660					}
  5661					entry->ip = ip;
  5662					entry->direct = iter->direct;
  5663					ftrace_hash_add_entry(hash, entry);
  5664				} if (iter->direct)
  5665					entry->direct = iter->direct;
  5666				else
  5667					free_hash_entry(hash, entry);
  5668			}
  5669		}
  5670	
  5671		mutex_lock(&ftrace_lock);
  5672	
  5673		enabled = ops->flags & FTRACE_OPS_FL_ENABLED;
  5674	
  5675		if ((hash->count == 0) && enabled) {
  5676			/* no functions to enable, going down */
  5677			err = ftrace_shutdown(ops, 0);
  5678			if (err)
  5679				goto out_unlock_ftrace;
  5680			err = ftrace_hash_move_and_update_ops(ops, orig, hash, enable);
  5681			ftrace_hash_free(direct_functions);
  5682			direct_functions = EMPTY_HASH;
  5683		} else if (!enabled) {
  5684			/* ops not enabled, starting */
  5685			ftrace_hash_free(direct_functions);
  5686			direct_functions = dup_hash(hash, hash->count, false);
  5687			if (!direct_functions)
  5688				goto out_unlock_ftrace;
  5689	
  5690			err = ftrace_hash_move_and_update_ops(ops, orig, hash, enable);
  5691			if (err)
  5692				goto out_unlock_ftrace;
  5693			err = ftrace_startup(ops, 0);
  5694		} else {
  5695			/* ops enabled, we need to shut it down, change and start again */
  5696			err = ftrace_shutdown(ops, 0);
  5697			if (err)
  5698				goto out_unlock_ftrace;
  5699			err = ftrace_hash_move_and_update_ops(ops, orig, EMPTY_HASH, enable);
  5700			if (err)
  5701				goto out_unlock_ftrace;
  5702	
  5703			ftrace_hash_free(direct_functions);
  5704			direct_functions = dup_hash(hash, hash->count, false);
  5705			if (!direct_functions)
  5706				goto out_unlock_ftrace;
  5707	
  5708			err = ftrace_hash_move_and_update_ops(ops, orig, hash, enable);
  5709			if (err)
  5710				goto out_unlock_ftrace;
  5711			err = ftrace_startup(ops, 0);
  5712		}
  5713	
  5714	out_unlock_ftrace:
  5715		mutex_unlock(&ftrace_lock);
  5716	
  5717	out_unlock_direct:
  5718		mutex_unlock(&direct_mutex);
  5719		ftrace_hash_free(hash);
  5720		return err;
  5721	}
  5722	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
