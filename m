Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D0834B1E11
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 07:04:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245192AbiBKGDu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 01:03:50 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:48818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238547AbiBKGDe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 01:03:34 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDAE4264F
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 22:03:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644559413; x=1676095413;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=5wqtbc0vWefMzKGCJhOvChWgfOmyEIjI7FN+FIK74zs=;
  b=AkE2RHNstqyUkBmQs8IBh2US4/BQSxT3B0oWWKef8AQDV/hRMDU4YqQ9
   kzeMTyKdcWZV7TENKl75z5+afRWZq9vHEBBhx5O2G+KKRv3ZzmsZsZ5Js
   lPHXa+jER6eULHK6fQFfJsNuofssGK4Jr+vXAaZpTCb5KC8NuDJEwzuVK
   270dvBjuI7eAB2tJJq+KwLnygtsknT8tCKz4wj8DMm9t7F+SF5VsaYIAn
   3dFfIlDXExa3jW3rDyIa4ByByn77VSQBY9jEATQlalvbOL6+wCuhHxW12
   pZGPMq4sUpZzi7oIpJmObj0IUp6UBL8uDiZ//ze8JJAlJYiHfDkR6PEQb
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10254"; a="247259370"
X-IronPort-AV: E=Sophos;i="5.88,359,1635231600"; 
   d="scan'208";a="247259370"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2022 22:03:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,359,1635231600"; 
   d="scan'208";a="701984598"
Received: from lkp-server01.sh.intel.com (HELO d95dc2dabeb1) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 10 Feb 2022 22:03:31 -0800
Received: from kbuild by d95dc2dabeb1 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nIP1m-0004Bz-WF; Fri, 11 Feb 2022 06:03:31 +0000
Date:   Fri, 11 Feb 2022 14:02:50 +0800
From:   kernel test robot <lkp@intel.com>
To:     David Howells <dhowells@redhat.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org
Subject: [ammarfaizi2-block:dhowells/linux-fs/netfs-maple 29/35]
 fs/netfs/write_helper.c:28:26: warning: comparison of distinct pointer types
 ('typeof ((1UL << 18) - offset) *' (aka 'unsigned long *') and 'typeof
 (size) *' (aka 'unsigned int *'))
Message-ID: <202202111352.8qGMAF4o-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ammarfaizi2/linux-block dhowells/linux-fs/netfs-maple
head:   429e2bb6fb190f390ed23afc0d2308e877c43be5
commit: 01abe2ebb0b5676c9d0394947cfeea45d0f5c09f [29/35] netfs: Implement buffered writes through netfs_file_write_iter()
config: hexagon-randconfig-r041-20220211 (https://download.01.org/0day-ci/archive/20220211/202202111352.8qGMAF4o-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project f6685f774697c85d6a352dcea013f46a99f9fe31)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/ammarfaizi2/linux-block/commit/01abe2ebb0b5676c9d0394947cfeea45d0f5c09f
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block dhowells/linux-fs/netfs-maple
        git checkout 01abe2ebb0b5676c9d0394947cfeea45d0f5c09f
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=hexagon SHELL=/bin/bash fs/netfs/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> fs/netfs/write_helper.c:28:26: warning: comparison of distinct pointer types ('typeof ((1UL << 18) - offset) *' (aka 'unsigned long *') and 'typeof (size) *' (aka 'unsigned int *')) [-Wcompare-distinct-pointer-types]
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
>> fs/netfs/write_helper.c:126:18: warning: comparison of distinct pointer types ('typeof (target->from) *' (aka 'unsigned long long *') and 'typeof (folio_pos(folio) + offset) *' (aka 'long long *')) [-Wcompare-distinct-pointer-types]
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
>> fs/netfs/write_helper.c:127:18: warning: comparison of distinct pointer types ('typeof (target->to) *' (aka 'unsigned long long *') and 'typeof (folio_pos(folio) + offset + len) *' (aka 'long long *')) [-Wcompare-distinct-pointer-types]
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


vim +28 fs/netfs/write_helper.c

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
    47					    enum netfs_write_type write_type,
    48					    loff_t start, size_t len)
    49	{
    50		struct netfs_flush_group *group;
    51	
    52		region->from		= start;
    53		region->to		= start + len;
    54		region->debug_id	= atomic_inc_return(&netfs_region_debug_ids);
    55		refcount_set(&region->ref, 1);
    56	
    57		switch (write_type) {
    58		case NETFS_ORDINARY_WRITE:
    59		case NETFS_DIO_WRITE:
    60			break;
    61		case NETFS_SYNC_WRITE:
    62			__set_bit(NETFS_REGION_SYNC, &region->flags);
    63			break;
    64		case NETFS_DSYNC_WRITE:
    65			__set_bit(NETFS_REGION_DSYNC, &region->flags);
    66			break;
    67		}
    68	
    69		if (file && ctx->ops->init_dirty_region)
    70			ctx->ops->init_dirty_region(region, file);
    71	
    72		if (!region->group) {
    73			group = list_last_entry(&ctx->flush_groups,
    74						struct netfs_flush_group, group_link);
    75			region->group = netfs_get_flush_group(group);
    76		}
    77		trace_netfs_ref_region(region->debug_id, refcount_read(&region->ref),
    78				       netfs_region_trace_new);
    79	}
    80	
    81	/*
    82	 * Decide if/how a write can be merged with a dirty region.
    83	 */
    84	static bool netfs_is_write_compatible(struct netfs_i_context *ctx,
    85					      struct netfs_dirty_region *old,
    86					      struct netfs_dirty_region *candidate)
    87	{
    88		/* Regions being actively flushed can't be merged with */
    89		if (netfs_mas_is_flushing(old) ||
    90		    candidate->group != old->group ||
    91		    test_bit(NETFS_FGROUP_FLUSHED, &old->group->flags)) {
    92			_leave(" = f [flush]");
    93			return false;
    94		}
    95	
    96		if (test_bit(NETFS_REGION_DSYNC, &old->flags)) {
    97			_leave(" = f [dsync]");
    98			return false;
    99		}
   100	
   101		if (!ctx->ops->is_write_compatible) {
   102			if (test_bit(NETFS_REGION_DSYNC, &candidate->flags)) {
   103				_leave(" = f [dsync]");
   104				return false;
   105			}
   106			_leave(" = t");
   107			return true;
   108		}
   109		return ctx->ops->is_write_compatible(ctx, old, candidate);
   110	}
   111	
   112	/*
   113	 * Subsume the modifications into an existing target region.  Returns true if
   114	 * we need to update the dirty_regions tree.
   115	 */
   116	static bool netfs_subsume_into_existing(struct netfs_i_context *ctx,
   117						struct folio *folio,
   118						struct ma_state *mas,
   119						struct netfs_dirty_region **_target,
   120						struct netfs_dirty_region **_to_put,
   121						pgoff_t *_first, pgoff_t *_last,
   122						size_t offset, size_t len)
   123	{
   124		struct netfs_dirty_region *target = *_target, *prev;
   125	
 > 126		target->from  = min(target->from, folio_pos(folio) + offset);
 > 127		target->to    = max(target->to,   folio_pos(folio) + offset + len);
   128		trace_netfs_dirty(ctx, target, NULL, *_first, *_last,
   129				  netfs_dirty_trace_modified);
   130	
   131		/* We might have bridged to the previous region also. */
   132		prev = mas_prev(mas, *_first - 1);
   133		if (!netfs_mas_is_valid(prev))
   134			return false;
   135	
   136		if (prev->to != target->from ||
   137		    prev->waiting_on_wb != target->waiting_on_wb)
   138			return false;
   139	
   140		*_first = mas->index;
   141		prev->to = target->to;
   142		*_to_put = target;
   143		trace_netfs_dirty(ctx, prev, NULL, *_first, *_last,
   144				  netfs_dirty_trace_merged_prev);
   145		return true;
   146	}
   147	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
