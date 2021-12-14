Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F062E474048
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 11:20:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232966AbhLNKUE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 05:20:04 -0500
Received: from mga12.intel.com ([192.55.52.136]:32457 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231191AbhLNKUD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 05:20:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639477203; x=1671013203;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=lB/96R8LtT4ubU1NkMbFVEKmi85F4Z2ZjCkVakV6Bug=;
  b=FS3FVXakC17JqgS2NubHRuDcEY46w27dBZKowhCU+BkLU27KwqhSTGoD
   D7w21jJhhXI6oYwlMoVfwpOC0UpqVcu8U8oqXojsXFDs/bLW0Qts+9tbi
   aeOFUOoBsxBb1QDT8y7OmHd3GGeSp2VirFM2HUKB4Tkr06N8ya07PxCiu
   79IbX/fZs6urxkMFmxSKKZkF+AV1+yoVPxkdXiTwcgg3DJazyTz5NDewA
   gjt0U8ZKGLA14WEMB1xr7cZQoyBuh5rKn9o5vCzPJ9564zwXLKNn0fkcM
   ZEuF0ulCjG97JyiXMauEDj+UyRQhSeMs0ims5Zusbu9WLGj4hkWG9yy9R
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10197"; a="218963058"
X-IronPort-AV: E=Sophos;i="5.88,205,1635231600"; 
   d="scan'208";a="218963058"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2021 02:20:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,205,1635231600"; 
   d="scan'208";a="465019940"
Received: from lkp-server02.sh.intel.com (HELO 9f38c0981d9f) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 14 Dec 2021 02:20:00 -0800
Received: from kbuild by 9f38c0981d9f with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mx4ue-0000BO-6A; Tue, 14 Dec 2021 10:20:00 +0000
Date:   Tue, 14 Dec 2021 18:19:08 +0800
From:   kernel test robot <lkp@intel.com>
To:     Wen Gong <quic_wgong@quicinc.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        Kalle Valo <kvalo@codeaurora.org>, ath10k@lists.infradead.org,
        linux-kernel@vger.kernel.org, Kalle Valo <quic_kvalo@quicinc.com>
Subject: [kvalo-ath:pending 53/57]
 drivers/net/wireless/ath/ath11k/wmi.c:5657:3: warning: variable 'len' is
 uninitialized when used here
Message-ID: <202112141834.pliLIgBL-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git pending
head:   6cce4964a399f7eb43e75e57de0def72561a162c
commit: b368704018cc51a0908adf79649fd692624e75da [53/57] ath11k: report rssi of each chain to mac80211 for QCA6390/WCN6855
config: x86_64-randconfig-a003-20211213 (https://download.01.org/0day-ci/archive/20211214/202112141834.pliLIgBL-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project b6a2ddb6c8ac29412b1361810972e15221fa021c)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git/commit/?id=b368704018cc51a0908adf79649fd692624e75da
        git remote add kvalo-ath https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git
        git fetch --no-tags kvalo-ath pending
        git checkout b368704018cc51a0908adf79649fd692624e75da
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash drivers/net/wireless/ath/ath11k/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/net/wireless/ath/ath11k/wmi.c:5657:3: warning: variable 'len' is uninitialized when used here [-Wuninitialized]
                   len -= sizeof(*src);
                   ^~~
   drivers/net/wireless/ath/ath11k/wmi.c:5637:9: note: initialize the variable 'len' to silence this warning
           u32 len;
                  ^
                   = 0
   1 warning generated.


vim +/len +5657 drivers/net/wireless/ath/ath11k/wmi.c

b368704018cc51 Wen Gong   2021-12-13  5628  
b368704018cc51 Wen Gong   2021-12-13  5629  static int ath11k_wmi_tlv_fw_stats_data_parse(struct ath11k_base *ab,
b368704018cc51 Wen Gong   2021-12-13  5630  					      struct wmi_tlv_fw_stats_parse *parse,
b368704018cc51 Wen Gong   2021-12-13  5631  					      const void *ptr)
b368704018cc51 Wen Gong   2021-12-13  5632  {
b368704018cc51 Wen Gong   2021-12-13  5633  	struct ath11k_fw_stats *stats = parse->stats;
b368704018cc51 Wen Gong   2021-12-13  5634  	const struct wmi_stats_event *ev = parse->ev;
b368704018cc51 Wen Gong   2021-12-13  5635  	int i;
b368704018cc51 Wen Gong   2021-12-13  5636  	const void *data = ptr;
b368704018cc51 Wen Gong   2021-12-13  5637  	u32 len;
b368704018cc51 Wen Gong   2021-12-13  5638  
b368704018cc51 Wen Gong   2021-12-13  5639  	if (!ev) {
b368704018cc51 Wen Gong   2021-12-13  5640  		ath11k_warn(ab, "failed to fetch update stats ev");
b368704018cc51 Wen Gong   2021-12-13  5641  		return -EPROTO;
b368704018cc51 Wen Gong   2021-12-13  5642  	}
d5c65159f28953 Kalle Valo 2019-11-23  5643  
d5c65159f28953 Kalle Valo 2019-11-23  5644  	stats->stats_id = 0;
d5c65159f28953 Kalle Valo 2019-11-23  5645  
d5c65159f28953 Kalle Valo 2019-11-23  5646  	for (i = 0; i < ev->num_pdev_stats; i++) {
d5c65159f28953 Kalle Valo 2019-11-23  5647  		const struct wmi_pdev_stats *src;
d5c65159f28953 Kalle Valo 2019-11-23  5648  		struct ath11k_fw_stats_pdev *dst;
d5c65159f28953 Kalle Valo 2019-11-23  5649  
d5c65159f28953 Kalle Valo 2019-11-23  5650  		src = data;
b368704018cc51 Wen Gong   2021-12-13  5651  		if (len < sizeof(*src))
d5c65159f28953 Kalle Valo 2019-11-23  5652  			return -EPROTO;
d5c65159f28953 Kalle Valo 2019-11-23  5653  
d5c65159f28953 Kalle Valo 2019-11-23  5654  		stats->stats_id = WMI_REQUEST_PDEV_STAT;
d5c65159f28953 Kalle Valo 2019-11-23  5655  
d5c65159f28953 Kalle Valo 2019-11-23  5656  		data += sizeof(*src);
d5c65159f28953 Kalle Valo 2019-11-23 @5657  		len -= sizeof(*src);
d5c65159f28953 Kalle Valo 2019-11-23  5658  
d5c65159f28953 Kalle Valo 2019-11-23  5659  		dst = kzalloc(sizeof(*dst), GFP_ATOMIC);
d5c65159f28953 Kalle Valo 2019-11-23  5660  		if (!dst)
d5c65159f28953 Kalle Valo 2019-11-23  5661  			continue;
d5c65159f28953 Kalle Valo 2019-11-23  5662  
d5c65159f28953 Kalle Valo 2019-11-23  5663  		ath11k_wmi_pull_pdev_stats_base(&src->base, dst);
d5c65159f28953 Kalle Valo 2019-11-23  5664  		ath11k_wmi_pull_pdev_stats_tx(&src->tx, dst);
d5c65159f28953 Kalle Valo 2019-11-23  5665  		ath11k_wmi_pull_pdev_stats_rx(&src->rx, dst);
d5c65159f28953 Kalle Valo 2019-11-23  5666  		list_add_tail(&dst->list, &stats->pdevs);
d5c65159f28953 Kalle Valo 2019-11-23  5667  	}
d5c65159f28953 Kalle Valo 2019-11-23  5668  
d5c65159f28953 Kalle Valo 2019-11-23  5669  	for (i = 0; i < ev->num_vdev_stats; i++) {
d5c65159f28953 Kalle Valo 2019-11-23  5670  		const struct wmi_vdev_stats *src;
d5c65159f28953 Kalle Valo 2019-11-23  5671  		struct ath11k_fw_stats_vdev *dst;
d5c65159f28953 Kalle Valo 2019-11-23  5672  
d5c65159f28953 Kalle Valo 2019-11-23  5673  		src = data;
b368704018cc51 Wen Gong   2021-12-13  5674  		if (len < sizeof(*src))
d5c65159f28953 Kalle Valo 2019-11-23  5675  			return -EPROTO;
d5c65159f28953 Kalle Valo 2019-11-23  5676  
d5c65159f28953 Kalle Valo 2019-11-23  5677  		stats->stats_id = WMI_REQUEST_VDEV_STAT;
d5c65159f28953 Kalle Valo 2019-11-23  5678  
d5c65159f28953 Kalle Valo 2019-11-23  5679  		data += sizeof(*src);
d5c65159f28953 Kalle Valo 2019-11-23  5680  		len -= sizeof(*src);
d5c65159f28953 Kalle Valo 2019-11-23  5681  
d5c65159f28953 Kalle Valo 2019-11-23  5682  		dst = kzalloc(sizeof(*dst), GFP_ATOMIC);
d5c65159f28953 Kalle Valo 2019-11-23  5683  		if (!dst)
d5c65159f28953 Kalle Valo 2019-11-23  5684  			continue;
d5c65159f28953 Kalle Valo 2019-11-23  5685  
d5c65159f28953 Kalle Valo 2019-11-23  5686  		ath11k_wmi_pull_vdev_stats(src, dst);
d5c65159f28953 Kalle Valo 2019-11-23  5687  		list_add_tail(&dst->list, &stats->vdevs);
d5c65159f28953 Kalle Valo 2019-11-23  5688  	}
d5c65159f28953 Kalle Valo 2019-11-23  5689  
d5c65159f28953 Kalle Valo 2019-11-23  5690  	for (i = 0; i < ev->num_bcn_stats; i++) {
d5c65159f28953 Kalle Valo 2019-11-23  5691  		const struct wmi_bcn_stats *src;
d5c65159f28953 Kalle Valo 2019-11-23  5692  		struct ath11k_fw_stats_bcn *dst;
d5c65159f28953 Kalle Valo 2019-11-23  5693  
d5c65159f28953 Kalle Valo 2019-11-23  5694  		src = data;
b368704018cc51 Wen Gong   2021-12-13  5695  		if (len < sizeof(*src))
d5c65159f28953 Kalle Valo 2019-11-23  5696  			return -EPROTO;
d5c65159f28953 Kalle Valo 2019-11-23  5697  
d5c65159f28953 Kalle Valo 2019-11-23  5698  		stats->stats_id = WMI_REQUEST_BCN_STAT;
d5c65159f28953 Kalle Valo 2019-11-23  5699  
d5c65159f28953 Kalle Valo 2019-11-23  5700  		data += sizeof(*src);
d5c65159f28953 Kalle Valo 2019-11-23  5701  		len -= sizeof(*src);
d5c65159f28953 Kalle Valo 2019-11-23  5702  
d5c65159f28953 Kalle Valo 2019-11-23  5703  		dst = kzalloc(sizeof(*dst), GFP_ATOMIC);
d5c65159f28953 Kalle Valo 2019-11-23  5704  		if (!dst)
d5c65159f28953 Kalle Valo 2019-11-23  5705  			continue;
d5c65159f28953 Kalle Valo 2019-11-23  5706  
d5c65159f28953 Kalle Valo 2019-11-23  5707  		ath11k_wmi_pull_bcn_stats(src, dst);
d5c65159f28953 Kalle Valo 2019-11-23  5708  		list_add_tail(&dst->list, &stats->bcn);
d5c65159f28953 Kalle Valo 2019-11-23  5709  	}
d5c65159f28953 Kalle Valo 2019-11-23  5710  
d5c65159f28953 Kalle Valo 2019-11-23  5711  	return 0;
d5c65159f28953 Kalle Valo 2019-11-23  5712  }
d5c65159f28953 Kalle Valo 2019-11-23  5713  

:::::: The code at line 5657 was first introduced by commit
:::::: d5c65159f2895379e11ca13f62feabe93278985d ath11k: driver for Qualcomm IEEE 802.11ax devices

:::::: TO: Kalle Valo <kvalo@codeaurora.org>
:::::: CC: Kalle Valo <kvalo@codeaurora.org>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
