Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 311894B933B
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 22:35:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234840AbiBPVgI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 16:36:08 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:40328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229635AbiBPVgH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 16:36:07 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0308028B613
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 13:35:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645047353; x=1676583353;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=QRJWsN67I0MagKQyC+abvYxSy/SjgNmkZ4CnqMtZUZY=;
  b=m4pRYH1n4j/ZYhdax6KbVSqV7l383Px5F1aO0/Ed8VCODvQqHhRy4JDF
   NAjNFFE6h0l6GMQeEjO6Fhr+MpXY9gPxI+lzN+V95I2sYuHrS6R4ky+6p
   PjQ7b8k25nCSBgjh4ddJncrLNVo4fxsyiQgkne05v03opBnY2UVbtlhud
   5eBnBZTCZlnf+GxkxjAvIaybRdUh5ZefSF9CCXXYRIJ7d/o7pBsAP3FsT
   CW+yyFww80701Ls5Kyv++FODIrV/pqQYLrhto/GUG+ULltXnY29nuxw5/
   wSKuUOroM4prtf+G6f7cxOEXyB6vwtro1+YgAemthIQzUBv2WhPSzfzC2
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10260"; a="234262691"
X-IronPort-AV: E=Sophos;i="5.88,374,1635231600"; 
   d="scan'208";a="234262691"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2022 13:35:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,374,1635231600"; 
   d="scan'208";a="503215036"
Received: from lkp-server01.sh.intel.com (HELO d95dc2dabeb1) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 16 Feb 2022 13:35:50 -0800
Received: from kbuild by d95dc2dabeb1 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nKRxl-000B8b-Q8; Wed, 16 Feb 2022 21:35:49 +0000
Date:   Thu, 17 Feb 2022 05:35:24 +0800
From:   kernel test robot <lkp@intel.com>
To:     Phillip Potter <phil@philpotter.co.uk>, gregkh@linuxfoundation.org
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        dan.carpenter@oracle.com, Larry.Finger@lwfinger.net,
        straube.linux@gmail.com, martin@kaiser.cx,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        paskripkin@gmail.com
Subject: Re: [PATCH v2 05/15] staging: r8188eu: remove DBG_88E calls from hal
 subdir
Message-ID: <202202170549.Ns7hoYfn-lkp@intel.com>
References: <20220216010709.791-6-phil@philpotter.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220216010709.791-6-phil@philpotter.co.uk>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Phillip,

I love your patch! Perhaps something to improve:

[auto build test WARNING on staging/staging-testing]

url:    https://github.com/0day-ci/linux/commits/Phillip-Potter/staging-r8188eu-Cleanup-and-removal-of-DBG_88E-macro/20220216-090900
base:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git e9685834b1db754cbd07e31ad1a091f5d366dacf
config: x86_64-allyesconfig (https://download.01.org/0day-ci/archive/20220217/202202170549.Ns7hoYfn-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 0e628a783b935c70c80815db6c061ec84f884af5)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/b481114992de793aca50ace1616b6b3947fde0a0
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Phillip-Potter/staging-r8188eu-Cleanup-and-removal-of-DBG_88E-macro/20220216-090900
        git checkout b481114992de793aca50ace1616b6b3947fde0a0
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash drivers/leds/ drivers/net/ethernet/mellanox/mlxsw/ drivers/platform/chrome/ drivers/staging/r8188eu/ mm/damon/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/staging/r8188eu/hal/usb_halinit.c:1546:6: warning: variable 'arg' set but not used [-Wunused-but-set-variable]
                   u8 arg;
                      ^
   1 warning generated.


vim +/arg +1546 drivers/staging/r8188eu/hal/usb_halinit.c

8cd574e6af5463a Phillip Potter  2021-07-28  1490  
b561d2f0dc01ab0 Michael Straube 2021-09-06  1491  void UpdateHalRAMask8188EUsb(struct adapter *adapt, u32 mac_id, u8 rssi_level)
8cd574e6af5463a Phillip Potter  2021-07-28  1492  {
8cd574e6af5463a Phillip Potter  2021-07-28  1493  	u8 init_rate = 0;
8cd574e6af5463a Phillip Potter  2021-07-28  1494  	u8 networkType, raid;
8cd574e6af5463a Phillip Potter  2021-07-28  1495  	u32 mask, rate_bitmap;
8cd574e6af5463a Phillip Potter  2021-07-28  1496  	u8 shortGIrate = false;
8cd574e6af5463a Phillip Potter  2021-07-28  1497  	int	supportRateNum = 0;
8cd574e6af5463a Phillip Potter  2021-07-28  1498  	struct sta_info	*psta;
d904512db6f3727 Michael Straube 2021-12-07  1499  	struct hal_data_8188e *haldata = &adapt->haldata;
8cd574e6af5463a Phillip Potter  2021-07-28  1500  	struct mlme_ext_priv	*pmlmeext = &adapt->mlmeextpriv;
6839ff57baa4a60 Michael Straube 2021-08-09  1501  	struct mlme_ext_info	*pmlmeinfo = &pmlmeext->mlmext_info;
6839ff57baa4a60 Michael Straube 2021-08-09  1502  	struct wlan_bssid_ex	*cur_network = &pmlmeinfo->network;
8cd574e6af5463a Phillip Potter  2021-07-28  1503  
8cd574e6af5463a Phillip Potter  2021-07-28  1504  	if (mac_id >= NUM_STA) /* CAM_SIZE */
8cd574e6af5463a Phillip Potter  2021-07-28  1505  		return;
8cd574e6af5463a Phillip Potter  2021-07-28  1506  	psta = pmlmeinfo->FW_sta_info[mac_id].psta;
725a3f1c4d56b73 Michael Straube 2021-08-01  1507  	if (!psta)
8cd574e6af5463a Phillip Potter  2021-07-28  1508  		return;
8cd574e6af5463a Phillip Potter  2021-07-28  1509  	switch (mac_id) {
8cd574e6af5463a Phillip Potter  2021-07-28  1510  	case 0:/*  for infra mode */
8cd574e6af5463a Phillip Potter  2021-07-28  1511  		supportRateNum = rtw_get_rateset_len(cur_network->SupportedRates);
8cd574e6af5463a Phillip Potter  2021-07-28  1512  		networkType = judge_network_type(adapt, cur_network->SupportedRates, supportRateNum) & 0xf;
8cd574e6af5463a Phillip Potter  2021-07-28  1513  		raid = networktype_to_raid(networkType);
8cd574e6af5463a Phillip Potter  2021-07-28  1514  		mask = update_supported_rate(cur_network->SupportedRates, supportRateNum);
6839ff57baa4a60 Michael Straube 2021-08-09  1515  		mask |= (pmlmeinfo->HT_enable) ? update_MSC_rate(&pmlmeinfo->HT_caps) : 0;
6839ff57baa4a60 Michael Straube 2021-08-09  1516  		if (support_short_GI(adapt, &pmlmeinfo->HT_caps))
8cd574e6af5463a Phillip Potter  2021-07-28  1517  			shortGIrate = true;
8cd574e6af5463a Phillip Potter  2021-07-28  1518  		break;
8cd574e6af5463a Phillip Potter  2021-07-28  1519  	case 1:/* for broadcast/multicast */
8cd574e6af5463a Phillip Potter  2021-07-28  1520  		supportRateNum = rtw_get_rateset_len(pmlmeinfo->FW_sta_info[mac_id].SupportedRates);
8cd574e6af5463a Phillip Potter  2021-07-28  1521  		if (pmlmeext->cur_wireless_mode & WIRELESS_11B)
8cd574e6af5463a Phillip Potter  2021-07-28  1522  			networkType = WIRELESS_11B;
8cd574e6af5463a Phillip Potter  2021-07-28  1523  		else
8cd574e6af5463a Phillip Potter  2021-07-28  1524  			networkType = WIRELESS_11G;
8cd574e6af5463a Phillip Potter  2021-07-28  1525  		raid = networktype_to_raid(networkType);
8cd574e6af5463a Phillip Potter  2021-07-28  1526  		mask = update_basic_rate(cur_network->SupportedRates, supportRateNum);
8cd574e6af5463a Phillip Potter  2021-07-28  1527  		break;
8cd574e6af5463a Phillip Potter  2021-07-28  1528  	default: /* for each sta in IBSS */
8cd574e6af5463a Phillip Potter  2021-07-28  1529  		supportRateNum = rtw_get_rateset_len(pmlmeinfo->FW_sta_info[mac_id].SupportedRates);
8cd574e6af5463a Phillip Potter  2021-07-28  1530  		networkType = judge_network_type(adapt, pmlmeinfo->FW_sta_info[mac_id].SupportedRates, supportRateNum) & 0xf;
8cd574e6af5463a Phillip Potter  2021-07-28  1531  		raid = networktype_to_raid(networkType);
8cd574e6af5463a Phillip Potter  2021-07-28  1532  		mask = update_supported_rate(cur_network->SupportedRates, supportRateNum);
8cd574e6af5463a Phillip Potter  2021-07-28  1533  
8cd574e6af5463a Phillip Potter  2021-07-28  1534  		/* todo: support HT in IBSS */
8cd574e6af5463a Phillip Potter  2021-07-28  1535  		break;
8cd574e6af5463a Phillip Potter  2021-07-28  1536  	}
8cd574e6af5463a Phillip Potter  2021-07-28  1537  
8cd574e6af5463a Phillip Potter  2021-07-28  1538  	rate_bitmap = 0x0fffffff;
8cd574e6af5463a Phillip Potter  2021-07-28  1539  	rate_bitmap = ODM_Get_Rate_Bitmap(&haldata->odmpriv, mac_id, mask, rssi_level);
8cd574e6af5463a Phillip Potter  2021-07-28  1540  
8cd574e6af5463a Phillip Potter  2021-07-28  1541  	mask &= rate_bitmap;
8cd574e6af5463a Phillip Potter  2021-07-28  1542  
8cd574e6af5463a Phillip Potter  2021-07-28  1543  	init_rate = get_highest_rate_idx(mask) & 0x3f;
8cd574e6af5463a Phillip Potter  2021-07-28  1544  
8cd574e6af5463a Phillip Potter  2021-07-28  1545  	if (haldata->fw_ractrl) {
8cd574e6af5463a Phillip Potter  2021-07-28 @1546  		u8 arg;
8cd574e6af5463a Phillip Potter  2021-07-28  1547  
8cd574e6af5463a Phillip Potter  2021-07-28  1548  		arg = mac_id & 0x1f;/* MACID */
8cd574e6af5463a Phillip Potter  2021-07-28  1549  		arg |= BIT(7);
8cd574e6af5463a Phillip Potter  2021-07-28  1550  		if (shortGIrate)
8cd574e6af5463a Phillip Potter  2021-07-28  1551  			arg |= BIT(5);
8cd574e6af5463a Phillip Potter  2021-07-28  1552  		mask |= ((raid << 28) & 0xf0000000);
8cd574e6af5463a Phillip Potter  2021-07-28  1553  		psta->ra_mask = mask;
8cd574e6af5463a Phillip Potter  2021-07-28  1554  		mask |= ((raid << 28) & 0xf0000000);
8cd574e6af5463a Phillip Potter  2021-07-28  1555  
8cd574e6af5463a Phillip Potter  2021-07-28  1556  		/* to do ,for 8188E-SMIC */
8cd574e6af5463a Phillip Potter  2021-07-28  1557  		rtl8188e_set_raid_cmd(adapt, mask);
8cd574e6af5463a Phillip Potter  2021-07-28  1558  	} else {
6839ff57baa4a60 Michael Straube 2021-08-09  1559  		ODM_RA_UpdateRateInfo_8188E(&haldata->odmpriv,
8cd574e6af5463a Phillip Potter  2021-07-28  1560  				mac_id,
8cd574e6af5463a Phillip Potter  2021-07-28  1561  				raid,
8cd574e6af5463a Phillip Potter  2021-07-28  1562  				mask,
8cd574e6af5463a Phillip Potter  2021-07-28  1563  				shortGIrate
8cd574e6af5463a Phillip Potter  2021-07-28  1564  				);
8cd574e6af5463a Phillip Potter  2021-07-28  1565  	}
8cd574e6af5463a Phillip Potter  2021-07-28  1566  	/* set ra_id */
8cd574e6af5463a Phillip Potter  2021-07-28  1567  	psta->raid = raid;
8cd574e6af5463a Phillip Potter  2021-07-28  1568  	psta->init_rate = init_rate;
8cd574e6af5463a Phillip Potter  2021-07-28  1569  }
8cd574e6af5463a Phillip Potter  2021-07-28  1570  

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
