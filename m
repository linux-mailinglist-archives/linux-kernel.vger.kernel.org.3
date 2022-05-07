Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F42D51E54F
	for <lists+linux-kernel@lfdr.de>; Sat,  7 May 2022 09:44:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383555AbiEGHsL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 May 2022 03:48:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235270AbiEGHsJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 May 2022 03:48:09 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03EED3BA45
        for <linux-kernel@vger.kernel.org>; Sat,  7 May 2022 00:44:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651909462; x=1683445462;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=A+QfSMTUtwlqNla3d/bvCsDYOhuDKOopeMPvyESEyG0=;
  b=iaUuu+3chUUHWb6BwpHsMOj9f9bE6krWM6tSUkx97aPUtNarFDB3/Li+
   mBh53gP0R1KaPRnMiV34Uv2dd0R03WlA37v1vB6Hr6ix5hjJRpTLcU1Kf
   FwQUMEI+VeS0f089SNMsRHQ8ZodULgxl8RP6pWO/Rtf/iLkApDuvxBCHt
   K2l0rIzNhcwVYYQoIkjIOXioaC1HaJGyFdFs7+Wxq1Aknx8Zgb/PNcXsE
   wbLmwMVhYiGWRQBh4YNLYcD+6z3DI2nZyO1S0+oAeOE91Bd1q8Cp3oz9B
   CzQUEiOSzdIesr2dGefglzsTgJGoenottjzrasncrMfXiQEict6qmcMVT
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10339"; a="329221848"
X-IronPort-AV: E=Sophos;i="5.91,206,1647327600"; 
   d="scan'208";a="329221848"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2022 00:44:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,206,1647327600"; 
   d="scan'208";a="665825398"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 07 May 2022 00:44:21 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nnF6y-000ELy-H6;
        Sat, 07 May 2022 07:44:20 +0000
Date:   Sat, 7 May 2022 15:43:23 +0800
From:   kernel test robot <lkp@intel.com>
To:     Edwin Peer <edwin.peer@broadcom.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Michael Chan <michael.chan@broadcom.com>
Subject: drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c:1036:7: warning:
 Local variable 'i' shadows outer variable [shadowVariable]
Message-ID: <202205071514.kZaJ8rw0-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   4b97bac0756a81cda5afd45417a99b5bccdcff67
commit: b032228e58ea2477955058ad4d70a636ce1dec51 bnxt_en: move coredump functions into dedicated file
date:   6 months ago
compiler: ia64-linux-gcc (GCC) 11.3.0
reproduce (cppcheck warning):
        # apt-get install cppcheck
        git checkout b032228e58ea2477955058ad4d70a636ce1dec51
        cppcheck --quiet --enable=style,performance,portability --template=gcc FILE

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


cppcheck warnings: (new ones prefixed by >>)
>> drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c:1036:7: warning: Local variable 'i' shadows outer variable [shadowVariable]
     int i;
         ^
   drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c:996:6: note: Shadowed declaration
    int i, rc = -EINVAL;
        ^
   drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c:1036:7: note: Shadow variable
     int i;
         ^

cppcheck possible warnings: (new ones prefixed by >>, may not real problems)

>> drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c:211:24: warning: Parameter 'frames' can be declared with const [constParameter]
       struct xdp_frame **frames, u32 flags)
                          ^
--
>> drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c:1521:40: warning: Uninitialized variables: mac_node.node, mac_node.state [uninitvar]
     ret = hclgevf_add_del_mac_addr(hdev, mac_node, mac_type);
                                          ^
>> drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c:1552:48: warning: Uninitialized variable: mac_node->state [uninitvar]
      hclgevf_update_mac_node(new_node, mac_node->state);
                                                  ^
   drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c:1616:21: warning: Uninitialized variable: mac_node->state [uninitvar]
     switch (mac_node->state) {
                       ^
>> drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c:1007:14: warning: Uninitialized variable: fltr->sw_id [uninitvar]
      if (fltr->sw_id == fs->location)
                ^
   drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c:998:19: note: Assuming condition is false
    if (fs->location >= BNXT_NTP_FLTR_MAX_FLTR)
                     ^
   drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c:1007:14: note: Uninitialized variable: fltr->sw_id
      if (fltr->sw_id == fs->location)
                ^

vim +/i +1036 drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c

c0c050c58d8409 Michael Chan      2015-10-22   989  
c0c050c58d8409 Michael Chan      2015-10-22   990  static int bnxt_grxclsrule(struct bnxt *bp, struct ethtool_rxnfc *cmd)
c0c050c58d8409 Michael Chan      2015-10-22   991  {
c0c050c58d8409 Michael Chan      2015-10-22   992  	struct ethtool_rx_flow_spec *fs =
c0c050c58d8409 Michael Chan      2015-10-22   993  		(struct ethtool_rx_flow_spec *)&cmd->fs;
c0c050c58d8409 Michael Chan      2015-10-22   994  	struct bnxt_ntuple_filter *fltr;
c0c050c58d8409 Michael Chan      2015-10-22   995  	struct flow_keys *fkeys;
c0c050c58d8409 Michael Chan      2015-10-22   996  	int i, rc = -EINVAL;
c0c050c58d8409 Michael Chan      2015-10-22   997  
b721cfaf03bcaa stephen hemminger 2017-07-24   998  	if (fs->location >= BNXT_NTP_FLTR_MAX_FLTR)
c0c050c58d8409 Michael Chan      2015-10-22   999  		return rc;
c0c050c58d8409 Michael Chan      2015-10-22  1000  
c0c050c58d8409 Michael Chan      2015-10-22  1001  	for (i = 0; i < BNXT_NTP_FLTR_HASH_SIZE; i++) {
c0c050c58d8409 Michael Chan      2015-10-22  1002  		struct hlist_head *head;
c0c050c58d8409 Michael Chan      2015-10-22  1003  
c0c050c58d8409 Michael Chan      2015-10-22  1004  		head = &bp->ntp_fltr_hash_tbl[i];
c0c050c58d8409 Michael Chan      2015-10-22  1005  		rcu_read_lock();
c0c050c58d8409 Michael Chan      2015-10-22  1006  		hlist_for_each_entry_rcu(fltr, head, hash) {
c0c050c58d8409 Michael Chan      2015-10-22 @1007  			if (fltr->sw_id == fs->location)
c0c050c58d8409 Michael Chan      2015-10-22  1008  				goto fltr_found;
c0c050c58d8409 Michael Chan      2015-10-22  1009  		}
c0c050c58d8409 Michael Chan      2015-10-22  1010  		rcu_read_unlock();
c0c050c58d8409 Michael Chan      2015-10-22  1011  	}
c0c050c58d8409 Michael Chan      2015-10-22  1012  	return rc;
c0c050c58d8409 Michael Chan      2015-10-22  1013  
c0c050c58d8409 Michael Chan      2015-10-22  1014  fltr_found:
c0c050c58d8409 Michael Chan      2015-10-22  1015  	fkeys = &fltr->fkeys;
dda0e7465f040e Michael Chan      2016-12-29  1016  	if (fkeys->basic.n_proto == htons(ETH_P_IP)) {
c0c050c58d8409 Michael Chan      2015-10-22  1017  		if (fkeys->basic.ip_proto == IPPROTO_TCP)
c0c050c58d8409 Michael Chan      2015-10-22  1018  			fs->flow_type = TCP_V4_FLOW;
c0c050c58d8409 Michael Chan      2015-10-22  1019  		else if (fkeys->basic.ip_proto == IPPROTO_UDP)
c0c050c58d8409 Michael Chan      2015-10-22  1020  			fs->flow_type = UDP_V4_FLOW;
c0c050c58d8409 Michael Chan      2015-10-22  1021  		else
c0c050c58d8409 Michael Chan      2015-10-22  1022  			goto fltr_err;
c0c050c58d8409 Michael Chan      2015-10-22  1023  
c0c050c58d8409 Michael Chan      2015-10-22  1024  		fs->h_u.tcp_ip4_spec.ip4src = fkeys->addrs.v4addrs.src;
c0c050c58d8409 Michael Chan      2015-10-22  1025  		fs->m_u.tcp_ip4_spec.ip4src = cpu_to_be32(~0);
c0c050c58d8409 Michael Chan      2015-10-22  1026  
c0c050c58d8409 Michael Chan      2015-10-22  1027  		fs->h_u.tcp_ip4_spec.ip4dst = fkeys->addrs.v4addrs.dst;
c0c050c58d8409 Michael Chan      2015-10-22  1028  		fs->m_u.tcp_ip4_spec.ip4dst = cpu_to_be32(~0);
c0c050c58d8409 Michael Chan      2015-10-22  1029  
c0c050c58d8409 Michael Chan      2015-10-22  1030  		fs->h_u.tcp_ip4_spec.psrc = fkeys->ports.src;
c0c050c58d8409 Michael Chan      2015-10-22  1031  		fs->m_u.tcp_ip4_spec.psrc = cpu_to_be16(~0);
c0c050c58d8409 Michael Chan      2015-10-22  1032  
c0c050c58d8409 Michael Chan      2015-10-22  1033  		fs->h_u.tcp_ip4_spec.pdst = fkeys->ports.dst;
c0c050c58d8409 Michael Chan      2015-10-22  1034  		fs->m_u.tcp_ip4_spec.pdst = cpu_to_be16(~0);
dda0e7465f040e Michael Chan      2016-12-29  1035  	} else {
dda0e7465f040e Michael Chan      2016-12-29 @1036  		int i;
dda0e7465f040e Michael Chan      2016-12-29  1037  
dda0e7465f040e Michael Chan      2016-12-29  1038  		if (fkeys->basic.ip_proto == IPPROTO_TCP)
dda0e7465f040e Michael Chan      2016-12-29  1039  			fs->flow_type = TCP_V6_FLOW;
dda0e7465f040e Michael Chan      2016-12-29  1040  		else if (fkeys->basic.ip_proto == IPPROTO_UDP)
dda0e7465f040e Michael Chan      2016-12-29  1041  			fs->flow_type = UDP_V6_FLOW;
dda0e7465f040e Michael Chan      2016-12-29  1042  		else
dda0e7465f040e Michael Chan      2016-12-29  1043  			goto fltr_err;
dda0e7465f040e Michael Chan      2016-12-29  1044  
dda0e7465f040e Michael Chan      2016-12-29  1045  		*(struct in6_addr *)&fs->h_u.tcp_ip6_spec.ip6src[0] =
dda0e7465f040e Michael Chan      2016-12-29  1046  			fkeys->addrs.v6addrs.src;
dda0e7465f040e Michael Chan      2016-12-29  1047  		*(struct in6_addr *)&fs->h_u.tcp_ip6_spec.ip6dst[0] =
dda0e7465f040e Michael Chan      2016-12-29  1048  			fkeys->addrs.v6addrs.dst;
dda0e7465f040e Michael Chan      2016-12-29  1049  		for (i = 0; i < 4; i++) {
dda0e7465f040e Michael Chan      2016-12-29  1050  			fs->m_u.tcp_ip6_spec.ip6src[i] = cpu_to_be32(~0);
dda0e7465f040e Michael Chan      2016-12-29  1051  			fs->m_u.tcp_ip6_spec.ip6dst[i] = cpu_to_be32(~0);
dda0e7465f040e Michael Chan      2016-12-29  1052  		}
dda0e7465f040e Michael Chan      2016-12-29  1053  		fs->h_u.tcp_ip6_spec.psrc = fkeys->ports.src;
dda0e7465f040e Michael Chan      2016-12-29  1054  		fs->m_u.tcp_ip6_spec.psrc = cpu_to_be16(~0);
dda0e7465f040e Michael Chan      2016-12-29  1055  
dda0e7465f040e Michael Chan      2016-12-29  1056  		fs->h_u.tcp_ip6_spec.pdst = fkeys->ports.dst;
dda0e7465f040e Michael Chan      2016-12-29  1057  		fs->m_u.tcp_ip6_spec.pdst = cpu_to_be16(~0);
dda0e7465f040e Michael Chan      2016-12-29  1058  	}
c0c050c58d8409 Michael Chan      2015-10-22  1059  
c0c050c58d8409 Michael Chan      2015-10-22  1060  	fs->ring_cookie = fltr->rxq;
c0c050c58d8409 Michael Chan      2015-10-22  1061  	rc = 0;
c0c050c58d8409 Michael Chan      2015-10-22  1062  
c0c050c58d8409 Michael Chan      2015-10-22  1063  fltr_err:
c0c050c58d8409 Michael Chan      2015-10-22  1064  	rcu_read_unlock();
c0c050c58d8409 Michael Chan      2015-10-22  1065  
c0c050c58d8409 Michael Chan      2015-10-22  1066  	return rc;
c0c050c58d8409 Michael Chan      2015-10-22  1067  }
a011952a1a4652 Michael Chan      2016-11-16  1068  #endif
a011952a1a4652 Michael Chan      2016-11-16  1069  

:::::: The code at line 1036 was first introduced by commit
:::::: dda0e7465f040ed814d4a5c98c6bf042e59cba69 bnxt_en: Add IPV6 hardware RFS support.

:::::: TO: Michael Chan <michael.chan@broadcom.com>
:::::: CC: David S. Miller <davem@davemloft.net>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
