Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B91B94BE782
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 19:03:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355357AbiBUKnA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 05:43:00 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:33194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355693AbiBUKlj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 05:41:39 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 143284DF68
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 02:03:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645437806; x=1676973806;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=LL64gE49wMxsg2sCVXOzTRsJ067WI7wGOPOAWroC4+Y=;
  b=ibKkug16CZB6tPCpNp6Bs377MvR0isO3B2vZdQXbBm5eH4/+SHRorSTt
   uffjZjjwTUYH6msQNrzO/gjMdVgcEJQ4N343ldFaAaPwbwy2Olj7wFS3F
   uxDjEFfuv6TXkYOgsQbFmgX4LmqEKBAWrqxUMibGDnA+Xt67yxStm82mo
   ksDjbe0gLF6/vKMLYhwZpcycQ+PgVOU9TLXunO+XhucikFIr6rlIjY0es
   WkMSNJAT0wHd6VF8zgnYV+SSZ1ktgABztsDk1cr5AwNTK3GGeVO1uc4Yp
   XtWTJ3CSQpO5vWl4wGQsXBtpn3n/eodKwYr1yMq+ycNSIeSt0ErY1TXrm
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10264"; a="235019100"
X-IronPort-AV: E=Sophos;i="5.88,385,1635231600"; 
   d="scan'208";a="235019100"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2022 02:03:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,385,1635231600"; 
   d="scan'208";a="590915799"
Received: from lkp-server01.sh.intel.com (HELO da3212ac2f54) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 21 Feb 2022 02:03:11 -0800
Received: from kbuild by da3212ac2f54 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nM5XC-0001Uf-Sc; Mon, 21 Feb 2022 10:03:10 +0000
Date:   Mon, 21 Feb 2022 18:02:15 +0800
From:   kernel test robot <lkp@intel.com>
To:     Hector Martin <marcan@marcan.st>
Cc:     kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [ammarfaizi2-block:axboe/linux-block/m1/2022-02-19 493/552]
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c:4075:42: sparse:
 sparse: incorrect type in assignment (different base types)
Message-ID: <202202211736.kxyu07D7-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ammarfaizi2/linux-block axboe/linux-block/m1/2022-02-19
head:   b781e0ccdc0c9a931571d15db09d45b7258b9905
commit: 8ad0f256eccca6e552589c0814abe4bcff183a41 [493/552] brcmfmac: cfg80211: Add support for PMKID_V3 operations
config: i386-randconfig-s001-20220221 (https://download.01.org/0day-ci/archive/20220221/202202211736.kxyu07D7-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://github.com/ammarfaizi2/linux-block/commit/8ad0f256eccca6e552589c0814abe4bcff183a41
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block axboe/linux-block/m1/2022-02-19
        git checkout 8ad0f256eccca6e552589c0814abe4bcff183a41
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=i386 SHELL=/bin/bash drivers/net/wireless/broadcom/brcm80211/brcmfmac/

If you fix the issue, kindly add following tag as appropriate
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

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
