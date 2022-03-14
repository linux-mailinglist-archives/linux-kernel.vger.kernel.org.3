Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEC134D79A7
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 04:32:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236078AbiCNDdP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Mar 2022 23:33:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231607AbiCNDdO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Mar 2022 23:33:14 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A10E245BE
        for <linux-kernel@vger.kernel.org>; Sun, 13 Mar 2022 20:32:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647228725; x=1678764725;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=snO8rGUb9URFdKwIcqtzNi/dK7l9SG1uDEz05qyUwFE=;
  b=OCHn4mi4wBsCT/RzZHcafN71GkeXw0hJtOzMYSIdv8pJu6heJKoBYds2
   kPNmYnS/j8Kdt/mgChVD5hndeBX2IeX4sjuYkmZIpyaUT5SUWdKJocwin
   dWkYzL/zUekGGJoiQExY1v6fycrAr54HFO+kj2IuNyeWXahooJPCRk1Ds
   /7TFLPbK+7VtMVvYcBWVBHB0g141wP+5E115/Bg2jhtyvEjWobf0gtzPB
   Q10uzVdcHNvclOOw1OxKEz30qGXAjl6Pbx34b2H1i+FpKuAANoZxkkrKR
   qUHWA9igrLsC91xP/8F+Vuo+ELdi0cEdv5tHoZX80jGNEAW3e5FUNEsa1
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10285"; a="280683489"
X-IronPort-AV: E=Sophos;i="5.90,179,1643702400"; 
   d="scan'208";a="280683489"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2022 20:32:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,179,1643702400"; 
   d="scan'208";a="612744344"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by fmsmga004.fm.intel.com with ESMTP; 13 Mar 2022 20:31:56 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nTbR4-0009Y8-HB; Mon, 14 Mar 2022 03:31:54 +0000
Date:   Mon, 14 Mar 2022 11:31:03 +0800
From:   kernel test robot <lkp@intel.com>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Johannes Berg <johannes.berg@intel.com>
Subject: drivers/net/wireless/intel/iwlwifi/mei/net.c:400: undefined
 reference to `ieee80211_hdrlen'
Message-ID: <202203141142.6EHviCS0-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   09688c0166e76ce2fb85e86b9d99be8b0084cdf9
commit: 875ad06015329314c594d3302ac2bbea37774543 iwlwifi: fix build error for IWLMEI
date:   11 days ago
config: i386-randconfig-a001-20220314 (https://download.01.org/0day-ci/archive/20220314/202203141142.6EHviCS0-lkp@intel.com/config)
compiler: gcc-9 (Ubuntu 9.4.0-1ubuntu1~20.04) 9.4.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=875ad06015329314c594d3302ac2bbea37774543
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 875ad06015329314c594d3302ac2bbea37774543
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   ld: drivers/net/wireless/intel/iwlwifi/mei/net.o: in function `iwl_mei_tx_copy_to_csme':
>> drivers/net/wireless/intel/iwlwifi/mei/net.c:400: undefined reference to `ieee80211_hdrlen'


vim +400 drivers/net/wireless/intel/iwlwifi/mei/net.c

2da4366f9e2c44 Emmanuel Grumbach 2021-11-12  364  
2da4366f9e2c44 Emmanuel Grumbach 2021-11-12  365  #define DHCP_SERVER_PORT 67
2da4366f9e2c44 Emmanuel Grumbach 2021-11-12  366  #define DHCP_CLIENT_PORT 68
2da4366f9e2c44 Emmanuel Grumbach 2021-11-12  367  void iwl_mei_tx_copy_to_csme(struct sk_buff *origskb, unsigned int ivlen)
2da4366f9e2c44 Emmanuel Grumbach 2021-11-12  368  {
2da4366f9e2c44 Emmanuel Grumbach 2021-11-12  369  	struct ieee80211_hdr *hdr;
2da4366f9e2c44 Emmanuel Grumbach 2021-11-12  370  	struct sk_buff *skb;
2da4366f9e2c44 Emmanuel Grumbach 2021-11-12  371  	struct ethhdr ethhdr;
2da4366f9e2c44 Emmanuel Grumbach 2021-11-12  372  	struct ethhdr *eth;
2da4366f9e2c44 Emmanuel Grumbach 2021-11-12  373  
2da4366f9e2c44 Emmanuel Grumbach 2021-11-12  374  	/* Catch DHCP packets */
2da4366f9e2c44 Emmanuel Grumbach 2021-11-12  375  	if (origskb->protocol != htons(ETH_P_IP) ||
2da4366f9e2c44 Emmanuel Grumbach 2021-11-12  376  	    ip_hdr(origskb)->protocol != IPPROTO_UDP ||
2da4366f9e2c44 Emmanuel Grumbach 2021-11-12  377  	    udp_hdr(origskb)->source != htons(DHCP_CLIENT_PORT) ||
2da4366f9e2c44 Emmanuel Grumbach 2021-11-12  378  	    udp_hdr(origskb)->dest != htons(DHCP_SERVER_PORT))
2da4366f9e2c44 Emmanuel Grumbach 2021-11-12  379  		return;
2da4366f9e2c44 Emmanuel Grumbach 2021-11-12  380  
2da4366f9e2c44 Emmanuel Grumbach 2021-11-12  381  	/*
2da4366f9e2c44 Emmanuel Grumbach 2021-11-12  382  	 * We could be a bit less aggressive here and not copy everything, but
2da4366f9e2c44 Emmanuel Grumbach 2021-11-12  383  	 * this is very rare anyway, do don't bother much.
2da4366f9e2c44 Emmanuel Grumbach 2021-11-12  384  	 */
2da4366f9e2c44 Emmanuel Grumbach 2021-11-12  385  	skb = skb_copy(origskb, GFP_ATOMIC);
2da4366f9e2c44 Emmanuel Grumbach 2021-11-12  386  	if (!skb)
2da4366f9e2c44 Emmanuel Grumbach 2021-11-12  387  		return;
2da4366f9e2c44 Emmanuel Grumbach 2021-11-12  388  
2da4366f9e2c44 Emmanuel Grumbach 2021-11-12  389  	skb->protocol = origskb->protocol;
2da4366f9e2c44 Emmanuel Grumbach 2021-11-12  390  
2da4366f9e2c44 Emmanuel Grumbach 2021-11-12  391  	hdr = (void *)skb->data;
2da4366f9e2c44 Emmanuel Grumbach 2021-11-12  392  
2da4366f9e2c44 Emmanuel Grumbach 2021-11-12  393  	memcpy(ethhdr.h_dest, ieee80211_get_DA(hdr), ETH_ALEN);
2da4366f9e2c44 Emmanuel Grumbach 2021-11-12  394  	memcpy(ethhdr.h_source, ieee80211_get_SA(hdr), ETH_ALEN);
2da4366f9e2c44 Emmanuel Grumbach 2021-11-12  395  
2da4366f9e2c44 Emmanuel Grumbach 2021-11-12  396  	/*
2da4366f9e2c44 Emmanuel Grumbach 2021-11-12  397  	 * Remove the ieee80211 header + IV + SNAP but leave the ethertype
2da4366f9e2c44 Emmanuel Grumbach 2021-11-12  398  	 * We still have enough headroom for the sap header.
2da4366f9e2c44 Emmanuel Grumbach 2021-11-12  399  	 */
2da4366f9e2c44 Emmanuel Grumbach 2021-11-12 @400  	pskb_pull(skb, ieee80211_hdrlen(hdr->frame_control) + ivlen + 6);

:::::: The code at line 400 was first introduced by commit
:::::: 2da4366f9e2c44afedec4acad65a99a3c7da1a35 iwlwifi: mei: add the driver to allow cooperation with CSME

:::::: TO: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
:::::: CC: Kalle Valo <kvalo@codeaurora.org>

---
0-DAY CI Kernel Test Service
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
