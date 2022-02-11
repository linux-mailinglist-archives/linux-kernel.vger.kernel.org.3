Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D556E4B1E9E
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 07:36:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344721AbiBKGgj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 01:36:39 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:36644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344480AbiBKGge (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 01:36:34 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37A5B25CC
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 22:36:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644561394; x=1676097394;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=sY9dWku6RRycjskqEGh+8C+Ky9T2kiuDL3HbLAFOjq0=;
  b=Pr5OyUTp7uSN2N0FUlXsvGNjBXNs1TwfTh3RZsTOhAWTXKkRZRwRw8Va
   tIRWutDU/qPJVOVK1fAwHGMdkckQyon8OIoFL8ECnQtfeBQfJOZWimVjN
   G3IAXSVI6AEHpEDn5ocExp2xCew8WBqpbUHxpBOnPV0f+eDYL0JUPUjfK
   1gMaNdSTKr1r8Ie37n9rdY6DXKJEOW9Z2KKV9L53oVt7Byqk3LGTKn56P
   vJ+AC7N8NdmjGXFno7WIX9Tf9+J7UT/aQys2VBaGrG/rg46B0tRA1NKNf
   zbEWA3zXmKH0477sjueVKNQO2Nh2rvAgNkqV8lQ42n6khAZM0NAdVtw2j
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10254"; a="336094563"
X-IronPort-AV: E=Sophos;i="5.88,359,1635231600"; 
   d="scan'208";a="336094563"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2022 22:36:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,359,1635231600"; 
   d="scan'208";a="586237925"
Received: from lkp-server01.sh.intel.com (HELO d95dc2dabeb1) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 10 Feb 2022 22:36:32 -0800
Received: from kbuild by d95dc2dabeb1 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nIPXk-0004En-5J; Fri, 11 Feb 2022 06:36:32 +0000
Date:   Fri, 11 Feb 2022 14:35:30 +0800
From:   kernel test robot <lkp@intel.com>
To:     David Howells <dhowells@redhat.com>
Cc:     kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org
Subject: [ammarfaizi2-block:dhowells/linux-fs/netfs-maple 29/35]
 fs/netfs/write_helper.c:28:40: sparse: sparse: incompatible types in
 comparison expression (different type sizes):
Message-ID: <202202111406.PpKHKjMT-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ammarfaizi2/linux-block dhowells/linux-fs/netfs-maple
head:   429e2bb6fb190f390ed23afc0d2308e877c43be5
commit: 01abe2ebb0b5676c9d0394947cfeea45d0f5c09f [29/35] netfs: Implement buffered writes through netfs_file_write_iter()
config: xtensa-randconfig-s031-20220211 (https://download.01.org/0day-ci/archive/20220211/202202111406.PpKHKjMT-lkp@intel.com/config)
compiler: xtensa-linux-gcc (GCC) 11.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://github.com/ammarfaizi2/linux-block/commit/01abe2ebb0b5676c9d0394947cfeea45d0f5c09f
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block dhowells/linux-fs/netfs-maple
        git checkout 01abe2ebb0b5676c9d0394947cfeea45d0f5c09f
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=xtensa SHELL=/bin/bash fs/netfs/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
   fs/netfs/write_helper.c: note: in included file (through arch/xtensa/include/asm/bitops.h, include/linux/bitops.h, include/linux/log2.h, ...):
   arch/xtensa/include/asm/processor.h:107:2: sparse: sparse: Unsupported xtensa ABI
   arch/xtensa/include/asm/processor.h:137:2: sparse: sparse: Unsupported Xtensa ABI
>> fs/netfs/write_helper.c:28:40: sparse: sparse: incompatible types in comparison expression (different type sizes):
>> fs/netfs/write_helper.c:28:40: sparse:    unsigned long *
>> fs/netfs/write_helper.c:28:40: sparse:    unsigned int *
>> fs/netfs/write_helper.c:126:25: sparse: sparse: incompatible types in comparison expression (different signedness):
>> fs/netfs/write_helper.c:126:25: sparse:    unsigned long long *
>> fs/netfs/write_helper.c:126:25: sparse:    long long *
   fs/netfs/write_helper.c:127:25: sparse: sparse: incompatible types in comparison expression (different signedness):
   fs/netfs/write_helper.c:127:25: sparse:    unsigned long long *
   fs/netfs/write_helper.c:127:25: sparse:    long long *

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
   127		target->to    = max(target->to,   folio_pos(folio) + offset + len);
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
