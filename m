Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88A6D49606A
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 15:06:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350894AbiAUOFv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 09:05:51 -0500
Received: from mga04.intel.com ([192.55.52.120]:2394 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1350871AbiAUOFu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 09:05:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642773950; x=1674309950;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=69sgSZz7lyieU1mkFLPQfUU9GE2k09qc14bQ2+FZAuE=;
  b=cF6lyz1SndhCfOQwXlHq4Y4rC2oN2OYdN4grDM68Mmkk4hjIQYezd20n
   ibFW5tMPrCqqB+kIUxWVnj9h774Gm5LCFi5Gn/fXBLRvw+WW+zWXbrqI2
   BsEMzim7mJw+pTY0iT05brGn868KyOLe3nMAmi+iPC4l6IRbMYb2jY7GC
   7WYuZh5RfXouMGMRGj03zvcONRcGoZ1qqVAbAnF+NiLDF1foHppnleb29
   tW8O3If40W8Vo2VkLTvv2X/4a518IvsJ8MoEB42oSAJjMenhcEcJarpKz
   BchNddks9OxECEugJjAmR5sbuxzBOp/IO2WOXwpky5z6Bn5GtEgEjwTLJ
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10233"; a="244478982"
X-IronPort-AV: E=Sophos;i="5.88,304,1635231600"; 
   d="scan'208";a="244478982"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2022 06:05:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,304,1635231600"; 
   d="scan'208";a="672951934"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 21 Jan 2022 06:05:48 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nAuXz-000FMH-Vf; Fri, 21 Jan 2022 14:05:47 +0000
Date:   Fri, 21 Jan 2022 22:05:28 +0800
From:   kernel test robot <lkp@intel.com>
To:     Hector Martin <marcan@marcan.st>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [asahilinux:bits/080-wifi 11/39]
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/of.c:74:10: warning:
 variable 'len' set but not used
Message-ID: <202201212104.gFjUBTm8-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/AsahiLinux/linux bits/080-wifi
head:   1753101ce16367deadb5ec5ab5dc7ab4894649bf
commit: cc44c86950084bc3437485288390841cf117c0d1 [11/39] brcmfmac: of: Use devm_kstrdup for board_type & check for errors
config: x86_64-randconfig-a003-20220117 (https://download.01.org/0day-ci/archive/20220121/202201212104.gFjUBTm8-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project 7b3d30728816403d1fd73cc5082e9fb761262bce)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/AsahiLinux/linux/commit/cc44c86950084bc3437485288390841cf117c0d1
        git remote add asahilinux https://github.com/AsahiLinux/linux
        git fetch --no-tags asahilinux bits/080-wifi
        git checkout cc44c86950084bc3437485288390841cf117c0d1
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash drivers/net/wireless/broadcom/brcm80211/brcmfmac/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/net/wireless/broadcom/brcm80211/brcmfmac/of.c:74:10: warning: variable 'len' set but not used [-Wunused-but-set-variable]
                   int i, len;
                          ^
   1 warning generated.


vim +/len +74 drivers/net/wireless/broadcom/brcm80211/brcmfmac/of.c

1a3ac5c651a0c85 drivers/net/wireless/broadcom/brcm80211/brcmfmac/of.c Shawn Guo        2021-04-17  60  
e457a8a01a19277 drivers/net/wireless/broadcom/brcm80211/brcmfmac/of.c Rafał Miłecki    2017-01-07  61  void brcmf_of_probe(struct device *dev, enum brcmf_bus_type bus_type,
e457a8a01a19277 drivers/net/wireless/broadcom/brcm80211/brcmfmac/of.c Rafał Miłecki    2017-01-07  62  		    struct brcmf_mp_device *settings)
61f663dfc1a091c drivers/net/wireless/brcm80211/brcmfmac/of.c          Chen-Yu Tsai     2014-06-29  63  {
e457a8a01a19277 drivers/net/wireless/broadcom/brcm80211/brcmfmac/of.c Rafał Miłecki    2017-01-07  64  	struct brcmfmac_sdio_pd *sdio = &settings->bus.sdio;
0ad4b55b2f29784 drivers/net/wireless/broadcom/brcm80211/brcmfmac/of.c Hans de Goede    2018-10-10  65  	struct device_node *root, *np = dev->of_node;
61f663dfc1a091c drivers/net/wireless/brcm80211/brcmfmac/of.c          Chen-Yu Tsai     2014-06-29  66  	int irq;
1a3ac5c651a0c85 drivers/net/wireless/broadcom/brcm80211/brcmfmac/of.c Shawn Guo        2021-04-17  67  	int err;
61f663dfc1a091c drivers/net/wireless/brcm80211/brcmfmac/of.c          Chen-Yu Tsai     2014-06-29  68  	u32 irqf;
61f663dfc1a091c drivers/net/wireless/brcm80211/brcmfmac/of.c          Chen-Yu Tsai     2014-06-29  69  	u32 val;
61f663dfc1a091c drivers/net/wireless/brcm80211/brcmfmac/of.c          Chen-Yu Tsai     2014-06-29  70  
0ad4b55b2f29784 drivers/net/wireless/broadcom/brcm80211/brcmfmac/of.c Hans de Goede    2018-10-10  71  	/* Set board-type to the first string of the machine compatible prop */
0ad4b55b2f29784 drivers/net/wireless/broadcom/brcm80211/brcmfmac/of.c Hans de Goede    2018-10-10  72  	root = of_find_node_by_path("/");
0ad4b55b2f29784 drivers/net/wireless/broadcom/brcm80211/brcmfmac/of.c Hans de Goede    2018-10-10  73  	if (root) {
29e354ebeeecaee drivers/net/wireless/broadcom/brcm80211/brcmfmac/of.c Matthias Brugger 2020-07-01 @74  		int i, len;

:::::: The code at line 74 was first introduced by commit
:::::: 29e354ebeeecaee979e6fe22cd6272682d7552c9 brcmfmac: Transform compatible string for FW loading

:::::: TO: Matthias Brugger <mbrugger@suse.com>
:::::: CC: Kalle Valo <kvalo@codeaurora.org>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
