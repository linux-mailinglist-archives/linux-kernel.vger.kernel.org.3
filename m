Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF76F591F92
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Aug 2022 12:36:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235958AbiHNKfz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Aug 2022 06:35:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229723AbiHNKfx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Aug 2022 06:35:53 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5653755BD
        for <linux-kernel@vger.kernel.org>; Sun, 14 Aug 2022 03:35:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660473352; x=1692009352;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=DxTsXDQ4bAkgR4XGW5jrW5c2qAfNm0N7R3mscA0spsg=;
  b=ENsxiQrzNDmEnBcX8s8pVb6I/wRZC/8xJkuRgL3XfiPh55DAX0BKXKic
   u5iwA0NDY9NSZt5/HOfOzFC4EcgxeB1QlCItKckGwhxQXpY8iKllRvdEM
   rns9R8Ovk5DE6aUiI7n5JzOKnNm5dgq9QyawljQTlcKOnuWr4eQa9m6ed
   KpanAOw5sLbXq4mhEShMdQiGVGQ/6gNbC+xJI5DxN1BR7pKnTujySsWEb
   Mg9S+PC/0y4Y5GxH9aM/ddMfJCLFtkRlcN1q+a7drWWNV78kQ3OIkSVq7
   IODNIZH828fUAH+0ZlfgplgVdSxGpq3dUlvGr0DdX1O3OVard1pgMNpPp
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10437"; a="289384581"
X-IronPort-AV: E=Sophos;i="5.93,236,1654585200"; 
   d="scan'208";a="289384581"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2022 03:35:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,236,1654585200"; 
   d="scan'208";a="934190854"
Received: from lkp-server02.sh.intel.com (HELO 8745164cafc7) ([10.239.97.151])
  by fmsmga005.fm.intel.com with ESMTP; 14 Aug 2022 03:35:49 -0700
Received: from kbuild by 8745164cafc7 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oNAyD-0002kz-15;
        Sun, 14 Aug 2022 10:35:49 +0000
Date:   Sun, 14 Aug 2022 18:35:31 +0800
From:   kernel test robot <lkp@intel.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: arch/arm/mach-omap1/serial.c:236:12: warning: no previous prototype
 for 'omap_serial_wakeup_init'
Message-ID: <202208141805.XynGMwka-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   aea23e7c464bfdec04b52cf61edb62030e9e0d0a
commit: 8c1fb11b8a77dc489a8ef6d96c38c1297b629d06 ARM: s3c: enable s3c24xx multiplatform support
date:   4 months ago
config: arm-randconfig-r006-20220805 (https://download.01.org/0day-ci/archive/20220814/202208141805.XynGMwka-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=8c1fb11b8a77dc489a8ef6d96c38c1297b629d06
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 8c1fb11b8a77dc489a8ef6d96c38c1297b629d06
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> arch/arm/mach-omap1/serial.c:236:12: warning: no previous prototype for 'omap_serial_wakeup_init' [-Wmissing-prototypes]
     236 | int __init omap_serial_wakeup_init(void)
         |            ^~~~~~~~~~~~~~~~~~~~~~~


vim +/omap_serial_wakeup_init +236 arch/arm/mach-omap1/serial.c

7c38cf021b42a4 Tony Lindgren 2005-09-08  235  
82c3bd03535f15 Shawn Guo     2012-04-26 @236  int __init omap_serial_wakeup_init(void)
7c38cf021b42a4 Tony Lindgren 2005-09-08  237  {
7c38cf021b42a4 Tony Lindgren 2005-09-08  238  	if (!cpu_is_omap16xx())
7c38cf021b42a4 Tony Lindgren 2005-09-08  239  		return 0;
7c38cf021b42a4 Tony Lindgren 2005-09-08  240  
7c38cf021b42a4 Tony Lindgren 2005-09-08  241  	if (uart1_ck != NULL)
7c38cf021b42a4 Tony Lindgren 2005-09-08  242  		omap_serial_set_port_wakeup(37);
7c38cf021b42a4 Tony Lindgren 2005-09-08  243  	if (uart2_ck != NULL)
7c38cf021b42a4 Tony Lindgren 2005-09-08  244  		omap_serial_set_port_wakeup(18);
7c38cf021b42a4 Tony Lindgren 2005-09-08  245  	if (uart3_ck != NULL)
7c38cf021b42a4 Tony Lindgren 2005-09-08  246  		omap_serial_set_port_wakeup(49);
7c38cf021b42a4 Tony Lindgren 2005-09-08  247  
7c38cf021b42a4 Tony Lindgren 2005-09-08  248  	return 0;
7c38cf021b42a4 Tony Lindgren 2005-09-08  249  }
7c38cf021b42a4 Tony Lindgren 2005-09-08  250  

:::::: The code at line 236 was first introduced by commit
:::::: 82c3bd03535f1571426fdd19b7d832f76b7ac85e ARM: omap1: use machine specific hook for late init

:::::: TO: Shawn Guo <shawn.guo@linaro.org>
:::::: CC: Shawn Guo <shawn.guo@linaro.org>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
