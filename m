Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D617550682F
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 12:00:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348573AbiDSKCd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 06:02:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347788AbiDSKCa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 06:02:30 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12DDB1097;
        Tue, 19 Apr 2022 02:59:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650362388; x=1681898388;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=CPWMk0HA7+zJxEJI8LP26KB7c4E/Ei9njL+XirDH73I=;
  b=EwoKqU2DWkzdHTaWrQENxBIN4JM4YqRI6N8yxjK4kjx9V76EXIc2PDFU
   e0kK2H0cpWNm7CSDm3JgsCf1oIi38Vlhocp1Nk88vOBJV4Se607xEOh1w
   bBau1GAMiXf2LVLXRhAOdopqSqXYd2a6D7bOl9dy7WL9A+ltAuxWuTrup
   vtjnZIZ96wlHu+/VEyxcnqC720/9Y884n5GIbBvy5sA30sqwCwMxqG9n4
   gRbSJGYn2z5bv8UarrPVzltShLZ20BRd2+clib+LfE2oYUrV7HYF9a9II
   0ghg5EjmUGDF9YiWigcJ2aH9t95uK6166Ev4CRnnmB/Nl38f65ZYgjQU3
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10321"; a="261330030"
X-IronPort-AV: E=Sophos;i="5.90,272,1643702400"; 
   d="scan'208";a="261330030"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2022 02:59:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,272,1643702400"; 
   d="scan'208";a="592724335"
Received: from lkp-server01.sh.intel.com (HELO 3abc53900bec) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 19 Apr 2022 02:59:45 -0700
Received: from kbuild by 3abc53900bec with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1ngke9-0005cm-1M;
        Tue, 19 Apr 2022 09:59:45 +0000
Date:   Tue, 19 Apr 2022 17:59:08 +0800
From:   kernel test robot <lkp@intel.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Jacopo Mondi <jacopo@jmondi.org>,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: ERROR: modpost: "snd_tea575x_hw_init"
 [drivers/media/pci/bt8xx/bttv.ko] undefined!
Message-ID: <202204191711.IKJJFjgU-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   b2d229d4ddb17db541098b83524d901257e93845
commit: 9958d30f38b96fb763a10d44d18ddad39127d5f4 media: Kconfig: cleanup VIDEO_DEV dependencies
date:   5 weeks ago
config: xtensa-randconfig-r022-20220419 (https://download.01.org/0day-ci/archive/20220419/202204191711.IKJJFjgU-lkp@intel.com/config)
compiler: xtensa-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=9958d30f38b96fb763a10d44d18ddad39127d5f4
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 9958d30f38b96fb763a10d44d18ddad39127d5f4
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross W=1 O=build_dir ARCH=xtensa SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>, old ones prefixed by <<):

>> ERROR: modpost: "snd_tea575x_hw_init" [drivers/media/pci/bt8xx/bttv.ko] undefined!
>> ERROR: modpost: "snd_tea575x_set_freq" [drivers/media/pci/bt8xx/bttv.ko] undefined!
>> ERROR: modpost: "snd_tea575x_s_hw_freq_seek" [drivers/media/pci/bt8xx/bttv.ko] undefined!
>> ERROR: modpost: "snd_tea575x_enum_freq_bands" [drivers/media/pci/bt8xx/bttv.ko] undefined!
>> ERROR: modpost: "snd_tea575x_g_tuner" [drivers/media/pci/bt8xx/bttv.ko] undefined!

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
