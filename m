Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7F244FBCC0
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 15:06:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229682AbiDKNIx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 09:08:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233939AbiDKNIs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 09:08:48 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFF552C11A;
        Mon, 11 Apr 2022 06:06:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649682394; x=1681218394;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=G48YFPLPhxeYJHK7qa1GRWu7rsF5S8ysdDrLe+CJRjM=;
  b=BKCRxreZ+VtuKj/bcQI0ZKeNpGCq+tKwv0Y21jo5Ony50O/0mMO9Eu7q
   zLX9yzlRrjJBvS4udiXkUjWiJKAqc1bK6I1dZdeBK3NS6GHSquFX1xzlz
   1IE61c+bvo5/xJapmfD0ewg+2/+WdWoVPHEv5OFFKHZy04SVbxc05Vr0t
   K/azzWo+gjPwVMgm0l7piDDLsVZMLEIicNOsVW9fqwVa1ai5IwLmPGzCc
   sB+JepWxFhvgTbNvvpw2WFlvzztMF1EGkmwdg3JbV5OG/4CbQKmXxWCEk
   nW6rXQ11hPCri/1wPXPEnPMINpgk/ZTgsrWFCEoqLOWzCeUXdM9lA7cLB
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10313"; a="243994341"
X-IronPort-AV: E=Sophos;i="5.90,251,1643702400"; 
   d="scan'208";a="243994341"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2022 06:06:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,251,1643702400"; 
   d="scan'208";a="589871491"
Received: from lkp-server02.sh.intel.com (HELO d3fc50ef50de) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 11 Apr 2022 06:06:08 -0700
Received: from kbuild by d3fc50ef50de with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1ndtk7-0001rf-Tg;
        Mon, 11 Apr 2022 13:06:07 +0000
Date:   Mon, 11 Apr 2022 21:05:11 +0800
From:   kernel test robot <lkp@intel.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org
Subject: drivers/media/platform/marvell/mmp-driver.c:364:34: warning: unused
 variable 'mmpcam_of_match'
Message-ID: <202204112131.girigduB-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mauro,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   ce522ba9ef7e2d9fb22a39eb3371c0c64e2a433e
commit: dc7bbea90075b57772e9a28043061bf71d96f06f media: platform: rename marvell-ccic/ to marvell/
date:   3 weeks ago
config: hexagon-randconfig-r012-20220411 (https://download.01.org/0day-ci/archive/20220411/202204112131.girigduB-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project c6e83f560f06cdfe8aa47b248d8bdc58f947274b)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=dc7bbea90075b57772e9a28043061bf71d96f06f
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout dc7bbea90075b57772e9a28043061bf71d96f06f
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=hexagon SHELL=/bin/bash drivers/media/platform/marvell/

If you fix the issue, kindly add following tag as appropriate
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
