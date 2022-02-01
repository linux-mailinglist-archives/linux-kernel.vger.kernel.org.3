Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA8EE4A6760
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 22:54:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235481AbiBAVyO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 16:54:14 -0500
Received: from mga17.intel.com ([192.55.52.151]:60954 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235804AbiBAVyN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 16:54:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643752453; x=1675288453;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=g3HuC/825ly1scS+giALZEgJq+wpKotE5+YV5VwCumM=;
  b=SJ7sMlPb13bk0nb5sCTQ5mftOs1UsrzoH+EuiOmJxcEm+NA7L/l3E9To
   MHUSnVlmFs74uiz9Wohmj5ugl6b6MTUyk2iyAc8yEa1976zz9hjwJQQom
   sw7wksEouysz9xNODJBG/e3ghGWYolwZw9wblcHbDedt2YK1eXblgPnUK
   l3Dovg2q0X42SHwBtVcRmXXRMlOrACMh9rY+uhIcHGnlnRQ4wXaKxuKdi
   1z67FnOF8GQzwjfP+KhHuurSZwAAUEdQgaNJooV/Esm2YnUr8jlwlBZBB
   LSZ6eN3IoL6oo1l18TKA8Mp8hASMrlCE6IJtJyL4xkLFTYcAICwgaoQWB
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10245"; a="228460160"
X-IronPort-AV: E=Sophos;i="5.88,335,1635231600"; 
   d="scan'208";a="228460160"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2022 13:54:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,335,1635231600"; 
   d="scan'208";a="619953319"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 01 Feb 2022 13:54:11 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nF16J-000TkO-A3; Tue, 01 Feb 2022 21:54:11 +0000
Date:   Wed, 2 Feb 2022 05:53:28 +0800
From:   kernel test robot <lkp@intel.com>
To:     Johannes Berg <johannes.berg@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Luca Coelho <luciano.coelho@intel.com>
Subject: [iwlwifi-next:pending 40/42] net/mac80211/agg-rx.c:505:22: error:
 'struct ieee80211_sta' has no member named 'eht_cap'; did you mean 'ht_cap'?
Message-ID: <202202020537.3IFRQCXk-lkp@intel.com>
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
config: nds32-buildonly-randconfig-r002-20220201 (https://download.01.org/0day-ci/archive/20220202/202202020537.3IFRQCXk-lkp@intel.com/config)
compiler: nds32le-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/iwlwifi/iwlwifi-next.git/commit/?id=7c8b580893d9c8858b60fec31cb5b55336667ac1
        git remote add iwlwifi-next https://git.kernel.org/pub/scm/linux/kernel/git/iwlwifi/iwlwifi-next.git
        git fetch --no-tags iwlwifi-next pending
        git checkout 7c8b580893d9c8858b60fec31cb5b55336667ac1
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=nds32 SHELL=/bin/bash net/mac80211/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   net/mac80211/agg-rx.c: In function 'ieee80211_process_addba_request':
>> net/mac80211/agg-rx.c:505:22: error: 'struct ieee80211_sta' has no member named 'eht_cap'; did you mean 'ht_cap'?
     505 |         if (sta->sta.eht_cap.has_eht && elems && elems->addba_ext_ie) {
         |                      ^~~~~~~
         |                      ht_cap
>> net/mac80211/agg-rx.c:507:46: error: 'IEEE80211_ADDBA_EXT_BUF_SIZE_MASK' undeclared (first use in this function); did you mean 'IEEE80211_ADDBA_PARAM_BUF_SIZE_MASK'?
     507 |                                              IEEE80211_ADDBA_EXT_BUF_SIZE_MASK);
         |                                              ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
         |                                              IEEE80211_ADDBA_PARAM_BUF_SIZE_MASK
   net/mac80211/agg-rx.c:507:46: note: each undeclared identifier is reported only once for each function it appears in
>> net/mac80211/agg-rx.c:509:44: error: 'IEEE80211_ADDBA_EXT_BUF_SIZE_SHIFT' undeclared (first use in this function); did you mean 'IEEE80211_ADDBA_EXT_FRAG_LEVEL_SHIFT'?
     509 |                 buf_size |= buf_size_1k << IEEE80211_ADDBA_EXT_BUF_SIZE_SHIFT;
         |                                            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
         |                                            IEEE80211_ADDBA_EXT_FRAG_LEVEL_SHIFT


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
