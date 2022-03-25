Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 583D94E6E53
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Mar 2022 07:43:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358487AbiCYGpB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Mar 2022 02:45:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231467AbiCYGo7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 02:44:59 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F0EE5DA22
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 23:43:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648190604; x=1679726604;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=KPMRaQCg2grDpT/7sJ0t4jSIwAVtcRyCXDS0pxmcF4I=;
  b=jDFGGFdSrGc+w45UWeClbDK0n2qZChcbrFoq1YbhuaL2tIq5NFbRSxLA
   T1GIbYVP8dW1/UcVse4TAKqr/W1TN1CQHDr64O6nTx56wn55f/8sCBHb4
   ZQ/9hS4wbbOHyiWx4HiUiLp/rdOqo2bPiNr9oT6X2y2qU5BBIFp/80VyC
   Sg9sXEYLN0im8FgXiXpZ5QfuGeefEA+u9aVNxUz1PAu/ecxp1gy7ve1VK
   p+GNEIjr1f7i5sCs46be311hl+NTnAZxnvA045N67FyLiZZYnlZ4ARrL6
   iPam0f28AV5CUNqRIhtm48Iv2IAVJ7kne3A1TF5DDxNuMALEu1gghznTT
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10296"; a="239171371"
X-IronPort-AV: E=Sophos;i="5.90,209,1643702400"; 
   d="scan'208";a="239171371"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2022 23:43:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,209,1643702400"; 
   d="scan'208";a="718114810"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 24 Mar 2022 23:43:21 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nXdfM-000LtO-D7; Fri, 25 Mar 2022 06:43:20 +0000
Date:   Fri, 25 Mar 2022 14:42:38 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Kalle Valo <kvalo@codeaurora.org>
Subject: drivers/net/wireless/realtek/rtw89/coex.c:3244:25: warning: variable
 'cnt_connecting' set but not used
Message-ID: <202203251402.WJNfqX5H-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   34af78c4e616c359ed428d79fe4758a35d2c5473
commit: e3ec7017f6a20d12ddd9fe23d345ebb7b8c104dd rtw89: add Realtek 802.11ax driver
date:   5 months ago
config: x86_64-allmodconfig (https://download.01.org/0day-ci/archive/20220325/202203251402.WJNfqX5H-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 0f6d9501cf49ce02937099350d08f20c4af86f3d)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=e3ec7017f6a20d12ddd9fe23d345ebb7b8c104dd
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout e3ec7017f6a20d12ddd9fe23d345ebb7b8c104dd
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash drivers/net/wireless/realtek/rtw89/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/net/wireless/realtek/rtw89/coex.c:3244:25: warning: variable 'cnt_connecting' set but not used [-Wunused-but-set-variable]
           u8 i, cnt_connect = 0, cnt_connecting = 0, cnt_active = 0;
                                  ^
   1 warning generated.


vim +/cnt_connecting +3244 drivers/net/wireless/realtek/rtw89/coex.c

  3236	
  3237	static void _update_wl_info(struct rtw89_dev *rtwdev)
  3238	{
  3239		struct rtw89_btc *btc = &rtwdev->btc;
  3240		struct rtw89_btc_wl_info *wl = &btc->cx.wl;
  3241		struct rtw89_btc_wl_link_info *wl_linfo = wl->link_info;
  3242		struct rtw89_btc_wl_role_info *wl_rinfo = &wl->role_info;
  3243		struct rtw89_btc_wl_dbcc_info *wl_dinfo = &wl->dbcc_info;
> 3244		u8 i, cnt_connect = 0, cnt_connecting = 0, cnt_active = 0;
  3245		u8 cnt_2g = 0, cnt_5g = 0, phy;
  3246		u32 wl_2g_ch[2] = {0}, wl_5g_ch[2] = {0};
  3247		bool b2g = false, b5g = false, client_joined = false;
  3248	
  3249		memset(wl_rinfo, 0, sizeof(*wl_rinfo));
  3250	
  3251		for (i = 0; i < RTW89_MAX_HW_PORT_NUM; i++) {
  3252			/* check if role active? */
  3253			if (!wl_linfo[i].active)
  3254				continue;
  3255	
  3256			cnt_active++;
  3257			wl_rinfo->active_role[cnt_active - 1].role = wl_linfo[i].role;
  3258			wl_rinfo->active_role[cnt_active - 1].pid = wl_linfo[i].pid;
  3259			wl_rinfo->active_role[cnt_active - 1].phy = wl_linfo[i].phy;
  3260			wl_rinfo->active_role[cnt_active - 1].band = wl_linfo[i].band;
  3261			wl_rinfo->active_role[cnt_active - 1].noa = (u8)wl_linfo[i].noa;
  3262			wl_rinfo->active_role[cnt_active - 1].connected = 0;
  3263	
  3264			wl->port_id[wl_linfo[i].role] = wl_linfo[i].pid;
  3265	
  3266			phy = wl_linfo[i].phy;
  3267	
  3268			/* check dbcc role */
  3269			if (rtwdev->dbcc_en && phy < RTW89_PHY_MAX) {
  3270				wl_dinfo->role[phy] = wl_linfo[i].role;
  3271				wl_dinfo->op_band[phy] = wl_linfo[i].band;
  3272				_update_dbcc_band(rtwdev, phy);
  3273				_fw_set_drv_info(rtwdev, CXDRVINFO_DBCC);
  3274			}
  3275	
  3276			if (wl_linfo[i].connected == MLME_NO_LINK) {
  3277				continue;
  3278			} else if (wl_linfo[i].connected == MLME_LINKING) {
  3279				cnt_connecting++;
  3280			} else {
  3281				cnt_connect++;
  3282				if ((wl_linfo[i].role == RTW89_WIFI_ROLE_P2P_GO ||
  3283				     wl_linfo[i].role == RTW89_WIFI_ROLE_AP) &&
  3284				     wl_linfo[i].client_cnt > 1)
  3285					client_joined = true;
  3286			}
  3287	
  3288			wl_rinfo->role_map.val |= BIT(wl_linfo[i].role);
  3289			wl_rinfo->active_role[cnt_active - 1].ch = wl_linfo[i].ch;
  3290			wl_rinfo->active_role[cnt_active - 1].bw = wl_linfo[i].bw;
  3291			wl_rinfo->active_role[cnt_active - 1].connected = 1;
  3292	
  3293			/* only care 2 roles + BT coex */
  3294			if (wl_linfo[i].band != RTW89_BAND_2G) {
  3295				if (cnt_5g <= ARRAY_SIZE(wl_5g_ch) - 1)
  3296					wl_5g_ch[cnt_5g] = wl_linfo[i].ch;
  3297				cnt_5g++;
  3298				b5g = true;
  3299			} else {
  3300				if (cnt_2g <= ARRAY_SIZE(wl_2g_ch) - 1)
  3301					wl_2g_ch[cnt_2g] = wl_linfo[i].ch;
  3302				cnt_2g++;
  3303				b2g = true;
  3304			}
  3305		}
  3306	
  3307		wl_rinfo->connect_cnt = cnt_connect;
  3308	
  3309		/* Be careful to change the following sequence!! */
  3310		if (cnt_connect == 0) {
  3311			wl_rinfo->link_mode = BTC_WLINK_NOLINK;
  3312			wl_rinfo->role_map.role.none = 1;
  3313		} else if (!b2g && b5g) {
  3314			wl_rinfo->link_mode = BTC_WLINK_5G;
  3315		} else if (wl_rinfo->role_map.role.nan) {
  3316			wl_rinfo->link_mode = BTC_WLINK_2G_NAN;
  3317		} else if (cnt_connect > BTC_TDMA_WLROLE_MAX) {
  3318			wl_rinfo->link_mode = BTC_WLINK_OTHER;
  3319		} else  if (b2g && b5g && cnt_connect == 2) {
  3320			if (rtwdev->dbcc_en) {
  3321				switch (wl_dinfo->role[RTW89_PHY_0]) {
  3322				case RTW89_WIFI_ROLE_STATION:
  3323					wl_rinfo->link_mode = BTC_WLINK_2G_STA;
  3324					break;
  3325				case RTW89_WIFI_ROLE_P2P_GO:
  3326					wl_rinfo->link_mode = BTC_WLINK_2G_GO;
  3327					break;
  3328				case RTW89_WIFI_ROLE_P2P_CLIENT:
  3329					wl_rinfo->link_mode = BTC_WLINK_2G_GC;
  3330					break;
  3331				case RTW89_WIFI_ROLE_AP:
  3332					wl_rinfo->link_mode = BTC_WLINK_2G_AP;
  3333					break;
  3334				default:
  3335					wl_rinfo->link_mode = BTC_WLINK_OTHER;
  3336					break;
  3337				}
  3338			} else {
  3339				wl_rinfo->link_mode = BTC_WLINK_25G_MCC;
  3340			}
  3341		} else if (!b5g && cnt_connect == 2) {
  3342			if (wl_rinfo->role_map.role.station &&
  3343			    (wl_rinfo->role_map.role.p2p_go ||
  3344			    wl_rinfo->role_map.role.p2p_gc ||
  3345			    wl_rinfo->role_map.role.ap)) {
  3346				if (wl_2g_ch[0] == wl_2g_ch[1])
  3347					wl_rinfo->link_mode = BTC_WLINK_2G_SCC;
  3348				else
  3349					wl_rinfo->link_mode = BTC_WLINK_2G_MCC;
  3350			} else {
  3351				wl_rinfo->link_mode = BTC_WLINK_2G_MCC;
  3352			}
  3353		} else if (!b5g && cnt_connect == 1) {
  3354			if (wl_rinfo->role_map.role.station)
  3355				wl_rinfo->link_mode = BTC_WLINK_2G_STA;
  3356			else if (wl_rinfo->role_map.role.ap)
  3357				wl_rinfo->link_mode = BTC_WLINK_2G_AP;
  3358			else if (wl_rinfo->role_map.role.p2p_go)
  3359				wl_rinfo->link_mode = BTC_WLINK_2G_GO;
  3360			else if (wl_rinfo->role_map.role.p2p_gc)
  3361				wl_rinfo->link_mode = BTC_WLINK_2G_GC;
  3362			else
  3363				wl_rinfo->link_mode = BTC_WLINK_OTHER;
  3364		}
  3365	
  3366		/* if no client_joined, don't care P2P-GO/AP role */
  3367		if (wl_rinfo->role_map.role.p2p_go || wl_rinfo->role_map.role.ap) {
  3368			if (!client_joined) {
  3369				if (wl_rinfo->link_mode == BTC_WLINK_2G_SCC ||
  3370				    wl_rinfo->link_mode == BTC_WLINK_2G_MCC) {
  3371					wl_rinfo->link_mode = BTC_WLINK_2G_STA;
  3372					wl_rinfo->connect_cnt = 1;
  3373				} else if (wl_rinfo->link_mode == BTC_WLINK_2G_GO ||
  3374					 wl_rinfo->link_mode == BTC_WLINK_2G_AP) {
  3375					wl_rinfo->link_mode = BTC_WLINK_NOLINK;
  3376					wl_rinfo->connect_cnt = 0;
  3377				}
  3378			}
  3379		}
  3380	
  3381		rtw89_debug(rtwdev, RTW89_DBG_BTC,
  3382			    "[BTC], cnt_connect = %d, link_mode = %d\n",
  3383			    cnt_connect, wl_rinfo->link_mode);
  3384	
  3385		_fw_set_drv_info(rtwdev, CXDRVINFO_ROLE);
  3386	}
  3387	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
