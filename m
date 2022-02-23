Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 081A14C1CD3
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 21:07:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237333AbiBWUIS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 15:08:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229842AbiBWUIQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 15:08:16 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39BB0488AA
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 12:07:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645646868; x=1677182868;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=0yDuDUtYkUYxpptBDI0BNASkVm09UHYe7zxy9Eu8ksg=;
  b=kJrgqScvvXtTImivSE/W5SFgkT/qUy8sYrmD+tLrzNtdVvRz3IZDkJLP
   a0/8bkbSzWfpV7endscn7T6uP1GIQEarEcBWrHCDcX4ztf+MwG2hIQEVw
   8xPVSp0ZPglELWLDZMHIB9c7Y4djg8vA7EthD/4euHgnBctUUUFrcmTQ3
   NmoEVvnJr5br2HrlgtwbBVhZ68J6v+IDRJ+Yl8ZWvQnwB0Su5uyh/qTlW
   0Np+X1PR924mCnFokl3hbgPl8/dWa6VOaIbDnNI5Q4vMrHAeGqFyjFE+F
   SymOzsI4L874y6SysQ3xhVuwt6ia2AXgwX///NAwUMbfYJUyU81CfzQEF
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10267"; a="232691720"
X-IronPort-AV: E=Sophos;i="5.88,391,1635231600"; 
   d="scan'208";a="232691720"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2022 12:07:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,391,1635231600"; 
   d="scan'208";a="532828002"
Received: from lkp-server01.sh.intel.com (HELO 788b1cd46f0d) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 23 Feb 2022 12:07:46 -0800
Received: from kbuild by 788b1cd46f0d with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nMxvN-0001mU-P4; Wed, 23 Feb 2022 20:07:45 +0000
Date:   Thu, 24 Feb 2022 04:07:31 +0800
From:   kernel test robot <lkp@intel.com>
To:     Felix Fietkau <nbd@nbd.name>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [nbd168-wireless:mtk-flow-offload 15/15]
 drivers/net/ethernet/mediatek/mtk_ppe.c:650:33: error: 'struct net_device'
 has no member named 'dsa_ptr'; did you mean 'dn_ptr'?
Message-ID: <202202240458.daZyVdyc-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/nbd168/wireless mtk-flow-offload
head:   4dded169141416b3248146f545378f36cca6bd03
commit: 4dded169141416b3248146f545378f36cca6bd03 [15/15] net: ethernet: mtk_eth_soc: support creating mac address based offload entries
config: m68k-randconfig-r004-20220223 (https://download.01.org/0day-ci/archive/20220224/202202240458.daZyVdyc-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/nbd168/wireless/commit/4dded169141416b3248146f545378f36cca6bd03
        git remote add nbd168-wireless https://github.com/nbd168/wireless
        git fetch --no-tags nbd168-wireless mtk-flow-offload
        git checkout 4dded169141416b3248146f545378f36cca6bd03
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=m68k SHELL=/bin/bash drivers/net/ethernet/mediatek/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   drivers/net/ethernet/mediatek/mtk_ppe.c: In function 'mtk_flow_entry_update_l2':
   drivers/net/ethernet/mediatek/mtk_ppe.c:446:28: warning: variable 'head' set but not used [-Wunused-but-set-variable]
     446 |         struct hlist_head *head;
         |                            ^~~~
   drivers/net/ethernet/mediatek/mtk_ppe.c: In function '__mtk_ppe_check_skb':
>> drivers/net/ethernet/mediatek/mtk_ppe.c:650:33: error: 'struct net_device' has no member named 'dsa_ptr'; did you mean 'dn_ptr'?
     650 |                 ops = skb->dev->dsa_ptr->tag_ops;
         |                                 ^~~~~~~
         |                                 dn_ptr


vim +650 drivers/net/ethernet/mediatek/mtk_ppe.c

   598	
   599	void __mtk_ppe_check_skb(struct mtk_ppe *ppe, struct sk_buff *skb, u16 hash)
   600	{
   601		struct hlist_head *head = &ppe->foe_flow[hash / 2];
   602		struct mtk_foe_entry *hwe = &ppe->foe_table[hash];
   603		const struct dsa_device_ops *ops;
   604		struct mtk_flow_entry *entry;
   605		struct mtk_foe_bridge key = {};
   606		struct ethhdr *eh;
   607		bool found = false;
   608		u8 *tag;
   609	
   610		spin_lock_bh(&ppe_lock);
   611	
   612		if (FIELD_GET(MTK_FOE_IB1_STATE, hwe->ib1) == MTK_FOE_STATE_BIND)
   613			goto out;
   614	
   615		hlist_for_each_entry(entry, head, list) {
   616			if (entry->type == MTK_FLOW_TYPE_L2_SUBFLOW) {
   617				if (unlikely(FIELD_GET(MTK_FOE_IB1_STATE, hwe->ib1) ==
   618					     MTK_FOE_STATE_BIND))
   619					continue;
   620	
   621				entry->hash = 0xffff;
   622				__mtk_foe_entry_clear(ppe, entry);
   623				continue;
   624			}
   625	
   626			if (found || !mtk_flow_entry_match(entry, hwe)) {
   627				if (entry->hash != 0xffff)
   628					entry->hash = 0xffff;
   629				continue;
   630			}
   631	
   632			entry->hash = hash;
   633			__mtk_foe_entry_commit(ppe, &entry->data, hash);
   634			found = true;
   635		}
   636	
   637		if (found)
   638			goto out;
   639	
   640		eh = eth_hdr(skb);
   641		ether_addr_copy(key.dest_mac, eh->h_dest);
   642		ether_addr_copy(key.src_mac, eh->h_source);
   643		tag = skb->data - 2;
   644		key.vlan = 0;
   645		switch (skb->protocol) {
   646		case htons(ETH_P_XDSA):
   647			if (!netdev_uses_dsa(skb->dev))
   648				goto out;
   649	
 > 650			ops = skb->dev->dsa_ptr->tag_ops;
   651			if (ops->proto != DSA_TAG_PROTO_MTK)
   652				goto out;
   653	
   654			tag += 4;
   655			if (get_unaligned_be16(tag) != ETH_P_8021Q)
   656				break;
   657	
   658			fallthrough;
   659		case htons(ETH_P_8021Q):
   660			key.vlan = get_unaligned_be16(tag + 2) & VLAN_VID_MASK;
   661			break;
   662		default:
   663			break;
   664		}
   665	
   666		entry = rhashtable_lookup_fast(&ppe->l2_flows, &key, mtk_flow_l2_ht_params);
   667		if (!entry)
   668			goto out;
   669	
   670		mtk_foe_entry_commit_subflow(ppe, entry, hash);
   671	
   672	out:
   673		spin_unlock_bh(&ppe_lock);
   674	}
   675	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
