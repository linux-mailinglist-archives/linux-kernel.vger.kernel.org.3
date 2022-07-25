Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FB9A57F93E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 07:56:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231577AbiGYF43 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 01:56:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232789AbiGYF4P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 01:56:15 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45D2712757
        for <linux-kernel@vger.kernel.org>; Sun, 24 Jul 2022 22:56:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658728564; x=1690264564;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=wyB8UbAUfamF2Wi+UQOkUPfW24UfVsXsvhjgsCzVTCI=;
  b=Uy73IUecUoEXA6BP6jQyQ3BdicqkcdHMb9NSyn3t2zNEAtCYWdbC6S36
   I1Pptwxkd47rDIXIX7Bxnx+M/HpXvDqSGzdad0y6PLBHvPWBiQF79kt3j
   KIRt1qPb1+RYE4fnfeebaJwPV1wjn6huxW0q+dk/6AHa7q2hoh5UlwK3Y
   +v2d8G7bebU7aw2Yo9FdRMDCLPvKb6FBgDHlJApiUQat2nUEutXMRTdNA
   29wycJ8da6dBT1/gX6UiuSR9Sgn5OVLatkRjrhWiOknQLzj1or+cD/Nl/
   6qowvM6Ij76Dq5xYv62F9szyuq5khOLwPcV90NjeyZnvMoo7lRIfyFbWZ
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10418"; a="287631251"
X-IronPort-AV: E=Sophos;i="5.93,192,1654585200"; 
   d="scan'208";a="287631251"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2022 22:56:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,192,1654585200"; 
   d="scan'208";a="926763896"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 24 Jul 2022 22:56:01 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oFr4T-0004mP-1E;
        Mon, 25 Jul 2022 05:56:01 +0000
Date:   Mon, 25 Jul 2022 13:55:46 +0800
From:   kernel test robot <lkp@intel.com>
To:     Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Felix Fietkau <nbd@nbd.name>
Subject: drivers/net/wireless/mediatek/mt76/mt7915/mac.c:2347:22: warning:
 taking address of packed member 'req_type' of class or structure
 'ieee80211_twt_params' may result in an unaligned pointer value
Message-ID: <202207251346.5l0YTQRD-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   e0dccc3b76fb35bb257b4118367a883073d7390e
commit: 3782b69d03e714b8ff98b84c7426d8cef0e64d7c mt76: mt7915: introduce mt7915_mac_add_twt_setup routine
date:   9 months ago
config: arm-buildonly-randconfig-r003-20220724 (https://download.01.org/0day-ci/archive/20220725/202207251346.5l0YTQRD-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 9e88cbcc403bdf82f29259ad60ff60a8fc4434a1)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm cross compiling tool for clang build
        # apt-get install binutils-arm-linux-gnueabi
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=3782b69d03e714b8ff98b84c7426d8cef0e64d7c
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 3782b69d03e714b8ff98b84c7426d8cef0e64d7c
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash drivers/net/wireless/mediatek/mt76/ drivers/usb/gadget/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/net/wireless/mediatek/mt76/mt7915/mac.c:2347:22: warning: taking address of packed member 'req_type' of class or structure 'ieee80211_twt_params' may result in an unaligned pointer value [-Waddress-of-packed-member]
           le16p_replace_bits(&twt_agrt->req_type, flowid,
                               ^~~~~~~~~~~~~~~~~~
   drivers/net/wireless/mediatek/mt76/mt7915/mac.c:2395:22: warning: taking address of packed member 'req_type' of class or structure 'ieee80211_twt_params' may result in an unaligned pointer value [-Waddress-of-packed-member]
           le16p_replace_bits(&twt_agrt->req_type, setup_cmd,
                               ^~~~~~~~~~~~~~~~~~
   2 warnings generated.


vim +2347 drivers/net/wireless/mediatek/mt76/mt7915/mac.c

  2320	
  2321	void mt7915_mac_add_twt_setup(struct ieee80211_hw *hw,
  2322				      struct ieee80211_sta *sta,
  2323				      struct ieee80211_twt_setup *twt)
  2324	{
  2325		enum ieee80211_twt_setup_cmd setup_cmd = TWT_SETUP_CMD_REJECT;
  2326		struct mt7915_sta *msta = (struct mt7915_sta *)sta->drv_priv;
  2327		struct ieee80211_twt_params *twt_agrt = (void *)twt->params;
  2328		u16 req_type = le16_to_cpu(twt_agrt->req_type);
  2329		enum ieee80211_twt_setup_cmd sta_setup_cmd;
  2330		struct mt7915_dev *dev = mt7915_hw_dev(hw);
  2331		struct mt7915_twt_flow *flow;
  2332		int flowid, table_id;
  2333		u8 exp;
  2334	
  2335		if (mt7915_mac_check_twt_req(twt))
  2336			goto out;
  2337	
  2338		mutex_lock(&dev->mt76.mutex);
  2339	
  2340		if (dev->twt.n_agrt == MT7915_MAX_TWT_AGRT)
  2341			goto unlock;
  2342	
  2343		if (hweight8(msta->twt.flowid_mask) == ARRAY_SIZE(msta->twt.flow))
  2344			goto unlock;
  2345	
  2346		flowid = ffs(~msta->twt.flowid_mask) - 1;
> 2347		le16p_replace_bits(&twt_agrt->req_type, flowid,
  2348				   IEEE80211_TWT_REQTYPE_FLOWID);
  2349	
  2350		table_id = ffs(~dev->twt.table_mask) - 1;
  2351		exp = FIELD_GET(IEEE80211_TWT_REQTYPE_WAKE_INT_EXP, req_type);
  2352		sta_setup_cmd = FIELD_GET(IEEE80211_TWT_REQTYPE_SETUP_CMD, req_type);
  2353	
  2354		flow = &msta->twt.flow[flowid];
  2355		memset(flow, 0, sizeof(*flow));
  2356		INIT_LIST_HEAD(&flow->list);
  2357		flow->wcid = msta->wcid.idx;
  2358		flow->table_id = table_id;
  2359		flow->id = flowid;
  2360		flow->duration = twt_agrt->min_twt_dur;
  2361		flow->mantissa = twt_agrt->mantissa;
  2362		flow->exp = exp;
  2363		flow->protection = !!(req_type & IEEE80211_TWT_REQTYPE_PROTECTION);
  2364		flow->flowtype = !!(req_type & IEEE80211_TWT_REQTYPE_FLOWTYPE);
  2365		flow->trigger = !!(req_type & IEEE80211_TWT_REQTYPE_TRIGGER);
  2366	
  2367		if (sta_setup_cmd == TWT_SETUP_CMD_REQUEST ||
  2368		    sta_setup_cmd == TWT_SETUP_CMD_SUGGEST) {
  2369			u64 interval = (u64)le16_to_cpu(twt_agrt->mantissa) << exp;
  2370			u64 flow_tsf, curr_tsf;
  2371			u32 rem;
  2372	
  2373			flow->sched = true;
  2374			flow->start_tsf = mt7915_mac_twt_sched_list_add(dev, flow);
  2375			curr_tsf = __mt7915_get_tsf(hw, msta->vif);
  2376			div_u64_rem(curr_tsf - flow->start_tsf, interval, &rem);
  2377			flow_tsf = curr_tsf + interval - rem;
  2378			twt_agrt->twt = cpu_to_le64(flow_tsf);
  2379		} else {
  2380			list_add_tail(&flow->list, &dev->twt_list);
  2381		}
  2382		flow->tsf = le64_to_cpu(twt_agrt->twt);
  2383	
  2384		if (mt7915_mcu_twt_agrt_update(dev, msta->vif, flow, MCU_TWT_AGRT_ADD))
  2385			goto unlock;
  2386	
  2387		setup_cmd = TWT_SETUP_CMD_ACCEPT;
  2388		dev->twt.table_mask |= BIT(table_id);
  2389		msta->twt.flowid_mask |= BIT(flowid);
  2390		dev->twt.n_agrt++;
  2391	
  2392	unlock:
  2393		mutex_unlock(&dev->mt76.mutex);
  2394	out:
  2395		le16p_replace_bits(&twt_agrt->req_type, setup_cmd,
  2396				   IEEE80211_TWT_REQTYPE_SETUP_CMD);
  2397		twt->control = (twt->control & IEEE80211_TWT_CONTROL_WAKE_DUR_UNIT) |
  2398			       (twt->control & IEEE80211_TWT_CONTROL_RX_DISABLED);
  2399	}
  2400	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
