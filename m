Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E4484EF988
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 20:08:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350944AbiDASKb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 14:10:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236250AbiDASKZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 14:10:25 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D27ED222BC
        for <linux-kernel@vger.kernel.org>; Fri,  1 Apr 2022 11:08:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648836514; x=1680372514;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=DU9PgH/5rb/qkF9q+WrXb9XrVXA9a5dGo5mm1m9YnB0=;
  b=UCtb36vYQL9/5IroLSSPLErbYBjMEr+WP1VQ9amTS/C2WTzhj1kK1Y81
   PKW3jnwZQgZ14LCanGztoSg5GZgluXO/K82UsIlcmIsAMvDCRoHAuP+j0
   ZtMuUiiG9ygbIKOFPwlB5S4ygKFj/H263Rn2JtWxZ9hbG6Zr5VljVaXh1
   3EdQbVmnvOEQ0I3wmKoOATKzC9lRM5LxHi9C/Huulal0CJRC2eYmfQbut
   tsbFx77svSEWUdCzfwHdeULNG+KE2jDqYNGcj/VzN+WMxckWDAOxA1e3K
   N94Z+1MF6qUfi5bHj2+4fEG0JsUcXunxTJuSM58dKJYV5sjzTQZDP6vH7
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10304"; a="240137058"
X-IronPort-AV: E=Sophos;i="5.90,228,1643702400"; 
   d="scan'208";a="240137058"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2022 11:08:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,228,1643702400"; 
   d="scan'208";a="547894028"
Received: from lkp-server02.sh.intel.com (HELO 3231c491b0e2) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 01 Apr 2022 11:08:32 -0700
Received: from kbuild by 3231c491b0e2 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1naLhH-0001S0-EK;
        Fri, 01 Apr 2022 18:08:31 +0000
Date:   Sat, 2 Apr 2022 02:08:02 +0800
From:   kernel test robot <lkp@intel.com>
To:     Sevinj Aghayeva <sevinj.aghayeva@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     kbuild-all@lists.01.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, outreachy@lists.linux.dev,
        Sevinj Aghayeva <sevinj.aghayeva@gmail.com>
Subject: Re: [PATCH 3/3] staging: rtl8723bs: remove redundant else branches
Message-ID: <202204020208.cUdIa2Q2-lkp@intel.com>
References: <8d745122cd10f5db59393b1bff09e6a73e88640b.1648817213.git.sevinj.aghayeva@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8d745122cd10f5db59393b1bff09e6a73e88640b.1648817213.git.sevinj.aghayeva@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sevinj,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on staging/staging-testing]
[also build test WARNING on v5.17 next-20220401]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Sevinj-Aghayeva/rlt8723bs-cleanup/20220401-210507
base:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git b22c721c4f3fd4608da059c56fbe7a0cc598fb6a
config: alpha-allyesconfig (https://download.01.org/0day-ci/archive/20220402/202204020208.cUdIa2Q2-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/ed0a6d578663ac28fa89918bc7ad86c0e6f82f8a
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Sevinj-Aghayeva/rlt8723bs-cleanup/20220401-210507
        git checkout ed0a6d578663ac28fa89918bc7ad86c0e6f82f8a
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=alpha SHELL=/bin/bash drivers/staging/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   drivers/staging/rtl8723bs/core/rtw_mlme_ext.c: In function 'OnDeAuth':
>> drivers/staging/rtl8723bs/core/rtw_mlme_ext.c:1505:9: warning: ISO C90 forbids mixed declarations and code [-Wdeclaration-after-statement]
    1505 |         int     ignore_received_deauth = 0;
         |         ^~~


vim +1505 drivers/staging/rtl8723bs/core/rtw_mlme_ext.c

554c0a3abf216c Hans de Goede   2017-03-29  1461  
554c0a3abf216c Hans de Goede   2017-03-29  1462  unsigned int OnDeAuth(struct adapter *padapter, union recv_frame *precv_frame)
554c0a3abf216c Hans de Goede   2017-03-29  1463  {
554c0a3abf216c Hans de Goede   2017-03-29  1464  	unsigned short	reason;
554c0a3abf216c Hans de Goede   2017-03-29  1465  	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
554c0a3abf216c Hans de Goede   2017-03-29  1466  	struct mlme_ext_priv *pmlmeext = &padapter->mlmeextpriv;
554c0a3abf216c Hans de Goede   2017-03-29  1467  	struct mlme_ext_info *pmlmeinfo = &(pmlmeext->mlmext_info);
554c0a3abf216c Hans de Goede   2017-03-29  1468  	u8 *pframe = precv_frame->u.hdr.rx_data;
554c0a3abf216c Hans de Goede   2017-03-29  1469  
554c0a3abf216c Hans de Goede   2017-03-29  1470  	/* check A3 */
554c0a3abf216c Hans de Goede   2017-03-29  1471  	if (memcmp(GetAddr3Ptr(pframe), get_my_bssid(&pmlmeinfo->network), ETH_ALEN))
554c0a3abf216c Hans de Goede   2017-03-29  1472  		return _SUCCESS;
554c0a3abf216c Hans de Goede   2017-03-29  1473  
554c0a3abf216c Hans de Goede   2017-03-29  1474  	reason = le16_to_cpu(*(__le16 *)(pframe + WLAN_HDR_A3_LEN));
554c0a3abf216c Hans de Goede   2017-03-29  1475  
0ad02fa8b90a87 Georgiana Chelu 2017-09-22  1476  	if (check_fwstate(pmlmepriv, WIFI_AP_STATE)) {
554c0a3abf216c Hans de Goede   2017-03-29  1477  		struct sta_info *psta;
554c0a3abf216c Hans de Goede   2017-03-29  1478  		struct sta_priv *pstapriv = &padapter->stapriv;
554c0a3abf216c Hans de Goede   2017-03-29  1479  
554c0a3abf216c Hans de Goede   2017-03-29  1480  		/* rtw_free_stainfo(padapter, psta); */
554c0a3abf216c Hans de Goede   2017-03-29  1481  
79df841b435018 Fabio Aiuto     2021-04-15  1482  		netdev_dbg(padapter->pnetdev,
79df841b435018 Fabio Aiuto     2021-04-15  1483  			   "ap recv deauth reason code(%d) sta:%pM\n", reason,
79df841b435018 Fabio Aiuto     2021-04-15  1484  			   GetAddr2Ptr(pframe));
554c0a3abf216c Hans de Goede   2017-03-29  1485  
554c0a3abf216c Hans de Goede   2017-03-29  1486  		psta = rtw_get_stainfo(pstapriv, GetAddr2Ptr(pframe));
554c0a3abf216c Hans de Goede   2017-03-29  1487  		if (psta) {
554c0a3abf216c Hans de Goede   2017-03-29  1488  			u8 updated = false;
554c0a3abf216c Hans de Goede   2017-03-29  1489  
554c0a3abf216c Hans de Goede   2017-03-29  1490  			spin_lock_bh(&pstapriv->asoc_list_lock);
554c0a3abf216c Hans de Goede   2017-03-29  1491  			if (list_empty(&psta->asoc_list) == false) {
554c0a3abf216c Hans de Goede   2017-03-29  1492  				list_del_init(&psta->asoc_list);
554c0a3abf216c Hans de Goede   2017-03-29  1493  				pstapriv->asoc_list_cnt--;
554c0a3abf216c Hans de Goede   2017-03-29  1494  				updated = ap_free_sta(padapter, psta, false, reason);
554c0a3abf216c Hans de Goede   2017-03-29  1495  
554c0a3abf216c Hans de Goede   2017-03-29  1496  			}
554c0a3abf216c Hans de Goede   2017-03-29  1497  			spin_unlock_bh(&pstapriv->asoc_list_lock);
554c0a3abf216c Hans de Goede   2017-03-29  1498  
554c0a3abf216c Hans de Goede   2017-03-29  1499  			associated_clients_update(padapter, updated);
554c0a3abf216c Hans de Goede   2017-03-29  1500  		}
554c0a3abf216c Hans de Goede   2017-03-29  1501  
554c0a3abf216c Hans de Goede   2017-03-29  1502  
554c0a3abf216c Hans de Goede   2017-03-29  1503  		return _SUCCESS;
ed0a6d578663ac Sevinj Aghayeva 2022-04-01  1504  	}
554c0a3abf216c Hans de Goede   2017-03-29 @1505  	int	ignore_received_deauth = 0;
554c0a3abf216c Hans de Goede   2017-03-29  1506  
554c0a3abf216c Hans de Goede   2017-03-29  1507  	/* 	Commented by Albert 20130604 */
554c0a3abf216c Hans de Goede   2017-03-29  1508  	/* 	Before sending the auth frame to start the STA/GC mode connection with AP/GO, */
554c0a3abf216c Hans de Goede   2017-03-29  1509  	/* 	we will send the deauth first. */
554c0a3abf216c Hans de Goede   2017-03-29  1510  	/* 	However, the Win8.1 with BRCM Wi-Fi will send the deauth with reason code 6 to us after receieving our deauth. */
554c0a3abf216c Hans de Goede   2017-03-29  1511  	/* 	Added the following code to avoid this case. */
554c0a3abf216c Hans de Goede   2017-03-29  1512  	if ((pmlmeinfo->state & WIFI_FW_AUTH_STATE) ||
554c0a3abf216c Hans de Goede   2017-03-29  1513  		(pmlmeinfo->state & WIFI_FW_ASSOC_STATE)) {
554c0a3abf216c Hans de Goede   2017-03-29  1514  		if (reason == WLAN_REASON_CLASS2_FRAME_FROM_NONAUTH_STA) {
554c0a3abf216c Hans de Goede   2017-03-29  1515  			ignore_received_deauth = 1;
a8be3a14951eb8 Sevinj Aghayeva 2022-04-01  1516  		} else if (reason == WLAN_REASON_PREV_AUTH_NOT_VALID) {
554c0a3abf216c Hans de Goede   2017-03-29  1517  			/*  TODO: 802.11r */
554c0a3abf216c Hans de Goede   2017-03-29  1518  			ignore_received_deauth = 1;
554c0a3abf216c Hans de Goede   2017-03-29  1519  		}
554c0a3abf216c Hans de Goede   2017-03-29  1520  	}
554c0a3abf216c Hans de Goede   2017-03-29  1521  
79df841b435018 Fabio Aiuto     2021-04-15  1522  	netdev_dbg(padapter->pnetdev,
79df841b435018 Fabio Aiuto     2021-04-15  1523  		"sta recv deauth reason code(%d) sta:%pM, ignore = %d\n",
79df841b435018 Fabio Aiuto     2021-04-15  1524  		reason, GetAddr3Ptr(pframe),
79df841b435018 Fabio Aiuto     2021-04-15  1525  		ignore_received_deauth);
554c0a3abf216c Hans de Goede   2017-03-29  1526  
a8be3a14951eb8 Sevinj Aghayeva 2022-04-01  1527  	if (ignore_received_deauth == 0)
554c0a3abf216c Hans de Goede   2017-03-29  1528  		receive_disconnect(padapter, GetAddr3Ptr(pframe), reason);
ed0a6d578663ac Sevinj Aghayeva 2022-04-01  1529  
554c0a3abf216c Hans de Goede   2017-03-29  1530  	pmlmepriv->LinkDetectInfo.bBusyTraffic = false;
554c0a3abf216c Hans de Goede   2017-03-29  1531  	return _SUCCESS;
554c0a3abf216c Hans de Goede   2017-03-29  1532  

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
