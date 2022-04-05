Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39C444F4ED6
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 03:54:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1836051AbiDFAem (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 20:34:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380527AbiDELml (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 07:42:41 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C64D110CF36
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 04:07:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649156828; x=1680692828;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=3S+PBrgR8OHideRbXJqAx4mt56NEYAVf+7QjssQLc6g=;
  b=LJUNKfcZf9ltqgnEL22xyySsEOCeLA4BAtcfKb4RKlCI4ws6axt0hGu2
   OpiGLxz08jns2Xb3yyrPSkavK7EyD0jUnl1xgF18/HlCOax8+rF0MmQ9P
   4Sk7EcO1V14B6gD3MW7kd3Zsln+dKCn2ca4oyK6txHh+KssKjGb2o7a4u
   XImS2AsNEqxsEKdhB1zYaym3rU2UCTlbwIjF3YKnbeqc85spGvg3LCpmf
   SbDvfEqu+gYqTb/vmNGzMQxotOoZ+Nc2lkSooOwnfn7Ff6yB+nt4ClK96
   RXN6JZEVDH30MZVlYqK+BpeARvc6ytFK0ZSDSOwDV5TFhAWB+id4buYjW
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10307"; a="259553567"
X-IronPort-AV: E=Sophos;i="5.90,236,1643702400"; 
   d="scan'208";a="259553567"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2022 04:07:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,236,1643702400"; 
   d="scan'208";a="657895181"
Received: from lkp-server02.sh.intel.com (HELO a44fdfb70b94) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 05 Apr 2022 04:07:05 -0700
Received: from kbuild by a44fdfb70b94 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nbh1c-00036Z-RE;
        Tue, 05 Apr 2022 11:07:04 +0000
Date:   Tue, 5 Apr 2022 19:06:56 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Liam R. Howlett" <Liam.Howlett@Oracle.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org, David Howells <dhowells@redhat.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [ammarfaizi2-block:dhowells/linux-fs/netfs-maple 19/40]
 lib/maple_tree.c:3863:19: warning: stack frame size (1040) exceeds limit
 (1024) in 'mas_wr_spanning_store'
Message-ID: <202204051823.Dzc2jr6L-lkp@intel.com>
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
head:   674eea41fc70a740ff83ec590f9833f805852464
commit: 51b63e667ad83864c161cf2b8ef462e907536070 [19/40] Maple Tree: Add new data structure
config: arm-lpc32xx_defconfig (https://download.01.org/0day-ci/archive/20220405/202204051823.Dzc2jr6L-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project c4a1b07d0979e7ff20d7d541af666d822d66b566)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm cross compiling tool for clang build
        # apt-get install binutils-arm-linux-gnueabi
        # https://github.com/ammarfaizi2/linux-block/commit/51b63e667ad83864c161cf2b8ef462e907536070
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block dhowells/linux-fs/netfs-maple
        git checkout 51b63e667ad83864c161cf2b8ef462e907536070
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   lib/maple_tree.c:758:2: warning: unannotated fall-through between switch labels [-Wimplicit-fallthrough]
           case maple_dense:
           ^
   lib/maple_tree.c:758:2: note: insert 'break;' to avoid fall-through
           case maple_dense:
           ^
           break; 
   lib/maple_tree.c:5556:6: warning: no previous prototype for function 'mas_wr_store_setup' [-Wmissing-prototypes]
   void mas_wr_store_setup(struct ma_wr_state *wr_mas)
        ^
   lib/maple_tree.c:5556:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void mas_wr_store_setup(struct ma_wr_state *wr_mas)
   ^
   static 
   lib/maple_tree.c:6184:5: warning: no previous prototype for function 'mtree_alloc_range' [-Wmissing-prototypes]
   int mtree_alloc_range(struct maple_tree *mt, unsigned long *startp,
       ^
   lib/maple_tree.c:6184:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   int mtree_alloc_range(struct maple_tree *mt, unsigned long *startp,
   ^
   static 
   lib/maple_tree.c:6219:5: warning: no previous prototype for function 'mtree_alloc_rrange' [-Wmissing-prototypes]
   int mtree_alloc_rrange(struct maple_tree *mt, unsigned long *startp,
       ^
   lib/maple_tree.c:6219:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   int mtree_alloc_rrange(struct maple_tree *mt, unsigned long *startp,
   ^
   static 
   lib/maple_tree.c:76:28: warning: unused variable 'mt_max' [-Wunused-const-variable]
   static const unsigned long mt_max[] = {
                              ^
   lib/maple_tree.c:317:20: warning: unused function 'mte_set_full' [-Wunused-function]
   static inline void mte_set_full(const struct maple_enode *node)
                      ^
   lib/maple_tree.c:322:20: warning: unused function 'mte_clear_full' [-Wunused-function]
   static inline void mte_clear_full(const struct maple_enode *node)
                      ^
   lib/maple_tree.c:832:35: warning: unused function 'mas_get_slot' [-Wunused-function]
   static inline struct maple_enode *mas_get_slot(struct ma_state *mas,
                                     ^
   lib/maple_tree.c:4608:19: warning: unused function 'mas_dead_node' [-Wunused-function]
   static inline int mas_dead_node(struct ma_state *mas, unsigned long index)
                     ^
   lib/maple_tree.c:4630:21: warning: unused function 'mas_first_entry' [-Wunused-function]
   static inline void *mas_first_entry(struct ma_state *mas, struct maple_node *mn,
                       ^
>> lib/maple_tree.c:3863:19: warning: stack frame size (1040) exceeds limit (1024) in 'mas_wr_spanning_store' [-Wframe-larger-than]
   static inline int mas_wr_spanning_store(struct ma_wr_state *wr_mas)
                     ^
   lib/maple_tree.c:4203:20: warning: stack frame size (1288) exceeds limit (1024) in 'mas_wr_modify' [-Wframe-larger-than]
   static inline void mas_wr_modify(struct ma_wr_state *wr_mas)
                      ^
   12 warnings generated.


vim +/mas_wr_spanning_store +3863 lib/maple_tree.c

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
> 3863	static inline int mas_wr_spanning_store(struct ma_wr_state *wr_mas)
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
  3941	}
  3942	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
