Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45D5150F00B
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 06:58:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244197AbiDZFAw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 01:00:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229988AbiDZFAq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 01:00:46 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58F203BBF8
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 21:57:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650949058; x=1682485058;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=UCcN97RI4a2d+AeokmfPrH4NM62IuE/MuaqFUHKia8w=;
  b=MEoiZ5Jr4Yd8cCET1n7EZ6pBHeE/w+8nFaVFMhnUqt0h8Rzev40WPFct
   vtOhmCylVoaEMPjfOzhPLKjgIpWiq1rDTL6i+aPh3WalzPEF45Jsb3Qqi
   V/AlgjDCApkc5gDtMItobljl45PSmlo0/2D9fkFOfNTcZTMhQK8/NfqhP
   LKyqRNsOVduZQXOSe3wXcVw9gygDSDtfEGuKCsQ/35Hc/7ipCxewoPj6n
   cKfGuRqcy+Siq8Eofnxv/jQMwu7tQUVSvJlUF4/yyU9EtX/5icSNC1UOp
   EbNsLppejbDEvWc9LpBypArU+gg3xW7nic8mh8oVXF8/lHALc8jJsQEnE
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10328"; a="325941811"
X-IronPort-AV: E=Sophos;i="5.90,290,1643702400"; 
   d="scan'208";a="325941811"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2022 21:57:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,290,1643702400"; 
   d="scan'208";a="730070234"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 25 Apr 2022 21:57:36 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1njDGZ-0003FO-Ls;
        Tue, 26 Apr 2022 04:57:35 +0000
Date:   Tue, 26 Apr 2022 12:56:46 +0800
From:   kernel test robot <lkp@intel.com>
To:     Hector Martin <marcan@marcan.st>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Arend van Spriel <arend.vanspriel@broadcom.com>
Subject: [asahilinux:pr/22 40/189]
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c:1849:25: warning:
 format '%ld' expects argument of type 'long int', but argument 2 has type
 'size_t' {aka 'unsigned int'}
Message-ID: <202204261241.FDz2mhDI-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/AsahiLinux/linux pr/22
head:   7ee315306d1a3b0da8cf2a53e7f55889d0e7f034
commit: fc41e32d8f12538376a1c602c118590a4a81a6a9 [40/189] brcmfmac: pcie: Read Apple OTP information
config: i386-randconfig-a013-20220425 (https://download.01.org/0day-ci/archive/20220426/202204261241.FDz2mhDI-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.2.0-20) 11.2.0
reproduce (this is a W=1 build):
        # https://github.com/AsahiLinux/linux/commit/fc41e32d8f12538376a1c602c118590a4a81a6a9
        git remote add asahilinux https://github.com/AsahiLinux/linux
        git fetch --no-tags asahilinux pr/22
        git checkout fc41e32d8f12538376a1c602c118590a4a81a6a9
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash drivers/net/wireless/broadcom/brcm80211/brcmfmac/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from include/linux/kernel.h:29,
                    from drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c:6:
   drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c: In function 'brcmf_pcie_parse_otp':
>> drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c:1849:25: warning: format '%ld' expects argument of type 'long int', but argument 2 has type 'size_t' {aka 'unsigned int'} [-Wformat=]
    1849 |         brcmf_dbg(PCIE, "parse_otp size=%ld\n", size);
         |                         ^~~~~~~~~~~~~~~~~~~~~~  ~~~~
         |                                                 |
         |                                                 size_t {aka unsigned int}
   include/linux/printk.h:418:25: note: in definition of macro 'printk_index_wrap'
     418 |                 _p_func(_fmt, ##__VA_ARGS__);                           \
         |                         ^~~~
   include/linux/printk.h:132:17: note: in expansion of macro 'printk'
     132 |                 printk(fmt, ##__VA_ARGS__);             \
         |                 ^~~~~~
   drivers/net/wireless/broadcom/brcm80211/brcmfmac/debug.h:96:36: note: in expansion of macro 'no_printk'
      96 | #define brcmf_dbg(level, fmt, ...) no_printk(fmt, ##__VA_ARGS__)
         |                                    ^~~~~~~~~
   drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c:1849:9: note: in expansion of macro 'brcmf_dbg'
    1849 |         brcmf_dbg(PCIE, "parse_otp size=%ld\n", size);
         |         ^~~~~~~~~
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

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
