Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAB284F228A
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Apr 2022 07:20:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229756AbiDEFWC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 01:22:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229659AbiDEFVq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 01:21:46 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BBDF2A8
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 22:19:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649135989; x=1680671989;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=GVI41wFRb1AFiNX5D4ViSYSdC1h59SRlnSn+t2neJys=;
  b=C6NgyzorhFD5tH9IY66r2iU5cr3iWK4lggwkCxP3nz65cKeZNvJRu9Fh
   KUcn0Hv3dlVYSujmE9HbENpoTYp0IVzUjKEiOuWyhxWvX3GA0Y7gdf5hN
   SaMk8/eZwzSR199FDNyA35mouN2QQNFMR63pgML0FQ1frMHpZfSWS5SO8
   IhYUefi/hMbptNJst1mJoZlGCDRlPKp+x7aVjvoA8Jlz/AE1ncbH6zbp1
   ME8HKp3J6N63ZO8WEBalMA6EVKi1A2fLAvdmsz2PSV0KyRGeSApxVEU3L
   BhIzi+i8PJwngnh3Cd9vySox92ZOxFfdgpPvk80EjzMwBC8sUXdJzX5HE
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10307"; a="260363836"
X-IronPort-AV: E=Sophos;i="5.90,235,1643702400"; 
   d="scan'208";a="260363836"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2022 22:19:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,235,1643702400"; 
   d="scan'208";a="523852346"
Received: from lkp-server02.sh.intel.com (HELO a44fdfb70b94) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 04 Apr 2022 22:19:46 -0700
Received: from kbuild by a44fdfb70b94 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nbbbV-0002fm-BN;
        Tue, 05 Apr 2022 05:19:45 +0000
Date:   Tue, 5 Apr 2022 13:19:40 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Liam R. Howlett" <Liam.Howlett@Oracle.com>
Cc:     kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org, David Howells <dhowells@redhat.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [ammarfaizi2-block:dhowells/linux-fs/netfs-maple 19/40]
 lib/maple_tree.c:3941:1: warning: the frame size of 1040 bytes is larger
 than 1024 bytes
Message-ID: <202204051345.4c9QlJeF-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ammarfaizi2/linux-block dhowells/linux-fs/netfs-maple
head:   674eea41fc70a740ff83ec590f9833f805852464
commit: 51b63e667ad83864c161cf2b8ef462e907536070 [19/40] Maple Tree: Add new data structure
config: h8300-randconfig-c003-20220405 (https://download.01.org/0day-ci/archive/20220405/202204051345.4c9QlJeF-lkp@intel.com/config)
compiler: h8300-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/ammarfaizi2/linux-block/commit/51b63e667ad83864c161cf2b8ef462e907536070
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block dhowells/linux-fs/netfs-maple
        git checkout 51b63e667ad83864c161cf2b8ef462e907536070
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=h8300 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   lib/maple_tree.c:5556:6: warning: no previous prototype for 'mas_wr_store_setup' [-Wmissing-prototypes]
    5556 | void mas_wr_store_setup(struct ma_wr_state *wr_mas)
         |      ^~~~~~~~~~~~~~~~~~
   lib/maple_tree.c:6184:5: warning: no previous prototype for 'mtree_alloc_range' [-Wmissing-prototypes]
    6184 | int mtree_alloc_range(struct maple_tree *mt, unsigned long *startp,
         |     ^~~~~~~~~~~~~~~~~
   lib/maple_tree.c:6219:5: warning: no previous prototype for 'mtree_alloc_rrange' [-Wmissing-prototypes]
    6219 | int mtree_alloc_rrange(struct maple_tree *mt, unsigned long *startp,
         |     ^~~~~~~~~~~~~~~~~~
   lib/maple_tree.c:6526:6: warning: no previous prototype for 'mt_dump_range' [-Wmissing-prototypes]
    6526 | void mt_dump_range(unsigned long min, unsigned long max, unsigned int depth)
         |      ^~~~~~~~~~~~~
   lib/maple_tree.c:6536:6: warning: no previous prototype for 'mt_dump_entry' [-Wmissing-prototypes]
    6536 | void mt_dump_entry(void *entry, unsigned long min, unsigned long max,
         |      ^~~~~~~~~~~~~
   lib/maple_tree.c:6552:6: warning: no previous prototype for 'mt_dump_range64' [-Wmissing-prototypes]
    6552 | void mt_dump_range64(const struct maple_tree *mt, void *entry,
         |      ^~~~~~~~~~~~~~~
   lib/maple_tree.c:6591:6: warning: no previous prototype for 'mt_dump_arange64' [-Wmissing-prototypes]
    6591 | void mt_dump_arange64(const struct maple_tree *mt, void *entry,
         |      ^~~~~~~~~~~~~~~~
   lib/maple_tree.c:6683:6: warning: no previous prototype for 'mas_validate_gaps' [-Wmissing-prototypes]
    6683 | void mas_validate_gaps(struct ma_state *mas)
         |      ^~~~~~~~~~~~~~~~~
   lib/maple_tree.c:6770:6: warning: no previous prototype for 'mas_validate_parent_slot' [-Wmissing-prototypes]
    6770 | void mas_validate_parent_slot(struct ma_state *mas)
         |      ^~~~~~~~~~~~~~~~~~~~~~~~
   lib/maple_tree.c:6803:6: warning: no previous prototype for 'mas_validate_child_slot' [-Wmissing-prototypes]
    6803 | void mas_validate_child_slot(struct ma_state *mas)
         |      ^~~~~~~~~~~~~~~~~~~~~~~
   lib/maple_tree.c:6841:6: warning: no previous prototype for 'mas_validate_limits' [-Wmissing-prototypes]
    6841 | void mas_validate_limits(struct ma_state *mas)
         |      ^~~~~~~~~~~~~~~~~~~
   lib/maple_tree.c:6891:6: warning: no previous prototype for 'mt_validate_nulls' [-Wmissing-prototypes]
    6891 | void mt_validate_nulls(struct maple_tree *mt)
         |      ^~~~~~~~~~~~~~~~~
   lib/maple_tree.c:6932:6: warning: no previous prototype for 'mt_validate' [-Wmissing-prototypes]
    6932 | void mt_validate(struct maple_tree *mt)
         |      ^~~~~~~~~~~
   lib/maple_tree.c: In function 'mas_wr_spanning_store.isra':
>> lib/maple_tree.c:3941:1: warning: the frame size of 1040 bytes is larger than 1024 bytes [-Wframe-larger-than=]
    3941 | }
         | ^


vim +3941 lib/maple_tree.c

  3805	
  3806	/*
  3807	 * mas_new_root() - Create a new root node that only contains the entry passed
  3808	 * in.
  3809	 * @mas: The maple state
  3810	 * @entry: The entry to store.
  3811	 *
  3812	 * Only valid when the index == 0 and the last == ULONG_MAX
  3813	 *
  3814	 * Return 0 on error, 1 on success.
  3815	 */
  3816	static inline int mas_new_root(struct ma_state *mas, void *entry)
  3817	{
  3818		struct maple_enode *root = mas_root_locked(mas);
  3819		enum maple_type type = maple_leaf_64;
  3820		struct maple_node *node;
  3821		void __rcu **slots;
  3822		unsigned long *pivots;
  3823	
  3824		if (!entry && !mas->index && mas->last == ULONG_MAX) {
  3825			mas->depth = 0;
  3826			mas_set_height(mas);
  3827			rcu_assign_pointer(mas->tree->ma_root, entry);
  3828			mas->node = MAS_START;
  3829			goto done;
  3830		}
  3831	
  3832		mas_node_count(mas, 1);
  3833		if (mas_is_err(mas))
  3834			return 0;
  3835	
  3836		node = mas_pop_node(mas);
  3837		pivots = ma_pivots(node, type);
  3838		slots = ma_slots(node, type);
  3839		node->parent = ma_parent_ptr(
  3840			      ((unsigned long)mas->tree | MA_ROOT_PARENT));
  3841		mas->node = mt_mk_node(node, type);
  3842		rcu_assign_pointer(slots[0], entry);
  3843		pivots[0] = mas->last;
  3844		mas->depth = 1;
  3845		mas_set_height(mas);
  3846		rcu_assign_pointer(mas->tree->ma_root, mte_mk_root(mas->node));
  3847	
  3848	done:
  3849		if (xa_is_node(root))
  3850			mte_destroy_walk(root, mas->tree);
  3851	
  3852		return 1;
  3853	}
  3854	/*
  3855	 * mas_spanning_store() - Create a subtree with the store operation completed
  3856	 * and new nodes where necessary, then place the sub-tree in the actual tree.
  3857	 * Note that mas is expected to point to the node which caused the store to
  3858	 * span.
  3859	 * @wr_mas: The maple write state
  3860	 *
  3861	 * Return: 0 on error, positive on success.
  3862	 */
  3863	static inline int mas_wr_spanning_store(struct ma_wr_state *wr_mas)
  3864	{
  3865		struct maple_subtree_state mast;
  3866		struct maple_big_node b_node;
  3867		struct ma_state *mas;
  3868		unsigned char height;
  3869	
  3870		/* Left and Right side of spanning store */
  3871		MA_STATE(l_mas, NULL, 0, 0);
  3872		MA_STATE(r_mas, NULL, 0, 0);
  3873	
  3874		MA_WR_STATE(r_wr_mas, &r_mas, wr_mas->entry);
  3875		MA_WR_STATE(l_wr_mas, &l_mas, wr_mas->entry);
  3876	
  3877		/*
  3878		 * A store operation that spans multiple nodes is called a spanning
  3879		 * store and is handled early in the store call stack by the function
  3880		 * mas_is_span_wr().  When a spanning store is identified, the maple
  3881		 * state is duplicated.  The first maple state walks the left tree path
  3882		 * to ``index``, the duplicate walks the right tree path to ``last``.
  3883		 * The data in the two nodes are combined into a single node, two nodes,
  3884		 * or possibly three nodes (see the 3-way split above).  A ``NULL``
  3885		 * written to the last entry of a node is considered a spanning store as
  3886		 * a rebalance is required for the operation to complete and an overflow
  3887		 * of data may happen.
  3888		 */
  3889		mas = wr_mas->mas;
  3890		trace_ma_op(__func__, mas);
  3891	
  3892		if (unlikely(!mas->index && mas->last == ULONG_MAX))
  3893			return mas_new_root(mas, wr_mas->entry);
  3894		/*
  3895		 * Node rebalancing may occur due to this store, so there may be two new
  3896		 * entries per level plus a new root.
  3897		 */
  3898		height = mas_mt_height(mas);
  3899		mas_node_count(mas, 1 + height * 3);
  3900		if (mas_is_err(mas))
  3901			return 0;
  3902	
  3903		/*
  3904		 * Set up right side.  Need to get to the next offset after the spanning
  3905		 * store to ensure it's not NULL and to combine both the next node and
  3906		 * the node with the start together.
  3907		 */
  3908		r_mas = *mas;
  3909		/* Avoid overflow, walk to next slot in the tree. */
  3910		if (r_mas.last + 1)
  3911			r_mas.last++;
  3912	
  3913		r_mas.index = r_mas.last;
  3914		mas_wr_walk_index(&r_wr_mas);
  3915		r_mas.last = r_mas.index = mas->last;
  3916	
  3917		/* Set up left side. */
  3918		l_mas = *mas;
  3919		mas_wr_walk_index(&l_wr_mas);
  3920	
  3921		if (!wr_mas->entry) {
  3922			mas_extend_spanning_null(&l_wr_mas, &r_wr_mas);
  3923			mas->offset = l_mas.offset;
  3924			mas->index = l_mas.index;
  3925			mas->last = l_mas.last = r_mas.last;
  3926		}
  3927	
  3928		/* Copy l_mas and store the value in b_node. */
  3929		b_node.b_end = mas_store_b_node(&l_wr_mas, &b_node, l_wr_mas.node_end);
  3930		/* Copy r_mas into b_node. */
  3931		mas_mab_cp(&r_mas, r_mas.offset, r_wr_mas.node_end,
  3932			   &b_node, b_node.b_end + 1);
  3933		/* Stop spanning searches by searching for just index. */
  3934		l_mas.index = l_mas.last = mas->index;
  3935	
  3936		mast.bn = &b_node;
  3937		mast.orig_l = &l_mas;
  3938		mast.orig_r = &r_mas;
  3939		/* Combine l_mas and r_mas and split them up evenly again. */
  3940		return mas_spanning_rebalance(mas, &mast, height + 1);
> 3941	}
  3942	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
