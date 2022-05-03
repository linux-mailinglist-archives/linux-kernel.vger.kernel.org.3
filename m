Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44F4C5180DB
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 11:19:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233362AbiECJXK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 05:23:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233317AbiECJXE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 05:23:04 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 956E01FCD5
        for <linux-kernel@vger.kernel.org>; Tue,  3 May 2022 02:19:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651569572; x=1683105572;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=xJctIF8PxvmuprZA7iQtJmbIrvppS9aODAGy8PlH6SQ=;
  b=fXS5PcysxiOAOfOqPMnrncFfJEDUWUP61LH1IKRnBxudSe/8IVmZfZWA
   EQccw6WLc0rJed0dCWXExQsTFaRX+zxwMx7AewoYvI+jdQV8tUq7CN+Fd
   PpXplnA/VC5n3N5xuTSDGYjJDv/iGTR2KnZ9DW4kSrQqQLdX2myXFWpz3
   GaruJHPbz2qvZq/dhVpYhYBKDOGSITrYqBwnF2t/tHVHjFoxfxc1jRrGa
   1cGg62KU4yQVVrvjvjgUlRdbMSR0aJZu+VC1lOA98EonbgiQq4W/E7lBa
   Ot05GPbNNhKJ1mrznDKqQUVnq/VV3zRysTu6Pp3b1IndvESv1xbzvk9Dz
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10335"; a="247342854"
X-IronPort-AV: E=Sophos;i="5.91,194,1647327600"; 
   d="scan'208";a="247342854"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 May 2022 02:19:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,194,1647327600"; 
   d="scan'208";a="547301360"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 03 May 2022 02:19:30 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nlogr-000AKC-Qb;
        Tue, 03 May 2022 09:19:29 +0000
Date:   Tue, 3 May 2022 17:19:18 +0800
From:   kernel test robot <lkp@intel.com>
To:     Hector Martin <marcan@marcan.st>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [asahilinux:bits/080-wifi 22/28]
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c:4075:42: sparse:
 sparse: incorrect type in assignment (different base types)
Message-ID: <202205031736.gRzjuzo3-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/AsahiLinux/linux bits/080-wifi
head:   a61fbffc5fad05fe49dfd9a09b3c2482ac250d46
commit: 02dc276155c1728343ebf406ab567b56d3891f19 [22/28] brcmfmac: cfg80211: Add support for PMKID_V3 operations
config: mips-randconfig-s032-20220501 (https://download.01.org/0day-ci/archive/20220503/202205031736.gRzjuzo3-lkp@intel.com/config)
compiler: mipsel-linux-gcc (GCC) 11.3.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://github.com/AsahiLinux/linux/commit/02dc276155c1728343ebf406ab567b56d3891f19
        git remote add asahilinux https://github.com/AsahiLinux/linux
        git fetch --no-tags asahilinux bits/080-wifi
        git checkout 02dc276155c1728343ebf406ab567b56d3891f19
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
