Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A25C54B185D
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 23:40:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345053AbiBJWk2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 17:40:28 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:58688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345032AbiBJWkZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 17:40:25 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC7AC26F3
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 14:40:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644532824; x=1676068824;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=ezk2NeDdSc2e0TnIa0ixhn44aPSqO9eSdI6KS3XUWsc=;
  b=EfqQF+u7kYcfTFbHdZpzaqq7gSCbS/OKXCjMAgmEI5SHfBoJh3EWVIwr
   9R9tzzMTEgFH057gYLkdKxu8zDdudEvg80gorM6qspLoY/G6L5WEzjbMw
   DENz2VL5AaWjShz/lr2IG/L9FOY1BQM6hDPOfoIw1/GHKvGJhHst+WmoA
   8nLgA9OcY/VIsgr6/vMUXwfLFw2Y0Y48IKq/En0DZhyYTA1o1z6cKPFmJ
   r88TUqK05dalrGMwyzPzruGzLLgZJLYvNTZ0Q2lWINzbv4jTCagaN5gzc
   YXGS9abMPT+fePv9lPDB7pi2Yb4AM3A2f7s1EJNmuQFiySUlyyyTMYXHg
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10254"; a="247196603"
X-IronPort-AV: E=Sophos;i="5.88,359,1635231600"; 
   d="scan'208";a="247196603"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2022 14:40:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,359,1635231600"; 
   d="scan'208";a="526706517"
Received: from lkp-server01.sh.intel.com (HELO d95dc2dabeb1) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 10 Feb 2022 14:40:22 -0800
Received: from kbuild by d95dc2dabeb1 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nII6q-0003qn-6G; Thu, 10 Feb 2022 22:40:16 +0000
Date:   Fri, 11 Feb 2022 06:39:39 +0800
From:   kernel test robot <lkp@intel.com>
To:     Nikolay Aleksandrov <nikolay@nvidia.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: net/bridge/br_private.h:901 br_multicast_rport_from_node_skb() warn:
 inconsistent indenting
Message-ID: <202202110618.ujwjrHxI-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   e3c85076d7a6f986445b9008be7e7f83d1b0780a
commit: 9632233e7de8da43711bb7cd3e054af32fedcc38 net: bridge: multicast: factor out port multicast context
date:   7 months ago
config: openrisc-randconfig-m031-20220210 (https://download.01.org/0day-ci/archive/20220211/202202110618.ujwjrHxI-lkp@intel.com/config)
compiler: or1k-linux-gcc (GCC) 11.2.0

If you fix the issue, kindly add following tag as appropriate
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

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
