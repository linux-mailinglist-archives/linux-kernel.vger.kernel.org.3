Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C71F4C20EE
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 02:30:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229487AbiBXBa1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 20:30:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbiBXBaZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 20:30:25 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EFCD21DF16
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 17:29:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645666191; x=1677202191;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=QvnE9BwdXoW24hJK9PB/iH3BAXPdjZitAQ4ovburPWo=;
  b=Vz40EW+24eeiHrNKyM1kjdE3YlJ/E9+maRVp1h3e27xj/V3+PboGTETE
   jEaN4X+yOG/ftUbpKvd+q3QsuEiQTn21yCL2D7L/0dKbpH21qEyU71ytp
   dumqvIvcBej00V1bII+0gphnizavFW4PQq8umg5slCQ5alHZuE6QwNDDQ
   WQxnVIXUhU919/BArREPAyKj4HxFGhEH8uBL3Q8u8tmCi6o+IjFn+YL0S
   9BsI/r08gGNywuO+gCaQ+xF/T/++O0sBalApyKy88iCIrtla6PI/ZATlS
   RRkmDIJ5QS+8d3wenSlMbINopZgbt8NAKmdLFCQB3d8P5F7OkjADcnT12
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10267"; a="276744619"
X-IronPort-AV: E=Sophos;i="5.88,392,1635231600"; 
   d="scan'208";a="276744619"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2022 17:06:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,392,1635231600"; 
   d="scan'208";a="776882266"
Received: from lkp-server01.sh.intel.com (HELO 788b1cd46f0d) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 23 Feb 2022 17:06:55 -0800
Received: from kbuild by 788b1cd46f0d with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nN2as-00023I-4S; Thu, 24 Feb 2022 01:06:54 +0000
Date:   Thu, 24 Feb 2022 09:06:36 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [mingo-tip:sched/headers 1767/2340]
 arch/mips/lantiq/xway/dma.c:284:34: error: array type has incomplete element
 type 'struct of_device_id'
Message-ID: <202202240941.VUAMJLNZ-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git sched/headers
head:   97c5eeb4de3ad324ed2a4656b46465299cfd010a
commit: 4d3d857e45b20f83f7a1902118be9158f7e62ef3 [1767/2340] headers/deps: of: Optimize <linux/of_types.h> dependencies
config: mips-xway_defconfig (https://download.01.org/0day-ci/archive/20220224/202202240941.VUAMJLNZ-lkp@intel.com/config)
compiler: mips-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git/commit/?id=4d3d857e45b20f83f7a1902118be9158f7e62ef3
        git remote add mingo-tip git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git
        git fetch --no-tags mingo-tip sched/headers
        git checkout 4d3d857e45b20f83f7a1902118be9158f7e62ef3
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=mips SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> arch/mips/lantiq/xway/dma.c:284:34: error: array type has incomplete element type 'struct of_device_id'
     284 | static const struct of_device_id dma_match[] = {
         |                                  ^~~~~~~~~
   arch/mips/lantiq/xway/dma.c:298:1: warning: no previous prototype for 'dma_init' [-Wmissing-prototypes]
     298 | dma_init(void)
         | ^~~~~~~~
   arch/mips/lantiq/xway/dma.c:284:34: warning: 'dma_match' defined but not used [-Wunused-variable]
     284 | static const struct of_device_id dma_match[] = {
         |                                  ^~~~~~~~~


vim +284 arch/mips/lantiq/xway/dma.c

dfec1a827d2bdc John Crispin 2011-05-06  283  
ddd4eeca961cc6 John Crispin 2012-04-12 @284  static const struct of_device_id dma_match[] = {
ddd4eeca961cc6 John Crispin 2012-04-12  285  	{ .compatible = "lantiq,dma-xway" },
ddd4eeca961cc6 John Crispin 2012-04-12  286  	{},
ddd4eeca961cc6 John Crispin 2012-04-12  287  };
ddd4eeca961cc6 John Crispin 2012-04-12  288  

:::::: The code at line 284 was first introduced by commit
:::::: ddd4eeca961cc6b1d57e0ca2f264403d690b6882 MIPS: lantiq: convert dma to platform driver

:::::: TO: John Crispin <blogic@openwrt.org>
:::::: CC: Ralf Baechle <ralf@linux-mips.org>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
