Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 263C14B943D
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 23:58:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237942AbiBPW6K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 17:58:10 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:36344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235180AbiBPW6I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 17:58:08 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CC7D2A2281
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 14:57:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645052275; x=1676588275;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=K1FNw9kJqvzXvvYeL/LL/mYYXyP+XB5IVbv9vIzKqKI=;
  b=QvqEpS6PaUbmhwSa8YYSpNsHZ8WoW88G0VXVVg3xXeC26TxHFDN5a/CU
   ngHpqQtvLtIDIpJ7wbBvPUV/Do9hT0xn0Lf26almtIg+XpRIt70QBTWs8
   PHm+1Q2k91IMFKUgUj1/xEtSFg56gqWrscakgpJmotFqfk6rzJL13aHuG
   SpHKfTtupKBfAnP4f5wqYDfqaQnyT2ESZ/+BCwalD+k9dCkY0vfExW/k7
   sEXISgfJwRUOh3rXm+ksG6PrqgoAFLFjJNhl+hpIcMuWn4o0FCBH93de3
   7csVrmf0EKVOteDQdWfsePKbEx0XSjyO6oNvHavORYjvbgWwmDXT2xLt9
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10260"; a="337185106"
X-IronPort-AV: E=Sophos;i="5.88,374,1635231600"; 
   d="scan'208";a="337185106"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2022 14:57:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,374,1635231600"; 
   d="scan'208";a="681713134"
Received: from lkp-server01.sh.intel.com (HELO d95dc2dabeb1) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 16 Feb 2022 14:57:53 -0800
Received: from kbuild by d95dc2dabeb1 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nKTFA-000BDC-Ul; Wed, 16 Feb 2022 22:57:52 +0000
Date:   Thu, 17 Feb 2022 06:56:56 +0800
From:   kernel test robot <lkp@intel.com>
To:     David Howells <dhowells@redhat.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org
Subject: [ammarfaizi2-block:dhowells/linux-fs/netfs-maple 29/42]
 fs/netfs/buffered_write.c:28:26: warning: comparison of distinct pointer
 types ('typeof ((1UL << 14) - offset) *' (aka 'unsigned long *') and 'typeof
 (size) *' (aka 'unsigned int *'))
Message-ID: <202202170638.sSxMPQ6J-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ammarfaizi2/linux-block dhowells/linux-fs/netfs-maple
head:   5cb7f190822d09757b30cd9539e57eef72552d1f
commit: 261cd621bd0477d43de460dea6c7bf7fa81824be [29/42] netfs: Implement buffered writes through netfs_file_write_iter()
config: hexagon-randconfig-r005-20220216 (https://download.01.org/0day-ci/archive/20220217/202202170638.sSxMPQ6J-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 0e628a783b935c70c80815db6c061ec84f884af5)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/ammarfaizi2/linux-block/commit/261cd621bd0477d43de460dea6c7bf7fa81824be
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block dhowells/linux-fs/netfs-maple
        git checkout 261cd621bd0477d43de460dea6c7bf7fa81824be
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=hexagon SHELL=/bin/bash fs/netfs/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> fs/netfs/buffered_write.c:28:26: warning: comparison of distinct pointer types ('typeof ((1UL << 14) - offset) *' (aka 'unsigned long *') and 'typeof (size) *' (aka 'unsigned int *')) [-Wcompare-distinct-pointer-types]
                   unsigned int psize   = min(PAGE_SIZE - offset, size);
                                          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/minmax.h:45:19: note: expanded from macro 'min'
   #define min(x, y)       __careful_cmp(x, y, <)
                           ^~~~~~~~~~~~~~~~~~~~~~
   include/linux/minmax.h:36:24: note: expanded from macro '__careful_cmp'
           __builtin_choose_expr(__safe_cmp(x, y), \
                                 ^~~~~~~~~~~~~~~~
   include/linux/minmax.h:26:4: note: expanded from macro '__safe_cmp'
                   (__typecheck(x, y) && __no_side_effects(x, y))
                    ^~~~~~~~~~~~~~~~~
   include/linux/minmax.h:20:28: note: expanded from macro '__typecheck'
           (!!(sizeof((typeof(x) *)1 == (typeof(y) *)1)))
                      ~~~~~~~~~~~~~~ ^  ~~~~~~~~~~~~~~
>> fs/netfs/buffered_write.c:95:18: warning: comparison of distinct pointer types ('typeof (target->from) *' (aka 'unsigned long long *') and 'typeof (folio_pos(folio) + offset) *' (aka 'long long *')) [-Wcompare-distinct-pointer-types]
           target->from  = min(target->from, folio_pos(folio) + offset);
                           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/minmax.h:45:19: note: expanded from macro 'min'
   #define min(x, y)       __careful_cmp(x, y, <)
                           ^~~~~~~~~~~~~~~~~~~~~~
   include/linux/minmax.h:36:24: note: expanded from macro '__careful_cmp'
           __builtin_choose_expr(__safe_cmp(x, y), \
                                 ^~~~~~~~~~~~~~~~
   include/linux/minmax.h:26:4: note: expanded from macro '__safe_cmp'
                   (__typecheck(x, y) && __no_side_effects(x, y))
                    ^~~~~~~~~~~~~~~~~
   include/linux/minmax.h:20:28: note: expanded from macro '__typecheck'
           (!!(sizeof((typeof(x) *)1 == (typeof(y) *)1)))
                      ~~~~~~~~~~~~~~ ^  ~~~~~~~~~~~~~~
>> fs/netfs/buffered_write.c:96:18: warning: comparison of distinct pointer types ('typeof (target->to) *' (aka 'unsigned long long *') and 'typeof (folio_pos(folio) + offset + len) *' (aka 'long long *')) [-Wcompare-distinct-pointer-types]
           target->to    = max(target->to,   folio_pos(folio) + offset + len);
                           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/minmax.h:52:19: note: expanded from macro 'max'
   #define max(x, y)       __careful_cmp(x, y, >)
                           ^~~~~~~~~~~~~~~~~~~~~~
   include/linux/minmax.h:36:24: note: expanded from macro '__careful_cmp'
           __builtin_choose_expr(__safe_cmp(x, y), \
                                 ^~~~~~~~~~~~~~~~
   include/linux/minmax.h:26:4: note: expanded from macro '__safe_cmp'
                   (__typecheck(x, y) && __no_side_effects(x, y))
                    ^~~~~~~~~~~~~~~~~
   include/linux/minmax.h:20:28: note: expanded from macro '__typecheck'
           (!!(sizeof((typeof(x) *)1 == (typeof(y) *)1)))
                      ~~~~~~~~~~~~~~ ^  ~~~~~~~~~~~~~~
   3 warnings generated.


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
    73		    !test_bit(NETFS_ICTX_NEW_CONTENT, &ctx->flags) &&
    74		    b->from < ctx->zero_point)
    75			return false;
    76		if (ctx->ops->are_regions_mergeable)
    77			return ctx->ops->are_regions_mergeable(ctx, a, b);
    78		return true;
    79	}
    80	
    81	/*
    82	 * Subsume the modifications into an existing target region.  Returns true if
    83	 * we need to update the dirty_regions tree.
    84	 */
    85	static bool netfs_subsume_into_existing(struct netfs_i_context *ctx,
    86						struct folio *folio,
    87						struct ma_state *mas,
    88						struct netfs_dirty_region **_target,
    89						struct netfs_dirty_region **_to_put,
    90						pgoff_t *_first, pgoff_t *_last,
    91						size_t offset, size_t len)
    92	{
    93		struct netfs_dirty_region *target = *_target, *prev;
    94	
  > 95		target->from  = min(target->from, folio_pos(folio) + offset);
  > 96		target->to    = max(target->to,   folio_pos(folio) + offset + len);
    97		trace_netfs_dirty(ctx, target, NULL, *_first, *_last,
    98				  netfs_dirty_trace_modified);
    99	
   100		/* We might have bridged to the previous region also. */
   101		prev = mas_prev(mas, *_first - 1);
   102		if (!netfs_mas_is_valid(prev))
   103			return false;
   104	
   105		if (prev->to != target->from ||
   106		    prev->waiting_on_wb != target->waiting_on_wb)
   107			return false;
   108	
   109		*_first = mas->index;
   110		prev->to = target->to;
   111		*_to_put = target;
   112		trace_netfs_dirty(ctx, prev, NULL, *_first, *_last,
   113				  netfs_dirty_trace_merged_prev);
   114		return true;
   115	}
   116	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
