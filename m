Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD96E4811CA
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Dec 2021 11:53:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239796AbhL2KxD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Dec 2021 05:53:03 -0500
Received: from mga03.intel.com ([134.134.136.65]:1668 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235648AbhL2KxC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Dec 2021 05:53:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640775182; x=1672311182;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=8R+iae+JbhJZJtEa+PJ0mGnVdF0biOVbbUPj8IsRZqI=;
  b=NDXXWvLx60okW1ltSxFHLHElX2qwKJXDNvaZBmFFNZz5/93VFv8KuAyz
   rWWo4yIRuIlvZPq/teIwkW0y1UfAP7r2lTO0cJgZEqIg5rpi5ZMM3i8qM
   mh1TZI1LBRNty6HKuG2NaW6N+ou6KpWsWfuf3hNen010ik9GfPgH+a7cD
   UDdtBq7140QT5jLk5c+zk+ncisAkOIlgmAzjluYGspomgdgCVuK6aqQXd
   fyl3/6pPMgHof+dWjXWRfmD0cg8puCDtRZGPT6kHcdw03ApHkxjnjQ7TM
   7+I+tpkqj4hTv5ZQq1QqBn2zqp/i6S6JeeFeY03etlmN2hYVLYyXNmd0l
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10211"; a="241457113"
X-IronPort-AV: E=Sophos;i="5.88,245,1635231600"; 
   d="scan'208";a="241457113"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Dec 2021 02:53:00 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,245,1635231600"; 
   d="scan'208";a="619004425"
Received: from lkp-server01.sh.intel.com (HELO e357b3ef1427) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 29 Dec 2021 02:52:59 -0800
Received: from kbuild by e357b3ef1427 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n2WZn-0008qL-2H; Wed, 29 Dec 2021 10:52:59 +0000
Date:   Wed, 29 Dec 2021 18:52:02 +0800
From:   kernel test robot <lkp@intel.com>
To:     Cong Wang <cong.wang@bytedance.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [congwang:sch_bpf 2/3] kernel/bpf/skb_map.c:160:5: warning: no
 previous prototype for 'skb_map_enqueue'
Message-ID: <202112291851.QYCzexRJ-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/congwang/linux.git sch_bpf
head:   5fb0da1e47e0c68da0323a3e0399b2628a13e999
commit: bc7c943a32f707b17d62bcbf4cca59f3e0de8d65 [2/3] bpf: introduce skb map
config: arc-randconfig-r043-20211228 (https://download.01.org/0day-ci/archive/20211229/202112291851.QYCzexRJ-lkp@intel.com/config)
compiler: arceb-elf-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/congwang/linux/commit/bc7c943a32f707b17d62bcbf4cca59f3e0de8d65
        git remote add congwang https://github.com/congwang/linux.git
        git fetch --no-tags congwang sch_bpf
        git checkout bc7c943a32f707b17d62bcbf4cca59f3e0de8d65
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arc SHELL=/bin/bash drivers/reset/ kernel/bpf/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> kernel/bpf/skb_map.c:160:5: warning: no previous prototype for 'skb_map_enqueue' [-Wmissing-prototypes]
     160 | int skb_map_enqueue(struct sk_buff *skb, struct bpf_map *map, u64 key)
         |     ^~~~~~~~~~~~~~~
>> kernel/bpf/skb_map.c:180:17: warning: no previous prototype for 'skb_map_dequeue' [-Wmissing-prototypes]
     180 | struct sk_buff *skb_map_dequeue(struct bpf_map *map)
         |                 ^~~~~~~~~~~~~~~


vim +/skb_map_enqueue +160 kernel/bpf/skb_map.c

   159	
 > 160	int skb_map_enqueue(struct sk_buff *skb, struct bpf_map *map, u64 key)
   161	{
   162		struct bpf_skb_map *pq = bpf_skb_map(map);
   163		struct skb_map_node *n;
   164		unsigned long flags;
   165	
   166		if (atomic_inc_return(&pq->count) > pq->map.max_entries)
   167			return -ENOBUFS;
   168		n = alloc_skb_map_node(pq);
   169		if (!n)
   170			return -ENOMEM;
   171		n->key = key;
   172		n->skb = skb_get(skb);
   173		raw_spin_lock_irqsave(&pq->lock, flags);
   174		pq_push(&pq->root, &n->node);
   175		raw_spin_unlock_irqrestore(&pq->lock, flags);
   176		return 0;
   177	
   178	}
   179	
 > 180	struct sk_buff *skb_map_dequeue(struct bpf_map *map)
   181	{
   182		struct bpf_skb_map *pq = bpf_skb_map(map);
   183		struct skb_map_node *n;
   184		struct pq_node *node;
   185		unsigned long flags;
   186	
   187		raw_spin_lock_irqsave(&pq->lock, flags);
   188		node = pq_pop(&pq->root);
   189		if (!node) {
   190			raw_spin_unlock_irqrestore(&pq->lock, flags);
   191			return NULL;
   192		}
   193		raw_spin_unlock_irqrestore(&pq->lock, flags);
   194		n = container_of(node, struct skb_map_node, node);
   195		consume_skb(n->skb);
   196		atomic_dec(&pq->count);
   197		return n->skb;
   198	}
   199	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
