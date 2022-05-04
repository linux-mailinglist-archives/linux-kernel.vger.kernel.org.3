Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01013519B44
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 11:14:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347022AbiEDJSD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 05:18:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346992AbiEDJRu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 05:17:50 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBC9C1FA52
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 02:14:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651655655; x=1683191655;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=VsPwoFBbW78xEeZLWVp/OKrWo88rORbPPuR9Qy9VbSQ=;
  b=QkaA5VJYcNoIjCA1uySgeM2HpqH2YD+oKXcVoioZN03P/Km/kAUxRadt
   RPhzsI6O3RsW50/ed5uNj7skwoVpfFAz77oNNsW1b19IQYAP6o/NZY1ZA
   ukNh+ZuTcksiMEDk2kdzBv++qyVT7dRDr761qlLp2aY9n4u0Vph4G7z9w
   PRHFdtAtyceNeLqs6fb4j9M95ZoX1dBMGkJ0/DGw6tHMhpvq1a7toBigo
   pjRP/SdVdoAQ0TyJTv2fHpun772ElCOkJBPz3onG2mH1kOJO5aKdfPV34
   tgH/IDgZ4Upoa49iKOBJWet+QRNGvM8BjvPmBATXVSLS7XEANepkCkvCR
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10336"; a="330696046"
X-IronPort-AV: E=Sophos;i="5.91,197,1647327600"; 
   d="scan'208";a="330696046"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2022 02:14:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,197,1647327600"; 
   d="scan'208";a="620726752"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 04 May 2022 02:14:14 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nmB5J-000BEk-Az;
        Wed, 04 May 2022 09:14:13 +0000
Date:   Wed, 4 May 2022 17:14:10 +0800
From:   kernel test robot <lkp@intel.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Greg Ungerer <gerg@linux-m68k.org>
Subject: time.c:undefined reference to `mach_get_rtc_pll'
Message-ID: <202205041720.i8wJ8uXq-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   107c948d1d3e61d10aee9d0f7c3d81bbee9842af
commit: 8b22820efb35f93d98638563b0a8f4094e8ee399 m68k: m68328: remove duplicate code
date:   1 year, 5 months ago
config: m68k-randconfig-r016-20220503 (https://download.01.org/0day-ci/archive/20220504/202205041720.i8wJ8uXq-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=8b22820efb35f93d98638563b0a8f4094e8ee399
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 8b22820efb35f93d98638563b0a8f4094e8ee399
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=m68k SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   m68k-linux-ld: arch/m68k/kernel/time.o: in function `rtc_ioctl':
>> time.c:(.text+0x82): undefined reference to `mach_get_rtc_pll'
   m68k-linux-ld: time.c:(.text+0xbc): undefined reference to `mach_set_rtc_pll'
   m68k-linux-ld: time.c:(.text+0xf4): undefined reference to `mach_set_rtc_pll'

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
