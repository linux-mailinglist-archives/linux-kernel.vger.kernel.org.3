Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 046C24C04C3
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 23:40:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236105AbiBVWkh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 17:40:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230219AbiBVWke (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 17:40:34 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B14B1275C4
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 14:40:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645569607; x=1677105607;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=176wQLv+JPu+ax5PyfIh5eLueGcR4pg2eaaptBLTKaI=;
  b=UGEWFT4NTYHc07eWUZaOwinwv5B9VgguSd9DJOxCqyI9GkAlOzm/xgZc
   0N+v/bmj+/BK7d8GtfsNSnrCJXV4Zlmow0FM6uiy0wOtIl25U5j6Rww+8
   zhRrOVmxqGjxNQErLTwn/uYfctloYMtFRNQOqlx4kjqFOYRVFsZbutPpG
   anRzXEN+4YYlF+yjHDDuVFGDECzFt9dfToM69VjWcig6upHnTm/EEwEiy
   U3YuJ8gDns1yhCLid6KvtSVXAI+QhnnM7ww8pejA06dw1MqkqV5c1bXd2
   coRRBBHJP5mUeknxsQMlL3WKN9+b08EPdUOMizgmMTPvGkmuSunDFHyBP
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10266"; a="252019238"
X-IronPort-AV: E=Sophos;i="5.88,389,1635231600"; 
   d="scan'208";a="252019238"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2022 14:40:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,389,1635231600"; 
   d="scan'208";a="683686011"
Received: from lkp-server01.sh.intel.com (HELO 788b1cd46f0d) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 22 Feb 2022 14:40:06 -0800
Received: from kbuild by 788b1cd46f0d with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nMdpF-0000h7-Dh; Tue, 22 Feb 2022 22:40:05 +0000
Date:   Wed, 23 Feb 2022 06:39:30 +0800
From:   kernel test robot <lkp@intel.com>
To:     Phillip Potter <phil@philpotter.co.uk>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [staging:staging-next 55/83]
 drivers/staging/r8188eu/hal/usb_halinit.c:1541:6: warning: variable 'arg'
 set but not used
Message-ID: <202202230620.BKXzonUy-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git staging-next
head:   7c6444d8e0f1be30e7fd910e40c0d495c36e6935
commit: db67ebf6b49cd6909f210ee44eb51d3cf2e39ae4 [55/83] staging: r8188eu: remove DBG_88E calls from hal subdir
config: arm64-allyesconfig (https://download.01.org/0day-ci/archive/20220223/202202230620.BKXzonUy-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project d271fc04d5b97b12e6b797c6067d3c96a8d7470e)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm64 cross compiling tool for clang build
        # apt-get install binutils-aarch64-linux-gnu
        # https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git/commit/?id=db67ebf6b49cd6909f210ee44eb51d3cf2e39ae4
        git remote add staging https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git
        git fetch --no-tags staging staging-next
        git checkout db67ebf6b49cd6909f210ee44eb51d3cf2e39ae4
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm64 SHELL=/bin/bash drivers/pinctrl/ drivers/remoteproc/ drivers/staging/r8188eu/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/staging/r8188eu/hal/usb_halinit.c:1541:6: warning: variable 'arg' set but not used [-Wunused-but-set-variable]
                   u8 arg;
                      ^
   1 warning generated.


vim +/arg +1541 drivers/staging/r8188eu/hal/usb_halinit.c

8cd574e6af5463a Phillip Potter  2021-07-28  1485  
b561d2f0dc01ab0 Michael Straube 2021-09-06  1486  void UpdateHalRAMask8188EUsb(struct adapter *adapt, u32 mac_id, u8 rssi_level)
8cd574e6af5463a Phillip Potter  2021-07-28  1487  {
8cd574e6af5463a Phillip Potter  2021-07-28  1488  	u8 init_rate = 0;
8cd574e6af5463a Phillip Potter  2021-07-28  1489  	u8 networkType, raid;
8cd574e6af5463a Phillip Potter  2021-07-28  1490  	u32 mask, rate_bitmap;
8cd574e6af5463a Phillip Potter  2021-07-28  1491  	u8 shortGIrate = false;
8cd574e6af5463a Phillip Potter  2021-07-28  1492  	int	supportRateNum = 0;
8cd574e6af5463a Phillip Potter  2021-07-28  1493  	struct sta_info	*psta;
d904512db6f3727 Michael Straube 2021-12-07  1494  	struct hal_data_8188e *haldata = &adapt->haldata;
8cd574e6af5463a Phillip Potter  2021-07-28  1495  	struct mlme_ext_priv	*pmlmeext = &adapt->mlmeextpriv;
6839ff57baa4a60 Michael Straube 2021-08-09  1496  	struct mlme_ext_info	*pmlmeinfo = &pmlmeext->mlmext_info;
6839ff57baa4a60 Michael Straube 2021-08-09  1497  	struct wlan_bssid_ex	*cur_network = &pmlmeinfo->network;
8cd574e6af5463a Phillip Potter  2021-07-28  1498  
8cd574e6af5463a Phillip Potter  2021-07-28  1499  	if (mac_id >= NUM_STA) /* CAM_SIZE */
8cd574e6af5463a Phillip Potter  2021-07-28  1500  		return;
8cd574e6af5463a Phillip Potter  2021-07-28  1501  	psta = pmlmeinfo->FW_sta_info[mac_id].psta;
725a3f1c4d56b73 Michael Straube 2021-08-01  1502  	if (!psta)
8cd574e6af5463a Phillip Potter  2021-07-28  1503  		return;
8cd574e6af5463a Phillip Potter  2021-07-28  1504  	switch (mac_id) {
8cd574e6af5463a Phillip Potter  2021-07-28  1505  	case 0:/*  for infra mode */
8cd574e6af5463a Phillip Potter  2021-07-28  1506  		supportRateNum = rtw_get_rateset_len(cur_network->SupportedRates);
8cd574e6af5463a Phillip Potter  2021-07-28  1507  		networkType = judge_network_type(adapt, cur_network->SupportedRates, supportRateNum) & 0xf;
8cd574e6af5463a Phillip Potter  2021-07-28  1508  		raid = networktype_to_raid(networkType);
8cd574e6af5463a Phillip Potter  2021-07-28  1509  		mask = update_supported_rate(cur_network->SupportedRates, supportRateNum);
6839ff57baa4a60 Michael Straube 2021-08-09  1510  		mask |= (pmlmeinfo->HT_enable) ? update_MSC_rate(&pmlmeinfo->HT_caps) : 0;
6839ff57baa4a60 Michael Straube 2021-08-09  1511  		if (support_short_GI(adapt, &pmlmeinfo->HT_caps))
8cd574e6af5463a Phillip Potter  2021-07-28  1512  			shortGIrate = true;
8cd574e6af5463a Phillip Potter  2021-07-28  1513  		break;
8cd574e6af5463a Phillip Potter  2021-07-28  1514  	case 1:/* for broadcast/multicast */
8cd574e6af5463a Phillip Potter  2021-07-28  1515  		supportRateNum = rtw_get_rateset_len(pmlmeinfo->FW_sta_info[mac_id].SupportedRates);
8cd574e6af5463a Phillip Potter  2021-07-28  1516  		if (pmlmeext->cur_wireless_mode & WIRELESS_11B)
8cd574e6af5463a Phillip Potter  2021-07-28  1517  			networkType = WIRELESS_11B;
8cd574e6af5463a Phillip Potter  2021-07-28  1518  		else
8cd574e6af5463a Phillip Potter  2021-07-28  1519  			networkType = WIRELESS_11G;
8cd574e6af5463a Phillip Potter  2021-07-28  1520  		raid = networktype_to_raid(networkType);
8cd574e6af5463a Phillip Potter  2021-07-28  1521  		mask = update_basic_rate(cur_network->SupportedRates, supportRateNum);
8cd574e6af5463a Phillip Potter  2021-07-28  1522  		break;
8cd574e6af5463a Phillip Potter  2021-07-28  1523  	default: /* for each sta in IBSS */
8cd574e6af5463a Phillip Potter  2021-07-28  1524  		supportRateNum = rtw_get_rateset_len(pmlmeinfo->FW_sta_info[mac_id].SupportedRates);
8cd574e6af5463a Phillip Potter  2021-07-28  1525  		networkType = judge_network_type(adapt, pmlmeinfo->FW_sta_info[mac_id].SupportedRates, supportRateNum) & 0xf;
8cd574e6af5463a Phillip Potter  2021-07-28  1526  		raid = networktype_to_raid(networkType);
8cd574e6af5463a Phillip Potter  2021-07-28  1527  		mask = update_supported_rate(cur_network->SupportedRates, supportRateNum);
8cd574e6af5463a Phillip Potter  2021-07-28  1528  
8cd574e6af5463a Phillip Potter  2021-07-28  1529  		/* todo: support HT in IBSS */
8cd574e6af5463a Phillip Potter  2021-07-28  1530  		break;
8cd574e6af5463a Phillip Potter  2021-07-28  1531  	}
8cd574e6af5463a Phillip Potter  2021-07-28  1532  
8cd574e6af5463a Phillip Potter  2021-07-28  1533  	rate_bitmap = 0x0fffffff;
8cd574e6af5463a Phillip Potter  2021-07-28  1534  	rate_bitmap = ODM_Get_Rate_Bitmap(&haldata->odmpriv, mac_id, mask, rssi_level);
8cd574e6af5463a Phillip Potter  2021-07-28  1535  
8cd574e6af5463a Phillip Potter  2021-07-28  1536  	mask &= rate_bitmap;
8cd574e6af5463a Phillip Potter  2021-07-28  1537  
8cd574e6af5463a Phillip Potter  2021-07-28  1538  	init_rate = get_highest_rate_idx(mask) & 0x3f;
8cd574e6af5463a Phillip Potter  2021-07-28  1539  
8cd574e6af5463a Phillip Potter  2021-07-28  1540  	if (haldata->fw_ractrl) {
8cd574e6af5463a Phillip Potter  2021-07-28 @1541  		u8 arg;
8cd574e6af5463a Phillip Potter  2021-07-28  1542  
8cd574e6af5463a Phillip Potter  2021-07-28  1543  		arg = mac_id & 0x1f;/* MACID */
8cd574e6af5463a Phillip Potter  2021-07-28  1544  		arg |= BIT(7);
8cd574e6af5463a Phillip Potter  2021-07-28  1545  		if (shortGIrate)
8cd574e6af5463a Phillip Potter  2021-07-28  1546  			arg |= BIT(5);
8cd574e6af5463a Phillip Potter  2021-07-28  1547  		mask |= ((raid << 28) & 0xf0000000);
8cd574e6af5463a Phillip Potter  2021-07-28  1548  		psta->ra_mask = mask;
8cd574e6af5463a Phillip Potter  2021-07-28  1549  		mask |= ((raid << 28) & 0xf0000000);
8cd574e6af5463a Phillip Potter  2021-07-28  1550  
8cd574e6af5463a Phillip Potter  2021-07-28  1551  		/* to do ,for 8188E-SMIC */
8cd574e6af5463a Phillip Potter  2021-07-28  1552  		rtl8188e_set_raid_cmd(adapt, mask);
8cd574e6af5463a Phillip Potter  2021-07-28  1553  	} else {
6839ff57baa4a60 Michael Straube 2021-08-09  1554  		ODM_RA_UpdateRateInfo_8188E(&haldata->odmpriv,
8cd574e6af5463a Phillip Potter  2021-07-28  1555  				mac_id,
8cd574e6af5463a Phillip Potter  2021-07-28  1556  				raid,
8cd574e6af5463a Phillip Potter  2021-07-28  1557  				mask,
8cd574e6af5463a Phillip Potter  2021-07-28  1558  				shortGIrate
8cd574e6af5463a Phillip Potter  2021-07-28  1559  				);
8cd574e6af5463a Phillip Potter  2021-07-28  1560  	}
8cd574e6af5463a Phillip Potter  2021-07-28  1561  	/* set ra_id */
8cd574e6af5463a Phillip Potter  2021-07-28  1562  	psta->raid = raid;
8cd574e6af5463a Phillip Potter  2021-07-28  1563  	psta->init_rate = init_rate;
8cd574e6af5463a Phillip Potter  2021-07-28  1564  }
8cd574e6af5463a Phillip Potter  2021-07-28  1565  

:::::: The code at line 1541 was first introduced by commit
:::::: 8cd574e6af5463af7d693d111c61212e52c44810 staging: r8188eu: introduce new hal dir for RTL8188eu driver

:::::: TO: Phillip Potter <phil@philpotter.co.uk>
:::::: CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
