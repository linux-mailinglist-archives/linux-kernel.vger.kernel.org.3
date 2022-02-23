Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 188994C066F
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 01:53:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236495AbiBWAxj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 19:53:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231428AbiBWAxh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 19:53:37 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CA2B41FBF
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 16:53:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645577591; x=1677113591;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=1X6EdUwHgSXxs0uDxZpEWCGnTkJHgKcK3hvP+2WiMCY=;
  b=KDowUOjmaIq/g9yaJLT/xGxjO/VIBou81veHfWjlz10FgJKMJOyzfaKb
   nc7b9zJVv+VM7rz+6ojA1tVOOT5oVh7QLfWsPfNn4sAorSGnsgN30LUSW
   e2yyqTef4BBgD4cbeJ/Bya7FK3uip2CIeVNdo5vMrjq+wiPM6LEYHmOO5
   1NgC/F4HBtd26PQzE9pFpLwyXHt4ctFphdqDrIIlQup34KZPqCqby9CtB
   Mpmu7kQgVlUBc1b2AhfGPCC011gbAURZdLeAuuXWSUfcg6REnOsZKtpcY
   4VIx/Xdwb3//cA/ROIuD46MtUY5+/6ywgP88kn9riNcW6cJJCJOK89DGV
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10266"; a="276463931"
X-IronPort-AV: E=Sophos;i="5.88,389,1635231600"; 
   d="scan'208";a="276463931"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2022 16:53:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,389,1635231600"; 
   d="scan'208";a="683718715"
Received: from lkp-server01.sh.intel.com (HELO 788b1cd46f0d) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 22 Feb 2022 16:53:09 -0800
Received: from kbuild by 788b1cd46f0d with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nMfu0-0000nd-Oi; Wed, 23 Feb 2022 00:53:08 +0000
Date:   Wed, 23 Feb 2022 08:52:44 +0800
From:   kernel test robot <lkp@intel.com>
To:     Carl Huang <quic_cjhuang@quicinc.com>
Cc:     kbuild-all@lists.01.org, Kalle Valo <kvalo@codeaurora.org>,
        ath10k@lists.infradead.org, linux-kernel@vger.kernel.org,
        Kalle Valo <quic_kvalo@quicinc.com>,
        Baochen Qiang <quic_bqiang@quicinc.com>,
        Wen Gong <quic_wgong@quicinc.com>
Subject: [kvalo-ath:pending 37/42]
 drivers/net/wireless/ath/ath11k/wow.c:467:5: error: redefinition of
 'ath11k_wow_init'
Message-ID: <202202230812.uOGgSw5k-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git pending
head:   4136ddcfda28450e2d01173e37300b95c8687d9b
commit: cae84a492cacd9b4eecaafd5dab33f5beba8806e [37/42] ath11k: Add basic WoW functionalities
config: m68k-allyesconfig (https://download.01.org/0day-ci/archive/20220223/202202230812.uOGgSw5k-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git/commit/?id=cae84a492cacd9b4eecaafd5dab33f5beba8806e
        git remote add kvalo-ath https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git
        git fetch --no-tags kvalo-ath pending
        git checkout cae84a492cacd9b4eecaafd5dab33f5beba8806e
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=m68k SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   drivers/net/wireless/ath/ath11k/wow.c:357:5: warning: no previous prototype for 'ath11k_wow_op_suspend' [-Wmissing-prototypes]
     357 | int ath11k_wow_op_suspend(struct ieee80211_hw *hw,
         |     ^~~~~~~~~~~~~~~~~~~~~
   drivers/net/wireless/ath/ath11k/wow.c:416:6: warning: no previous prototype for 'ath11k_wow_op_set_wakeup' [-Wmissing-prototypes]
     416 | void ath11k_wow_op_set_wakeup(struct ieee80211_hw *hw, bool enabled)
         |      ^~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/wireless/ath/ath11k/wow.c:425:5: warning: no previous prototype for 'ath11k_wow_op_resume' [-Wmissing-prototypes]
     425 | int ath11k_wow_op_resume(struct ieee80211_hw *hw)
         |     ^~~~~~~~~~~~~~~~~~~~
>> drivers/net/wireless/ath/ath11k/wow.c:467:5: error: redefinition of 'ath11k_wow_init'
     467 | int ath11k_wow_init(struct ath11k *ar)
         |     ^~~~~~~~~~~~~~~
   In file included from drivers/net/wireless/ath/ath11k/core.h:26,
                    from drivers/net/wireless/ath/ath11k/wow.c:11:
   drivers/net/wireless/ath/ath11k/wow.h:40:19: note: previous definition of 'ath11k_wow_init' with type 'int(struct ath11k *)'
      40 | static inline int ath11k_wow_init(struct ath11k *ar)
         |                   ^~~~~~~~~~~~~~~
   drivers/net/wireless/ath/ath11k/wow.c: In function 'ath11k_wow_init':
>> drivers/net/wireless/ath/ath11k/wow.c:482:22: error: 'struct wiphy' has no member named 'wowlan'
     482 |         ar->hw->wiphy->wowlan = &ar->wow.wowlan_support;
         |                      ^~


vim +/ath11k_wow_init +467 drivers/net/wireless/ath/ath11k/wow.c

   466	
 > 467	int ath11k_wow_init(struct ath11k *ar)
   468	{
   469		if (WARN_ON(!test_bit(WMI_TLV_SERVICE_WOW, ar->wmi->wmi_ab->svc_map)))
   470			return -EINVAL;
   471	
   472		ar->wow.wowlan_support = ath11k_wowlan_support;
   473	
   474		if (ar->wmi->wmi_ab->wlan_resource_config.rx_decap_mode ==
   475		    ATH11K_HW_TXRX_NATIVE_WIFI) {
   476			ar->wow.wowlan_support.pattern_max_len -= WOW_MAX_REDUCE;
   477			ar->wow.wowlan_support.max_pkt_offset -= WOW_MAX_REDUCE;
   478		}
   479	
   480		ar->wow.max_num_patterns = ATH11K_WOW_PATTERNS;
   481		ar->wow.wowlan_support.n_patterns = ar->wow.max_num_patterns;
 > 482		ar->hw->wiphy->wowlan = &ar->wow.wowlan_support;

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
