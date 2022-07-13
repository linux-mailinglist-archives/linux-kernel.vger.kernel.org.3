Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E36C1573900
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 16:38:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236104AbiGMOiH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 10:38:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230093AbiGMOiF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 10:38:05 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41EBE39B96
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 07:38:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657723084; x=1689259084;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=f+ISdq4EVcP36sGxQB1wU3oLfvFyxneOjcN96pVNTE4=;
  b=gs2BsBdI6a7hr4fbd2fb/k30Abr8OfeUJFcMR5do7Qu+3r00wLkUMENc
   uVeMJEGcVYyjqSTS1n+7ui9senk8jpZ9xc8lILc+bjQ+BrKPMDeDO/s/7
   6Xej0zmLN/Z+hHvxRf+RVswWTh42ScuZqBFEbII6rbg42mz2NcpX3WXSf
   3P0UqYioGH0QdCtwpB2HI/vke8mvbWBm1ugJ3wLWW2KNAXLdBTkoLQkfa
   oGnRX5HjIDtu4jPSZVbkxfAME32cIrRpMKSJN3YjmKJPekutzfKCfuTX2
   F/vTWq2AAt5gktznJxnyxd76BtqMwBEMFj/NJqg3Th7HK9OsZjbYiHXp7
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10407"; a="265016043"
X-IronPort-AV: E=Sophos;i="5.92,267,1650956400"; 
   d="scan'208";a="265016043"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2022 07:38:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,267,1650956400"; 
   d="scan'208";a="545862128"
Received: from lkp-server02.sh.intel.com (HELO 8708c84be1ad) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 13 Jul 2022 07:38:01 -0700
Received: from kbuild by 8708c84be1ad with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1oBdV3-0003bD-81;
        Wed, 13 Jul 2022 14:38:01 +0000
Date:   Wed, 13 Jul 2022 22:37:32 +0800
From:   kernel test robot <lkp@intel.com>
To:     Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: drivers/net/ethernet/mediatek/mtk_ppe_debugfs.c:60:27: sparse:
 sparse: incorrect type in assignment (different base types)
Message-ID: <202207132213.FoQ1TlEg-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lorenzo,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   b047602d579b4fb028128a525f056bbdc890e7f0
commit: a3c62a042237d1adeb0290dcb768e17edd6dcd25 net: mtk_eth: add COMPILE_TEST support
date:   7 months ago
config: riscv-randconfig-s032-20220713 (https://download.01.org/0day-ci/archive/20220713/202207132213.FoQ1TlEg-lkp@intel.com/config)
compiler: riscv32-linux-gcc (GCC) 11.3.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-39-gce1a6720-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=a3c62a042237d1adeb0290dcb768e17edd6dcd25
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout a3c62a042237d1adeb0290dcb768e17edd6dcd25
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=riscv SHELL=/bin/bash drivers/net/ethernet/mediatek/ net/core/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
>> drivers/net/ethernet/mediatek/mtk_ppe_debugfs.c:60:27: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int @@     got restricted __be32 [usertype] @@
   drivers/net/ethernet/mediatek/mtk_ppe_debugfs.c:60:27: sparse:     expected unsigned int
   drivers/net/ethernet/mediatek/mtk_ppe_debugfs.c:60:27: sparse:     got restricted __be32 [usertype]
>> drivers/net/ethernet/mediatek/mtk_ppe_debugfs.c:158:46: sparse: sparse: cast to restricted __be16
>> drivers/net/ethernet/mediatek/mtk_ppe_debugfs.c:158:46: sparse: sparse: cast to restricted __be16
>> drivers/net/ethernet/mediatek/mtk_ppe_debugfs.c:158:46: sparse: sparse: cast to restricted __be16
>> drivers/net/ethernet/mediatek/mtk_ppe_debugfs.c:158:46: sparse: sparse: cast to restricted __be16
--
>> drivers/net/ethernet/mediatek/mtk_ppe_offload.c:88:19: sparse: sparse: cast to restricted __be32
>> drivers/net/ethernet/mediatek/mtk_ppe_offload.c:88:19: sparse: sparse: cast to restricted __be32
>> drivers/net/ethernet/mediatek/mtk_ppe_offload.c:88:19: sparse: sparse: cast to restricted __be32
>> drivers/net/ethernet/mediatek/mtk_ppe_offload.c:88:19: sparse: sparse: cast to restricted __be32
>> drivers/net/ethernet/mediatek/mtk_ppe_offload.c:88:19: sparse: sparse: cast to restricted __be32
>> drivers/net/ethernet/mediatek/mtk_ppe_offload.c:88:19: sparse: sparse: cast to restricted __be32
>> drivers/net/ethernet/mediatek/mtk_ppe_offload.c:92:41: sparse: sparse: restricted __be32 degrades to integer
--
>> drivers/net/ethernet/mediatek/mtk_eth_soc.c:1113:45: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __sum16 [usertype] check @@     got restricted __be16 [usertype] @@
   drivers/net/ethernet/mediatek/mtk_eth_soc.c:1113:45: sparse:     expected restricted __sum16 [usertype] check
   drivers/net/ethernet/mediatek/mtk_eth_soc.c:1113:45: sparse:     got restricted __be16 [usertype]
>> drivers/net/ethernet/mediatek/mtk_eth_soc.c:1801:22: sparse: sparse: incorrect type in argument 2 (different base types) @@     expected unsigned int [usertype] val @@     got restricted __be32 [usertype] ip @@
   drivers/net/ethernet/mediatek/mtk_eth_soc.c:1801:22: sparse:     expected unsigned int [usertype] val
   drivers/net/ethernet/mediatek/mtk_eth_soc.c:1801:22: sparse:     got restricted __be32 [usertype] ip
>> drivers/net/ethernet/mediatek/mtk_eth_soc.c:1846:40: sparse: sparse: cast from restricted __be32
>> drivers/net/ethernet/mediatek/mtk_eth_soc.c:1846:40: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] val @@     got restricted __be32 [usertype] ip4dst @@
   drivers/net/ethernet/mediatek/mtk_eth_soc.c:1846:40: sparse:     expected unsigned int [usertype] val
   drivers/net/ethernet/mediatek/mtk_eth_soc.c:1846:40: sparse:     got restricted __be32 [usertype] ip4dst
>> drivers/net/ethernet/mediatek/mtk_eth_soc.c:1846:40: sparse: sparse: cast from restricted __be32
>> drivers/net/ethernet/mediatek/mtk_eth_soc.c:1846:40: sparse: sparse: cast from restricted __be32
>> drivers/net/ethernet/mediatek/mtk_eth_soc.c:1846:40: sparse: sparse: cast from restricted __be32
>> drivers/net/ethernet/mediatek/mtk_eth_soc.c:1846:40: sparse: sparse: cast from restricted __be32
>> drivers/net/ethernet/mediatek/mtk_eth_soc.c:1903:38: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __be32 [usertype] ip4dst @@     got unsigned int @@
   drivers/net/ethernet/mediatek/mtk_eth_soc.c:1903:38: sparse:     expected restricted __be32 [usertype] ip4dst
   drivers/net/ethernet/mediatek/mtk_eth_soc.c:1903:38: sparse:     got unsigned int
>> drivers/net/ethernet/mediatek/mtk_eth_soc.c:1907:38: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __be32 [usertype] ip4src @@     got unsigned int @@
   drivers/net/ethernet/mediatek/mtk_eth_soc.c:1907:38: sparse:     expected restricted __be32 [usertype] ip4src
   drivers/net/ethernet/mediatek/mtk_eth_soc.c:1907:38: sparse:     got unsigned int
>> drivers/net/ethernet/mediatek/mtk_eth_soc.c:1909:36: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __be16 [usertype] psrc @@     got int @@
   drivers/net/ethernet/mediatek/mtk_eth_soc.c:1909:36: sparse:     expected restricted __be16 [usertype] psrc
   drivers/net/ethernet/mediatek/mtk_eth_soc.c:1909:36: sparse:     got int
>> drivers/net/ethernet/mediatek/mtk_eth_soc.c:1911:36: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __be16 [usertype] pdst @@     got int @@
   drivers/net/ethernet/mediatek/mtk_eth_soc.c:1911:36: sparse:     expected restricted __be16 [usertype] pdst
   drivers/net/ethernet/mediatek/mtk_eth_soc.c:1911:36: sparse:     got int

vim +60 drivers/net/ethernet/mediatek/mtk_ppe_debugfs.c

ba37b7caf1ed239 Felix Fietkau 2021-03-24   47  
ba37b7caf1ed239 Felix Fietkau 2021-03-24   48  static void
ba37b7caf1ed239 Felix Fietkau 2021-03-24   49  mtk_print_addr(struct seq_file *m, u32 *addr, bool ipv6)
ba37b7caf1ed239 Felix Fietkau 2021-03-24   50  {
ba37b7caf1ed239 Felix Fietkau 2021-03-24   51  	u32 n_addr[4];
ba37b7caf1ed239 Felix Fietkau 2021-03-24   52  	int i;
ba37b7caf1ed239 Felix Fietkau 2021-03-24   53  
ba37b7caf1ed239 Felix Fietkau 2021-03-24   54  	if (!ipv6) {
ba37b7caf1ed239 Felix Fietkau 2021-03-24   55  		seq_printf(m, "%pI4h", addr);
ba37b7caf1ed239 Felix Fietkau 2021-03-24   56  		return;
ba37b7caf1ed239 Felix Fietkau 2021-03-24   57  	}
ba37b7caf1ed239 Felix Fietkau 2021-03-24   58  
ba37b7caf1ed239 Felix Fietkau 2021-03-24   59  	for (i = 0; i < ARRAY_SIZE(n_addr); i++)
ba37b7caf1ed239 Felix Fietkau 2021-03-24  @60  		n_addr[i] = htonl(addr[i]);
ba37b7caf1ed239 Felix Fietkau 2021-03-24   61  	seq_printf(m, "%pI6", n_addr);
ba37b7caf1ed239 Felix Fietkau 2021-03-24   62  }
ba37b7caf1ed239 Felix Fietkau 2021-03-24   63  
ba37b7caf1ed239 Felix Fietkau 2021-03-24   64  static void
ba37b7caf1ed239 Felix Fietkau 2021-03-24   65  mtk_print_addr_info(struct seq_file *m, struct mtk_flow_addr_info *ai)
ba37b7caf1ed239 Felix Fietkau 2021-03-24   66  {
ba37b7caf1ed239 Felix Fietkau 2021-03-24   67  	mtk_print_addr(m, ai->src, ai->ipv6);
ba37b7caf1ed239 Felix Fietkau 2021-03-24   68  	if (ai->src_port)
ba37b7caf1ed239 Felix Fietkau 2021-03-24   69  		seq_printf(m, ":%d", *ai->src_port);
ba37b7caf1ed239 Felix Fietkau 2021-03-24   70  	seq_printf(m, "->");
ba37b7caf1ed239 Felix Fietkau 2021-03-24   71  	mtk_print_addr(m, ai->dest, ai->ipv6);
ba37b7caf1ed239 Felix Fietkau 2021-03-24   72  	if (ai->dest_port)
ba37b7caf1ed239 Felix Fietkau 2021-03-24   73  		seq_printf(m, ":%d", *ai->dest_port);
ba37b7caf1ed239 Felix Fietkau 2021-03-24   74  }
ba37b7caf1ed239 Felix Fietkau 2021-03-24   75  
ba37b7caf1ed239 Felix Fietkau 2021-03-24   76  static int
ba37b7caf1ed239 Felix Fietkau 2021-03-24   77  mtk_ppe_debugfs_foe_show(struct seq_file *m, void *private, bool bind)
ba37b7caf1ed239 Felix Fietkau 2021-03-24   78  {
ba37b7caf1ed239 Felix Fietkau 2021-03-24   79  	struct mtk_ppe *ppe = m->private;
ae8f5867d590866 Qiheng Lin    2021-03-25   80  	int i;
ba37b7caf1ed239 Felix Fietkau 2021-03-24   81  
ae8f5867d590866 Qiheng Lin    2021-03-25   82  	for (i = 0; i < MTK_PPE_ENTRIES; i++) {
ba37b7caf1ed239 Felix Fietkau 2021-03-24   83  		struct mtk_foe_entry *entry = &ppe->foe_table[i];
ba37b7caf1ed239 Felix Fietkau 2021-03-24   84  		struct mtk_foe_mac_info *l2;
ba37b7caf1ed239 Felix Fietkau 2021-03-24   85  		struct mtk_flow_addr_info ai = {};
ba37b7caf1ed239 Felix Fietkau 2021-03-24   86  		unsigned char h_source[ETH_ALEN];
ba37b7caf1ed239 Felix Fietkau 2021-03-24   87  		unsigned char h_dest[ETH_ALEN];
ba37b7caf1ed239 Felix Fietkau 2021-03-24   88  		int type, state;
ba37b7caf1ed239 Felix Fietkau 2021-03-24   89  		u32 ib2;
ba37b7caf1ed239 Felix Fietkau 2021-03-24   90  
ba37b7caf1ed239 Felix Fietkau 2021-03-24   91  
ba37b7caf1ed239 Felix Fietkau 2021-03-24   92  		state = FIELD_GET(MTK_FOE_IB1_STATE, entry->ib1);
ba37b7caf1ed239 Felix Fietkau 2021-03-24   93  		if (!state)
ba37b7caf1ed239 Felix Fietkau 2021-03-24   94  			continue;
ba37b7caf1ed239 Felix Fietkau 2021-03-24   95  
ba37b7caf1ed239 Felix Fietkau 2021-03-24   96  		if (bind && state != MTK_FOE_STATE_BIND)
ba37b7caf1ed239 Felix Fietkau 2021-03-24   97  			continue;
ba37b7caf1ed239 Felix Fietkau 2021-03-24   98  
ba37b7caf1ed239 Felix Fietkau 2021-03-24   99  		type = FIELD_GET(MTK_FOE_IB1_PACKET_TYPE, entry->ib1);
ba37b7caf1ed239 Felix Fietkau 2021-03-24  100  		seq_printf(m, "%05x %s %7s", i,
ba37b7caf1ed239 Felix Fietkau 2021-03-24  101  			   mtk_foe_entry_state_str(state),
ba37b7caf1ed239 Felix Fietkau 2021-03-24  102  			   mtk_foe_pkt_type_str(type));
ba37b7caf1ed239 Felix Fietkau 2021-03-24  103  
ba37b7caf1ed239 Felix Fietkau 2021-03-24  104  		switch (type) {
ba37b7caf1ed239 Felix Fietkau 2021-03-24  105  		case MTK_PPE_PKT_TYPE_IPV4_HNAPT:
ba37b7caf1ed239 Felix Fietkau 2021-03-24  106  		case MTK_PPE_PKT_TYPE_IPV4_DSLITE:
ba37b7caf1ed239 Felix Fietkau 2021-03-24  107  			ai.src_port = &entry->ipv4.orig.src_port;
ba37b7caf1ed239 Felix Fietkau 2021-03-24  108  			ai.dest_port = &entry->ipv4.orig.dest_port;
ba37b7caf1ed239 Felix Fietkau 2021-03-24  109  			fallthrough;
ba37b7caf1ed239 Felix Fietkau 2021-03-24  110  		case MTK_PPE_PKT_TYPE_IPV4_ROUTE:
ba37b7caf1ed239 Felix Fietkau 2021-03-24  111  			ai.src = &entry->ipv4.orig.src_ip;
ba37b7caf1ed239 Felix Fietkau 2021-03-24  112  			ai.dest = &entry->ipv4.orig.dest_ip;
ba37b7caf1ed239 Felix Fietkau 2021-03-24  113  			break;
ba37b7caf1ed239 Felix Fietkau 2021-03-24  114  		case MTK_PPE_PKT_TYPE_IPV6_ROUTE_5T:
ba37b7caf1ed239 Felix Fietkau 2021-03-24  115  			ai.src_port = &entry->ipv6.src_port;
ba37b7caf1ed239 Felix Fietkau 2021-03-24  116  			ai.dest_port = &entry->ipv6.dest_port;
ba37b7caf1ed239 Felix Fietkau 2021-03-24  117  			fallthrough;
ba37b7caf1ed239 Felix Fietkau 2021-03-24  118  		case MTK_PPE_PKT_TYPE_IPV6_ROUTE_3T:
ba37b7caf1ed239 Felix Fietkau 2021-03-24  119  		case MTK_PPE_PKT_TYPE_IPV6_6RD:
ba37b7caf1ed239 Felix Fietkau 2021-03-24  120  			ai.src = &entry->ipv6.src_ip;
ba37b7caf1ed239 Felix Fietkau 2021-03-24  121  			ai.dest = &entry->ipv6.dest_ip;
ba37b7caf1ed239 Felix Fietkau 2021-03-24  122  			ai.ipv6 = true;
ba37b7caf1ed239 Felix Fietkau 2021-03-24  123  			break;
ba37b7caf1ed239 Felix Fietkau 2021-03-24  124  		}
ba37b7caf1ed239 Felix Fietkau 2021-03-24  125  
ba37b7caf1ed239 Felix Fietkau 2021-03-24  126  		seq_printf(m, " orig=");
ba37b7caf1ed239 Felix Fietkau 2021-03-24  127  		mtk_print_addr_info(m, &ai);
ba37b7caf1ed239 Felix Fietkau 2021-03-24  128  
ba37b7caf1ed239 Felix Fietkau 2021-03-24  129  		switch (type) {
ba37b7caf1ed239 Felix Fietkau 2021-03-24  130  		case MTK_PPE_PKT_TYPE_IPV4_HNAPT:
ba37b7caf1ed239 Felix Fietkau 2021-03-24  131  		case MTK_PPE_PKT_TYPE_IPV4_DSLITE:
ba37b7caf1ed239 Felix Fietkau 2021-03-24  132  			ai.src_port = &entry->ipv4.new.src_port;
ba37b7caf1ed239 Felix Fietkau 2021-03-24  133  			ai.dest_port = &entry->ipv4.new.dest_port;
ba37b7caf1ed239 Felix Fietkau 2021-03-24  134  			fallthrough;
ba37b7caf1ed239 Felix Fietkau 2021-03-24  135  		case MTK_PPE_PKT_TYPE_IPV4_ROUTE:
ba37b7caf1ed239 Felix Fietkau 2021-03-24  136  			ai.src = &entry->ipv4.new.src_ip;
ba37b7caf1ed239 Felix Fietkau 2021-03-24  137  			ai.dest = &entry->ipv4.new.dest_ip;
ba37b7caf1ed239 Felix Fietkau 2021-03-24  138  			seq_printf(m, " new=");
ba37b7caf1ed239 Felix Fietkau 2021-03-24  139  			mtk_print_addr_info(m, &ai);
ba37b7caf1ed239 Felix Fietkau 2021-03-24  140  			break;
ba37b7caf1ed239 Felix Fietkau 2021-03-24  141  		}
ba37b7caf1ed239 Felix Fietkau 2021-03-24  142  
ba37b7caf1ed239 Felix Fietkau 2021-03-24  143  		if (type >= MTK_PPE_PKT_TYPE_IPV4_DSLITE) {
ba37b7caf1ed239 Felix Fietkau 2021-03-24  144  			l2 = &entry->ipv6.l2;
ba37b7caf1ed239 Felix Fietkau 2021-03-24  145  			ib2 = entry->ipv6.ib2;
ba37b7caf1ed239 Felix Fietkau 2021-03-24  146  		} else {
ba37b7caf1ed239 Felix Fietkau 2021-03-24  147  			l2 = &entry->ipv4.l2;
ba37b7caf1ed239 Felix Fietkau 2021-03-24  148  			ib2 = entry->ipv4.ib2;
ba37b7caf1ed239 Felix Fietkau 2021-03-24  149  		}
ba37b7caf1ed239 Felix Fietkau 2021-03-24  150  
ba37b7caf1ed239 Felix Fietkau 2021-03-24  151  		*((__be32 *)h_source) = htonl(l2->src_mac_hi);
ba37b7caf1ed239 Felix Fietkau 2021-03-24  152  		*((__be16 *)&h_source[4]) = htons(l2->src_mac_lo);
ba37b7caf1ed239 Felix Fietkau 2021-03-24  153  		*((__be32 *)h_dest) = htonl(l2->dest_mac_hi);
ba37b7caf1ed239 Felix Fietkau 2021-03-24  154  		*((__be16 *)&h_dest[4]) = htons(l2->dest_mac_lo);
ba37b7caf1ed239 Felix Fietkau 2021-03-24  155  
ba37b7caf1ed239 Felix Fietkau 2021-03-24  156  		seq_printf(m, " eth=%pM->%pM etype=%04x"
ba37b7caf1ed239 Felix Fietkau 2021-03-24  157  			      " vlan=%d,%d ib1=%08x ib2=%08x\n",
ba37b7caf1ed239 Felix Fietkau 2021-03-24 @158  			   h_source, h_dest, ntohs(l2->etype),
ba37b7caf1ed239 Felix Fietkau 2021-03-24  159  			   l2->vlan1, l2->vlan2, entry->ib1, ib2);
ba37b7caf1ed239 Felix Fietkau 2021-03-24  160  	}
ba37b7caf1ed239 Felix Fietkau 2021-03-24  161  
ba37b7caf1ed239 Felix Fietkau 2021-03-24  162  	return 0;
ba37b7caf1ed239 Felix Fietkau 2021-03-24  163  }
ba37b7caf1ed239 Felix Fietkau 2021-03-24  164  

:::::: The code at line 60 was first introduced by commit
:::::: ba37b7caf1ed2395cc84d8f823ff933975f1f789 net: ethernet: mtk_eth_soc: add support for initializing the PPE

:::::: TO: Felix Fietkau <nbd@nbd.name>
:::::: CC: David S. Miller <davem@davemloft.net>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
