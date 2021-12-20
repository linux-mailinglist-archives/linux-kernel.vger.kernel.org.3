Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D71747B3EA
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 20:46:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232672AbhLTTqY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 14:46:24 -0500
Received: from mga18.intel.com ([134.134.136.126]:56175 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232531AbhLTTqX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 14:46:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640029583; x=1671565583;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=KxKn56AlsLsZzXcLXKmDSVBcRdq3rt2AytqOoQD9rAY=;
  b=cMFrPgjYcoYjDceFPDylfd69+0SS1n2b2JQLtF4+toO0zJAXns7la1Lv
   0G81IXLiNIcuJk1A4gD6OzJ7eplLdX9UQop6IgI3gyf/0gwI1LoYlZvuD
   eBLq4cwoYa5YXdoZu6sSQ3uDjyVP+RjDgZFM63BLF/HZCF059roLsc+VV
   2h8+EZiVT/WExXR8CQUqL2c4oEoU1uwXnLx2vqb72McxQ9sZyCUxgVecL
   9EI9/wDJv3F+MmjZwLTDvkx21qjWd45Lbbms4Z3zJZvIHi/i6kA+Cc4Dz
   WhpunDK1vzWN31044AopmGfjFw8eCVWdT/JTuOehn2zsS2ixBciYFE/o4
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10204"; a="227112291"
X-IronPort-AV: E=Sophos;i="5.88,221,1635231600"; 
   d="scan'208";a="227112291"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Dec 2021 11:46:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,221,1635231600"; 
   d="scan'208";a="616520018"
Received: from lkp-server02.sh.intel.com (HELO 9f38c0981d9f) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 20 Dec 2021 11:46:21 -0800
Received: from kbuild by 9f38c0981d9f with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mzOc0-0008AO-JC; Mon, 20 Dec 2021 19:46:20 +0000
Date:   Tue, 21 Dec 2021 03:45:34 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bo Jiao <Bo.Jiao@mediatek.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Felix Fietkau <nbd@nbd.name>,
        Sujuan Chen <sujuan.chen@mediatek.com>,
        Ryder Lee <ryder.lee@mediatek.com>
Subject: [nbd168-wireless:mt76 75/86]
 drivers/net/wireless/mediatek/mt76/mt7915/mac.c:472:13: warning: variable
 'legacy' set but not used
Message-ID: <202112210355.uzkDTs8K-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/nbd168/wireless mt76
head:   632aeeec329ae1e7426806dfd825e7efdd4e73e8
commit: d2cf90e432b3f94878b2bbbee11f5ea0500020dd [75/86] mt76: mt7915: update rx rate reporting for mt7916
config: alpha-allyesconfig (https://download.01.org/0day-ci/archive/20211221/202112210355.uzkDTs8K-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/nbd168/wireless/commit/d2cf90e432b3f94878b2bbbee11f5ea0500020dd
        git remote add nbd168-wireless https://github.com/nbd168/wireless
        git fetch --no-tags nbd168-wireless mt76
        git checkout d2cf90e432b3f94878b2bbbee11f5ea0500020dd
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=alpha SHELL=/bin/bash drivers/net/wireless/mediatek/mt76/mt7915/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   drivers/net/wireless/mediatek/mt76/mt7915/mac.c: In function 'mt7915_mac_fill_rx_rate':
>> drivers/net/wireless/mediatek/mt76/mt7915/mac.c:472:13: warning: variable 'legacy' set but not used [-Wunused-but-set-variable]
     472 |         u16 legacy;
         |             ^~~~~~
>> drivers/net/wireless/mediatek/mt76/mt7915/mac.c:471:17: warning: variable 'v1' set but not used [-Wunused-but-set-variable]
     471 |         u32 v0, v1, v2;
         |                 ^~


vim +/legacy +472 drivers/net/wireless/mediatek/mt76/mt7915/mac.c

   464	
   465	static int
   466	mt7915_mac_fill_rx_rate(struct mt7915_dev *dev,
   467				struct mt76_rx_status *status,
   468				struct ieee80211_supported_band *sband,
   469				__le32 *rxv)
   470	{
 > 471		u32 v0, v1, v2;
 > 472		u16 legacy;
   473		u8 flags, stbc, gi, bw, dcm, mode, nss;
   474		int i, idx;
   475		bool cck = false;
   476	
   477		v0 = le32_to_cpu(rxv[0]);
   478		v1 = le32_to_cpu(rxv[1]);
   479		v2 = le32_to_cpu(rxv[2]);
   480	
   481		idx = i = FIELD_GET(MT_PRXV_TX_RATE, v0);
   482		nss = FIELD_GET(MT_PRXV_NSTS, v0) + 1;
   483	
   484		if (!is_mt7915(&dev->mt76)) {
   485			stbc = FIELD_GET(MT_PRXV_HT_STBC, v0);
   486			gi = FIELD_GET(MT_PRXV_HT_SHORT_GI, v0);
   487			mode = FIELD_GET(MT_PRXV_TX_MODE, v0);
   488			dcm = FIELD_GET(MT_PRXV_DCM, v0);
   489			bw = FIELD_GET(MT_PRXV_FRAME_MODE, v0);
   490		} else {
   491			stbc = FIELD_GET(MT_CRXV_HT_STBC, v2);
   492			gi = FIELD_GET(MT_CRXV_HT_SHORT_GI, v2);
   493			mode = FIELD_GET(MT_CRXV_TX_MODE, v2);
   494			dcm = !!(idx & GENMASK(3, 0) & MT_PRXV_TX_DCM);
   495			bw = FIELD_GET(MT_CRXV_FRAME_MODE, v2);
   496		}
   497	
   498		switch (mode) {
   499		case MT_PHY_TYPE_CCK:
   500			cck = true;
   501			fallthrough;
   502		case MT_PHY_TYPE_OFDM:
   503			i = mt76_get_rate(&dev->mt76, sband, i, cck);
   504			legacy = sband->bitrates[i].bitrate;
   505			break;
   506		case MT_PHY_TYPE_HT_GF:
   507		case MT_PHY_TYPE_HT:
   508			status->encoding = RX_ENC_HT;
   509			if (i > 31)
   510				return -EINVAL;
   511	
   512			flags = RATE_INFO_FLAGS_MCS;
   513			if (gi)
   514				flags |= RATE_INFO_FLAGS_SHORT_GI;
   515			break;
   516		case MT_PHY_TYPE_VHT:
   517			status->nss = nss;
   518			status->encoding = RX_ENC_VHT;
   519			if (i > 9)
   520				return -EINVAL;
   521	
   522			flags = RATE_INFO_FLAGS_VHT_MCS;
   523			if (gi)
   524				flags |= RATE_INFO_FLAGS_SHORT_GI;
   525			break;
   526		case MT_PHY_TYPE_HE_MU:
   527		case MT_PHY_TYPE_HE_SU:
   528		case MT_PHY_TYPE_HE_EXT_SU:
   529		case MT_PHY_TYPE_HE_TB:
   530			status->nss = nss;
   531			status->encoding = RX_ENC_HE;
   532			i &= GENMASK(3, 0);
   533	
   534			if (gi <= NL80211_RATE_INFO_HE_GI_3_2)
   535				status->he_gi = gi;
   536	
   537			status->he_dcm = dcm;
   538			flags |= RATE_INFO_FLAGS_HE_MCS;
   539			break;
   540		default:
   541			return -EINVAL;
   542		}
   543		status->rate_idx = i;
   544	
   545		switch (bw) {
   546		case IEEE80211_STA_RX_BW_20:
   547			break;
   548		case IEEE80211_STA_RX_BW_40:
   549			if (mode & MT_PHY_TYPE_HE_EXT_SU &&
   550			    (idx & MT_PRXV_TX_ER_SU_106T)) {
   551				status->bw = RATE_INFO_BW_HE_RU;
   552				status->he_ru =
   553					NL80211_RATE_INFO_HE_RU_ALLOC_106;
   554			} else {
   555				status->bw = RATE_INFO_BW_40;
   556			}
   557			break;
   558		case IEEE80211_STA_RX_BW_80:
   559			status->bw = RATE_INFO_BW_80;
   560			break;
   561		case IEEE80211_STA_RX_BW_160:
   562			status->bw = RATE_INFO_BW_160;
   563			break;
   564		default:
   565			return -EINVAL;
   566		}
   567	
   568		status->enc_flags |= RX_ENC_FLAG_STBC_MASK * stbc;
   569		if (mode < MT_PHY_TYPE_HE_SU && gi)
   570			status->enc_flags |= RX_ENC_FLAG_SHORT_GI;
   571	
   572		return 0;
   573	}
   574	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
