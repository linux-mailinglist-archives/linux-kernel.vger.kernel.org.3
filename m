Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55CF74A95BA
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 10:09:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236665AbiBDJJP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 04:09:15 -0500
Received: from mga06.intel.com ([134.134.136.31]:42609 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229680AbiBDJJO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 04:09:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643965754; x=1675501754;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=SWVTA8lGun21/jrOqI6jof5fMDwtYNd/1yH6chN1mgw=;
  b=b3EZJN+cadyQ9nhkYaKZ3mfaSk5BfA5obi5uzlvs/Mbc2bhI/MzIqPAH
   Z7CY2jH31L/xXbrX8yVaxAedRYrkeEnRiI3tiFvNcnBMPJ/26Qfg6xWoF
   CxSHBd1jJdNf3yycGMdYmv36szn1KkBUL8TM9ZtbjLieBNj6BclpQGq2z
   I+BEth59ElBCgOC61axNx9fm/JIec6wAcsI95DqZd4wZptFJZjEBPzWjD
   6rvAxIjdZ+0yEM5rAP9CFEvcIW7XbHhEaWDfdLVmhWYc/wvAybPYAZNuO
   RGMEAueNpBb3A2BpRWZlpTHjs4DwplmL87Kqmjn2H9UfC+5wYkJSg9dWA
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10247"; a="309081416"
X-IronPort-AV: E=Sophos;i="5.88,342,1635231600"; 
   d="scan'208";a="309081416"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2022 01:09:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,342,1635231600"; 
   d="scan'208";a="480789300"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 04 Feb 2022 01:09:13 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nFuae-000XOw-CX; Fri, 04 Feb 2022 09:09:12 +0000
Date:   Fri, 4 Feb 2022 17:08:40 +0800
From:   kernel test robot <lkp@intel.com>
To:     Hector Martin <marcan@marcan.st>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Arend van Spriel <arend.vanspriel@broadcom.com>
Subject: [asahilinux:bits/080-wifi 16/39]
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c:1849:25: warning:
 format '%ld' expects argument of type 'long int', but argument 4 has type
 'size_t' {aka 'unsigned int'}
Message-ID: <202202041704.s5S9QTyY-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/AsahiLinux/linux bits/080-wifi
head:   1753101ce16367deadb5ec5ab5dc7ab4894649bf
commit: 1b3f024a42ffd102e9abcf974c3102afd7966252 [16/39] brcmfmac: pcie: Read Apple OTP information
config: mips-allyesconfig (https://download.01.org/0day-ci/archive/20220204/202202041704.s5S9QTyY-lkp@intel.com/config)
compiler: mips-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/AsahiLinux/linux/commit/1b3f024a42ffd102e9abcf974c3102afd7966252
        git remote add asahilinux https://github.com/AsahiLinux/linux
        git fetch --no-tags asahilinux bits/080-wifi
        git checkout 1b3f024a42ffd102e9abcf974c3102afd7966252
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=mips SHELL=/bin/bash drivers/net/wireless/broadcom/brcm80211/brcmfmac/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c:33:
   drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c: In function 'brcmf_pcie_parse_otp':
>> drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c:1849:25: warning: format '%ld' expects argument of type 'long int', but argument 4 has type 'size_t' {aka 'unsigned int'} [-Wformat=]
    1849 |         brcmf_dbg(PCIE, "parse_otp size=%ld\n", size);
         |                         ^~~~~~~~~~~~~~~~~~~~~~  ~~~~
         |                                                 |
         |                                                 size_t {aka unsigned int}
   drivers/net/wireless/broadcom/brcm80211/brcmfmac/debug.h:77:21: note: in definition of macro 'brcmf_dbg'
      77 |                     fmt, ##__VA_ARGS__);                        \
         |                     ^~~
   drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c:1849:43: note: format string is defined here
    1849 |         brcmf_dbg(PCIE, "parse_otp size=%ld\n", size);
         |                                         ~~^
         |                                           |
         |                                           long int
         |                                         %d


vim +1849 drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c

  1842	
  1843	static int
  1844	brcmf_pcie_parse_otp(struct brcmf_pciedev_info *devinfo, u8 *otp, size_t size)
  1845	{
  1846		int p = 0;
  1847		int ret = -EINVAL;
  1848	
> 1849		brcmf_dbg(PCIE, "parse_otp size=%ld\n", size);
  1850	
  1851		while (p < (size - 1)) {
  1852			u8 type = otp[p];
  1853			u8 length = otp[p + 1];
  1854	
  1855			if (type == 0)
  1856				break;
  1857	
  1858			if ((p + 2 + length) > size)
  1859				break;
  1860	
  1861			switch (type) {
  1862			case BRCMF_OTP_SYS_VENDOR:
  1863				brcmf_dbg(PCIE, "OTP @ 0x%x (%d): SYS_VENDOR\n",
  1864					  p, length);
  1865				ret = brcmf_pcie_parse_otp_sys_vendor(devinfo,
  1866								      &otp[p + 2],
  1867								      length);
  1868				break;
  1869			case BRCMF_OTP_BRCM_CIS:
  1870				brcmf_dbg(PCIE, "OTP @ 0x%x (%d): BRCM_CIS\n",
  1871					  p, length);
  1872				break;
  1873			default:
  1874				brcmf_dbg(PCIE, "OTP @ 0x%x (%d): Unknown type 0x%x\n",
  1875					  p, length, type);
  1876				break;
  1877			}
  1878	
  1879			p += 2 + length;
  1880		}
  1881	
  1882		return ret;
  1883	}
  1884	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
