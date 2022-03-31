Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6BBB4EE281
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 22:19:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235411AbiCaUUL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 16:20:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232815AbiCaUUJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 16:20:09 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4527449F96
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 13:18:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648757900; x=1680293900;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=t14If84QyvMWIv6XQCAXo4CPitLRFThvQsoB7XV0uMY=;
  b=BzavnIQVmBBrPWiEE2rN18ZJ/2TXp6l6VpHGJU0I0o9YXp59tB91wINA
   ld7QAt0TkVHPwgMXQx12/i0tHvFPIPw7IlSEGHsJwiC6VMnXynZQqfOuA
   RwM2GazeJMKBb1Uh1sc6rR3/dpXi/oMCt9LXNoxS+7AN5ghJrNEgz24hU
   rH4EIyae3E/Dovr+ZYvV1e8VDcJ1x5y6/0SOBO8uuY7VMTNkQBc1g85++
   shI4rVKY1z6JiPb0LILqYm9y9g00OdxoVOfuA8P7NdKPXWhfoXNMMkgTP
   5M4mf0+7BMceKcX5CYnGV7ud9HbUUigoXl/c+yPnsGGrooVKWVbtms8yk
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10302"; a="346392907"
X-IronPort-AV: E=Sophos;i="5.90,225,1643702400"; 
   d="scan'208";a="346392907"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2022 13:18:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,225,1643702400"; 
   d="scan'208";a="566798351"
Received: from lkp-server02.sh.intel.com (HELO 3231c491b0e2) ([10.239.97.151])
  by orsmga008.jf.intel.com with ESMTP; 31 Mar 2022 13:18:17 -0700
Received: from kbuild by 3231c491b0e2 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1na1FI-0000cq-Hp;
        Thu, 31 Mar 2022 20:18:16 +0000
Date:   Fri, 1 Apr 2022 04:18:11 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Kalle Valo <kvalo@codeaurora.org>
Subject: drivers/net/wireless/ath/wcn36xx/smd.c:2921
 wcn36xx_smd_gtk_offload_get_info_rsp() warn: inconsistent indenting
Message-ID: <202204010433.RPAzSi9S-lkp@intel.com>
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

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   787af64d05cd528aac9ad16752d11bb1c6061bb9
commit: bedf1169bcae2f762b37d40dc9db648fe7ad1952 wcn36xx: Add GTK offload info to WoWLAN resume
date:   10 months ago
config: mips-randconfig-m031-20220331 (https://download.01.org/0day-ci/archive/20220401/202204010433.RPAzSi9S-lkp@intel.com/config)
compiler: mipsel-linux-gcc (GCC) 11.2.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

New smatch warnings:
drivers/net/wireless/ath/wcn36xx/smd.c:2921 wcn36xx_smd_gtk_offload_get_info_rsp() warn: inconsistent indenting

Old smatch warnings:
drivers/net/wireless/ath/wcn36xx/smd.c:525 wcn36xx_smd_load_nv() error: we previously assumed 'wcn->nv' could be null (see line 516)
drivers/net/wireless/ath/wcn36xx/smd.c:1909 wcn36xx_smd_send_beacon() warn: potential spectre issue 'msg_body.beacon' [w]

vim +2921 drivers/net/wireless/ath/wcn36xx/smd.c

  2896	
  2897	static int wcn36xx_smd_gtk_offload_get_info_rsp(struct wcn36xx *wcn,
  2898							struct ieee80211_vif *vif)
  2899	{
  2900		struct wcn36xx_vif *vif_priv = wcn36xx_vif_to_priv(vif);
  2901		struct wcn36xx_hal_gtk_offload_get_info_rsp_msg *rsp;
  2902		__be64 replay_ctr;
  2903	
  2904		if (wcn36xx_smd_rsp_status_check(wcn->hal_buf, wcn->hal_rsp_len))
  2905			return -EIO;
  2906	
  2907		rsp = (struct wcn36xx_hal_gtk_offload_get_info_rsp_msg *)wcn->hal_buf;
  2908	
  2909		if (rsp->bss_index != vif_priv->bss_index) {
  2910			wcn36xx_err("gtk_offload_info invalid response bss index %d\n",
  2911				    rsp->bss_index);
  2912			return -ENOENT;
  2913		}
  2914	
  2915		if (vif_priv->rekey_data.replay_ctr != cpu_to_le64(rsp->key_replay_counter)) {
  2916			replay_ctr = cpu_to_be64(rsp->key_replay_counter);
  2917			vif_priv->rekey_data.replay_ctr =
  2918				cpu_to_le64(rsp->key_replay_counter);
  2919			ieee80211_gtk_rekey_notify(vif, vif->bss_conf.bssid,
  2920						   (void *)&replay_ctr, GFP_KERNEL);
> 2921			 wcn36xx_dbg(WCN36XX_DBG_HAL,
  2922				     "GTK replay counter increment %llu\n",
  2923				     rsp->key_replay_counter);
  2924		}
  2925	
  2926		wcn36xx_dbg(WCN36XX_DBG_HAL,
  2927			    "gtk offload info status %d last_rekey_status %d "
  2928			    "replay_counter %llu total_rekey_count %d gtk_rekey_count %d "
  2929			    "igtk_rekey_count %d bss_index %d\n",
  2930			    rsp->status, rsp->last_rekey_status,
  2931			    rsp->key_replay_counter, rsp->total_rekey_count,
  2932			    rsp->gtk_rekey_count, rsp->igtk_rekey_count,
  2933			    rsp->bss_index);
  2934	
  2935		return 0;
  2936	}
  2937	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
