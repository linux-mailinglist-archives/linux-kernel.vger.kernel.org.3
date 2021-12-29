Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 181C4481520
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Dec 2021 17:38:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240805AbhL2QiN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Dec 2021 11:38:13 -0500
Received: from mga07.intel.com ([134.134.136.100]:1641 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240794AbhL2QiM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Dec 2021 11:38:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640795892; x=1672331892;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=lp2LunFintpzxpvq6k+vcg4Yxil9Vg0kewdsPyRPqkQ=;
  b=gvNzImYtOZUheEMzRJvduVEJsPPxEHvZ/Im//Ukil5WWjwrDFPbHVCm5
   0Ak2BWmymIISMWg6SeNIWFKIr60IzAKDdntAFSQZkOdRiW2SnLVj4/X3p
   u1V3zWvzMRThm2bBwdAFsI2yJdoNkj8xQwvoFSfLVm9gG080iKgTooRnQ
   QF8cqqJflYEA4TeH0dw53ymu9Aj3H4wYuwtqkzQ2oo7gSoV3PHfLuFb6i
   9Mcz7W1q6uKcAX9BHhVAZ3icImgGJFDgQloqfjvZY81hE3teFM9EuUf9C
   xN2jQFo14o5x6IWLUxrNsNQd9Aq7jDSz6fqLu/EaCr4T00i7gg4p1Ntx8
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10211"; a="304899339"
X-IronPort-AV: E=Sophos;i="5.88,245,1635231600"; 
   d="scan'208";a="304899339"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Dec 2021 08:38:12 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,245,1635231600"; 
   d="scan'208";a="470389271"
Received: from lkp-server01.sh.intel.com (HELO e357b3ef1427) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 29 Dec 2021 08:38:11 -0800
Received: from kbuild by e357b3ef1427 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n2bxq-0009DB-HO; Wed, 29 Dec 2021 16:38:10 +0000
Date:   Thu, 30 Dec 2021 00:37:28 +0800
From:   kernel test robot <lkp@intel.com>
To:     Felix Fietkau <nbd@nbd.name>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [nbd168-wireless:mt76 61/62]
 drivers/net/wireless/mediatek/mt76/mt7615/main.c:408:35: warning: implicit
 conversion from 'enum mcu_cipher_type' to 'enum mt76_cipher_type'
Message-ID: <202112300039.Vl9TunbG-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/nbd168/wireless mt76
head:   b18073c341fd3b4143cd034decb0ad8544b51bdf
commit: ef1e7305c000792e704ba70d34ad653224d56d24 [61/62] mt76: mt7615: update bss_info with cipher after setting the group key
config: alpha-allyesconfig (https://download.01.org/0day-ci/archive/20211230/202112300039.Vl9TunbG-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/nbd168/wireless/commit/ef1e7305c000792e704ba70d34ad653224d56d24
        git remote add nbd168-wireless https://github.com/nbd168/wireless
        git fetch --no-tags nbd168-wireless mt76
        git checkout ef1e7305c000792e704ba70d34ad653224d56d24
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=alpha SHELL=/bin/bash drivers/net/wireless/mediatek/mt76/mt7615/ drivers/net/wireless/mediatek/mt76/mt7915/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   drivers/net/wireless/mediatek/mt76/mt7615/main.c: In function 'mt7615_set_key':
>> drivers/net/wireless/mediatek/mt76/mt7615/main.c:408:35: warning: implicit conversion from 'enum mcu_cipher_type' to 'enum mt76_cipher_type' [-Wenum-conversion]
     408 |                 mvif->mt76.cipher = mt76_connac_mcu_get_cipher(key->cipher);
         |                                   ^


vim +408 drivers/net/wireless/mediatek/mt76/mt7615/main.c

   362	
   363	static int mt7615_set_key(struct ieee80211_hw *hw, enum set_key_cmd cmd,
   364				  struct ieee80211_vif *vif, struct ieee80211_sta *sta,
   365				  struct ieee80211_key_conf *key)
   366	{
   367		struct mt7615_dev *dev = mt7615_hw_dev(hw);
   368		struct mt7615_phy *phy = mt7615_hw_phy(hw);
   369		struct mt7615_vif *mvif = (struct mt7615_vif *)vif->drv_priv;
   370		struct mt7615_sta *msta = sta ? (struct mt7615_sta *)sta->drv_priv :
   371					  &mvif->sta;
   372		struct mt76_wcid *wcid = &msta->wcid;
   373		int idx = key->keyidx, err = 0;
   374		u8 *wcid_keyidx = &wcid->hw_key_idx;
   375	
   376		/* The hardware does not support per-STA RX GTK, fallback
   377		 * to software mode for these.
   378		 */
   379		if ((vif->type == NL80211_IFTYPE_ADHOC ||
   380		     vif->type == NL80211_IFTYPE_MESH_POINT) &&
   381		    (key->cipher == WLAN_CIPHER_SUITE_TKIP ||
   382		     key->cipher == WLAN_CIPHER_SUITE_CCMP) &&
   383		    !(key->flags & IEEE80211_KEY_FLAG_PAIRWISE))
   384			return -EOPNOTSUPP;
   385	
   386		/* fall back to sw encryption for unsupported ciphers */
   387		switch (key->cipher) {
   388		case WLAN_CIPHER_SUITE_AES_CMAC:
   389			wcid_keyidx = &wcid->hw_key_idx2;
   390			key->flags |= IEEE80211_KEY_FLAG_GENERATE_MMIE;
   391			break;
   392		case WLAN_CIPHER_SUITE_TKIP:
   393		case WLAN_CIPHER_SUITE_CCMP:
   394		case WLAN_CIPHER_SUITE_CCMP_256:
   395		case WLAN_CIPHER_SUITE_GCMP:
   396		case WLAN_CIPHER_SUITE_GCMP_256:
   397		case WLAN_CIPHER_SUITE_SMS4:
   398			break;
   399		case WLAN_CIPHER_SUITE_WEP40:
   400		case WLAN_CIPHER_SUITE_WEP104:
   401		default:
   402			return -EOPNOTSUPP;
   403		}
   404	
   405		mt7615_mutex_acquire(dev);
   406	
   407		if (cmd == SET_KEY && !sta && !mvif->mt76.cipher) {
 > 408			mvif->mt76.cipher = mt76_connac_mcu_get_cipher(key->cipher);
   409			mt7615_mcu_add_bss_info(phy, vif, NULL, true);
   410		}
   411	
   412		if (cmd == SET_KEY)
   413			*wcid_keyidx = idx;
   414		else if (idx == *wcid_keyidx)
   415			*wcid_keyidx = -1;
   416		else
   417			goto out;
   418	
   419		mt76_wcid_key_setup(&dev->mt76, wcid,
   420				    cmd == SET_KEY ? key : NULL);
   421	
   422		if (mt76_is_mmio(&dev->mt76))
   423			err = mt7615_mac_wtbl_set_key(dev, wcid, key, cmd);
   424		else
   425			err = __mt7615_mac_wtbl_set_key(dev, wcid, key, cmd);
   426	
   427	out:
   428		mt7615_mutex_release(dev);
   429	
   430		return err;
   431	}
   432	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
