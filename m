Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 497FC4B2D4F
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 20:12:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244933AbiBKTMK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 14:12:10 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:39366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234187AbiBKTMJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 14:12:09 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DD0DCE7
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 11:12:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644606727; x=1676142727;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=OpQRZh+mKPJH6X4O7agdIjv5RxBIcNXlPQT1ivzX0PA=;
  b=g5dq695VD40h/iDo8355ur4UcXrOkx5QVWaDyWiUCfHQSCta6EvJMMqb
   JbLI0KVFp7bgJ/VRYryfopfwL0PZvBZdqaGSq/36svOqDs7WsVp8dS1ml
   igZYfI/Q0sOgSK7NbXTdT+oPz5az5WM/9Tva0MU9q7Rj/xLJVngyJpsix
   KmhmYwfwChriykFKeDiP0RJTL7fwq/smanmWvniKa3ZNkOZHXyPYTBzsj
   mygDLWTUVgT8s8UVNHUBfFHvwPBVg2In4jX8wD8F4MKO2gAbUfdOrvZ7C
   VuNfx6JSdC8DHZOo9tdrXsxTs2ykqPe1ouBvAE8fEqe2p5yDURXO/cvEd
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10255"; a="249541536"
X-IronPort-AV: E=Sophos;i="5.88,361,1635231600"; 
   d="scan'208";a="249541536"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2022 11:12:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,361,1635231600"; 
   d="scan'208";a="488530711"
Received: from lkp-server01.sh.intel.com (HELO d95dc2dabeb1) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 11 Feb 2022 11:12:04 -0800
Received: from kbuild by d95dc2dabeb1 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nIbKu-00053L-9B; Fri, 11 Feb 2022 19:12:04 +0000
Date:   Sat, 12 Feb 2022 03:11:03 +0800
From:   kernel test robot <lkp@intel.com>
To:     Carl Huang <quic_cjhuang@quicinc.com>
Cc:     kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org, Kalle Valo <quic_kvalo@quicinc.com>,
        Baochen Qiang <quic_bqiang@quicinc.com>,
        Wen Gong <quic_wgong@quicinc.com>
Subject: [ammarfaizi2-block:kvalo/ath/pending-deferred 57/62]
 drivers/net/wireless/ath/ath11k/wow.c:466:5: error: redefinition of
 'ath11k_wow_init'
Message-ID: <202202120334.sUc5tt9e-lkp@intel.com>
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

tree:   https://github.com/ammarfaizi2/linux-block kvalo/ath/pending-deferred
head:   9a4dbe8c276e1d26533f2e4191c2b5dbef2d7b1e
commit: 24a2528121749a929923132e26ef5b0180e18544 [57/62] ath11k: Add basic WoW functionalities
config: parisc-allyesconfig (https://download.01.org/0day-ci/archive/20220212/202202120334.sUc5tt9e-lkp@intel.com/config)
compiler: hppa-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/ammarfaizi2/linux-block/commit/24a2528121749a929923132e26ef5b0180e18544
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block kvalo/ath/pending-deferred
        git checkout 24a2528121749a929923132e26ef5b0180e18544
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=parisc SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   drivers/net/wireless/ath/ath11k/wow.c:356:5: warning: no previous prototype for 'ath11k_wow_op_suspend' [-Wmissing-prototypes]
     356 | int ath11k_wow_op_suspend(struct ieee80211_hw *hw,
         |     ^~~~~~~~~~~~~~~~~~~~~
   drivers/net/wireless/ath/ath11k/wow.c:415:6: warning: no previous prototype for 'ath11k_wow_op_set_wakeup' [-Wmissing-prototypes]
     415 | void ath11k_wow_op_set_wakeup(struct ieee80211_hw *hw, bool enabled)
         |      ^~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/wireless/ath/ath11k/wow.c:424:5: warning: no previous prototype for 'ath11k_wow_op_resume' [-Wmissing-prototypes]
     424 | int ath11k_wow_op_resume(struct ieee80211_hw *hw)
         |     ^~~~~~~~~~~~~~~~~~~~
>> drivers/net/wireless/ath/ath11k/wow.c:466:5: error: redefinition of 'ath11k_wow_init'
     466 | int ath11k_wow_init(struct ath11k *ar)
         |     ^~~~~~~~~~~~~~~
   In file included from drivers/net/wireless/ath/ath11k/core.h:26,
                    from drivers/net/wireless/ath/ath11k/wow.c:11:
   drivers/net/wireless/ath/ath11k/wow.h:40:19: note: previous definition of 'ath11k_wow_init' with type 'int(struct ath11k *)'
      40 | static inline int ath11k_wow_init(struct ath11k *ar)
         |                   ^~~~~~~~~~~~~~~
   drivers/net/wireless/ath/ath11k/wow.c: In function 'ath11k_wow_init':
>> drivers/net/wireless/ath/ath11k/wow.c:481:22: error: 'struct wiphy' has no member named 'wowlan'
     481 |         ar->hw->wiphy->wowlan = &ar->wow.wowlan_support;
         |                      ^~


vim +/ath11k_wow_init +466 drivers/net/wireless/ath/ath11k/wow.c

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
