Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED8A757782E
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Jul 2022 22:21:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231300AbiGQUUd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Jul 2022 16:20:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229680AbiGQUUa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jul 2022 16:20:30 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BEE912604
        for <linux-kernel@vger.kernel.org>; Sun, 17 Jul 2022 13:20:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658089229; x=1689625229;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=u3BTU9s6wqgyMqlryXdvFK/JVmALAmGORBwys/OKIBM=;
  b=YKrne1KPGh4q6a1VjJldSiDkwIDRRxZIWTuOzLSk/DzSDmIeEz8PoEM6
   Yp271xBOVYB3O2H9gsZ3eNF6fFQTO9Mu1Zh41NsPJHhUeWrN1cTHJQbKP
   JqihRFA7xT1gMPpP4hTQMSOrxDaPfdNWeXKlbRO1onWZvCtSDJsxW/w0X
   CdKG+eZCnbxgmKO8MPERszZOv0DxhiakRYxZdKSQslwcMD6Q2jpA5TrUq
   aUDgnIMwUrS3ZXFnSuSo6cnl3qY7vQYP2KxAJNGgVDqoZHgd70hLBvGpC
   521fGoqg5FOWFNRv4nW5X910D1KhxoCLWoYJ9wnG9L0Ni8pWAUjZouwgj
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10411"; a="347779846"
X-IronPort-AV: E=Sophos;i="5.92,279,1650956400"; 
   d="scan'208";a="347779846"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2022 13:20:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,279,1650956400"; 
   d="scan'208";a="572153981"
Received: from lkp-server02.sh.intel.com (HELO ff137eb26ff1) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 17 Jul 2022 13:20:27 -0700
Received: from kbuild by ff137eb26ff1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1oDAkd-0003f3-0q;
        Sun, 17 Jul 2022 20:20:27 +0000
Date:   Mon, 18 Jul 2022 04:19:34 +0800
From:   kernel test robot <lkp@intel.com>
To:     Hector Martin <marcan@marcan.st>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [asahilinux:bits/080-wifi 22/29]
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c:4075:42: sparse:
 sparse: incorrect type in assignment (different base types)
Message-ID: <202207180442.juH2G4EL-lkp@intel.com>
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
config: parisc-randconfig-s041-20220715 (https://download.01.org/0day-ci/archive/20220718/202207180442.juH2G4EL-lkp@intel.com/config)
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
