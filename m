Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A3B6535E72
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 12:41:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350545AbiE0Klj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 May 2022 06:41:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344353AbiE0Klg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 06:41:36 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B48DD58
        for <linux-kernel@vger.kernel.org>; Fri, 27 May 2022 03:41:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653648090; x=1685184090;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=aROHtuTAI9r44H/GerBgCxeaHRVZh6w/RqvURh3hKmU=;
  b=HG2coq3wM5YmTdsv7QCVvTjFo6uCOpO0spURusvLDYw304/DobKapU3E
   adbAbICfMcfhQYGZB8jkCyDLx3G1VhkLHO5g1/SVPAvh5jJ672Zkz9XM8
   9Gpfc7M6DJvxYM9Am6mveRAoSDFhiirq806IbCsVGkiZmDNpB2dcHKLru
   NOC0aua4LbR0o51R7i8ypHkyXoWyb4PycPInXeYHLLhgkxCBXq463d+om
   w6u68vF16h4pXf4ERvqXVNfd8aisbDmvtjzG1wN37BmVL8u5H9BhFsNc7
   frUlDfmfWMUaGNkmo+ZVNTohMhfUYKFGLtrg6RgLSlRsHvwGJIaBOn0DV
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10359"; a="262064568"
X-IronPort-AV: E=Sophos;i="5.91,255,1647327600"; 
   d="scan'208";a="262064568"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2022 03:41:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,255,1647327600"; 
   d="scan'208";a="610190178"
Received: from lkp-server01.sh.intel.com (HELO db63a1be7222) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 27 May 2022 03:41:28 -0700
Received: from kbuild by db63a1be7222 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nuXPM-0004gU-2C;
        Fri, 27 May 2022 10:41:28 +0000
Date:   Fri, 27 May 2022 18:41:16 +0800
From:   kernel test robot <lkp@intel.com>
To:     Cong Wang <cong.wang@bytedance.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [congwang:sch_bpf 4/4] net/sched/sch_api.c:369:22: error: implicit
 declaration of function 'tcf_get_next_chain'
Message-ID: <202205271852.CPCyjBUG-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/congwang/linux.git sch_bpf
head:   d7144f4291a2882e698a6d9d83f7e614d97be9c8
commit: d7144f4291a2882e698a6d9d83f7e614d97be9c8 [4/4] net_sched: introduce helper bpf_skb_tc_classify()
config: mips-xway_defconfig (https://download.01.org/0day-ci/archive/20220527/202205271852.CPCyjBUG-lkp@intel.com/config)
compiler: mips-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/congwang/linux/commit/d7144f4291a2882e698a6d9d83f7e614d97be9c8
        git remote add congwang https://github.com/congwang/linux.git
        git fetch --no-tags congwang sch_bpf
        git checkout d7144f4291a2882e698a6d9d83f7e614d97be9c8
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=mips SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   net/sched/sch_api.c: In function '____bpf_skb_tc_classify':
>> net/sched/sch_api.c:369:22: error: implicit declaration of function 'tcf_get_next_chain' [-Werror=implicit-function-declaration]
     369 |         for (chain = tcf_get_next_chain(block, NULL);
         |                      ^~~~~~~~~~~~~~~~~~
   net/sched/sch_api.c:369:20: warning: assignment to 'struct tcf_chain *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
     369 |         for (chain = tcf_get_next_chain(block, NULL);
         |                    ^
   net/sched/sch_api.c:371:20: warning: assignment to 'struct tcf_chain *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
     371 |              chain = tcf_get_next_chain(block, chain)) {
         |                    ^
   cc1: some warnings being treated as errors


vim +/tcf_get_next_chain +369 net/sched/sch_api.c

   334	
   335	BPF_CALL_3(bpf_skb_tc_classify, struct sk_buff *, skb, int, ifindex, u32, handle)
   336	{
   337		struct net *net = dev_net(skb->dev);
   338		const struct Qdisc_class_ops *cops;
   339		struct tcf_result res = {};
   340		struct tcf_block *block;
   341		struct tcf_chain *chain;
   342		struct net_device *dev;
   343		unsigned long cl = 0;
   344		struct Qdisc *q;
   345		int result;
   346	
   347		rcu_read_lock();
   348		dev = dev_get_by_index_rcu(net, ifindex);
   349		if (!dev)
   350			goto out;
   351		q = qdisc_lookup_rcu(dev, handle);
   352		if (!q)
   353			goto out;
   354	
   355		cops = q->ops->cl_ops;
   356		if (!cops)
   357			goto out;
   358		if (!cops->tcf_block)
   359			goto out;
   360		if (TC_H_MIN(handle)) {
   361			cl = cops->find(q, handle);
   362			if (cl == 0)
   363				goto out;
   364		}
   365		block = cops->tcf_block(q, cl, NULL);
   366		if (!block)
   367			goto out;
   368	
 > 369		for (chain = tcf_get_next_chain(block, NULL);
   370		     chain;
   371		     chain = tcf_get_next_chain(block, chain)) {
   372			struct tcf_proto *tp;
   373	
   374			result = tcf_classify(skb, NULL, tp, &res, false);
   375			if (result  >= 0) {
   376	#ifdef CONFIG_NET_CLS_ACT
   377				switch (result) {
   378				case TC_ACT_QUEUED:
   379				case TC_ACT_STOLEN:
   380				case TC_ACT_TRAP:
   381					fallthrough;
   382				case TC_ACT_SHOT:
   383					rcu_read_unlock();
   384					return 0;
   385				}
   386	#endif
   387			}
   388		}
   389	out:
   390		rcu_read_unlock();
   391		return res.class;
   392	}
   393	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
