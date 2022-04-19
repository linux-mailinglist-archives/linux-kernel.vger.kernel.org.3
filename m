Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BB34506194
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 03:12:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244963AbiDSBOy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 21:14:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242136AbiDSBOw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 21:14:52 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D28A2D1E2
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 18:12:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650330731; x=1681866731;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=c+5pP6ms2AI/MslPa1DFe2iZIwSwe0a7F3q89IjGaQY=;
  b=Vxoj3E24wq4KYsDNJcTa3nsLllGYesB4bTneTwkV0p0mLyrBnutdkcy0
   k/DE/OWh6HXwWmuzBj7xoOaNmkjHoCKdIlfnaOMkuc/0w/t/6PW3J2Gab
   JFvzjFlFeKFqNm6OR3q2DlPkmFuEXnY9+64ab8YPVnxXO6Q6bmDBF0DNM
   kxRI7iEAEw5CJiBHFpBN60Fbm9yd9h3URs8V2ZiLTPRCLYgmu6PE/2FIe
   ttX+ZZ4R4uc6TA95xaPwCobW3CBvbP0jxYu7fcLkLrWrWtL6OjJaEQ5gi
   3Kfw8JmehAkZnr+Mmj03FgN8Y3005wyzbOihLgrVTtkVxNoIkBKZXM2lw
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10321"; a="326546210"
X-IronPort-AV: E=Sophos;i="5.90,271,1643702400"; 
   d="scan'208";a="326546210"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2022 18:12:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,271,1643702400"; 
   d="scan'208";a="726858734"
Received: from lkp-server01.sh.intel.com (HELO 3abc53900bec) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 18 Apr 2022 18:12:09 -0700
Received: from kbuild by 3abc53900bec with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1ngcPY-00059M-Ot;
        Tue, 19 Apr 2022 01:12:08 +0000
Date:   Tue, 19 Apr 2022 09:11:55 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [mingo-tip:sched/headers 1541/2356]
 drivers/input/touchscreen/imagis.c:358:21: warning: incompatible integer to
 pointer conversion initializing 'const struct of_device_id *' with an
 expression of type 'int'
Message-ID: <202204190945.vfrBnN8A-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git sched/headers
head:   af93551cf39027d176f30b9beafc60a4c130998a
commit: 63245bf3e0db1d416f39a3ccb1311f94f37697f5 [1541/2356] headers/deps: i2c: Optimize <linux/i2c.h> header dependencies
config: i386-randconfig-a015-20220418 (https://download.01.org/0day-ci/archive/20220419/202204190945.vfrBnN8A-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 429cbac0390654f90bba18a41799464adf31a5ec)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git/commit/?id=63245bf3e0db1d416f39a3ccb1311f94f37697f5
        git remote add mingo-tip git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git
        git fetch --no-tags mingo-tip sched/headers
        git checkout 63245bf3e0db1d416f39a3ccb1311f94f37697f5
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash drivers/block/ drivers/clk/ drivers/iio/accel/ drivers/infiniband/core/ drivers/infiniband/ulp/ipoib/ drivers/input/touchscreen/ drivers/mmc/host/ drivers/net/dsa/ drivers/nvdimm/ drivers/powercap/ drivers/usb/typec/ init/ mm/damon/ net/dsa/ net/smc/ sound/soc/codecs/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   drivers/input/touchscreen/imagis.c:358:21: error: implicit declaration of function 'of_match_ptr' is invalid in C99 [-Werror,-Wimplicit-function-declaration]
                   .of_match_table = of_match_ptr(imagis_of_match),
                                     ^
>> drivers/input/touchscreen/imagis.c:358:21: warning: incompatible integer to pointer conversion initializing 'const struct of_device_id *' with an expression of type 'int' [-Wint-conversion]
                   .of_match_table = of_match_ptr(imagis_of_match),
                                     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/input/touchscreen/imagis.c:358:21: error: initializer element is not a compile-time constant
                   .of_match_table = of_match_ptr(imagis_of_match),
                                     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   1 warning and 2 errors generated.


vim +358 drivers/input/touchscreen/imagis.c

a23ba3c043db9a Markuss Broks 2022-03-14  353  
a23ba3c043db9a Markuss Broks 2022-03-14  354  static struct i2c_driver imagis_ts_driver = {
a23ba3c043db9a Markuss Broks 2022-03-14  355  	.driver = {
a23ba3c043db9a Markuss Broks 2022-03-14  356  		.name = "imagis-touchscreen",
a23ba3c043db9a Markuss Broks 2022-03-14  357  		.pm = &imagis_pm_ops,
a23ba3c043db9a Markuss Broks 2022-03-14 @358  		.of_match_table = of_match_ptr(imagis_of_match),
a23ba3c043db9a Markuss Broks 2022-03-14  359  	},
a23ba3c043db9a Markuss Broks 2022-03-14  360  	.probe_new = imagis_probe,
a23ba3c043db9a Markuss Broks 2022-03-14  361  };
a23ba3c043db9a Markuss Broks 2022-03-14  362  

:::::: The code at line 358 was first introduced by commit
:::::: a23ba3c043db9a2e8c967a3ff66dcedc5725afdf Input: add Imagis touchscreen driver

:::::: TO: Markuss Broks <markuss.broks@gmail.com>
:::::: CC: Dmitry Torokhov <dmitry.torokhov@gmail.com>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
