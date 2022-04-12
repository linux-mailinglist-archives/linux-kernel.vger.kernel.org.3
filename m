Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B1B34FD488
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 12:04:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1389994AbiDLJY0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 05:24:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355519AbiDLIIb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 04:08:31 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E55EEBE
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 00:37:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649749058; x=1681285058;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=0LJFvrdyN/JW03J9udGK9z8Z3EITY86/qGe+UYJwVjM=;
  b=gJsQWRuFNlFSVb2UBTGdIbx0MaUUyl0V6rgbbVVmSDL3dYZQ3dhUyAZA
   8UtvhG/sQiT3bERBGOgyreZLdW/OU56tsxn/BW9XpRRTSfDb0cG6cIqOm
   G10oBKJm2iW6hNKp1C6kyB+Ga/XfWVv81MlAFapGUBhsu/jfGFMJclWNm
   s+K78gbEqyhzOcTXwhtFCBSu1bkdhOdLjR89dHKPYsfTE2jTNi+vdA4RP
   TViwTd2LqMYUOBQoGzd0j1LaXD91F/FZs3h0er7OY7/i0RVDMqXN60f1M
   Qq2JMl4KHdwCOO7DyBLFfkGTy4hvXyxzY3A/5WZ1fum1Bu9ajEiREgMFo
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10314"; a="242889079"
X-IronPort-AV: E=Sophos;i="5.90,253,1643702400"; 
   d="scan'208";a="242889079"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2022 00:37:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,253,1643702400"; 
   d="scan'208";a="525925955"
Received: from lkp-server02.sh.intel.com (HELO d3fc50ef50de) ([10.239.97.151])
  by orsmga002.jf.intel.com with ESMTP; 12 Apr 2022 00:37:24 -0700
Received: from kbuild by d3fc50ef50de with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1neB5X-0002dU-Ck;
        Tue, 12 Apr 2022 07:37:23 +0000
Date:   Tue, 12 Apr 2022 15:36:24 +0800
From:   kernel test robot <lkp@intel.com>
To:     Luiz Angelo Daros de Luca <luizluca@gmail.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alvin =?utf-8?Q?=C5=A0ipraga?= <alsi@bang-olufsen.dk>,
        Linus Walleij <linus.walleij@linaro.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [linux-stable-rc:queue/5.17 638/1505]
 drivers/net/dsa/realtek/realtek-smi-core.c:494:34: warning: unused variable
 'realtek_smi_of_match'
Message-ID: <202204121538.1pGOoGfb-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
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

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git queue/5.17
head:   22fa848c25c536c9ec7b151d56caa65b3e5b8b68
commit: b0cbd13db467ef03b28297d3effb6b726c0dcba8 [638/1505] net: dsa: realtek-smi: move to subdirectory
config: x86_64-randconfig-r033-20220411 (https://download.01.org/0day-ci/archive/20220412/202204121538.1pGOoGfb-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project fe2478d44e4f7f191c43fef629ac7a23d0251e72)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git/commit/?id=b0cbd13db467ef03b28297d3effb6b726c0dcba8
        git remote add linux-stable-rc https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
        git fetch --no-tags linux-stable-rc queue/5.17
        git checkout b0cbd13db467ef03b28297d3effb6b726c0dcba8
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash drivers/net/dsa/realtek/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/net/dsa/realtek/realtek-smi-core.c:494:34: warning: unused variable 'realtek_smi_of_match' [-Wunused-const-variable]
   static const struct of_device_id realtek_smi_of_match[] = {
                                    ^
   1 warning generated.


vim +/realtek_smi_of_match +494 drivers/net/dsa/realtek/realtek-smi-core.c

0650bf52b31ff3 drivers/net/dsa/realtek-smi-core.c Vladimir Oltean 2021-09-17  493  
d8652956cf37c5 drivers/net/dsa/realtek-smi.c      Linus Walleij   2018-07-14 @494  static const struct of_device_id realtek_smi_of_match[] = {
d8652956cf37c5 drivers/net/dsa/realtek-smi.c      Linus Walleij   2018-07-14  495  	{
d8652956cf37c5 drivers/net/dsa/realtek-smi.c      Linus Walleij   2018-07-14  496  		.compatible = "realtek,rtl8366rb",
d8652956cf37c5 drivers/net/dsa/realtek-smi.c      Linus Walleij   2018-07-14  497  		.data = &rtl8366rb_variant,
d8652956cf37c5 drivers/net/dsa/realtek-smi.c      Linus Walleij   2018-07-14  498  	},
d8652956cf37c5 drivers/net/dsa/realtek-smi.c      Linus Walleij   2018-07-14  499  	{
d8652956cf37c5 drivers/net/dsa/realtek-smi.c      Linus Walleij   2018-07-14  500  		/* FIXME: add support for RTL8366S and more */
d8652956cf37c5 drivers/net/dsa/realtek-smi.c      Linus Walleij   2018-07-14  501  		.compatible = "realtek,rtl8366s",
d8652956cf37c5 drivers/net/dsa/realtek-smi.c      Linus Walleij   2018-07-14  502  		.data = NULL,
d8652956cf37c5 drivers/net/dsa/realtek-smi.c      Linus Walleij   2018-07-14  503  	},
4af2950c50c863 drivers/net/dsa/realtek-smi-core.c Alvin Šipraga   2021-10-18  504  	{
4af2950c50c863 drivers/net/dsa/realtek-smi-core.c Alvin Šipraga   2021-10-18  505  		.compatible = "realtek,rtl8365mb",
4af2950c50c863 drivers/net/dsa/realtek-smi-core.c Alvin Šipraga   2021-10-18  506  		.data = &rtl8365mb_variant,
4af2950c50c863 drivers/net/dsa/realtek-smi-core.c Alvin Šipraga   2021-10-18  507  	},
d8652956cf37c5 drivers/net/dsa/realtek-smi.c      Linus Walleij   2018-07-14  508  	{ /* sentinel */ },
d8652956cf37c5 drivers/net/dsa/realtek-smi.c      Linus Walleij   2018-07-14  509  };
d8652956cf37c5 drivers/net/dsa/realtek-smi.c      Linus Walleij   2018-07-14  510  MODULE_DEVICE_TABLE(of, realtek_smi_of_match);
d8652956cf37c5 drivers/net/dsa/realtek-smi.c      Linus Walleij   2018-07-14  511  

:::::: The code at line 494 was first introduced by commit
:::::: d8652956cf37c5caa8c19e0b99ce5ca235c6d5de net: dsa: realtek-smi: Add Realtek SMI driver

:::::: TO: Linus Walleij <linus.walleij@linaro.org>
:::::: CC: David S. Miller <davem@davemloft.net>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
