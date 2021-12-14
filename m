Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6655F47498C
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 18:34:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236516AbhLNReU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 12:34:20 -0500
Received: from mga03.intel.com ([134.134.136.65]:64946 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236513AbhLNReR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 12:34:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639503257; x=1671039257;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=3m4KrKgqDcX0rfsDzNXxYGp7TPhHBGaHWDD+JMQ8xOI=;
  b=XPYUAtyeUEZSTAmRxw3XYIaHI8VzKIdb18TRDPs1cgNp7lLpI0qMiXwp
   JMa4E10Tw+cS09mmTQZEKuryKpQKYCxXNbdtvxQgtdRimA4ligzvygj89
   4GIrkkBbkQeNhh83ea7qLQR7nMJp54sF4rShUKCY0H1loEZuK1WY8Y++m
   paUAkcc6cnp8PkYuk2Sri1BgPuOWP0tlu6XHnfL8l8gLpVeo9APEgLsFN
   Te7MvjWAy3pgus24ycuIxHQs+uhotQTJ9xsbd6nM/wyaJ7sOGNOxC8N2V
   dAEBnANj9EXJBp2k/+yDw5j1T9QkXDsQyAToc0fjpUBbEL5Z115WhpEps
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10197"; a="238981695"
X-IronPort-AV: E=Sophos;i="5.88,205,1635231600"; 
   d="scan'208";a="238981695"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2021 09:34:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,205,1635231600"; 
   d="scan'208";a="482041549"
Received: from lkp-server02.sh.intel.com (HELO 9f38c0981d9f) ([10.239.97.151])
  by orsmga002.jf.intel.com with ESMTP; 14 Dec 2021 09:34:15 -0800
Received: from kbuild by 9f38c0981d9f with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mxBgs-0000ZH-FD; Tue, 14 Dec 2021 17:34:14 +0000
Date:   Wed, 15 Dec 2021 01:33:56 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ryder Lee <ryder.lee@mediatek.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Felix Fietkau <nbd@nbd.name>
Subject: drivers/net/wireless/mediatek/mt76/mt7915/mcu.c:2393:5: warning: no
 previous prototype for function 'mt7915_mcu_set_fixed_rate'
Message-ID: <202112150129.mnFkjamR-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ryder,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   5472f14a37421d1bca3dddf33cabd3bd6dbefbbc
commit: 9a93364d6595358a11d07e7f4261ae263ae2a02a mt76: mt7915: rework debugfs fixed-rate knob
date:   7 weeks ago
config: arm64-randconfig-r026-20211214 (https://download.01.org/0day-ci/archive/20211215/202112150129.mnFkjamR-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project b6a2ddb6c8ac29412b1361810972e15221fa021c)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm64 cross compiling tool for clang build
        # apt-get install binutils-aarch64-linux-gnu
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=9a93364d6595358a11d07e7f4261ae263ae2a02a
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 9a93364d6595358a11d07e7f4261ae263ae2a02a
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm64 SHELL=/bin/bash drivers/net/wireless/mediatek/mt76/mt7915/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/net/wireless/mediatek/mt76/mt7915/mcu.c:2393:5: warning: no previous prototype for function 'mt7915_mcu_set_fixed_rate' [-Wmissing-prototypes]
   int mt7915_mcu_set_fixed_rate(struct mt7915_dev *dev,
       ^
   drivers/net/wireless/mediatek/mt76/mt7915/mcu.c:2393:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   int mt7915_mcu_set_fixed_rate(struct mt7915_dev *dev,
   ^
   static 
   1 warning generated.


vim +/mt7915_mcu_set_fixed_rate +2393 drivers/net/wireless/mediatek/mt76/mt7915/mcu.c

e57b7901469fc0b Ryder Lee     2020-04-25  2392  
9fac3c81eebd81b Ryder Lee     2020-04-25 @2393  int mt7915_mcu_set_fixed_rate(struct mt7915_dev *dev,
9fac3c81eebd81b Ryder Lee     2020-04-25  2394  			      struct ieee80211_sta *sta, u32 rate)
9fac3c81eebd81b Ryder Lee     2020-04-25  2395  {
9fac3c81eebd81b Ryder Lee     2020-04-25  2396  	struct mt7915_sta *msta = (struct mt7915_sta *)sta->drv_priv;
9fac3c81eebd81b Ryder Lee     2020-04-25  2397  	struct mt7915_vif *mvif = msta->vif;
9fac3c81eebd81b Ryder Lee     2020-04-25  2398  	struct sta_rec_ra_fixed *ra;
9fac3c81eebd81b Ryder Lee     2020-04-25  2399  	struct sk_buff *skb;
9fac3c81eebd81b Ryder Lee     2020-04-25  2400  	struct tlv *tlv;
3e68af622254bad Ryder Lee     2020-05-12  2401  	int len = sizeof(struct sta_req_hdr) + sizeof(*ra);
9fac3c81eebd81b Ryder Lee     2020-04-25  2402  
3e68af622254bad Ryder Lee     2020-05-12  2403  	skb = mt7915_mcu_alloc_sta_req(dev, mvif, msta, len);
9fac3c81eebd81b Ryder Lee     2020-04-25  2404  	if (IS_ERR(skb))
9fac3c81eebd81b Ryder Lee     2020-04-25  2405  		return PTR_ERR(skb);
9fac3c81eebd81b Ryder Lee     2020-04-25  2406  
9fac3c81eebd81b Ryder Lee     2020-04-25  2407  	tlv = mt7915_mcu_add_tlv(skb, STA_REC_RA_UPDATE, sizeof(*ra));
9fac3c81eebd81b Ryder Lee     2020-04-25  2408  	ra = (struct sta_rec_ra_fixed *)tlv;
9fac3c81eebd81b Ryder Lee     2020-04-25  2409  
9fac3c81eebd81b Ryder Lee     2020-04-25  2410  	if (!rate) {
9fac3c81eebd81b Ryder Lee     2020-04-25  2411  		ra->field = cpu_to_le32(RATE_PARAM_AUTO);
9fac3c81eebd81b Ryder Lee     2020-04-25  2412  		goto out;
9fac3c81eebd81b Ryder Lee     2020-04-25  2413  	}
9fac3c81eebd81b Ryder Lee     2020-04-25  2414  
4d2423326de9e98 Ryder Lee     2021-08-07  2415  	ra->field = cpu_to_le32(RATE_PARAM_FIXED);
9fac3c81eebd81b Ryder Lee     2020-04-25  2416  	ra->phy.type = FIELD_GET(RATE_CFG_PHY_TYPE, rate);
9fac3c81eebd81b Ryder Lee     2020-04-25  2417  	ra->phy.bw = FIELD_GET(RATE_CFG_BW, rate);
9fac3c81eebd81b Ryder Lee     2020-04-25  2418  	ra->phy.nss = FIELD_GET(RATE_CFG_NSS, rate);
9fac3c81eebd81b Ryder Lee     2020-04-25  2419  	ra->phy.mcs = FIELD_GET(RATE_CFG_MCS, rate);
9fac3c81eebd81b Ryder Lee     2020-04-25  2420  	ra->phy.stbc = FIELD_GET(RATE_CFG_STBC, rate);
9fac3c81eebd81b Ryder Lee     2020-04-25  2421  
9fac3c81eebd81b Ryder Lee     2020-04-25  2422  	if (ra->phy.bw)
9fac3c81eebd81b Ryder Lee     2020-04-25  2423  		ra->phy.ldpc = 7;
9fac3c81eebd81b Ryder Lee     2020-04-25  2424  	else
9fac3c81eebd81b Ryder Lee     2020-04-25  2425  		ra->phy.ldpc = FIELD_GET(RATE_CFG_LDPC, rate) * 7;
9fac3c81eebd81b Ryder Lee     2020-04-25  2426  
9fac3c81eebd81b Ryder Lee     2020-04-25  2427  	/* HT/VHT - SGI: 1, LGI: 0; HE - SGI: 0, MGI: 1, LGI: 2 */
4d2423326de9e98 Ryder Lee     2021-08-07  2428  	if (ra->phy.type > MT_PHY_TYPE_VHT) {
4d2423326de9e98 Ryder Lee     2021-08-07  2429  		ra->phy.he_ltf = FIELD_GET(RATE_CFG_HE_LTF, rate) * 85;
4d2423326de9e98 Ryder Lee     2021-08-07  2430  		ra->phy.sgi = FIELD_GET(RATE_CFG_GI, rate) * 85;
4d2423326de9e98 Ryder Lee     2021-08-07  2431  	} else {
4d2423326de9e98 Ryder Lee     2021-08-07  2432  		ra->phy.sgi = FIELD_GET(RATE_CFG_GI, rate) * 15;
4d2423326de9e98 Ryder Lee     2021-08-07  2433  	}
9fac3c81eebd81b Ryder Lee     2020-04-25  2434  
9fac3c81eebd81b Ryder Lee     2020-04-25  2435  out:
fa62d0e0080bca7 Felix Fietkau 2020-09-30  2436  	return mt76_mcu_skb_send_msg(&dev->mt76, skb,
c203dd621780842 Felix Fietkau 2021-01-06  2437  				     MCU_EXT_CMD(STA_REC_UPDATE), true);
9fac3c81eebd81b Ryder Lee     2020-04-25  2438  }
9fac3c81eebd81b Ryder Lee     2020-04-25  2439  

:::::: The code at line 2393 was first introduced by commit
:::::: 9fac3c81eebd81bbce8b050e15b03d3490841717 mt76: mt7915: set peer Tx fixed rate through debugfs

:::::: TO: Ryder Lee <ryder.lee@mediatek.com>
:::::: CC: Felix Fietkau <nbd@nbd.name>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
