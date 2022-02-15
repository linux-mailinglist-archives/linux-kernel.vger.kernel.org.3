Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 417DE4B77A4
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 21:51:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242629AbiBOUFX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 15:05:23 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:53454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239220AbiBOUFT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 15:05:19 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45EAC7EB31;
        Tue, 15 Feb 2022 12:05:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644955508; x=1676491508;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=KhrUE6oST5D1XAj1J9NXmf6cxsxaGXbFCMzbBICRqZ4=;
  b=hngLm6iKtSLxVAKIEsrqvemIGU3qDhPOD71g7a5EOBcqfeSXbaV9U9R4
   ZBOXsNZ6DTcSz2mFBFuZrbS26w+/me2rIPtSxrvTKxJ+Utw5kvHx1JW0z
   JL9Ri2+RhIORiEnWyURPCGklkj1fc6pDmzB1anD5Io6zBZvkpUNEvSEXl
   wpPZ9/cLAvE9eAJ0H/GToSLmDHTgG8mIHyZMEm/+i6cU84wqBYFFPFHnL
   ThasBOfcmIAuyNt6nTMar0CiiMU/WLgw7I9tlUv1n0EfSXTi5PXhstwcu
   wMboF8DXFN7XN2ve8Ob4t3j/ndi6QOWSXy4R00t8/pZ4Fv3bcAIPHsObc
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10259"; a="230405425"
X-IronPort-AV: E=Sophos;i="5.88,371,1635231600"; 
   d="scan'208";a="230405425"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2022 12:05:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,371,1635231600"; 
   d="scan'208";a="636103638"
Received: from lkp-server01.sh.intel.com (HELO d95dc2dabeb1) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 15 Feb 2022 12:05:04 -0800
Received: from kbuild by d95dc2dabeb1 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nK44N-0009zQ-UQ; Tue, 15 Feb 2022 20:05:03 +0000
Date:   Wed, 16 Feb 2022 04:05:01 +0800
From:   kernel test robot <lkp@intel.com>
To:     Qu Wenruo <wqu@suse.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, David Sterba <dsterba@suse.com>,
        linux-doc@vger.kernel.org
Subject: [kdave-btrfs-devel:misc-next 68/68] fs/btrfs/ioctl.c:1192: warning:
 This comment starts with '/**', but isn't a kernel-doc comment. Refer
 Documentation/doc-guide/kernel-doc.rst
Message-ID: <202202160409.lvaZWYmg-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/kdave/btrfs-devel.git misc-next
head:   e6c69fcbee7ef1d7bde4ff78eb1377dbe09d71cf
commit: e6c69fcbee7ef1d7bde4ff78eb1377dbe09d71cf [68/68] btrfs: defrag: use control structure in btrfs_defrag_file()
config: arm64-randconfig-r036-20220214 (https://download.01.org/0day-ci/archive/20220216/202202160409.lvaZWYmg-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 37f422f4ac31c8b8041c6b62065263314282dab6)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm64 cross compiling tool for clang build
        # apt-get install binutils-aarch64-linux-gnu
        # https://github.com/kdave/btrfs-devel/commit/e6c69fcbee7ef1d7bde4ff78eb1377dbe09d71cf
        git remote add kdave-btrfs-devel https://github.com/kdave/btrfs-devel.git
        git fetch --no-tags kdave-btrfs-devel misc-next
        git checkout e6c69fcbee7ef1d7bde4ff78eb1377dbe09d71cf
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm64 SHELL=/bin/bash drivers/mfd/ fs/btrfs/ mm/kasan/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> fs/btrfs/ioctl.c:1192: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
    * Collect all valid target extents.
   fs/btrfs/ioctl.c:1598: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
    * Entry point to file defragmentation.


vim +1192 fs/btrfs/ioctl.c

4cb5300bc839b8a Chris Mason   2011-05-24  1190  
e6c69fcbee7ef1d Qu Wenruo     2022-02-11  1191  /**
eb793cf857828db Qu Wenruo     2021-08-06 @1192   * Collect all valid target extents.
eb793cf857828db Qu Wenruo     2021-08-06  1193   *
e6c69fcbee7ef1d Qu Wenruo     2022-02-11  1194   * @inode:         inode to defragment
e6c69fcbee7ef1d Qu Wenruo     2022-02-11  1195   * @ctrl:	   extra defrag policy control
eb793cf857828db Qu Wenruo     2021-08-06  1196   * @start:	   file offset to lookup
eb793cf857828db Qu Wenruo     2021-08-06  1197   * @len:	   length to lookup
e9eec72151e215c Qu Wenruo     2021-08-06  1198   * @locked:	   if the range has already held extent lock
eb793cf857828db Qu Wenruo     2021-08-06  1199   * @target_list:   list of targets file extents
e6c69fcbee7ef1d Qu Wenruo     2022-02-11  1200   *
e6c69fcbee7ef1d Qu Wenruo     2022-02-11  1201   * Will update ctrl::last_scanned.
4cb5300bc839b8a Chris Mason   2011-05-24  1202   */
eb793cf857828db Qu Wenruo     2021-08-06  1203  static int defrag_collect_targets(struct btrfs_inode *inode,
e6c69fcbee7ef1d Qu Wenruo     2022-02-11  1204  				  struct btrfs_defrag_ctrl *ctrl,
e6c69fcbee7ef1d Qu Wenruo     2022-02-11  1205  				  u64 start, u32 len,
e6c69fcbee7ef1d Qu Wenruo     2022-02-11  1206  				  bool locked, struct list_head *target_list)
eb793cf857828db Qu Wenruo     2021-08-06  1207  {
e6c69fcbee7ef1d Qu Wenruo     2022-02-11  1208  	bool do_compress = (ctrl->flags & BTRFS_DEFRAG_RANGE_COMPRESS);
c0a67d1ead1393b Qu Wenruo     2022-02-11  1209  	bool last_is_target = false;
eb793cf857828db Qu Wenruo     2021-08-06  1210  	u64 cur = start;
eb793cf857828db Qu Wenruo     2021-08-06  1211  	int ret = 0;
4cb5300bc839b8a Chris Mason   2011-05-24  1212  
eb793cf857828db Qu Wenruo     2021-08-06  1213  	while (cur < start + len) {
eb793cf857828db Qu Wenruo     2021-08-06  1214  		struct extent_map *em;
eb793cf857828db Qu Wenruo     2021-08-06  1215  		struct defrag_target_range *new;
eb793cf857828db Qu Wenruo     2021-08-06  1216  		bool next_mergeable = true;
eb793cf857828db Qu Wenruo     2021-08-06  1217  		u64 range_len;
eb793cf857828db Qu Wenruo     2021-08-06  1218  
c0a67d1ead1393b Qu Wenruo     2022-02-11  1219  		last_is_target = false;
e9eec72151e215c Qu Wenruo     2021-08-06  1220  		em = defrag_lookup_extent(&inode->vfs_inode, cur, locked);
eb793cf857828db Qu Wenruo     2021-08-06  1221  		if (!em)
eb793cf857828db Qu Wenruo     2021-08-06  1222  			break;
eb793cf857828db Qu Wenruo     2021-08-06  1223  
eb793cf857828db Qu Wenruo     2021-08-06  1224  		/* Skip hole/inline/preallocated extents */
eb793cf857828db Qu Wenruo     2021-08-06  1225  		if (em->block_start >= EXTENT_MAP_LAST_BYTE ||
eb793cf857828db Qu Wenruo     2021-08-06  1226  		    test_bit(EXTENT_FLAG_PREALLOC, &em->flags))
eb793cf857828db Qu Wenruo     2021-08-06  1227  			goto next;
4cb5300bc839b8a Chris Mason   2011-05-24  1228  
eb793cf857828db Qu Wenruo     2021-08-06  1229  		/* Skip older extent */
e6c69fcbee7ef1d Qu Wenruo     2022-02-11  1230  		if (em->generation < ctrl->newer_than)
eb793cf857828db Qu Wenruo     2021-08-06  1231  			goto next;
7f458a3873ae94e Filipe Manana 2020-11-04  1232  
79c19b4d71f61a3 Qu Wenruo     2022-02-08  1233  		/* This em is under writeback, no need to defrag */
79c19b4d71f61a3 Qu Wenruo     2022-02-08  1234  		if (em->generation == (u64)-1)
79c19b4d71f61a3 Qu Wenruo     2022-02-08  1235  			goto next;
79c19b4d71f61a3 Qu Wenruo     2022-02-08  1236  
0cb5950f3f3b51a Filipe Manana 2022-01-20  1237  		/*
0cb5950f3f3b51a Filipe Manana 2022-01-20  1238  		 * Our start offset might be in the middle of an existing extent
0cb5950f3f3b51a Filipe Manana 2022-01-20  1239  		 * map, so take that into account.
0cb5950f3f3b51a Filipe Manana 2022-01-20  1240  		 */
0cb5950f3f3b51a Filipe Manana 2022-01-20  1241  		range_len = em->len - (cur - em->start);
0cb5950f3f3b51a Filipe Manana 2022-01-20  1242  		/*
0cb5950f3f3b51a Filipe Manana 2022-01-20  1243  		 * If this range of the extent map is already flagged for delalloc,
0cb5950f3f3b51a Filipe Manana 2022-01-20  1244  		 * skip it, because:
0cb5950f3f3b51a Filipe Manana 2022-01-20  1245  		 *
0cb5950f3f3b51a Filipe Manana 2022-01-20  1246  		 * 1) We could deadlock later, when trying to reserve space for
0cb5950f3f3b51a Filipe Manana 2022-01-20  1247  		 *    delalloc, because in case we can't immediately reserve space
0cb5950f3f3b51a Filipe Manana 2022-01-20  1248  		 *    the flusher can start delalloc and wait for the respective
0cb5950f3f3b51a Filipe Manana 2022-01-20  1249  		 *    ordered extents to complete. The deadlock would happen
0cb5950f3f3b51a Filipe Manana 2022-01-20  1250  		 *    because we do the space reservation while holding the range
0cb5950f3f3b51a Filipe Manana 2022-01-20  1251  		 *    locked, and starting writeback, or finishing an ordered
0cb5950f3f3b51a Filipe Manana 2022-01-20  1252  		 *    extent, requires locking the range;
0cb5950f3f3b51a Filipe Manana 2022-01-20  1253  		 *
0cb5950f3f3b51a Filipe Manana 2022-01-20  1254  		 * 2) If there's delalloc there, it means there's dirty pages for
0cb5950f3f3b51a Filipe Manana 2022-01-20  1255  		 *    which writeback has not started yet (we clean the delalloc
0cb5950f3f3b51a Filipe Manana 2022-01-20  1256  		 *    flag when starting writeback and after creating an ordered
0cb5950f3f3b51a Filipe Manana 2022-01-20  1257  		 *    extent). If we mark pages in an adjacent range for defrag,
0cb5950f3f3b51a Filipe Manana 2022-01-20  1258  		 *    then we will have a larger contiguous range for delalloc,
0cb5950f3f3b51a Filipe Manana 2022-01-20  1259  		 *    very likely resulting in a larger extent after writeback is
0cb5950f3f3b51a Filipe Manana 2022-01-20  1260  		 *    triggered (except in a case of free space fragmentation).
0cb5950f3f3b51a Filipe Manana 2022-01-20  1261  		 */
0cb5950f3f3b51a Filipe Manana 2022-01-20  1262  		if (test_range_bit(&inode->io_tree, cur, cur + range_len - 1,
0cb5950f3f3b51a Filipe Manana 2022-01-20  1263  				   EXTENT_DELALLOC, 0, NULL))
0cb5950f3f3b51a Filipe Manana 2022-01-20  1264  			goto next;
0cb5950f3f3b51a Filipe Manana 2022-01-20  1265  
7f458a3873ae94e Filipe Manana 2020-11-04  1266  		/*
eb793cf857828db Qu Wenruo     2021-08-06  1267  		 * For do_compress case, we want to compress all valid file
eb793cf857828db Qu Wenruo     2021-08-06  1268  		 * extents, thus no @extent_thresh or mergeable check.
7f458a3873ae94e Filipe Manana 2020-11-04  1269  		 */
eb793cf857828db Qu Wenruo     2021-08-06  1270  		if (do_compress)
eb793cf857828db Qu Wenruo     2021-08-06  1271  			goto add;
eb793cf857828db Qu Wenruo     2021-08-06  1272  
eb793cf857828db Qu Wenruo     2021-08-06  1273  		/* Skip too large extent */
e6c69fcbee7ef1d Qu Wenruo     2022-02-11  1274  		if (range_len >= ctrl->extent_thresh)
eb793cf857828db Qu Wenruo     2021-08-06  1275  			goto next;
eb793cf857828db Qu Wenruo     2021-08-06  1276  
c55eaee8366f0b9 Qu Wenruo     2022-01-28  1277  		/*
c55eaee8366f0b9 Qu Wenruo     2022-01-28  1278  		 * Skip extents already at its max capacity, this is mostly for
c55eaee8366f0b9 Qu Wenruo     2022-01-28  1279  		 * compressed extents, which max cap is only 128K.
c55eaee8366f0b9 Qu Wenruo     2022-01-28  1280  		 */
c55eaee8366f0b9 Qu Wenruo     2022-01-28  1281  		if (em->len >= get_extent_max_capacity(em))
c55eaee8366f0b9 Qu Wenruo     2022-01-28  1282  			goto next;
c55eaee8366f0b9 Qu Wenruo     2022-01-28  1283  
e9eec72151e215c Qu Wenruo     2021-08-06  1284  		next_mergeable = defrag_check_next_extent(&inode->vfs_inode, em,
e9eec72151e215c Qu Wenruo     2021-08-06  1285  							  locked);
eb793cf857828db Qu Wenruo     2021-08-06  1286  		if (!next_mergeable) {
eb793cf857828db Qu Wenruo     2021-08-06  1287  			struct defrag_target_range *last;
eb793cf857828db Qu Wenruo     2021-08-06  1288  
eb793cf857828db Qu Wenruo     2021-08-06  1289  			/* Empty target list, no way to merge with last entry */
eb793cf857828db Qu Wenruo     2021-08-06  1290  			if (list_empty(target_list))
eb793cf857828db Qu Wenruo     2021-08-06  1291  				goto next;
eb793cf857828db Qu Wenruo     2021-08-06  1292  			last = list_entry(target_list->prev,
eb793cf857828db Qu Wenruo     2021-08-06  1293  					  struct defrag_target_range, list);
eb793cf857828db Qu Wenruo     2021-08-06  1294  			/* Not mergeable with last entry */
eb793cf857828db Qu Wenruo     2021-08-06  1295  			if (last->start + last->len != cur)
eb793cf857828db Qu Wenruo     2021-08-06  1296  				goto next;
7f458a3873ae94e Filipe Manana 2020-11-04  1297  
eb793cf857828db Qu Wenruo     2021-08-06  1298  			/* Mergeable, fall through to add it to @target_list. */
7f458a3873ae94e Filipe Manana 2020-11-04  1299  		}
eb793cf857828db Qu Wenruo     2021-08-06  1300  
eb793cf857828db Qu Wenruo     2021-08-06  1301  add:
c0a67d1ead1393b Qu Wenruo     2022-02-11  1302  		last_is_target = true;
eb793cf857828db Qu Wenruo     2021-08-06  1303  		range_len = min(extent_map_end(em), start + len) - cur;
eb793cf857828db Qu Wenruo     2021-08-06  1304  		/*
eb793cf857828db Qu Wenruo     2021-08-06  1305  		 * This one is a good target, check if it can be merged into
eb793cf857828db Qu Wenruo     2021-08-06  1306  		 * last range of the target list.
eb793cf857828db Qu Wenruo     2021-08-06  1307  		 */
eb793cf857828db Qu Wenruo     2021-08-06  1308  		if (!list_empty(target_list)) {
eb793cf857828db Qu Wenruo     2021-08-06  1309  			struct defrag_target_range *last;
eb793cf857828db Qu Wenruo     2021-08-06  1310  
eb793cf857828db Qu Wenruo     2021-08-06  1311  			last = list_entry(target_list->prev,
eb793cf857828db Qu Wenruo     2021-08-06  1312  					  struct defrag_target_range, list);
eb793cf857828db Qu Wenruo     2021-08-06  1313  			ASSERT(last->start + last->len <= cur);
eb793cf857828db Qu Wenruo     2021-08-06  1314  			if (last->start + last->len == cur) {
eb793cf857828db Qu Wenruo     2021-08-06  1315  				/* Mergeable, enlarge the last entry */
eb793cf857828db Qu Wenruo     2021-08-06  1316  				last->len += range_len;
eb793cf857828db Qu Wenruo     2021-08-06  1317  				goto next;
7f458a3873ae94e Filipe Manana 2020-11-04  1318  			}
eb793cf857828db Qu Wenruo     2021-08-06  1319  			/* Fall through to allocate a new entry */
eb793cf857828db Qu Wenruo     2021-08-06  1320  		}
eb793cf857828db Qu Wenruo     2021-08-06  1321  
eb793cf857828db Qu Wenruo     2021-08-06  1322  		/* Allocate new defrag_target_range */
eb793cf857828db Qu Wenruo     2021-08-06  1323  		new = kmalloc(sizeof(*new), GFP_NOFS);
eb793cf857828db Qu Wenruo     2021-08-06  1324  		if (!new) {
7f458a3873ae94e Filipe Manana 2020-11-04  1325  			free_extent_map(em);
eb793cf857828db Qu Wenruo     2021-08-06  1326  			ret = -ENOMEM;
eb793cf857828db Qu Wenruo     2021-08-06  1327  			break;
7f458a3873ae94e Filipe Manana 2020-11-04  1328  		}
eb793cf857828db Qu Wenruo     2021-08-06  1329  		new->start = cur;
eb793cf857828db Qu Wenruo     2021-08-06  1330  		new->len = range_len;
eb793cf857828db Qu Wenruo     2021-08-06  1331  		list_add_tail(&new->list, target_list);
7f458a3873ae94e Filipe Manana 2020-11-04  1332  
eb793cf857828db Qu Wenruo     2021-08-06  1333  next:
eb793cf857828db Qu Wenruo     2021-08-06  1334  		cur = extent_map_end(em);
eb793cf857828db Qu Wenruo     2021-08-06  1335  		free_extent_map(em);
eb793cf857828db Qu Wenruo     2021-08-06  1336  	}
eb793cf857828db Qu Wenruo     2021-08-06  1337  	if (ret < 0) {
eb793cf857828db Qu Wenruo     2021-08-06  1338  		struct defrag_target_range *entry;
eb793cf857828db Qu Wenruo     2021-08-06  1339  		struct defrag_target_range *tmp;
4cb5300bc839b8a Chris Mason   2011-05-24  1340  
eb793cf857828db Qu Wenruo     2021-08-06  1341  		list_for_each_entry_safe(entry, tmp, target_list, list) {
eb793cf857828db Qu Wenruo     2021-08-06  1342  			list_del_init(&entry->list);
eb793cf857828db Qu Wenruo     2021-08-06  1343  			kfree(entry);
eb793cf857828db Qu Wenruo     2021-08-06  1344  		}
eb793cf857828db Qu Wenruo     2021-08-06  1345  	}
e6c69fcbee7ef1d Qu Wenruo     2022-02-11  1346  	if (!ret) {
c0a67d1ead1393b Qu Wenruo     2022-02-11  1347  		/*
c0a67d1ead1393b Qu Wenruo     2022-02-11  1348  		 * If the last extent is not a target, the caller can skip to
c0a67d1ead1393b Qu Wenruo     2022-02-11  1349  		 * the end of that extent.
c0a67d1ead1393b Qu Wenruo     2022-02-11  1350  		 * Otherwise, we can only go the end of the specified range.
e6c69fcbee7ef1d Qu Wenruo     2022-02-11  1351  		 *
e6c69fcbee7ef1d Qu Wenruo     2022-02-11  1352  		 * And we may got a range smaller than current
e6c69fcbee7ef1d Qu Wenruo     2022-02-11  1353  		 * ctrl->last_scanned (e.g. executed in the defrag_one_range
e6c69fcbee7ef1d Qu Wenruo     2022-02-11  1354  		 * call), so we have to ensure we didn't decrease
e6c69fcbee7ef1d Qu Wenruo     2022-02-11  1355  		 * ctrl->last_scanned.
c0a67d1ead1393b Qu Wenruo     2022-02-11  1356  		 */
c0a67d1ead1393b Qu Wenruo     2022-02-11  1357  		if (!last_is_target)
e6c69fcbee7ef1d Qu Wenruo     2022-02-11  1358  			ctrl->last_scanned = max(cur, ctrl->last_scanned);
c0a67d1ead1393b Qu Wenruo     2022-02-11  1359  		else
e6c69fcbee7ef1d Qu Wenruo     2022-02-11  1360  			ctrl->last_scanned = max(start + len, ctrl->last_scanned);
c0a67d1ead1393b Qu Wenruo     2022-02-11  1361  	}
eb793cf857828db Qu Wenruo     2021-08-06  1362  	return ret;
4cb5300bc839b8a Chris Mason   2011-05-24  1363  }
4cb5300bc839b8a Chris Mason   2011-05-24  1364  

:::::: The code at line 1192 was first introduced by commit
:::::: eb793cf857828dbb1f21bfe405e5e493fdceae6c btrfs: defrag: introduce helper to collect target file extents

:::::: TO: Qu Wenruo <wqu@suse.com>
:::::: CC: David Sterba <dsterba@suse.com>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
