Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAB6E55423C
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 07:25:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356980AbiFVFZk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 01:25:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356965AbiFVFZi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 01:25:38 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D14C436176
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 22:25:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655875536; x=1687411536;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=tKGo7VSpILTuiVUU3R3fW3eghnyKH14NdGlEIpUPeuY=;
  b=V1+DNzwutvb7q7K9KLTFjNHee6vYEyGRBvONrwweWOAH8GOLM4PHs9kF
   LxhF+KpYTdT8qLXbAraGEzYX9p6uBmHdguNHP0i6XB1Beu9U9ISGeXfA8
   if+BGcnwXJ0pJb2XOHFWCEGEwwq6POIbct9hRjUp3Svu3n9PgmqMkXNlK
   io2/Nq8oaapB9AdbA2zl5ulIi+13kLJbl6FwtpEoesvWbHpga8R0zIl/E
   c97ISgb66XVW8Oqdbi5zcs2wUyBaCdldLtST1Tgzo4PMKybhWh3usEbvQ
   igqs02+CXGTn0tYId5QIMhJW6yW8DwQzWH1T+n01V4ydKYLrvrMhVK34r
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10385"; a="263350313"
X-IronPort-AV: E=Sophos;i="5.92,211,1650956400"; 
   d="scan'208";a="263350313"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2022 22:25:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,211,1650956400"; 
   d="scan'208";a="538310176"
Received: from lkp-server02.sh.intel.com (HELO a67cc04a5eeb) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 21 Jun 2022 22:25:34 -0700
Received: from kbuild by a67cc04a5eeb with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o3srs-0000sL-Ma;
        Wed, 22 Jun 2022 05:25:32 +0000
Date:   Wed, 22 Jun 2022 13:25:01 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kalle Valo <quic_kvalo@quicinc.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        Kalle Valo <kvalo@codeaurora.org>, ath10k@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [kvalo-ath:ath12k-bringup 49/53]
 drivers/net/wireless/ath/ath12k/dp_mon.c:2140:18: warning: variable
 'rx_buf_sz' is uninitialized when used here
Message-ID: <202206221338.iV0Co3Bt-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git ath12k-bringup
head:   cc108fac9c287f5624daedca923743587adcafd1
commit: caa2f39cd59ba34be73e788ca2f6d8ed45de980f [49/53] ath12k: remove debugfs support
config: arm64-allyesconfig (https://download.01.org/0day-ci/archive/20220622/202206221338.iV0Co3Bt-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project af6d2a0b6825e71965f3e2701a63c239fa0ad70f)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm64 cross compiling tool for clang build
        # apt-get install binutils-aarch64-linux-gnu
        # https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git/commit/?id=caa2f39cd59ba34be73e788ca2f6d8ed45de980f
        git remote add kvalo-ath https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git
        git fetch --no-tags kvalo-ath ath12k-bringup
        git checkout caa2f39cd59ba34be73e788ca2f6d8ed45de980f
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm64 SHELL=/bin/bash drivers/net/ drivers/pci/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   drivers/net/wireless/ath/ath12k/dp_mon.c:884:13: warning: variable 'pkt_type' set but not used [-Wunused-but-set-variable]
           static u32 pkt_type;
                      ^
>> drivers/net/wireless/ath/ath12k/dp_mon.c:2140:18: warning: variable 'rx_buf_sz' is uninitialized when used here [-Wuninitialized]
                                                           log_type, rx_buf_sz);
                                                                     ^~~~~~~~~
   drivers/net/wireless/ath/ath12k/dp_mon.c:2080:15: note: initialize the variable 'rx_buf_sz' to silence this warning
           u32 rx_buf_sz;
                        ^
                         = 0
   2 warnings generated.


vim +/rx_buf_sz +2140 drivers/net/wireless/ath/ath12k/dp_mon.c

f40abb4788a2a3 Vasanthakumar Thiagarajan 2022-02-01  2059  
f40abb4788a2a3 Vasanthakumar Thiagarajan 2022-02-01  2060  int ath12k_dp_mon_srng_process(struct ath12k *ar, int mac_id, int *budget,
f40abb4788a2a3 Vasanthakumar Thiagarajan 2022-02-01  2061  			       bool flag, struct napi_struct *napi)
f40abb4788a2a3 Vasanthakumar Thiagarajan 2022-02-01  2062  {
f40abb4788a2a3 Vasanthakumar Thiagarajan 2022-02-01  2063  	struct hal_mon_dest_desc *mon_dst_desc;
f40abb4788a2a3 Vasanthakumar Thiagarajan 2022-02-01  2064  	struct ath12k_pdev_dp *pdev_dp = &ar->dp;
f40abb4788a2a3 Vasanthakumar Thiagarajan 2022-02-01  2065  	struct ath12k_mon_data *pmon = (struct ath12k_mon_data *)&pdev_dp->mon_data;
f40abb4788a2a3 Vasanthakumar Thiagarajan 2022-02-01  2066  	struct ath12k_base *ab = ar->ab;
f40abb4788a2a3 Vasanthakumar Thiagarajan 2022-02-01  2067  	struct ath12k_dp *dp = &ab->dp;
f40abb4788a2a3 Vasanthakumar Thiagarajan 2022-02-01  2068  	struct sk_buff *skb;
f40abb4788a2a3 Vasanthakumar Thiagarajan 2022-02-01  2069  	struct ath12k_skb_rxcb *rxcb;
f40abb4788a2a3 Vasanthakumar Thiagarajan 2022-02-01  2070  	struct dp_srng *mon_dst_ring;
f40abb4788a2a3 Vasanthakumar Thiagarajan 2022-02-01  2071  	struct hal_srng *srng;
f40abb4788a2a3 Vasanthakumar Thiagarajan 2022-02-01  2072  	struct dp_rxdma_ring *buf_ring;
f40abb4788a2a3 Vasanthakumar Thiagarajan 2022-02-01  2073  	u64 cookie;
f40abb4788a2a3 Vasanthakumar Thiagarajan 2022-02-01  2074  	u32 ppdu_id;
f40abb4788a2a3 Vasanthakumar Thiagarajan 2022-02-01  2075  	int num_buffs_reaped = 0, srng_id, buf_id;
f40abb4788a2a3 Vasanthakumar Thiagarajan 2022-02-01  2076  	u8 dest_idx = 0, i;
f40abb4788a2a3 Vasanthakumar Thiagarajan 2022-02-01  2077  	bool end_of_ppdu;
f40abb4788a2a3 Vasanthakumar Thiagarajan 2022-02-01  2078  	struct hal_rx_mon_ppdu_info *ppdu_info;
f40abb4788a2a3 Vasanthakumar Thiagarajan 2022-02-01  2079  	struct ath12k_peer *peer = NULL;
f40abb4788a2a3 Vasanthakumar Thiagarajan 2022-02-01  2080  	u32 rx_buf_sz;
f40abb4788a2a3 Vasanthakumar Thiagarajan 2022-02-01  2081  	u16 log_type = 0;
f40abb4788a2a3 Vasanthakumar Thiagarajan 2022-02-01  2082  
f40abb4788a2a3 Vasanthakumar Thiagarajan 2022-02-01  2083  	ppdu_info = &pmon->mon_ppdu_info;
f40abb4788a2a3 Vasanthakumar Thiagarajan 2022-02-01  2084  	memset(ppdu_info, 0, sizeof(*ppdu_info));
f40abb4788a2a3 Vasanthakumar Thiagarajan 2022-02-01  2085  	ppdu_info->peer_id = HAL_INVALID_PEERID;
f40abb4788a2a3 Vasanthakumar Thiagarajan 2022-02-01  2086  
f40abb4788a2a3 Vasanthakumar Thiagarajan 2022-02-01  2087  	srng_id = ath12k_hw_mac_id_to_srng_id(&ab->hw_params, mac_id);
f40abb4788a2a3 Vasanthakumar Thiagarajan 2022-02-01  2088  
f40abb4788a2a3 Vasanthakumar Thiagarajan 2022-02-01  2089  	if (flag == ATH12K_DP_RX_MONITOR_MODE) {
f40abb4788a2a3 Vasanthakumar Thiagarajan 2022-02-01  2090  		mon_dst_ring = &pdev_dp->rxdma_mon_dst_ring[srng_id];
f40abb4788a2a3 Vasanthakumar Thiagarajan 2022-02-01  2091  		buf_ring = &dp->rxdma_mon_buf_ring;
f40abb4788a2a3 Vasanthakumar Thiagarajan 2022-02-01  2092  	} else {
f40abb4788a2a3 Vasanthakumar Thiagarajan 2022-02-01  2093  		mon_dst_ring = &pdev_dp->tx_mon_dst_ring[srng_id];
f40abb4788a2a3 Vasanthakumar Thiagarajan 2022-02-01  2094  		buf_ring = &dp->tx_mon_buf_ring;
f40abb4788a2a3 Vasanthakumar Thiagarajan 2022-02-01  2095  	}
f40abb4788a2a3 Vasanthakumar Thiagarajan 2022-02-01  2096  
f40abb4788a2a3 Vasanthakumar Thiagarajan 2022-02-01  2097  	srng = &ab->hal.srng_list[mon_dst_ring->ring_id];
f40abb4788a2a3 Vasanthakumar Thiagarajan 2022-02-01  2098  
f40abb4788a2a3 Vasanthakumar Thiagarajan 2022-02-01  2099  	spin_lock_bh(&srng->lock);
f40abb4788a2a3 Vasanthakumar Thiagarajan 2022-02-01  2100  	ath12k_hal_srng_access_begin(ab, srng);
f40abb4788a2a3 Vasanthakumar Thiagarajan 2022-02-01  2101  
f40abb4788a2a3 Vasanthakumar Thiagarajan 2022-02-01  2102  	while (likely(*budget)) {
f40abb4788a2a3 Vasanthakumar Thiagarajan 2022-02-01  2103  		*budget -= 1;
f40abb4788a2a3 Vasanthakumar Thiagarajan 2022-02-01  2104  		mon_dst_desc = (struct hal_mon_dest_desc *)
f40abb4788a2a3 Vasanthakumar Thiagarajan 2022-02-01  2105  				ath12k_hal_srng_dst_peek(ab, srng);
f40abb4788a2a3 Vasanthakumar Thiagarajan 2022-02-01  2106  		if (unlikely(!mon_dst_desc))
f40abb4788a2a3 Vasanthakumar Thiagarajan 2022-02-01  2107  			break;
f40abb4788a2a3 Vasanthakumar Thiagarajan 2022-02-01  2108  
f40abb4788a2a3 Vasanthakumar Thiagarajan 2022-02-01  2109  		cookie = mon_dst_desc->cookie;
f40abb4788a2a3 Vasanthakumar Thiagarajan 2022-02-01  2110  		buf_id = u32_get_bits(cookie, DP_RXDMA_BUF_COOKIE_BUF_ID);
f40abb4788a2a3 Vasanthakumar Thiagarajan 2022-02-01  2111  
f40abb4788a2a3 Vasanthakumar Thiagarajan 2022-02-01  2112  		spin_lock_bh(&buf_ring->idr_lock);
f40abb4788a2a3 Vasanthakumar Thiagarajan 2022-02-01  2113  		skb = idr_remove(&buf_ring->bufs_idr, buf_id);
f40abb4788a2a3 Vasanthakumar Thiagarajan 2022-02-01  2114  		spin_unlock_bh(&buf_ring->idr_lock);
f40abb4788a2a3 Vasanthakumar Thiagarajan 2022-02-01  2115  
f40abb4788a2a3 Vasanthakumar Thiagarajan 2022-02-01  2116  		if (unlikely(!skb)) {
f40abb4788a2a3 Vasanthakumar Thiagarajan 2022-02-01  2117  			ath12k_warn(ab, "montior destination with invalid buf_id %d\n",
f40abb4788a2a3 Vasanthakumar Thiagarajan 2022-02-01  2118  				    buf_id);
f40abb4788a2a3 Vasanthakumar Thiagarajan 2022-02-01  2119  			goto move_next;
f40abb4788a2a3 Vasanthakumar Thiagarajan 2022-02-01  2120  		}
f40abb4788a2a3 Vasanthakumar Thiagarajan 2022-02-01  2121  
f40abb4788a2a3 Vasanthakumar Thiagarajan 2022-02-01  2122  		rxcb = ATH12K_SKB_RXCB(skb);
f40abb4788a2a3 Vasanthakumar Thiagarajan 2022-02-01  2123  		dma_unmap_single(ab->dev, rxcb->paddr,
f40abb4788a2a3 Vasanthakumar Thiagarajan 2022-02-01  2124  				 skb->len + skb_tailroom(skb),
f40abb4788a2a3 Vasanthakumar Thiagarajan 2022-02-01  2125  				 DMA_FROM_DEVICE);
f40abb4788a2a3 Vasanthakumar Thiagarajan 2022-02-01  2126  
f40abb4788a2a3 Vasanthakumar Thiagarajan 2022-02-01  2127  		pmon->dest_skb_q[dest_idx] = skb;
f40abb4788a2a3 Vasanthakumar Thiagarajan 2022-02-01  2128  		dest_idx++;
f40abb4788a2a3 Vasanthakumar Thiagarajan 2022-02-01  2129  		ppdu_id = mon_dst_desc->ppdu_id;
f40abb4788a2a3 Vasanthakumar Thiagarajan 2022-02-01  2130  		end_of_ppdu = u32_get_bits(mon_dst_desc->info0,
f40abb4788a2a3 Vasanthakumar Thiagarajan 2022-02-01  2131  					   HAL_MON_DEST_INFO0_END_OF_PPDU);
f40abb4788a2a3 Vasanthakumar Thiagarajan 2022-02-01  2132  		if (!end_of_ppdu)
f40abb4788a2a3 Vasanthakumar Thiagarajan 2022-02-01  2133  			continue;
f40abb4788a2a3 Vasanthakumar Thiagarajan 2022-02-01  2134  
f40abb4788a2a3 Vasanthakumar Thiagarajan 2022-02-01  2135  		for (i = 0; i < dest_idx; i++) {
f40abb4788a2a3 Vasanthakumar Thiagarajan 2022-02-01  2136  			skb = pmon->dest_skb_q[i];
f40abb4788a2a3 Vasanthakumar Thiagarajan 2022-02-01  2137  
f40abb4788a2a3 Vasanthakumar Thiagarajan 2022-02-01  2138  			if (log_type)
f40abb4788a2a3 Vasanthakumar Thiagarajan 2022-02-01  2139  				trace_ath12k_htt_rxdesc(ar, skb->data,
f40abb4788a2a3 Vasanthakumar Thiagarajan 2022-02-01 @2140  							log_type, rx_buf_sz);
f40abb4788a2a3 Vasanthakumar Thiagarajan 2022-02-01  2141  
f40abb4788a2a3 Vasanthakumar Thiagarajan 2022-02-01  2142  			if (flag == ATH12K_DP_RX_MONITOR_MODE)
f40abb4788a2a3 Vasanthakumar Thiagarajan 2022-02-01  2143  				ath12k_dp_mon_rx_parse_mon_status(ar, pmon, mac_id,
f40abb4788a2a3 Vasanthakumar Thiagarajan 2022-02-01  2144  								  skb, napi);
f40abb4788a2a3 Vasanthakumar Thiagarajan 2022-02-01  2145  			else
f40abb4788a2a3 Vasanthakumar Thiagarajan 2022-02-01  2146  				ath12k_dp_mon_tx_parse_mon_status(ar, pmon, mac_id,
f40abb4788a2a3 Vasanthakumar Thiagarajan 2022-02-01  2147  								  skb, napi, ppdu_id);
f40abb4788a2a3 Vasanthakumar Thiagarajan 2022-02-01  2148  
f40abb4788a2a3 Vasanthakumar Thiagarajan 2022-02-01  2149  			peer = ath12k_peer_find_by_id(ab, ppdu_info->peer_id);
f40abb4788a2a3 Vasanthakumar Thiagarajan 2022-02-01  2150  
f40abb4788a2a3 Vasanthakumar Thiagarajan 2022-02-01  2151  			if (!peer || !peer->sta) {
f40abb4788a2a3 Vasanthakumar Thiagarajan 2022-02-01  2152  				ath12k_dbg(ab, ATH12K_DBG_DATA,
f40abb4788a2a3 Vasanthakumar Thiagarajan 2022-02-01  2153  					   "failed to find the peer with peer_id %d\n",
f40abb4788a2a3 Vasanthakumar Thiagarajan 2022-02-01  2154  					   ppdu_info->peer_id);
f40abb4788a2a3 Vasanthakumar Thiagarajan 2022-02-01  2155  				dev_kfree_skb_any(skb);
f40abb4788a2a3 Vasanthakumar Thiagarajan 2022-02-01  2156  				continue;
f40abb4788a2a3 Vasanthakumar Thiagarajan 2022-02-01  2157  			}
f40abb4788a2a3 Vasanthakumar Thiagarajan 2022-02-01  2158  
f40abb4788a2a3 Vasanthakumar Thiagarajan 2022-02-01  2159  			dev_kfree_skb_any(skb);
f40abb4788a2a3 Vasanthakumar Thiagarajan 2022-02-01  2160  			pmon->dest_skb_q[i] = NULL;
f40abb4788a2a3 Vasanthakumar Thiagarajan 2022-02-01  2161  		}
f40abb4788a2a3 Vasanthakumar Thiagarajan 2022-02-01  2162  
f40abb4788a2a3 Vasanthakumar Thiagarajan 2022-02-01  2163  		dest_idx = 0;
f40abb4788a2a3 Vasanthakumar Thiagarajan 2022-02-01  2164  move_next:
f40abb4788a2a3 Vasanthakumar Thiagarajan 2022-02-01  2165  		ath12k_dp_mon_buf_replenish(ab, buf_ring, 1);
f40abb4788a2a3 Vasanthakumar Thiagarajan 2022-02-01  2166  		ath12k_hal_srng_src_get_next_entry(ab, srng);
f40abb4788a2a3 Vasanthakumar Thiagarajan 2022-02-01  2167  		num_buffs_reaped++;
f40abb4788a2a3 Vasanthakumar Thiagarajan 2022-02-01  2168  	}
f40abb4788a2a3 Vasanthakumar Thiagarajan 2022-02-01  2169  
f40abb4788a2a3 Vasanthakumar Thiagarajan 2022-02-01  2170  	ath12k_hal_srng_access_end(ab, srng);
f40abb4788a2a3 Vasanthakumar Thiagarajan 2022-02-01  2171  	spin_unlock_bh(&srng->lock);
f40abb4788a2a3 Vasanthakumar Thiagarajan 2022-02-01  2172  
f40abb4788a2a3 Vasanthakumar Thiagarajan 2022-02-01  2173  	return num_buffs_reaped;
f40abb4788a2a3 Vasanthakumar Thiagarajan 2022-02-01  2174  }
f40abb4788a2a3 Vasanthakumar Thiagarajan 2022-02-01  2175  

:::::: The code at line 2140 was first introduced by commit
:::::: f40abb4788a2a3868606a29d99583421e0874350 ath12k: New driver for Qualcomm 11be hw family

:::::: TO: Vasanthakumar Thiagarajan <quic_vthiagar@quicinc.com>
:::::: CC: Kalle Valo <quic_kvalo@quicinc.com>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
