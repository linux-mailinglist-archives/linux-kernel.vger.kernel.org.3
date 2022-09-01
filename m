Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93DB85A9764
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 14:51:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231764AbiIAMul (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 08:50:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232604AbiIAMug (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 08:50:36 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 652AF3ECD6
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 05:50:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662036633; x=1693572633;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=DlIMpYko/Y2Es4sT+Pe1aXFnnl85LOJ8PPDtIU9pU9M=;
  b=hqmu9MHrjCD6OJAUGoxAiZ1+LBtXf16DUHuyCX/X2LfVAeQrIayis1o0
   Jhc0+JjaESCdYvKtX4xhp4WgoKnQZX0HJvNUDaS54ndelrFOpuSAEuiiI
   lTIZXJe6mXnQtFf0CPn+6rDqiRsz/4GuRxVrJz+dN0j/39Zm9U0u/7rri
   /Dtp49MJ/YU/oq97yXGDfkZPEqvQL/6kuesCG4l8PvbQ7y1W1GRzkzQ1U
   sMJBnCQZbzvPQIUfNJhGIhqe41GSU2BQxqt6on6UJGhjfGIfr92SYFk1i
   MUBFxOyqgRFUSTmHRWVtphHINE+Bkj3H+VRgnzp905DkVu1GIjB8ODOXz
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10457"; a="296488953"
X-IronPort-AV: E=Sophos;i="5.93,280,1654585200"; 
   d="scan'208";a="296488953"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2022 05:50:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,280,1654585200"; 
   d="scan'208";a="754809905"
Received: from lkp-server02.sh.intel.com (HELO b138c9e8658c) ([10.239.97.151])
  by fmsmga001.fm.intel.com with ESMTP; 01 Sep 2022 05:50:30 -0700
Received: from kbuild by b138c9e8658c with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oTjeP-0000Ih-2T;
        Thu, 01 Sep 2022 12:50:29 +0000
Date:   Thu, 1 Sep 2022 20:49:48 +0800
From:   kernel test robot <lkp@intel.com>
To:     Johannes Berg <johannes.berg@intel.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        Ammar Faizi <ammarfaizi2@gnuweeb.org>,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org
Subject: [ammarfaizi2-block:wireless/wireless-next/mld-wip 16/20]
 drivers/net/wireless/st/cw1200/sta.c:198:58: error: too few arguments to
 function call, expected 4, have 3
Message-ID: <202209012046.5sg4d0qh-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ammarfaizi2/linux-block wireless/wireless-next/mld-wip
head:   10cf17b0508f56ee45e15ad2a612b64999264d4f
commit: 60286c25de214ab636d7af34c4c05db0023fd827 [16/20] wifi: mac80211: extend ieee80211_nullfunc_get() for MLO
config: x86_64-randconfig-a003 (https://download.01.org/0day-ci/archive/20220901/202209012046.5sg4d0qh-lkp@intel.com/config)
compiler: clang version 14.0.6 (https://github.com/llvm/llvm-project f28c006a5895fc0e329fe15fead81e37457cb1d1)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/ammarfaizi2/linux-block/commit/60286c25de214ab636d7af34c4c05db0023fd827
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block wireless/wireless-next/mld-wip
        git checkout 60286c25de214ab636d7af34c4c05db0023fd827
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash drivers/net/wireless/st/cw1200/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> drivers/net/wireless/st/cw1200/sta.c:198:58: error: too few arguments to function call, expected 4, have 3
                   skb = ieee80211_nullfunc_get(priv->hw, priv->vif, false);
                         ~~~~~~~~~~~~~~~~~~~~~~                           ^
   include/net/mac80211.h:5319:17: note: 'ieee80211_nullfunc_get' declared here
   struct sk_buff *ieee80211_nullfunc_get(struct ieee80211_hw *hw,
                   ^
   drivers/net/wireless/st/cw1200/sta.c:2266:63: error: too few arguments to function call, expected 4, have 3
           frame.skb = ieee80211_nullfunc_get(priv->hw, priv->vif, false);
                       ~~~~~~~~~~~~~~~~~~~~~~                           ^
   include/net/mac80211.h:5319:17: note: 'ieee80211_nullfunc_get' declared here
   struct sk_buff *ieee80211_nullfunc_get(struct ieee80211_hw *hw,
                   ^
   2 errors generated.


vim +198 drivers/net/wireless/st/cw1200/sta.c

a910e4a94f6923c drivers/net/wireless/cw1200/sta.c    Solomon Peachy 2013-05-24  146  
a910e4a94f6923c drivers/net/wireless/cw1200/sta.c    Solomon Peachy 2013-05-24  147  
a910e4a94f6923c drivers/net/wireless/cw1200/sta.c    Solomon Peachy 2013-05-24  148  void __cw1200_cqm_bssloss_sm(struct cw1200_common *priv,
a910e4a94f6923c drivers/net/wireless/cw1200/sta.c    Solomon Peachy 2013-05-24  149  			     int init, int good, int bad)
a910e4a94f6923c drivers/net/wireless/cw1200/sta.c    Solomon Peachy 2013-05-24  150  {
a910e4a94f6923c drivers/net/wireless/cw1200/sta.c    Solomon Peachy 2013-05-24  151  	int tx = 0;
a910e4a94f6923c drivers/net/wireless/cw1200/sta.c    Solomon Peachy 2013-05-24  152  
a910e4a94f6923c drivers/net/wireless/cw1200/sta.c    Solomon Peachy 2013-05-24  153  	priv->delayed_link_loss = 0;
a910e4a94f6923c drivers/net/wireless/cw1200/sta.c    Solomon Peachy 2013-05-24  154  	cancel_work_sync(&priv->bss_params_work);
a910e4a94f6923c drivers/net/wireless/cw1200/sta.c    Solomon Peachy 2013-05-24  155  
a910e4a94f6923c drivers/net/wireless/cw1200/sta.c    Solomon Peachy 2013-05-24  156  	pr_debug("[STA] CQM BSSLOSS_SM: state: %d init %d good %d bad: %d txlock: %d uj: %d\n",
a910e4a94f6923c drivers/net/wireless/cw1200/sta.c    Solomon Peachy 2013-05-24  157  		 priv->bss_loss_state,
a910e4a94f6923c drivers/net/wireless/cw1200/sta.c    Solomon Peachy 2013-05-24  158  		 init, good, bad,
a910e4a94f6923c drivers/net/wireless/cw1200/sta.c    Solomon Peachy 2013-05-24  159  		 atomic_read(&priv->tx_lock),
a910e4a94f6923c drivers/net/wireless/cw1200/sta.c    Solomon Peachy 2013-05-24  160  		 priv->delayed_unjoin);
a910e4a94f6923c drivers/net/wireless/cw1200/sta.c    Solomon Peachy 2013-05-24  161  
a910e4a94f6923c drivers/net/wireless/cw1200/sta.c    Solomon Peachy 2013-05-24  162  	/* If we have a pending unjoin */
a910e4a94f6923c drivers/net/wireless/cw1200/sta.c    Solomon Peachy 2013-05-24  163  	if (priv->delayed_unjoin)
a910e4a94f6923c drivers/net/wireless/cw1200/sta.c    Solomon Peachy 2013-05-24  164  		return;
a910e4a94f6923c drivers/net/wireless/cw1200/sta.c    Solomon Peachy 2013-05-24  165  
a910e4a94f6923c drivers/net/wireless/cw1200/sta.c    Solomon Peachy 2013-05-24  166  	if (init) {
a910e4a94f6923c drivers/net/wireless/cw1200/sta.c    Solomon Peachy 2013-05-24  167  		queue_delayed_work(priv->workqueue,
a910e4a94f6923c drivers/net/wireless/cw1200/sta.c    Solomon Peachy 2013-05-24  168  				   &priv->bss_loss_work,
a910e4a94f6923c drivers/net/wireless/cw1200/sta.c    Solomon Peachy 2013-05-24  169  				   HZ);
a910e4a94f6923c drivers/net/wireless/cw1200/sta.c    Solomon Peachy 2013-05-24  170  		priv->bss_loss_state = 0;
a910e4a94f6923c drivers/net/wireless/cw1200/sta.c    Solomon Peachy 2013-05-24  171  
a910e4a94f6923c drivers/net/wireless/cw1200/sta.c    Solomon Peachy 2013-05-24  172  		/* Skip the confimration procedure in P2P case */
a910e4a94f6923c drivers/net/wireless/cw1200/sta.c    Solomon Peachy 2013-05-24  173  		if (!priv->vif->p2p && !atomic_read(&priv->tx_lock))
a910e4a94f6923c drivers/net/wireless/cw1200/sta.c    Solomon Peachy 2013-05-24  174  			tx = 1;
a910e4a94f6923c drivers/net/wireless/cw1200/sta.c    Solomon Peachy 2013-05-24  175  	} else if (good) {
a910e4a94f6923c drivers/net/wireless/cw1200/sta.c    Solomon Peachy 2013-05-24  176  		cancel_delayed_work_sync(&priv->bss_loss_work);
a910e4a94f6923c drivers/net/wireless/cw1200/sta.c    Solomon Peachy 2013-05-24  177  		priv->bss_loss_state = 0;
a910e4a94f6923c drivers/net/wireless/cw1200/sta.c    Solomon Peachy 2013-05-24  178  		queue_work(priv->workqueue, &priv->bss_params_work);
a910e4a94f6923c drivers/net/wireless/cw1200/sta.c    Solomon Peachy 2013-05-24  179  	} else if (bad) {
a910e4a94f6923c drivers/net/wireless/cw1200/sta.c    Solomon Peachy 2013-05-24  180  		/* XXX Should we just keep going until we time out? */
a910e4a94f6923c drivers/net/wireless/cw1200/sta.c    Solomon Peachy 2013-05-24  181  		if (priv->bss_loss_state < 3)
a910e4a94f6923c drivers/net/wireless/cw1200/sta.c    Solomon Peachy 2013-05-24  182  			tx = 1;
a910e4a94f6923c drivers/net/wireless/cw1200/sta.c    Solomon Peachy 2013-05-24  183  	} else {
a910e4a94f6923c drivers/net/wireless/cw1200/sta.c    Solomon Peachy 2013-05-24  184  		cancel_delayed_work_sync(&priv->bss_loss_work);
a910e4a94f6923c drivers/net/wireless/cw1200/sta.c    Solomon Peachy 2013-05-24  185  		priv->bss_loss_state = 0;
a910e4a94f6923c drivers/net/wireless/cw1200/sta.c    Solomon Peachy 2013-05-24  186  	}
a910e4a94f6923c drivers/net/wireless/cw1200/sta.c    Solomon Peachy 2013-05-24  187  
a910e4a94f6923c drivers/net/wireless/cw1200/sta.c    Solomon Peachy 2013-05-24  188  	/* Bypass mitigation if it's disabled */
a910e4a94f6923c drivers/net/wireless/cw1200/sta.c    Solomon Peachy 2013-05-24  189  	if (!cw1200_bssloss_mitigation)
a910e4a94f6923c drivers/net/wireless/cw1200/sta.c    Solomon Peachy 2013-05-24  190  		tx = 0;
a910e4a94f6923c drivers/net/wireless/cw1200/sta.c    Solomon Peachy 2013-05-24  191  
a910e4a94f6923c drivers/net/wireless/cw1200/sta.c    Solomon Peachy 2013-05-24  192  	/* Spit out a NULL packet to our AP if necessary */
a910e4a94f6923c drivers/net/wireless/cw1200/sta.c    Solomon Peachy 2013-05-24  193  	if (tx) {
a910e4a94f6923c drivers/net/wireless/cw1200/sta.c    Solomon Peachy 2013-05-24  194  		struct sk_buff *skb;
a910e4a94f6923c drivers/net/wireless/cw1200/sta.c    Solomon Peachy 2013-05-24  195  
a910e4a94f6923c drivers/net/wireless/cw1200/sta.c    Solomon Peachy 2013-05-24  196  		priv->bss_loss_state++;
a910e4a94f6923c drivers/net/wireless/cw1200/sta.c    Solomon Peachy 2013-05-24  197  
7b6ddeaf27eca72 drivers/net/wireless/st/cw1200/sta.c Johannes Berg  2017-11-21 @198  		skb = ieee80211_nullfunc_get(priv->hw, priv->vif, false);
a910e4a94f6923c drivers/net/wireless/cw1200/sta.c    Solomon Peachy 2013-05-24  199  		WARN_ON(!skb);
a910e4a94f6923c drivers/net/wireless/cw1200/sta.c    Solomon Peachy 2013-05-24  200  		if (skb)
a910e4a94f6923c drivers/net/wireless/cw1200/sta.c    Solomon Peachy 2013-05-24  201  			cw1200_tx(priv->hw, NULL, skb);
a910e4a94f6923c drivers/net/wireless/cw1200/sta.c    Solomon Peachy 2013-05-24  202  	}
a910e4a94f6923c drivers/net/wireless/cw1200/sta.c    Solomon Peachy 2013-05-24  203  }
a910e4a94f6923c drivers/net/wireless/cw1200/sta.c    Solomon Peachy 2013-05-24  204  

:::::: The code at line 198 was first introduced by commit
:::::: 7b6ddeaf27eca72795ceeae2f0f347db1b5f9a30 mac80211: use QoS NDP for AP probing

:::::: TO: Johannes Berg <johannes.berg@intel.com>
:::::: CC: Johannes Berg <johannes.berg@intel.com>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
