Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27F7A47C4D0
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 18:16:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240275AbhLURQW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 12:16:22 -0500
Received: from mga11.intel.com ([192.55.52.93]:54200 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240272AbhLURQV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 12:16:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640106981; x=1671642981;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=EzXtSwvigbRj7n7exm44TiiNaH5fR7ngD/STtjtuZRE=;
  b=jTdIMx2zx6vRLpWCSlxSk3AXemRPzSbtl5vk8xBxwP++e1qzKoEkntqG
   QD42ZJK2rPpThek5jNSn4kIUKYuTEKCqHYy76coaFLQEn3M/sCX5pVOBu
   6V8eb3Us2q4ngOmhi5h331XZaaqhHU2tqxnmIJQS2LPsAp0IEdMk7w9Zk
   D0LRvcG2CAOHsJprlzrI2EBA+yoxrw+rhcgS6qhxRQ5q/i+qDQKOmwijA
   HaHdqWtIlAMSugl4KcScZg5BRSQlMzdLnpENSLLl0hStufgF84KKuMw58
   d4c+D59EUYAufItQBEvC3SZ8/XecmSmpY6E625r2jmoz9ucPyUnS8uj4W
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10205"; a="237976064"
X-IronPort-AV: E=Sophos;i="5.88,224,1635231600"; 
   d="scan'208";a="237976064"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Dec 2021 09:16:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,224,1635231600"; 
   d="scan'208";a="466361300"
Received: from lkp-server02.sh.intel.com (HELO 9f38c0981d9f) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 21 Dec 2021 09:16:01 -0800
Received: from kbuild by 9f38c0981d9f with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mzik4-0009F4-Vb; Tue, 21 Dec 2021 17:16:00 +0000
Date:   Wed, 22 Dec 2021 01:15:04 +0800
From:   kernel test robot <lkp@intel.com>
To:     Hector Martin <marcan@marcan.st>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [asahilinux:wifi/take1 85/91]
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c:4077:1: warning:
 the frame size of 1800 bytes is larger than 1024 bytes
Message-ID: <202112220041.deKpnjGs-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/AsahiLinux/linux wifi/take1
head:   834938020c08ed3b67af49e60513162a0f1a41fc
commit: d3ffbfeeb6594d1354497a8e20fd2f31b1788ddd [85/91] brcmfmac: cfg80211: Add support for PMKID_V3 operations
config: nds32-allyesconfig (https://download.01.org/0day-ci/archive/20211222/202112220041.deKpnjGs-lkp@intel.com/config)
compiler: nds32le-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/AsahiLinux/linux/commit/d3ffbfeeb6594d1354497a8e20fd2f31b1788ddd
        git remote add asahilinux https://github.com/AsahiLinux/linux
        git fetch --no-tags asahilinux wifi/take1
        git checkout d3ffbfeeb6594d1354497a8e20fd2f31b1788ddd
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=nds32 SHELL=/bin/bash drivers/net/wireless/broadcom/brcm80211/brcmfmac/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c: In function 'brcmf_pmksa_v3_op':
>> drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c:4077:1: warning: the frame size of 1800 bytes is larger than 1024 bytes [-Wframe-larger-than=]
    4077 | }
         | ^


vim +4077 drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c

  4050	
  4051	static s32
  4052	brcmf_pmksa_v3_op(struct brcmf_if *ifp, struct cfg80211_pmksa *pmksa,
  4053			  bool alive)
  4054	{
  4055		struct brcmf_pmk_op_v3_le pmk_op;
  4056		int length = offsetof(struct brcmf_pmk_op_v3_le, pmk);
  4057	
  4058		memset(&pmk_op, 0, sizeof(pmk_op));
  4059		pmk_op.version = cpu_to_le16(BRCMF_PMKSA_VER_3);
  4060	
  4061		if (!pmksa) {
  4062			/* Flush operation, operate on entire list */
  4063			pmk_op.count = cpu_to_le16(0);
  4064		} else {
  4065			/* Single PMK operation */
  4066			pmk_op.count = cpu_to_le16(1);
  4067			length += sizeof(struct brcmf_pmksa_v3);
  4068			memcpy(pmk_op.pmk[0].bssid, pmksa->bssid, ETH_ALEN);
  4069			memcpy(pmk_op.pmk[0].pmkid, pmksa->pmkid, WLAN_PMKID_LEN);
  4070			pmk_op.pmk[0].pmkid_len = WLAN_PMKID_LEN;
  4071			pmk_op.pmk[0].time_left = alive ? BRCMF_PMKSA_NO_EXPIRY : 0;
  4072		}
  4073	
  4074		pmk_op.length = cpu_to_le16(length);
  4075	
  4076		return brcmf_fil_iovar_data_set(ifp, "pmkid_info", &pmk_op, sizeof(pmk_op));
> 4077	}
  4078	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
