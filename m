Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11377489012
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 07:16:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238945AbiAJGQN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 01:16:13 -0500
Received: from mga17.intel.com ([192.55.52.151]:36964 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234844AbiAJGQM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 01:16:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641795372; x=1673331372;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=B06A3u6gFx4FxgHVcZ1+mhwy9kIYXfRppFBd1wrgXyU=;
  b=e+B8WsklhqWLfxXCFmekCh4Bk7MX3O44Z1xDJAhr45fDna4KiCEmAq2h
   U0PE7rp4dsJZv/uZS/5QCQjfJAJV36mXLkso4xi11BcvzXg8SocJjLn49
   aDahzAd60uB0gnuWVmuzIWAiepjUYmZeww3SkbdUcn60L0e1WbNhTprBt
   nQDEyk66WShe2DWlNncEPvKG1bCCn3owq4trR9OkF0qbTorTHCKTAhgIx
   eVAicg8v6HA8Y7QKLDQ/rt9BMlP4TSYyGEIXU68r0XCInZGgmMQlZU+Js
   2vNUEYL8AcsXEQt4QuhChpYHzDbpkveeX8tGVaV8BHDGktKwVaWIIS1Ld
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10222"; a="223855901"
X-IronPort-AV: E=Sophos;i="5.88,276,1635231600"; 
   d="scan'208";a="223855901"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jan 2022 22:16:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,276,1635231600"; 
   d="scan'208";a="575719236"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 09 Jan 2022 22:16:09 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n6nyS-0002JI-AX; Mon, 10 Jan 2022 06:16:08 +0000
Date:   Mon, 10 Jan 2022 14:15:59 +0800
From:   kernel test robot <lkp@intel.com>
To:     Phillip Potter <phil@philpotter.co.uk>, gregkh@linuxfoundation.org
Cc:     kbuild-all@lists.01.org, Larry.Finger@lwfinger.net,
        straube.linux@gmail.com, martin@kaiser.cx,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/7] staging: r8188eu: convert DBG_88E calls in
 core/rtw_mlme_ext.c
Message-ID: <202201101405.RNRjMxAF-lkp@intel.com>
References: <20220109215427.887-7-phil@philpotter.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220109215427.887-7-phil@philpotter.co.uk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Phillip,

I love your patch! Yet something to improve:

[auto build test ERROR on staging/staging-testing]

url:    https://github.com/0day-ci/linux/commits/Phillip-Potter/staging-r8188eu-further-per-file-DBG_88E-cleanups/20220110-055642
base:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git fa783154524a71ab74e293cd8251155e5971952b
config: i386-allyesconfig (https://download.01.org/0day-ci/archive/20220110/202201101405.RNRjMxAF-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build):
        # https://github.com/0day-ci/linux/commit/cc951de8ec99ed47dd19c0c276799a9ac0d679d4
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Phillip-Potter/staging-r8188eu-further-per-file-DBG_88E-cleanups/20220110-055642
        git checkout cc951de8ec99ed47dd19c0c276799a9ac0d679d4
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash drivers/staging/r8188eu/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   drivers/staging/r8188eu/core/rtw_mlme_ext.c: In function 'mlmeext_joinbss_event_callback':
>> drivers/staging/r8188eu/core/rtw_mlme_ext.c:7104:1: error: label at end of compound statement
    7104 | exit_mlmeext_joinbss_event_callback:
         | ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


vim +7104 drivers/staging/r8188eu/core/rtw_mlme_ext.c

15865124feed88 Phillip Potter  2021-07-28  7028  
15865124feed88 Phillip Potter  2021-07-28  7029  void mlmeext_joinbss_event_callback(struct adapter *padapter, int join_res)
15865124feed88 Phillip Potter  2021-07-28  7030  {
15865124feed88 Phillip Potter  2021-07-28  7031  	struct sta_info		*psta, *psta_bmc;
15865124feed88 Phillip Potter  2021-07-28  7032  	struct mlme_ext_priv	*pmlmeext = &padapter->mlmeextpriv;
3b522a11b50476 Michael Straube 2021-08-09  7033  	struct mlme_ext_info	*pmlmeinfo = &pmlmeext->mlmext_info;
3b522a11b50476 Michael Straube 2021-08-09  7034  	struct wlan_bssid_ex *cur_network = &pmlmeinfo->network;
15865124feed88 Phillip Potter  2021-07-28  7035  	struct sta_priv		*pstapriv = &padapter->stapriv;
15865124feed88 Phillip Potter  2021-07-28  7036  	u8 join_type;
15865124feed88 Phillip Potter  2021-07-28  7037  	u16 media_status;
15865124feed88 Phillip Potter  2021-07-28  7038  
15865124feed88 Phillip Potter  2021-07-28  7039  	if (join_res < 0) {
15865124feed88 Phillip Potter  2021-07-28  7040  		join_type = 1;
461c4776856c15 Michael Straube 2021-10-07  7041  		SetHwReg8188EU(padapter, HW_VAR_MLME_JOIN, (u8 *)(&join_type));
461c4776856c15 Michael Straube 2021-10-07  7042  		SetHwReg8188EU(padapter, HW_VAR_BSSID, null_addr);
15865124feed88 Phillip Potter  2021-07-28  7043  
15865124feed88 Phillip Potter  2021-07-28  7044  		/* restore to initial setting. */
15865124feed88 Phillip Potter  2021-07-28  7045  		update_tx_basic_rate(padapter, padapter->registrypriv.wireless_mode);
15865124feed88 Phillip Potter  2021-07-28  7046  
15865124feed88 Phillip Potter  2021-07-28  7047  		goto exit_mlmeext_joinbss_event_callback;
15865124feed88 Phillip Potter  2021-07-28  7048  	}
15865124feed88 Phillip Potter  2021-07-28  7049  
15865124feed88 Phillip Potter  2021-07-28  7050  	if ((pmlmeinfo->state & 0x03) == WIFI_FW_ADHOC_STATE) {
15865124feed88 Phillip Potter  2021-07-28  7051  		/* for bc/mc */
15865124feed88 Phillip Potter  2021-07-28  7052  		psta_bmc = rtw_get_bcmc_stainfo(padapter);
15865124feed88 Phillip Potter  2021-07-28  7053  		if (psta_bmc) {
15865124feed88 Phillip Potter  2021-07-28  7054  			pmlmeinfo->FW_sta_info[psta_bmc->mac_id].psta = psta_bmc;
15865124feed88 Phillip Potter  2021-07-28  7055  			update_bmc_sta_support_rate(padapter, psta_bmc->mac_id);
15865124feed88 Phillip Potter  2021-07-28  7056  			Update_RA_Entry(padapter, psta_bmc->mac_id);
15865124feed88 Phillip Potter  2021-07-28  7057  		}
15865124feed88 Phillip Potter  2021-07-28  7058  	}
15865124feed88 Phillip Potter  2021-07-28  7059  
15865124feed88 Phillip Potter  2021-07-28  7060  	/* turn on dynamic functions */
15865124feed88 Phillip Potter  2021-07-28  7061  	Switch_DM_Func(padapter, DYNAMIC_ALL_FUNC_ENABLE, true);
15865124feed88 Phillip Potter  2021-07-28  7062  
15865124feed88 Phillip Potter  2021-07-28  7063  	/*  update IOT-releated issue */
15865124feed88 Phillip Potter  2021-07-28  7064  	update_IOT_info(padapter);
15865124feed88 Phillip Potter  2021-07-28  7065  
461c4776856c15 Michael Straube 2021-10-07  7066  	SetHwReg8188EU(padapter, HW_VAR_BASIC_RATE, cur_network->SupportedRates);
15865124feed88 Phillip Potter  2021-07-28  7067  
15865124feed88 Phillip Potter  2021-07-28  7068  	/* BCN interval */
461c4776856c15 Michael Straube 2021-10-07  7069  	SetHwReg8188EU(padapter, HW_VAR_BEACON_INTERVAL, (u8 *)(&pmlmeinfo->bcn_interval));
15865124feed88 Phillip Potter  2021-07-28  7070  
15865124feed88 Phillip Potter  2021-07-28  7071  	/* udpate capability */
15865124feed88 Phillip Potter  2021-07-28  7072  	update_capinfo(padapter, pmlmeinfo->capability);
15865124feed88 Phillip Potter  2021-07-28  7073  
15865124feed88 Phillip Potter  2021-07-28  7074  	/* WMM, Update EDCA param */
15865124feed88 Phillip Potter  2021-07-28  7075  	WMMOnAssocRsp(padapter);
15865124feed88 Phillip Potter  2021-07-28  7076  
15865124feed88 Phillip Potter  2021-07-28  7077  	/* HT */
15865124feed88 Phillip Potter  2021-07-28  7078  	HTOnAssocRsp(padapter);
15865124feed88 Phillip Potter  2021-07-28  7079  
15865124feed88 Phillip Potter  2021-07-28  7080  	set_channel_bwmode(padapter, pmlmeext->cur_channel, pmlmeext->cur_ch_offset, pmlmeext->cur_bwmode);
15865124feed88 Phillip Potter  2021-07-28  7081  
15865124feed88 Phillip Potter  2021-07-28  7082  	psta = rtw_get_stainfo(pstapriv, cur_network->MacAddress);
15865124feed88 Phillip Potter  2021-07-28  7083  	if (psta) { /* only for infra. mode */
15865124feed88 Phillip Potter  2021-07-28  7084  		pmlmeinfo->FW_sta_info[psta->mac_id].psta = psta;
15865124feed88 Phillip Potter  2021-07-28  7085  
15865124feed88 Phillip Potter  2021-07-28  7086  		psta->wireless_mode = pmlmeext->cur_wireless_mode;
15865124feed88 Phillip Potter  2021-07-28  7087  
15865124feed88 Phillip Potter  2021-07-28  7088  		/* set per sta rate after updating HT cap. */
15865124feed88 Phillip Potter  2021-07-28  7089  		set_sta_rate(padapter, psta);
461c4776856c15 Michael Straube 2021-10-07  7090  		SetHwReg8188EU(padapter, HW_VAR_TX_RPT_MAX_MACID, (u8 *)&psta->mac_id);
15865124feed88 Phillip Potter  2021-07-28  7091  		media_status = (psta->mac_id << 8) | 1; /*   MACID|OPMODE: 1 means connect */
461c4776856c15 Michael Straube 2021-10-07  7092  		SetHwReg8188EU(padapter, HW_VAR_H2C_MEDIA_STATUS_RPT, (u8 *)&media_status);
15865124feed88 Phillip Potter  2021-07-28  7093  	}
15865124feed88 Phillip Potter  2021-07-28  7094  
15865124feed88 Phillip Potter  2021-07-28  7095  	join_type = 2;
461c4776856c15 Michael Straube 2021-10-07  7096  	SetHwReg8188EU(padapter, HW_VAR_MLME_JOIN, (u8 *)(&join_type));
15865124feed88 Phillip Potter  2021-07-28  7097  
15865124feed88 Phillip Potter  2021-07-28  7098  	if ((pmlmeinfo->state & 0x03) == WIFI_FW_STATION_STATE) {
15865124feed88 Phillip Potter  2021-07-28  7099  		/*  correcting TSF */
15865124feed88 Phillip Potter  2021-07-28  7100  		correct_TSF(padapter, pmlmeext);
15865124feed88 Phillip Potter  2021-07-28  7101  	}
15865124feed88 Phillip Potter  2021-07-28  7102  	rtw_lps_ctrl_wk_cmd(padapter, LPS_CTRL_CONNECT, 0);
15865124feed88 Phillip Potter  2021-07-28  7103  
15865124feed88 Phillip Potter  2021-07-28 @7104  exit_mlmeext_joinbss_event_callback:
15865124feed88 Phillip Potter  2021-07-28  7105  }
15865124feed88 Phillip Potter  2021-07-28  7106  

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
