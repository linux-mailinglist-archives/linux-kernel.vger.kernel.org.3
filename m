Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 848695777C2
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Jul 2022 20:26:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231509AbiGQS0D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Jul 2022 14:26:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbiGQS0C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jul 2022 14:26:02 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 200AF12090
        for <linux-kernel@vger.kernel.org>; Sun, 17 Jul 2022 11:26:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658082361; x=1689618361;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=njU9EQSSPra2TYQzCjcFgBQwyeni81otigjBmys3YUM=;
  b=XfLyR1ni8lRhV9v8n+Qwv68FiEnfhbZ75GJaFO2q9XI8Eg5hlU0N3rIS
   3M7J6mrm250/lhTvi1HbFGMcwFEik9+e+IFcarVwKU6EAHKRq1OxL8Z8D
   JP/SXfg5OVFHAFznyMtUrkYMo7vn0v9F7EZKhxqcFi+fv8EQE/8r/mBbz
   osbv7GPkVgqWNx9qhSV6T68FQnzne7oBItyJWZyCkIlOBoq6KY85W30c7
   HJF/glh2BPjW6wok9DtOm/FBx6e3KDCkrAaOdtjdwxAok8Y+J/Iz6NORa
   pMTzono0PL5NEYqGsQdyWvCTv6SZc2/49lWiQv0KWggz5JuWotkRqERyi
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10411"; a="350045601"
X-IronPort-AV: E=Sophos;i="5.92,279,1650956400"; 
   d="scan'208";a="350045601"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2022 11:26:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,279,1650956400"; 
   d="scan'208";a="699785912"
Received: from lkp-server02.sh.intel.com (HELO ff137eb26ff1) ([10.239.97.151])
  by fmsmga002.fm.intel.com with ESMTP; 17 Jul 2022 11:25:59 -0700
Received: from kbuild by ff137eb26ff1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1oD8xq-0003ZK-Mj;
        Sun, 17 Jul 2022 18:25:58 +0000
Date:   Mon, 18 Jul 2022 02:25:37 +0800
From:   kernel test robot <lkp@intel.com>
To:     Hector Martin <marcan@marcan.st>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [asahilinux:bits/080-wifi 20/29]
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c:1087:28: sparse:
 sparse: incorrect type in assignment (different base types)
Message-ID: <202207180208.JN9wWybB-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/AsahiLinux/linux bits/080-wifi
head:   17fbadf936c0875886e8b4f48a777eca5acf3b20
commit: ef271557a174ab5bf47549d93f05ee97a54ae145 [20/29] brcmfmac: cfg80211: Add support for scan params v2
config: parisc-randconfig-s041-20220715 (https://download.01.org/0day-ci/archive/20220718/202207180208.JN9wWybB-lkp@intel.com/config)
compiler: hppa64-linux-gcc (GCC) 12.1.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-39-gce1a6720-dirty
        # https://github.com/AsahiLinux/linux/commit/ef271557a174ab5bf47549d93f05ee97a54ae145
        git remote add asahilinux https://github.com/AsahiLinux/linux
        git fetch --no-tags asahilinux bits/080-wifi
        git checkout ef271557a174ab5bf47549d93f05ee97a54ae145
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=parisc64 SHELL=/bin/bash drivers/bluetooth/ drivers/media/i2c/ drivers/net/wireless/broadcom/brcm80211/brcmfmac/ drivers/pci/ kernel/trace/ sound/soc/codecs/

If you fix the issue, kindly add following tag where applicable
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

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
