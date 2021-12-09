Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CC2246E740
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 12:07:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236400AbhLILLA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 06:11:00 -0500
Received: from mga18.intel.com ([134.134.136.126]:11248 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236371AbhLILK7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 06:10:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639048046; x=1670584046;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=+pNm7LpSapzSHjAl7xGc+T/u8eNQs01fQUKoECN/oJk=;
  b=Ly53WCToYicGCEVTKn6RKqWB5tzPPIaKHQp89cj3DbifXTdx1JcIHvVK
   Wmk66DnMG6cJwDH13+n5FCuMQhXZk1qz5M8iPlWW2n54FEPBngPF5NOlW
   RVM57nUPiTgG3cUDtEBsUZh+lV0Ex9dfeETZxpH2faehkuS34yT+Kkx4w
   dkBlToNE7a22MAMSrxlvrjqIlOqQMoeTVbIRK8+yP7GuxleomhzDrsQpO
   eK1uT03MlD9jKlvCsTv5u2MqtZmKGr6+Dj/oGF5zSw7+k6t1Y/ubeZdxR
   bXywXo7+CmUa+EweMsrDD8ye5GK5uGffOzZJSQF/EdLjsbk2wTxULSSvd
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10192"; a="224943889"
X-IronPort-AV: E=Sophos;i="5.88,192,1635231600"; 
   d="scan'208";a="224943889"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2021 03:07:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,192,1635231600"; 
   d="scan'208";a="462091695"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 09 Dec 2021 03:07:23 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mvHGk-0001pB-QG; Thu, 09 Dec 2021 11:07:22 +0000
Date:   Thu, 9 Dec 2021 19:06:48 +0800
From:   kernel test robot <lkp@intel.com>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>
Subject: drivers/spi/spi-sh-msiof.c:1072:34: warning: unused variable
 'sh_msiof_match'
Message-ID: <202112091948.lD9JYOeh-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   2a987e65025e2b79c6d453b78cb5985ac6e5eb26
commit: bbd7ffdbef6888459f301c5889f3b14ada38b913 clk: Allow the common clk framework to be selectable
date:   1 year, 7 months ago
config: hexagon-buildonly-randconfig-r003-20211209 (https://download.01.org/0day-ci/archive/20211209/202112091948.lD9JYOeh-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project 097a1cb1d5ebb3a0ec4bcaed8ba3ff6a8e33c00a)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=bbd7ffdbef6888459f301c5889f3b14ada38b913
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout bbd7ffdbef6888459f301c5889f3b14ada38b913
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=hexagon SHELL=/bin/bash drivers/mmc/host/ drivers/spi/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/spi/spi-sh-msiof.c:1072:34: warning: unused variable 'sh_msiof_match' [-Wunused-const-variable]
   static const struct of_device_id sh_msiof_match[] = {
                                    ^
   1 warning generated.


vim +/sh_msiof_match +1072 drivers/spi/spi-sh-msiof.c

50a7e23f536779 Geert Uytterhoeven 2014-02-25  1071  
50a7e23f536779 Geert Uytterhoeven 2014-02-25 @1072  static const struct of_device_id sh_msiof_match[] = {
50a7e23f536779 Geert Uytterhoeven 2014-02-25  1073  	{ .compatible = "renesas,sh-mobile-msiof", .data = &sh_data },
bdacfc7b6216dd Fabrizio Castro    2017-09-25  1074  	{ .compatible = "renesas,msiof-r8a7743",   .data = &rcar_gen2_data },
bdacfc7b6216dd Fabrizio Castro    2017-09-25  1075  	{ .compatible = "renesas,msiof-r8a7745",   .data = &rcar_gen2_data },
61a8dec502b873 Geert Uytterhoeven 2017-07-12  1076  	{ .compatible = "renesas,msiof-r8a7790",   .data = &rcar_gen2_data },
61a8dec502b873 Geert Uytterhoeven 2017-07-12  1077  	{ .compatible = "renesas,msiof-r8a7791",   .data = &rcar_gen2_data },
61a8dec502b873 Geert Uytterhoeven 2017-07-12  1078  	{ .compatible = "renesas,msiof-r8a7792",   .data = &rcar_gen2_data },
61a8dec502b873 Geert Uytterhoeven 2017-07-12  1079  	{ .compatible = "renesas,msiof-r8a7793",   .data = &rcar_gen2_data },
61a8dec502b873 Geert Uytterhoeven 2017-07-12  1080  	{ .compatible = "renesas,msiof-r8a7794",   .data = &rcar_gen2_data },
61a8dec502b873 Geert Uytterhoeven 2017-07-12  1081  	{ .compatible = "renesas,rcar-gen2-msiof", .data = &rcar_gen2_data },
61a8dec502b873 Geert Uytterhoeven 2017-07-12  1082  	{ .compatible = "renesas,msiof-r8a7796",   .data = &rcar_gen3_data },
61a8dec502b873 Geert Uytterhoeven 2017-07-12  1083  	{ .compatible = "renesas,rcar-gen3-msiof", .data = &rcar_gen3_data },
264c3e8de4fbda Simon Horman       2016-12-20  1084  	{ .compatible = "renesas,sh-msiof",        .data = &sh_data }, /* Deprecated */
50a7e23f536779 Geert Uytterhoeven 2014-02-25  1085  	{},
50a7e23f536779 Geert Uytterhoeven 2014-02-25  1086  };
50a7e23f536779 Geert Uytterhoeven 2014-02-25  1087  MODULE_DEVICE_TABLE(of, sh_msiof_match);
50a7e23f536779 Geert Uytterhoeven 2014-02-25  1088  

:::::: The code at line 1072 was first introduced by commit
:::::: 50a7e23f53677918bf521b09ce9bb20fb87cd175 spi: sh-msiof: Move default FIFO sizes to device ID data

:::::: TO: Geert Uytterhoeven <geert+renesas@linux-m68k.org>
:::::: CC: Mark Brown <broonie@linaro.org>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
