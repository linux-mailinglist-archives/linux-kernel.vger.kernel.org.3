Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C74649ADB7
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 08:39:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1446224AbiAYHjJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 02:39:09 -0500
Received: from mga09.intel.com ([134.134.136.24]:48204 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1446077AbiAYHgI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 02:36:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643096165; x=1674632165;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=yIWj5LDAN53Dk/SEQT30Nls1xipilfefgs2CtJ8gszs=;
  b=RHw4z/3dAMrZcoDG9yS6jDryiafUj8rWIrUvtfgcB8dwTElZIHg4MAfU
   jfA/Yn8tGc1yIeu3DTWsZ0aO95vmsOl8V0lKmicJ3mhwqgIEj5Iu24xPq
   EzR0m6zrL2TTA2xQ2JF0OLZqDNXivS55RhcTQVVjyAYSvuWrrmbFOPWye
   cP+0VP4CCozC+y1nW0/kauNgrakuSKBji3vBl1NMyp9Uq+vTwuQ5FvLuC
   +b2E/BJeJOBlEJQliGbR5uWiuPAS//3wRuG2VSmSEh0zzADmyjZSrtDxl
   at1p7xv1IaLIrR6eeHsmWmr5QCVdueLl+ZouW/jHczhA3Si2Y6uTEHj8X
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10237"; a="246021625"
X-IronPort-AV: E=Sophos;i="5.88,314,1635231600"; 
   d="scan'208";a="246021625"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2022 23:23:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,314,1635231600"; 
   d="scan'208";a="494904564"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 24 Jan 2022 23:23:28 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nCGAp-000JV5-QU; Tue, 25 Jan 2022 07:23:27 +0000
Date:   Tue, 25 Jan 2022 15:22:56 +0800
From:   kernel test robot <lkp@intel.com>
To:     Phillip Potter <phil@philpotter.co.uk>, gregkh@linuxfoundation.org
Cc:     kbuild-all@lists.01.org, dan.carpenter@oracle.com,
        Larry.Finger@lwfinger.net, straube.linux@gmail.com,
        martin@kaiser.cx, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, paskripkin@gmail.com
Subject: Re: [PATCH 03/10] staging: r8188eu: remove DBG_88E calls from
 core/rtw_mlme_ext.c
Message-ID: <202201251504.QbCNelqi-lkp@intel.com>
References: <20220124224415.831-4-phil@philpotter.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220124224415.831-4-phil@philpotter.co.uk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Phillip,

I love your patch! Perhaps something to improve:

[auto build test WARNING on staging/staging-testing]
[also build test WARNING on v5.17-rc1 next-20220124]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Phillip-Potter/Cleanup-and-removal-of-DBG_88E-macro/20220125-125206
base:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git fa783154524a71ab74e293cd8251155e5971952b
config: arc-allyesconfig (https://download.01.org/0day-ci/archive/20220125/202201251504.QbCNelqi-lkp@intel.com/config)
compiler: arceb-elf-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/8b7efc8d3123ad5411beb88fc84fab8141f8b60f
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Phillip-Potter/Cleanup-and-removal-of-DBG_88E-macro/20220125-125206
        git checkout 8b7efc8d3123ad5411beb88fc84fab8141f8b60f
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arc SHELL=/bin/bash drivers/staging/r8188eu/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   drivers/staging/r8188eu/core/rtw_mlme_ext.c: In function 'OnAssocReq':
>> drivers/staging/r8188eu/core/rtw_mlme_ext.c:919:33: warning: variable 'reassoc' set but not used [-Wunused-but-set-variable]
     919 |         unsigned char           reassoc, *p, *pos, *wpa_ie;
         |                                 ^~~~~~~
   drivers/staging/r8188eu/core/rtw_mlme_ext.c: In function 'OnAction_back':
>> drivers/staging/r8188eu/core/rtw_mlme_ext.c:1580:38: warning: variable 'reason_code' set but not used [-Wunused-but-set-variable]
    1580 |         unsigned short  tid, status, reason_code = 0;
         |                                      ^~~~~~~~~~~


vim +/reassoc +919 drivers/staging/r8188eu/core/rtw_mlme_ext.c

15865124feed88 Phillip Potter  2021-07-28   913  
15865124feed88 Phillip Potter  2021-07-28   914  unsigned int OnAssocReq(struct adapter *padapter, struct recv_frame *precv_frame)
15865124feed88 Phillip Potter  2021-07-28   915  {
15865124feed88 Phillip Potter  2021-07-28   916  	u16 capab_info;
15865124feed88 Phillip Potter  2021-07-28   917  	struct rtw_ieee802_11_elems elems;
15865124feed88 Phillip Potter  2021-07-28   918  	struct sta_info	*pstat;
15865124feed88 Phillip Potter  2021-07-28  @919  	unsigned char		reassoc, *p, *pos, *wpa_ie;
15865124feed88 Phillip Potter  2021-07-28   920  	unsigned char WMM_IE[] = {0x00, 0x50, 0xf2, 0x02, 0x00, 0x01};
15865124feed88 Phillip Potter  2021-07-28   921  	int		i, ie_len, wpa_ie_len, left;
15865124feed88 Phillip Potter  2021-07-28   922  	unsigned char		supportRate[16];
15865124feed88 Phillip Potter  2021-07-28   923  	int					supportRateNum;
15865124feed88 Phillip Potter  2021-07-28   924  	unsigned short		status = _STATS_SUCCESSFUL_;
15865124feed88 Phillip Potter  2021-07-28   925  	unsigned short		frame_type, ie_offset = 0;
15865124feed88 Phillip Potter  2021-07-28   926  	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
15865124feed88 Phillip Potter  2021-07-28   927  	struct security_priv *psecuritypriv = &padapter->securitypriv;
15865124feed88 Phillip Potter  2021-07-28   928  	struct mlme_ext_priv *pmlmeext = &padapter->mlmeextpriv;
3b522a11b50476 Michael Straube 2021-08-09   929  	struct mlme_ext_info	*pmlmeinfo = &pmlmeext->mlmext_info;
3b522a11b50476 Michael Straube 2021-08-09   930  	struct wlan_bssid_ex *cur = &pmlmeinfo->network;
15865124feed88 Phillip Potter  2021-07-28   931  	struct sta_priv *pstapriv = &padapter->stapriv;
15865124feed88 Phillip Potter  2021-07-28   932  	u8 *pframe = precv_frame->rx_data;
15865124feed88 Phillip Potter  2021-07-28   933  	uint pkt_len = precv_frame->len;
3b522a11b50476 Michael Straube 2021-08-09   934  	struct wifidirect_info	*pwdinfo = &padapter->wdinfo;
15865124feed88 Phillip Potter  2021-07-28   935  	u8 p2p_status_code = P2P_STATUS_SUCCESS;
15865124feed88 Phillip Potter  2021-07-28   936  	u8 *p2pie;
15865124feed88 Phillip Potter  2021-07-28   937  	u32 p2pielen = 0;
15865124feed88 Phillip Potter  2021-07-28   938  
15865124feed88 Phillip Potter  2021-07-28   939  	if ((pmlmeinfo->state & 0x03) != WIFI_FW_AP_STATE)
15865124feed88 Phillip Potter  2021-07-28   940  		return _FAIL;
15865124feed88 Phillip Potter  2021-07-28   941  
15865124feed88 Phillip Potter  2021-07-28   942  	frame_type = GetFrameSubType(pframe);
15865124feed88 Phillip Potter  2021-07-28   943  	if (frame_type == WIFI_ASSOCREQ) {
15865124feed88 Phillip Potter  2021-07-28   944  		reassoc = 0;
15865124feed88 Phillip Potter  2021-07-28   945  		ie_offset = _ASOCREQ_IE_OFFSET_;
15865124feed88 Phillip Potter  2021-07-28   946  	} else { /*  WIFI_REASSOCREQ */
15865124feed88 Phillip Potter  2021-07-28   947  		reassoc = 1;
15865124feed88 Phillip Potter  2021-07-28   948  		ie_offset = _REASOCREQ_IE_OFFSET_;
15865124feed88 Phillip Potter  2021-07-28   949  	}
15865124feed88 Phillip Potter  2021-07-28   950  
8b7efc8d3123ad Phillip Potter  2022-01-24   951  	if (pkt_len < IEEE80211_3ADDR_LEN + ie_offset)
15865124feed88 Phillip Potter  2021-07-28   952  		return _FAIL;
15865124feed88 Phillip Potter  2021-07-28   953  
15865124feed88 Phillip Potter  2021-07-28   954  	pstat = rtw_get_stainfo(pstapriv, GetAddr2Ptr(pframe));
15865124feed88 Phillip Potter  2021-07-28   955  	if (pstat == (struct sta_info *)NULL) {
15865124feed88 Phillip Potter  2021-07-28   956  		status = _RSON_CLS2_;
15865124feed88 Phillip Potter  2021-07-28   957  		goto asoc_class2_error;
15865124feed88 Phillip Potter  2021-07-28   958  	}
15865124feed88 Phillip Potter  2021-07-28   959  
15865124feed88 Phillip Potter  2021-07-28   960  	capab_info = get_unaligned_le16(pframe + WLAN_HDR_A3_LEN);
15865124feed88 Phillip Potter  2021-07-28   961  
15865124feed88 Phillip Potter  2021-07-28   962  	left = pkt_len - (IEEE80211_3ADDR_LEN + ie_offset);
15865124feed88 Phillip Potter  2021-07-28   963  	pos = pframe + (IEEE80211_3ADDR_LEN + ie_offset);
15865124feed88 Phillip Potter  2021-07-28   964  
15865124feed88 Phillip Potter  2021-07-28   965  	/*  check if this stat has been successfully authenticated/assocated */
15865124feed88 Phillip Potter  2021-07-28   966  	if (!((pstat->state) & WIFI_FW_AUTH_SUCCESS)) {
15865124feed88 Phillip Potter  2021-07-28   967  		if (!((pstat->state) & WIFI_FW_ASSOC_SUCCESS)) {
15865124feed88 Phillip Potter  2021-07-28   968  			status = _RSON_CLS2_;
15865124feed88 Phillip Potter  2021-07-28   969  			goto asoc_class2_error;
15865124feed88 Phillip Potter  2021-07-28   970  		} else {
15865124feed88 Phillip Potter  2021-07-28   971  			pstat->state &= (~WIFI_FW_ASSOC_SUCCESS);
15865124feed88 Phillip Potter  2021-07-28   972  			pstat->state |= WIFI_FW_ASSOC_STATE;
15865124feed88 Phillip Potter  2021-07-28   973  		}
15865124feed88 Phillip Potter  2021-07-28   974  	} else {
15865124feed88 Phillip Potter  2021-07-28   975  		pstat->state &= (~WIFI_FW_AUTH_SUCCESS);
15865124feed88 Phillip Potter  2021-07-28   976  		pstat->state |= WIFI_FW_ASSOC_STATE;
15865124feed88 Phillip Potter  2021-07-28   977  	}
15865124feed88 Phillip Potter  2021-07-28   978  	pstat->capability = capab_info;
15865124feed88 Phillip Potter  2021-07-28   979  	/* now parse all ieee802_11 ie to point to elems */
15865124feed88 Phillip Potter  2021-07-28   980  	if (rtw_ieee802_11_parse_elems(pos, left, &elems, 1) == ParseFailed ||
15865124feed88 Phillip Potter  2021-07-28   981  	    !elems.ssid) {
15865124feed88 Phillip Potter  2021-07-28   982  		status = _STATS_FAILURE_;
15865124feed88 Phillip Potter  2021-07-28   983  		goto OnAssocReqFail;
15865124feed88 Phillip Potter  2021-07-28   984  	}
15865124feed88 Phillip Potter  2021-07-28   985  
15865124feed88 Phillip Potter  2021-07-28   986  	/*  now we should check all the fields... */
15865124feed88 Phillip Potter  2021-07-28   987  	/*  checking SSID */
15865124feed88 Phillip Potter  2021-07-28   988  	p = rtw_get_ie(pframe + WLAN_HDR_A3_LEN + ie_offset, _SSID_IE_, &ie_len,
15865124feed88 Phillip Potter  2021-07-28   989  		pkt_len - WLAN_HDR_A3_LEN - ie_offset);
552838fdcaef2c Michael Straube 2021-08-01   990  	if (!p)
15865124feed88 Phillip Potter  2021-07-28   991  		status = _STATS_FAILURE_;
15865124feed88 Phillip Potter  2021-07-28   992  
15865124feed88 Phillip Potter  2021-07-28   993  	if (ie_len == 0) { /*  broadcast ssid, however it is not allowed in assocreq */
15865124feed88 Phillip Potter  2021-07-28   994  		status = _STATS_FAILURE_;
15865124feed88 Phillip Potter  2021-07-28   995  	} else {
15865124feed88 Phillip Potter  2021-07-28   996  		/*  check if ssid match */
15865124feed88 Phillip Potter  2021-07-28   997  		if (memcmp((void *)(p + 2), cur->Ssid.Ssid, cur->Ssid.SsidLength))
15865124feed88 Phillip Potter  2021-07-28   998  			status = _STATS_FAILURE_;
15865124feed88 Phillip Potter  2021-07-28   999  
15865124feed88 Phillip Potter  2021-07-28  1000  		if (ie_len != cur->Ssid.SsidLength)
15865124feed88 Phillip Potter  2021-07-28  1001  			status = _STATS_FAILURE_;
15865124feed88 Phillip Potter  2021-07-28  1002  	}
15865124feed88 Phillip Potter  2021-07-28  1003  
15865124feed88 Phillip Potter  2021-07-28  1004  	if (_STATS_SUCCESSFUL_ != status)
15865124feed88 Phillip Potter  2021-07-28  1005  		goto OnAssocReqFail;
15865124feed88 Phillip Potter  2021-07-28  1006  
15865124feed88 Phillip Potter  2021-07-28  1007  	/*  check if the supported rate is ok */
15865124feed88 Phillip Potter  2021-07-28  1008  	p = rtw_get_ie(pframe + WLAN_HDR_A3_LEN + ie_offset, _SUPPORTEDRATES_IE_, &ie_len, pkt_len - WLAN_HDR_A3_LEN - ie_offset);
552838fdcaef2c Michael Straube 2021-08-01  1009  	if (!p) {
15865124feed88 Phillip Potter  2021-07-28  1010  		/*  use our own rate set as statoin used */
15865124feed88 Phillip Potter  2021-07-28  1011  		/* memcpy(supportRate, AP_BSSRATE, AP_BSSRATE_LEN); */
15865124feed88 Phillip Potter  2021-07-28  1012  		/* supportRateNum = AP_BSSRATE_LEN; */
15865124feed88 Phillip Potter  2021-07-28  1013  
15865124feed88 Phillip Potter  2021-07-28  1014  		status = _STATS_FAILURE_;
15865124feed88 Phillip Potter  2021-07-28  1015  		goto OnAssocReqFail;
15865124feed88 Phillip Potter  2021-07-28  1016  	} else {
15865124feed88 Phillip Potter  2021-07-28  1017  		memcpy(supportRate, p + 2, ie_len);
15865124feed88 Phillip Potter  2021-07-28  1018  		supportRateNum = ie_len;
15865124feed88 Phillip Potter  2021-07-28  1019  
15865124feed88 Phillip Potter  2021-07-28  1020  		p = rtw_get_ie(pframe + WLAN_HDR_A3_LEN + ie_offset, _EXT_SUPPORTEDRATES_IE_, &ie_len,
15865124feed88 Phillip Potter  2021-07-28  1021  				pkt_len - WLAN_HDR_A3_LEN - ie_offset);
552838fdcaef2c Michael Straube 2021-08-01  1022  		if (p) {
15865124feed88 Phillip Potter  2021-07-28  1023  			if (supportRateNum <= sizeof(supportRate)) {
15865124feed88 Phillip Potter  2021-07-28  1024  				memcpy(supportRate + supportRateNum, p + 2, ie_len);
15865124feed88 Phillip Potter  2021-07-28  1025  				supportRateNum += ie_len;
15865124feed88 Phillip Potter  2021-07-28  1026  			}
15865124feed88 Phillip Potter  2021-07-28  1027  		}
15865124feed88 Phillip Potter  2021-07-28  1028  	}
15865124feed88 Phillip Potter  2021-07-28  1029  
15865124feed88 Phillip Potter  2021-07-28  1030  	/* todo: mask supportRate between AP & STA -> move to update raid */
15865124feed88 Phillip Potter  2021-07-28  1031  	/* get_matched_rate(pmlmeext, supportRate, &supportRateNum, 0); */
15865124feed88 Phillip Potter  2021-07-28  1032  
15865124feed88 Phillip Potter  2021-07-28  1033  	/* update station supportRate */
15865124feed88 Phillip Potter  2021-07-28  1034  	pstat->bssratelen = supportRateNum;
15865124feed88 Phillip Potter  2021-07-28  1035  	memcpy(pstat->bssrateset, supportRate, supportRateNum);
15865124feed88 Phillip Potter  2021-07-28  1036  	UpdateBrateTblForSoftAP(pstat->bssrateset, pstat->bssratelen);
15865124feed88 Phillip Potter  2021-07-28  1037  
15865124feed88 Phillip Potter  2021-07-28  1038  	/* check RSN/WPA/WPS */
15865124feed88 Phillip Potter  2021-07-28  1039  	pstat->dot8021xalg = 0;
15865124feed88 Phillip Potter  2021-07-28  1040  	pstat->wpa_psk = 0;
15865124feed88 Phillip Potter  2021-07-28  1041  	pstat->wpa_group_cipher = 0;
15865124feed88 Phillip Potter  2021-07-28  1042  	pstat->wpa2_group_cipher = 0;
15865124feed88 Phillip Potter  2021-07-28  1043  	pstat->wpa_pairwise_cipher = 0;
15865124feed88 Phillip Potter  2021-07-28  1044  	pstat->wpa2_pairwise_cipher = 0;
15865124feed88 Phillip Potter  2021-07-28  1045  	memset(pstat->wpa_ie, 0, sizeof(pstat->wpa_ie));
15865124feed88 Phillip Potter  2021-07-28  1046  	if ((psecuritypriv->wpa_psk & BIT(1)) && elems.rsn_ie) {
15865124feed88 Phillip Potter  2021-07-28  1047  		int group_cipher = 0, pairwise_cipher = 0;
15865124feed88 Phillip Potter  2021-07-28  1048  
15865124feed88 Phillip Potter  2021-07-28  1049  		wpa_ie = elems.rsn_ie;
15865124feed88 Phillip Potter  2021-07-28  1050  		wpa_ie_len = elems.rsn_ie_len;
15865124feed88 Phillip Potter  2021-07-28  1051  
15865124feed88 Phillip Potter  2021-07-28  1052  		if (rtw_parse_wpa2_ie(wpa_ie - 2, wpa_ie_len + 2, &group_cipher, &pairwise_cipher, NULL) == _SUCCESS) {
15865124feed88 Phillip Potter  2021-07-28  1053  			pstat->dot8021xalg = 1;/* psk,  todo:802.1x */
15865124feed88 Phillip Potter  2021-07-28  1054  			pstat->wpa_psk |= BIT(1);
15865124feed88 Phillip Potter  2021-07-28  1055  
15865124feed88 Phillip Potter  2021-07-28  1056  			pstat->wpa2_group_cipher = group_cipher & psecuritypriv->wpa2_group_cipher;
15865124feed88 Phillip Potter  2021-07-28  1057  			pstat->wpa2_pairwise_cipher = pairwise_cipher & psecuritypriv->wpa2_pairwise_cipher;
15865124feed88 Phillip Potter  2021-07-28  1058  
15865124feed88 Phillip Potter  2021-07-28  1059  			if (!pstat->wpa2_group_cipher)
15865124feed88 Phillip Potter  2021-07-28  1060  				status = WLAN_STATUS_GROUP_CIPHER_NOT_VALID;
15865124feed88 Phillip Potter  2021-07-28  1061  
15865124feed88 Phillip Potter  2021-07-28  1062  			if (!pstat->wpa2_pairwise_cipher)
15865124feed88 Phillip Potter  2021-07-28  1063  				status = WLAN_STATUS_PAIRWISE_CIPHER_NOT_VALID;
15865124feed88 Phillip Potter  2021-07-28  1064  		} else {
15865124feed88 Phillip Potter  2021-07-28  1065  			status = WLAN_STATUS_INVALID_IE;
15865124feed88 Phillip Potter  2021-07-28  1066  		}
15865124feed88 Phillip Potter  2021-07-28  1067  	} else if ((psecuritypriv->wpa_psk & BIT(0)) && elems.wpa_ie) {
15865124feed88 Phillip Potter  2021-07-28  1068  		int group_cipher = 0, pairwise_cipher = 0;
15865124feed88 Phillip Potter  2021-07-28  1069  
15865124feed88 Phillip Potter  2021-07-28  1070  		wpa_ie = elems.wpa_ie;
15865124feed88 Phillip Potter  2021-07-28  1071  		wpa_ie_len = elems.wpa_ie_len;
15865124feed88 Phillip Potter  2021-07-28  1072  
15865124feed88 Phillip Potter  2021-07-28  1073  		if (rtw_parse_wpa_ie(wpa_ie - 2, wpa_ie_len + 2, &group_cipher, &pairwise_cipher, NULL) == _SUCCESS) {
15865124feed88 Phillip Potter  2021-07-28  1074  			pstat->dot8021xalg = 1;/* psk,  todo:802.1x */
15865124feed88 Phillip Potter  2021-07-28  1075  			pstat->wpa_psk |= BIT(0);
15865124feed88 Phillip Potter  2021-07-28  1076  
15865124feed88 Phillip Potter  2021-07-28  1077  			pstat->wpa_group_cipher = group_cipher & psecuritypriv->wpa_group_cipher;
15865124feed88 Phillip Potter  2021-07-28  1078  			pstat->wpa_pairwise_cipher = pairwise_cipher & psecuritypriv->wpa_pairwise_cipher;
15865124feed88 Phillip Potter  2021-07-28  1079  
15865124feed88 Phillip Potter  2021-07-28  1080  			if (!pstat->wpa_group_cipher)
15865124feed88 Phillip Potter  2021-07-28  1081  				status = WLAN_STATUS_GROUP_CIPHER_NOT_VALID;
15865124feed88 Phillip Potter  2021-07-28  1082  
15865124feed88 Phillip Potter  2021-07-28  1083  			if (!pstat->wpa_pairwise_cipher)
15865124feed88 Phillip Potter  2021-07-28  1084  				status = WLAN_STATUS_PAIRWISE_CIPHER_NOT_VALID;
15865124feed88 Phillip Potter  2021-07-28  1085  		} else {
15865124feed88 Phillip Potter  2021-07-28  1086  			status = WLAN_STATUS_INVALID_IE;
15865124feed88 Phillip Potter  2021-07-28  1087  		}
15865124feed88 Phillip Potter  2021-07-28  1088  	} else {
15865124feed88 Phillip Potter  2021-07-28  1089  		wpa_ie = NULL;
15865124feed88 Phillip Potter  2021-07-28  1090  		wpa_ie_len = 0;
15865124feed88 Phillip Potter  2021-07-28  1091  	}
15865124feed88 Phillip Potter  2021-07-28  1092  
15865124feed88 Phillip Potter  2021-07-28  1093  	if (_STATS_SUCCESSFUL_ != status)
15865124feed88 Phillip Potter  2021-07-28  1094  		goto OnAssocReqFail;
15865124feed88 Phillip Potter  2021-07-28  1095  
15865124feed88 Phillip Potter  2021-07-28  1096  	pstat->flags &= ~(WLAN_STA_WPS | WLAN_STA_MAYBE_WPS);
552838fdcaef2c Michael Straube 2021-08-01  1097  	if (!wpa_ie) {
8b7efc8d3123ad Phillip Potter  2022-01-24  1098  		if (elems.wps_ie)
15865124feed88 Phillip Potter  2021-07-28  1099  			pstat->flags |= WLAN_STA_WPS;
15865124feed88 Phillip Potter  2021-07-28  1100  			/* wpabuf_free(sta->wps_ie); */
15865124feed88 Phillip Potter  2021-07-28  1101  			/* sta->wps_ie = wpabuf_alloc_copy(elems.wps_ie + 4, */
15865124feed88 Phillip Potter  2021-07-28  1102  			/*				elems.wps_ie_len - 4); */
8b7efc8d3123ad Phillip Potter  2022-01-24  1103  		else
15865124feed88 Phillip Potter  2021-07-28  1104  			pstat->flags |= WLAN_STA_MAYBE_WPS;
15865124feed88 Phillip Potter  2021-07-28  1105  
15865124feed88 Phillip Potter  2021-07-28  1106  		/*  AP support WPA/RSN, and sta is going to do WPS, but AP is not ready */
15865124feed88 Phillip Potter  2021-07-28  1107  		/*  that the selected registrar of AP is _FLASE */
15865124feed88 Phillip Potter  2021-07-28  1108  		if ((psecuritypriv->wpa_psk > 0) && (pstat->flags & (WLAN_STA_WPS | WLAN_STA_MAYBE_WPS))) {
15865124feed88 Phillip Potter  2021-07-28  1109  			if (pmlmepriv->wps_beacon_ie) {
15865124feed88 Phillip Potter  2021-07-28  1110  				u8 selected_registrar = 0;
15865124feed88 Phillip Potter  2021-07-28  1111  
15865124feed88 Phillip Potter  2021-07-28  1112  				rtw_get_wps_attr_content(pmlmepriv->wps_beacon_ie, pmlmepriv->wps_beacon_ie_len, WPS_ATTR_SELECTED_REGISTRAR, &selected_registrar, NULL);
15865124feed88 Phillip Potter  2021-07-28  1113  
15865124feed88 Phillip Potter  2021-07-28  1114  				if (!selected_registrar) {
15865124feed88 Phillip Potter  2021-07-28  1115  					status = _STATS_UNABLE_HANDLE_STA_;
15865124feed88 Phillip Potter  2021-07-28  1116  
15865124feed88 Phillip Potter  2021-07-28  1117  					goto OnAssocReqFail;
15865124feed88 Phillip Potter  2021-07-28  1118  				}
15865124feed88 Phillip Potter  2021-07-28  1119  			}
15865124feed88 Phillip Potter  2021-07-28  1120  		}
15865124feed88 Phillip Potter  2021-07-28  1121  	} else {
15865124feed88 Phillip Potter  2021-07-28  1122  		int copy_len;
15865124feed88 Phillip Potter  2021-07-28  1123  
15865124feed88 Phillip Potter  2021-07-28  1124  		if (psecuritypriv->wpa_psk == 0) {
15865124feed88 Phillip Potter  2021-07-28  1125  			status = WLAN_STATUS_INVALID_IE;
15865124feed88 Phillip Potter  2021-07-28  1126  
15865124feed88 Phillip Potter  2021-07-28  1127  			goto OnAssocReqFail;
15865124feed88 Phillip Potter  2021-07-28  1128  		}
15865124feed88 Phillip Potter  2021-07-28  1129  
15865124feed88 Phillip Potter  2021-07-28  1130  		if (elems.wps_ie) {
15865124feed88 Phillip Potter  2021-07-28  1131  			pstat->flags |= WLAN_STA_WPS;
15865124feed88 Phillip Potter  2021-07-28  1132  			copy_len = 0;
15865124feed88 Phillip Potter  2021-07-28  1133  		} else {
15865124feed88 Phillip Potter  2021-07-28  1134  			copy_len = ((wpa_ie_len + 2) > sizeof(pstat->wpa_ie)) ? (sizeof(pstat->wpa_ie)) : (wpa_ie_len + 2);
15865124feed88 Phillip Potter  2021-07-28  1135  		}
15865124feed88 Phillip Potter  2021-07-28  1136  		if (copy_len > 0)
15865124feed88 Phillip Potter  2021-07-28  1137  			memcpy(pstat->wpa_ie, wpa_ie - 2, copy_len);
15865124feed88 Phillip Potter  2021-07-28  1138  	}
15865124feed88 Phillip Potter  2021-07-28  1139  	/*  check if there is WMM IE & support WWM-PS */
15865124feed88 Phillip Potter  2021-07-28  1140  	pstat->flags &= ~WLAN_STA_WME;
15865124feed88 Phillip Potter  2021-07-28  1141  	pstat->qos_option = 0;
15865124feed88 Phillip Potter  2021-07-28  1142  	pstat->qos_info = 0;
15865124feed88 Phillip Potter  2021-07-28  1143  	pstat->has_legacy_ac = true;
15865124feed88 Phillip Potter  2021-07-28  1144  	pstat->uapsd_vo = 0;
15865124feed88 Phillip Potter  2021-07-28  1145  	pstat->uapsd_vi = 0;
15865124feed88 Phillip Potter  2021-07-28  1146  	pstat->uapsd_be = 0;
15865124feed88 Phillip Potter  2021-07-28  1147  	pstat->uapsd_bk = 0;
15865124feed88 Phillip Potter  2021-07-28  1148  	if (pmlmepriv->qospriv.qos_option) {
15865124feed88 Phillip Potter  2021-07-28  1149  		p = pframe + WLAN_HDR_A3_LEN + ie_offset; ie_len = 0;
15865124feed88 Phillip Potter  2021-07-28  1150  		for (;;) {
15865124feed88 Phillip Potter  2021-07-28  1151  			p = rtw_get_ie(p, _VENDOR_SPECIFIC_IE_, &ie_len, pkt_len - WLAN_HDR_A3_LEN - ie_offset);
552838fdcaef2c Michael Straube 2021-08-01  1152  			if (p) {
15865124feed88 Phillip Potter  2021-07-28  1153  				if (!memcmp(p + 2, WMM_IE, 6)) {
15865124feed88 Phillip Potter  2021-07-28  1154  					pstat->flags |= WLAN_STA_WME;
15865124feed88 Phillip Potter  2021-07-28  1155  
15865124feed88 Phillip Potter  2021-07-28  1156  					pstat->qos_option = 1;
15865124feed88 Phillip Potter  2021-07-28  1157  					pstat->qos_info = *(p + 8);
15865124feed88 Phillip Potter  2021-07-28  1158  
15865124feed88 Phillip Potter  2021-07-28  1159  					pstat->max_sp_len = (pstat->qos_info >> 5) & 0x3;
15865124feed88 Phillip Potter  2021-07-28  1160  
15865124feed88 Phillip Potter  2021-07-28  1161  					if ((pstat->qos_info & 0xf) != 0xf)
15865124feed88 Phillip Potter  2021-07-28  1162  						pstat->has_legacy_ac = true;
15865124feed88 Phillip Potter  2021-07-28  1163  					else
15865124feed88 Phillip Potter  2021-07-28  1164  						pstat->has_legacy_ac = false;
15865124feed88 Phillip Potter  2021-07-28  1165  
15865124feed88 Phillip Potter  2021-07-28  1166  					if (pstat->qos_info & 0xf) {
15865124feed88 Phillip Potter  2021-07-28  1167  						if (pstat->qos_info & BIT(0))
15865124feed88 Phillip Potter  2021-07-28  1168  							pstat->uapsd_vo = BIT(0) | BIT(1);
15865124feed88 Phillip Potter  2021-07-28  1169  						else
15865124feed88 Phillip Potter  2021-07-28  1170  							pstat->uapsd_vo = 0;
15865124feed88 Phillip Potter  2021-07-28  1171  
15865124feed88 Phillip Potter  2021-07-28  1172  						if (pstat->qos_info & BIT(1))
15865124feed88 Phillip Potter  2021-07-28  1173  							pstat->uapsd_vi = BIT(0) | BIT(1);
15865124feed88 Phillip Potter  2021-07-28  1174  						else
15865124feed88 Phillip Potter  2021-07-28  1175  							pstat->uapsd_vi = 0;
15865124feed88 Phillip Potter  2021-07-28  1176  
15865124feed88 Phillip Potter  2021-07-28  1177  						if (pstat->qos_info & BIT(2))
15865124feed88 Phillip Potter  2021-07-28  1178  							pstat->uapsd_bk = BIT(0) | BIT(1);
15865124feed88 Phillip Potter  2021-07-28  1179  						else
15865124feed88 Phillip Potter  2021-07-28  1180  							pstat->uapsd_bk = 0;
15865124feed88 Phillip Potter  2021-07-28  1181  
15865124feed88 Phillip Potter  2021-07-28  1182  						if (pstat->qos_info & BIT(3))
15865124feed88 Phillip Potter  2021-07-28  1183  							pstat->uapsd_be = BIT(0) | BIT(1);
15865124feed88 Phillip Potter  2021-07-28  1184  						else
15865124feed88 Phillip Potter  2021-07-28  1185  							pstat->uapsd_be = 0;
15865124feed88 Phillip Potter  2021-07-28  1186  					}
15865124feed88 Phillip Potter  2021-07-28  1187  					break;
15865124feed88 Phillip Potter  2021-07-28  1188  				}
15865124feed88 Phillip Potter  2021-07-28  1189  			} else {
15865124feed88 Phillip Potter  2021-07-28  1190  				break;
15865124feed88 Phillip Potter  2021-07-28  1191  			}
15865124feed88 Phillip Potter  2021-07-28  1192  			p = p + ie_len + 2;
15865124feed88 Phillip Potter  2021-07-28  1193  		}
15865124feed88 Phillip Potter  2021-07-28  1194  	}
15865124feed88 Phillip Potter  2021-07-28  1195  
15865124feed88 Phillip Potter  2021-07-28  1196  	/* save HT capabilities in the sta object */
15865124feed88 Phillip Potter  2021-07-28  1197  	memset(&pstat->htpriv.ht_cap, 0, sizeof(struct ieee80211_ht_cap));
15865124feed88 Phillip Potter  2021-07-28  1198  	if (elems.ht_capabilities && elems.ht_capabilities_len >= sizeof(struct ieee80211_ht_cap)) {
15865124feed88 Phillip Potter  2021-07-28  1199  		pstat->flags |= WLAN_STA_HT;
15865124feed88 Phillip Potter  2021-07-28  1200  
15865124feed88 Phillip Potter  2021-07-28  1201  		pstat->flags |= WLAN_STA_WME;
15865124feed88 Phillip Potter  2021-07-28  1202  
15865124feed88 Phillip Potter  2021-07-28  1203  		memcpy(&pstat->htpriv.ht_cap, elems.ht_capabilities, sizeof(struct ieee80211_ht_cap));
15865124feed88 Phillip Potter  2021-07-28  1204  	} else {
15865124feed88 Phillip Potter  2021-07-28  1205  		pstat->flags &= ~WLAN_STA_HT;
15865124feed88 Phillip Potter  2021-07-28  1206  	}
15865124feed88 Phillip Potter  2021-07-28  1207  	if ((!pmlmepriv->htpriv.ht_option) && (pstat->flags & WLAN_STA_HT)) {
15865124feed88 Phillip Potter  2021-07-28  1208  		status = _STATS_FAILURE_;
15865124feed88 Phillip Potter  2021-07-28  1209  		goto OnAssocReqFail;
15865124feed88 Phillip Potter  2021-07-28  1210  	}
15865124feed88 Phillip Potter  2021-07-28  1211  
15865124feed88 Phillip Potter  2021-07-28  1212  	pstat->flags |= WLAN_STA_NONERP;
15865124feed88 Phillip Potter  2021-07-28  1213  	for (i = 0; i < pstat->bssratelen; i++) {
15865124feed88 Phillip Potter  2021-07-28  1214  		if ((pstat->bssrateset[i] & 0x7f) > 22) {
15865124feed88 Phillip Potter  2021-07-28  1215  			pstat->flags &= ~WLAN_STA_NONERP;
15865124feed88 Phillip Potter  2021-07-28  1216  			break;
15865124feed88 Phillip Potter  2021-07-28  1217  		}
15865124feed88 Phillip Potter  2021-07-28  1218  	}
15865124feed88 Phillip Potter  2021-07-28  1219  
15865124feed88 Phillip Potter  2021-07-28  1220  	if (pstat->capability & WLAN_CAPABILITY_SHORT_PREAMBLE)
15865124feed88 Phillip Potter  2021-07-28  1221  		pstat->flags |= WLAN_STA_SHORT_PREAMBLE;
15865124feed88 Phillip Potter  2021-07-28  1222  	else
15865124feed88 Phillip Potter  2021-07-28  1223  		pstat->flags &= ~WLAN_STA_SHORT_PREAMBLE;
15865124feed88 Phillip Potter  2021-07-28  1224  
15865124feed88 Phillip Potter  2021-07-28  1225  	if (status != _STATS_SUCCESSFUL_)
15865124feed88 Phillip Potter  2021-07-28  1226  		goto OnAssocReqFail;
15865124feed88 Phillip Potter  2021-07-28  1227  
15865124feed88 Phillip Potter  2021-07-28  1228  	pstat->is_p2p_device = false;
15865124feed88 Phillip Potter  2021-07-28  1229  	if (rtw_p2p_chk_role(pwdinfo, P2P_ROLE_GO)) {
15865124feed88 Phillip Potter  2021-07-28  1230  		p2pie = rtw_get_p2p_ie(pframe + WLAN_HDR_A3_LEN + ie_offset, pkt_len - WLAN_HDR_A3_LEN - ie_offset, NULL, &p2pielen);
15865124feed88 Phillip Potter  2021-07-28  1231  		if (p2pie) {
15865124feed88 Phillip Potter  2021-07-28  1232  			pstat->is_p2p_device = true;
15865124feed88 Phillip Potter  2021-07-28  1233  			p2p_status_code = (u8)process_assoc_req_p2p_ie(pwdinfo, pframe, pkt_len, pstat);
15865124feed88 Phillip Potter  2021-07-28  1234  			if (p2p_status_code > 0) {
15865124feed88 Phillip Potter  2021-07-28  1235  				pstat->p2p_status_code = p2p_status_code;
15865124feed88 Phillip Potter  2021-07-28  1236  				status = _STATS_CAP_FAIL_;
15865124feed88 Phillip Potter  2021-07-28  1237  				goto OnAssocReqFail;
15865124feed88 Phillip Potter  2021-07-28  1238  			}
15865124feed88 Phillip Potter  2021-07-28  1239  		}
15865124feed88 Phillip Potter  2021-07-28  1240  	}
15865124feed88 Phillip Potter  2021-07-28  1241  	pstat->p2p_status_code = p2p_status_code;
15865124feed88 Phillip Potter  2021-07-28  1242  
15865124feed88 Phillip Potter  2021-07-28  1243  	/* TODO: identify_proprietary_vendor_ie(); */
15865124feed88 Phillip Potter  2021-07-28  1244  	/*  Realtek proprietary IE */
15865124feed88 Phillip Potter  2021-07-28  1245  	/*  identify if this is Broadcom sta */
15865124feed88 Phillip Potter  2021-07-28  1246  	/*  identify if this is ralink sta */
15865124feed88 Phillip Potter  2021-07-28  1247  	/*  Customer proprietary IE */
15865124feed88 Phillip Potter  2021-07-28  1248  
15865124feed88 Phillip Potter  2021-07-28  1249  	/* get a unique AID */
8b7efc8d3123ad Phillip Potter  2022-01-24  1250  	if (pstat->aid == 0) {
15865124feed88 Phillip Potter  2021-07-28  1251  		for (pstat->aid = 1; pstat->aid <= NUM_STA; pstat->aid++)
552838fdcaef2c Michael Straube 2021-08-01  1252  			if (!pstapriv->sta_aid[pstat->aid - 1])
15865124feed88 Phillip Potter  2021-07-28  1253  				break;
15865124feed88 Phillip Potter  2021-07-28  1254  
15865124feed88 Phillip Potter  2021-07-28  1255  		/* if (pstat->aid > NUM_STA) { */
15865124feed88 Phillip Potter  2021-07-28  1256  		if (pstat->aid > pstapriv->max_num_sta) {
15865124feed88 Phillip Potter  2021-07-28  1257  			pstat->aid = 0;
15865124feed88 Phillip Potter  2021-07-28  1258  
15865124feed88 Phillip Potter  2021-07-28  1259  			status = WLAN_STATUS_AP_UNABLE_TO_HANDLE_NEW_STA;
15865124feed88 Phillip Potter  2021-07-28  1260  
15865124feed88 Phillip Potter  2021-07-28  1261  			goto OnAssocReqFail;
15865124feed88 Phillip Potter  2021-07-28  1262  		} else {
15865124feed88 Phillip Potter  2021-07-28  1263  			pstapriv->sta_aid[pstat->aid - 1] = pstat;
15865124feed88 Phillip Potter  2021-07-28  1264  		}
15865124feed88 Phillip Potter  2021-07-28  1265  	}
15865124feed88 Phillip Potter  2021-07-28  1266  
15865124feed88 Phillip Potter  2021-07-28  1267  	pstat->state &= (~WIFI_FW_ASSOC_STATE);
15865124feed88 Phillip Potter  2021-07-28  1268  	pstat->state |= WIFI_FW_ASSOC_SUCCESS;
15865124feed88 Phillip Potter  2021-07-28  1269  
15865124feed88 Phillip Potter  2021-07-28  1270  	spin_lock_bh(&pstapriv->auth_list_lock);
15865124feed88 Phillip Potter  2021-07-28  1271  	if (!list_empty(&pstat->auth_list)) {
15865124feed88 Phillip Potter  2021-07-28  1272  		list_del_init(&pstat->auth_list);
15865124feed88 Phillip Potter  2021-07-28  1273  		pstapriv->auth_list_cnt--;
15865124feed88 Phillip Potter  2021-07-28  1274  	}
15865124feed88 Phillip Potter  2021-07-28  1275  	spin_unlock_bh(&pstapriv->auth_list_lock);
15865124feed88 Phillip Potter  2021-07-28  1276  
15865124feed88 Phillip Potter  2021-07-28  1277  	spin_lock_bh(&pstapriv->asoc_list_lock);
15865124feed88 Phillip Potter  2021-07-28  1278  	if (list_empty(&pstat->asoc_list)) {
15865124feed88 Phillip Potter  2021-07-28  1279  		pstat->expire_to = pstapriv->expire_to;
15865124feed88 Phillip Potter  2021-07-28  1280  		list_add_tail(&pstat->asoc_list, &pstapriv->asoc_list);
15865124feed88 Phillip Potter  2021-07-28  1281  		pstapriv->asoc_list_cnt++;
15865124feed88 Phillip Potter  2021-07-28  1282  	}
15865124feed88 Phillip Potter  2021-07-28  1283  	spin_unlock_bh(&pstapriv->asoc_list_lock);
15865124feed88 Phillip Potter  2021-07-28  1284  
15865124feed88 Phillip Potter  2021-07-28  1285  	/*  now the station is qualified to join our BSS... */
15865124feed88 Phillip Potter  2021-07-28  1286  	if (pstat && (pstat->state & WIFI_FW_ASSOC_SUCCESS) && (_STATS_SUCCESSFUL_ == status)) {
15865124feed88 Phillip Potter  2021-07-28  1287  		/* 1 bss_cap_update & sta_info_update */
15865124feed88 Phillip Potter  2021-07-28  1288  		bss_cap_update_on_sta_join(padapter, pstat);
15865124feed88 Phillip Potter  2021-07-28  1289  		sta_info_update(padapter, pstat);
15865124feed88 Phillip Potter  2021-07-28  1290  
15865124feed88 Phillip Potter  2021-07-28  1291  		/* issue assoc rsp before notify station join event. */
15865124feed88 Phillip Potter  2021-07-28  1292  		if (frame_type == WIFI_ASSOCREQ)
15865124feed88 Phillip Potter  2021-07-28  1293  			issue_asocrsp(padapter, status, pstat, WIFI_ASSOCRSP);
15865124feed88 Phillip Potter  2021-07-28  1294  		else
15865124feed88 Phillip Potter  2021-07-28  1295  			issue_asocrsp(padapter, status, pstat, WIFI_REASSOCRSP);
15865124feed88 Phillip Potter  2021-07-28  1296  
15865124feed88 Phillip Potter  2021-07-28  1297  		/* 2 - report to upper layer */
15865124feed88 Phillip Potter  2021-07-28  1298  		rtw_indicate_sta_assoc_event(padapter, pstat);
15865124feed88 Phillip Potter  2021-07-28  1299  
15865124feed88 Phillip Potter  2021-07-28  1300  		/* 3-(1) report sta add event */
15865124feed88 Phillip Potter  2021-07-28  1301  		report_add_sta_event(padapter, pstat->hwaddr, pstat->aid);
15865124feed88 Phillip Potter  2021-07-28  1302  	}
15865124feed88 Phillip Potter  2021-07-28  1303  
15865124feed88 Phillip Potter  2021-07-28  1304  	return _SUCCESS;
15865124feed88 Phillip Potter  2021-07-28  1305  
15865124feed88 Phillip Potter  2021-07-28  1306  asoc_class2_error:
15865124feed88 Phillip Potter  2021-07-28  1307  
15865124feed88 Phillip Potter  2021-07-28  1308  	issue_deauth(padapter, (void *)GetAddr2Ptr(pframe), status);
15865124feed88 Phillip Potter  2021-07-28  1309  
15865124feed88 Phillip Potter  2021-07-28  1310  	return _FAIL;
15865124feed88 Phillip Potter  2021-07-28  1311  
15865124feed88 Phillip Potter  2021-07-28  1312  OnAssocReqFail:
15865124feed88 Phillip Potter  2021-07-28  1313  
15865124feed88 Phillip Potter  2021-07-28  1314  	pstat->aid = 0;
15865124feed88 Phillip Potter  2021-07-28  1315  	if (frame_type == WIFI_ASSOCREQ)
15865124feed88 Phillip Potter  2021-07-28  1316  		issue_asocrsp(padapter, status, pstat, WIFI_ASSOCRSP);
15865124feed88 Phillip Potter  2021-07-28  1317  	else
15865124feed88 Phillip Potter  2021-07-28  1318  		issue_asocrsp(padapter, status, pstat, WIFI_REASSOCRSP);
15865124feed88 Phillip Potter  2021-07-28  1319  
15865124feed88 Phillip Potter  2021-07-28  1320  	return _FAIL;
15865124feed88 Phillip Potter  2021-07-28  1321  }
15865124feed88 Phillip Potter  2021-07-28  1322  

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
