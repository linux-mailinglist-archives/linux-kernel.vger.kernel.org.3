Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C20094AB2A8
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Feb 2022 23:31:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347340AbiBFWbw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Feb 2022 17:31:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229752AbiBFWbu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Feb 2022 17:31:50 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90546C06173B
        for <linux-kernel@vger.kernel.org>; Sun,  6 Feb 2022 14:31:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644186709; x=1675722709;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=kFnGWBRuYaRO+lKITZ6AYKmTA6IRz5Jul47SZVwBE9w=;
  b=egdidNKfX9DTaDxfBqFDre6YG10k8IQEpVvRbxE04Dl+pzxvOOmwcNBf
   VH4zIl28Vrey0g/q1eib6s5/rpoKy2NAGyGqcITjhQVxIIQqv7zFWe+zw
   k5a5R9SdB+EeLW+0pxLDmeQv8c1jbRSEvDk2cNYd4BiEWBAQGh7fCoMiM
   k2FR84f0QNfGqg2AhsTbf3V7fWfhwWThfyo56G46ZoUt9CTokiATMqJSd
   8u+5XStUtKRuGMlJ8+R+IpPgv2Z72UaTvRNfw2B62zwjLw6EpYSc0ERDO
   uGLuN9FTuum3gaI3h839vINyTi7hL39NbLcz9DXw5Zm5PVTayDFRHuG8L
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10250"; a="229259446"
X-IronPort-AV: E=Sophos;i="5.88,348,1635231600"; 
   d="scan'208";a="229259446"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2022 14:31:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,348,1635231600"; 
   d="scan'208";a="700264749"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 06 Feb 2022 14:31:47 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nGq4Q-000ao2-T1; Sun, 06 Feb 2022 22:31:46 +0000
Date:   Mon, 7 Feb 2022 06:31:15 +0800
From:   kernel test robot <lkp@intel.com>
To:     Hector Martin <marcan@marcan.st>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Arend van Spriel <arend.vanspriel@broadcom.com>
Subject: [asahilinux:bits/080-wifi 16/39]
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c:1849:42: warning:
 format specifies type 'long' but the argument has type 'size_t' (aka
 'unsigned int')
Message-ID: <202202070649.4O7uhfhJ-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/AsahiLinux/linux bits/080-wifi
head:   1753101ce16367deadb5ec5ab5dc7ab4894649bf
commit: 1b3f024a42ffd102e9abcf974c3102afd7966252 [16/39] brcmfmac: pcie: Read Apple OTP information
config: i386-allyesconfig (https://download.01.org/0day-ci/archive/20220207/202202070649.4O7uhfhJ-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 6daaf5a44925592c764c59219b0024ee06317028)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/AsahiLinux/linux/commit/1b3f024a42ffd102e9abcf974c3102afd7966252
        git remote add asahilinux https://github.com/AsahiLinux/linux
        git fetch --no-tags asahilinux bits/080-wifi
        git checkout 1b3f024a42ffd102e9abcf974c3102afd7966252
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash drivers/hid/ drivers/net/wireless/broadcom/brcm80211/brcmfmac/ sound/soc/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c:1849:42: warning: format specifies type 'long' but the argument has type 'size_t' (aka 'unsigned int') [-Wformat]
           brcmf_dbg(PCIE, "parse_otp size=%ld\n", size);
                                           ~~~     ^~~~
                                           %u
   drivers/net/wireless/broadcom/brcm80211/brcmfmac/debug.h:77:14: note: expanded from macro 'brcmf_dbg'
                       fmt, ##__VA_ARGS__);                        \
                       ~~~    ^~~~~~~~~~~
   1 warning generated.


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
