Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D00CC50C9BE
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Apr 2022 13:54:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235353AbiDWL5V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Apr 2022 07:57:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234794AbiDWL5T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Apr 2022 07:57:19 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A3331F7D51
        for <linux-kernel@vger.kernel.org>; Sat, 23 Apr 2022 04:54:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650714862; x=1682250862;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=l4wPno+iosFMmEiU8vUqOggby6d5mok6/+Fqva8QWE4=;
  b=ksira4/nB4aHLDNf6OohdVxgL+ZImrDouHMd0hYI7KP/2yeTwA464Pj4
   Xm0jEoGenTfTkLpHcIMQDZDLsM0dd4lmjtO3VgVqsQS+qLPUQjmgFiGq/
   X2Ak0Jr1oznFBRnPaeFe1fHUplO57L8B0cPJNzPbwqOHE3rzlAwO+cuNk
   NGr1VSrqNzjyaFuVXqdvwvP/CMUEr7m86U2JjFKjmD/9sRR5Xp0RD8q23
   I8NlD8c1zxSb9jpWm7vgiz0T+OplM1elG7ieF9dS+dGOF9wcYthZz7f39
   eFZaHTKbgES9Ltf00NJjdl1xrl7Ey9wWWJxAKQG1+36Ix7WZK6s0AH6JT
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10324"; a="325341942"
X-IronPort-AV: E=Sophos;i="5.90,284,1643702400"; 
   d="scan'208";a="325341942"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2022 04:54:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,284,1643702400"; 
   d="scan'208";a="511927683"
Received: from lkp-server01.sh.intel.com (HELO dd58949a6e39) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 23 Apr 2022 04:54:19 -0700
Received: from kbuild by dd58949a6e39 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1niELC-0000Dx-T6;
        Sat, 23 Apr 2022 11:54:18 +0000
Date:   Sat, 23 Apr 2022 19:53:28 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Liam R. Howlett" <Liam.Howlett@oracle.com>
Cc:     kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org, David Howells <dhowells@redhat.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>
Subject: [ammarfaizi2-block:dhowells/linux-fs/netfs-maple 19/44]
 lib/maple_tree.c:5317:23: sparse: sparse: incorrect type in assignment
 (different address spaces)
Message-ID: <202204231903.VFCpjd8T-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ammarfaizi2/linux-block dhowells/linux-fs/netfs-maple
head:   931e50676c6598d0eda1954ead465519ff91874d
commit: 6c45be03ed6456efda93c06956d586eecae0e51a [19/44] Maple Tree: add new data structure
config: arc-randconfig-s032-20220422 (https://download.01.org/0day-ci/archive/20220423/202204231903.VFCpjd8T-lkp@intel.com/config)
compiler: arc-elf-gcc (GCC) 11.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://github.com/ammarfaizi2/linux-block/commit/6c45be03ed6456efda93c06956d586eecae0e51a
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block dhowells/linux-fs/netfs-maple
        git checkout 6c45be03ed6456efda93c06956d586eecae0e51a
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=arc SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
>> lib/maple_tree.c:5317:23: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void **slots @@     got void [noderef] __rcu ** @@
   lib/maple_tree.c:5317:23: sparse:     expected void **slots
   lib/maple_tree.c:5317:23: sparse:     got void [noderef] __rcu **
>> lib/maple_tree.c:5318:45: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __rcu **slots @@     got void **slots @@
   lib/maple_tree.c:5318:45: sparse:     expected void [noderef] __rcu **slots
   lib/maple_tree.c:5318:45: sparse:     got void **slots
>> lib/maple_tree.c:5343:15: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __rcu **slots @@     got void ** @@
   lib/maple_tree.c:5343:15: sparse:     expected void [noderef] __rcu **slots
   lib/maple_tree.c:5343:15: sparse:     got void **
>> lib/maple_tree.c:5355:31: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __rcu **[assigned] slots @@     got void ** @@
   lib/maple_tree.c:5355:31: sparse:     expected void [noderef] __rcu **[assigned] slots
   lib/maple_tree.c:5355:31: sparse:     got void **
>> lib/maple_tree.c:5425:34: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct maple_enode *[addressable] [assigned] node @@     got void [noderef] __rcu * @@
   lib/maple_tree.c:5425:34: sparse:     expected struct maple_enode *[addressable] [assigned] node
   lib/maple_tree.c:5425:34: sparse:     got void [noderef] __rcu *
   lib/maple_tree.c:5365:9: sparse: sparse: context imbalance in 'mt_free_walk' - different lock contexts for basic block

vim +5317 lib/maple_tree.c

  5307	
  5308	static void **mas_dead_walk(struct ma_state *mas, unsigned char offset)
  5309	{
  5310		struct maple_node *node, *next;
  5311		void **slots = NULL;
  5312	
  5313		next = mas_mn(mas);
  5314		do {
  5315			mas->node = ma_enode_ptr(next);
  5316			node = mas_mn(mas);
> 5317			slots = ma_slots(node, node->type);
> 5318			next = mas_slot_locked(mas, slots, offset);
  5319			offset = 0;
  5320		} while (!ma_is_leaf(next->type));
  5321	
  5322		return slots;
  5323	}
  5324	
  5325	static void mt_free_walk(struct rcu_head *head)
  5326	{
  5327		void __rcu **slots;
  5328		struct maple_node *node, *start;
  5329		struct maple_tree mt;
  5330		unsigned char offset;
  5331		enum maple_type type;
  5332		MA_STATE(mas, &mt, 0, 0);
  5333	
  5334		node = container_of(head, struct maple_node, rcu);
  5335	
  5336		if (ma_is_leaf(node->type))
  5337			goto free_leaf;
  5338	
  5339		mt_init_flags(&mt, node->ma_flags);
  5340		mas_lock(&mas);
  5341		start = node;
  5342		mas.node = mt_mk_node(node, node->type);
> 5343		slots = mas_dead_walk(&mas, 0);
  5344		node = mas_mn(&mas);
  5345		do {
  5346			mt_free_bulk(node->slot_len, slots);
  5347			offset = node->parent_slot + 1;
  5348			mas.node = node->piv_parent;
  5349			if (mas_mn(&mas) == node)
  5350				goto start_slots_free;
  5351	
  5352			type = mte_node_type(mas.node);
  5353			slots = ma_slots(mte_to_node(mas.node), type);
  5354			if ((offset < mt_slots[type]) && (slots[offset]))
> 5355				slots = mas_dead_walk(&mas, offset);
  5356	
  5357			node = mas_mn(&mas);
  5358		} while ((node != start) || (node->slot_len < offset));
  5359	
  5360		slots = ma_slots(node, node->type);
  5361		mt_free_bulk(node->slot_len, slots);
  5362	
  5363	start_slots_free:
  5364	free_leaf:
  5365		mt_free_rcu(&node->rcu);
  5366	}
  5367	
  5368	static inline void __rcu **mas_destroy_descend(struct ma_state *mas,
  5369				struct maple_enode *prev, unsigned char offset)
  5370	{
  5371		struct maple_node *node;
  5372		struct maple_enode *next = mas->node;
  5373		void __rcu **slots = NULL;
  5374	
  5375		do {
  5376			mas->node = next;
  5377			node = mas_mn(mas);
  5378			slots = ma_slots(node, mte_node_type(mas->node));
  5379			next = mas_slot_locked(mas, slots, 0);
  5380			mte_set_node_dead(mas->node);
  5381			node->type = mte_node_type(mas->node);
  5382			node->piv_parent = prev;
  5383			node->parent_slot = offset;
  5384			offset = 0;
  5385			prev = mas->node;
  5386		} while (!mte_is_leaf(next));
  5387		return slots;
  5388	}
  5389	
  5390	static void mt_destroy_walk(struct maple_enode *enode, unsigned char ma_flags,
  5391				    bool free)
  5392	{
  5393		void __rcu **slots;
  5394		struct maple_node *node = mte_to_node(enode);
  5395		struct maple_enode *start;
  5396		struct maple_tree mt;
  5397	
  5398		MA_STATE(mas, &mt, 0, 0);
  5399	
  5400		if (mte_is_leaf(enode))
  5401			goto free_leaf;
  5402	
  5403		mt_init_flags(&mt, ma_flags);
  5404		mas_lock(&mas);
  5405	
  5406		mas.node = start = enode;
  5407		slots = mas_destroy_descend(&mas, start, 0);
  5408		node = mas_mn(&mas);
  5409		do {
  5410			enum maple_type type;
  5411			unsigned char offset;
  5412	
  5413			node->slot_len = mas_dead_leaves(&mas, slots);
  5414			if (free)
  5415				mt_free_bulk(node->slot_len, slots);
  5416			offset = node->parent_slot + 1;
  5417			mas.node = node->piv_parent;
  5418			if (mas_mn(&mas) == node)
  5419				goto start_slots_free;
  5420			type = mte_node_type(mas.node);
  5421			slots = ma_slots(mte_to_node(mas.node), type);
  5422			if ((offset < mt_slots[type]) && (slots[offset])) {
  5423				struct maple_enode *parent = mas.node;
  5424	
> 5425				mas.node = slots[offset];
  5426				slots = mas_destroy_descend(&mas, parent, offset);
  5427			}
  5428			node = mas_mn(&mas);
  5429		} while (start != mas.node);
  5430	
  5431		node = mas_mn(&mas);
  5432		node->slot_len = mas_dead_leaves(&mas, slots);
  5433		if (free)
  5434			mt_free_bulk(node->slot_len, slots);
  5435	
  5436	start_slots_free:
  5437		mas_unlock(&mas);
  5438	
  5439	free_leaf:
  5440		if (free)
  5441			mt_free_rcu(&node->rcu);
  5442	}
  5443	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
