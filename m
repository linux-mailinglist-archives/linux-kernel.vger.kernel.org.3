Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93DA84A6CF4
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 09:34:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244959AbiBBIez (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 03:34:55 -0500
Received: from mga09.intel.com ([134.134.136.24]:7872 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244674AbiBBIex (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 03:34:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643790893; x=1675326893;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=chfIHeT4f/Papc8hY3mJ8L7DJIX4apHbdmQfVLJncgY=;
  b=KMYHEW1F9/c7chXlrVeSFqCyoJj4hvoUq3lrGBuppjNNsTihlRxmQIr2
   FDZ9q2fi/gt+oHm2DT0oP4jUz+kx+iqZ484T3v8sr4FazanO5kewrVbmT
   cLxt3unXa20E9ALT8uTWDjdv2DQq/mgOrAPM0+RzNhrRntWP7YH3NWf1Y
   dGQIM3EmYg8JKAZKQlabEoYYMgzrtGc/6AqOUD2ROI2qd3kfh1xahAu7/
   /bXBZCECsGak6qQ8gjwgrTUT6y7pwj5hIoEFaFVEapSZks7yePWGgcCHi
   C8sYbvcN82Zv4h82XRSLjAa4jSz7a0F/D9/bvw7XmEzkxF1ZZHPm/lFfd
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10245"; a="247641720"
X-IronPort-AV: E=Sophos;i="5.88,336,1635231600"; 
   d="scan'208";a="247641720"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2022 00:34:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,336,1635231600"; 
   d="scan'208";a="626998223"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 02 Feb 2022 00:34:49 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nFB6G-000UMv-EJ; Wed, 02 Feb 2022 08:34:48 +0000
Date:   Wed, 2 Feb 2022 16:34:31 +0800
From:   kernel test robot <lkp@intel.com>
To:     Mordechay Goodstein <mordechay.goodstein@intel.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Luca Coelho <luciano.coelho@intel.com>
Subject: [iwlwifi-next:pending 41/42] net/mac80211/vht.c:493:15: error: no
 member named 'eht_cap' in 'struct ieee80211_sta'; did you mean 'he_cap'?
Message-ID: <202202021628.MiHnhNan-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/iwlwifi/iwlwifi-next.git pending
head:   b15caa03d4e21e9e8dbc81f6ac09171a2871af1d
commit: 741d1c0dbb94288b29ba79d187a2898f02d085af [41/42] mac80211: calculate max rx nss for EHT mode
config: arm-multi_v5_defconfig (https://download.01.org/0day-ci/archive/20220202/202202021628.MiHnhNan-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project 6b1e844b69f15bb7dffaf9365cd2b355d2eb7579)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm cross compiling tool for clang build
        # apt-get install binutils-arm-linux-gnueabi
        # https://git.kernel.org/pub/scm/linux/kernel/git/iwlwifi/iwlwifi-next.git/commit/?id=741d1c0dbb94288b29ba79d187a2898f02d085af
        git remote add iwlwifi-next https://git.kernel.org/pub/scm/linux/kernel/git/iwlwifi/iwlwifi-next.git
        git fetch --no-tags iwlwifi-next pending
        git checkout 741d1c0dbb94288b29ba79d187a2898f02d085af
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> net/mac80211/vht.c:493:15: error: no member named 'eht_cap' in 'struct ieee80211_sta'; did you mean 'he_cap'?
           if (sta->sta.eht_cap.has_eht) {
                        ^~~~~~~
                        he_cap
   include/net/mac80211.h:2099:30: note: 'he_cap' declared here
           struct ieee80211_sta_he_cap he_cap;
                                       ^
>> net/mac80211/vht.c:493:23: error: no member named 'has_eht' in 'struct ieee80211_sta_he_cap'; did you mean 'has_he'?
           if (sta->sta.eht_cap.has_eht) {
                                ^~~~~~~
                                has_he
   include/net/cfg80211.h:357:7: note: 'has_he' declared here
           bool has_he;
                ^
   net/mac80211/vht.c:495:44: error: no member named 'eht_cap' in 'struct ieee80211_sta'; did you mean 'he_cap'?
                   const u8 *rx_nss_mcs = (void *)&sta->sta.eht_cap.eht_mcs_nss_supp;
                                                            ^~~~~~~
                                                            he_cap
   include/net/mac80211.h:2099:30: note: 'he_cap' declared here
           struct ieee80211_sta_he_cap he_cap;
                                       ^
>> net/mac80211/vht.c:495:52: error: no member named 'eht_mcs_nss_supp' in 'struct ieee80211_sta_he_cap'; did you mean 'he_mcs_nss_supp'?
                   const u8 *rx_nss_mcs = (void *)&sta->sta.eht_cap.eht_mcs_nss_supp;
                                                                    ^~~~~~~~~~~~~~~~
                                                                    he_mcs_nss_supp
   include/net/cfg80211.h:359:35: note: 'he_mcs_nss_supp' declared here
           struct ieee80211_he_mcs_nss_supp he_mcs_nss_supp;
                                            ^
>> net/mac80211/vht.c:498:19: error: invalid application of 'sizeof' to an incomplete type 'struct ieee80211_eht_mcs_nss_supp'
                   for (i = 0; i < sizeof(struct ieee80211_eht_mcs_nss_supp); i++)
                                   ^     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   net/mac80211/vht.c:498:33: note: forward declaration of 'struct ieee80211_eht_mcs_nss_supp'
                   for (i = 0; i < sizeof(struct ieee80211_eht_mcs_nss_supp); i++)
                                                 ^
>> net/mac80211/vht.c:501:14: error: use of undeclared identifier 'IEEE80211_EHT_MCS_NSS_RX'
                                                          IEEE80211_EHT_MCS_NSS_RX));
                                                          ^
>> net/mac80211/vht.c:501:14: error: use of undeclared identifier 'IEEE80211_EHT_MCS_NSS_RX'
   7 errors generated.


vim +493 net/mac80211/vht.c

   483	
   484	void ieee80211_sta_set_rx_nss(struct sta_info *sta)
   485	{
   486		u8 ht_rx_nss = 0, vht_rx_nss = 0, he_rx_nss = 0, eht_rx_nss = 0, rx_nss;
   487		bool support_160;
   488	
   489		/* if we received a notification already don't overwrite it */
   490		if (sta->sta.rx_nss)
   491			return;
   492	
 > 493		if (sta->sta.eht_cap.has_eht) {
   494			int i;
 > 495			const u8 *rx_nss_mcs = (void *)&sta->sta.eht_cap.eht_mcs_nss_supp;
   496	
   497			/* get the max nss for EHT over all possible bandwidths and mcs */
 > 498			for (i = 0; i < sizeof(struct ieee80211_eht_mcs_nss_supp); i++)
   499				eht_rx_nss = max_t(u8, eht_rx_nss,
   500						   u8_get_bits(rx_nss_mcs[i],
 > 501							       IEEE80211_EHT_MCS_NSS_RX));
   502		}
   503	
   504		if (sta->sta.he_cap.has_he) {
   505			int i;
   506			u8 rx_mcs_80 = 0, rx_mcs_160 = 0;
   507			const struct ieee80211_sta_he_cap *he_cap = &sta->sta.he_cap;
   508			u16 mcs_160_map =
   509				le16_to_cpu(he_cap->he_mcs_nss_supp.rx_mcs_160);
   510			u16 mcs_80_map = le16_to_cpu(he_cap->he_mcs_nss_supp.rx_mcs_80);
   511	
   512			for (i = 7; i >= 0; i--) {
   513				u8 mcs_160 = (mcs_160_map >> (2 * i)) & 3;
   514	
   515				if (mcs_160 != IEEE80211_VHT_MCS_NOT_SUPPORTED) {
   516					rx_mcs_160 = i + 1;
   517					break;
   518				}
   519			}
   520			for (i = 7; i >= 0; i--) {
   521				u8 mcs_80 = (mcs_80_map >> (2 * i)) & 3;
   522	
   523				if (mcs_80 != IEEE80211_VHT_MCS_NOT_SUPPORTED) {
   524					rx_mcs_80 = i + 1;
   525					break;
   526				}
   527			}
   528	
   529			support_160 = he_cap->he_cap_elem.phy_cap_info[0] &
   530				      IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_160MHZ_IN_5G;
   531	
   532			if (support_160)
   533				he_rx_nss = min(rx_mcs_80, rx_mcs_160);
   534			else
   535				he_rx_nss = rx_mcs_80;
   536		}
   537	
   538		if (sta->sta.ht_cap.ht_supported) {
   539			if (sta->sta.ht_cap.mcs.rx_mask[0])
   540				ht_rx_nss++;
   541			if (sta->sta.ht_cap.mcs.rx_mask[1])
   542				ht_rx_nss++;
   543			if (sta->sta.ht_cap.mcs.rx_mask[2])
   544				ht_rx_nss++;
   545			if (sta->sta.ht_cap.mcs.rx_mask[3])
   546				ht_rx_nss++;
   547			/* FIXME: consider rx_highest? */
   548		}
   549	
   550		if (sta->sta.vht_cap.vht_supported) {
   551			int i;
   552			u16 rx_mcs_map;
   553	
   554			rx_mcs_map = le16_to_cpu(sta->sta.vht_cap.vht_mcs.rx_mcs_map);
   555	
   556			for (i = 7; i >= 0; i--) {
   557				u8 mcs = (rx_mcs_map >> (2 * i)) & 3;
   558	
   559				if (mcs != IEEE80211_VHT_MCS_NOT_SUPPORTED) {
   560					vht_rx_nss = i + 1;
   561					break;
   562				}
   563			}
   564			/* FIXME: consider rx_highest? */
   565		}
   566	
   567		rx_nss = max(vht_rx_nss, ht_rx_nss);
   568		rx_nss = max(he_rx_nss, rx_nss);
   569		rx_nss = max(eht_rx_nss, rx_nss);
   570		sta->sta.rx_nss = max_t(u8, 1, rx_nss);
   571	}
   572	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
