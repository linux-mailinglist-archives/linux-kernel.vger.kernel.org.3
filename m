Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DD9E47DC53
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Dec 2021 01:47:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238309AbhLWArM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 19:47:12 -0500
Received: from mga14.intel.com ([192.55.52.115]:53913 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238185AbhLWArJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 19:47:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640220429; x=1671756429;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=BDkevwZcPC1lV5iGmPBU8XCAUFg0Tix5/IkG1xiFR2s=;
  b=iOCk8/5UB41Aj/e0ez+HAGJAc5Gyk9jopmnBxAHOMFMMoK3x/L/zUtBP
   C3WEYN7R8XZTrXqxeFlLwDMK4ye1tjKBz5xxVQEsiDkf1NolCJC3vfqOV
   RAZ4cL0/fstfbKySImlXJGNdob7EkCpdy46A7R2cgKv6Va2YuySoNmRtt
   3/zwix7DUw+T0ouBUMWZm4E2R2veya/X1q3ryuCatN0RFVT92kVErMyzC
   pLa9HKkH4PJxKt5ka1qezCPcReYuwHTGq2GVSKTd6W5x4NgXAkXz8puBH
   go0LrKFdyNiKqQ8Kxj1M7iicUGfX7wWW75fIp8pbPh/MTrxBCmwCgQLK0
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10206"; a="240954790"
X-IronPort-AV: E=Sophos;i="5.88,228,1635231600"; 
   d="scan'208";a="240954790"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Dec 2021 16:47:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,228,1635231600"; 
   d="scan'208";a="468353664"
Received: from lkp-server01.sh.intel.com (HELO e357b3ef1427) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 22 Dec 2021 16:47:06 -0800
Received: from kbuild by e357b3ef1427 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n0CG9-00016A-92; Thu, 23 Dec 2021 00:47:05 +0000
Date:   Thu, 23 Dec 2021 08:46:53 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bo Jiao <Bo.Jiao@mediatek.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Felix Fietkau <nbd@nbd.name>,
        Sujuan Chen <sujuan.chen@mediatek.com>,
        Ryder Lee <ryder.lee@mediatek.com>
Subject: [nbd168-wireless:mt76 10/28]
 drivers/net/wireless/mediatek/mt76/mt7915/mac.c:472:5: warning: variable
 'flags' set but not used
Message-ID: <202112230801.vyMZPnaw-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/nbd168/wireless mt76
head:   05f0500c7b0147353e97de7369d504c5fbd3951e
commit: 0aa6b534b5e1cfe82e676d1d8f90bcea584565d3 [10/28] mt76: mt7915: update rx rate reporting for mt7916
config: mips-randconfig-r033-20211222 (https://download.01.org/0day-ci/archive/20211223/202112230801.vyMZPnaw-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project de4e0195ae1c39f1c3b07834b8e32c113f4f20eb)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install mips cross compiling tool for clang build
        # apt-get install binutils-mips-linux-gnu
        # https://github.com/nbd168/wireless/commit/0aa6b534b5e1cfe82e676d1d8f90bcea584565d3
        git remote add nbd168-wireless https://github.com/nbd168/wireless
        git fetch --no-tags nbd168-wireless mt76
        git checkout 0aa6b534b5e1cfe82e676d1d8f90bcea584565d3
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=mips SHELL=/bin/bash drivers/net/wireless/mediatek/mt76/mt7915/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/net/wireless/mediatek/mt76/mt7915/mac.c:472:5: warning: variable 'flags' set but not used [-Wunused-but-set-variable]
           u8 flags, stbc, gi, bw, dcm, mode, nss;
              ^
>> drivers/net/wireless/mediatek/mt76/mt7915/mac.c:535:3: warning: variable 'flags' is uninitialized when used here [-Wuninitialized]
                   flags |= RATE_INFO_FLAGS_HE_MCS;
                   ^~~~~
   drivers/net/wireless/mediatek/mt76/mt7915/mac.c:472:10: note: initialize the variable 'flags' to silence this warning
           u8 flags, stbc, gi, bw, dcm, mode, nss;
                   ^
                    = '\0'
   2 warnings generated.


vim +/flags +472 drivers/net/wireless/mediatek/mt76/mt7915/mac.c

   464	
   465	static int
   466	mt7915_mac_fill_rx_rate(struct mt7915_dev *dev,
   467				struct mt76_rx_status *status,
   468				struct ieee80211_supported_band *sband,
   469				__le32 *rxv)
   470	{
   471		u32 v0, v2;
 > 472		u8 flags, stbc, gi, bw, dcm, mode, nss;
   473		int i, idx;
   474		bool cck = false;
   475	
   476		v0 = le32_to_cpu(rxv[0]);
   477		v2 = le32_to_cpu(rxv[2]);
   478	
   479		idx = i = FIELD_GET(MT_PRXV_TX_RATE, v0);
   480		nss = FIELD_GET(MT_PRXV_NSTS, v0) + 1;
   481	
   482		if (!is_mt7915(&dev->mt76)) {
   483			stbc = FIELD_GET(MT_PRXV_HT_STBC, v0);
   484			gi = FIELD_GET(MT_PRXV_HT_SHORT_GI, v0);
   485			mode = FIELD_GET(MT_PRXV_TX_MODE, v0);
   486			dcm = FIELD_GET(MT_PRXV_DCM, v0);
   487			bw = FIELD_GET(MT_PRXV_FRAME_MODE, v0);
   488		} else {
   489			stbc = FIELD_GET(MT_CRXV_HT_STBC, v2);
   490			gi = FIELD_GET(MT_CRXV_HT_SHORT_GI, v2);
   491			mode = FIELD_GET(MT_CRXV_TX_MODE, v2);
   492			dcm = !!(idx & GENMASK(3, 0) & MT_PRXV_TX_DCM);
   493			bw = FIELD_GET(MT_CRXV_FRAME_MODE, v2);
   494		}
   495	
   496		switch (mode) {
   497		case MT_PHY_TYPE_CCK:
   498			cck = true;
   499			fallthrough;
   500		case MT_PHY_TYPE_OFDM:
   501			i = mt76_get_rate(&dev->mt76, sband, i, cck);
   502			break;
   503		case MT_PHY_TYPE_HT_GF:
   504		case MT_PHY_TYPE_HT:
   505			status->encoding = RX_ENC_HT;
   506			if (i > 31)
   507				return -EINVAL;
   508	
   509			flags = RATE_INFO_FLAGS_MCS;
   510			if (gi)
   511				flags |= RATE_INFO_FLAGS_SHORT_GI;
   512			break;
   513		case MT_PHY_TYPE_VHT:
   514			status->nss = nss;
   515			status->encoding = RX_ENC_VHT;
   516			if (i > 9)
   517				return -EINVAL;
   518	
   519			flags = RATE_INFO_FLAGS_VHT_MCS;
   520			if (gi)
   521				flags |= RATE_INFO_FLAGS_SHORT_GI;
   522			break;
   523		case MT_PHY_TYPE_HE_MU:
   524		case MT_PHY_TYPE_HE_SU:
   525		case MT_PHY_TYPE_HE_EXT_SU:
   526		case MT_PHY_TYPE_HE_TB:
   527			status->nss = nss;
   528			status->encoding = RX_ENC_HE;
   529			i &= GENMASK(3, 0);
   530	
   531			if (gi <= NL80211_RATE_INFO_HE_GI_3_2)
   532				status->he_gi = gi;
   533	
   534			status->he_dcm = dcm;
 > 535			flags |= RATE_INFO_FLAGS_HE_MCS;
   536			break;
   537		default:
   538			return -EINVAL;
   539		}
   540		status->rate_idx = i;
   541	
   542		switch (bw) {
   543		case IEEE80211_STA_RX_BW_20:
   544			break;
   545		case IEEE80211_STA_RX_BW_40:
   546			if (mode & MT_PHY_TYPE_HE_EXT_SU &&
   547			    (idx & MT_PRXV_TX_ER_SU_106T)) {
   548				status->bw = RATE_INFO_BW_HE_RU;
   549				status->he_ru =
   550					NL80211_RATE_INFO_HE_RU_ALLOC_106;
   551			} else {
   552				status->bw = RATE_INFO_BW_40;
   553			}
   554			break;
   555		case IEEE80211_STA_RX_BW_80:
   556			status->bw = RATE_INFO_BW_80;
   557			break;
   558		case IEEE80211_STA_RX_BW_160:
   559			status->bw = RATE_INFO_BW_160;
   560			break;
   561		default:
   562			return -EINVAL;
   563		}
   564	
   565		status->enc_flags |= RX_ENC_FLAG_STBC_MASK * stbc;
   566		if (mode < MT_PHY_TYPE_HE_SU && gi)
   567			status->enc_flags |= RX_ENC_FLAG_SHORT_GI;
   568	
   569		return 0;
   570	}
   571	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
