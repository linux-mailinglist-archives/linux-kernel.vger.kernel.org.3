Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 100164E5C1F
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 01:00:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346608AbiCXACT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 20:02:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240367AbiCXACS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 20:02:18 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E490C76282
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 17:00:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648080046; x=1679616046;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=oMEJnPtZcH7pdTBWL2rAUzaHh70z6n+O5Q3opiboGBU=;
  b=BdlMENf5dEV5dQzySZvR2aJyc7/9FF0wRdwgNm5jQ0DkZKPAYpAMP/GT
   E9UTNCH8dVYCOL4JE2NTtQxR6ItSZ2VdCZA25MgaiyqKZ+W37DBftzjzk
   PHvSCniGmJAyFkboFWjwlPf/uu36TDqKLlHyKaUfPpbe3lUcyg/pfSsqm
   MEAMVoCdJw2+RO2j2oZJS+yYKsbgCy4LfzzXXYNPmeFUz80NxEO3DbAvF
   eh7y8Rzs7ooEWBVvZc7zkL5AJF1YZb4sKkbRfJGyfnmaNb5KL92kYDz/g
   tjAj/NJVf6k1hy/T9BN5PEm6JIFAzb5iUopVCE+AWz53LutozBhEmZI4I
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10295"; a="258205575"
X-IronPort-AV: E=Sophos;i="5.90,205,1643702400"; 
   d="scan'208";a="258205575"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2022 17:00:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,205,1643702400"; 
   d="scan'208";a="601494545"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by fmsmga008.fm.intel.com with ESMTP; 23 Mar 2022 17:00:43 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nXAuA-000KUZ-Uj; Thu, 24 Mar 2022 00:00:42 +0000
Date:   Thu, 24 Mar 2022 07:59:55 +0800
From:   kernel test robot <lkp@intel.com>
To:     Martin Kaiser <martin@kaiser.cx>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     kbuild-all@lists.01.org, Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: Re: [PATCH 1/7] staging: r8188eu: use ieee80211 define for version
 check
Message-ID: <202203240701.1JNFezRj-lkp@intel.com>
References: <20220323074859.177425-2-martin@kaiser.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220323074859.177425-2-martin@kaiser.cx>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Martin,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on staging/staging-testing]

url:    https://github.com/0day-ci/linux/commits/Martin-Kaiser/staging-r8188eu-use-ieee80211-helpers-for-parsing/20220323-155119
base:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git 41197a5f11a4b2d11ac19bc62552022153032811
config: sh-randconfig-s031-20220323 (https://download.01.org/0day-ci/archive/20220324/202203240701.1JNFezRj-lkp@intel.com/config)
compiler: sh4-linux-gcc (GCC) 11.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://github.com/0day-ci/linux/commit/ab583161be478f342c621b22766fc7f233769bef
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Martin-Kaiser/staging-r8188eu-use-ieee80211-helpers-for-parsing/20220323-155119
        git checkout ab583161be478f342c621b22766fc7f233769bef
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=sh SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
>> drivers/staging/r8188eu/core/rtw_recv.c:1074:14: sparse: sparse: restricted __le16 degrades to integer

vim +1074 drivers/staging/r8188eu/core/rtw_recv.c

  1054	
  1055	static int validate_recv_frame(struct adapter *adapter, struct recv_frame *precv_frame)
  1056	{
  1057		/* shall check frame subtype, to / from ds, da, bssid */
  1058	
  1059		/* then call check if rx seq/frag. duplicated. */
  1060	
  1061		int retval = _FAIL;
  1062		u8 bDumpRxPkt;
  1063		struct rx_pkt_attrib *pattrib = &precv_frame->attrib;
  1064		u8 *ptr = precv_frame->rx_data;
  1065		__le16 fc = *(__le16 *)ptr;
  1066		struct mlme_ext_priv *pmlmeext = &adapter->mlmeextpriv;
  1067	
  1068		if (pmlmeext->sitesurvey_res.state == SCAN_PROCESS) {
  1069			int ch_set_idx = rtw_ch_set_search_ch(pmlmeext->channel_set, rtw_get_oper_ch(adapter));
  1070			if (ch_set_idx >= 0)
  1071				pmlmeext->channel_set[ch_set_idx].rx_count++;
  1072		}
  1073	
> 1074		if ((fc & IEEE80211_FCTL_VERS) != 0)
  1075			return _FAIL;
  1076	
  1077		pattrib->to_fr_ds = get_tofr_ds(ptr);
  1078	
  1079		pattrib->frag_num = GetFragNum(ptr);
  1080		pattrib->seq_num = GetSequence(ptr);
  1081	
  1082		pattrib->pw_save = GetPwrMgt(ptr);
  1083		pattrib->mfrag = ieee80211_has_morefrags(fc);
  1084		pattrib->mdata = ieee80211_has_moredata(fc);
  1085		pattrib->privacy = ieee80211_has_protected(fc);
  1086		pattrib->order = ieee80211_has_order(fc);
  1087	
  1088		/* Dump rx packets */
  1089		GetHalDefVar8188EUsb(adapter, HAL_DEF_DBG_DUMP_RXPKT, &bDumpRxPkt);
  1090	
  1091		/* We return _SUCCESS only for data frames. */
  1092		if (ieee80211_is_mgmt(fc))
  1093			validate_recv_mgnt_frame(adapter, precv_frame);
  1094		else if (ieee80211_is_ctl(fc))
  1095			validate_recv_ctrl_frame(adapter, precv_frame);
  1096		else if (ieee80211_is_data(fc)) {
  1097			rtw_led_control(adapter, LED_CTL_RX);
  1098			pattrib->qos = ieee80211_is_data_qos(fc);
  1099			retval = validate_recv_data_frame(adapter, precv_frame);
  1100			if (retval == _FAIL) {
  1101				struct recv_priv *precvpriv = &adapter->recvpriv;
  1102				precvpriv->rx_drop++;
  1103			}
  1104		}
  1105	
  1106		return retval;
  1107	}
  1108	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
