Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0F6953D65D
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Jun 2022 12:10:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234547AbiFDKKe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Jun 2022 06:10:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230482AbiFDKKb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jun 2022 06:10:31 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A1F617A9A
        for <linux-kernel@vger.kernel.org>; Sat,  4 Jun 2022 03:10:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654337431; x=1685873431;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=5haCdPTsgeUARclowhw2ARAP4afuCarRczIaCvDSzTk=;
  b=l/sxgh3M4UJOqHw0hNSJYNDOeoN04HKG6j4e8LnWKdn/fmZ9iVY8PdcG
   o76i3FBYS1udfX3ETpYCHy+q1gYZ8Fse8DmY72qYGP9IGAaWJRmRORBjc
   C2mL0aRmb4XqQncffUl7m1/ExyXDD2rWitgaT+lDB9xqjibl5YzPXGO+x
   ZNfsB5hmY9lE6z+5HtXoPcK1PMCStwFLBuELloaZZfTtoV7um5YDaMVAJ
   Kkqv/Zz8WFr+NPzn+n8OXeH7jbabJNwuXJGD+McE3oJzSEPXANnMwhJG5
   XtXv0mz3ksdRH0N+ZYELIOf6QerhOucDUBzT2z7QRZ7EGRBHKle4bo8MP
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10367"; a="301796748"
X-IronPort-AV: E=Sophos;i="5.91,277,1647327600"; 
   d="scan'208";a="301796748"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2022 03:10:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,277,1647327600"; 
   d="scan'208";a="582917709"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 04 Jun 2022 03:10:29 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nxQjl-000AdY-6r;
        Sat, 04 Jun 2022 10:10:29 +0000
Date:   Sat, 4 Jun 2022 18:09:40 +0800
From:   kernel test robot <lkp@intel.com>
To:     Keerthy <j-keerthy@ti.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: drivers/thermal/k3_j72xx_bandgap.c:532:36: sparse: sparse: symbol
 'k3_j72xx_bandgap_j721e_data' was not declared. Should it be static?
Message-ID: <202206041824.svJIkOwb-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   032dcf09e2bf7c822be25b4abef7a6c913870d98
commit: ffcb2fc86eb7ebc9f5524525fb57e1cccfbd1fc0 thermal: k3_j72xx_bandgap: Add the bandgap driver support
date:   2 weeks ago
config: powerpc64-randconfig-s031-20220603 (https://download.01.org/0day-ci/archive/20220604/202206041824.svJIkOwb-lkp@intel.com/config)
compiler: powerpc64-linux-gcc (GCC) 11.3.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-18-g56afb504-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=ffcb2fc86eb7ebc9f5524525fb57e1cccfbd1fc0
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout ffcb2fc86eb7ebc9f5524525fb57e1cccfbd1fc0
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=powerpc SHELL=/bin/bash drivers/thermal/ kernel/debug/kdb/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
>> drivers/thermal/k3_j72xx_bandgap.c:532:36: sparse: sparse: symbol 'k3_j72xx_bandgap_j721e_data' was not declared. Should it be static?
>> drivers/thermal/k3_j72xx_bandgap.c:536:36: sparse: sparse: symbol 'k3_j72xx_bandgap_j7200_data' was not declared. Should it be static?

vim +/k3_j72xx_bandgap_j721e_data +532 drivers/thermal/k3_j72xx_bandgap.c

   531	
 > 532	const struct k3_j72xx_bandgap_data k3_j72xx_bandgap_j721e_data = {
   533		.has_errata_i2128 = 1,
   534	};
   535	
 > 536	const struct k3_j72xx_bandgap_data k3_j72xx_bandgap_j7200_data = {
   537		.has_errata_i2128 = 0,
   538	};
   539	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
