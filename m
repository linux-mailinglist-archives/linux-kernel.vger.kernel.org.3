Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA5024E6472
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 14:52:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350655AbiCXNyH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 09:54:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350662AbiCXNyC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 09:54:02 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59C47A0BD0
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 06:52:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648129950; x=1679665950;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=E/lsasjdV6rOhnGRnIeuOjq8RmX3nRQDlQ+MHVs/SOo=;
  b=fsxQOsFCVjkK6C2JrroV01+4XLeclOQ6egaMMrrlT1wSFXP4k/7+mSP0
   twhu+d2mzqgyCCcVAJYjkY/pwadzHILy0UYjjAaY3WQdao88xe2FpaYRT
   o6aUv23jpXHIBxfUAxTZWzLJpAnUd5Poen30Xl60Nzmu2LINQ72OcAwDf
   /ZrcII1Pqzfd6ldmCzaka++UcNg2lnuZqjYuo8TbD3xfz8zlnANw+8nnk
   DXriKOROUto19y3zMg8xItlQAQN/cEkmh/VD76f/R6/hBTJ3OzZZbZ9uR
   UqHjDCLdvV8QB24kdIkivf3vd4ILsakNRo8XP/Gt5LWPZzZN4T5PpBC4L
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10295"; a="321579179"
X-IronPort-AV: E=Sophos;i="5.90,207,1643702400"; 
   d="scan'208";a="321579179"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2022 06:52:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,207,1643702400"; 
   d="scan'208";a="717827088"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 24 Mar 2022 06:52:28 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nXNt5-000L7g-FP; Thu, 24 Mar 2022 13:52:27 +0000
Date:   Thu, 24 Mar 2022 21:52:09 +0800
From:   kernel test robot <lkp@intel.com>
To:     Felix Fietkau <nbd@nbd.name>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Johannes Berg <johannes.berg@intel.com>
Subject: net/mac80211/rc80211_minstrel_ht.c:1495:6: warning: variable
 'n_supported' set but not used
Message-ID: <202203242101.6uCR7FWR-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   ed4643521e6af8ab8ed1e467630a85884d2696cf
commit: a7844a53846017c34804b0a22bbda855cb08dd7c mac80211: minstrel_ht: add support for OFDM rates on non-HT clients
date:   1 year, 2 months ago
config: riscv-buildonly-randconfig-r002-20220324 (https://download.01.org/0day-ci/archive/20220324/202203242101.6uCR7FWR-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 0f6d9501cf49ce02937099350d08f20c4af86f3d)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install riscv cross compiling tool for clang build
        # apt-get install binutils-riscv64-linux-gnu
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=a7844a53846017c34804b0a22bbda855cb08dd7c
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout a7844a53846017c34804b0a22bbda855cb08dd7c
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=riscv SHELL=/bin/bash net/mac80211/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> net/mac80211/rc80211_minstrel_ht.c:1495:6: warning: variable 'n_supported' set but not used [-Wunused-but-set-variable]
           int n_supported = 0;
               ^
   1 warning generated.


vim +/n_supported +1495 net/mac80211/rc80211_minstrel_ht.c

a7844a53846017 Felix Fietkau    2021-01-15  1480  
ec8aa669b8393b Felix Fietkau    2010-05-13  1481  static void
ec8aa669b8393b Felix Fietkau    2010-05-13  1482  minstrel_ht_update_caps(void *priv, struct ieee80211_supported_band *sband,
3de805cf965d69 Simon Wunderlich 2013-07-08  1483  			struct cfg80211_chan_def *chandef,
64f68e5d15bee4 Johannes Berg    2012-03-28  1484  			struct ieee80211_sta *sta, void *priv_sta)
ec8aa669b8393b Felix Fietkau    2010-05-13  1485  {
ec8aa669b8393b Felix Fietkau    2010-05-13  1486  	struct minstrel_priv *mp = priv;
ec8aa669b8393b Felix Fietkau    2010-05-13  1487  	struct minstrel_ht_sta_priv *msp = priv_sta;
ec8aa669b8393b Felix Fietkau    2010-05-13  1488  	struct minstrel_ht_sta *mi = &msp->ht;
ec8aa669b8393b Felix Fietkau    2010-05-13  1489  	struct ieee80211_mcs_info *mcs = &sta->ht_cap.mcs;
f458e832ba510f Chaitanya T K    2018-10-06  1490  	u16 ht_cap = sta->ht_cap.cap;
9208247d74bc52 Karl Beldan      2014-10-21  1491  	struct ieee80211_sta_vht_cap *vht_cap = &sta->vht_cap;
f84de063985a6f Felix Fietkau    2021-01-15  1492  	const struct ieee80211_rate *ctl_rate;
f84de063985a6f Felix Fietkau    2021-01-15  1493  	bool ldpc, erp;
9208247d74bc52 Karl Beldan      2014-10-21  1494  	int use_vht;
4dc217df68a17a Felix Fietkau    2011-03-25 @1495  	int n_supported = 0;
ec8aa669b8393b Felix Fietkau    2010-05-13  1496  	int ack_dur;
ec8aa669b8393b Felix Fietkau    2010-05-13  1497  	int stbc;
ec8aa669b8393b Felix Fietkau    2010-05-13  1498  	int i;
ec8aa669b8393b Felix Fietkau    2010-05-13  1499  
8a0ee4fe1951af Karl Beldan      2014-10-20  1500  	BUILD_BUG_ON(ARRAY_SIZE(minstrel_mcs_groups) != MINSTREL_GROUPS_NB);
ec8aa669b8393b Felix Fietkau    2010-05-13  1501  
9208247d74bc52 Karl Beldan      2014-10-21  1502  	if (vht_cap->vht_supported)
9208247d74bc52 Karl Beldan      2014-10-21  1503  		use_vht = vht_cap->vht_mcs.tx_mcs_map != cpu_to_le16(~0);
9208247d74bc52 Karl Beldan      2014-10-21  1504  	else
9208247d74bc52 Karl Beldan      2014-10-21  1505  		use_vht = 0;
9208247d74bc52 Karl Beldan      2014-10-21  1506  
ec8aa669b8393b Felix Fietkau    2010-05-13  1507  	memset(mi, 0, sizeof(*mi));
a85666627b7f10 Felix Fietkau    2013-04-22  1508  
a85666627b7f10 Felix Fietkau    2013-04-22  1509  	mi->sta = sta;
a7844a53846017 Felix Fietkau    2021-01-15  1510  	mi->band = sband->band;
9134073bc69363 Thomas Huehn     2015-03-24  1511  	mi->last_stats_update = jiffies;
ec8aa669b8393b Felix Fietkau    2010-05-13  1512  
438b61b77082e7 Simon Wunderlich 2013-07-08  1513  	ack_dur = ieee80211_frame_duration(sband->band, 10, 60, 1, 1, 0);
438b61b77082e7 Simon Wunderlich 2013-07-08  1514  	mi->overhead = ieee80211_frame_duration(sband->band, 0, 60, 1, 1, 0);
438b61b77082e7 Simon Wunderlich 2013-07-08  1515  	mi->overhead += ack_dur;
ec8aa669b8393b Felix Fietkau    2010-05-13  1516  	mi->overhead_rtscts = mi->overhead + 2 * ack_dur;
ec8aa669b8393b Felix Fietkau    2010-05-13  1517  
f84de063985a6f Felix Fietkau    2021-01-15  1518  	ctl_rate = &sband->bitrates[rate_lowest_index(sband, sta)];
f84de063985a6f Felix Fietkau    2021-01-15  1519  	erp = ctl_rate->flags & IEEE80211_RATE_ERP_G;
f84de063985a6f Felix Fietkau    2021-01-15  1520  	ack_dur = ieee80211_frame_duration(sband->band, 10,
f84de063985a6f Felix Fietkau    2021-01-15  1521  					   ctl_rate->bitrate, erp, 1,
f84de063985a6f Felix Fietkau    2021-01-15  1522  					   ieee80211_chandef_get_shift(chandef));
f84de063985a6f Felix Fietkau    2021-01-15  1523  	mi->overhead_legacy = ack_dur;
f84de063985a6f Felix Fietkau    2021-01-15  1524  	mi->overhead_legacy_rtscts = mi->overhead_legacy + 2 * ack_dur;
f84de063985a6f Felix Fietkau    2021-01-15  1525  
ec8aa669b8393b Felix Fietkau    2010-05-13  1526  	mi->avg_ampdu_len = MINSTREL_FRAC(1, 1);
ec8aa669b8393b Felix Fietkau    2010-05-13  1527  
ec8aa669b8393b Felix Fietkau    2010-05-13  1528  	/* When using MRR, sample more on the first attempt, without delay */
ec8aa669b8393b Felix Fietkau    2010-05-13  1529  	if (mp->has_mrr) {
ec8aa669b8393b Felix Fietkau    2010-05-13  1530  		mi->sample_count = 16;
ec8aa669b8393b Felix Fietkau    2010-05-13  1531  		mi->sample_wait = 0;
ec8aa669b8393b Felix Fietkau    2010-05-13  1532  	} else {
ec8aa669b8393b Felix Fietkau    2010-05-13  1533  		mi->sample_count = 8;
ec8aa669b8393b Felix Fietkau    2010-05-13  1534  		mi->sample_wait = 8;
ec8aa669b8393b Felix Fietkau    2010-05-13  1535  	}
ec8aa669b8393b Felix Fietkau    2010-05-13  1536  	mi->sample_tries = 4;
ec8aa669b8393b Felix Fietkau    2010-05-13  1537  
9208247d74bc52 Karl Beldan      2014-10-21  1538  	if (!use_vht) {
f458e832ba510f Chaitanya T K    2018-10-06  1539  		stbc = (ht_cap & IEEE80211_HT_CAP_RX_STBC) >>
ec8aa669b8393b Felix Fietkau    2010-05-13  1540  			IEEE80211_HT_CAP_RX_STBC_SHIFT;
ec8aa669b8393b Felix Fietkau    2010-05-13  1541  
f458e832ba510f Chaitanya T K    2018-10-06  1542  		ldpc = ht_cap & IEEE80211_HT_CAP_LDPC_CODING;
f458e832ba510f Chaitanya T K    2018-10-06  1543  	} else {
f458e832ba510f Chaitanya T K    2018-10-06  1544  		stbc = (vht_cap->cap & IEEE80211_VHT_CAP_RXSTBC_MASK) >>
f458e832ba510f Chaitanya T K    2018-10-06  1545  			IEEE80211_VHT_CAP_RXSTBC_SHIFT;
f458e832ba510f Chaitanya T K    2018-10-06  1546  
f458e832ba510f Chaitanya T K    2018-10-06  1547  		ldpc = vht_cap->cap & IEEE80211_VHT_CAP_RXLDPC;
9208247d74bc52 Karl Beldan      2014-10-21  1548  	}
ec8aa669b8393b Felix Fietkau    2010-05-13  1549  
f458e832ba510f Chaitanya T K    2018-10-06  1550  	mi->tx_flags |= stbc << IEEE80211_TX_CTL_STBC_SHIFT;
f458e832ba510f Chaitanya T K    2018-10-06  1551  	if (ldpc)
f458e832ba510f Chaitanya T K    2018-10-06  1552  		mi->tx_flags |= IEEE80211_TX_CTL_LDPC;
f458e832ba510f Chaitanya T K    2018-10-06  1553  
ec8aa669b8393b Felix Fietkau    2010-05-13  1554  	for (i = 0; i < ARRAY_SIZE(mi->groups); i++) {
3ec373c421b6ef Karl Beldan      2014-10-20  1555  		u32 gflags = minstrel_mcs_groups[i].flags;
9208247d74bc52 Karl Beldan      2014-10-21  1556  		int bw, nss;
3ec373c421b6ef Karl Beldan      2014-10-20  1557  
41d085835d3d22 Felix Fietkau    2016-12-14  1558  		mi->supported[i] = 0;
a7844a53846017 Felix Fietkau    2021-01-15  1559  		if (minstrel_ht_is_legacy_group(i))
a0497f9f57478c Felix Fietkau    2013-02-13  1560  			continue;
a0497f9f57478c Felix Fietkau    2013-02-13  1561  
3ec373c421b6ef Karl Beldan      2014-10-20  1562  		if (gflags & IEEE80211_TX_RC_SHORT_GI) {
3ec373c421b6ef Karl Beldan      2014-10-20  1563  			if (gflags & IEEE80211_TX_RC_40_MHZ_WIDTH) {
f458e832ba510f Chaitanya T K    2018-10-06  1564  				if (!(ht_cap & IEEE80211_HT_CAP_SGI_40))
e1a0c6b3a4b27e Johannes Berg    2013-02-07  1565  					continue;
e1a0c6b3a4b27e Johannes Berg    2013-02-07  1566  			} else {
f458e832ba510f Chaitanya T K    2018-10-06  1567  				if (!(ht_cap & IEEE80211_HT_CAP_SGI_20))
e1a0c6b3a4b27e Johannes Berg    2013-02-07  1568  					continue;
e1a0c6b3a4b27e Johannes Berg    2013-02-07  1569  			}
ec8aa669b8393b Felix Fietkau    2010-05-13  1570  		}
ec8aa669b8393b Felix Fietkau    2010-05-13  1571  
3ec373c421b6ef Karl Beldan      2014-10-20  1572  		if (gflags & IEEE80211_TX_RC_40_MHZ_WIDTH &&
e1a0c6b3a4b27e Johannes Berg    2013-02-07  1573  		    sta->bandwidth < IEEE80211_STA_RX_BW_40)
ec8aa669b8393b Felix Fietkau    2010-05-13  1574  			continue;
ec8aa669b8393b Felix Fietkau    2010-05-13  1575  
9208247d74bc52 Karl Beldan      2014-10-21  1576  		nss = minstrel_mcs_groups[i].streams;
9208247d74bc52 Karl Beldan      2014-10-21  1577  
e9219779f943df Helmut Schaa     2012-03-09  1578  		/* Mark MCS > 7 as unsupported if STA is in static SMPS mode */
9208247d74bc52 Karl Beldan      2014-10-21  1579  		if (sta->smps_mode == IEEE80211_SMPS_STATIC && nss > 1)
e9219779f943df Helmut Schaa     2012-03-09  1580  			continue;
e9219779f943df Helmut Schaa     2012-03-09  1581  
9208247d74bc52 Karl Beldan      2014-10-21  1582  		/* HT rate */
9208247d74bc52 Karl Beldan      2014-10-21  1583  		if (gflags & IEEE80211_TX_RC_MCS) {
9ffe904405580f Karl Beldan      2014-10-24  1584  			if (use_vht && minstrel_vht_only)
9208247d74bc52 Karl Beldan      2014-10-21  1585  				continue;
b1c4f68337fa6b Felix Fietkau    2018-10-06  1586  
41d085835d3d22 Felix Fietkau    2016-12-14  1587  			mi->supported[i] = mcs->rx_mask[nss - 1];
41d085835d3d22 Felix Fietkau    2016-12-14  1588  			if (mi->supported[i])
9208247d74bc52 Karl Beldan      2014-10-21  1589  				n_supported++;
9208247d74bc52 Karl Beldan      2014-10-21  1590  			continue;
9208247d74bc52 Karl Beldan      2014-10-21  1591  		}
9208247d74bc52 Karl Beldan      2014-10-21  1592  
9208247d74bc52 Karl Beldan      2014-10-21  1593  		/* VHT rate */
9208247d74bc52 Karl Beldan      2014-10-21  1594  		if (!vht_cap->vht_supported ||
9208247d74bc52 Karl Beldan      2014-10-21  1595  		    WARN_ON(!(gflags & IEEE80211_TX_RC_VHT_MCS)) ||
9208247d74bc52 Karl Beldan      2014-10-21  1596  		    WARN_ON(gflags & IEEE80211_TX_RC_160_MHZ_WIDTH))
9208247d74bc52 Karl Beldan      2014-10-21  1597  			continue;
9208247d74bc52 Karl Beldan      2014-10-21  1598  
9208247d74bc52 Karl Beldan      2014-10-21  1599  		if (gflags & IEEE80211_TX_RC_80_MHZ_WIDTH) {
9208247d74bc52 Karl Beldan      2014-10-21  1600  			if (sta->bandwidth < IEEE80211_STA_RX_BW_80 ||
9208247d74bc52 Karl Beldan      2014-10-21  1601  			    ((gflags & IEEE80211_TX_RC_SHORT_GI) &&
9208247d74bc52 Karl Beldan      2014-10-21  1602  			     !(vht_cap->cap & IEEE80211_VHT_CAP_SHORT_GI_80))) {
9208247d74bc52 Karl Beldan      2014-10-21  1603  				continue;
9208247d74bc52 Karl Beldan      2014-10-21  1604  			}
9208247d74bc52 Karl Beldan      2014-10-21  1605  		}
9208247d74bc52 Karl Beldan      2014-10-21  1606  
9208247d74bc52 Karl Beldan      2014-10-21  1607  		if (gflags & IEEE80211_TX_RC_40_MHZ_WIDTH)
9208247d74bc52 Karl Beldan      2014-10-21  1608  			bw = BW_40;
9208247d74bc52 Karl Beldan      2014-10-21  1609  		else if (gflags & IEEE80211_TX_RC_80_MHZ_WIDTH)
9208247d74bc52 Karl Beldan      2014-10-21  1610  			bw = BW_80;
9208247d74bc52 Karl Beldan      2014-10-21  1611  		else
9208247d74bc52 Karl Beldan      2014-10-21  1612  			bw = BW_20;
9208247d74bc52 Karl Beldan      2014-10-21  1613  
41d085835d3d22 Felix Fietkau    2016-12-14  1614  		mi->supported[i] = minstrel_get_valid_vht_rates(bw, nss,
9208247d74bc52 Karl Beldan      2014-10-21  1615  				vht_cap->vht_mcs.tx_mcs_map);
4dc217df68a17a Felix Fietkau    2011-03-25  1616  
41d085835d3d22 Felix Fietkau    2016-12-14  1617  		if (mi->supported[i])
4dc217df68a17a Felix Fietkau    2011-03-25  1618  			n_supported++;
ec8aa669b8393b Felix Fietkau    2010-05-13  1619  	}
4dc217df68a17a Felix Fietkau    2011-03-25  1620  
a7844a53846017 Felix Fietkau    2021-01-15  1621  	minstrel_ht_update_cck(mp, mi, sband, sta);
a7844a53846017 Felix Fietkau    2021-01-15  1622  	minstrel_ht_update_ofdm(mp, mi, sband, sta);
4dc217df68a17a Felix Fietkau    2011-03-25  1623  
a85666627b7f10 Felix Fietkau    2013-04-22  1624  	/* create an initial rate table with the lowest supported rates */
48cb39522a9d4d Felix Fietkau    2019-08-20  1625  	minstrel_ht_update_stats(mp, mi, true);
a85666627b7f10 Felix Fietkau    2013-04-22  1626  	minstrel_ht_update_rates(mp, mi);
ec8aa669b8393b Felix Fietkau    2010-05-13  1627  }
ec8aa669b8393b Felix Fietkau    2010-05-13  1628  

:::::: The code at line 1495 was first introduced by commit
:::::: 4dc217df68a17a57f8464c74c1b4785e40bddf77 mac80211: fix a crash in minstrel_ht in HT mode with no supported MCS rates

:::::: TO: Felix Fietkau <nbd@openwrt.org>
:::::: CC: John W. Linville <linville@tuxdriver.com>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
