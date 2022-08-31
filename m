Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 773F15A88DB
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 00:14:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230410AbiHaWOs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 18:14:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229916AbiHaWOq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 18:14:46 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FC09D137
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 15:14:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661984084; x=1693520084;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=RjferLJbdvjk+ohIuhPzJJMJTOgj6+5o48F0bGgHWrs=;
  b=Kp5n5J30I2c9CCU+u0PYhhZSVxiuaXHjE79fWYRRConAMBcszDV9eLsJ
   fRInEPE9mNqiUHWR6vrD+LvRTtNRHZ+sKBNZ9DuZLcOhu2NzAz2v84NBG
   Srr3zr1+FbvI2BacQfEN3aaok8/AhUKB6QViZSI7GM1btCVv3bbOj/KdY
   v6i82h1Qb6A3cDRgtAH2n/ws0c0BF95C+km0t2l3eFjWpQW5sHCcaLP4n
   RMIMnz24GewpHGyBYbBm5Lg4Sr2aOUovRo9ud20qzoyGZVrqMEXsBeri+
   RRQuHjddESwWc9CFzc9r0FO5VkOxtOo9iL/DiqO8KYm22ZBzuWp/yTinX
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10456"; a="293133757"
X-IronPort-AV: E=Sophos;i="5.93,279,1654585200"; 
   d="scan'208";a="293133757"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2022 15:14:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,279,1654585200"; 
   d="scan'208";a="589200578"
Received: from lkp-server02.sh.intel.com (HELO 811e2ceaf0e5) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 31 Aug 2022 15:14:31 -0700
Received: from kbuild by 811e2ceaf0e5 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oTVyg-0000la-26;
        Wed, 31 Aug 2022 22:14:30 +0000
Date:   Thu, 1 Sep 2022 06:13:59 +0800
From:   kernel test robot <lkp@intel.com>
To:     Nikolay Aleksandrov <nikolay@nvidia.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: net/bridge/br_private.h:901 br_multicast_rport_from_node_skb() warn:
 inconsistent indenting
Message-ID: <202209010637.UHbMVYHc-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nikolay,

FYI, the error/warning was bisected to this commit, please ignore it if it's irrelevant.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   c5e4d5e99162ba8025d58a3af7ad103f155d2df7
commit: 9632233e7de8da43711bb7cd3e054af32fedcc38 net: bridge: multicast: factor out port multicast context
date:   1 year, 1 month ago
config: riscv-randconfig-m041-20220831 (https://download.01.org/0day-ci/archive/20220901/202209010637.UHbMVYHc-lkp@intel.com/config)
compiler: riscv64-linux-gcc (GCC) 12.1.0

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

New smatch warnings:
net/bridge/br_private.h:901 br_multicast_rport_from_node_skb() warn: inconsistent indenting

Old smatch warnings:
net/bridge/br_forward.c:317 br_multicast_flood() error: we previously assumed 'p' could be null (see line 293)

vim +901 net/bridge/br_private.h

   890	
   891	static inline struct net_bridge_port *
   892	br_multicast_rport_from_node_skb(struct hlist_node *rp, struct sk_buff *skb) {
   893		struct net_bridge_mcast_port *mctx;
   894	
   895	#if IS_ENABLED(CONFIG_IPV6)
   896		if (skb->protocol == htons(ETH_P_IPV6))
   897			mctx = hlist_entry_safe(rp, struct net_bridge_mcast_port,
   898						ip6_rlist);
   899		else
   900	#endif
 > 901			mctx = hlist_entry_safe(rp, struct net_bridge_mcast_port,
   902						ip4_rlist);
   903	
   904		if (mctx)
   905			return mctx->port;
   906		else
   907			return NULL;
   908	}
   909	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
