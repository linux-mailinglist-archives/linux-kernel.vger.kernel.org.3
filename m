Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18AE24BDF8F
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 18:50:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344138AbiBUIlg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 03:41:36 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:56404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344090AbiBUIle (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 03:41:34 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F413F73
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 00:41:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645432871; x=1676968871;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Du4bp4MXJE1id8FkmcvDPXmNJoGlJfxo8VUBgob2eL8=;
  b=dbCVRBKHsFyETGiK1EZ2reF8wW743rV8Fovnno+llxD99lODuTIIQwwW
   TAd/GR+DmIU8YlQh/dFWyipCmLMk+EWgyuLo/ct1S6G8VPyr1eNb79oaW
   lwjVuzQ3ovauC6PwL8Jjs7BNtyniarPPNDiS5lwB5J7VpQGj6vs6O9DqT
   WdMkbtiC9HCUCXPpNBuR7QX7Cymh99hi+Z/qKiTOxS6x1oVL8Y+ROB0eC
   VMrDfSPyT3edLhTz8BVZ/Bgg4baK975dAfITmJnoejRG7PdlkGADncujF
   TWgSSU2iQmuN5gGW9A9+M3WjepDKOO59CdCO+aLZ4OD4g0fZkj33tEOyU
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10264"; a="238878676"
X-IronPort-AV: E=Sophos;i="5.88,385,1635231600"; 
   d="scan'208";a="238878676"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2022 00:41:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,385,1635231600"; 
   d="scan'208";a="638481729"
Received: from lkp-server01.sh.intel.com (HELO da3212ac2f54) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 21 Feb 2022 00:41:09 -0800
Received: from kbuild by da3212ac2f54 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nM4Fo-0001QW-Ks; Mon, 21 Feb 2022 08:41:08 +0000
Date:   Mon, 21 Feb 2022 16:40:10 +0800
From:   kernel test robot <lkp@intel.com>
To:     Hector Martin <marcan@marcan.st>
Cc:     kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org
Subject: [ammarfaizi2-block:axboe/linux-block/m1/2022-02-19 491/552]
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c:1087:28: sparse:
 sparse: incorrect type in assignment (different base types)
Message-ID: <202202211631.TQArYv6u-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ammarfaizi2/linux-block axboe/linux-block/m1/2022-02-19
head:   b781e0ccdc0c9a931571d15db09d45b7258b9905
commit: cc508fcd22b7d2522a7ace5baaf236db384f1160 [491/552] brcmfmac: cfg80211: Add support for scan params v2
config: i386-randconfig-s001-20220221 (https://download.01.org/0day-ci/archive/20220221/202202211631.TQArYv6u-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://github.com/ammarfaizi2/linux-block/commit/cc508fcd22b7d2522a7ace5baaf236db384f1160
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block axboe/linux-block/m1/2022-02-19
        git checkout cc508fcd22b7d2522a7ace5baaf236db384f1160
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=i386 SHELL=/bin/bash drivers/net/wireless/broadcom/brcm80211/brcmfmac/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
>> drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c:1087:28: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le16 [usertype] version @@     got int @@
   drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c:1087:28: sparse:     expected restricted __le16 [usertype] version
   drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c:1087:28: sparse:     got int
>> drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c:1149:38: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [usertype] scan_type @@     got int @@
   drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c:1149:38: sparse:     expected restricted __le32 [usertype] scan_type
   drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c:1149:38: sparse:     got int
>> drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c:790:30: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned char [usertype] scan_type @@     got restricted __le32 [usertype] scan_type @@
   drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c:790:30: sparse:     expected unsigned char [usertype] scan_type
   drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c:790:30: sparse:     got restricted __le32 [usertype] scan_type

vim +1087 drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c

  1069	
  1070	static void brcmf_escan_prep(struct brcmf_cfg80211_info *cfg,
  1071				     struct brcmf_scan_params_v2_le *params_le,
  1072				     struct cfg80211_scan_request *request)
  1073	{
  1074		u32 n_ssids;
  1075		u32 n_channels;
  1076		s32 i;
  1077		s32 offset;
  1078		u16 chanspec;
  1079		char *ptr;
  1080		int length;
  1081		struct brcmf_ssid_le ssid_le;
  1082	
  1083		eth_broadcast_addr(params_le->bssid);
  1084	
  1085		length = BRCMF_SCAN_PARAMS_V2_FIXED_SIZE;
  1086	
> 1087		params_le->version = BRCMF_SCAN_PARAMS_VERSION_V2;
  1088		params_le->bss_type = DOT11_BSSTYPE_ANY;
  1089		params_le->scan_type = BRCMF_SCANTYPE_ACTIVE;
  1090		params_le->channel_num = 0;
  1091		params_le->nprobes = cpu_to_le32(-1);
  1092		params_le->active_time = cpu_to_le32(-1);
  1093		params_le->passive_time = cpu_to_le32(-1);
  1094		params_le->home_time = cpu_to_le32(-1);
  1095		memset(&params_le->ssid_le, 0, sizeof(params_le->ssid_le));
  1096	
  1097		/* Scan abort */
  1098		if (!request) {
  1099			length += sizeof(u16);
  1100			params_le->channel_num = cpu_to_le32(1);
  1101			params_le->channel_list[0] = cpu_to_le16(-1);
  1102			params_le->length = cpu_to_le16(length);
  1103			return;
  1104		}
  1105	
  1106		n_ssids = request->n_ssids;
  1107		n_channels = request->n_channels;
  1108	
  1109		/* Copy channel array if applicable */
  1110		brcmf_dbg(SCAN, "### List of channelspecs to scan ### %d\n",
  1111			  n_channels);
  1112		if (n_channels > 0) {
  1113			length += roundup(sizeof(u16) * n_channels, sizeof(u32));
  1114			for (i = 0; i < n_channels; i++) {
  1115				chanspec = channel_to_chanspec(&cfg->d11inf,
  1116							       request->channels[i]);
  1117				brcmf_dbg(SCAN, "Chan : %d, Channel spec: %x\n",
  1118					  request->channels[i]->hw_value, chanspec);
  1119				params_le->channel_list[i] = cpu_to_le16(chanspec);
  1120			}
  1121		} else {
  1122			brcmf_dbg(SCAN, "Scanning all channels\n");
  1123		}
  1124	
  1125		/* Copy ssid array if applicable */
  1126		brcmf_dbg(SCAN, "### List of SSIDs to scan ### %d\n", n_ssids);
  1127		if (n_ssids > 0) {
  1128			offset = offsetof(struct brcmf_scan_params_v2_le, channel_list) +
  1129					n_channels * sizeof(u16);
  1130			offset = roundup(offset, sizeof(u32));
  1131			length += sizeof(ssid_le) * n_ssids,
  1132			ptr = (char *)params_le + offset;
  1133			for (i = 0; i < n_ssids; i++) {
  1134				memset(&ssid_le, 0, sizeof(ssid_le));
  1135				ssid_le.SSID_len =
  1136						cpu_to_le32(request->ssids[i].ssid_len);
  1137				memcpy(ssid_le.SSID, request->ssids[i].ssid,
  1138				       request->ssids[i].ssid_len);
  1139				if (!ssid_le.SSID_len)
  1140					brcmf_dbg(SCAN, "%d: Broadcast scan\n", i);
  1141				else
  1142					brcmf_dbg(SCAN, "%d: scan for  %.32s size=%d\n",
  1143						  i, ssid_le.SSID, ssid_le.SSID_len);
  1144				memcpy(ptr, &ssid_le, sizeof(ssid_le));
  1145				ptr += sizeof(ssid_le);
  1146			}
  1147		} else {
  1148			brcmf_dbg(SCAN, "Performing passive scan\n");
> 1149			params_le->scan_type = BRCMF_SCANTYPE_PASSIVE;
  1150		}
  1151		params_le->length = cpu_to_le16(length);
  1152		/* Adding mask to channel numbers */
  1153		params_le->channel_num =
  1154			cpu_to_le32((n_ssids << BRCMF_SCAN_PARAMS_NSSID_SHIFT) |
  1155				(n_channels & BRCMF_SCAN_PARAMS_COUNT_MASK));
  1156	}
  1157	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
