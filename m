Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 332F058BB34
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Aug 2022 16:18:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233553AbiHGOSm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Aug 2022 10:18:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230020AbiHGOSj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Aug 2022 10:18:39 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07BE863FA
        for <linux-kernel@vger.kernel.org>; Sun,  7 Aug 2022 07:18:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659881916; x=1691417916;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=4BrGEHs/BfnzTz3X2LkZNqHPcyaOzG7VcuAVBesCzFM=;
  b=JAU1vAbpduq858loxZaS5TDmPNvqna1YQXS5NOrGVeqiXl9U6dFD/eF/
   qmvsToSPE7drGn22b0erwhZ9JG8VjKAWfkcxY1ZEaXq3wj18O2fC5uSNM
   D3wst5JR7ZrTbQuLkIgcrgSS/0DCzQ1ucikq8kHmC61s2Ip7HkPNh+JQY
   cPtquoLHE0IJlteu2ccI720N7vE1I6C6C/zUlA9OpG1Ks38j/GKR0xBgX
   DEieyv0NiUdT+moGi0fxbC2Pc8WUiQ+qwvLHC13zXCYtikJksqsaia4c3
   8xhDcMcLft9kHgZd28axbf792hjcTiwD8Ats5fTPweRe7VTABU+uhj9Xx
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10432"; a="376735377"
X-IronPort-AV: E=Sophos;i="5.93,220,1654585200"; 
   d="scan'208";a="376735377"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2022 07:18:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,220,1654585200"; 
   d="scan'208";a="931745115"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 07 Aug 2022 07:18:34 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oKh6v-000LLh-1v;
        Sun, 07 Aug 2022 14:18:33 +0000
Date:   Sun, 7 Aug 2022 22:18:08 +0800
From:   kernel test robot <lkp@intel.com>
To:     Simone Serra <serrazimone@gmail.com>, gregkh@linuxfoundation.org,
        fabioaiuto83@gmail.com, soumya.negi97@gmail.com,
        hdegoede@redhat.com, straube.linux@gmail.com
Cc:     kbuild-all@lists.01.org, Simone Serra <serrazimone@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fixes checkpatch warnings and checks
Message-ID: <202208072225.fazL9FsN-lkp@intel.com>
References: <20220805073932.225975-1-serrazimone@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220805073932.225975-1-serrazimone@gmail.com>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Simone,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on staging/staging-testing]
[also build test ERROR on linus/master v5.19 next-20220805]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Simone-Serra/Fixes-checkpatch-warnings-and-checks/20220805-154109
base:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git b2a88c212e652e94f1e4b635910972ac57ba4e97
config: i386-allyesconfig (https://download.01.org/0day-ci/archive/20220807/202208072225.fazL9FsN-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-3) 11.3.0
reproduce (this is a W=1 build):
        # https://github.com/intel-lab-lkp/linux/commit/d73d8cf7a17857c53ecdf684477d60e3492f0978
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Simone-Serra/Fixes-checkpatch-warnings-and-checks/20220805-154109
        git checkout d73d8cf7a17857c53ecdf684477d60e3492f0978
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash drivers/staging/rtl8723bs/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All error/warnings (new ones prefixed by >>):

   drivers/staging/rtl8723bs/core/rtw_ap.c: In function 'expire_timeout_chk':
>> drivers/staging/rtl8723bs/core/rtw_ap.c:280:25: error: implicit declaration of function 'select_channel'; did you mean 'SelectChannel'? [-Werror=implicit-function-declaration]
     280 |                         select_channel(padapter, pmlmeext->cur_channel);
         |                         ^~~~~~~~~~~~~~
         |                         SelectChannel
   drivers/staging/rtl8723bs/core/rtw_ap.c: At top level:
>> drivers/staging/rtl8723bs/core/rtw_ap.c:324:6: warning: no previous prototype for 'add_ratid' [-Wmissing-prototypes]
     324 | void add_ratid(struct adapter *padapter, struct sta_info *psta, u8 rssi_level)
         |      ^~~~~~~~~
   drivers/staging/rtl8723bs/core/rtw_ap.c: In function 'update_sta_info_apmode':
>> drivers/staging/rtl8723bs/core/rtw_ap.c:468:28: error: 'struct security_priv' has no member named 'dot11_auth_algrthm'; did you mean 'dot11AuthAlgrthm'?
     468 |         if (psecuritypriv->dot11_auth_algrthm == dot11_auth_algrthm_8021X)
         |                            ^~~~~~~~~~~~~~~~~~
         |                            dot11AuthAlgrthm
>> drivers/staging/rtl8723bs/core/rtw_ap.c:468:50: error: 'dot11_auth_algrthm_8021X' undeclared (first use in this function); did you mean 'dot11AuthAlgrthm_8021X'?
     468 |         if (psecuritypriv->dot11_auth_algrthm == dot11_auth_algrthm_8021X)
         |                                                  ^~~~~~~~~~~~~~~~~~~~~~~~
         |                                                  dot11AuthAlgrthm_8021X
   drivers/staging/rtl8723bs/core/rtw_ap.c:468:50: note: each undeclared identifier is reported only once for each function it appears in
   drivers/staging/rtl8723bs/core/rtw_ap.c: In function 'start_bss_network':
>> drivers/staging/rtl8723bs/core/rtw_ap.c:683:37: error: 'struct security_priv' has no member named 'dot11_privacy_algrthm'; did you mean 'dot11PrivacyAlgrthm'?
     683 |                 if ((psecuritypriv->dot11_privacy_algrthm != _WEP40_) &&
         |                                     ^~~~~~~~~~~~~~~~~~~~~
         |                                     dot11PrivacyAlgrthm
   drivers/staging/rtl8723bs/core/rtw_ap.c:684:37: error: 'struct security_priv' has no member named 'dot11_privacy_algrthm'; did you mean 'dot11PrivacyAlgrthm'?
     684 |                     (psecuritypriv->dot11_privacy_algrthm != _WEP104_))
         |                                     ^~~~~~~~~~~~~~~~~~~~~
         |                                     dot11PrivacyAlgrthm
>> drivers/staging/rtl8723bs/core/rtw_ap.c:689:9: error: implicit declaration of function 'set_msr'; did you mean 'Set_MSR'? [-Werror=implicit-function-declaration]
     689 |         set_msr(padapter, _HW_STATE_AP_);
         |         ^~~~~~~
         |         Set_MSR
   drivers/staging/rtl8723bs/core/rtw_ap.c:706:32: error: 'struct security_priv' has no member named 'dot11_auth_algrthm'; did you mean 'dot11AuthAlgrthm'?
     706 |         val8 = (psecuritypriv->dot11_auth_algrthm == dot11_auth_algrthm_8021X
         |                                ^~~~~~~~~~~~~~~~~~
         |                                dot11AuthAlgrthm
   drivers/staging/rtl8723bs/core/rtw_ap.c:706:54: error: 'dot11_auth_algrthm_8021X' undeclared (first use in this function); did you mean 'dot11AuthAlgrthm_8021X'?
     706 |         val8 = (psecuritypriv->dot11_auth_algrthm == dot11_auth_algrthm_8021X
         |                                                      ^~~~~~~~~~~~~~~~~~~~~~~~
         |                                                      dot11AuthAlgrthm_8021X
>> drivers/staging/rtl8723bs/core/rtw_ap.c:725:17: error: implicit declaration of function 'switch_DM_func'; did you mean 'Switch_DM_Func'? [-Werror=implicit-function-declaration]
     725 |                 switch_DM_func(padapter, DYNAMIC_ALL_FUNC_ENABLE, true);
         |                 ^~~~~~~~~~~~~~
         |                 Switch_DM_Func
>> drivers/staging/rtl8723bs/core/rtw_ap.c:783:9: error: implicit declaration of function 'update_brate_tbl'; did you mean 'UpdateBrateTbl'? [-Werror=implicit-function-declaration]
     783 |         update_brate_tbl(padapter, pnetwork->supported_rates);
         |         ^~~~~~~~~~~~~~~~
         |         UpdateBrateTbl
   drivers/staging/rtl8723bs/core/rtw_ap.c: In function 'rtw_check_beacon_data':
>> drivers/staging/rtl8723bs/core/rtw_ap.c:837:50: error: 'ndis802_11_ap_mode' undeclared (first use in this function); did you mean 'Ndis802_11APMode'?
     837 |         if (pbss_network->infrastructure_mode != ndis802_11_ap_mode)
         |                                                  ^~~~~~~~~~~~~~~~~~
         |                                                  Ndis802_11APMode
   drivers/staging/rtl8723bs/core/rtw_ap.c:940:40: error: 'struct security_priv' has no member named 'dot11_auth_algrthm'; did you mean 'dot11AuthAlgrthm'?
     940 |                         psecuritypriv->dot11_auth_algrthm = dot11_auth_algrthm_8021X;
         |                                        ^~~~~~~~~~~~~~~~~~
         |                                        dot11AuthAlgrthm
   drivers/staging/rtl8723bs/core/rtw_ap.c:940:61: error: 'dot11_auth_algrthm_8021X' undeclared (first use in this function); did you mean 'dot11AuthAlgrthm_8021X'?
     940 |                         psecuritypriv->dot11_auth_algrthm = dot11_auth_algrthm_8021X;
         |                                                             ^~~~~~~~~~~~~~~~~~~~~~~~
         |                                                             dot11AuthAlgrthm_8021X
   drivers/staging/rtl8723bs/core/rtw_ap.c:969:48: error: 'struct security_priv' has no member named 'dot11_auth_algrthm'; did you mean 'dot11AuthAlgrthm'?
     969 |                                 psecuritypriv->dot11_auth_algrthm = dot11_auth_algrthm_8021X;
         |                                                ^~~~~~~~~~~~~~~~~~
         |                                                dot11AuthAlgrthm
>> drivers/staging/rtl8723bs/core/rtw_ap.c:1089:53: error: 'ndis802_11ds' undeclared (first use in this function); did you mean 'Ndis802_11DS'?
    1089 |                 pbss_network->network_type_in_use = ndis802_11ds;
         |                                                     ^~~~~~~~~~~~
         |                                                     Ndis802_11DS
>> drivers/staging/rtl8723bs/core/rtw_ap.c:1095:53: error: 'ndis802_11ofdm24' undeclared (first use in this function); did you mean 'Ndis802_11OFDM24'?
    1095 |                 pbss_network->network_type_in_use = ndis802_11ofdm24;
         |                                                     ^~~~~~~~~~~~~~~~
         |                                                     Ndis802_11OFDM24
>> drivers/staging/rtl8723bs/core/rtw_ap.c:1120:17: error: implicit declaration of function 'ht_caps_handler'; did you mean 'HT_caps_handler'? [-Werror=implicit-function-declaration]
    1120 |                 ht_caps_handler(padapter, (struct ndis_80211_var_ie *)pht_caps_ie);
         |                 ^~~~~~~~~~~~~~~
         |                 HT_caps_handler
>> drivers/staging/rtl8723bs/core/rtw_ap.c:1122:17: error: implicit declaration of function 'ht_info_handler'; did you mean 'HT_info_handler'? [-Werror=implicit-function-declaration]
    1122 |                 ht_info_handler(padapter, (struct ndis_80211_var_ie *)pht_info_ie);
         |                 ^~~~~~~~~~~~~~~
         |                 HT_info_handler
   In file included from drivers/staging/rtl8723bs/include/drv_types.h:29,
                    from drivers/staging/rtl8723bs/core/rtw_ap.c:8:
   drivers/staging/rtl8723bs/core/rtw_ap.c: In function 'rtw_ap_set_pairwise_key':
>> drivers/staging/rtl8723bs/core/rtw_ap.c:1273:59: error: '_set_stakey_cmd_' undeclared (first use in this function); did you mean 'set_stakey_hdl'?
    1273 |         init_h2fwcmd_w_parm_no_rsp(ph2c, psetstakey_para, _set_stakey_cmd_);
         |                                                           ^~~~~~~~~~~~~~~~
   drivers/staging/rtl8723bs/include/rtw_cmd.h:76:25: note: in definition of macro 'init_h2fwcmd_w_parm_no_rsp'
      76 |         pcmd->cmdcode = code;\
         |                         ^~~~
>> drivers/staging/rtl8723bs/core/rtw_ap.c:1275:48: error: 'struct sta_info' has no member named 'dot118021_xprivacy'; did you mean 'dot118021XPrivacy'?
    1275 |         psetstakey_para->algorithm = (u8)psta->dot118021_xprivacy;
         |                                                ^~~~~~~~~~~~~~~~~~
         |                                                dot118021XPrivacy
   In file included from include/linux/string.h:253,
                    from arch/x86/include/asm/page_32.h:22,
                    from arch/x86/include/asm/page.h:14,
                    from arch/x86/include/asm/thread_info.h:12,
                    from include/linux/thread_info.h:60,
                    from arch/x86/include/asm/preempt.h:7,
                    from include/linux/preempt.h:78,
                    from include/linux/rcupdate.h:27,
                    from include/linux/rculist.h:11,
                    from include/linux/sched/signal.h:5,
                    from drivers/staging/rtl8723bs/include/drv_types.h:17,
                    from drivers/staging/rtl8723bs/core/rtw_ap.c:8:
>> drivers/staging/rtl8723bs/core/rtw_ap.c:1279:45: error: 'struct sta_info' has no member named 'dot118021x_uncst_key'; did you mean 'dot118021x_UncstKey'?
    1279 |         memcpy(psetstakey_para->key, &psta->dot118021x_uncst_key, 16);
         |                                             ^~~~~~~~~~~~~~~~~~~~
   include/linux/fortify-string.h:376:52: note: in definition of macro '__fortify_memcpy_chk'
     376 |         fortify_memcpy_chk(__fortify_size, p_size, q_size,              \
         |                                                    ^~~~~~
   drivers/staging/rtl8723bs/core/rtw_ap.c:1279:9: note: in expansion of macro 'memcpy'
    1279 |         memcpy(psetstakey_para->key, &psta->dot118021x_uncst_key, 16);
         |         ^~~~~~
>> drivers/staging/rtl8723bs/core/rtw_ap.c:1279:45: error: 'struct sta_info' has no member named 'dot118021x_uncst_key'; did you mean 'dot118021x_UncstKey'?
    1279 |         memcpy(psetstakey_para->key, &psta->dot118021x_uncst_key, 16);
         |                                             ^~~~~~~~~~~~~~~~~~~~
   include/linux/fortify-string.h:377:42: note: in definition of macro '__fortify_memcpy_chk'
     377 |                            p_size_field, q_size_field, #op);            \
         |                                          ^~~~~~~~~~~~
   drivers/staging/rtl8723bs/core/rtw_ap.c:1279:9: note: in expansion of macro 'memcpy'
    1279 |         memcpy(psetstakey_para->key, &psta->dot118021x_uncst_key, 16);
         |         ^~~~~~
>> drivers/staging/rtl8723bs/core/rtw_ap.c:1279:45: error: 'struct sta_info' has no member named 'dot118021x_uncst_key'; did you mean 'dot118021x_UncstKey'?
    1279 |         memcpy(psetstakey_para->key, &psta->dot118021x_uncst_key, 16);
         |                                             ^~~~~~~~~~~~~~~~~~~~
   include/linux/fortify-string.h:378:30: note: in definition of macro '__fortify_memcpy_chk'
     378 |         __underlying_##op(p, q, __fortify_size);                        \
         |                              ^
   drivers/staging/rtl8723bs/core/rtw_ap.c:1279:9: note: in expansion of macro 'memcpy'
    1279 |         memcpy(psetstakey_para->key, &psta->dot118021x_uncst_key, 16);
         |         ^~~~~~
   drivers/staging/rtl8723bs/core/rtw_ap.c: In function 'rtw_ap_set_key':
>> drivers/staging/rtl8723bs/core/rtw_ap.c:1337:25: error: '_setkey_cmd_' undeclared (first use in this function); did you mean '_SetKey_CMD_'?
    1337 |         pcmd->cmdcode = _setkey_cmd_;
         |                         ^~~~~~~~~~~~
         |                         _SetKey_CMD_
   drivers/staging/rtl8723bs/core/rtw_ap.c: In function 'ap_sta_info_defer_update':
>> drivers/staging/rtl8723bs/core/rtw_ap.c:1982:17: error: implicit declaration of function 'add_rat_id'; did you mean 'add_ratid'? [-Werror=implicit-function-declaration]
    1982 |                 add_rat_id(padapter, psta, 0);/* DM_RATR_STA_INIT */
         |                 ^~~~~~~~~~
         |                 add_ratid
   drivers/staging/rtl8723bs/core/rtw_ap.c: In function 'rtw_ap_restore_network':
   drivers/staging/rtl8723bs/core/rtw_ap.c:1998:37: error: 'ndis802_11apmode' undeclared (first use in this function); did you mean 'Ndis802_11APMode'?
    1998 |         rtw_setopmode_cmd(padapter, ndis802_11apmode, false);
         |                                     ^~~~~~~~~~~~~~~~
         |                                     Ndis802_11APMode
   drivers/staging/rtl8723bs/core/rtw_ap.c:2008:37: error: 'struct security_priv' has no member named 'dot11_privacy_algrthm'; did you mean 'dot11PrivacyAlgrthm'?
    2008 |         if ((padapter->securitypriv.dot11_privacy_algrthm == _TKIP_) ||
         |                                     ^~~~~~~~~~~~~~~~~~~~~
         |                                     dot11PrivacyAlgrthm
   drivers/staging/rtl8723bs/core/rtw_ap.c:2009:37: error: 'struct security_priv' has no member named 'dot11_privacy_algrthm'; did you mean 'dot11PrivacyAlgrthm'?
    2009 |             (padapter->securitypriv.dot11_privacy_algrthm == _AES_)) {
         |                                     ^~~~~~~~~~~~~~~~~~~~~
         |                                     dot11PrivacyAlgrthm
   drivers/staging/rtl8723bs/core/rtw_ap.c:2013:44: error: 'struct security_priv' has no member named 'dot118021_xgrp_keyid'; did you mean 'dot118021XGrpKeyid'?
    2013 |                             psecuritypriv->dot118021_xgrp_keyid,
         |                                            ^~~~~~~~~~~~~~~~~~~~
         |                                            dot118021XGrpKeyid
   drivers/staging/rtl8723bs/core/rtw_ap.c:2042:25: error: implicit declaration of function 'update_ra_entry'; did you mean 'Update_RA_Entry'? [-Werror=implicit-function-declaration]
    2042 |                         update_ra_entry(padapter, psta);
         |                         ^~~~~~~~~~~~~~~
         |                         Update_RA_Entry
   drivers/staging/rtl8723bs/core/rtw_ap.c:2045:45: error: 'struct security_priv' has no member named 'dot11_privacy_algrthm'; did you mean 'dot11PrivacyAlgrthm'?
    2045 |                         if ((psecuritypriv->dot11_privacy_algrthm == _TKIP_) ||
         |                                             ^~~~~~~~~~~~~~~~~~~~~
         |                                             dot11PrivacyAlgrthm
   drivers/staging/rtl8723bs/core/rtw_ap.c:2046:45: error: 'struct security_priv' has no member named 'dot11_privacy_algrthm'; did you mean 'dot11PrivacyAlgrthm'?
    2046 |                             (psecuritypriv->dot11_privacy_algrthm == _AES_)) {
         |                                             ^~~~~~~~~~~~~~~~~~~~~
         |                                             dot11PrivacyAlgrthm
   drivers/staging/rtl8723bs/core/rtw_ap.c: In function 'stop_ap_mode':
   drivers/staging/rtl8723bs/core/rtw_ap.c:2121:47: error: 'ndis802_11auth_mode_open' undeclared (first use in this function); did you mean 'Ndis802_11AuthModeOpen'?
    2121 |         padapter->securitypriv.ndisauthtype = ndis802_11auth_mode_open;
         |                                               ^~~~~~~~~~~~~~~~~~~~~~~~
         |                                               Ndis802_11AuthModeOpen
   drivers/staging/rtl8723bs/core/rtw_ap.c:2122:52: error: 'ndis802_11wep_disabled' undeclared (first use in this function); did you mean 'Ndis802_11WEPDisabled'?
    2122 |         padapter->securitypriv.ndisencryptstatus = ndis802_11wep_disabled;
         |                                                    ^~~~~~~~~~~~~~~~~~~~~~
         |                                                    Ndis802_11WEPDisabled
   drivers/staging/rtl8723bs/core/rtw_ap.c:2152:9: error: implicit declaration of function 'rtw_btcoex_media_status_notify'; did you mean 'rtw_btcoex_MediaStatusNotify'? [-Werror=implicit-function-declaration]
    2152 |         rtw_btcoex_media_status_notify(padapter, 0); /* disconnect */
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
         |         rtw_btcoex_MediaStatusNotify
   cc1: some warnings being treated as errors


vim +280 drivers/staging/rtl8723bs/core/rtw_ap.c

   173	
   174	void expire_timeout_chk(struct adapter *padapter)
   175	{
   176		struct list_head *phead, *plist, *tmp;
   177		u8 updated = false;
   178		struct sta_info *psta = NULL;
   179		struct sta_priv *pstapriv = &padapter->stapriv;
   180		u8 chk_alive_num = 0;
   181		char chk_alive_list[NUM_STA];
   182		int i;
   183	
   184		spin_lock_bh(&pstapriv->auth_list_lock);
   185	
   186		phead = &pstapriv->auth_list;
   187		/* check auth_queue */
   188		list_for_each_safe(plist, tmp, phead) {
   189			psta = list_entry(plist, struct sta_info, auth_list);
   190	
   191			if (psta->expire_to > 0) {
   192				psta->expire_to--;
   193				if (psta->expire_to == 0) {
   194					list_del_init(&psta->auth_list);
   195					pstapriv->auth_list_cnt--;
   196	
   197					spin_unlock_bh(&pstapriv->auth_list_lock);
   198	
   199					rtw_free_stainfo(padapter, psta);
   200	
   201					spin_lock_bh(&pstapriv->auth_list_lock);
   202				}
   203			}
   204		}
   205	
   206		spin_unlock_bh(&pstapriv->auth_list_lock);
   207		psta = NULL;
   208	
   209		spin_lock_bh(&pstapriv->asoc_list_lock);
   210	
   211		phead = &pstapriv->asoc_list;
   212		/* check asoc_queue */
   213		list_for_each_safe(plist, tmp, phead) {
   214			psta = list_entry(plist, struct sta_info, asoc_list);
   215			if (chk_sta_is_alive(psta) || !psta->expire_to) {
   216				psta->expire_to = pstapriv->expire_to;
   217				psta->keep_alive_trycnt = 0;
   218				psta->under_exist_checking = 0;
   219			} else {
   220				if (psta->expire_to > 0)
   221					psta->expire_to--;
   222			}
   223	
   224			if (psta->expire_to == 0) {
   225				struct mlme_ext_priv *pmlmeext = &padapter->mlmeextpriv;
   226	
   227				if (padapter->registrypriv.wifi_spec == 1) {
   228					psta->expire_to = pstapriv->expire_to;
   229					continue;
   230				}
   231	
   232				if (psta->state & WIFI_SLEEP_STATE) {
   233					if (!(psta->state & WIFI_STA_ALIVE_CHK_STATE)) {
   234						/* to check if alive by another methods */
   235						/* if station is at ps mode. */
   236						psta->expire_to = pstapriv->expire_to;
   237						psta->state |= WIFI_STA_ALIVE_CHK_STATE;
   238	
   239						/* to update bcn with tim_bitmap for this station */
   240						pstapriv->tim_bitmap |= BIT(psta->aid);
   241						update_beacon(padapter, WLAN_EID_TIM, NULL, true);
   242	
   243						if (!pmlmeext->active_keep_alive_check)
   244							continue;
   245					}
   246				}
   247				if (pmlmeext->active_keep_alive_check) {
   248					int stainfo_offset;
   249	
   250					stainfo_offset = rtw_stainfo_offset(pstapriv, psta);
   251					if (stainfo_offset_valid(stainfo_offset))
   252						chk_alive_list[chk_alive_num++] = stainfo_offset;
   253	
   254					continue;
   255				}
   256				list_del_init(&psta->asoc_list);
   257				pstapriv->asoc_list_cnt--;
   258				updated = ap_free_sta(padapter, psta, false, WLAN_REASON_DEAUTH_LEAVING);
   259			} else {
   260				/* TODO: Aging mechanism to digest frames in sleep_q to */
   261				/* avoid running out of xmitframe */
   262				if (psta->sleepq_len > (NR_XMITFRAME / pstapriv->asoc_list_cnt) &&
   263				    padapter->xmitpriv.free_xmitframe_cnt <
   264							 ((NR_XMITFRAME / pstapriv->asoc_list_cnt
   265					) / 2)
   266				)
   267					wakeup_sta_to_xmit(padapter, psta);
   268			}
   269		}
   270	
   271		spin_unlock_bh(&pstapriv->asoc_list_lock);
   272	
   273		if (chk_alive_num) {
   274			u8 backup_oper_channel = 0;
   275			struct mlme_ext_priv *pmlmeext = &padapter->mlmeextpriv;
   276	
   277			/* switch to correct channel of current network  before issue keep-alive frames */
   278			if (rtw_get_oper_ch(padapter) != pmlmeext->cur_channel) {
   279				backup_oper_channel = rtw_get_oper_ch(padapter);
 > 280				select_channel(padapter, pmlmeext->cur_channel);
   281			}
   282	
   283			/* issue null data to check sta alive*/
   284			for (i = 0; i < chk_alive_num; i++) {
   285				int ret = _FAIL;
   286	
   287				psta = rtw_get_stainfo_by_offset(pstapriv, chk_alive_list[i]);
   288				if (!(psta->state & _FW_LINKED))
   289					continue;
   290	
   291				if (psta->state & WIFI_SLEEP_STATE)
   292					ret = issue_nulldata(padapter, psta->hwaddr, 0, 1, 50);
   293				else
   294					ret = issue_nulldata(padapter, psta->hwaddr, 0, 3, 50);
   295	
   296				psta->keep_alive_trycnt++;
   297				if (ret == _SUCCESS) {
   298					psta->expire_to = pstapriv->expire_to;
   299					psta->keep_alive_trycnt = 0;
   300					continue;
   301				} else if (psta->keep_alive_trycnt <= 3) {
   302					psta->expire_to = 1;
   303					continue;
   304				}
   305	
   306				psta->keep_alive_trycnt = 0;
   307				spin_lock_bh(&pstapriv->asoc_list_lock);
   308				if (list_empty(&psta->asoc_list) == false) {
   309					list_del_init(&psta->asoc_list);
   310					pstapriv->asoc_list_cnt--;
   311					updated = ap_free_sta(padapter, psta, false,
   312							      WLAN_REASON_DEAUTH_LEAVING);
   313				}
   314				spin_unlock_bh(&pstapriv->asoc_list_lock);
   315			}
   316	
   317			if (backup_oper_channel > 0) /* back to the original operation channel */
   318				select_channel(padapter, backup_oper_channel);
   319		}
   320	
   321		associated_clients_update(padapter, updated);
   322	}
   323	
 > 324	void add_ratid(struct adapter *padapter, struct sta_info *psta, u8 rssi_level)
   325	{
   326		unsigned char sta_band = 0, short_gi_rate = false;
   327		unsigned int tx_ra_bitmap = 0;
   328		struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
   329		struct wlan_bssid_ex
   330			*pcur_network = (struct wlan_bssid_ex *)&pmlmepriv->cur_network.network;
   331	
   332		if (!psta)
   333			return;
   334	
   335		if (!(psta->state & _FW_LINKED))
   336			return;
   337	
   338		rtw_hal_update_sta_rate_mask(padapter, psta);
   339		tx_ra_bitmap = psta->ra_mask;
   340	
   341		short_gi_rate = query_ra_short_GI(psta);
   342	
   343		if (pcur_network->configuration.ds_config > 14) {
   344			sta_band |= WIRELESS_INVALID;
   345		} else {
   346			if (tx_ra_bitmap & 0xffff000)
   347				sta_band |= WIRELESS_11_24N;
   348	
   349			if (tx_ra_bitmap & 0xff0)
   350				sta_band |= WIRELESS_11G;
   351	
   352			if (tx_ra_bitmap & 0x0f)
   353				sta_band |= WIRELESS_11B;
   354		}
   355	
   356		psta->wireless_mode = sta_band;
   357		psta->raid = networktype_to_raid_ex(padapter, psta);
   358	
   359		if (psta->aid < NUM_STA) {
   360			u8 arg[4] = {0};
   361	
   362			arg[0] = psta->mac_id;
   363			arg[1] = psta->raid;
   364			arg[2] = short_gi_rate;
   365			arg[3] = psta->init_rate;
   366	
   367			rtw_hal_add_ra_tid(padapter, tx_ra_bitmap, arg, rssi_level);
   368		}
   369	}
   370	
   371	void update_bmc_sta(struct adapter *padapter)
   372	{
   373		unsigned char network_type;
   374		int support_rate_num = 0;
   375		unsigned int tx_ra_bitmap = 0;
   376		struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
   377		struct mlme_ext_priv *pmlmeext = &padapter->mlmeextpriv;
   378		struct mlme_ext_info *pmlmeinfo = &pmlmeext->mlmext_info;
   379		struct wlan_bssid_ex
   380			*pcur_network = (struct wlan_bssid_ex *)&pmlmepriv->cur_network.network;
   381		struct sta_info *psta = rtw_get_bcmc_stainfo(padapter);
   382	
   383		if (psta) {
   384			psta->aid = 0;/* default set to 0 */
   385			/* psta->mac_id = psta->aid+4; */
   386			psta->mac_id = psta->aid + 1;/* mac_id = 1 for bc/mc stainfo */
   387	
   388			pmlmeinfo->FW_sta_info[psta->mac_id].psta = psta;
   389	
   390			psta->qos_option = 0;
   391			psta->htpriv.ht_option = false;
   392	
   393			psta->ieee8021x_blocked = 0;
   394	
   395			memset((void *)&psta->sta_stats, 0, sizeof(struct stainfo_stats));
   396	
   397			/* prepare for add_RATid */
   398			support_rate_num = rtw_get_rateset_len((u8 *)&pcur_network->supported_rates);
   399			network_type = rtw_check_network_type((u8 *)&pcur_network->supported_rates,
   400							      support_rate_num,
   401							      pcur_network->configuration.ds_config
   402			);
   403			if (is_supported_tx_cck(network_type)) {
   404				network_type = WIRELESS_11B;
   405			} else if (network_type == WIRELESS_INVALID) { /*  error handling */
   406	
   407				if (pcur_network->configuration.ds_config > 14)
   408					network_type = WIRELESS_INVALID;
   409				else
   410					network_type = WIRELESS_11B;
   411			}
   412			update_sta_basic_rate(psta, network_type);
   413			psta->wireless_mode = network_type;
   414	
   415			rtw_hal_update_sta_rate_mask(padapter, psta);
   416			tx_ra_bitmap = psta->ra_mask;
   417	
   418			psta->raid = networktype_to_raid_ex(padapter, psta);
   419	
   420			/* ap mode */
   421			rtw_hal_set_odm_var(padapter, HAL_ODM_STA_INFO, psta, true);
   422	
   423			/* if (pHalData->fw_ractrl == true) */
   424			{
   425				u8 arg[4] = {0};
   426	
   427				arg[0] = psta->mac_id;
   428				arg[1] = psta->raid;
   429				arg[2] = 0;
   430				arg[3] = psta->init_rate;
   431	
   432				rtw_hal_add_ra_tid(padapter, tx_ra_bitmap, arg, 0);
   433			}
   434	
   435			rtw_sta_media_status_rpt(padapter, psta, 1);
   436	
   437			spin_lock_bh(&psta->lock);
   438			psta->state = _FW_LINKED;
   439			spin_unlock_bh(&psta->lock);
   440		}
   441	}
   442	
   443	/* notes: */
   444	/* AID: 1~MAX for sta and 0 for bc/mc in ap/adhoc mode */
   445	/* MAC_ID = AID+1 for sta in ap/adhoc mode */
   446	/* MAC_ID = 1 for bc/mc for sta/ap/adhoc */
   447	/* MAC_ID = 0 for bssid for sta/ap/adhoc */
   448	/* CAM_ID = 0~3 for default key, cmd_id =macid + 3, macid =aid+1; */
   449	
   450	void update_sta_info_apmode(struct adapter *padapter, struct sta_info *psta)
   451	{
   452		struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
   453		struct security_priv *psecuritypriv = &padapter->securitypriv;
   454		struct mlme_ext_priv *pmlmeext = &padapter->mlmeextpriv;
   455		struct ht_priv *phtpriv_ap = &pmlmepriv->htpriv;
   456		struct ht_priv *phtpriv_sta = &psta->htpriv;
   457		u8 cur_ldpc_cap = 0, cur_stbc_cap = 0, cur_beamform_cap = 0;
   458		/* set intf_tag to if1 */
   459		/* psta->intf_tag = 0; */
   460	
   461		/* psta->mac_id = psta->aid+4; */
   462		/* psta->mac_id = psta->aid+1;//alloc macid when call rtw_alloc_stainfo(), */
   463		/* release macid when call rtw_free_stainfo() */
   464	
   465		/* ap mode */
   466		rtw_hal_set_odm_var(padapter, HAL_ODM_STA_INFO, psta, true);
   467	
 > 468		if (psecuritypriv->dot11_auth_algrthm == dot11_auth_algrthm_8021X)
   469			psta->ieee8021x_blocked = true;
   470		else
   471			psta->ieee8021x_blocked = false;
   472	
   473		/* update sta's cap */
   474	
   475		/* ERP */
   476		VCS_update(padapter, psta);
   477	
   478		/* HT related cap */
   479		if (phtpriv_sta->ht_option) {
   480			/* check if sta supports rx ampdu */
   481			phtpriv_sta->ampdu_enable = phtpriv_ap->ampdu_enable;
   482	
   483			phtpriv_sta->rx_ampdu_min_spacing =
   484			(phtpriv_sta->ht_cap.ampdu_params_info & IEEE80211_HT_CAP_AMPDU_DENSITY
   485			) >> 2;
   486	
   487			/*  bwmode */
   488			if ((phtpriv_sta->ht_cap.cap_info & phtpriv_ap->ht_cap.cap_info
   489			) & cpu_to_le16(IEEE80211_HT_CAP_SUP_WIDTH))
   490				psta->bw_mode = CHANNEL_WIDTH_40;
   491			else
   492				psta->bw_mode = CHANNEL_WIDTH_20;
   493	
   494			if (pmlmeext->cur_bwmode < psta->bw_mode)
   495				psta->bw_mode = pmlmeext->cur_bwmode;
   496	
   497			phtpriv_sta->ch_offset = pmlmeext->cur_ch_offset;
   498	
   499			/* check if sta support s Short GI 20M */
   500			if ((phtpriv_sta->ht_cap.cap_info & phtpriv_ap->ht_cap.cap_info
   501			) & cpu_to_le16(IEEE80211_HT_CAP_SGI_20))
   502				phtpriv_sta->sgi_20m = true;
   503	
   504			/* check if sta support s Short GI 40M */
   505			if ((phtpriv_sta->ht_cap.cap_info & phtpriv_ap->ht_cap.cap_info
   506			) & cpu_to_le16(IEEE80211_HT_CAP_SGI_40)) {
   507				if (psta->bw_mode == CHANNEL_WIDTH_40) /* according to psta->bw_mode */
   508					phtpriv_sta->sgi_40m = true;
   509				else
   510					phtpriv_sta->sgi_40m = false;
   511			}
   512	
   513			psta->qos_option = true;
   514	
   515			/*  B0 Config LDPC Coding Capability */
   516			if (TEST_FLAG(phtpriv_ap->ldpc_cap, LDPC_HT_ENABLE_TX) &&
   517			    GET_HT_CAPABILITY_ELE_LDPC_CAP((u8 *)(&phtpriv_sta->ht_cap)))
   518				SET_FLAG(cur_ldpc_cap, (LDPC_HT_ENABLE_TX | LDPC_HT_CAP_TX));
   519	
   520			/*  B7 B8 B9 Config STBC setting */
   521			if (TEST_FLAG(phtpriv_ap->stbc_cap, STBC_HT_ENABLE_TX) &&
   522			    GET_HT_CAPABILITY_ELE_RX_STBC((u8 *)(&phtpriv_sta->ht_cap)))
   523				SET_FLAG(cur_stbc_cap, (STBC_HT_ENABLE_TX | STBC_HT_CAP_TX));
   524		} else {
   525			phtpriv_sta->ampdu_enable = false;
   526	
   527			phtpriv_sta->sgi_20m = false;
   528			phtpriv_sta->sgi_40m = false;
   529			psta->bw_mode = CHANNEL_WIDTH_20;
   530			phtpriv_sta->ch_offset = HAL_PRIME_CHNL_OFFSET_DONT_CARE;
   531		}
   532	
   533		phtpriv_sta->ldpc_cap = cur_ldpc_cap;
   534		phtpriv_sta->stbc_cap = cur_stbc_cap;
   535		phtpriv_sta->beamform_cap = cur_beamform_cap;
   536	
   537		/* Rx AMPDU */
   538		send_delba(padapter, 0, psta->hwaddr);/*  recipient */
   539	
   540		/* TX AMPDU */
   541		send_delba(padapter, 1, psta->hwaddr);/* originator */
   542		phtpriv_sta->agg_enable_bitmap = 0x0;/* reset */
   543		phtpriv_sta->candidate_tid_bitmap = 0x0;/* reset */
   544	
   545		update_ldpc_stbc_cap(psta);
   546	
   547		/* todo: init other variables */
   548	
   549		memset((void *)&psta->sta_stats, 0, sizeof(struct stainfo_stats));
   550	
   551		/* add ratid */
   552		/* add_RATid(padapter, psta);//move to ap_sta_info_defer_update() */
   553	
   554		spin_lock_bh(&psta->lock);
   555		psta->state |= _FW_LINKED;
   556		spin_unlock_bh(&psta->lock);
   557	}
   558	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
