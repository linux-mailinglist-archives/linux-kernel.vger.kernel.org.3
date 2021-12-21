Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C01E747BA74
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 08:09:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234672AbhLUHJu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 02:09:50 -0500
Received: from mga11.intel.com ([192.55.52.93]:10923 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233417AbhLUHJt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 02:09:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640070589; x=1671606589;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=0K4nz5kEPqX+fMNJz6rUSGbUvjQ+BKPobREGKe/hgdA=;
  b=mQp3EFuo9ccRNUAawiUzKoxsLgslM+OUYnOPo5hdVkg/Iug1fCwv0V62
   t76ETB2z2TCgVXl2TOQGvwXBFAdwfg2hbJ1fibTwM3BJaX6xISV9TPVXP
   sp03KXLkuTWGKmGzyj89RFf9YB6sPhkMNA5jUgBYS0EQ5yqrI1ZfEduLC
   Tu2SFms4B7FG2gOVNbZr0/vzqpipVytxFQ7eeY8U9n/WqkqDAmRayOJPQ
   1eZIlD0YEZE03x4wbHQZvMunfHFUWaP56apDTAMdFRo3Ono1FuR2EaJR6
   Glx1O1vkpruCCdZFW6H3Q+cpCD6pPa8RIgLTyjQ03d3oOgcw9Vb4/Qh1O
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10204"; a="237879134"
X-IronPort-AV: E=Sophos;i="5.88,222,1635231600"; 
   d="scan'208";a="237879134"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Dec 2021 23:09:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,222,1635231600"; 
   d="scan'208";a="663865821"
Received: from lkp-server02.sh.intel.com (HELO 9f38c0981d9f) ([10.239.97.151])
  by fmsmga001.fm.intel.com with ESMTP; 20 Dec 2021 23:09:48 -0800
Received: from kbuild by 9f38c0981d9f with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mzZHP-0008nk-Fn; Tue, 21 Dec 2021 07:09:47 +0000
Date:   Tue, 21 Dec 2021 15:09:36 +0800
From:   kernel test robot <lkp@intel.com>
To:     Hector Martin <marcan@marcan.st>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [asahilinux:wifi-wip 69/69]
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c:2024:1: warning: the
 frame size of 1032 bytes is larger than 1024 bytes
Message-ID: <202112211521.t1MoHFEv-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/AsahiLinux/linux wifi-wip
head:   f23b880a0e670605f762a659fae44c4cb198bf8d
commit: f23b880a0e670605f762a659fae44c4cb198bf8d [69/69] WIP: wifi stuff
config: i386-allyesconfig (https://download.01.org/0day-ci/archive/20211221/202112211521.t1MoHFEv-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build):
        # https://github.com/AsahiLinux/linux/commit/f23b880a0e670605f762a659fae44c4cb198bf8d
        git remote add asahilinux https://github.com/AsahiLinux/linux
        git fetch --no-tags asahilinux wifi-wip
        git checkout f23b880a0e670605f762a659fae44c4cb198bf8d
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash drivers/net/wireless/broadcom/brcm80211/brcmfmac/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c:32:
   drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c: In function 'brcmf_pcie_parse_otp':
   drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c:1960:18: warning: format '%ld' expects argument of type 'long int', but argument 4 has type 'size_t' {aka 'unsigned int'} [-Wformat=]
    1960 |  brcmf_dbg(PCIE, "parse_otp size=%ld\n", size);
         |                  ^~~~~~~~~~~~~~~~~~~~~~  ~~~~
         |                                          |
         |                                          size_t {aka unsigned int}
   drivers/net/wireless/broadcom/brcm80211/brcmfmac/debug.h:77:7: note: in definition of macro 'brcmf_dbg'
      77 |       fmt, ##__VA_ARGS__);   \
         |       ^~~
   drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c:1960:36: note: format string is defined here
    1960 |  brcmf_dbg(PCIE, "parse_otp size=%ld\n", size);
         |                                  ~~^
         |                                    |
         |                                    long int
         |                                  %d
   drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c: In function 'brcmf_pcie_read_otp':
>> drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c:2024:1: warning: the frame size of 1032 bytes is larger than 1024 bytes [-Wframe-larger-than=]
    2024 | }
         | ^


vim +2024 drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c

  1995	
  1996	static int brcmf_pcie_read_otp(struct brcmf_pciedev_info *devinfo)
  1997	{
  1998		u32 base, words, idx;
  1999		u32 otp[BRCMF_OTP_MAX_WORDS];
  2000		struct brcmf_core *core;
  2001	
  2002		switch (devinfo->ci->chip) {
  2003		case BRCM_CC_4387_CHIP_ID:
  2004			base = 0x113c;
  2005			words = 0x40;
  2006			break;
  2007		default:
  2008			return 0;
  2009		}
  2010	
  2011		BUG_ON(words > BRCMF_OTP_MAX_WORDS);
  2012	
  2013		core = brcmf_chip_get_core(devinfo->ci, BCMA_CORE_GCI);
  2014		if (!core)
  2015			return -ENODEV;
  2016	
  2017		base += core->base;
  2018	
  2019		for (idx = 0; idx < words; idx++) {
  2020			otp[idx] = brcmf_pcie_buscore_read32(devinfo, base + 4 * idx);
  2021		}
  2022	
  2023		return brcmf_pcie_parse_otp(devinfo, (u8 *)otp, 4 * words);
> 2024	}
  2025	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
