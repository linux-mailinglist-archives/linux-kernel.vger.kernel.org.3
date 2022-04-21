Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51DAE50983A
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 09:05:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385340AbiDUGum (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 02:50:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1385401AbiDUGrs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 02:47:48 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A53CFF40
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 23:44:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650523493; x=1682059493;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=/gppJWCe0B7bleliwSDxhCbWIdMsp7TYejqO+tWtnpQ=;
  b=T22XB42PVhgr+DAiZdb9ZyUZcNyXJrSbpW8D3NO10VLjnC2siD7/z+ib
   bjPtn64Xzea21fmDGncMjK6FZqFc5JfwWbhSAK4jUbxiW6KCSfGHl8OYG
   3sEcKIzfUUS0SQctiHr1y0lQI84IDHuC9Qa61JMjA7ERYPBamDItAuY5q
   eBFo/grP1DOvRqlCV8uuEXf7ZUabUTq7RnQVj7iUStZHMLN3knO4RcoEe
   gpzVyUjpatWmDuPXeE8LzpFStDG9J9IeoKMdHVg3Vey6YXGNbJSw4w7Yv
   BPS77x1m5JNswKAQvwztlHSEkOpUUzJ5dG+3g38+BAdijzr0CynhB9Omm
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10323"; a="264022419"
X-IronPort-AV: E=Sophos;i="5.90,278,1643702400"; 
   d="scan'208";a="264022419"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2022 23:44:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,278,1643702400"; 
   d="scan'208";a="577052368"
Received: from lkp-server01.sh.intel.com (HELO 3abc53900bec) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 20 Apr 2022 23:44:52 -0700
Received: from kbuild by 3abc53900bec with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nhQYd-00081k-D7;
        Thu, 21 Apr 2022 06:44:51 +0000
Date:   Thu, 21 Apr 2022 14:44:26 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Kalle Valo <kvalo@codeaurora.org>
Subject: drivers/net/wireless/ath/wcn36xx/smd.c:2921
 wcn36xx_smd_gtk_offload_get_info_rsp() warn: inconsistent indenting
Message-ID: <202204211011.FHYvcCPz-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   b253435746d9a4a701b5f09211b9c14d3370d0da
commit: bedf1169bcae2f762b37d40dc9db648fe7ad1952 wcn36xx: Add GTK offload info to WoWLAN resume
date:   10 months ago
config: x86_64-randconfig-m001-20220418 (https://download.01.org/0day-ci/archive/20220421/202204211011.FHYvcCPz-lkp@intel.com/config)
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
