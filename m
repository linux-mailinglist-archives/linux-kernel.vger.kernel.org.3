Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4915C4F4F5D
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 04:02:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354894AbiDFAqe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 20:46:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381931AbiDEORE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 10:17:04 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCFDE1606AB
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 06:01:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649163681; x=1680699681;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=R/3O09Fvikb/UjlJkbEDyN5KSOd3qkHBI3aO3BM5jn0=;
  b=BAGTaW8q9IjK1hayD7V6bPVvVxZNMp9BunuZZv5xRwuZEWuxtqNoAbms
   gQim9dg+qHMoWZJ3eLdYeOcwcwQu0yO7ly3+5VsgVfP9ynn6WXvyZZKBz
   vlgvuJino8ve6J3rH70uOsFeRJPKoBL9S6tr8UstYqgV6K6fhxVbI6eqM
   JG4+X8ncwSqNMtu4pP4Dp//flPcBIN1tnnpwXQRDqAmPI2xenbW+6j9Dg
   bSMU1xVQuUMz3Q9BZho9eMriP2tVzoM+oskao/Umk1j5Glzr6AY6s5/pV
   GJOo/9IUwo//d7Wdensa6Nz4kIh6y1104OrIYR6Xsth2NX7sLITsKBhfU
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10307"; a="323914999"
X-IronPort-AV: E=Sophos;i="5.90,236,1643702400"; 
   d="scan'208";a="323914999"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2022 06:01:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,236,1643702400"; 
   d="scan'208";a="587920871"
Received: from lkp-server02.sh.intel.com (HELO a44fdfb70b94) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 05 Apr 2022 06:01:14 -0700
Received: from kbuild by a44fdfb70b94 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nbio5-0003Id-CI;
        Tue, 05 Apr 2022 13:01:13 +0000
Date:   Tue, 5 Apr 2022 21:00:08 +0800
From:   kernel test robot <lkp@intel.com>
To:     David Howells <dhowells@redhat.com>
Cc:     kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org
Subject: [ammarfaizi2-block:dhowells/linux-fs/netfs-maple 33/40]
 fs/netfs/buffered_write.c:28:40: sparse: sparse: incompatible types in
 comparison expression (different type sizes):
Message-ID: <202204052030.EJNYjMgU-lkp@intel.com>
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

tree:   https://github.com/ammarfaizi2/linux-block dhowells/linux-fs/netfs-maple
head:   674eea41fc70a740ff83ec590f9833f805852464
commit: 073b0ba90614945b31bccfede6e00102b7eb460e [33/40] netfs: Implement buffered writes through netfs_file_write_iter()
config: i386-randconfig-s002 (https://download.01.org/0day-ci/archive/20220405/202204052030.EJNYjMgU-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.2.0-19) 11.2.0
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://github.com/ammarfaizi2/linux-block/commit/073b0ba90614945b31bccfede6e00102b7eb460e
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block dhowells/linux-fs/netfs-maple
        git checkout 073b0ba90614945b31bccfede6e00102b7eb460e
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=i386 SHELL=/bin/bash fs/netfs/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
>> fs/netfs/buffered_write.c:28:40: sparse: sparse: incompatible types in comparison expression (different type sizes):
>> fs/netfs/buffered_write.c:28:40: sparse:    unsigned long *
>> fs/netfs/buffered_write.c:28:40: sparse:    unsigned int *
>> fs/netfs/buffered_write.c:94:25: sparse: sparse: incompatible types in comparison expression (different signedness):
>> fs/netfs/buffered_write.c:94:25: sparse:    unsigned long long *
>> fs/netfs/buffered_write.c:94:25: sparse:    long long *
   fs/netfs/buffered_write.c:95:25: sparse: sparse: incompatible types in comparison expression (different signedness):
   fs/netfs/buffered_write.c:95:25: sparse:    unsigned long long *
   fs/netfs/buffered_write.c:95:25: sparse:    long long *

vim +28 fs/netfs/buffered_write.c

    18	
    19	static size_t copy_folio_from_iter_atomic(struct folio *folio,
    20						  unsigned int offset, size_t size,
    21						  struct iov_iter *i)
    22	{
    23		size_t copied = 0, n;
    24	
    25		do {
    26			unsigned int index   = offset / PAGE_SIZE;
    27			unsigned int poffset = offset % PAGE_SIZE;
  > 28			unsigned int psize   = min(PAGE_SIZE - offset, size);
    29	
    30			n = copy_page_from_iter_atomic(folio_file_page(folio, index),
    31						       poffset, psize, i);
    32			copied += n;
    33			if (n < psize)
    34				break;
    35			size -= n;
    36		} while (size);
    37		return copied;
    38	}
    39	
    40	/*
    41	 * Initialise a new dirty folio group.  We have to round it out to any crypto
    42	 * alignment.
    43	 */
    44	static void netfs_init_dirty_region(struct netfs_i_context *ctx,
    45					    struct netfs_dirty_region *region,
    46					    struct file *file,
    47					    loff_t start, size_t len)
    48	{
    49		region->from		= start;
    50		region->to		= start + len;
    51		region->debug_id	= atomic_inc_return(&netfs_region_debug_ids);
    52	
    53		if (file && ctx->ops->init_dirty_region)
    54			ctx->ops->init_dirty_region(region, file);
    55	
    56		trace_netfs_ref_region(region->debug_id, refcount_read(&region->ref),
    57				       netfs_region_trace_new);
    58	}
    59	
    60	/*
    61	 * Return true if two dirty regions are compatible such that b can be merged
    62	 * onto the end of a.
    63	 */
    64	bool netfs_are_regions_mergeable(struct netfs_i_context *ctx,
    65					 struct netfs_dirty_region *a,
    66					 struct netfs_dirty_region *b)
    67	{
    68		if (!netfs_mas_is_valid(a) || !netfs_mas_is_valid(b))
    69			return a == b;
    70		if (b->waiting_on_wb != a->waiting_on_wb)
    71			return false;
    72		if (b->from != a->to &&
    73		    b->from < ctx->zero_point)
    74			return false;
    75		if (ctx->ops->are_regions_mergeable)
    76			return ctx->ops->are_regions_mergeable(ctx, a, b);
    77		return true;
    78	}
    79	
    80	/*
    81	 * Subsume the modifications into an existing target region.  Returns true if
    82	 * we need to update the dirty_regions tree.
    83	 */
    84	static bool netfs_subsume_into_existing(struct netfs_i_context *ctx,
    85						struct folio *folio,
    86						struct ma_state *mas,
    87						struct netfs_dirty_region **_target,
    88						struct netfs_dirty_region **_to_put,
    89						pgoff_t *_first, pgoff_t *_last,
    90						size_t offset, size_t len)
    91	{
    92		struct netfs_dirty_region *target = *_target, *prev;
    93	
  > 94		target->from  = min(target->from, folio_pos(folio) + offset);
    95		target->to    = max(target->to,   folio_pos(folio) + offset + len);
    96		trace_netfs_dirty(ctx, target, NULL, *_first, *_last,
    97				  netfs_dirty_trace_modified);
    98	
    99		/* We might have bridged to the previous region also. */
   100		prev = mas_prev(mas, *_first - 1);
   101		if (!netfs_mas_is_valid(prev))
   102			return false;
   103	
   104		if (prev->to != target->from ||
   105		    prev->waiting_on_wb != target->waiting_on_wb)
   106			return false;
   107	
   108		*_first = mas->index;
   109		prev->to = target->to;
   110		*_to_put = target;
   111		trace_netfs_dirty(ctx, prev, NULL, *_first, *_last,
   112				  netfs_dirty_trace_merged_prev);
   113		return true;
   114	}
   115	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
