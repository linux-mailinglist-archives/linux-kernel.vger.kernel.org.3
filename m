Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F32AC50C997
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Apr 2022 13:33:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235224AbiDWLgT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Apr 2022 07:36:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232036AbiDWLgR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Apr 2022 07:36:17 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24BCC23B99F
        for <linux-kernel@vger.kernel.org>; Sat, 23 Apr 2022 04:33:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650713600; x=1682249600;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=FmWzH5rzWS9kWfEW69ioQpm+6UDQflf1hpgxUSBNGB4=;
  b=XT8BC0IyJNiZrzgu4UXdITP7LIIyvrVXBvAaHM0YBsfKA1JpnOrQ2ADC
   tApGUM2tZz3eGO82z/yPqbR/38jEQEKPsAvm6Xbb4RbfNnQ+8Ax13SYMY
   LQm0gQFOeY4ckb0I7CLGaOnbkrc5DhHmWwPgyAN2ZRQbB89Gs/4Qq8yGb
   B8MMXtnk4/e0rQhtQzDZ9lkL/QiroaGfGNFUz35PaogZ4JHGQdHXbDnDn
   h+ZqIkj3UHr4bUQEm5wdWo2tC36jDre+EWRo9l3QqcWhIeyBKgaXaPxE/
   jVGjbr1SUGyPSE0hf+mLqayVRnIetLk4oz8Zn9Jw1WVcZNaUm4HCSfqZw
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10324"; a="245455002"
X-IronPort-AV: E=Sophos;i="5.90,284,1643702400"; 
   d="scan'208";a="245455002"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2022 04:33:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,284,1643702400"; 
   d="scan'208";a="615788460"
Received: from lkp-server01.sh.intel.com (HELO dd58949a6e39) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 23 Apr 2022 04:33:18 -0700
Received: from kbuild by dd58949a6e39 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1niE0s-0000Ct-4b;
        Sat, 23 Apr 2022 11:33:18 +0000
Date:   Sat, 23 Apr 2022 19:32:48 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Kalle Valo <kvalo@codeaurora.org>
Subject: drivers/net/wireless/ath/wcn36xx/smd.c:2921
 wcn36xx_smd_gtk_offload_get_info_rsp() warn: inconsistent indenting
Message-ID: <202204231946.6dxI8t51-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   c00c5e1d157bec0ef0b0b59aa5482eb8dc7e8e49
commit: bedf1169bcae2f762b37d40dc9db648fe7ad1952 wcn36xx: Add GTK offload info to WoWLAN resume
date:   10 months ago
config: x86_64-randconfig-m001-20220418 (https://download.01.org/0day-ci/archive/20220423/202204231946.6dxI8t51-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.2.0-19) 11.2.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

New smatch warnings:
drivers/net/wireless/ath/wcn36xx/smd.c:2921 wcn36xx_smd_gtk_offload_get_info_rsp() warn: inconsistent indenting

Old smatch warnings:
drivers/net/wireless/ath/wcn36xx/smd.c:525 wcn36xx_smd_load_nv() error: we previously assumed 'wcn->nv' could be null (see line 516)
drivers/net/wireless/ath/wcn36xx/smd.c:1908 wcn36xx_smd_send_beacon() warn: potential spectre issue 'msg_body.beacon' [w]

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
