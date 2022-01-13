Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F73848D647
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 12:04:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233869AbiAMLEn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 06:04:43 -0500
Received: from mga04.intel.com ([192.55.52.120]:19246 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231831AbiAMLEn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 06:04:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642071883; x=1673607883;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=obWMCGhkzw7XxN/RKA/ndY8uGrgVi00uMD7y0+wq6u4=;
  b=gaJ83njqxI58UpGZKJbH2jPHba1F2hK7u4rJ6zk26R+aqXf9BVRMjmA1
   LJUoK5IIalmB6tdn1yrMi8TKTjQNYckOtDjrxwwmya3pbW7lTZDwXvP+g
   vCWzvSViR4tbnuf5/6kDvheEv1BvYAUS9oJmECDha6+CLfGHFFvM+ntk7
   ooo978X/eaAimxHBYMrGJVHg9QttEPHQGZWSBO79gJ5AoJ4wdreo/qjla
   J15pMeHX2DAC7p0HOwP0LfqKMY4X5zONFk5u/6USWkIODPYu/TJ80JeAj
   NWMfJuykB0H4fH1mdoRgXhoys5JdzGzr1oSZPlYuI+eQpzmiKFhgZ3RT6
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10225"; a="242802725"
X-IronPort-AV: E=Sophos;i="5.88,284,1635231600"; 
   d="scan'208";a="242802725"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2022 03:04:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,284,1635231600"; 
   d="scan'208";a="529619970"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 13 Jan 2022 03:04:41 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n7xuK-000770-RP; Thu, 13 Jan 2022 11:04:40 +0000
Date:   Thu, 13 Jan 2022 19:04:26 +0800
From:   kernel test robot <lkp@intel.com>
To:     Russell King <rmk+kernel@armlinux.org.uk>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [rmk-arm:sa1100 51/57] drivers/pcmcia/sa1100_h3600.c:16:8: error:
 redefinition of 'struct ipaq_option_id'
Message-ID: <202201131931.mrlITrew-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://git.armlinux.org.uk/~rmk/linux-arm sa1100
head:   7c5e0e177553f8a9ef3424e59fb3ef69c6b71689
commit: 0c9773b1e881f134894c15133ca61b79432d7d89 [51/57] pcmcia: convert sa1100_h3600 to support dual-slot sleeve only
config: arm-h3600_defconfig (https://download.01.org/0day-ci/archive/20220113/202201131931.mrlITrew-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git remote add rmk-arm git://git.armlinux.org.uk/~rmk/linux-arm
        git fetch --no-tags rmk-arm sa1100
        git checkout 0c9773b1e881f134894c15133ca61b79432d7d89
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arm SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> drivers/pcmcia/sa1100_h3600.c:16:8: error: redefinition of 'struct ipaq_option_id'
      16 | struct ipaq_option_id {
         |        ^~~~~~~~~~~~~~
   In file included from include/linux/of.h:18,
                    from include/linux/cpufreq.h:17,
                    from drivers/pcmcia/soc_common.h:15,
                    from drivers/pcmcia/sa1100_generic.h:2,
                    from drivers/pcmcia/sa1100_h3600.c:14:
   include/linux/mod_devicetable.h:646:8: note: originally defined here
     646 | struct ipaq_option_id {
         |        ^~~~~~~~~~~~~~


vim +16 drivers/pcmcia/sa1100_h3600.c

    15	
  > 16	struct ipaq_option_id {
    17		u16 vendor;
    18		u16 device;
    19	};
    20	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
