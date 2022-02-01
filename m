Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 886274A67F0
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 23:25:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240109AbiBAWZT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 17:25:19 -0500
Received: from mga07.intel.com ([134.134.136.100]:11134 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229602AbiBAWZS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 17:25:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643754317; x=1675290317;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=X382LaJfBeerAaDLbSOIqUrZGF0P+G0JVbuMo2GQNzY=;
  b=WwyH9Xm9kSjU3/yvs9brLDBrr/m/SE6OgX72cRJmPO38gO4IcLeGhVrD
   cMxyRSBeC8NMTC5JkUB263/2sgcOtOc2HXdsOLpoXKl7sYYrrgpVSTgBX
   2/m8siKQK/yOVYJZxIXwtx2awsvi7T4cvAjXewH/SPwFOfhGsGlqQnkQl
   chadwl+v0QUgkWnsDwqqFXZ3yBVtp4eOuIz+pKtTvEARDJs8KWYOYYTbd
   8omkeBV/nxLqvoxlt1XVOUH14Izjrp1AvFg6dAcOTbsN7UcW7vbGAjTX+
   WkW1jM+cHcN+uQYk0mVp9EcWx+qxMM0XxLI/T3Sv24Z+3UUg9s8Hu9861
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10245"; a="311118768"
X-IronPort-AV: E=Sophos;i="5.88,335,1635231600"; 
   d="scan'208";a="311118768"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2022 14:25:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,335,1635231600"; 
   d="scan'208";a="523231880"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 01 Feb 2022 14:25:16 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nF1aN-000Tma-P6; Tue, 01 Feb 2022 22:25:15 +0000
Date:   Wed, 2 Feb 2022 06:24:18 +0800
From:   kernel test robot <lkp@intel.com>
To:     Mordechay Goodstein <mordechay.goodstein@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Luca Coelho <luciano.coelho@intel.com>
Subject: [iwlwifi-next:pending 41/42] net/mac80211/vht.c:493:22: error:
 'struct ieee80211_sta' has no member named 'eht_cap'; did you mean 'ht_cap'?
Message-ID: <202202020632.f5qedDLM-lkp@intel.com>
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
config: nds32-buildonly-randconfig-r002-20220201 (https://download.01.org/0day-ci/archive/20220202/202202020632.f5qedDLM-lkp@intel.com/config)
compiler: nds32le-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/iwlwifi/iwlwifi-next.git/commit/?id=741d1c0dbb94288b29ba79d187a2898f02d085af
        git remote add iwlwifi-next https://git.kernel.org/pub/scm/linux/kernel/git/iwlwifi/iwlwifi-next.git
        git fetch --no-tags iwlwifi-next pending
        git checkout 741d1c0dbb94288b29ba79d187a2898f02d085af
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=nds32 SHELL=/bin/bash net/mac80211/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   net/mac80211/vht.c: In function 'ieee80211_sta_set_rx_nss':
>> net/mac80211/vht.c:493:22: error: 'struct ieee80211_sta' has no member named 'eht_cap'; did you mean 'ht_cap'?
     493 |         if (sta->sta.eht_cap.has_eht) {
         |                      ^~~~~~~
         |                      ht_cap
   net/mac80211/vht.c:495:58: error: 'struct ieee80211_sta' has no member named 'eht_cap'; did you mean 'ht_cap'?
     495 |                 const u8 *rx_nss_mcs = (void *)&sta->sta.eht_cap.eht_mcs_nss_supp;
         |                                                          ^~~~~~~
         |                                                          ht_cap
>> net/mac80211/vht.c:498:40: error: invalid application of 'sizeof' to incomplete type 'struct ieee80211_eht_mcs_nss_supp'
     498 |                 for (i = 0; i < sizeof(struct ieee80211_eht_mcs_nss_supp); i++)
         |                                        ^~~~~~
   In file included from include/linux/kernel.h:26,
                    from include/linux/skbuff.h:13,
                    from include/linux/if_ether.h:19,
                    from include/linux/ieee80211.h:19,
                    from net/mac80211/vht.c:10:
>> net/mac80211/vht.c:501:56: error: 'IEEE80211_EHT_MCS_NSS_RX' undeclared (first use in this function); did you mean 'IEEE80211_HT_MCS_MASK_LEN'?
     501 |                                                        IEEE80211_EHT_MCS_NSS_RX));
         |                                                        ^~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/minmax.h:20:46: note: in definition of macro '__typecheck'
      20 |         (!!(sizeof((typeof(x) *)1 == (typeof(y) *)1)))
         |                                              ^
   include/linux/minmax.h:36:31: note: in expansion of macro '__safe_cmp'
      36 |         __builtin_choose_expr(__safe_cmp(x, y), \
         |                               ^~~~~~~~~~
   include/linux/minmax.h:112:33: note: in expansion of macro '__careful_cmp'
     112 | #define max_t(type, x, y)       __careful_cmp((type)(x), (type)(y), >)
         |                                 ^~~~~~~~~~~~~
   net/mac80211/vht.c:499:38: note: in expansion of macro 'max_t'
     499 |                         eht_rx_nss = max_t(u8, eht_rx_nss,
         |                                      ^~~~~
   net/mac80211/vht.c:501:56: note: each undeclared identifier is reported only once for each function it appears in
     501 |                                                        IEEE80211_EHT_MCS_NSS_RX));
         |                                                        ^~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/minmax.h:20:46: note: in definition of macro '__typecheck'
      20 |         (!!(sizeof((typeof(x) *)1 == (typeof(y) *)1)))
         |                                              ^
   include/linux/minmax.h:36:31: note: in expansion of macro '__safe_cmp'
      36 |         __builtin_choose_expr(__safe_cmp(x, y), \
         |                               ^~~~~~~~~~
   include/linux/minmax.h:112:33: note: in expansion of macro '__careful_cmp'
     112 | #define max_t(type, x, y)       __careful_cmp((type)(x), (type)(y), >)
         |                                 ^~~~~~~~~~~~~
   net/mac80211/vht.c:499:38: note: in expansion of macro 'max_t'
     499 |                         eht_rx_nss = max_t(u8, eht_rx_nss,
         |                                      ^~~~~
>> include/linux/minmax.h:36:9: error: first argument to '__builtin_choose_expr' not a constant
      36 |         __builtin_choose_expr(__safe_cmp(x, y), \
         |         ^~~~~~~~~~~~~~~~~~~~~
   include/linux/minmax.h:112:33: note: in expansion of macro '__careful_cmp'
     112 | #define max_t(type, x, y)       __careful_cmp((type)(x), (type)(y), >)
         |                                 ^~~~~~~~~~~~~
   net/mac80211/vht.c:499:38: note: in expansion of macro 'max_t'
     499 |                         eht_rx_nss = max_t(u8, eht_rx_nss,
         |                                      ^~~~~


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
   495			const u8 *rx_nss_mcs = (void *)&sta->sta.eht_cap.eht_mcs_nss_supp;
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
