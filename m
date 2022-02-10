Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58FEC4B039D
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 03:55:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231811AbiBJCz0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 21:55:26 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:58134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229765AbiBJCzV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 21:55:21 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A9C82409C
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 18:55:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644461724; x=1675997724;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=iDfWGlHTAn8lrs/k4FQdMghrl98b7boV7KEbgB7lnR0=;
  b=KWk157ucPQPt/OXYSYoobsHIMzBlPFpU4MxXO/ph63aOsYodlLOuvm1F
   wWeUJ+GleSJ/fMtS5rB5B7LLj/EicCmJMtN/oeTLCQgyNeBfMbm9PB3V+
   jSWCCQRpeVQZZ9DuiPtnVVuyg/IQIXCGfCHks5pwwj1XWORnv7WwCApaP
   BKJ3d8cbDN5zXnNsDm2A+w86HK3mwGKT6GkHGr6KiD25FGk5R2rvBSdjA
   wRz7d7AR/7sLfXr51tYGmtL+S6d1lY06N8aBCRLACg965093wKouWHT7h
   tiu9C/GfZ+m5z3b6RstrxU3GiY1F5ev1uZ/ZKrp1eM4OUK5Fhx0q6vHRr
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10253"; a="232961804"
X-IronPort-AV: E=Sophos;i="5.88,357,1635231600"; 
   d="scan'208";a="232961804"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2022 18:53:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,357,1635231600"; 
   d="scan'208";a="633479230"
Received: from lkp-server01.sh.intel.com (HELO d95dc2dabeb1) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 09 Feb 2022 18:53:22 -0800
Received: from kbuild by d95dc2dabeb1 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nHzaD-0002bY-Rz; Thu, 10 Feb 2022 02:53:21 +0000
Date:   Thu, 10 Feb 2022 10:53:16 +0800
From:   kernel test robot <lkp@intel.com>
To:     Nikolay Aleksandrov <nikolay@nvidia.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: net/bridge/br_private.h:901 br_multicast_rport_from_node_skb() warn:
 inconsistent indenting
Message-ID: <202202101038.9QptdYTn-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   f4bc5bbb5fef3cf421ba3485d6d383c27ec473ed
commit: 9632233e7de8da43711bb7cd3e054af32fedcc38 net: bridge: multicast: factor out port multicast context
date:   7 months ago
config: openrisc-randconfig-m031-20220210 (https://download.01.org/0day-ci/archive/20220210/202202101038.9QptdYTn-lkp@intel.com/config)
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
