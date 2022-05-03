Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13C98517F7F
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 10:09:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232440AbiECIMQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 04:12:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232709AbiECIMK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 04:12:10 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA10821242
        for <linux-kernel@vger.kernel.org>; Tue,  3 May 2022 01:08:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651565309; x=1683101309;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=pQRJIMSHRWoXWkBHaCg0thUW9BPcCDhLqp+vI0JQ3ec=;
  b=F/5KdSUJlbEORkIBF1pCYRsEphx6t/xOhbxoAiwd7/0EZfBdb2NSjWT9
   9suNXhkG3m5hOGGAU1cTxlkd6fNmaragRfN0+JtOIsZ0K54JQq/Q8FMzb
   OGfzaSUU++D/C0EW+KeI97jzPckV9tlhEYswvm3C9W6lwuiadZPWY4sX5
   lBDDjZY1H1xbMYV1jVEjEvtk4LYGa0hGQl18doz6wEGtEsYSJjn4oLQfB
   YC7Y16WexCJsqx7QRONnpAyj+OGlFM7feERZTNJJVfluCoUWDUIpxEASp
   EIaFNcW9sPqezFuaNQ28+28v/nRpndT9m4qZfnyPkKXXnQkj1DHwFsQY3
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10335"; a="353865258"
X-IronPort-AV: E=Sophos;i="5.91,194,1647327600"; 
   d="scan'208";a="353865258"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 May 2022 01:08:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,194,1647327600"; 
   d="scan'208";a="631422988"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 03 May 2022 01:08:28 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nlna7-000AGp-OE;
        Tue, 03 May 2022 08:08:27 +0000
Date:   Tue, 3 May 2022 16:07:43 +0800
From:   kernel test robot <lkp@intel.com>
To:     Hector Martin <marcan@marcan.st>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [asahilinux:bits/080-wifi 20/28]
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c:1087:28: sparse:
 sparse: incorrect type in assignment (different base types)
Message-ID: <202205031618.zjvgzw7q-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/AsahiLinux/linux bits/080-wifi
head:   a61fbffc5fad05fe49dfd9a09b3c2482ac250d46
commit: 3535383eee14ca31f15355d05d4bcec4ae9ae09b [20/28] brcmfmac: cfg80211: Add support for scan params v2
config: mips-randconfig-s032-20220501 (https://download.01.org/0day-ci/archive/20220503/202205031618.zjvgzw7q-lkp@intel.com/config)
compiler: mipsel-linux-gcc (GCC) 11.3.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://github.com/AsahiLinux/linux/commit/3535383eee14ca31f15355d05d4bcec4ae9ae09b
        git remote add asahilinux https://github.com/AsahiLinux/linux
        git fetch --no-tags asahilinux bits/080-wifi
        git checkout 3535383eee14ca31f15355d05d4bcec4ae9ae09b
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=mips SHELL=/bin/bash drivers/net/wireless/broadcom/brcm80211/brcmfmac/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
   command-line: note: in included file:
   builtin:1:9: sparse: sparse: preprocessor token __ATOMIC_ACQUIRE redefined
   builtin:0:0: sparse: this was the original definition
   builtin:1:9: sparse: sparse: preprocessor token __ATOMIC_SEQ_CST redefined
   builtin:0:0: sparse: this was the original definition
   builtin:1:9: sparse: sparse: preprocessor token __ATOMIC_ACQ_REL redefined
   builtin:0:0: sparse: this was the original definition
   builtin:1:9: sparse: sparse: preprocessor token __ATOMIC_RELEASE redefined
   builtin:0:0: sparse: this was the original definition
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

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
