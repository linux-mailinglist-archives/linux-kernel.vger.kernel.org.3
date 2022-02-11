Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7234E4B1E0F
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 07:04:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243614AbiBKGDr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 01:03:47 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:48820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239178AbiBKGDe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 01:03:34 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36D215589
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 22:03:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644559414; x=1676095414;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=HK4xC+6JUpQkmPX0PZae+YBXwScsP73EELvRa6GGoCM=;
  b=kZfpPmikODPF5RGm20Fm62iWbuxN6gvQgFdL+oWiTfZKYcfWuhA9egNw
   wI4nmPGtW8fhUcbpJrwvnNagVD3oi7tphIw7j3D6DBTDIpEapQ+8Bd6Xq
   0srY95Lo6gVBIQU9W1qFL0S4C/514HIV8ZgfK6QpoT1e55gySpoDnIMLr
   hX3LAiEBtu8aDboUXqRst4talz6Q8S5b6Au4aBCo1dTdM7gn8FlxVNlfS
   g7Sms1E2E6ioELIU4BrpXZa/n9l783neebSlQhKTNgvh5JkpK+Iq2OG/p
   Gof5AljqeC/UL4w7MI0WfFlsAM3KhIwyatGo0M+e39Oz0cw4Pcb+TFqU8
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10254"; a="249419500"
X-IronPort-AV: E=Sophos;i="5.88,359,1635231600"; 
   d="scan'208";a="249419500"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2022 22:03:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,359,1635231600"; 
   d="scan'208";a="679414671"
Received: from lkp-server01.sh.intel.com (HELO d95dc2dabeb1) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 10 Feb 2022 22:03:31 -0800
Received: from kbuild by d95dc2dabeb1 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nIP1n-0004C1-1G; Fri, 11 Feb 2022 06:03:31 +0000
Date:   Fri, 11 Feb 2022 14:02:56 +0800
From:   kernel test robot <lkp@intel.com>
To:     David Howells <dhowells@redhat.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org
Subject: [ammarfaizi2-block:dhowells/linux-fs/netfs-maple 29/35]
 fs/netfs/write_helper.c:28:26: warning: comparison of distinct pointer types
 ('typeof (((1UL) << 12) - offset) *' (aka 'unsigned long *') and 'typeof
 (size) *' (aka 'unsigned int *'))
Message-ID: <202202111324.LBsc3lm4-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ammarfaizi2/linux-block dhowells/linux-fs/netfs-maple
head:   429e2bb6fb190f390ed23afc0d2308e877c43be5
commit: 01abe2ebb0b5676c9d0394947cfeea45d0f5c09f [29/35] netfs: Implement buffered writes through netfs_file_write_iter()
config: i386-randconfig-a015 (https://download.01.org/0day-ci/archive/20220211/202202111324.LBsc3lm4-lkp@intel.com/config)
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
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash fs/netfs/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> fs/netfs/write_helper.c:28:26: warning: comparison of distinct pointer types ('typeof (((1UL) << 12) - offset) *' (aka 'unsigned long *') and 'typeof (size) *' (aka 'unsigned int *')) [-Wcompare-distinct-pointer-types]
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
