Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B6904B2C4A
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 19:00:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352435AbiBKR7P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 12:59:15 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:47226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352359AbiBKR7F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 12:59:05 -0500
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85D8CD41
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 09:59:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644602343; x=1676138343;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=WSks6dsa3hUoEPiEsR6qt3KVJg6s77h+kCp+ajSvbJg=;
  b=H59Y/CI/UF5jzsmwV4lhm6+MRzi5UX7FzR9Z7Fe+BoaJE6V7Fa//wLQu
   NJNJGmmAPCobwGK2Wv32GY1GoblPl0fyRROzph4TSxBhG8ymE4/jRXhBx
   7Aby365kf8s7ck4tCrfWDEN90kyInf+aPEeh5K9NM2/h9uXIwS3cZGAR9
   7tcELK+rUJa/UdCCiXEq+dtLd7p8HRAZMjrIysP9r2/u8g8V/MnGhLk+V
   e2yvsdDMyQ28cYpws6ZG0bdOKiHgCLA6W5AeIj/glvuE0p2lXckaOcce9
   dRN+zWjBZUOLFrFbBvfQookJd5DPbNPoiAeaf9Sc0Kg0X6xzci9zN/lUe
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10255"; a="310515364"
X-IronPort-AV: E=Sophos;i="5.88,361,1635231600"; 
   d="scan'208";a="310515364"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2022 09:59:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,361,1635231600"; 
   d="scan'208";a="772156703"
Received: from lkp-server01.sh.intel.com (HELO d95dc2dabeb1) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 11 Feb 2022 09:59:01 -0800
Received: from kbuild by d95dc2dabeb1 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nIaCC-0004tw-Rp; Fri, 11 Feb 2022 17:59:00 +0000
Date:   Sat, 12 Feb 2022 01:58:01 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Liam R. Howlett" <Liam.Howlett@Oracle.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [dhowells-fs:netfs-maple 27/48] lib/maple_tree.c:6514:6: warning: no
 previous prototype for 'mt_dump_range'
Message-ID: <202202112145.NLi7L3SB-lkp@intel.com>
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

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git netfs-maple
head:   429e2bb6fb190f390ed23afc0d2308e877c43be5
commit: ae818d3bce322321c0987d493e6687aefffe7c63 [27/48] Maple Tree: Add new data structure
config: m68k-allyesconfig (https://download.01.org/0day-ci/archive/20220211/202202112145.NLi7L3SB-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git/commit/?id=ae818d3bce322321c0987d493e6687aefffe7c63
        git remote add dhowells-fs https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git
        git fetch --no-tags dhowells-fs netfs-maple
        git checkout ae818d3bce322321c0987d493e6687aefffe7c63
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=m68k SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   lib/maple_tree.c:5557:6: warning: no previous prototype for 'mas_wr_store_setup' [-Wmissing-prototypes]
    5557 | void mas_wr_store_setup(struct ma_wr_state *wr_mas)
         |      ^~~~~~~~~~~~~~~~~~
   lib/maple_tree.c:6172:5: warning: no previous prototype for 'mtree_alloc_range' [-Wmissing-prototypes]
    6172 | int mtree_alloc_range(struct maple_tree *mt, unsigned long *startp,
         |     ^~~~~~~~~~~~~~~~~
   lib/maple_tree.c:6207:5: warning: no previous prototype for 'mtree_alloc_rrange' [-Wmissing-prototypes]
    6207 | int mtree_alloc_rrange(struct maple_tree *mt, unsigned long *startp,
         |     ^~~~~~~~~~~~~~~~~~
>> lib/maple_tree.c:6514:6: warning: no previous prototype for 'mt_dump_range' [-Wmissing-prototypes]
    6514 | void mt_dump_range(unsigned long min, unsigned long max, unsigned int depth)
         |      ^~~~~~~~~~~~~
>> lib/maple_tree.c:6524:6: warning: no previous prototype for 'mt_dump_entry' [-Wmissing-prototypes]
    6524 | void mt_dump_entry(void *entry, unsigned long min, unsigned long max,
         |      ^~~~~~~~~~~~~
>> lib/maple_tree.c:6540:6: warning: no previous prototype for 'mt_dump_range64' [-Wmissing-prototypes]
    6540 | void mt_dump_range64(const struct maple_tree *mt, void *entry,
         |      ^~~~~~~~~~~~~~~
>> lib/maple_tree.c:6579:6: warning: no previous prototype for 'mt_dump_arange64' [-Wmissing-prototypes]
    6579 | void mt_dump_arange64(const struct maple_tree *mt, void *entry,
         |      ^~~~~~~~~~~~~~~~
>> lib/maple_tree.c:6671:6: warning: no previous prototype for 'mas_validate_gaps' [-Wmissing-prototypes]
    6671 | void mas_validate_gaps(struct ma_state *mas)
         |      ^~~~~~~~~~~~~~~~~
>> lib/maple_tree.c:6758:6: warning: no previous prototype for 'mas_validate_parent_slot' [-Wmissing-prototypes]
    6758 | void mas_validate_parent_slot(struct ma_state *mas)
         |      ^~~~~~~~~~~~~~~~~~~~~~~~
>> lib/maple_tree.c:6791:6: warning: no previous prototype for 'mas_validate_child_slot' [-Wmissing-prototypes]
    6791 | void mas_validate_child_slot(struct ma_state *mas)
         |      ^~~~~~~~~~~~~~~~~~~~~~~
>> lib/maple_tree.c:6829:6: warning: no previous prototype for 'mas_validate_limits' [-Wmissing-prototypes]
    6829 | void mas_validate_limits(struct ma_state *mas)
         |      ^~~~~~~~~~~~~~~~~~~
>> lib/maple_tree.c:6879:6: warning: no previous prototype for 'mt_validate_nulls' [-Wmissing-prototypes]
    6879 | void mt_validate_nulls(struct maple_tree *mt)
         |      ^~~~~~~~~~~~~~~~~
>> lib/maple_tree.c:6920:6: warning: no previous prototype for 'mt_validate' [-Wmissing-prototypes]
    6920 | void mt_validate(struct maple_tree *mt)
         |      ^~~~~~~~~~~


vim +/mt_dump_range +6514 lib/maple_tree.c

  6510	
  6511	/* Tree validations */
  6512	void mt_dump_node(const struct maple_tree *mt, void *entry, unsigned long min,
  6513			unsigned long max, unsigned int depth);
> 6514	void mt_dump_range(unsigned long min, unsigned long max, unsigned int depth)
  6515	{
  6516		static const char spaces[] = "                                ";
  6517	
  6518		if (min == max)
  6519			pr_info("%.*s%lu: ", depth * 2, spaces, min);
  6520		else
  6521			pr_info("%.*s%lu-%lu: ", depth * 2, spaces, min, max);
  6522	}
  6523	
> 6524	void mt_dump_entry(void *entry, unsigned long min, unsigned long max,
  6525			unsigned int depth)
  6526	{
  6527		mt_dump_range(min, max, depth);
  6528	
  6529		if (xa_is_value(entry))
  6530			pr_cont("value %ld (0x%lx) ["MA_PTR"]\n", xa_to_value(entry),
  6531					xa_to_value(entry), entry);
  6532		else if (xa_is_zero(entry))
  6533			pr_cont("zero (%ld)\n", xa_to_internal(entry));
  6534		else if (mt_is_reserved(entry))
  6535			pr_cont("UNKNOWN ENTRY ("MA_PTR")\n", entry);
  6536		else
  6537			pr_cont(""MA_PTR"\n", entry);
  6538	}
  6539	
> 6540	void mt_dump_range64(const struct maple_tree *mt, void *entry,
  6541			unsigned long min, unsigned long max, unsigned int depth)
  6542	{
  6543		struct maple_range_64 *node = &mte_to_node(entry)->mr64;
  6544		bool leaf = mte_is_leaf(entry);
  6545		unsigned long first = min;
  6546		int i;
  6547	
  6548		pr_cont(" contents: ");
  6549		for (i = 0; i < MAPLE_RANGE64_SLOTS - 1; i++)
  6550			pr_cont(""MA_PTR" %lu ", node->slot[i], node->pivot[i]);
  6551		pr_cont(""MA_PTR"\n", node->slot[i]);
  6552		for (i = 0; i < MAPLE_RANGE64_SLOTS; i++) {
  6553			unsigned long last = max;
  6554	
  6555			if (i < (MAPLE_RANGE64_SLOTS - 1))
  6556				last = node->pivot[i];
  6557			else if (!node->slot[i] && max != mt_max[mte_node_type(entry)])
  6558				break;
  6559			if (last == 0 && i > 0)
  6560				break;
  6561			if (leaf)
  6562				mt_dump_entry(mt_slot(mt, node->slot, i),
  6563						first, last, depth + 1);
  6564			else if (node->slot[i])
  6565				mt_dump_node(mt, mt_slot(mt, node->slot, i),
  6566						first, last, depth + 1);
  6567	
  6568			if (last == max)
  6569				break;
  6570			if (last > max) {
  6571				pr_err("node "MA_PTR" last (%lu) > max (%lu) at pivot %d!\n",
  6572						node, last, max, i);
  6573				break;
  6574			}
  6575			first = last + 1;
  6576		}
  6577	}
  6578	
> 6579	void mt_dump_arange64(const struct maple_tree *mt, void *entry,
  6580			unsigned long min, unsigned long max, unsigned int depth)
  6581	{
  6582		struct maple_arange_64 *node = &mte_to_node(entry)->ma64;
  6583		bool leaf = mte_is_leaf(entry);
  6584		unsigned long first = min;
  6585		int i;
  6586	
  6587		pr_cont(" contents: ");
  6588		for (i = 0; i < MAPLE_ARANGE64_SLOTS; i++)
  6589			pr_cont("%lu ", node->gap[i]);
  6590		pr_cont("| %02X %02X| ", node->meta.end, node->meta.gap);
  6591		for (i = 0; i < MAPLE_ARANGE64_SLOTS - 1; i++)
  6592			pr_cont(MA_PTR" %lu ", node->slot[i], node->pivot[i]);
  6593		pr_cont(MA_PTR"\n", node->slot[i]);
  6594		for (i = 0; i < MAPLE_ARANGE64_SLOTS; i++) {
  6595			unsigned long last = max;
  6596	
  6597			if (i < (MAPLE_ARANGE64_SLOTS - 1))
  6598				last = node->pivot[i];
  6599			else if (!node->slot[i])
  6600				break;
  6601			if (last == 0 && i > 0)
  6602				break;
  6603			if (leaf)
  6604				mt_dump_entry(mt_slot(mt, node->slot, i),
  6605						first, last, depth + 1);
  6606			else if (node->slot[i])
  6607				mt_dump_node(mt, mt_slot(mt, node->slot, i),
  6608						first, last, depth + 1);
  6609	
  6610			if (last == max)
  6611				break;
  6612			if (last > max) {
  6613				pr_err("node "MA_PTR" last (%lu) > max (%lu) at pivot %d!\n",
  6614						node, last, max, i);
  6615				break;
  6616			}
  6617			first = last + 1;
  6618		}
  6619	}
  6620	
  6621	void mt_dump_node(const struct maple_tree *mt, void *entry, unsigned long min,
  6622			unsigned long max, unsigned int depth)
  6623	{
  6624		struct maple_node *node = mte_to_node(entry);
  6625		unsigned int type = mte_node_type(entry);
  6626		unsigned int i;
  6627	
  6628		mt_dump_range(min, max, depth);
  6629	
  6630		pr_cont("node "MA_PTR" depth %d type %d parent "MA_PTR, node, depth, type,
  6631				node ? node->parent : NULL);
  6632		switch (type) {
  6633		case maple_dense:
  6634			pr_cont("\n");
  6635			for (i = 0; i < MAPLE_NODE_SLOTS; i++) {
  6636				if (min + i > max)
  6637					pr_cont("OUT OF RANGE: ");
  6638				mt_dump_entry(mt_slot(mt, node->slot, i),
  6639						min + i, min + i, depth);
  6640			}
  6641			break;
  6642		case maple_leaf_64:
  6643		case maple_range_64:
  6644			mt_dump_range64(mt, entry, min, max, depth);
  6645			break;
  6646		case maple_arange_64:
  6647			mt_dump_arange64(mt, entry, min, max, depth);
  6648			break;
  6649	
  6650		default:
  6651			pr_cont(" UNKNOWN TYPE\n");
  6652		}
  6653	}
  6654	
  6655	void mt_dump(const struct maple_tree *mt)
  6656	{
  6657		void *entry = rcu_dereference_check(mt->ma_root, mt_locked(mt));
  6658	
  6659		pr_info("maple_tree("MA_PTR") flags %X, height %u root "MA_PTR"\n",
  6660			 mt, mt->ma_flags, mt_height(mt), entry);
  6661		if (!xa_is_node(entry))
  6662			mt_dump_entry(entry, 0, 0, 0);
  6663		else if (entry)
  6664			mt_dump_node(mt, entry, 0, mt_max[mte_node_type(entry)], 0);
  6665	}
  6666	
  6667	/*
  6668	 * Calculate the maximum gap in a node and check if that's what is reported in
  6669	 * the parent (unless root).
  6670	 */
> 6671	void mas_validate_gaps(struct ma_state *mas)
  6672	{
  6673		struct maple_enode *mte = mas->node;
  6674		struct maple_node *p_mn;
  6675		unsigned long gap = 0, max_gap = 0;
  6676		unsigned long p_end, p_start = mas->min;
  6677		unsigned char p_slot;
  6678		unsigned long *gaps = NULL;
  6679		unsigned long *pivots = ma_pivots(mte_to_node(mte), mte_node_type(mte));
  6680		int i;
  6681	
  6682		if (ma_is_dense(mte_node_type(mte))) {
  6683			for (i = 0; i < mt_slot_count(mte); i++) {
  6684				if (mas_get_slot(mas, i)) {
  6685					if (gap > max_gap)
  6686						max_gap = gap;
  6687					gap = 0;
  6688					continue;
  6689				}
  6690				gap++;
  6691			}
  6692			goto counted;
  6693		}
  6694	
  6695		if (!mte_is_leaf(mte))
  6696			gaps = ma_gaps(mte_to_node(mte), mte_node_type(mte));
  6697	
  6698		for (i = 0; i < mt_slot_count(mte); i++) {
  6699			p_end = mas_logical_pivot(mas, pivots, i, mte_node_type(mte));
  6700	
  6701			if (!gaps) {
  6702				if (mas_get_slot(mas, i)) {
  6703					gap = 0;
  6704					goto not_empty;
  6705				}
  6706	
  6707				gap += p_end - p_start + 1;
  6708			} else {
  6709				void *entry = mas_get_slot(mas, i);
  6710	
  6711				gap = gaps[i];
  6712				if (!entry) {
  6713					if (gap != p_end - p_start + 1) {
  6714						pr_err(MA_PTR"[%u] -> "MA_PTR" %lu != %lu - %lu + 1\n",
  6715							mas_mn(mas), i,
  6716							mas_get_slot(mas, i), gap,
  6717							p_end, p_start);
  6718						mt_dump(mas->tree);
  6719	
  6720						MT_BUG_ON(mas->tree,
  6721							gap != p_end - p_start + 1);
  6722					}
  6723				} else {
  6724					if (gap > p_end - p_start + 1) {
  6725						pr_err(MA_PTR"[%u] %lu >= %lu - %lu + 1 (%lu)\n",
  6726						mas_mn(mas), i, gap, p_end, p_start,
  6727						p_end - p_start + 1);
  6728						MT_BUG_ON(mas->tree,
  6729							gap > p_end - p_start + 1);
  6730					}
  6731				}
  6732			}
  6733	
  6734			if (gap > max_gap)
  6735				max_gap = gap;
  6736	not_empty:
  6737			p_start = p_end + 1;
  6738			if (p_end >= mas->max)
  6739				break;
  6740		}
  6741	
  6742	counted:
  6743		if (mte_is_root(mte))
  6744			return;
  6745	
  6746		p_slot = mte_parent_slot(mas->node);
  6747		p_mn = mte_parent(mte);
  6748		MT_BUG_ON(mas->tree, max_gap > mas->max);
  6749		if (ma_gaps(p_mn, mas_parent_enum(mas, mte))[p_slot] != max_gap) {
  6750			pr_err("gap "MA_PTR"[%u] != %lu\n", p_mn, p_slot, max_gap);
  6751			mt_dump(mas->tree);
  6752		}
  6753	
  6754		MT_BUG_ON(mas->tree,
  6755			  ma_gaps(p_mn, mas_parent_enum(mas, mte))[p_slot] != max_gap);
  6756	}
  6757	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
