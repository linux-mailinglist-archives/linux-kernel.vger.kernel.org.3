Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 581DD53F43C
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 04:59:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236157AbiFGC7p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 22:59:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236141AbiFGC7n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 22:59:43 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BD4DAE61
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 19:59:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654570782; x=1686106782;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=GMvv2QN3movH56Birwa1BAzXblpRL4s926UwU7wjY8s=;
  b=lxG2VuIlolLCVMzTcCYBV8hmxF3TgN+jnMI26kVQJu8fVh2o/R9vwBOw
   oVdVMOiMME1kvr6iRMrflJyNvKltcYJm8FnaCmFe26mltTxk4PUyOc6yC
   PhK5C16BwWP9q8M1V3Jde68orlXELdXa6JUN8b2FZHLMikXkqTcLQpPDy
   wxxVmv4UGzwKti/Y0SmEbtKMNHRmU5AKP+Teq/F8TTnNjpkSwnSV3ofhV
   EkvXUA+aGKLyud0GgmN6Q3arHse/7bwsBncml03TYKtH+ClO8tDFYOAGS
   JWepg3iyKC+ciJuQCR6PzZdAG5VVALACOnnjp2RRdwYqH7cdAdr2d8VZD
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10370"; a="264917036"
X-IronPort-AV: E=Sophos;i="5.91,282,1647327600"; 
   d="scan'208";a="264917036"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2022 19:59:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,282,1647327600"; 
   d="scan'208";a="709302113"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 06 Jun 2022 19:59:38 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nyPRS-000DGv-2s;
        Tue, 07 Jun 2022 02:59:38 +0000
Date:   Tue, 7 Jun 2022 10:59:10 +0800
From:   kernel test robot <lkp@intel.com>
To:     Miles Hu <milehu@codeaurora.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Kalle Valo <kvalo@codeaurora.org>,
        Aloka Dixit <alokad@codeaurora.org>,
        Lavanya Suresh <lavaks@codeaurora.org>,
        Pradeep Chitrapu <pradeepc@codeaurora.org>,
        Venkateswara Naralasetty <vnaralas@codeaurora.org>,
        Jouni Malinen <jouni@codeaurora.org>
Subject: drivers/net/wireless/ath/ath11k/mac.c:1889:29: warning:
 'ath11k_peer_assoc_h_he_limit' reading 16 bytes from a region of size 0
Message-ID: <202206071043.lpcglnsK-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   f2906aa863381afb0015a9eb7fefad885d4e5a56
commit: 61fe43e7216df6e9a912d831aafc7142fa20f280 ath11k: add support for setting fixed HE rate/gi/ltf
date:   8 months ago
config: arm64-sof-customedconfig-memory-debug-defconfig (https://download.01.org/0day-ci/archive/20220607/202206071043.lpcglnsK-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=61fe43e7216df6e9a912d831aafc7142fa20f280
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 61fe43e7216df6e9a912d831aafc7142fa20f280
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=arm64 SHELL=/bin/bash drivers/net/wireless/ath/ath11k/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In function 'ath11k_peer_assoc_h_he',
       inlined from 'ath11k_peer_assoc_prepare' at drivers/net/wireless/ath/ath11k/mac.c:2232:2:
>> drivers/net/wireless/ath/ath11k/mac.c:1889:29: warning: 'ath11k_peer_assoc_h_he_limit' reading 16 bytes from a region of size 0 [-Wstringop-overread]
    1889 |                         v = ath11k_peer_assoc_h_he_limit(v, he_mcs_mask);
         |                             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/wireless/ath/ath11k/mac.c: In function 'ath11k_peer_assoc_prepare':
   drivers/net/wireless/ath/ath11k/mac.c:1889:29: note: referencing argument 2 of type 'const u16 *' {aka 'const short unsigned int *'}
   drivers/net/wireless/ath/ath11k/mac.c:1706:12: note: in a call to function 'ath11k_peer_assoc_h_he_limit'
    1706 | static u16 ath11k_peer_assoc_h_he_limit(u16 tx_mcs_set,
         |            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   In function 'ath11k_peer_assoc_h_he',
       inlined from 'ath11k_peer_assoc_prepare' at drivers/net/wireless/ath/ath11k/mac.c:2232:2:
   drivers/net/wireless/ath/ath11k/mac.c:1902:21: warning: 'ath11k_peer_assoc_h_he_limit' reading 16 bytes from a region of size 0 [-Wstringop-overread]
    1902 |                 v = ath11k_peer_assoc_h_he_limit(v, he_mcs_mask);
         |                     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/wireless/ath/ath11k/mac.c: In function 'ath11k_peer_assoc_prepare':
   drivers/net/wireless/ath/ath11k/mac.c:1902:21: note: referencing argument 2 of type 'const u16 *' {aka 'const short unsigned int *'}
   drivers/net/wireless/ath/ath11k/mac.c:1706:12: note: in a call to function 'ath11k_peer_assoc_h_he_limit'
    1706 | static u16 ath11k_peer_assoc_h_he_limit(u16 tx_mcs_set,
         |            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   In function 'ath11k_peer_assoc_h_he',
       inlined from 'ath11k_peer_assoc_prepare' at drivers/net/wireless/ath/ath11k/mac.c:2232:2:
   drivers/net/wireless/ath/ath11k/mac.c:1915:21: warning: 'ath11k_peer_assoc_h_he_limit' reading 16 bytes from a region of size 0 [-Wstringop-overread]
    1915 |                 v = ath11k_peer_assoc_h_he_limit(v, he_mcs_mask);
         |                     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/wireless/ath/ath11k/mac.c: In function 'ath11k_peer_assoc_prepare':
   drivers/net/wireless/ath/ath11k/mac.c:1915:21: note: referencing argument 2 of type 'const u16 *' {aka 'const short unsigned int *'}
   drivers/net/wireless/ath/ath11k/mac.c:1706:12: note: in a call to function 'ath11k_peer_assoc_h_he_limit'
    1706 | static u16 ath11k_peer_assoc_h_he_limit(u16 tx_mcs_set,
         |            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   In function 'ath11k_peer_assoc_h_he',
       inlined from 'ath11k_peer_assoc_prepare' at drivers/net/wireless/ath/ath11k/mac.c:2232:2:
   drivers/net/wireless/ath/ath11k/mac.c:1915:21: warning: 'ath11k_peer_assoc_h_he_limit' reading 16 bytes from a region of size 0 [-Wstringop-overread]
    1915 |                 v = ath11k_peer_assoc_h_he_limit(v, he_mcs_mask);
         |                     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/wireless/ath/ath11k/mac.c: In function 'ath11k_peer_assoc_prepare':
   drivers/net/wireless/ath/ath11k/mac.c:1915:21: note: referencing argument 2 of type 'const u16 *' {aka 'const short unsigned int *'}
   drivers/net/wireless/ath/ath11k/mac.c:1706:12: note: in a call to function 'ath11k_peer_assoc_h_he_limit'
    1706 | static u16 ath11k_peer_assoc_h_he_limit(u16 tx_mcs_set,
         |            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   In function 'ath11k_peer_assoc_h_he',
       inlined from 'ath11k_peer_assoc_prepare' at drivers/net/wireless/ath/ath11k/mac.c:2232:2:
   drivers/net/wireless/ath/ath11k/mac.c:1915:21: warning: 'ath11k_peer_assoc_h_he_limit' reading 16 bytes from a region of size 0 [-Wstringop-overread]
    1915 |                 v = ath11k_peer_assoc_h_he_limit(v, he_mcs_mask);
         |                     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/wireless/ath/ath11k/mac.c: In function 'ath11k_peer_assoc_prepare':
   drivers/net/wireless/ath/ath11k/mac.c:1915:21: note: referencing argument 2 of type 'const u16 *' {aka 'const short unsigned int *'}
   drivers/net/wireless/ath/ath11k/mac.c:1706:12: note: in a call to function 'ath11k_peer_assoc_h_he_limit'
    1706 | static u16 ath11k_peer_assoc_h_he_limit(u16 tx_mcs_set,
         |            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   In function 'ath11k_peer_assoc_h_he',
       inlined from 'ath11k_peer_assoc_prepare' at drivers/net/wireless/ath/ath11k/mac.c:2232:2:
   drivers/net/wireless/ath/ath11k/mac.c:1902:21: warning: 'ath11k_peer_assoc_h_he_limit' reading 16 bytes from a region of size 0 [-Wstringop-overread]
    1902 |                 v = ath11k_peer_assoc_h_he_limit(v, he_mcs_mask);
         |                     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/wireless/ath/ath11k/mac.c: In function 'ath11k_peer_assoc_prepare':
   drivers/net/wireless/ath/ath11k/mac.c:1902:21: note: referencing argument 2 of type 'const u16 *' {aka 'const short unsigned int *'}
   drivers/net/wireless/ath/ath11k/mac.c:1706:12: note: in a call to function 'ath11k_peer_assoc_h_he_limit'
    1706 | static u16 ath11k_peer_assoc_h_he_limit(u16 tx_mcs_set,
         |            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~


vim +/ath11k_peer_assoc_h_he_limit +1889 drivers/net/wireless/ath/ath11k/mac.c

  1761	
  1762	static void ath11k_peer_assoc_h_he(struct ath11k *ar,
  1763					   struct ieee80211_vif *vif,
  1764					   struct ieee80211_sta *sta,
  1765					   struct peer_assoc_params *arg)
  1766	{
  1767		struct ath11k_vif *arvif = (void *)vif->drv_priv;
  1768		struct cfg80211_chan_def def;
  1769		const struct ieee80211_sta_he_cap *he_cap = &sta->he_cap;
  1770		u8 ampdu_factor;
  1771		enum nl80211_band band;
  1772		u16 *he_mcs_mask;
  1773		u8 max_nss, he_mcs;
  1774		u16 he_tx_mcs = 0, v = 0;
  1775		int i, he_nss, nss_idx;
  1776		bool user_rate_valid = true;
  1777	
  1778		if (WARN_ON(ath11k_mac_vif_chan(vif, &def)))
  1779			return;
  1780	
  1781		if (!he_cap->has_he)
  1782			return;
  1783	
  1784		band = def.chan->band;
  1785		he_mcs_mask = arvif->bitrate_mask.control[band].he_mcs;
  1786	
  1787		if (ath11k_peer_assoc_h_he_masked(he_mcs_mask))
  1788			return;
  1789	
  1790		arg->he_flag = true;
  1791	
  1792		memcpy_and_pad(&arg->peer_he_cap_macinfo,
  1793			       sizeof(arg->peer_he_cap_macinfo),
  1794			       he_cap->he_cap_elem.mac_cap_info,
  1795			       sizeof(he_cap->he_cap_elem.mac_cap_info),
  1796			       0);
  1797		memcpy_and_pad(&arg->peer_he_cap_phyinfo,
  1798			       sizeof(arg->peer_he_cap_phyinfo),
  1799			       he_cap->he_cap_elem.phy_cap_info,
  1800			       sizeof(he_cap->he_cap_elem.phy_cap_info),
  1801			       0);
  1802		arg->peer_he_ops = vif->bss_conf.he_oper.params;
  1803	
  1804		/* the top most byte is used to indicate BSS color info */
  1805		arg->peer_he_ops &= 0xffffff;
  1806	
  1807		/* As per section 26.6.1 11ax Draft5.0, if the Max AMPDU Exponent Extension
  1808		 * in HE cap is zero, use the arg->peer_max_mpdu as calculated while parsing
  1809		 * VHT caps(if VHT caps is present) or HT caps (if VHT caps is not present).
  1810		 *
  1811		 * For non-zero value of Max AMPDU Extponent Extension in HE MAC caps,
  1812		 * if a HE STA sends VHT cap and HE cap IE in assoc request then, use
  1813		 * MAX_AMPDU_LEN_FACTOR as 20 to calculate max_ampdu length.
  1814		 * If a HE STA that does not send VHT cap, but HE and HT cap in assoc
  1815		 * request, then use MAX_AMPDU_LEN_FACTOR as 16 to calculate max_ampdu
  1816		 * length.
  1817		 */
  1818		ampdu_factor = u8_get_bits(he_cap->he_cap_elem.mac_cap_info[3],
  1819					   IEEE80211_HE_MAC_CAP3_MAX_AMPDU_LEN_EXP_MASK);
  1820	
  1821		if (ampdu_factor) {
  1822			if (sta->vht_cap.vht_supported)
  1823				arg->peer_max_mpdu = (1 << (IEEE80211_HE_VHT_MAX_AMPDU_FACTOR +
  1824							    ampdu_factor)) - 1;
  1825			else if (sta->ht_cap.ht_supported)
  1826				arg->peer_max_mpdu = (1 << (IEEE80211_HE_HT_MAX_AMPDU_FACTOR +
  1827							    ampdu_factor)) - 1;
  1828		}
  1829	
  1830		if (he_cap->he_cap_elem.phy_cap_info[6] &
  1831		    IEEE80211_HE_PHY_CAP6_PPE_THRESHOLD_PRESENT) {
  1832			int bit = 7;
  1833			int nss, ru;
  1834	
  1835			arg->peer_ppet.numss_m1 = he_cap->ppe_thres[0] &
  1836						  IEEE80211_PPE_THRES_NSS_MASK;
  1837			arg->peer_ppet.ru_bit_mask =
  1838				(he_cap->ppe_thres[0] &
  1839				 IEEE80211_PPE_THRES_RU_INDEX_BITMASK_MASK) >>
  1840				IEEE80211_PPE_THRES_RU_INDEX_BITMASK_POS;
  1841	
  1842			for (nss = 0; nss <= arg->peer_ppet.numss_m1; nss++) {
  1843				for (ru = 0; ru < 4; ru++) {
  1844					u32 val = 0;
  1845					int i;
  1846	
  1847					if ((arg->peer_ppet.ru_bit_mask & BIT(ru)) == 0)
  1848						continue;
  1849					for (i = 0; i < 6; i++) {
  1850						val >>= 1;
  1851						val |= ((he_cap->ppe_thres[bit / 8] >>
  1852							 (bit % 8)) & 0x1) << 5;
  1853						bit++;
  1854					}
  1855					arg->peer_ppet.ppet16_ppet8_ru3_ru0[nss] |=
  1856									val << (ru * 6);
  1857				}
  1858			}
  1859		}
  1860	
  1861		if (he_cap->he_cap_elem.mac_cap_info[0] & IEEE80211_HE_MAC_CAP0_TWT_RES)
  1862			arg->twt_responder = true;
  1863		if (he_cap->he_cap_elem.mac_cap_info[0] & IEEE80211_HE_MAC_CAP0_TWT_REQ)
  1864			arg->twt_requester = true;
  1865	
  1866		he_nss =  ath11k_mac_max_he_nss(he_mcs_mask);
  1867	
  1868		if (he_nss > sta->rx_nss) {
  1869			user_rate_valid = false;
  1870			for (nss_idx = sta->rx_nss - 1; nss_idx >= 0; nss_idx--) {
  1871				if (he_mcs_mask[nss_idx]) {
  1872					user_rate_valid = true;
  1873					break;
  1874				}
  1875			}
  1876		}
  1877	
  1878		if (!user_rate_valid) {
  1879			ath11k_dbg(ar->ab, ATH11K_DBG_MAC, "mac setting he range mcs value to peer supported nss %d for peer %pM\n",
  1880				   sta->rx_nss, sta->addr);
  1881			he_mcs_mask[sta->rx_nss - 1] = he_mcs_mask[he_nss - 1];
  1882		}
  1883	
  1884		switch (sta->bandwidth) {
  1885		case IEEE80211_STA_RX_BW_160:
  1886			if (he_cap->he_cap_elem.phy_cap_info[0] &
  1887			    IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_80PLUS80_MHZ_IN_5G) {
  1888				v = le16_to_cpu(he_cap->he_mcs_nss_supp.rx_mcs_80p80);
> 1889				v = ath11k_peer_assoc_h_he_limit(v, he_mcs_mask);
  1890				arg->peer_he_rx_mcs_set[WMI_HECAP_TXRX_MCS_NSS_IDX_80_80] = v;
  1891	
  1892				v = le16_to_cpu(he_cap->he_mcs_nss_supp.tx_mcs_80p80);
  1893				arg->peer_he_tx_mcs_set[WMI_HECAP_TXRX_MCS_NSS_IDX_80_80] = v;
  1894	
  1895				arg->peer_he_mcs_count++;
  1896				he_tx_mcs = v;
  1897			}
  1898			v = le16_to_cpu(he_cap->he_mcs_nss_supp.rx_mcs_160);
  1899			arg->peer_he_rx_mcs_set[WMI_HECAP_TXRX_MCS_NSS_IDX_160] = v;
  1900	
  1901			v = le16_to_cpu(he_cap->he_mcs_nss_supp.tx_mcs_160);
  1902			v = ath11k_peer_assoc_h_he_limit(v, he_mcs_mask);
  1903			arg->peer_he_tx_mcs_set[WMI_HECAP_TXRX_MCS_NSS_IDX_160] = v;
  1904	
  1905			arg->peer_he_mcs_count++;
  1906			if (!he_tx_mcs)
  1907				he_tx_mcs = v;
  1908			fallthrough;
  1909	
  1910		default:
  1911			v = le16_to_cpu(he_cap->he_mcs_nss_supp.rx_mcs_80);
  1912			arg->peer_he_rx_mcs_set[WMI_HECAP_TXRX_MCS_NSS_IDX_80] = v;
  1913	
  1914			v = le16_to_cpu(he_cap->he_mcs_nss_supp.tx_mcs_80);
  1915			v = ath11k_peer_assoc_h_he_limit(v, he_mcs_mask);
  1916			arg->peer_he_tx_mcs_set[WMI_HECAP_TXRX_MCS_NSS_IDX_80] = v;
  1917	
  1918			arg->peer_he_mcs_count++;
  1919			if (!he_tx_mcs)
  1920				he_tx_mcs = v;
  1921			break;
  1922		}
  1923	
  1924		/* Calculate peer NSS capability from HE capabilities if STA
  1925		 * supports HE.
  1926		 */
  1927		for (i = 0, max_nss = 0, he_mcs = 0; i < NL80211_HE_NSS_MAX; i++) {
  1928			he_mcs = he_tx_mcs >> (2 * i) & 3;
  1929	
  1930			/* In case of fixed rates, MCS Range in he_tx_mcs might have
  1931			 * unsupported range, with he_mcs_mask set, so check either of them
  1932			 * to find nss.
  1933			 */
  1934			if (he_mcs != IEEE80211_HE_MCS_NOT_SUPPORTED ||
  1935			    he_mcs_mask[i])
  1936				max_nss = i + 1;
  1937		}
  1938		arg->peer_nss = min(sta->rx_nss, max_nss);
  1939	
  1940		ath11k_dbg(ar->ab, ATH11K_DBG_MAC,
  1941			   "mac he peer %pM nss %d mcs cnt %d\n",
  1942			   sta->addr, arg->peer_nss, arg->peer_he_mcs_count);
  1943	}
  1944	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
