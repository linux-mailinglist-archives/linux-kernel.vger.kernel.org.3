Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BCE9464AAC
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 10:30:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242500AbhLAJdy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 04:33:54 -0500
Received: from mga14.intel.com ([192.55.52.115]:26981 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242448AbhLAJdx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 04:33:53 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10184"; a="236651211"
X-IronPort-AV: E=Sophos;i="5.87,278,1631602800"; 
   d="scan'208";a="236651211"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2021 01:30:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,278,1631602800"; 
   d="scan'208";a="500165981"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 01 Dec 2021 01:30:15 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1msLwM-000EgO-Oo; Wed, 01 Dec 2021 09:30:14 +0000
Date:   Wed, 1 Dec 2021 17:29:15 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ayala Beker <ayala.beker@intel.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, 0day robot <lkp@intel.com>,
        Luca Coelho <luciano.coelho@intel.com>
Subject: net/wireless/scan.c:1801:6: error: use of undeclared identifier
 'channel'
Message-ID: <202112011713.xTG8PaIt-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/0day-ci/linux/commits/UPDATE-20211130-192005/Luca-Coelho/cfg80211-mac80211-patches-from-our-internal-tree-2021-11-29/20211129-213704
head:   f4120354927ddc6644f1356a4f0744c1cd2010d2
commit: 7c19322131f8862f2827dc281b380e4d675740aa cfg80211: Use the HE operation IE to determine a 6GHz BSS channel
date:   22 hours ago
config: arm-randconfig-c002-20211201 (https://download.01.org/0day-ci/archive/20211201/202112011713.xTG8PaIt-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project 25eb7fa01d7ebbe67648ea03841cda55b4239ab2)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm cross compiling tool for clang build
        # apt-get install binutils-arm-linux-gnueabi
        # https://github.com/0day-ci/linux/commit/7c19322131f8862f2827dc281b380e4d675740aa
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review UPDATE-20211130-192005/Luca-Coelho/cfg80211-mac80211-patches-from-our-internal-tree-2021-11-29/20211129-213704
        git checkout 7c19322131f8862f2827dc281b380e4d675740aa
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash net/wireless/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> net/wireless/scan.c:1801:6: error: use of undeclared identifier 'channel'
           if (channel->band == NL80211_BAND_6GHZ) {
               ^
   net/wireless/scan.c:1813:12: error: use of undeclared identifier 'channel'
                                   return channel;
                                          ^
>> net/wireless/scan.c:1815:4: error: use of undeclared identifier 'freq'
                           freq = ieee80211_channel_to_frequency(he_6ghz_oper->primary,
                           ^
   net/wireless/scan.c:1822:12: error: use of undeclared identifier 'freq'
                               abs(freq - channel->center_freq) <= 80 &&
                                   ^
   net/wireless/scan.c:1822:19: error: use of undeclared identifier 'channel'
                               abs(freq - channel->center_freq) <= 80 &&
                                          ^
   net/wireless/scan.c:1822:12: error: use of undeclared identifier 'freq'
                               abs(freq - channel->center_freq) <= 80 &&
                                   ^
   net/wireless/scan.c:1822:19: error: use of undeclared identifier 'channel'
                               abs(freq - channel->center_freq) <= 80 &&
                                          ^
   net/wireless/scan.c:1821:8: error: use of undeclared identifier 'freq'
                           if (freq != channel->center_freq &&
                               ^
   net/wireless/scan.c:1821:16: error: use of undeclared identifier 'channel'
                           if (freq != channel->center_freq &&
                                       ^
>> net/wireless/scan.c:1823:9: error: use of undeclared identifier 'ftype'; did you mean '_ctype'?
                               (ftype != CFG80211_BSS_FTYPE_BEACON ||
                                ^~~~~
                                _ctype
   include/linux/ctype.h:21:28: note: '_ctype' declared here
   extern const unsigned char _ctype[];
                              ^
   10 errors generated.


vim +/channel +1801 net/wireless/scan.c

  1794	
  1795	int cfg80211_get_ies_channel_number(const u8 *ie, size_t ielen,
  1796					    enum nl80211_band band)
  1797	{
  1798		const u8 *tmp;
  1799		int channel_number = -1;
  1800	
> 1801		if (channel->band == NL80211_BAND_6GHZ) {
  1802			const struct element *elem;
  1803	
  1804			elem = cfg80211_find_ext_elem(WLAN_EID_EXT_HE_OPERATION, ie,
  1805						      ielen);
  1806			if (elem && elem->datalen >= ieee80211_he_oper_size(&elem->data[1])) {
  1807				struct ieee80211_he_operation *he_oper =
  1808					(void *)(&elem->data[1]);
  1809				const struct ieee80211_he_6ghz_oper *he_6ghz_oper;
  1810	
  1811				he_6ghz_oper = ieee80211_he_6ghz_oper(he_oper);
  1812				if (!he_6ghz_oper)
  1813					return channel;
  1814	
> 1815				freq = ieee80211_channel_to_frequency(he_6ghz_oper->primary,
  1816								      NL80211_BAND_6GHZ);
  1817	
  1818				/* duplicated beacon indication is relevant for beacons
  1819				 * only
  1820				 */
  1821				if (freq != channel->center_freq &&
  1822				    abs(freq - channel->center_freq) <= 80 &&
> 1823				    (ftype != CFG80211_BSS_FTYPE_BEACON ||
  1824				     he_6ghz_oper->control & IEEE80211_HE_6GHZ_OPER_CTRL_DUP_BEACON))
  1825					channel_number = he_6ghz_oper->primary;
  1826			}
  1827		} else if (band == NL80211_BAND_S1GHZ) {
  1828			tmp = cfg80211_find_ie(WLAN_EID_S1G_OPERATION, ie, ielen);
  1829			if (tmp && tmp[1] >= sizeof(struct ieee80211_s1g_oper_ie)) {
  1830				struct ieee80211_s1g_oper_ie *s1gop = (void *)(tmp + 2);
  1831	
  1832				channel_number = s1gop->primary_ch;
  1833			}
  1834		} else {
  1835			tmp = cfg80211_find_ie(WLAN_EID_DS_PARAMS, ie, ielen);
  1836			if (tmp && tmp[1] == 1) {
  1837				channel_number = tmp[2];
  1838			} else {
  1839				tmp = cfg80211_find_ie(WLAN_EID_HT_OPERATION, ie, ielen);
  1840				if (tmp && tmp[1] >= sizeof(struct ieee80211_ht_operation)) {
  1841					struct ieee80211_ht_operation *htop = (void *)(tmp + 2);
  1842	
  1843					channel_number = htop->primary_chan;
  1844				}
  1845			}
  1846		}
  1847	
  1848		return channel_number;
  1849	}
  1850	EXPORT_SYMBOL(cfg80211_get_ies_channel_number);
  1851	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
