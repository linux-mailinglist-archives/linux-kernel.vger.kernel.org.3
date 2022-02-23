Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E14A4C1D55
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 21:50:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241685AbiBWUuV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 15:50:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236471AbiBWUuS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 15:50:18 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DDDD48E5D
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 12:49:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645649390; x=1677185390;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=CfN0XEMsU5/qod2CtJNDeIwiwGBSjbl6ma6LIKdrH4E=;
  b=WzdzSkvVdrRHZnHEzp4az3HUnAPqKHjw5mmd+VE20YXbt9gjwLPqdM8J
   GSnOthZP1c31IK2J4I//WC9FWRoFAg6JCkC0DdhxtGuxBS7VoICNNfFCs
   yoEJFTJxybPeaIQLFUdgMsJ7arsXcF3dWcFgWIQw4U/oEvDVgWPhtyKAC
   P490w6+I7Kn1IkzXRMXVfd4xhPX8C6zMR+OH6VE8VnYfsedrcHrZjba7s
   p5Bs7+UJ74niousQVy4PjYPQbo7sTpZaTmwN8dMWIR7JN7SxlrD52Z8xX
   mSo7Z+rn8ST/raBybFLraIykf4tjsexbCDu2y9pXesyZfU+HMdnl52nwN
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10267"; a="276699725"
X-IronPort-AV: E=Sophos;i="5.88,391,1635231600"; 
   d="scan'208";a="276699725"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2022 12:49:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,391,1635231600"; 
   d="scan'208";a="506065753"
Received: from lkp-server01.sh.intel.com (HELO 788b1cd46f0d) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 23 Feb 2022 12:49:48 -0800
Received: from kbuild by 788b1cd46f0d with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nMya3-0001pA-Qp; Wed, 23 Feb 2022 20:49:47 +0000
Date:   Thu, 24 Feb 2022 04:48:53 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [mingo-tip:sched/headers 2133/2340] net/dsa/tag_lan9303.c:94:3:
 error: implicit declaration of function 'skb_push_rcsum'
Message-ID: <202202240411.5lMVIT5k-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git sched/headers
head:   97c5eeb4de3ad324ed2a4656b46465299cfd010a
commit: 2ac0ad655704cc7c3109124f8ef6427a09d7b623 [2133/2340] headers/deps: net: Optimize <linux/skbuff_api.h> dependencies, remove <net/checksum.h> inclusion
config: i386-randconfig-a013 (https://download.01.org/0day-ci/archive/20220224/202202240411.5lMVIT5k-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project d271fc04d5b97b12e6b797c6067d3c96a8d7470e)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git/commit/?id=2ac0ad655704cc7c3109124f8ef6427a09d7b623
        git remote add mingo-tip git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git
        git fetch --no-tags mingo-tip sched/headers
        git checkout 2ac0ad655704cc7c3109124f8ef6427a09d7b623
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash net/dsa/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

Note: the mingo-tip/sched/headers HEAD 97c5eeb4de3ad324ed2a4656b46465299cfd010a builds fine.
      It only hurts bisectability.

All errors (new ones prefixed by >>):

>> net/dsa/tag_lan9303.c:94:3: error: implicit declaration of function 'skb_push_rcsum' [-Werror,-Wimplicit-function-declaration]
                   skb_push_rcsum(skb, ETH_HLEN);
                   ^
   net/dsa/tag_lan9303.c:94:3: note: did you mean 'skb_pull_rcsum'?
   include/linux/skbuff_api.h:2026:7: note: 'skb_pull_rcsum' declared here
   void *skb_pull_rcsum(struct sk_buff *skb, unsigned int len);
         ^
   1 error generated.


vim +/skb_push_rcsum +94 net/dsa/tag_lan9303.c

e8fe177a62feaf Juergen Beisert 2017-04-18   78  
29a097b7747725 Vladimir Oltean 2021-07-31   79  static struct sk_buff *lan9303_rcv(struct sk_buff *skb, struct net_device *dev)
e8fe177a62feaf Juergen Beisert 2017-04-18   80  {
1a48fbd9ec1483 Egil Hjelmeland 2017-11-13   81  	u16 lan9303_tag1;
e8fe177a62feaf Juergen Beisert 2017-04-18   82  	unsigned int source_port;
e8fe177a62feaf Juergen Beisert 2017-04-18   83  
e8fe177a62feaf Juergen Beisert 2017-04-18   84  	if (unlikely(!pskb_may_pull(skb, LAN9303_TAG_LEN))) {
e8fe177a62feaf Juergen Beisert 2017-04-18   85  		dev_warn_ratelimited(&dev->dev,
e8fe177a62feaf Juergen Beisert 2017-04-18   86  				     "Dropping packet, cannot pull\n");
e8fe177a62feaf Juergen Beisert 2017-04-18   87  		return NULL;
e8fe177a62feaf Juergen Beisert 2017-04-18   88  	}
e8fe177a62feaf Juergen Beisert 2017-04-18   89  
017b355bbdc662 Mans Rullgard   2022-02-16   90  	if (skb_vlan_tag_present(skb)) {
017b355bbdc662 Mans Rullgard   2022-02-16   91  		lan9303_tag1 = skb_vlan_tag_get(skb);
017b355bbdc662 Mans Rullgard   2022-02-16   92  		__vlan_hwaccel_clear_tag(skb);
017b355bbdc662 Mans Rullgard   2022-02-16   93  	} else {
017b355bbdc662 Mans Rullgard   2022-02-16  @94  		skb_push_rcsum(skb, ETH_HLEN);
017b355bbdc662 Mans Rullgard   2022-02-16   95  		__skb_vlan_pop(skb, &lan9303_tag1);
017b355bbdc662 Mans Rullgard   2022-02-16   96  		skb_pull_rcsum(skb, ETH_HLEN);
e8fe177a62feaf Juergen Beisert 2017-04-18   97  	}
e8fe177a62feaf Juergen Beisert 2017-04-18   98  
1a48fbd9ec1483 Egil Hjelmeland 2017-11-13   99  	source_port = lan9303_tag1 & 0x3;
e8fe177a62feaf Juergen Beisert 2017-04-18  100  
2231c43b560403 Vivien Didelot  2017-10-16  101  	skb->dev = dsa_master_find_slave(dev, 0, source_port);
3775b1b7f0c330 Vivien Didelot  2017-09-29  102  	if (!skb->dev) {
e8fe177a62feaf Juergen Beisert 2017-04-18  103  		dev_warn_ratelimited(&dev->dev, "Dropping packet due to invalid source port\n");
e8fe177a62feaf Juergen Beisert 2017-04-18  104  		return NULL;
e8fe177a62feaf Juergen Beisert 2017-04-18  105  	}
e8fe177a62feaf Juergen Beisert 2017-04-18  106  
bea7907837c57a Vladimir Oltean 2021-07-29  107  	if (!(lan9303_tag1 & LAN9303_TAG_RX_TRAPPED_TO_CPU))
bea7907837c57a Vladimir Oltean 2021-07-29  108  		dsa_default_offload_fwd_mark(skb);
4672cd36053e4a Egil Hjelmeland 2017-11-10  109  
e8fe177a62feaf Juergen Beisert 2017-04-18  110  	return skb;
e8fe177a62feaf Juergen Beisert 2017-04-18  111  }
e8fe177a62feaf Juergen Beisert 2017-04-18  112  

:::::: The code at line 94 was first introduced by commit
:::::: 017b355bbdc6620fd8fe05fe297f553ce9d855ee net: dsa: lan9303: handle hwaccel VLAN tags

:::::: TO: Mans Rullgard <mans@mansr.com>
:::::: CC: Jakub Kicinski <kuba@kernel.org>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
