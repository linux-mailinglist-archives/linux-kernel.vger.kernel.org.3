Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34ECA50CD68
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Apr 2022 22:36:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237043AbiDWUi5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Apr 2022 16:38:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237030AbiDWUiu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Apr 2022 16:38:50 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA52849F2C
        for <linux-kernel@vger.kernel.org>; Sat, 23 Apr 2022 13:35:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650746151; x=1682282151;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=B/+Y8+22IvCHWVRp75Ce96j8rR1OCBhwyXaly9Rfpl0=;
  b=kKhl+qbI1RgzBAae9m3/BqJSt17qKHdF27trckJ2c/f3FnpaQIWMnxNt
   NpYgDKR+wf2TtDHeaDGVU2I5DkQ5PcO7lgOP/fi8dGntiCvuXSYzUxEjz
   Wpzzuy1MyzZ4+B3AgTbknAz5qAf4xerXr+sLAxFeRoRVEgQAy3X3oYqLa
   Kpz1r6Ub6pgnn4q3ft7PVp/8nibfttkCiSF1l7fMmqZ349LzxuYsZdrRI
   jUqM0quKc8iAQ/KQnTBUqJW9FE0Wi9iIHfeDC5PfwFd58QVHbFOLB0QLF
   lMOmCmMyAn4ck7Aoic+XX+U7kWuEsWMs2oG7lagdeXSaXGxsXsiEhlYpC
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10326"; a="264449567"
X-IronPort-AV: E=Sophos;i="5.90,285,1643702400"; 
   d="scan'208";a="264449567"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2022 13:35:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,285,1643702400"; 
   d="scan'208";a="531420064"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 23 Apr 2022 13:35:48 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1niMTs-0000R8-0y;
        Sat, 23 Apr 2022 20:35:48 +0000
Date:   Sun, 24 Apr 2022 04:34:49 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Liam R. Howlett" <Liam.Howlett@oracle.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org, David Howells <dhowells@redhat.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>
Subject: [ammarfaizi2-block:dhowells/linux-fs/netfs-maple 19/44]
 lib/maple_tree.c:6539:6: warning: no previous prototype for function
 'mt_dump_range'
Message-ID: <202204240438.zNyBSBSi-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ammarfaizi2/linux-block dhowells/linux-fs/netfs-maple
head:   931e50676c6598d0eda1954ead465519ff91874d
commit: 6c45be03ed6456efda93c06956d586eecae0e51a [19/44] Maple Tree: add new data structure
config: x86_64-allyesconfig (https://download.01.org/0day-ci/archive/20220424/202204240438.zNyBSBSi-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 5bd87350a5ae429baf8f373cb226a57b62f87280)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/ammarfaizi2/linux-block/commit/6c45be03ed6456efda93c06956d586eecae0e51a
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block dhowells/linux-fs/netfs-maple
        git checkout 6c45be03ed6456efda93c06956d586eecae0e51a
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> lib/maple_tree.c:6539:6: warning: no previous prototype for function 'mt_dump_range' [-Wmissing-prototypes]
   void mt_dump_range(unsigned long min, unsigned long max, unsigned int depth)
        ^
   lib/maple_tree.c:6539:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void mt_dump_range(unsigned long min, unsigned long max, unsigned int depth)
   ^
   static 
>> lib/maple_tree.c:6549:6: warning: no previous prototype for function 'mt_dump_entry' [-Wmissing-prototypes]
   void mt_dump_entry(void *entry, unsigned long min, unsigned long max,
        ^
   lib/maple_tree.c:6549:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void mt_dump_entry(void *entry, unsigned long min, unsigned long max,
   ^
   static 
>> lib/maple_tree.c:6565:6: warning: no previous prototype for function 'mt_dump_range64' [-Wmissing-prototypes]
   void mt_dump_range64(const struct maple_tree *mt, void *entry,
        ^
   lib/maple_tree.c:6565:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void mt_dump_range64(const struct maple_tree *mt, void *entry,
   ^
   static 
>> lib/maple_tree.c:6604:6: warning: no previous prototype for function 'mt_dump_arange64' [-Wmissing-prototypes]
   void mt_dump_arange64(const struct maple_tree *mt, void *entry,
        ^
   lib/maple_tree.c:6604:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void mt_dump_arange64(const struct maple_tree *mt, void *entry,
   ^
   static 
>> lib/maple_tree.c:6696:6: warning: no previous prototype for function 'mas_validate_gaps' [-Wmissing-prototypes]
   void mas_validate_gaps(struct ma_state *mas)
        ^
   lib/maple_tree.c:6696:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void mas_validate_gaps(struct ma_state *mas)
   ^
   static 
>> lib/maple_tree.c:6781:6: warning: no previous prototype for function 'mas_validate_parent_slot' [-Wmissing-prototypes]
   void mas_validate_parent_slot(struct ma_state *mas)
        ^
   lib/maple_tree.c:6781:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void mas_validate_parent_slot(struct ma_state *mas)
   ^
   static 
>> lib/maple_tree.c:6814:6: warning: no previous prototype for function 'mas_validate_child_slot' [-Wmissing-prototypes]
   void mas_validate_child_slot(struct ma_state *mas)
        ^
   lib/maple_tree.c:6814:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void mas_validate_child_slot(struct ma_state *mas)
   ^
   static 
>> lib/maple_tree.c:6852:6: warning: no previous prototype for function 'mas_validate_limits' [-Wmissing-prototypes]
   void mas_validate_limits(struct ma_state *mas)
        ^
   lib/maple_tree.c:6852:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void mas_validate_limits(struct ma_state *mas)
   ^
   static 
>> lib/maple_tree.c:6902:6: warning: no previous prototype for function 'mt_validate_nulls' [-Wmissing-prototypes]
   void mt_validate_nulls(struct maple_tree *mt)
        ^
   lib/maple_tree.c:6902:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void mt_validate_nulls(struct maple_tree *mt)
   ^
   static 
>> lib/maple_tree.c:6943:6: warning: no previous prototype for function 'mt_validate' [-Wmissing-prototypes]
   void mt_validate(struct maple_tree *mt)
        ^
   lib/maple_tree.c:6943:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void mt_validate(struct maple_tree *mt)
   ^
   static 
   lib/maple_tree.c:322:20: warning: unused function 'mte_set_full' [-Wunused-function]
   static inline void mte_set_full(const struct maple_enode *node)
                      ^
   lib/maple_tree.c:327:20: warning: unused function 'mte_clear_full' [-Wunused-function]
   static inline void mte_clear_full(const struct maple_enode *node)
                      ^
   12 warnings generated.


vim +/mt_dump_range +6539 lib/maple_tree.c

  6535	
  6536	/* Tree validations */
  6537	void mt_dump_node(const struct maple_tree *mt, void *entry, unsigned long min,
  6538			unsigned long max, unsigned int depth);
> 6539	void mt_dump_range(unsigned long min, unsigned long max, unsigned int depth)
  6540	{
  6541		static const char spaces[] = "                                ";
  6542	
  6543		if (min == max)
  6544			pr_info("%.*s%lu: ", depth * 2, spaces, min);
  6545		else
  6546			pr_info("%.*s%lu-%lu: ", depth * 2, spaces, min, max);
  6547	}
  6548	
> 6549	void mt_dump_entry(void *entry, unsigned long min, unsigned long max,
  6550			unsigned int depth)
  6551	{
  6552		mt_dump_range(min, max, depth);
  6553	
  6554		if (xa_is_value(entry))
  6555			pr_cont("value %ld (0x%lx) ["MA_PTR"]\n", xa_to_value(entry),
  6556					xa_to_value(entry), entry);
  6557		else if (xa_is_zero(entry))
  6558			pr_cont("zero (%ld)\n", xa_to_internal(entry));
  6559		else if (mt_is_reserved(entry))
  6560			pr_cont("UNKNOWN ENTRY ("MA_PTR")\n", entry);
  6561		else
  6562			pr_cont(""MA_PTR"\n", entry);
  6563	}
  6564	
> 6565	void mt_dump_range64(const struct maple_tree *mt, void *entry,
  6566			unsigned long min, unsigned long max, unsigned int depth)
  6567	{
  6568		struct maple_range_64 *node = &mte_to_node(entry)->mr64;
  6569		bool leaf = mte_is_leaf(entry);
  6570		unsigned long first = min;
  6571		int i;
  6572	
  6573		pr_cont(" contents: ");
  6574		for (i = 0; i < MAPLE_RANGE64_SLOTS - 1; i++)
  6575			pr_cont(""MA_PTR" %lu ", node->slot[i], node->pivot[i]);
  6576		pr_cont(""MA_PTR"\n", node->slot[i]);
  6577		for (i = 0; i < MAPLE_RANGE64_SLOTS; i++) {
  6578			unsigned long last = max;
  6579	
  6580			if (i < (MAPLE_RANGE64_SLOTS - 1))
  6581				last = node->pivot[i];
  6582			else if (!node->slot[i] && max != mt_max[mte_node_type(entry)])
  6583				break;
  6584			if (last == 0 && i > 0)
  6585				break;
  6586			if (leaf)
  6587				mt_dump_entry(mt_slot(mt, node->slot, i),
  6588						first, last, depth + 1);
  6589			else if (node->slot[i])
  6590				mt_dump_node(mt, mt_slot(mt, node->slot, i),
  6591						first, last, depth + 1);
  6592	
  6593			if (last == max)
  6594				break;
  6595			if (last > max) {
  6596				pr_err("node "MA_PTR" last (%lu) > max (%lu) at pivot %d!\n",
  6597						node, last, max, i);
  6598				break;
  6599			}
  6600			first = last + 1;
  6601		}
  6602	}
  6603	
> 6604	void mt_dump_arange64(const struct maple_tree *mt, void *entry,
  6605			unsigned long min, unsigned long max, unsigned int depth)
  6606	{
  6607		struct maple_arange_64 *node = &mte_to_node(entry)->ma64;
  6608		bool leaf = mte_is_leaf(entry);
  6609		unsigned long first = min;
  6610		int i;
  6611	
  6612		pr_cont(" contents: ");
  6613		for (i = 0; i < MAPLE_ARANGE64_SLOTS; i++)
  6614			pr_cont("%lu ", node->gap[i]);
  6615		pr_cont("| %02X %02X| ", node->meta.end, node->meta.gap);
  6616		for (i = 0; i < MAPLE_ARANGE64_SLOTS - 1; i++)
  6617			pr_cont(MA_PTR" %lu ", node->slot[i], node->pivot[i]);
  6618		pr_cont(MA_PTR"\n", node->slot[i]);
  6619		for (i = 0; i < MAPLE_ARANGE64_SLOTS; i++) {
  6620			unsigned long last = max;
  6621	
  6622			if (i < (MAPLE_ARANGE64_SLOTS - 1))
  6623				last = node->pivot[i];
  6624			else if (!node->slot[i])
  6625				break;
  6626			if (last == 0 && i > 0)
  6627				break;
  6628			if (leaf)
  6629				mt_dump_entry(mt_slot(mt, node->slot, i),
  6630						first, last, depth + 1);
  6631			else if (node->slot[i])
  6632				mt_dump_node(mt, mt_slot(mt, node->slot, i),
  6633						first, last, depth + 1);
  6634	
  6635			if (last == max)
  6636				break;
  6637			if (last > max) {
  6638				pr_err("node "MA_PTR" last (%lu) > max (%lu) at pivot %d!\n",
  6639						node, last, max, i);
  6640				break;
  6641			}
  6642			first = last + 1;
  6643		}
  6644	}
  6645	
  6646	void mt_dump_node(const struct maple_tree *mt, void *entry, unsigned long min,
  6647			unsigned long max, unsigned int depth)
  6648	{
  6649		struct maple_node *node = mte_to_node(entry);
  6650		unsigned int type = mte_node_type(entry);
  6651		unsigned int i;
  6652	
  6653		mt_dump_range(min, max, depth);
  6654	
  6655		pr_cont("node "MA_PTR" depth %d type %d parent "MA_PTR, node, depth, type,
  6656				node ? node->parent : NULL);
  6657		switch (type) {
  6658		case maple_dense:
  6659			pr_cont("\n");
  6660			for (i = 0; i < MAPLE_NODE_SLOTS; i++) {
  6661				if (min + i > max)
  6662					pr_cont("OUT OF RANGE: ");
  6663				mt_dump_entry(mt_slot(mt, node->slot, i),
  6664						min + i, min + i, depth);
  6665			}
  6666			break;
  6667		case maple_leaf_64:
  6668		case maple_range_64:
  6669			mt_dump_range64(mt, entry, min, max, depth);
  6670			break;
  6671		case maple_arange_64:
  6672			mt_dump_arange64(mt, entry, min, max, depth);
  6673			break;
  6674	
  6675		default:
  6676			pr_cont(" UNKNOWN TYPE\n");
  6677		}
  6678	}
  6679	
  6680	void mt_dump(const struct maple_tree *mt)
  6681	{
  6682		void *entry = rcu_dereference_check(mt->ma_root, mt_locked(mt));
  6683	
  6684		pr_info("maple_tree("MA_PTR") flags %X, height %u root "MA_PTR"\n",
  6685			 mt, mt->ma_flags, mt_height(mt), entry);
  6686		if (!xa_is_node(entry))
  6687			mt_dump_entry(entry, 0, 0, 0);
  6688		else if (entry)
  6689			mt_dump_node(mt, entry, 0, mt_max[mte_node_type(entry)], 0);
  6690	}
  6691	
  6692	/*
  6693	 * Calculate the maximum gap in a node and check if that's what is reported in
  6694	 * the parent (unless root).
  6695	 */
> 6696	void mas_validate_gaps(struct ma_state *mas)
  6697	{
  6698		struct maple_enode *mte = mas->node;
  6699		struct maple_node *p_mn;
  6700		unsigned long gap = 0, max_gap = 0;
  6701		unsigned long p_end, p_start = mas->min;
  6702		unsigned char p_slot;
  6703		unsigned long *gaps = NULL;
  6704		unsigned long *pivots = ma_pivots(mte_to_node(mte), mte_node_type(mte));
  6705		int i;
  6706	
  6707		if (ma_is_dense(mte_node_type(mte))) {
  6708			for (i = 0; i < mt_slot_count(mte); i++) {
  6709				if (mas_get_slot(mas, i)) {
  6710					if (gap > max_gap)
  6711						max_gap = gap;
  6712					gap = 0;
  6713					continue;
  6714				}
  6715				gap++;
  6716			}
  6717			goto counted;
  6718		}
  6719	
  6720		gaps = ma_gaps(mte_to_node(mte), mte_node_type(mte));
  6721		for (i = 0; i < mt_slot_count(mte); i++) {
  6722			p_end = mas_logical_pivot(mas, pivots, i, mte_node_type(mte));
  6723	
  6724			if (!gaps) {
  6725				if (mas_get_slot(mas, i)) {
  6726					gap = 0;
  6727					goto not_empty;
  6728				}
  6729	
  6730				gap += p_end - p_start + 1;
  6731			} else {
  6732				void *entry = mas_get_slot(mas, i);
  6733	
  6734				gap = gaps[i];
  6735				if (!entry) {
  6736					if (gap != p_end - p_start + 1) {
  6737						pr_err(MA_PTR"[%u] -> "MA_PTR" %lu != %lu - %lu + 1\n",
  6738							mas_mn(mas), i,
  6739							mas_get_slot(mas, i), gap,
  6740							p_end, p_start);
  6741						mt_dump(mas->tree);
  6742	
  6743						MT_BUG_ON(mas->tree,
  6744							gap != p_end - p_start + 1);
  6745					}
  6746				} else {
  6747					if (gap > p_end - p_start + 1) {
  6748						pr_err(MA_PTR"[%u] %lu >= %lu - %lu + 1 (%lu)\n",
  6749						mas_mn(mas), i, gap, p_end, p_start,
  6750						p_end - p_start + 1);
  6751						MT_BUG_ON(mas->tree,
  6752							gap > p_end - p_start + 1);
  6753					}
  6754				}
  6755			}
  6756	
  6757			if (gap > max_gap)
  6758				max_gap = gap;
  6759	not_empty:
  6760			p_start = p_end + 1;
  6761			if (p_end >= mas->max)
  6762				break;
  6763		}
  6764	
  6765	counted:
  6766		if (mte_is_root(mte))
  6767			return;
  6768	
  6769		p_slot = mte_parent_slot(mas->node);
  6770		p_mn = mte_parent(mte);
  6771		MT_BUG_ON(mas->tree, max_gap > mas->max);
  6772		if (ma_gaps(p_mn, mas_parent_enum(mas, mte))[p_slot] != max_gap) {
  6773			pr_err("gap "MA_PTR"[%u] != %lu\n", p_mn, p_slot, max_gap);
  6774			mt_dump(mas->tree);
  6775		}
  6776	
  6777		MT_BUG_ON(mas->tree,
  6778			  ma_gaps(p_mn, mas_parent_enum(mas, mte))[p_slot] != max_gap);
  6779	}
  6780	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
