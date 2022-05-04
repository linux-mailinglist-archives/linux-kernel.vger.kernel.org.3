Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6FA5519768
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 08:34:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344971AbiEDGhh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 02:37:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238996AbiEDGhf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 02:37:35 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 729D326D5
        for <linux-kernel@vger.kernel.org>; Tue,  3 May 2022 23:34:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651646040; x=1683182040;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=TwHQSjU1r77aWxN/rt0iMIRTOmxL1JDibeYx3vm4ORg=;
  b=esf6O78eksAhqHEKyogm9tMZjI4U8zuq/2QnlREof0RM+KkXhzEE/emZ
   xbMtH3MG7BMRKHQuV0ZoEpDf9CP4s5/w8R2m4W3kp8NwTm/a/bGRNDnHA
   e4jKtFzM6AgLScO/eKkyNBrnvjOEctW9IezfM1TO+aaN4sDPoLt4+/e/E
   sDOhgAafHWt2vPhKk1+Xu1MBDWcUi6nG5fPqhW3Bk+ZaDMClKoi5IlfJb
   DAUzV91mbABGC9Kk8X8h3NalwhemnyEY9XFwXXcSXM8aERVV8rNJpRgNQ
   7lZd1axric0J1u1MKEy9hfL2M49s/JaVokPvKQRu0rWq84m8qkKj34BnJ
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10336"; a="247588003"
X-IronPort-AV: E=Sophos;i="5.91,197,1647327600"; 
   d="scan'208";a="247588003"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 May 2022 23:31:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,197,1647327600"; 
   d="scan'208";a="536692166"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 03 May 2022 23:31:53 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nm8YC-000B8d-B8;
        Wed, 04 May 2022 06:31:52 +0000
Date:   Wed, 4 May 2022 14:31:06 +0800
From:   kernel test robot <lkp@intel.com>
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [lunn:v5.18-rc4-stacked-bridges 2/2] net/bridge/br_input.c:45:12:
 error: 'struct sk_buff' has no member named 'offload_fwd_mark'
Message-ID: <202205041457.Jo1Z7eif-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/lunn/linux.git v5.18-rc4-stacked-bridges
head:   eab6004bc4f6b012db3b6e1fac75f4911662baf5
commit: eab6004bc4f6b012db3b6e1fac75f4911662baf5 [2/2] net: bridge: Clear offload_fwd_mark when passing frame up bridge interface.
config: m68k-randconfig-r031-20220501 (https://download.01.org/0day-ci/archive/20220504/202205041457.Jo1Z7eif-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/lunn/linux/commit/eab6004bc4f6b012db3b6e1fac75f4911662baf5
        git remote add lunn https://github.com/lunn/linux.git
        git fetch --no-tags lunn v5.18-rc4-stacked-bridges
        git checkout eab6004bc4f6b012db3b6e1fac75f4911662baf5
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=m68k SHELL=/bin/bash net/bridge/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   net/bridge/br_input.c: In function 'br_pass_frame_up':
>> net/bridge/br_input.c:45:12: error: 'struct sk_buff' has no member named 'offload_fwd_mark'
      45 |         skb->offload_fwd_mark = false;
         |            ^~


vim +45 net/bridge/br_input.c

    32	
    33	static int br_pass_frame_up(struct sk_buff *skb)
    34	{
    35		struct net_device *indev, *brdev = BR_INPUT_SKB_CB(skb)->brdev;
    36		struct net_bridge *br = netdev_priv(brdev);
    37		struct net_bridge_vlan_group *vg;
    38	
    39		dev_sw_netstats_rx_add(brdev, skb->len);
    40	
    41		vg = br_vlan_group_rcu(br);
    42	
    43		/* Reset the offload_fwd_mark because there could be a stacked bridge
    44		 * above. */
  > 45		skb->offload_fwd_mark = false;
    46	
    47		/* Bridge is just like any other port.  Make sure the
    48		 * packet is allowed except in promisc mode when someone
    49		 * may be running packet capture.
    50		 */
    51		if (!(brdev->flags & IFF_PROMISC) &&
    52		    !br_allowed_egress(vg, skb)) {
    53			kfree_skb(skb);
    54			return NET_RX_DROP;
    55		}
    56	
    57		indev = skb->dev;
    58		skb->dev = brdev;
    59		skb = br_handle_vlan(br, NULL, vg, skb);
    60		if (!skb)
    61			return NET_RX_DROP;
    62		/* update the multicast stats if the packet is IGMP/MLD */
    63		br_multicast_count(br, NULL, skb, br_multicast_igmp_type(skb),
    64				   BR_MCAST_DIR_TX);
    65	
    66		return NF_HOOK(NFPROTO_BRIDGE, NF_BR_LOCAL_IN,
    67			       dev_net(indev), NULL, skb, indev, NULL,
    68			       br_netif_receive_skb);
    69	}
    70	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
