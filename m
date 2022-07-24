Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8CC857F381
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Jul 2022 08:52:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233273AbiGXGvz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Jul 2022 02:51:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbiGXGvx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jul 2022 02:51:53 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A46A613FAE;
        Sat, 23 Jul 2022 23:51:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658645512; x=1690181512;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=2NUyPhN/UYQQ9M7d6K0Zy/ra6kwOYG5LKXH/GneiZ18=;
  b=jh4Pnm1VXxyckYNMq1EsJDMWo1Kn8cI42jCWFoH5I24CMStyxhrU1VWR
   Ns5+YZsDkdAxrX45fh305JIq3MllyewolWFUBSChWVRkLvzPP5slI72Wz
   Ws5hLx3o59ZQLdcQV03cI9BU7dQQy54zy+RRTMwPmTChkT5qyczwz2iAZ
   HslM88lJIRlL+36SjRZ6R1r8h4bK9sjYo6id8DrBpHCaTYXAzoz8hwWUl
   6Ept3A7HFNyEVWs2/4HjNF9FAQedM/NiDvFqgaToO35erwEKyhGcdywOt
   9+9Qtk4QNukFBF8sz+uSe+jf1c88ogeDWNpnYhPSQABF5qa/xbqwLH9B7
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10417"; a="286279761"
X-IronPort-AV: E=Sophos;i="5.93,190,1654585200"; 
   d="scan'208";a="286279761"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2022 23:51:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,190,1654585200"; 
   d="scan'208";a="926512947"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 23 Jul 2022 23:51:43 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oFVSo-0003eT-2m;
        Sun, 24 Jul 2022 06:51:42 +0000
Date:   Sun, 24 Jul 2022 14:51:03 +0800
From:   kernel test robot <lkp@intel.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org
Subject: drivers/media/platform/intel/pxa_camera.c:2449:34: warning: unused
 variable 'pxa_camera_of_match'
Message-ID: <202207241411.UTTuvBZG-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mauro,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   515f71412bb73ebd7f41f90e1684fc80b8730789
commit: 95495f2aa9d8df1a7697bab24118544d3568f41d media: platform: place Intel drivers on a separate dir
date:   4 months ago
config: hexagon-randconfig-r035-20220724 (https://download.01.org/0day-ci/archive/20220724/202207241411.UTTuvBZG-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 12fbd2d377e396ad61bce56d71c98a1eb1bebfa9)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=95495f2aa9d8df1a7697bab24118544d3568f41d
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 95495f2aa9d8df1a7697bab24118544d3568f41d
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=hexagon SHELL=/bin/bash drivers/media/platform/intel/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/media/platform/intel/pxa_camera.c:2449:34: warning: unused variable 'pxa_camera_of_match' [-Wunused-const-variable]
   static const struct of_device_id pxa_camera_of_match[] = {
                                    ^
   1 warning generated.


vim +/pxa_camera_of_match +2449 drivers/media/platform/intel/pxa_camera.c

7254026cedd42d drivers/media/video/pxa_camera.c               Guennadi Liakhovetski 2011-06-29  2448  
e9a1d94fa85542 drivers/media/platform/soc_camera/pxa_camera.c Robert Jarzmik        2014-06-29 @2449  static const struct of_device_id pxa_camera_of_match[] = {
e9a1d94fa85542 drivers/media/platform/soc_camera/pxa_camera.c Robert Jarzmik        2014-06-29  2450  	{ .compatible = "marvell,pxa270-qci", },
e9a1d94fa85542 drivers/media/platform/soc_camera/pxa_camera.c Robert Jarzmik        2014-06-29  2451  	{},
e9a1d94fa85542 drivers/media/platform/soc_camera/pxa_camera.c Robert Jarzmik        2014-06-29  2452  };
e9a1d94fa85542 drivers/media/platform/soc_camera/pxa_camera.c Robert Jarzmik        2014-06-29  2453  MODULE_DEVICE_TABLE(of, pxa_camera_of_match);
e9a1d94fa85542 drivers/media/platform/soc_camera/pxa_camera.c Robert Jarzmik        2014-06-29  2454  

:::::: The code at line 2449 was first introduced by commit
:::::: e9a1d94fa85542d4f3046ac82d234a3c8349c948 [media] media: pxa_camera device-tree support

:::::: TO: Robert Jarzmik <robert.jarzmik@free.fr>
:::::: CC: Mauro Carvalho Chehab <m.chehab@samsung.com>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
