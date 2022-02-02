Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEC614A6C69
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 08:44:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239626AbiBBHoP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 02:44:15 -0500
Received: from mga04.intel.com ([192.55.52.120]:36615 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239217AbiBBHoO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 02:44:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643787854; x=1675323854;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=RIa8njm2mFgDerF+1vW9sHj2Bq6WhPH9PzJyI12vbDI=;
  b=h7UhRi4zEjZ6yUkcsf81I984DpminafA8VSECATNa1ooBMkGTXEzeHcA
   U/SHLFJY9NizBG6HkXe4r+t9D1yuYgkwFFMTO06R8r1PN5ngJpFwvFtkt
   5mFhvXKrqkhle2X9vVseSkoBdkhs0UuAV8Mj19EzaG98xVm2CVZcn2T9I
   mNLK8N0Eh9YyeygUaB288ArFTg6gEmYP/jl5gPxNjr48sKrMtUsOa9nEa
   cWT15vq2Z1i6N/KmOAdCcYjF3ddFtbRcx3UwfBp+WjL2FOYznBc8l8PB7
   luFncZDiDr8c485lnpyFnZf+IcqOu/0F1lM7N6Y8lLhmsYbuccBXaD13q
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10245"; a="246689250"
X-IronPort-AV: E=Sophos;i="5.88,336,1635231600"; 
   d="scan'208";a="246689250"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2022 22:22:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,336,1635231600"; 
   d="scan'208";a="583317767"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 01 Feb 2022 22:22:41 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nF92O-000UDa-Ie; Wed, 02 Feb 2022 06:22:40 +0000
Date:   Wed, 2 Feb 2022 14:22:24 +0800
From:   kernel test robot <lkp@intel.com>
To:     Johannes Berg <johannes.berg@intel.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Luca Coelho <luciano.coelho@intel.com>
Subject: [iwlwifi-next:pending 40/42] net/mac80211/agg-rx.c:505:15: error: no
 member named 'eht_cap' in 'struct ieee80211_sta'; did you mean 'he_cap'?
Message-ID: <202202021412.zzbjX8rs-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/iwlwifi/iwlwifi-next.git pending
head:   b15caa03d4e21e9e8dbc81f6ac09171a2871af1d
commit: 7c8b580893d9c8858b60fec31cb5b55336667ac1 [40/42] mac80211: fix NULL-ptr-deref in ADDBA extended element
config: arm-multi_v5_defconfig (https://download.01.org/0day-ci/archive/20220202/202202021412.zzbjX8rs-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project 6b1e844b69f15bb7dffaf9365cd2b355d2eb7579)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm cross compiling tool for clang build
        # apt-get install binutils-arm-linux-gnueabi
        # https://git.kernel.org/pub/scm/linux/kernel/git/iwlwifi/iwlwifi-next.git/commit/?id=7c8b580893d9c8858b60fec31cb5b55336667ac1
        git remote add iwlwifi-next https://git.kernel.org/pub/scm/linux/kernel/git/iwlwifi/iwlwifi-next.git
        git fetch --no-tags iwlwifi-next pending
        git checkout 7c8b580893d9c8858b60fec31cb5b55336667ac1
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> net/mac80211/agg-rx.c:505:15: error: no member named 'eht_cap' in 'struct ieee80211_sta'; did you mean 'he_cap'?
           if (sta->sta.eht_cap.has_eht && elems && elems->addba_ext_ie) {
                        ^~~~~~~
                        he_cap
   include/net/mac80211.h:2099:30: note: 'he_cap' declared here
           struct ieee80211_sta_he_cap he_cap;
                                       ^
>> net/mac80211/agg-rx.c:505:23: error: no member named 'has_eht' in 'struct ieee80211_sta_he_cap'; did you mean 'has_he'?
           if (sta->sta.eht_cap.has_eht && elems && elems->addba_ext_ie) {
                                ^~~~~~~
                                has_he
   include/net/cfg80211.h:357:7: note: 'has_he' declared here
           bool has_he;
                ^
>> net/mac80211/agg-rx.c:507:11: error: use of undeclared identifier 'IEEE80211_ADDBA_EXT_BUF_SIZE_MASK'
                                                IEEE80211_ADDBA_EXT_BUF_SIZE_MASK);
                                                ^
>> net/mac80211/agg-rx.c:509:30: error: use of undeclared identifier 'IEEE80211_ADDBA_EXT_BUF_SIZE_SHIFT'
                   buf_size |= buf_size_1k << IEEE80211_ADDBA_EXT_BUF_SIZE_SHIFT;
                                              ^
   4 errors generated.


vim +505 net/mac80211/agg-rx.c

   474	
   475	void ieee80211_process_addba_request(struct ieee80211_local *local,
   476					     struct sta_info *sta,
   477					     struct ieee80211_mgmt *mgmt,
   478					     size_t len)
   479	{
   480		u16 capab, tid, timeout, ba_policy, buf_size, start_seq_num;
   481		struct ieee802_11_elems *elems = NULL;
   482		u8 dialog_token;
   483		int ies_len;
   484	
   485		/* extract session parameters from addba request frame */
   486		dialog_token = mgmt->u.action.u.addba_req.dialog_token;
   487		timeout = le16_to_cpu(mgmt->u.action.u.addba_req.timeout);
   488		start_seq_num =
   489			le16_to_cpu(mgmt->u.action.u.addba_req.start_seq_num) >> 4;
   490	
   491		capab = le16_to_cpu(mgmt->u.action.u.addba_req.capab);
   492		ba_policy = (capab & IEEE80211_ADDBA_PARAM_POLICY_MASK) >> 1;
   493		tid = (capab & IEEE80211_ADDBA_PARAM_TID_MASK) >> 2;
   494		buf_size = (capab & IEEE80211_ADDBA_PARAM_BUF_SIZE_MASK) >> 6;
   495	
   496		ies_len = len - offsetof(struct ieee80211_mgmt,
   497					 u.action.u.addba_req.variable);
   498		if (ies_len) {
   499			elems = ieee802_11_parse_elems(mgmt->u.action.u.addba_req.variable,
   500						       ies_len, true, mgmt->bssid, NULL);
   501			if (!elems || elems->parse_error)
   502				goto free;
   503		}
   504	
 > 505		if (sta->sta.eht_cap.has_eht && elems && elems->addba_ext_ie) {
   506			u8 buf_size_1k = u8_get_bits(elems->addba_ext_ie->data,
 > 507						     IEEE80211_ADDBA_EXT_BUF_SIZE_MASK);
   508	
 > 509			buf_size |= buf_size_1k << IEEE80211_ADDBA_EXT_BUF_SIZE_SHIFT;
   510		}
   511	
   512		__ieee80211_start_rx_ba_session(sta, dialog_token, timeout,
   513						start_seq_num, ba_policy, tid,
   514						buf_size, true, false,
   515						elems ? elems->addba_ext_ie : NULL);
   516	free:
   517		kfree(elems);
   518	}
   519	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
