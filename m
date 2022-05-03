Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48DFD517C47
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 05:42:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230431AbiECDnA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 23:43:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230403AbiECDmt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 23:42:49 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF94E3C4A9
        for <linux-kernel@vger.kernel.org>; Mon,  2 May 2022 20:39:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651549157; x=1683085157;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=u/vRBXs/PzG8wVyfT8hrzxrE1AWCzBRb6QNdElUcqHI=;
  b=AkBhGIqiYQhcKa2p3P6xj/EXdkJakpBRfnA/33l4kT1Wa4cF4iQVfN/6
   NqUEHT6lXBZtID2wPbj79Ao4dsz2LTuijgkzft9xVo8TXN2aZD9hNAzpi
   FXu2wNgObd/jRVcCt+kCii28jlw0jLAba14+h1MvrvcsVF5NN1YoW5EMZ
   78NZ3z6WL0NootJ2ZKid+jU2HSHjPdaVm9ytQYj0oo68Q9mDFv+0x+NVo
   D/wQpWeD8rAzLX4xGozn0QV2v0V/NxBxTgAdBAsqGGDjJfjxn1BXpaXZv
   2mghJwFtqRnYl/pJ1dXNpM12g6rDnCNe3XjNAjrVOiGCXEhYPJRSD7E3o
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10335"; a="267266135"
X-IronPort-AV: E=Sophos;i="5.91,194,1647327600"; 
   d="scan'208";a="267266135"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2022 20:39:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,194,1647327600"; 
   d="scan'208";a="663816394"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 02 May 2022 20:39:15 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nljNb-000A7q-4S;
        Tue, 03 May 2022 03:39:15 +0000
Date:   Tue, 3 May 2022 11:38:41 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Kalle Valo <kvalo@codeaurora.org>
Subject: drivers/net/wireless/ath/wcn36xx/smd.c:2921
 wcn36xx_smd_gtk_offload_get_info_rsp() warn: inconsistent indenting
Message-ID: <202205031153.oyQ1vVL3-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   9050ba3a61a4b5bd84c2cde092a100404f814f31
commit: bedf1169bcae2f762b37d40dc9db648fe7ad1952 wcn36xx: Add GTK offload info to WoWLAN resume
date:   11 months ago
config: i386-randconfig-m021-20220502 (https://download.01.org/0day-ci/archive/20220503/202205031153.oyQ1vVL3-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.2.0-20) 11.2.0

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
