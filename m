Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3626A48842D
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jan 2022 16:20:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234528AbiAHPUB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Jan 2022 10:20:01 -0500
Received: from mga02.intel.com ([134.134.136.20]:56977 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229455AbiAHPUA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jan 2022 10:20:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641655199; x=1673191199;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=k0BG1kxN035jz80uP5ZCYRt/ZZu3yLZ6NInbhi4pbXQ=;
  b=cbe2XB/dCxG/y44nQwJ/IZpEAMbWESE1Ad0fHSx9Eb5qeEHhwDHwmaCv
   45o2WnVMwZe4y0exRqOD80X2i7l58kGOgBdtmGRABt1Hhs1eTWWTDLTwu
   jqvI3UPz7YPeAoDGtXEefLj51IBjc1kpuWNlUF75UB2T19L4SYGUM22lU
   jYzgucOJReRdzTGpLXqEZ4I3PkwrimmPRpqZnx63T+9MkTneLa4KK+xq3
   Qo1aB/PlFQUoT+r148NmlKEGYe9YaRlmc6mP8lgx5Zd3LyuMmFpmSZxoD
   7dsAdyAWLg0h2h40TX+mWw9TKpSlk70T189wMAYgI9BNPnlvcBxvL+GZ2
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10220"; a="230360738"
X-IronPort-AV: E=Sophos;i="5.88,272,1635231600"; 
   d="scan'208";a="230360738"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jan 2022 07:19:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,272,1635231600"; 
   d="scan'208";a="489592169"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 08 Jan 2022 07:19:58 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n6DVd-0000ji-QO; Sat, 08 Jan 2022 15:19:57 +0000
Date:   Sat, 8 Jan 2022 23:19:48 +0800
From:   kernel test robot <lkp@intel.com>
To:     Hector Martin <marcan@marcan.st>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [asahilinux:wifi/v2 7/36]
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c:1876:25: warning:
 format '%ld' expects argument of type 'long int', but argument 4 has type
 'size_t' {aka 'unsigned int'}
Message-ID: <202201082351.OJp1BM88-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/AsahiLinux/linux wifi/v2
head:   eb734bc66e4a5a80ba82846d9c2dd20011f17561
commit: b2f82fde0c4ca15202b587ec9def353c45bef5af [7/36] brcmfmac: pcie: Read Apple OTP information
config: arc-allmodconfig (https://download.01.org/0day-ci/archive/20220108/202201082351.OJp1BM88-lkp@intel.com/config)
compiler: arceb-elf-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/AsahiLinux/linux/commit/b2f82fde0c4ca15202b587ec9def353c45bef5af
        git remote add asahilinux https://github.com/AsahiLinux/linux
        git fetch --no-tags asahilinux wifi/v2
        git checkout b2f82fde0c4ca15202b587ec9def353c45bef5af
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arc SHELL=/bin/bash drivers/block/ drivers/net/wireless/broadcom/brcm80211/brcmfmac/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c:32:
   drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c: In function 'brcmf_pcie_parse_otp':
>> drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c:1876:25: warning: format '%ld' expects argument of type 'long int', but argument 4 has type 'size_t' {aka 'unsigned int'} [-Wformat=]
    1876 |         brcmf_dbg(PCIE, "parse_otp size=%ld\n", size);
         |                         ^~~~~~~~~~~~~~~~~~~~~~  ~~~~
         |                                                 |
         |                                                 size_t {aka unsigned int}
   drivers/net/wireless/broadcom/brcm80211/brcmfmac/debug.h:77:21: note: in definition of macro 'brcmf_dbg'
      77 |                     fmt, ##__VA_ARGS__);                        \
         |                     ^~~
   drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c:1876:43: note: format string is defined here
    1876 |         brcmf_dbg(PCIE, "parse_otp size=%ld\n", size);
         |                                         ~~^
         |                                           |
         |                                           long int
         |                                         %d


vim +1876 drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c

  1869	
  1870	static int
  1871	brcmf_pcie_parse_otp(struct brcmf_pciedev_info *devinfo, u8 *otp, size_t size)
  1872	{
  1873		int p = 0;
  1874		int ret = -1;
  1875	
> 1876		brcmf_dbg(PCIE, "parse_otp size=%ld\n", size);
  1877	
  1878		while (p < (size - 1)) {
  1879			u8 type = otp[p];
  1880			u8 length = otp[p + 1];
  1881	
  1882			if (type == 0)
  1883				break;
  1884	
  1885			if ((p + 2 + length) > size)
  1886				break;
  1887	
  1888			switch (type) {
  1889			case BRCMF_OTP_SYS_VENDOR:
  1890				brcmf_dbg(PCIE, "OTP @ 0x%x (0x%x): SYS_VENDOR\n",
  1891					  p, length);
  1892				ret = brcmf_pcie_parse_otp_sys_vendor(devinfo,
  1893								      &otp[p + 2],
  1894								      length);
  1895				break;
  1896			case BRCMF_OTP_BRCM_CIS:
  1897				brcmf_dbg(PCIE, "OTP @ 0x%x (0x%x): BRCM_CIS\n",
  1898					  p, length);
  1899				break;
  1900			default:
  1901				brcmf_dbg(PCIE, "OTP @ 0x%x (0x%x): Unknown type 0x%x\n",
  1902					  p, length, type);
  1903				break;
  1904			}
  1905	
  1906			p += 2 + length;
  1907		}
  1908	
  1909		return ret;
  1910	}
  1911	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
