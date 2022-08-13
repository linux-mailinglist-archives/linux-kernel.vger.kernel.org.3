Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06CC7591D29
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Aug 2022 01:42:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239823AbiHMXli (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Aug 2022 19:41:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229870AbiHMXlg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Aug 2022 19:41:36 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C88058B982
        for <linux-kernel@vger.kernel.org>; Sat, 13 Aug 2022 16:41:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660434095; x=1691970095;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=BtKy7399i2D8mcG/xZ6wAq1j27q7DKlirfoZDR6Ngiw=;
  b=CQ2qhqiSv14yKZcijNEfoz/RKJk6kumfPr7fMIQR6zVR5Yr/X4fURGO5
   8DmoIQIWA98M/LQfPGwJi/BIUpy/lxzlEDJIyd4+vIQtStCOz6pgdTjfv
   47LfxQhUsXTSrPvAxhfrrmz7IRM77cti5cYz4tGjZ1f8uZ7eQPRiS3DLX
   DLn9J5vCqSNsCzuw1dLoo/L6/isag08NKZg/3yYMyBFdrCSzhv0FrRF9P
   LWefB9X/FMOUxHLso+zXhP8nTd6NwnAFjPdVXzzcyloxECh0T9Sct4byv
   kDMkYU7sVLgTicuLmsJC4UDj7XMyzLF7YIvyDBDSUehkplChAZbpZ6bDo
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10437"; a="292579383"
X-IronPort-AV: E=Sophos;i="5.93,236,1654585200"; 
   d="scan'208";a="292579383"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2022 16:41:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,236,1654585200"; 
   d="scan'208";a="556897883"
Received: from lkp-server02.sh.intel.com (HELO 8745164cafc7) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 13 Aug 2022 16:41:33 -0700
Received: from kbuild by 8745164cafc7 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oN0l3-0002CN-0g;
        Sat, 13 Aug 2022 23:41:33 +0000
Date:   Sun, 14 Aug 2022 07:40:43 +0800
From:   kernel test robot <lkp@intel.com>
To:     Eric Dumazet <edumazet@google.com>
Cc:     kbuild-all@lists.01.org, Ammar Faizi <ammarfaizi2@gnuweeb.org>,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org, Sasha Levin <sashal@kernel.org>
Subject: [ammarfaizi2-block:stable/linux-stable-rc/queue/5.19 369/1034]
 net/ipv6/raw.c:338:40: warning: variable 'daddr' set but not used
Message-ID: <202208140715.Z91crNte-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ammarfaizi2/linux-block stable/linux-stable-rc/queue/5.19
head:   a93eab25d54766b1d89d7fa7dd315b3fc268d0b5
commit: 097153d36084aaae5c40688aa5a424ac8d9cca5f [369/1034] raw: use more conventional iterators
config: i386-defconfig (https://download.01.org/0day-ci/archive/20220814/202208140715.Z91crNte-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-3) 11.3.0
reproduce (this is a W=1 build):
        # https://github.com/ammarfaizi2/linux-block/commit/097153d36084aaae5c40688aa5a424ac8d9cca5f
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block stable/linux-stable-rc/queue/5.19
        git checkout 097153d36084aaae5c40688aa5a424ac8d9cca5f
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash net/ipv6/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   net/ipv6/raw.c: In function 'raw6_icmp_error':
>> net/ipv6/raw.c:338:40: warning: variable 'daddr' set but not used [-Wunused-but-set-variable]
     338 |         const struct in6_addr *saddr, *daddr;
         |                                        ^~~~~
>> net/ipv6/raw.c:338:32: warning: variable 'saddr' set but not used [-Wunused-but-set-variable]
     338 |         const struct in6_addr *saddr, *daddr;
         |                                ^~~~~


vim +/daddr +338 net/ipv6/raw.c

   334	
   335	void raw6_icmp_error(struct sk_buff *skb, int nexthdr,
   336			u8 type, u8 code, int inner_offset, __be32 info)
   337	{
 > 338		const struct in6_addr *saddr, *daddr;
   339		struct net *net = dev_net(skb->dev);
   340		struct hlist_head *head;
   341		struct sock *sk;
   342		int hash;
   343	
   344		hash = nexthdr & (RAW_HTABLE_SIZE - 1);
   345		head = &raw_v6_hashinfo.ht[hash];
   346		read_lock(&raw_v6_hashinfo.lock);
   347		sk_for_each(sk, head) {
   348			/* Note: ipv6_hdr(skb) != skb->data */
   349			const struct ipv6hdr *ip6h = (const struct ipv6hdr *)skb->data;
   350			saddr = &ip6h->saddr;
   351			daddr = &ip6h->daddr;
   352	
   353			if (!raw_v6_match(net, sk, nexthdr, &ip6h->saddr, &ip6h->daddr,
   354					  inet6_iif(skb), inet6_iif(skb)))
   355				continue;
   356			rawv6_err(sk, skb, NULL, type, code, inner_offset, info);
   357		}
   358		read_unlock(&raw_v6_hashinfo.lock);
   359	}
   360	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
