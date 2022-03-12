Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A98624D6FF5
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Mar 2022 17:11:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232081AbiCLQMl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Mar 2022 11:12:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbiCLQMj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Mar 2022 11:12:39 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 627003B559
        for <linux-kernel@vger.kernel.org>; Sat, 12 Mar 2022 08:11:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647101494; x=1678637494;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=wR47TZkCjWInUPpS9XaWREJqExz7vOG2XpNR4g+vJZo=;
  b=gv0Ydv0KHCczoiC1HkF1xTsvz6TW1kJrSSGfRnND9XgZZStw1DByxUi8
   59OjZcEq8EfTDW2dD0JECKNbLIBFErIBqERhxXxF3lJhGf86MzoBqUQTv
   ZYwjQkF/Yl6ZAL3p3CiTrCX/Y1f0zxjQIyWVxTctbb4K0EivN/0rVdIOJ
   wDiBmwcyNqLZcvpD6olr11nsrQj5aerpSGkJHMnR181EZnossAmXgj6Xt
   JoKBvvg+npidaM1NNDL6tA8b0f1mSXRVSWvPh/PNam7n/XF59ZyBv+drf
   L4f9PqeE05anhp4woE051+OfRWXbY2WzdU/LUgLDcMHNoMVTntL9eK8/b
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10284"; a="280552223"
X-IronPort-AV: E=Sophos;i="5.90,175,1643702400"; 
   d="scan'208";a="280552223"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2022 08:11:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,175,1643702400"; 
   d="scan'208";a="514898630"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 12 Mar 2022 08:11:32 -0800
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nT4L5-00082R-PR; Sat, 12 Mar 2022 16:11:31 +0000
Date:   Sun, 13 Mar 2022 00:11:01 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [rmk-arm:zii 128/199] drivers/net/dsa/mv88e6xxx/serdes.c:1343:3:
 warning: variable 'reg' is uninitialized when used here
Message-ID: <202203130000.24KypUX4-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://git.armlinux.org.uk/~rmk/linux-arm zii
head:   22f6fd6865d54d3632278e7f17bad52308e50311
commit: b222c2366f2aacc7b0b55d6fa78e903293aa9eaa [128/199] net: dsa: mv88e6xxx: provide and use mv88e6390_serdes_modify()
config: i386-randconfig-a013 (https://download.01.org/0day-ci/archive/20220313/202203130000.24KypUX4-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 43f668b98e8d87290fc6bbf5ed13c3ab542e3497)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git remote add rmk-arm git://git.armlinux.org.uk/~rmk/linux-arm
        git fetch --no-tags rmk-arm zii
        git checkout b222c2366f2aacc7b0b55d6fa78e903293aa9eaa
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash drivers/net/dsa/mv88e6xxx/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/net/dsa/mv88e6xxx/serdes.c:1343:3: warning: variable 'reg' is uninitialized when used here [-Wuninitialized]
                   reg |= MV88E6393X_SERDES_CTRL1_TX_PDOWN |
                   ^~~
   drivers/net/dsa/mv88e6xxx/serdes.c:1338:9: note: initialize the variable 'reg' to silence this warning
           u16 reg;
                  ^
                   = 0
   1 warning generated.


vim +/reg +1343 drivers/net/dsa/mv88e6xxx/serdes.c

de776d0d316f72 Pavana Sharma         2021-03-17  1334  
7527d66260ac0c Marek Behún           2021-11-30  1335  static int mv88e6393x_serdes_power_lane(struct mv88e6xxx_chip *chip, int lane,
7527d66260ac0c Marek Behún           2021-11-30  1336  					bool on)
7527d66260ac0c Marek Behún           2021-11-30  1337  {
7527d66260ac0c Marek Behún           2021-11-30  1338  	u16 reg;
7527d66260ac0c Marek Behún           2021-11-30  1339  
7527d66260ac0c Marek Behún           2021-11-30  1340  	if (on)
b222c2366f2aac Russell King (Oracle  2022-03-08  1341) 		reg = 0;
7527d66260ac0c Marek Behún           2021-11-30  1342  	else
7527d66260ac0c Marek Behún           2021-11-30 @1343  		reg |= MV88E6393X_SERDES_CTRL1_TX_PDOWN |
7527d66260ac0c Marek Behún           2021-11-30  1344  		       MV88E6393X_SERDES_CTRL1_RX_PDOWN;
7527d66260ac0c Marek Behún           2021-11-30  1345  
b222c2366f2aac Russell King (Oracle  2022-03-08  1346) 	return mv88e6390_serdes_modify(chip, lane, MDIO_MMD_PHYXS,
b222c2366f2aac Russell King (Oracle  2022-03-08  1347) 				       MV88E6393X_SERDES_CTRL1,
b222c2366f2aac Russell King (Oracle  2022-03-08  1348) 				       MV88E6393X_SERDES_CTRL1_TX_PDOWN |
b222c2366f2aac Russell King (Oracle  2022-03-08  1349) 				       MV88E6393X_SERDES_CTRL1_RX_PDOWN, reg);
7527d66260ac0c Marek Behún           2021-11-30  1350  }
7527d66260ac0c Marek Behún           2021-11-30  1351  

:::::: The code at line 1343 was first introduced by commit
:::::: 7527d66260ac0c603c6baca5146748061fcddbd6 net: dsa: mv88e6xxx: Save power by disabling SerDes trasmitter and receiver

:::::: TO: Marek Behún <kabel@kernel.org>
:::::: CC: David S. Miller <davem@davemloft.net>

---
0-DAY CI Kernel Test Service
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
