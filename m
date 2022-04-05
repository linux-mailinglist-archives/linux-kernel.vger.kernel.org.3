Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47BCF4F4C1B
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 03:11:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1575835AbiDEXJX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 19:09:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356633AbiDELPh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 07:15:37 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 718EA81180
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 03:36:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649154966; x=1680690966;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=m/w1iGtXxdNAXlOqUzYZa0cnChQ1gqMHWhoCBK/uBEs=;
  b=gWw5666GFMCKk6D2ZHm0pszfO23TiDkOuZCDgjCGpXz2oCw4QNcIy7JA
   7+uKetf/kemkYap8qlA5kpg39ZFfeZ4QZDq+TvE5O/5+S6r/3u2O8+pqe
   ZvExmvS2nbaGJleBXyEvswoLWASw8Y2OlEN9IBMJS315uY5Bw96BUU6KN
   N5ucOzHkv/yXiQAT8YAdQQ813OlepxriJ31eV5U0xg6/wwX4FSjKCJ+Tq
   IRF6r3m4uuyESlo0WQEuFaQRpFNOpjBN5lGMqu/kS6rW+Bu7aM9Vm9vmU
   IKwTK9QiKgbW/v2C5jLK+Z0gE79zIGA/einUeDE7d4WRAdlAKQJ8Y+Oyo
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10307"; a="260413923"
X-IronPort-AV: E=Sophos;i="5.90,236,1643702400"; 
   d="scan'208";a="260413923"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2022 03:36:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,236,1643702400"; 
   d="scan'208";a="505232715"
Received: from lkp-server02.sh.intel.com (HELO a44fdfb70b94) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 05 Apr 2022 03:36:02 -0700
Received: from kbuild by a44fdfb70b94 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nbgXa-00034H-5L;
        Tue, 05 Apr 2022 10:36:02 +0000
Date:   Tue, 5 Apr 2022 18:35:39 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Liam R. Howlett" <Liam.Howlett@Oracle.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org, David Howells <dhowells@redhat.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [ammarfaizi2-block:dhowells/linux-fs/netfs-maple 19/40]
 lib/maple_tree.c:4203:20: warning: stack frame size (1288) exceeds limit
 (1024) in 'mas_wr_modify'
Message-ID: <202204051827.GTlRliPg-lkp@intel.com>
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
config: arm-moxart_defconfig (https://download.01.org/0day-ci/archive/20220405/202204051827.GTlRliPg-lkp@intel.com/config)
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
   lib/maple_tree.c:3863:19: warning: stack frame size (1040) exceeds limit (1024) in 'mas_wr_spanning_store' [-Wframe-larger-than]
   static inline int mas_wr_spanning_store(struct ma_wr_state *wr_mas)
                     ^
>> lib/maple_tree.c:4203:20: warning: stack frame size (1288) exceeds limit (1024) in 'mas_wr_modify' [-Wframe-larger-than]
   static inline void mas_wr_modify(struct ma_wr_state *wr_mas)
                      ^
   12 warnings generated.


vim +/mas_wr_modify +4203 lib/maple_tree.c

  4202	
> 4203	static inline void mas_wr_modify(struct ma_wr_state *wr_mas)
  4204	{
  4205		unsigned char zero;
  4206		unsigned char node_slots;
  4207		struct ma_state *mas = wr_mas->mas;
  4208		struct maple_big_node b_node;
  4209	
  4210		/* Direct replacement */
  4211		if (wr_mas->r_min == mas->index && wr_mas->r_max == mas->last) {
  4212			rcu_assign_pointer(wr_mas->slots[mas->offset], wr_mas->entry);
  4213			if (!!wr_mas->entry ^ !!wr_mas->content)
  4214				mas_update_gap(mas);
  4215			return;
  4216		}
  4217	
  4218		/* Attempt to append */
  4219		node_slots = mt_slots[wr_mas->type];
  4220		/* slot and node store will not fit, go to the slow path */
  4221		if (unlikely(wr_mas->offset_end + 1 >= node_slots))
  4222			goto slow_path;
  4223	
  4224		if (wr_mas->entry && (wr_mas->node_end < node_slots - 1) &&
  4225		    (mas->offset == wr_mas->node_end) && mas_wr_append(wr_mas)) {
  4226				if (!wr_mas->content || !wr_mas->entry)
  4227					mas_update_gap(mas);
  4228				return;
  4229		}
  4230	
  4231		if ((wr_mas->offset_end - mas->offset <= 1) && mas_wr_slot_store(wr_mas))
  4232			return;
  4233		else if (mas_wr_node_store(wr_mas))
  4234			return;
  4235	
  4236		if (mas_is_err(mas))
  4237			return;
  4238	
  4239	slow_path:
  4240		b_node.b_end = mas_store_b_node(wr_mas, &b_node, wr_mas->offset_end);
  4241		b_node.min = mas->min;
  4242		zero = MAPLE_BIG_NODE_SLOTS - b_node.b_end - 1;
  4243		memset(b_node.slot + b_node.b_end + 1, 0, sizeof(void *) * zero--);
  4244		memset(b_node.pivot + b_node.b_end + 1, 0,
  4245		       sizeof(unsigned long) * zero);
  4246	
  4247		trace_ma_write(__func__, mas, 0, wr_mas->entry);
  4248		mas_commit_b_node(mas, &b_node, wr_mas->node_end);
  4249	}
  4250	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
