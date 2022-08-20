Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 342DB59AF43
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Aug 2022 19:50:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346845AbiHTRqL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Aug 2022 13:46:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231989AbiHTRqJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Aug 2022 13:46:09 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87D9A18348
        for <linux-kernel@vger.kernel.org>; Sat, 20 Aug 2022 10:46:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661017568; x=1692553568;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=V3xUB0G5MWjahGbivjTSWkBh5oriy0+L2gJc/1Oo45s=;
  b=DIXe3+UPpVCiOK3BmYeOE7bOi6syAK431fb/METAo2QpfPdxu3iNd26Q
   q+eL2cRU16lt5N1mUSlnU5JlBSlOQ/eyuu/rXo5gjm/JTbm4RoHIGHZvv
   Es0jvfvqgG+j9UrYTzIV7Kw8mE/MLDHwPxOwK5824KDBgRWf/JlPpcoP4
   T4kTZ9votO6tB3VB3vRO3C+KybF6u+ROVNvTXP2IMWCpJjfKw+F89mZ7I
   6cyIeSXQ8zN4QqN8BlDo2wubuOjbeOHG9Map1Ef0rUqQmESQApbJWOdTJ
   Qxdu2174nIwwPiNLcmDnDWyoBf++eZzKQOipffFisFA4z41WuSxmenCvX
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10445"; a="357173233"
X-IronPort-AV: E=Sophos;i="5.93,251,1654585200"; 
   d="scan'208";a="357173233"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2022 10:46:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,251,1654585200"; 
   d="scan'208";a="936551586"
Received: from lkp-server01.sh.intel.com (HELO 44b6dac04a33) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 20 Aug 2022 10:46:06 -0700
Received: from kbuild by 44b6dac04a33 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oPSXu-0002ym-15;
        Sat, 20 Aug 2022 17:46:06 +0000
Date:   Sun, 21 Aug 2022 01:45:31 +0800
From:   kernel test robot <lkp@intel.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: drivers/watchdog/sa1100_wdt.c:241:24: sparse: sparse: symbol
 'sa1100dog_driver' was not declared. Should it be static?
Message-ID: <202208210136.zAPBCMxF-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   50cd95ac46548429e5bba7ca75cc97d11a697947
commit: e86bd43bcfc579cf8935c1913e92cb76b4ba81c2 watchdog: sa1100: use platform device registration
date:   4 months ago
config: arm-randconfig-s052-20220820 (https://download.01.org/0day-ci/archive/20220821/202208210136.zAPBCMxF-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 12.1.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-39-gce1a6720-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=e86bd43bcfc579cf8935c1913e92cb76b4ba81c2
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout e86bd43bcfc579cf8935c1913e92cb76b4ba81c2
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=arm SHELL=/bin/bash drivers/watchdog/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

sparse warnings: (new ones prefixed by >>)
>> drivers/watchdog/sa1100_wdt.c:241:24: sparse: sparse: symbol 'sa1100dog_driver' was not declared. Should it be static?

vim +/sa1100dog_driver +241 drivers/watchdog/sa1100_wdt.c

   240	
 > 241	struct platform_driver sa1100dog_driver = {
   242		.driver.name = "sa1100_wdt",
   243		.probe	  = sa1100dog_probe,
   244		.remove	  = sa1100dog_remove,
   245	};
   246	module_platform_driver(sa1100dog_driver);
   247	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
