Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4F334B2C50
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 19:00:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352445AbiBKSAI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 13:00:08 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:48428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244616AbiBKSAG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 13:00:06 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AADDCD3
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 10:00:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644602404; x=1676138404;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=4hQe/gaqC8VJ4miQIXlMaSjVco1XU+NwrK+DxptlP7o=;
  b=O7OLyhNlyrigUzwtMv+s0rblJELNNQE3d7mmgkPmTLn6SFUMm4kd709a
   cfqSrO06XT+dbhizaZT8a05+zSYFZQdJHMPJEpU9chmDN1xLW4G7F4+4f
   gnErBgikSqNYCwBfLcU2AR4/24lB9LW1KrAFlr/gQ36chfSxVJLzGsKxT
   bWZ4BGvo1JQ0iJj8ihirUiT3MFTytR1vhJTDqKTyHW/7qZkJzTbB/o47k
   dVBwyJQCRopTgl0jWpJghOD+bDJ5jHiMWauTFl4FH2tQW0gkQcIkUMCKN
   Hf3+BNmqvPetOeb1Zj0XMaSE/uP9wITURhw/XgBc6HhHLjcSmV8Ry0RmE
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10255"; a="248609109"
X-IronPort-AV: E=Sophos;i="5.88,361,1635231600"; 
   d="scan'208";a="248609109"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2022 10:00:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,361,1635231600"; 
   d="scan'208";a="679574080"
Received: from lkp-server01.sh.intel.com (HELO d95dc2dabeb1) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 11 Feb 2022 10:00:02 -0800
Received: from kbuild by d95dc2dabeb1 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nIaDB-0004w3-DM; Fri, 11 Feb 2022 18:00:01 +0000
Date:   Sat, 12 Feb 2022 01:59:17 +0800
From:   kernel test robot <lkp@intel.com>
To:     Carl Huang <quic_cjhuang@quicinc.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org, Kalle Valo <quic_kvalo@quicinc.com>,
        Baochen Qiang <quic_bqiang@quicinc.com>,
        Wen Gong <quic_wgong@quicinc.com>
Subject: [ammarfaizi2-block:kvalo/ath/pending-deferred 57/62]
 drivers/net/wireless/ath/ath11k/wow.c:481:17: error: no member named
 'wowlan' in 'struct wiphy'
Message-ID: <202202120027.x2o1HiR8-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ammarfaizi2/linux-block kvalo/ath/pending-deferred
head:   9a4dbe8c276e1d26533f2e4191c2b5dbef2d7b1e
commit: 24a2528121749a929923132e26ef5b0180e18544 [57/62] ath11k: Add basic WoW functionalities
config: hexagon-randconfig-r005-20220211 (https://download.01.org/0day-ci/archive/20220212/202202120027.x2o1HiR8-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project f6685f774697c85d6a352dcea013f46a99f9fe31)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/ammarfaizi2/linux-block/commit/24a2528121749a929923132e26ef5b0180e18544
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block kvalo/ath/pending-deferred
        git checkout 24a2528121749a929923132e26ef5b0180e18544
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=hexagon SHELL=/bin/bash drivers/net/wireless/ath/ath11k/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All error/warnings (new ones prefixed by >>):

>> drivers/net/wireless/ath/ath11k/wow.c:356:5: warning: no previous prototype for function 'ath11k_wow_op_suspend' [-Wmissing-prototypes]
   int ath11k_wow_op_suspend(struct ieee80211_hw *hw,
       ^
   drivers/net/wireless/ath/ath11k/wow.c:356:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   int ath11k_wow_op_suspend(struct ieee80211_hw *hw,
   ^
   static 
>> drivers/net/wireless/ath/ath11k/wow.c:415:6: warning: no previous prototype for function 'ath11k_wow_op_set_wakeup' [-Wmissing-prototypes]
   void ath11k_wow_op_set_wakeup(struct ieee80211_hw *hw, bool enabled)
        ^
   drivers/net/wireless/ath/ath11k/wow.c:415:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void ath11k_wow_op_set_wakeup(struct ieee80211_hw *hw, bool enabled)
   ^
   static 
>> drivers/net/wireless/ath/ath11k/wow.c:424:5: warning: no previous prototype for function 'ath11k_wow_op_resume' [-Wmissing-prototypes]
   int ath11k_wow_op_resume(struct ieee80211_hw *hw)
       ^
   drivers/net/wireless/ath/ath11k/wow.c:424:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   int ath11k_wow_op_resume(struct ieee80211_hw *hw)
   ^
   static 
   drivers/net/wireless/ath/ath11k/wow.c:466:5: error: redefinition of 'ath11k_wow_init'
   int ath11k_wow_init(struct ath11k *ar)
       ^
   drivers/net/wireless/ath/ath11k/wow.h:40:19: note: previous definition is here
   static inline int ath11k_wow_init(struct ath11k *ar)
                     ^
>> drivers/net/wireless/ath/ath11k/wow.c:481:17: error: no member named 'wowlan' in 'struct wiphy'
           ar->hw->wiphy->wowlan = &ar->wow.wowlan_support;
           ~~~~~~~~~~~~~  ^
   3 warnings and 2 errors generated.


vim +481 drivers/net/wireless/ath/ath11k/wow.c

   355	
 > 356	int ath11k_wow_op_suspend(struct ieee80211_hw *hw,
   357				  struct cfg80211_wowlan *wowlan)
   358	{
   359		struct ath11k *ar = hw->priv;
   360		int ret;
   361	
   362		mutex_lock(&ar->conf_mutex);
   363	
   364		ret =  ath11k_wow_cleanup(ar);
   365		if (ret) {
   366			ath11k_warn(ar->ab, "failed to clear wow wakeup events: %d\n",
   367				    ret);
   368			goto exit;
   369		}
   370	
   371		ret = ath11k_wow_set_wakeups(ar, wowlan);
   372		if (ret) {
   373			ath11k_warn(ar->ab, "failed to set wow wakeup events: %d\n",
   374				    ret);
   375			goto cleanup;
   376		}
   377	
   378		ret = ath11k_mac_wait_tx_complete(ar);
   379		if (ret) {
   380			ath11k_warn(ar->ab, "failed to wait tx complete: %d\n", ret);
   381			goto cleanup;
   382		}
   383	
   384		ret = ath11k_wow_enable(ar->ab);
   385		if (ret) {
   386			ath11k_warn(ar->ab, "failed to start wow: %d\n", ret);
   387			goto cleanup;
   388		}
   389	
   390		ath11k_ce_stop_shadow_timers(ar->ab);
   391		ath11k_dp_stop_shadow_timers(ar->ab);
   392	
   393		ath11k_hif_irq_disable(ar->ab);
   394		ath11k_hif_ce_irq_disable(ar->ab);
   395	
   396		ret = ath11k_hif_suspend(ar->ab);
   397		if (ret) {
   398			ath11k_warn(ar->ab, "failed to suspend hif: %d\n", ret);
   399			goto wakeup;
   400		}
   401	
   402		goto exit;
   403	
   404	wakeup:
   405		ath11k_wow_wakeup(ar->ab);
   406	
   407	cleanup:
   408		ath11k_wow_cleanup(ar);
   409	
   410	exit:
   411		mutex_unlock(&ar->conf_mutex);
   412		return ret ? 1 : 0;
   413	}
   414	
 > 415	void ath11k_wow_op_set_wakeup(struct ieee80211_hw *hw, bool enabled)
   416	{
   417		struct ath11k *ar = hw->priv;
   418	
   419		mutex_lock(&ar->conf_mutex);
   420		device_set_wakeup_enable(ar->ab->dev, enabled);
   421		mutex_unlock(&ar->conf_mutex);
   422	}
   423	
 > 424	int ath11k_wow_op_resume(struct ieee80211_hw *hw)
   425	{
   426		struct ath11k *ar = hw->priv;
   427		int ret;
   428	
   429		mutex_lock(&ar->conf_mutex);
   430	
   431		ret = ath11k_hif_resume(ar->ab);
   432		if (ret) {
   433			ath11k_warn(ar->ab, "failed to resume hif: %d\n", ret);
   434			goto exit;
   435		}
   436	
   437		ath11k_hif_ce_irq_enable(ar->ab);
   438		ath11k_hif_irq_enable(ar->ab);
   439	
   440		ret = ath11k_wow_wakeup(ar->ab);
   441		if (ret)
   442			ath11k_warn(ar->ab, "failed to wakeup from wow: %d\n", ret);
   443	
   444	exit:
   445		if (ret) {
   446			switch (ar->state) {
   447			case ATH11K_STATE_ON:
   448				ar->state = ATH11K_STATE_RESTARTING;
   449				ret = 1;
   450				break;
   451			case ATH11K_STATE_OFF:
   452			case ATH11K_STATE_RESTARTING:
   453			case ATH11K_STATE_RESTARTED:
   454			case ATH11K_STATE_WEDGED:
   455				ath11k_warn(ar->ab, "encountered unexpected device state %d on resume, cannot recover\n",
   456					    ar->state);
   457				ret = -EIO;
   458				break;
   459			}
   460		}
   461	
   462		mutex_unlock(&ar->conf_mutex);
   463		return ret;
   464	}
   465	
 > 466	int ath11k_wow_init(struct ath11k *ar)
   467	{
   468		if (WARN_ON(!test_bit(WMI_TLV_SERVICE_WOW, ar->wmi->wmi_ab->svc_map)))
   469			return -EINVAL;
   470	
   471		ar->wow.wowlan_support = ath11k_wowlan_support;
   472	
   473		if (ar->wmi->wmi_ab->wlan_resource_config.rx_decap_mode ==
   474		    ATH11K_HW_TXRX_NATIVE_WIFI) {
   475			ar->wow.wowlan_support.pattern_max_len -= WOW_MAX_REDUCE;
   476			ar->wow.wowlan_support.max_pkt_offset -= WOW_MAX_REDUCE;
   477		}
   478	
   479		ar->wow.max_num_patterns = ATH11K_WOW_PATTERNS;
   480		ar->wow.wowlan_support.n_patterns = ar->wow.max_num_patterns;
 > 481		ar->hw->wiphy->wowlan = &ar->wow.wowlan_support;

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
