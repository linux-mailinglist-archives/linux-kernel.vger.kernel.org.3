Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4C4C5A958B
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 13:16:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234181AbiIALQc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 07:16:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234032AbiIALQ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 07:16:28 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9773D12CB13
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 04:16:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662030985; x=1693566985;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=zaww39FN+CW4WASt8lPnfsdxpWqwlbXitSMeNCTBWWA=;
  b=XyWWgbdrF1lf561YDx17ia3YDcEDU9XrWRz1U0+G9dhmjjoS2o+DjlAA
   53QBcqHEuUKiGttt7x+TLXgyRPFMQtCo9+Yw/6a5FAC8yC/7QWgVo3zYo
   gn3J/jP1BPKTvIGj1OZZD8TJ3vqdM2G6BaA+I7WLTsTHfmBknRTLKfPN5
   C06uKb20jGEhjZ14mIp31JJIWFigOdZiNfLJHeeatwAVW8e5buKYKPW3l
   LI0UQBpQDaMtHnHA0NCUhDRJ+1dT0P4KTiNCB4OEEV/b4Oe6o8yN227Eq
   FaxjXPRwwXWg04alMoWhHIAT2527bhXQEIjh8KhAHvSHxDPf5CGLKH4sX
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10456"; a="295694726"
X-IronPort-AV: E=Sophos;i="5.93,280,1654585200"; 
   d="scan'208";a="295694726"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2022 04:16:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,280,1654585200"; 
   d="scan'208";a="680812136"
Received: from lkp-server02.sh.intel.com (HELO b138c9e8658c) ([10.239.97.151])
  by fmsmga004.fm.intel.com with ESMTP; 01 Sep 2022 04:16:23 -0700
Received: from kbuild by b138c9e8658c with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oTiBL-0000DH-0P;
        Thu, 01 Sep 2022 11:16:23 +0000
Date:   Thu, 1 Sep 2022 19:16:18 +0800
From:   kernel test robot <lkp@intel.com>
To:     Johannes Berg <johannes.berg@intel.com>
Cc:     kbuild-all@lists.01.org, Ammar Faizi <ammarfaizi2@gnuweeb.org>,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org
Subject: [ammarfaizi2-block:wireless/wireless-next/mld-wip 16/20]
 drivers/net/wireless/realtek/rtw88/fw.c:1085:27: error: too few arguments to
 function 'ieee80211_nullfunc_get'
Message-ID: <202209011952.4tMld57n-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ammarfaizi2/linux-block wireless/wireless-next/mld-wip
head:   10cf17b0508f56ee45e15ad2a612b64999264d4f
commit: 60286c25de214ab636d7af34c4c05db0023fd827 [16/20] wifi: mac80211: extend ieee80211_nullfunc_get() for MLO
config: arm-randconfig-r015-20220901 (https://download.01.org/0day-ci/archive/20220901/202209011952.4tMld57n-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/ammarfaizi2/linux-block/commit/60286c25de214ab636d7af34c4c05db0023fd827
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block wireless/wireless-next/mld-wip
        git checkout 60286c25de214ab636d7af34c4c05db0023fd827
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash drivers/net/wireless/realtek/rtw88/ drivers/net/wireless/st/cw1200/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   drivers/net/wireless/realtek/rtw88/fw.c: In function 'rtw_get_rsvd_page_skb':
>> drivers/net/wireless/realtek/rtw88/fw.c:1085:27: error: too few arguments to function 'ieee80211_nullfunc_get'
    1085 |                 skb_new = ieee80211_nullfunc_get(hw, vif, false);
         |                           ^~~~~~~~~~~~~~~~~~~~~~
   In file included from drivers/net/wireless/realtek/rtw88/main.h:8,
                    from drivers/net/wireless/realtek/rtw88/fw.c:7:
   include/net/mac80211.h:5319:17: note: declared here
    5319 | struct sk_buff *ieee80211_nullfunc_get(struct ieee80211_hw *hw,
         |                 ^~~~~~~~~~~~~~~~~~~~~~
   drivers/net/wireless/realtek/rtw88/fw.c:1088:27: error: too few arguments to function 'ieee80211_nullfunc_get'
    1088 |                 skb_new = ieee80211_nullfunc_get(hw, vif, true);
         |                           ^~~~~~~~~~~~~~~~~~~~~~
   include/net/mac80211.h:5319:17: note: declared here
    5319 | struct sk_buff *ieee80211_nullfunc_get(struct ieee80211_hw *hw,
         |                 ^~~~~~~~~~~~~~~~~~~~~~
--
   drivers/net/wireless/st/cw1200/sta.c: In function '__cw1200_cqm_bssloss_sm':
>> drivers/net/wireless/st/cw1200/sta.c:198:23: error: too few arguments to function 'ieee80211_nullfunc_get'
     198 |                 skb = ieee80211_nullfunc_get(priv->hw, priv->vif, false);
         |                       ^~~~~~~~~~~~~~~~~~~~~~
   In file included from drivers/net/wireless/st/cw1200/cw1200.h:21,
                    from drivers/net/wireless/st/cw1200/sta.c:15:
   include/net/mac80211.h:5319:17: note: declared here
    5319 | struct sk_buff *ieee80211_nullfunc_get(struct ieee80211_hw *hw,
         |                 ^~~~~~~~~~~~~~~~~~~~~~
   drivers/net/wireless/st/cw1200/sta.c: In function 'cw1200_upload_null':
   drivers/net/wireless/st/cw1200/sta.c:2266:21: error: too few arguments to function 'ieee80211_nullfunc_get'
    2266 |         frame.skb = ieee80211_nullfunc_get(priv->hw, priv->vif, false);
         |                     ^~~~~~~~~~~~~~~~~~~~~~
   include/net/mac80211.h:5319:17: note: declared here
    5319 | struct sk_buff *ieee80211_nullfunc_get(struct ieee80211_hw *hw,
         |                 ^~~~~~~~~~~~~~~~~~~~~~


vim +/ieee80211_nullfunc_get +1085 drivers/net/wireless/realtek/rtw88/fw.c

04b786e00987c5 Yan-Hsuan Chuang 2019-10-02  1048  
e3037485c68ec1 Yan-Hsuan Chuang 2019-04-26  1049  static struct sk_buff *rtw_get_rsvd_page_skb(struct ieee80211_hw *hw,
b6c12908a33e4e Chin-Yen Lee     2019-12-19  1050  					     struct rtw_rsvd_page *rsvd_pkt)
e3037485c68ec1 Yan-Hsuan Chuang 2019-04-26  1051  {
895c096dab3603 Yan-Hsuan Chuang 2020-03-12  1052  	struct ieee80211_vif *vif;
895c096dab3603 Yan-Hsuan Chuang 2020-03-12  1053  	struct rtw_vif *rtwvif;
e3037485c68ec1 Yan-Hsuan Chuang 2019-04-26  1054  	struct sk_buff *skb_new;
b6c12908a33e4e Chin-Yen Lee     2019-12-19  1055  	struct cfg80211_ssid *ssid;
9cbdadf0097fc4 Po-Hao Huang     2022-04-20  1056  	u16 tim_offset = 0;
e3037485c68ec1 Yan-Hsuan Chuang 2019-04-26  1057  
895c096dab3603 Yan-Hsuan Chuang 2020-03-12  1058  	if (rsvd_pkt->type == RSVD_DUMMY) {
895c096dab3603 Yan-Hsuan Chuang 2020-03-12  1059  		skb_new = alloc_skb(1, GFP_KERNEL);
895c096dab3603 Yan-Hsuan Chuang 2020-03-12  1060  		if (!skb_new)
895c096dab3603 Yan-Hsuan Chuang 2020-03-12  1061  			return NULL;
895c096dab3603 Yan-Hsuan Chuang 2020-03-12  1062  
895c096dab3603 Yan-Hsuan Chuang 2020-03-12  1063  		skb_put(skb_new, 1);
895c096dab3603 Yan-Hsuan Chuang 2020-03-12  1064  		return skb_new;
895c096dab3603 Yan-Hsuan Chuang 2020-03-12  1065  	}
895c096dab3603 Yan-Hsuan Chuang 2020-03-12  1066  
895c096dab3603 Yan-Hsuan Chuang 2020-03-12  1067  	rtwvif = rsvd_pkt->rtwvif;
895c096dab3603 Yan-Hsuan Chuang 2020-03-12  1068  	if (!rtwvif)
895c096dab3603 Yan-Hsuan Chuang 2020-03-12  1069  		return NULL;
895c096dab3603 Yan-Hsuan Chuang 2020-03-12  1070  
895c096dab3603 Yan-Hsuan Chuang 2020-03-12  1071  	vif = rtwvif_to_vif(rtwvif);
895c096dab3603 Yan-Hsuan Chuang 2020-03-12  1072  
b6c12908a33e4e Chin-Yen Lee     2019-12-19  1073  	switch (rsvd_pkt->type) {
e3037485c68ec1 Yan-Hsuan Chuang 2019-04-26  1074  	case RSVD_BEACON:
6e8912a503759b Shaul Triebitz   2022-06-06  1075  		skb_new = ieee80211_beacon_get_tim(hw, vif, &tim_offset, NULL, 0);
f2217968ffdae7 Po-Hao Huang     2022-04-07  1076  		rsvd_pkt->tim_offset = tim_offset;
e3037485c68ec1 Yan-Hsuan Chuang 2019-04-26  1077  		break;
e3037485c68ec1 Yan-Hsuan Chuang 2019-04-26  1078  	case RSVD_PS_POLL:
e3037485c68ec1 Yan-Hsuan Chuang 2019-04-26  1079  		skb_new = ieee80211_pspoll_get(hw, vif);
e3037485c68ec1 Yan-Hsuan Chuang 2019-04-26  1080  		break;
e3037485c68ec1 Yan-Hsuan Chuang 2019-04-26  1081  	case RSVD_PROBE_RESP:
e3037485c68ec1 Yan-Hsuan Chuang 2019-04-26  1082  		skb_new = ieee80211_proberesp_get(hw, vif);
e3037485c68ec1 Yan-Hsuan Chuang 2019-04-26  1083  		break;
e3037485c68ec1 Yan-Hsuan Chuang 2019-04-26  1084  	case RSVD_NULL:
e3037485c68ec1 Yan-Hsuan Chuang 2019-04-26 @1085  		skb_new = ieee80211_nullfunc_get(hw, vif, false);
e3037485c68ec1 Yan-Hsuan Chuang 2019-04-26  1086  		break;
e3037485c68ec1 Yan-Hsuan Chuang 2019-04-26  1087  	case RSVD_QOS_NULL:
e3037485c68ec1 Yan-Hsuan Chuang 2019-04-26  1088  		skb_new = ieee80211_nullfunc_get(hw, vif, true);
e3037485c68ec1 Yan-Hsuan Chuang 2019-04-26  1089  		break;
04b786e00987c5 Yan-Hsuan Chuang 2019-10-02  1090  	case RSVD_LPS_PG_DPK:
04b786e00987c5 Yan-Hsuan Chuang 2019-10-02  1091  		skb_new = rtw_lps_pg_dpk_get(hw);
04b786e00987c5 Yan-Hsuan Chuang 2019-10-02  1092  		break;
04b786e00987c5 Yan-Hsuan Chuang 2019-10-02  1093  	case RSVD_LPS_PG_INFO:
597fc0e6ad59c6 Yan-Hsuan Chuang 2020-02-05  1094  		skb_new = rtw_lps_pg_info_get(hw);
04b786e00987c5 Yan-Hsuan Chuang 2019-10-02  1095  		break;
b6c12908a33e4e Chin-Yen Lee     2019-12-19  1096  	case RSVD_PROBE_REQ:
b6c12908a33e4e Chin-Yen Lee     2019-12-19  1097  		ssid = (struct cfg80211_ssid *)rsvd_pkt->ssid;
b6c12908a33e4e Chin-Yen Lee     2019-12-19  1098  		if (ssid)
b6c12908a33e4e Chin-Yen Lee     2019-12-19  1099  			skb_new = ieee80211_probereq_get(hw, vif->addr,
b6c12908a33e4e Chin-Yen Lee     2019-12-19  1100  							 ssid->ssid,
b6c12908a33e4e Chin-Yen Lee     2019-12-19  1101  							 ssid->ssid_len, 0);
b6c12908a33e4e Chin-Yen Lee     2019-12-19  1102  		else
b6c12908a33e4e Chin-Yen Lee     2019-12-19  1103  			skb_new = ieee80211_probereq_get(hw, vif->addr, NULL, 0, 0);
69c7044526d984 Chin-Yen Lee     2021-07-28  1104  		if (skb_new)
69c7044526d984 Chin-Yen Lee     2021-07-28  1105  			rsvd_pkt->probe_req_size = (u16)skb_new->len;
b6c12908a33e4e Chin-Yen Lee     2019-12-19  1106  		break;
b6c12908a33e4e Chin-Yen Lee     2019-12-19  1107  	case RSVD_NLO_INFO:
b6c12908a33e4e Chin-Yen Lee     2019-12-19  1108  		skb_new = rtw_nlo_info_get(hw);
b6c12908a33e4e Chin-Yen Lee     2019-12-19  1109  		break;
b6c12908a33e4e Chin-Yen Lee     2019-12-19  1110  	case RSVD_CH_INFO:
b6c12908a33e4e Chin-Yen Lee     2019-12-19  1111  		skb_new = rtw_cs_channel_info_get(hw);
b6c12908a33e4e Chin-Yen Lee     2019-12-19  1112  		break;
e3037485c68ec1 Yan-Hsuan Chuang 2019-04-26  1113  	default:
e3037485c68ec1 Yan-Hsuan Chuang 2019-04-26  1114  		return NULL;
e3037485c68ec1 Yan-Hsuan Chuang 2019-04-26  1115  	}
e3037485c68ec1 Yan-Hsuan Chuang 2019-04-26  1116  
e3037485c68ec1 Yan-Hsuan Chuang 2019-04-26  1117  	if (!skb_new)
e3037485c68ec1 Yan-Hsuan Chuang 2019-04-26  1118  		return NULL;
e3037485c68ec1 Yan-Hsuan Chuang 2019-04-26  1119  
e3037485c68ec1 Yan-Hsuan Chuang 2019-04-26  1120  	return skb_new;
e3037485c68ec1 Yan-Hsuan Chuang 2019-04-26  1121  }
e3037485c68ec1 Yan-Hsuan Chuang 2019-04-26  1122  

:::::: The code at line 1085 was first introduced by commit
:::::: e3037485c68ec1a299ff41160d8fedbd4abc29b9 rtw88: new Realtek 802.11ac driver

:::::: TO: Yan-Hsuan Chuang <yhchuang@realtek.com>
:::::: CC: Kalle Valo <kvalo@codeaurora.org>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
