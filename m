Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F6D55771C8
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Jul 2022 00:20:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232513AbiGPWUB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Jul 2022 18:20:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229619AbiGPWT7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jul 2022 18:19:59 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A5EC18E2B
        for <linux-kernel@vger.kernel.org>; Sat, 16 Jul 2022 15:19:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658009998; x=1689545998;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=ufvwV4ixnLX1+1hIZGjDLBj9Eq1g9Ryobutjp7mbHSE=;
  b=STISRy+7IGiWBLNigazbcdVwbzP2WUjiI+HtHHt4TkPMzR465jZW1CKa
   +3HFBqbYRCun3FOjjBqpmAIbbbALiQieoWcZQs2WDEr3TDWn0bQactIAR
   quizyAN1wdJVATixEC51lHpsrAwhLhOkCMORbkCjs3gEXgtOxMN6268LY
   aXvHETChTwSziVqGpMRYORHHZBrgSuIr/8iJpWacurudGZr6vuLX0PuMq
   lMxcpsiA+PAX9h8QgL5IiVTw6W5RKM74LnPWkXKNCT6NZuL7EGiWACLtr
   /dKOElhAjFlM5P/jkXhhP58nca5JwBoJYwLZV29QllvebBs0GmC1ix2hy
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10410"; a="284766138"
X-IronPort-AV: E=Sophos;i="5.92,277,1650956400"; 
   d="scan'208";a="284766138"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2022 15:19:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,277,1650956400"; 
   d="scan'208";a="686333534"
Received: from lkp-server02.sh.intel.com (HELO ff137eb26ff1) ([10.239.97.151])
  by FMSMGA003.fm.intel.com with ESMTP; 16 Jul 2022 15:19:56 -0700
Received: from kbuild by ff137eb26ff1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1oCq8h-0002E6-SU;
        Sat, 16 Jul 2022 22:19:55 +0000
Date:   Sun, 17 Jul 2022 06:19:01 +0800
From:   kernel test robot <lkp@intel.com>
To:     Hector Martin <marcan@marcan.st>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [asahilinux:bits/080-wifi 22/29]
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c:4075:42: sparse:
 sparse: incorrect type in assignment (different base types)
Message-ID: <202207170607.LQUVasBU-lkp@intel.com>
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
commit: cb8c1e6eaed57ea1268f71d306e4a7e4708992d8 [22/29] brcmfmac: cfg80211: Add support for PMKID_V3 operations
config: parisc-randconfig-s041-20220715 (https://download.01.org/0day-ci/archive/20220717/202207170607.LQUVasBU-lkp@intel.com/config)
compiler: hppa64-linux-gcc (GCC) 12.1.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-39-gce1a6720-dirty
        # https://github.com/AsahiLinux/linux/commit/cb8c1e6eaed57ea1268f71d306e4a7e4708992d8
        git remote add asahilinux https://github.com/AsahiLinux/linux
        git fetch --no-tags asahilinux bits/080-wifi
        git checkout cb8c1e6eaed57ea1268f71d306e4a7e4708992d8
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=parisc64 SHELL=/bin/bash drivers/bluetooth/ drivers/media/i2c/ drivers/net/wireless/broadcom/brcm80211/brcmfmac/ drivers/pci/ kernel/trace/ sound/soc/codecs/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
   drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c:1087:28: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le16 [usertype] version @@     got int @@
   drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c:1087:28: sparse:     expected restricted __le16 [usertype] version
   drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c:1087:28: sparse:     got int
   drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c:1149:38: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [usertype] scan_type @@     got int @@
   drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c:1149:38: sparse:     expected restricted __le32 [usertype] scan_type
   drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c:1149:38: sparse:     got int
   drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c:790:30: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned char [usertype] scan_type @@     got restricted __le32 [usertype] scan_type @@
   drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c:790:30: sparse:     expected unsigned char [usertype] scan_type
   drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c:790:30: sparse:     got restricted __le32 [usertype] scan_type
>> drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c:4075:42: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [usertype] time_left @@     got unsigned int @@
   drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c:4075:42: sparse:     expected restricted __le32 [usertype] time_left
   drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c:4075:42: sparse:     got unsigned int

vim +4075 drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c

  4053	
  4054	static s32
  4055	brcmf_pmksa_v3_op(struct brcmf_if *ifp, struct cfg80211_pmksa *pmksa,
  4056			  bool alive)
  4057	{
  4058		struct brcmf_pmk_op_v3_le *pmk_op;
  4059		int length = offsetof(struct brcmf_pmk_op_v3_le, pmk);
  4060		int ret;
  4061	
  4062		pmk_op = kzalloc(sizeof(*pmk_op), GFP_KERNEL);
  4063		pmk_op->version = cpu_to_le16(BRCMF_PMKSA_VER_3);
  4064	
  4065		if (!pmksa) {
  4066			/* Flush operation, operate on entire list */
  4067			pmk_op->count = cpu_to_le16(0);
  4068		} else {
  4069			/* Single PMK operation */
  4070			pmk_op->count = cpu_to_le16(1);
  4071			length += sizeof(struct brcmf_pmksa_v3);
  4072			memcpy(pmk_op->pmk[0].bssid, pmksa->bssid, ETH_ALEN);
  4073			memcpy(pmk_op->pmk[0].pmkid, pmksa->pmkid, WLAN_PMKID_LEN);
  4074			pmk_op->pmk[0].pmkid_len = WLAN_PMKID_LEN;
> 4075			pmk_op->pmk[0].time_left = alive ? BRCMF_PMKSA_NO_EXPIRY : 0;
  4076		}
  4077	
  4078		pmk_op->length = cpu_to_le16(length);
  4079	
  4080		ret = brcmf_fil_iovar_data_set(ifp, "pmkid_info", pmk_op, sizeof(*pmk_op));
  4081		kfree(pmk_op);
  4082		return ret;
  4083	}
  4084	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
