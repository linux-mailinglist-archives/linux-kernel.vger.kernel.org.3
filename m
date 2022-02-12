Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 019E94B3334
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Feb 2022 06:26:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231261AbiBLFZa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Feb 2022 00:25:30 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:49444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbiBLFZ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Feb 2022 00:25:29 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D6BE28E19
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 21:25:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644643526; x=1676179526;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=zGrm93nNj4LMh8RUd7xldBiLFQ2irWfSSjxL0CI8UJs=;
  b=SO9MtvWxV3qhdSj1yKmngB8EpGQJEHgGQ6VVjBFPor/ZJceCL5YDbhJW
   T9ks+368UTpPDeq09CqQg9WSzKY1yLo9C3ctPlZU6x5SbBwC51YCov1hb
   XUdeE18+TZLRMySySEKr38s5fuuUrIvVr8nu5EZHyKwFarzvc2T1uSTnM
   ukS20RlQVtYtUy8w1/FOq0Ua7qjH+BDgVhjxC4YNltAy1bRjvoWz6F4cJ
   IkgXc/illPoCFdgzaPd6u/xrmHtrb9hDqpsJBVn7mH5FLR/RQOC5JthTM
   Ng2fEquFNW2kumcscH9j3rXdqtw6TOxa1Tt30z9CLoarhNZQOxbbiHs5I
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10255"; a="237260571"
X-IronPort-AV: E=Sophos;i="5.88,361,1635231600"; 
   d="scan'208";a="237260571"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2022 21:25:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,361,1635231600"; 
   d="scan'208";a="602565559"
Received: from lkp-server01.sh.intel.com (HELO d95dc2dabeb1) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 11 Feb 2022 21:25:24 -0800
Received: from kbuild by d95dc2dabeb1 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nIkuS-0005fj-1r; Sat, 12 Feb 2022 05:25:24 +0000
Date:   Sat, 12 Feb 2022 13:24:39 +0800
From:   kernel test robot <lkp@intel.com>
To:     Felix Fietkau <nbd@nbd.name>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [nbd168-wireless:mtk-flow-offload 9/9]
 drivers/net/wireless/mediatek/mt76/mt7915/mac.c:1414:28: warning: variable
 'phy' set but not used
Message-ID: <202202121320.bRZMLlj6-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/nbd168/wireless mtk-flow-offload
head:   1ba2137278dd5c4747b6e43be7aae4e94fb9c76e
commit: 1ba2137278dd5c4747b6e43be7aae4e94fb9c76e [9/9] mt76: mt7915: add Wireless Ethernet Dispatch support
config: arc-allyesconfig (https://download.01.org/0day-ci/archive/20220212/202202121320.bRZMLlj6-lkp@intel.com/config)
compiler: arceb-elf-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/nbd168/wireless/commit/1ba2137278dd5c4747b6e43be7aae4e94fb9c76e
        git remote add nbd168-wireless https://github.com/nbd168/wireless
        git fetch --no-tags nbd168-wireless mtk-flow-offload
        git checkout 1ba2137278dd5c4747b6e43be7aae4e94fb9c76e
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arc SHELL=/bin/bash drivers/net/wireless/mediatek/mt76/mt7915/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   drivers/net/wireless/mediatek/mt76/mt7915/mac.c: In function 'mt7915_txwi_free':
>> drivers/net/wireless/mediatek/mt76/mt7915/mac.c:1414:28: warning: variable 'phy' set but not used [-Wunused-but-set-variable]
    1414 |         struct mt7915_phy *phy;
         |                            ^~~


vim +/phy +1414 drivers/net/wireless/mediatek/mt76/mt7915/mac.c

  1407	
  1408	static void
  1409	mt7915_txwi_free(struct mt7915_dev *dev, struct mt76_txwi_cache *t,
  1410			 struct ieee80211_sta *sta, struct list_head *free_list)
  1411	{
  1412		struct mt76_dev *mdev = &dev->mt76;
  1413		struct mt7915_sta *msta;
> 1414		struct mt7915_phy *phy;
  1415		struct mt76_wcid *wcid;
  1416		__le32 *txwi;
  1417		u16 wcid_idx;
  1418	
  1419		mt7915_txp_skb_unmap(mdev, t);
  1420		if (!t->skb)
  1421			goto out;
  1422	
  1423		txwi = (__le32 *)mt76_get_txwi_ptr(mdev, t);
  1424		if (sta) {
  1425			wcid = (struct mt76_wcid *)sta->drv_priv;
  1426			wcid_idx = wcid->idx;
  1427		} else {
  1428			wcid_idx = FIELD_GET(MT_TXD1_WLAN_IDX, le32_to_cpu(txwi[1]));
  1429			wcid = rcu_dereference(dev->mt76.wcid[wcid_idx]);
  1430	
  1431			if (wcid && wcid->sta) {
  1432				msta = container_of(wcid, struct mt7915_sta, wcid);
  1433				sta = container_of((void *)msta, struct ieee80211_sta,
  1434						  drv_priv);
  1435				phy = msta->vif->phy;
  1436				spin_lock_bh(&dev->sta_poll_lock);
  1437				if (list_empty(&msta->poll_list))
  1438					list_add_tail(&msta->poll_list, &dev->sta_poll_list);
  1439				spin_unlock_bh(&dev->sta_poll_lock);
  1440			}
  1441		}
  1442	
  1443		if (sta && likely(t->skb->protocol != cpu_to_be16(ETH_P_PAE)))
  1444			mt7915_tx_check_aggr(sta, txwi);
  1445	
  1446		__mt76_tx_complete_skb(mdev, wcid_idx, t->skb, free_list);
  1447	
  1448	out:
  1449		t->skb = NULL;
  1450		mt76_put_txwi(mdev, t);
  1451	}
  1452	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
