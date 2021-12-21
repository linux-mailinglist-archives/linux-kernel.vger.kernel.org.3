Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3640C47BB90
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 09:14:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235462AbhLUIOv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 03:14:51 -0500
Received: from mga03.intel.com ([134.134.136.65]:60342 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235408AbhLUIOv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 03:14:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640074491; x=1671610491;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=bWNx5W9PmCJS3+waDT84TICsA1cZWMlEiJsdKehUVak=;
  b=MAjoqFEwdSk8eUGC5O+bsPJR24A1qAh711k5WI+DnvuHezl43YVrqw9/
   KNo6Tfz+tzwYXSlSDTn209P2Ha9+C+9sesosqI+lkPGsOWcDp2+qFV4Pr
   ZaEUEv6tXhzp3auqR0lDydQAGC9mpEv1OOfv6MWffmF7S0m9u6mFCoEPG
   6u17t408PglTiJj0eGGjUBWLkDNe63GrvzGb07lWEuZl5Sr8lPI2o59SR
   kVG8/tE/gKSNC9vXFEeEJMkKqPHymVVNsvg1a2fgDkj6cRoOUGGLCTi2S
   DrzMloph3wmFGJvv2lbiDT3AtrpdQYCapOuIekC62NVzciaOCIufVrQgY
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10204"; a="240304862"
X-IronPort-AV: E=Sophos;i="5.88,222,1635231600"; 
   d="scan'208";a="240304862"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Dec 2021 00:14:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,222,1635231600"; 
   d="scan'208";a="757692560"
Received: from lkp-server02.sh.intel.com (HELO 9f38c0981d9f) ([10.239.97.151])
  by fmsmga005.fm.intel.com with ESMTP; 21 Dec 2021 00:14:49 -0800
Received: from kbuild by 9f38c0981d9f with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mzaIK-0008rT-Lc; Tue, 21 Dec 2021 08:14:48 +0000
Date:   Tue, 21 Dec 2021 16:13:55 +0800
From:   kernel test robot <lkp@intel.com>
To:     Hector Martin <marcan@marcan.st>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [asahilinux:wifi-wip 69/69]
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c:1960:25: warning:
 format '%ld' expects argument of type 'long int', but argument 4 has type
 'size_t' {aka 'unsigned int'}
Message-ID: <202112211644.oOqVGMC7-lkp@intel.com>
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
config: arc-allyesconfig (https://download.01.org/0day-ci/archive/20211221/202112211644.oOqVGMC7-lkp@intel.com/config)
compiler: arceb-elf-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/AsahiLinux/linux/commit/f23b880a0e670605f762a659fae44c4cb198bf8d
        git remote add asahilinux https://github.com/AsahiLinux/linux
        git fetch --no-tags asahilinux wifi-wip
        git checkout f23b880a0e670605f762a659fae44c4cb198bf8d
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arc SHELL=/bin/bash drivers/net/wireless/broadcom/brcm80211/brcmfmac/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c:32:
   drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c: In function 'brcmf_pcie_parse_otp':
>> drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c:1960:25: warning: format '%ld' expects argument of type 'long int', but argument 4 has type 'size_t' {aka 'unsigned int'} [-Wformat=]
    1960 |         brcmf_dbg(PCIE, "parse_otp size=%ld\n", size);
         |                         ^~~~~~~~~~~~~~~~~~~~~~  ~~~~
         |                                                 |
         |                                                 size_t {aka unsigned int}
   drivers/net/wireless/broadcom/brcm80211/brcmfmac/debug.h:77:21: note: in definition of macro 'brcmf_dbg'
      77 |                     fmt, ##__VA_ARGS__);                        \
         |                     ^~~
   drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c:1960:43: note: format string is defined here
    1960 |         brcmf_dbg(PCIE, "parse_otp size=%ld\n", size);
         |                                         ~~^
         |                                           |
         |                                           long int
         |                                         %d

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for SND_AMD_ACP_CONFIG
   Depends on SOUND && !UML && SND && SND_SOC && SND_SOC_ACPI
   Selected by
   - SND_SOC_SOF_AMD_COMMON && SOUND && !UML && SND && SND_SOC && SND_SOC_SOF_TOPLEVEL && SND_SOC_SOF_AMD_TOPLEVEL


vim +1960 drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c

  1953	
  1954	static int
  1955	brcmf_pcie_parse_otp(struct brcmf_pciedev_info *devinfo, u8 *otp, size_t size)
  1956	{
  1957		int p = 0;
  1958		int ret = -1;
  1959	
> 1960		brcmf_dbg(PCIE, "parse_otp size=%ld\n", size);
  1961	
  1962		while (p < (size - 1)) {
  1963			u8 type = otp[p];
  1964			u8 length = otp[p + 1];
  1965	
  1966			if (type == 0)
  1967				break;
  1968	
  1969			if ((p + 2 + length) > size)
  1970				break;
  1971	
  1972			switch (type) {
  1973			case BRCMF_OTP_SYS_VENDOR:
  1974				brcmf_dbg(PCIE, "OTP @ 0x%x (0x%x): SYS_VENDOR\n",
  1975					  p, length);
  1976				ret = brcmf_pcie_parse_otp_sys_vendor(devinfo,
  1977								      &otp[p + 2],
  1978								      length);
  1979				break;
  1980			case BRCMF_OTP_BRCM_CIS:
  1981				brcmf_dbg(PCIE, "OTP @ 0x%x (0x%x): BRCM_CIS\n",
  1982					  p, length);
  1983				break;
  1984			default:
  1985				brcmf_dbg(PCIE, "OTP @ 0x%x (0x%x): Unknown type 0x%x\n",
  1986					  p, length, type);
  1987				break;
  1988			}
  1989	
  1990			p += 2 + length;
  1991		}
  1992	
  1993		return ret;
  1994	}
  1995	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
