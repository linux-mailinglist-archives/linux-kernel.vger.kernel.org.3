Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5858466A9A
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 20:46:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242634AbhLBTuI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 14:50:08 -0500
Received: from mga17.intel.com ([192.55.52.151]:31842 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242766AbhLBTuG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 14:50:06 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10185"; a="217485280"
X-IronPort-AV: E=Sophos;i="5.87,282,1631602800"; 
   d="scan'208";a="217485280"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2021 11:46:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,282,1631602800"; 
   d="scan'208";a="513329615"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by orsmga008.jf.intel.com with ESMTP; 02 Dec 2021 11:46:40 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mss2S-000Gd9-4u; Thu, 02 Dec 2021 19:46:40 +0000
Date:   Fri, 3 Dec 2021 03:45:55 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ayala Beker <ayala.beker@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        0day robot <lkp@intel.com>,
        Luca Coelho <luciano.coelho@intel.com>
Subject: net/wireless/scan.c:1801:13: error: 'channel' undeclared
Message-ID: <202112030331.PvPiXKbK-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/0day-ci/linux/commits/UPDATE-20211202-212646/Luca-Coelho/cfg80211-mac80211-patches-from-our-internal-tree-2021-11-29/20211129-213704
head:   461abce0c1b19527fb902433bfdca9524f3f4af7
commit: 080325ec300ebf29168a08ed5924c5730c0bb980 cfg80211: Use the HE operation IE to determine a 6GHz BSS channel
date:   6 hours ago
config: m68k-randconfig-r035-20211202 (https://download.01.org/0day-ci/archive/20211203/202112030331.PvPiXKbK-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/080325ec300ebf29168a08ed5924c5730c0bb980
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review UPDATE-20211202-212646/Luca-Coelho/cfg80211-mac80211-patches-from-our-internal-tree-2021-11-29/20211129-213704
        git checkout 080325ec300ebf29168a08ed5924c5730c0bb980
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=m68k SHELL=/bin/bash net/wireless/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   net/wireless/scan.c: In function 'cfg80211_get_ies_channel_number':
>> net/wireless/scan.c:1801:13: error: 'channel' undeclared (first use in this function)
    1801 |         if (channel->band == NL80211_BAND_6GHZ) {
         |             ^~~~~~~
   net/wireless/scan.c:1801:13: note: each undeclared identifier is reported only once for each function it appears in
>> net/wireless/scan.c:1815:25: error: 'freq' undeclared (first use in this function); did you mean 'ifreq'?
    1815 |                         freq = ieee80211_channel_to_frequency(he_6ghz_oper->primary,
         |                         ^~~~
         |                         ifreq
   In file included from include/linux/kernel.h:16,
                    from net/wireless/scan.c:10:
>> include/linux/math.h:136:17: error: first argument to '__builtin_choose_expr' not a constant
     136 |                 __builtin_choose_expr(                                  \
         |                 ^~~~~~~~~~~~~~~~~~~~~
   include/linux/math.h:144:61: note: in definition of macro '__abs_choose_expr'
     144 |         ({ signed type __x = (x); __x < 0 ? -__x : __x; }), other)
         |                                                             ^~~~~
   include/linux/math.h:132:17: note: in expansion of macro '__abs_choose_expr'
     132 |                 __abs_choose_expr(x, long,                              \
         |                 ^~~~~~~~~~~~~~~~~
   include/linux/math.h:133:17: note: in expansion of macro '__abs_choose_expr'
     133 |                 __abs_choose_expr(x, int,                               \
         |                 ^~~~~~~~~~~~~~~~~
   include/linux/math.h:134:17: note: in expansion of macro '__abs_choose_expr'
     134 |                 __abs_choose_expr(x, short,                             \
         |                 ^~~~~~~~~~~~~~~~~
   include/linux/math.h:135:17: note: in expansion of macro '__abs_choose_expr'
     135 |                 __abs_choose_expr(x, char,                              \
         |                 ^~~~~~~~~~~~~~~~~
   net/wireless/scan.c:1822:29: note: in expansion of macro 'abs'
    1822 |                             abs(freq - channel->center_freq) <= 80 &&
         |                             ^~~
   include/linux/math.h:141:43: error: first argument to '__builtin_choose_expr' not a constant
     141 | #define __abs_choose_expr(x, type, other) __builtin_choose_expr(        \
         |                                           ^~~~~~~~~~~~~~~~~~~~~
   include/linux/math.h:144:61: note: in definition of macro '__abs_choose_expr'
     144 |         ({ signed type __x = (x); __x < 0 ? -__x : __x; }), other)
         |                                                             ^~~~~
   include/linux/math.h:132:17: note: in expansion of macro '__abs_choose_expr'
     132 |                 __abs_choose_expr(x, long,                              \
         |                 ^~~~~~~~~~~~~~~~~
   include/linux/math.h:133:17: note: in expansion of macro '__abs_choose_expr'
     133 |                 __abs_choose_expr(x, int,                               \
         |                 ^~~~~~~~~~~~~~~~~
   include/linux/math.h:134:17: note: in expansion of macro '__abs_choose_expr'
     134 |                 __abs_choose_expr(x, short,                             \
         |                 ^~~~~~~~~~~~~~~~~
   include/linux/math.h:135:17: note: in expansion of macro '__abs_choose_expr'
     135 |                 __abs_choose_expr(x, char,                              \
         |                 ^~~~~~~~~~~~~~~~~
   net/wireless/scan.c:1822:29: note: in expansion of macro 'abs'
    1822 |                             abs(freq - channel->center_freq) <= 80 &&
         |                             ^~~
   include/linux/math.h:141:43: error: first argument to '__builtin_choose_expr' not a constant
     141 | #define __abs_choose_expr(x, type, other) __builtin_choose_expr(        \
         |                                           ^~~~~~~~~~~~~~~~~~~~~
   include/linux/math.h:144:61: note: in definition of macro '__abs_choose_expr'
     144 |         ({ signed type __x = (x); __x < 0 ? -__x : __x; }), other)
         |                                                             ^~~~~
   include/linux/math.h:132:17: note: in expansion of macro '__abs_choose_expr'
     132 |                 __abs_choose_expr(x, long,                              \
         |                 ^~~~~~~~~~~~~~~~~
   include/linux/math.h:133:17: note: in expansion of macro '__abs_choose_expr'
     133 |                 __abs_choose_expr(x, int,                               \
         |                 ^~~~~~~~~~~~~~~~~
   include/linux/math.h:134:17: note: in expansion of macro '__abs_choose_expr'
     134 |                 __abs_choose_expr(x, short,                             \
         |                 ^~~~~~~~~~~~~~~~~
   net/wireless/scan.c:1822:29: note: in expansion of macro 'abs'
    1822 |                             abs(freq - channel->center_freq) <= 80 &&
         |                             ^~~
   include/linux/math.h:141:43: error: first argument to '__builtin_choose_expr' not a constant
     141 | #define __abs_choose_expr(x, type, other) __builtin_choose_expr(        \
         |                                           ^~~~~~~~~~~~~~~~~~~~~
   include/linux/math.h:144:61: note: in definition of macro '__abs_choose_expr'
     144 |         ({ signed type __x = (x); __x < 0 ? -__x : __x; }), other)
         |                                                             ^~~~~
   include/linux/math.h:132:17: note: in expansion of macro '__abs_choose_expr'
     132 |                 __abs_choose_expr(x, long,                              \
         |                 ^~~~~~~~~~~~~~~~~
   include/linux/math.h:133:17: note: in expansion of macro '__abs_choose_expr'
     133 |                 __abs_choose_expr(x, int,                               \
         |                 ^~~~~~~~~~~~~~~~~
   net/wireless/scan.c:1822:29: note: in expansion of macro 'abs'
    1822 |                             abs(freq - channel->center_freq) <= 80 &&
         |                             ^~~
   include/linux/math.h:141:43: error: first argument to '__builtin_choose_expr' not a constant
     141 | #define __abs_choose_expr(x, type, other) __builtin_choose_expr(        \
         |                                           ^~~~~~~~~~~~~~~~~~~~~
   include/linux/math.h:144:61: note: in definition of macro '__abs_choose_expr'
     144 |         ({ signed type __x = (x); __x < 0 ? -__x : __x; }), other)
         |                                                             ^~~~~
   include/linux/math.h:132:17: note: in expansion of macro '__abs_choose_expr'
     132 |                 __abs_choose_expr(x, long,                              \
         |                 ^~~~~~~~~~~~~~~~~
   net/wireless/scan.c:1822:29: note: in expansion of macro 'abs'
    1822 |                             abs(freq - channel->center_freq) <= 80 &&
         |                             ^~~
   include/linux/math.h:141:43: error: first argument to '__builtin_choose_expr' not a constant
     141 | #define __abs_choose_expr(x, type, other) __builtin_choose_expr(        \
         |                                           ^~~~~~~~~~~~~~~~~~~~~
   include/linux/math.h:131:17: note: in expansion of macro '__abs_choose_expr'
     131 | #define abs(x)  __abs_choose_expr(x, long long,                         \
         |                 ^~~~~~~~~~~~~~~~~
   net/wireless/scan.c:1822:29: note: in expansion of macro 'abs'
    1822 |                             abs(freq - channel->center_freq) <= 80 &&
         |                             ^~~
>> net/wireless/scan.c:1823:30: error: 'ftype' undeclared (first use in this function); did you mean '_ctype'?
    1823 |                             (ftype != CFG80211_BSS_FTYPE_BEACON ||
         |                              ^~~~~
         |                              _ctype


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
