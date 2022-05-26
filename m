Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4550F534FDE
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 15:21:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347517AbiEZNVQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 09:21:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238733AbiEZNVN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 09:21:13 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EE1E110
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 06:21:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653571269; x=1685107269;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=eVyO1IsIdralPqpLu+kCq5/IiitwqBpeF+FcSSLsc6Y=;
  b=UfqztTpJSpnLXQcnMHTkbjM2XcdOpx28VGPDSKxpwhD+ePIx87Dub38N
   I12hKK+NyTuw6S9J0lZcRsQ2nGbQkZWfpKlr/HDBZnw4werSomSwfPaMV
   tKcIFRA1Zv+r6u7hwwp+Fa0V4YAnkZ7qcfl8PUUdfc4OVEyanM+maNHGv
   Zs17uE8Bmn0hWrJk1081O/8LOix1slu2j4x3JFR+X8bxC0aALcd1G/H3I
   wuVp+Jp7cj2NhR9zd9lUPOug29qss1yZaNoYG37+D3pbigwK2Nddq6ok7
   oi9aZxrBxKbg7UD0qw8cRRu9Sr+MCVPXgoYQIn5JER4fwJTbQiFFDjBQE
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10358"; a="274156664"
X-IronPort-AV: E=Sophos;i="5.91,252,1647327600"; 
   d="scan'208";a="274156664"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2022 06:21:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,252,1647327600"; 
   d="scan'208";a="609688137"
Received: from lkp-server01.sh.intel.com (HELO db63a1be7222) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 26 May 2022 06:21:07 -0700
Received: from kbuild by db63a1be7222 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nuDQI-0003tO-Pk;
        Thu, 26 May 2022 13:21:06 +0000
Date:   Thu, 26 May 2022 21:20:37 +0800
From:   kernel test robot <lkp@intel.com>
To:     Vladimir Oltean <vladimir.oltean@nxp.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        0day robot <lkp@intel.com>
Subject: include/linux/netdevice.h:2339:16: error: 'const struct sk_buff' has
 no member named 'use_ipv'
Message-ID: <202205262147.gC3FSeHN-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/intel-lab-lkp/linux/commits/UPDATE-20220526-173254/Vladimir-Oltean/selftests-forwarding-add-Per-Stream-Filtering-and-Policing-test-for-Ocelot/20220501-193132
head:   32b52188919f424bfabe1d3c0921ff854fb7f4ee
commit: 32b52188919f424bfabe1d3c0921ff854fb7f4ee selftests: forwarding: add Per-Stream Filtering and Policing test for Ocelot
date:   4 hours ago
config: mips-allmodconfig (https://download.01.org/0day-ci/archive/20220526/202205262147.gC3FSeHN-lkp@intel.com/config)
compiler: mips-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/32b52188919f424bfabe1d3c0921ff854fb7f4ee
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review UPDATE-20220526-173254/Vladimir-Oltean/selftests-forwarding-add-Per-Stream-Filtering-and-Policing-test-for-Ocelot/20220501-193132
        git checkout 32b52188919f424bfabe1d3c0921ff854fb7f4ee
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=mips SHELL=/bin/bash drivers/net/wireless/st/cw1200/ net/sched/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from include/linux/rtnetlink.h:7,
                    from net/sched/act_police.c:15:
   include/linux/netdevice.h: In function 'skb_get_prio_tc_map':
>> include/linux/netdevice.h:2339:16: error: 'const struct sk_buff' has no member named 'use_ipv'
    2339 |         if (skb->use_ipv)
         |                ^~
>> include/linux/netdevice.h:2340:27: error: 'const struct sk_buff' has no member named 'ipv'
    2340 |                 prio = skb->ipv;
         |                           ^~
--
   In file included from include/linux/rtnetlink.h:7,
                    from net/sched/act_gate.c:10:
   include/linux/netdevice.h: In function 'skb_get_prio_tc_map':
>> include/linux/netdevice.h:2339:16: error: 'const struct sk_buff' has no member named 'use_ipv'
    2339 |         if (skb->use_ipv)
         |                ^~
>> include/linux/netdevice.h:2340:27: error: 'const struct sk_buff' has no member named 'ipv'
    2340 |                 prio = skb->ipv;
         |                           ^~
   net/sched/act_gate.c: In function 'tcf_gate_act':
>> net/sched/act_gate.c:145:20: error: 'struct sk_buff' has no member named 'use_ipv'
     145 |                 skb->use_ipv = true;
         |                    ^~
>> net/sched/act_gate.c:146:20: error: 'struct sk_buff' has no member named 'ipv'
     146 |                 skb->ipv = gact->current_ipv;
         |                    ^~


vim +2339 include/linux/netdevice.h

  2332	
  2333	static inline int skb_get_prio_tc_map(const struct sk_buff *skb,
  2334					      const struct net_device *dev)
  2335	{
  2336		__u32 prio = skb->priority;
  2337	
  2338	#if IS_ENABLED(CONFIG_NET_ACT_GATE)
> 2339		if (skb->use_ipv)
> 2340			prio = skb->ipv;
  2341	#endif
  2342	
  2343		return netdev_get_prio_tc_map(dev, prio);
  2344	}
  2345	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
