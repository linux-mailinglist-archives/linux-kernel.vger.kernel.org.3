Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A616757BFED
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 00:11:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229943AbiGTWLM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 18:11:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229665AbiGTWLK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 18:11:10 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2F31286EB
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 15:11:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658355068; x=1689891068;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=F1F1hWBdhDC9ImTfqdhKdiBX+EbIYtGNErw5yOaP/cA=;
  b=J2+vw49HwLX1TI6WznzD6hJ/rRDeQxCoZ3R3rZ6s/9EczqvCn1BEmrLi
   oE6qp+NipyX7UrRfLPaAYXcW9vjZXpqPHicEi9Vy0L7c48KUJ1aOwzDs2
   MNVpfu3VT6Q6YlpXGTJqgyx+nYV2joWYdZc1SvnZg5PO4w7/hiv+/LVCB
   21DWA4RkshooQBF6zgVRNznva/nwQGNv9zyfIGJHAJ98y4JyECLnHG9ep
   4x4LB5M6RAh09zx9wAOfvuoYDHcSd18Ab6oILKyh9jrQ7sHAK+GsoYV1r
   4Z7mzEvyWij9LGHJ0SuH+PqJZmO3iEodYkwWu6BWB7E0Zm+dupLZJaTcl
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10414"; a="273737630"
X-IronPort-AV: E=Sophos;i="5.92,287,1650956400"; 
   d="scan'208";a="273737630"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2022 15:11:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,287,1650956400"; 
   d="scan'208";a="666036876"
Received: from lkp-server01.sh.intel.com (HELO 7dfbdc7c7900) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 20 Jul 2022 15:11:07 -0700
Received: from kbuild by 7dfbdc7c7900 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1oEHuM-0000z3-EH;
        Wed, 20 Jul 2022 22:11:06 +0000
Date:   Thu, 21 Jul 2022 06:10:39 +0800
From:   kernel test robot <lkp@intel.com>
To:     Hector Martin <marcan@marcan.st>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Arend van Spriel <arend.vanspriel@broadcom.com>
Subject: [asahilinux:bits/080-wifi 5/29]
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c:1849:25: warning:
 format '%ld' expects argument of type 'long int', but argument 4 has type
 'size_t' {aka 'unsigned int'}
Message-ID: <202207210649.UfR2pswx-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/AsahiLinux/linux bits/080-wifi
head:   17fbadf936c0875886e8b4f48a777eca5acf3b20
commit: 52ca690168b8099616e3d5a99728e07d408e9cae [5/29] brcmfmac: pcie: Read Apple OTP information
config: arc-buildonly-randconfig-r005-20220719 (https://download.01.org/0day-ci/archive/20220721/202207210649.UfR2pswx-lkp@intel.com/config)
compiler: arceb-elf-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/AsahiLinux/linux/commit/52ca690168b8099616e3d5a99728e07d408e9cae
        git remote add asahilinux https://github.com/AsahiLinux/linux
        git fetch --no-tags asahilinux bits/080-wifi
        git checkout 52ca690168b8099616e3d5a99728e07d408e9cae
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=arc SHELL=/bin/bash drivers/net/wireless/ lib//

If you fix the issue, kindly add following tag where applicable
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

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
