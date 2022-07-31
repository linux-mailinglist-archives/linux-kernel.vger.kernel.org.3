Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D023A585D10
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Jul 2022 05:26:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236230AbiGaD0R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Jul 2022 23:26:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230454AbiGaD0P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jul 2022 23:26:15 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 093B0FD1B;
        Sat, 30 Jul 2022 20:26:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659237972; x=1690773972;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=IcGL+BIy3WMtB5r7XufZHaujFpvkbpL0Knkjx1giuiU=;
  b=KSCPhIhqhU7Vc9mxBrJMYIrcSDv54HCFkSsKM15NdAcK8/uB4xEQ19VK
   GUdgmGFQc2eeerkf0Gq0Wc5FMyv6jKusB3xTlIaD7NzYJ9MObUiJgIk50
   544jhT83z2eKV3845uwZdZsOzxdkDMh8MS0Xs89kFCVdsbV3Rqvx0w0Qr
   /psn7YrXnef9Wyvq4jBFgKupdnTEYs+pxjJZj9ufyvMgG8LuAImcGtVtj
   Tix1AA+SweW8aUMGUyCCbMvzDqk0cvBuHAQGw0edYvpI6H3BEFLEMik4x
   KtAhD4E40r/ntTj+UdR4MPU5sKicvkGAs+8PmclUA+eAeXkax4MWzNuSg
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10424"; a="275860204"
X-IronPort-AV: E=Sophos;i="5.93,205,1654585200"; 
   d="scan'208";a="275860204"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2022 20:26:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,205,1654585200"; 
   d="scan'208";a="577388396"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 30 Jul 2022 20:26:10 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oHzaj-000Dck-1K;
        Sun, 31 Jul 2022 03:26:09 +0000
Date:   Sun, 31 Jul 2022 11:25:39 +0800
From:   kernel test robot <lkp@intel.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org
Subject: drivers/media/platform/marvell/mmp-driver.c:364:34: warning: unused
 variable 'mmpcam_of_match'
Message-ID: <202207311122.TwtWf9R9-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mauro,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   6a010258447d386186ca10cd374d888ac66ffe1a
commit: dc7bbea90075b57772e9a28043061bf71d96f06f media: platform: rename marvell-ccic/ to marvell/
date:   5 months ago
config: mips-randconfig-r024-20220731 (https://download.01.org/0day-ci/archive/20220731/202207311122.TwtWf9R9-lkp@intel.com/config)
compiler: clang version 16.0.0 (https://github.com/llvm/llvm-project 52cd00cabf479aa7eb6dbb063b7ba41ea57bce9e)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install mips cross compiling tool for clang build
        # apt-get install binutils-mipsel-linux-gnu
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=dc7bbea90075b57772e9a28043061bf71d96f06f
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout dc7bbea90075b57772e9a28043061bf71d96f06f
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=mips SHELL=/bin/bash drivers/media/platform/marvell/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/media/platform/marvell/mmp-driver.c:364:34: warning: unused variable 'mmpcam_of_match' [-Wunused-const-variable]
   static const struct of_device_id mmpcam_of_match[] = {
                                    ^
   1 warning generated.


vim +/mmpcam_of_match +364 drivers/media/platform/marvell/mmp-driver.c

bb0a896e3d5083 drivers/media/video/marvell-ccic/mmp-driver.c    Jonathan Corbet 2011-12-30  363  
83c40e6611ec1e drivers/media/platform/marvell-ccic/mmp-driver.c Lubomir Rintel  2019-05-28 @364  static const struct of_device_id mmpcam_of_match[] = {
83c40e6611ec1e drivers/media/platform/marvell-ccic/mmp-driver.c Lubomir Rintel  2019-05-28  365  	{ .compatible = "marvell,mmp2-ccic", },
83c40e6611ec1e drivers/media/platform/marvell-ccic/mmp-driver.c Lubomir Rintel  2019-05-28  366  	{},
83c40e6611ec1e drivers/media/platform/marvell-ccic/mmp-driver.c Lubomir Rintel  2019-05-28  367  };
08aac0e32fe44b drivers/media/platform/marvell-ccic/mmp-driver.c Lubomir Rintel  2019-07-22  368  MODULE_DEVICE_TABLE(of, mmpcam_of_match);
67a8dbbc4e04cd drivers/media/video/marvell-ccic/mmp-driver.c    Jonathan Corbet 2011-06-11  369  

:::::: The code at line 364 was first introduced by commit
:::::: 83c40e6611ec1e548ece34f6940f516333abc16a media: marvell-ccic/mmp: add devicetree support

:::::: TO: Lubomir Rintel <lkundrak@v3.sk>
:::::: CC: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
