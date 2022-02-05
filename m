Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E1CF4AAC98
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Feb 2022 22:02:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379351AbiBEVCu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Feb 2022 16:02:50 -0500
Received: from mga14.intel.com ([192.55.52.115]:21311 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1354918AbiBEVCt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Feb 2022 16:02:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644094969; x=1675630969;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=0wXwwQ0y06+pUlSOjjm+CQCMvr5YFOWiUdCi1boRIJI=;
  b=jUqXFMvZe+70LPZ8XIVZy7qgHKvqPD+/h5wim71cbYqcJ43GwZFv3F81
   7awEyIQQZ1OO4eQYy+fROXYakd2qC7zhndLqXQ3KjTXpPaYo4piwyrAHc
   jQ9OstBSgARMWN5vKH2iDuiB/51FbZ3amwqcy52bJJrp1Ug+TO9uWPOoA
   CDP+Vzf05+3LdVJwJoBgeLEO0plBbj4sxeh6COH8U6OnUGYthvQ25hOtZ
   T69CtwkiYjsjhkPEI4TZXATUVk+8cuhA5gNk/crPZ8LZ2ZKcrs+2Z6nE8
   aIgHVCht6o1ZebYOLmlWDuVnMxyjE1j0JlGlyhNcflOC0qpaxD4uPiCdy
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10249"; a="248749248"
X-IronPort-AV: E=Sophos;i="5.88,346,1635231600"; 
   d="scan'208";a="248749248"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2022 13:02:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,346,1635231600"; 
   d="scan'208";a="600534406"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 05 Feb 2022 13:02:47 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nGSCl-000ZUb-Av; Sat, 05 Feb 2022 21:02:47 +0000
Date:   Sun, 6 Feb 2022 05:02:19 +0800
From:   kernel test robot <lkp@intel.com>
To:     Luiz Angelo Daros de Luca <luizluca@gmail.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [saeed:net-next 48/260]
 drivers/net/dsa/realtek/realtek-mdio.c:203:34: warning: unused variable
 'realtek_mdio_of_match'
Message-ID: <202202060415.LYwQvNJX-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/saeed/linux.git net-next
head:   69dd0fdc44211d799165e6959057b323accc5afe
commit: aac94001067da183455d6d37959892744fa01d9d [48/260] net: dsa: realtek: add new mdio interface for drivers
config: arm-randconfig-r001-20220206 (https://download.01.org/0day-ci/archive/20220206/202202060415.LYwQvNJX-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project dee058c670593b999fec19c458dbbd882ad9de56)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm cross compiling tool for clang build
        # apt-get install binutils-arm-linux-gnueabi
        # https://git.kernel.org/pub/scm/linux/kernel/git/saeed/linux.git/commit/?id=aac94001067da183455d6d37959892744fa01d9d
        git remote add saeed https://git.kernel.org/pub/scm/linux/kernel/git/saeed/linux.git
        git fetch --no-tags saeed net-next
        git checkout aac94001067da183455d6d37959892744fa01d9d
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash drivers/net/dsa/realtek/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/net/dsa/realtek/realtek-mdio.c:203:34: warning: unused variable 'realtek_mdio_of_match' [-Wunused-const-variable]
   static const struct of_device_id realtek_mdio_of_match[] = {
                                    ^
   1 warning generated.


vim +/realtek_mdio_of_match +203 drivers/net/dsa/realtek/realtek-mdio.c

   202	
 > 203	static const struct of_device_id realtek_mdio_of_match[] = {
   204	#if IS_ENABLED(CONFIG_NET_DSA_REALTEK_RTL8366RB)
   205		{ .compatible = "realtek,rtl8366rb", .data = &rtl8366rb_variant, },
   206	#endif
   207	#if IS_ENABLED(CONFIG_NET_DSA_REALTEK_RTL8365MB)
   208		{ .compatible = "realtek,rtl8365mb", .data = &rtl8365mb_variant, },
   209	#endif
   210		{ /* sentinel */ },
   211	};
   212	MODULE_DEVICE_TABLE(of, realtek_mdio_of_match);
   213	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
