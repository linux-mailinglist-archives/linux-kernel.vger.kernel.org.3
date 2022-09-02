Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BDCE5AA47E
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 02:36:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232390AbiIBAgP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 20:36:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229839AbiIBAgM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 20:36:12 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23D7B564D9
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 17:36:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662078971; x=1693614971;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=tectJUvngPqB0r7zPtOAwr1pT8QaXGhQmBBhQQmd3HQ=;
  b=JYndgoyeels+bW3wUXhN1+Sl4uh0T7wN6EfXy+6hy/EgcLISKBFyJjMX
   5wrJlbezoLIC99YQtO7bXP5TjwU6u1fpgz14/upAMfa88v0rmwxgWzyic
   T9+sXjynT5t45WJtSpdRCVH1JSaGPT0MFCpJWwmlVzlLyWigWxeKKKPeY
   SEATU8e7LaJZpXMRfkURJZaGX4p3NGNKKuHNqWUXnq/arH97bva9tnen3
   3Ui1NSxnG0eaeizQcujL9eE/nW8BV2CEv6rf+QqW4r2wdDntbu5BHzoWi
   jR7S2pZe1I8mPpJOVnuP/eIY29cAt1vJEiIFjDFZqBKN+VcXeo5W3O4Cd
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10457"; a="296644517"
X-IronPort-AV: E=Sophos;i="5.93,281,1654585200"; 
   d="scan'208";a="296644517"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2022 17:36:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,281,1654585200"; 
   d="scan'208";a="563722151"
Received: from lkp-server02.sh.intel.com (HELO b138c9e8658c) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 01 Sep 2022 17:36:08 -0700
Received: from kbuild by b138c9e8658c with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oTufH-0000wR-1H;
        Fri, 02 Sep 2022 00:36:07 +0000
Date:   Fri, 2 Sep 2022 08:35:51 +0800
From:   kernel test robot <lkp@intel.com>
To:     Johannes Berg <johannes.berg@intel.com>
Cc:     kbuild-all@lists.01.org, Ammar Faizi <ammarfaizi2@gnuweeb.org>,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org
Subject: [ammarfaizi2-block:wireless/wireless-next/mld-wip 15/20]
 net/mac80211/link.c:398:51: error: 'BSS_CHANGED_EHT_PUNCTURING' undeclared
Message-ID: <202209020842.MRD1g4vr-lkp@intel.com>
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
commit: 43af0cd81d9314a71d9824514efd1f4c6fa3b437 [15/20] wifi: mac80211: implement link switching
config: i386-randconfig-a005 (https://download.01.org/0day-ci/archive/20220902/202209020842.MRD1g4vr-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-5) 11.3.0
reproduce (this is a W=1 build):
        # https://github.com/ammarfaizi2/linux-block/commit/43af0cd81d9314a71d9824514efd1f4c6fa3b437
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block wireless/wireless-next/mld-wip
        git checkout 43af0cd81d9314a71d9824514efd1f4c6fa3b437
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash drivers/net/wireless/ath/ath9k/ net/mac80211/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   net/mac80211/link.c: In function '_ieee80211_set_active_links':
>> net/mac80211/link.c:398:51: error: 'BSS_CHANGED_EHT_PUNCTURING' undeclared (first use in this function)
     398 |                                                   BSS_CHANGED_EHT_PUNCTURING);
         |                                                   ^~~~~~~~~~~~~~~~~~~~~~~~~~
   net/mac80211/link.c:398:51: note: each undeclared identifier is reported only once for each function it appears in


vim +/BSS_CHANGED_EHT_PUNCTURING +398 net/mac80211/link.c

   304	
   305	static int _ieee80211_set_active_links(struct ieee80211_sub_if_data *sdata,
   306					       u16 active_links)
   307	{
   308		struct ieee80211_bss_conf *link_confs[IEEE80211_MLD_MAX_NUM_LINKS];
   309		struct ieee80211_local *local = sdata->local;
   310		u16 old_active = sdata->vif.active_links;
   311		unsigned long rem = old_active & ~active_links;
   312		unsigned long add = active_links & ~old_active;
   313		struct sta_info *sta;
   314		unsigned int link_id;
   315		int ret, i;
   316	
   317		if (sdata->vif.type != NL80211_IFTYPE_STATION)
   318			return -EINVAL;
   319	
   320		/* cannot activate links that don't exist */
   321		if (active_links & ~sdata->vif.valid_links)
   322			return -EINVAL;
   323	
   324		/* nothing to do */
   325		if (old_active == active_links)
   326			return 0;
   327	
   328		for (i = 0; i < IEEE80211_MLD_MAX_NUM_LINKS; i++)
   329			link_confs[i] = sdata_dereference(sdata->vif.link_conf[i],
   330							  sdata);
   331	
   332		if (add) {
   333			sdata->vif.active_links |= active_links;
   334			ret = drv_change_vif_links(local, sdata,
   335						   old_active,
   336						   sdata->vif.active_links,
   337						   link_confs);
   338			if (ret) {
   339				sdata->vif.active_links = old_active;
   340				return ret;
   341			}
   342		}
   343	
   344		for_each_set_bit(link_id, &rem, IEEE80211_MLD_MAX_NUM_LINKS) {
   345			struct ieee80211_link_data *link;
   346	
   347			link = sdata_dereference(sdata->link[link_id], sdata);
   348	
   349			/* FIXME: kill TDLS connections on the link */
   350	
   351			ieee80211_link_release_channel(link);
   352		}
   353	
   354		list_for_each_entry(sta, &local->sta_list, list) {
   355			if (sdata != sta->sdata)
   356				continue;
   357			ret = drv_change_sta_links(local, sdata, &sta->sta,
   358						   old_active,
   359						   old_active | active_links);
   360			WARN_ON(ret); // FIXME //
   361		}
   362	
   363		ret = ieee80211_key_switch_links(sdata, rem, add);
   364		WARN_ON(ret); // FIXME //
   365	
   366		list_for_each_entry(sta, &local->sta_list, list) {
   367			if (sdata != sta->sdata)
   368				continue;
   369			ret = drv_change_sta_links(local, sdata, &sta->sta,
   370						   old_active | active_links,
   371						   active_links);
   372			WARN_ON(ret); // FIXME //
   373		}
   374	
   375		for_each_set_bit(link_id, &add, IEEE80211_MLD_MAX_NUM_LINKS) {
   376			struct ieee80211_link_data *link;
   377	
   378			link = sdata_dereference(sdata->link[link_id], sdata);
   379	
   380			ret = ieee80211_link_use_channel(link, &link->conf->chandef,
   381							 IEEE80211_CHANCTX_SHARED);
   382			WARN_ON(ret); // FIXME //
   383	
   384			ieee80211_link_info_change_notify(sdata, link,
   385							  BSS_CHANGED_ERP_CTS_PROT |
   386							  BSS_CHANGED_ERP_PREAMBLE |
   387							  BSS_CHANGED_ERP_SLOT |
   388							  BSS_CHANGED_HT |
   389							  BSS_CHANGED_BASIC_RATES |
   390							  BSS_CHANGED_BSSID |
   391							  BSS_CHANGED_CQM |
   392							  BSS_CHANGED_QOS |
   393							  BSS_CHANGED_TXPOWER |
   394							  BSS_CHANGED_BANDWIDTH |
   395							  BSS_CHANGED_TWT |
   396							  BSS_CHANGED_HE_OBSS_PD |
   397							  BSS_CHANGED_HE_BSS_COLOR |
 > 398							  BSS_CHANGED_EHT_PUNCTURING);
   399			ieee80211_mgd_set_link_qos_params(link);
   400		}
   401	
   402		old_active = sdata->vif.active_links;
   403		sdata->vif.active_links = active_links;
   404	
   405		if (rem) {
   406			ret = drv_change_vif_links(local, sdata, old_active,
   407						   active_links, link_confs);
   408			WARN_ON(ret); // FIXME //
   409		}
   410	
   411		return 0;
   412	}
   413	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
