Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CBE85273BA
	for <lists+linux-kernel@lfdr.de>; Sat, 14 May 2022 21:29:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234876AbiENT3i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 May 2022 15:29:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234727AbiENT3e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 May 2022 15:29:34 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BACF219018
        for <linux-kernel@vger.kernel.org>; Sat, 14 May 2022 12:29:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652556571; x=1684092571;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=mZ8ZArrRWt0oA0jiuE9tcZA7by6X9dx+CekkEmMIdMg=;
  b=XAHno2DnLeJ8YUhhNLvJpRo5IsNaO0ku3AHXOjeOAIIkctbov4YN5DJY
   mgck1hZCTYpDhwtNd39hKbHhnJ0bAcCHLjVlT8WED/JZvNrXzna3c4KAN
   U8LCg132tdNhDrnaGVsF/13VE7pzUMbBP+LSRBZro2+24HmsdEKOR6JMs
   NTbhJp2KRCulp1Xs1M08pW+jh/PQmDxr/pzUT5y5gQDElcsX8ySyISm3W
   1c23fAt6cDevX/1lg+/0kzzunc4cY4fxgQjQoEaMRfKl9kf3fejLKXjx4
   F4g9NwBfvITFeCqkXE0oIEiuPgwNR0ZxIkvSdL7Z9FC1pfKGadVQMttwy
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10347"; a="270678837"
X-IronPort-AV: E=Sophos;i="5.91,226,1647327600"; 
   d="scan'208";a="270678837"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2022 12:29:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,226,1647327600"; 
   d="scan'208";a="740637908"
Received: from lkp-server01.sh.intel.com (HELO d1462bc4b09b) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 14 May 2022 12:29:30 -0700
Received: from kbuild by d1462bc4b09b with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1npxSD-0000yD-IG;
        Sat, 14 May 2022 19:29:29 +0000
Date:   Sun, 15 May 2022 03:28:45 +0800
From:   kernel test robot <lkp@intel.com>
To:     Javier Martinez Canillas <javierm@redhat.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [drm-misc:drm-misc-next 2/2] undefined reference to `screen_info'
Message-ID: <202205150326.ps3FiIYo-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://anongit.freedesktop.org/drm/drm-misc drm-misc-next
head:   d0edd3c1a7e859a5899c26e2906e80f4ac798fa9
commit: fa0e256450f27a7d85f65c63f05e6897954a1d53 [2/2] fbdev: vesafb: Allow to be built if COMPILE_TEST is enabled
config: parisc-allyesconfig (https://download.01.org/0day-ci/archive/20220515/202205150326.ps3FiIYo-lkp@intel.com/config)
compiler: hppa-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git remote add drm-misc git://anongit.freedesktop.org/drm/drm-misc
        git fetch --no-tags drm-misc drm-misc-next
        git checkout fa0e256450f27a7d85f65c63f05e6897954a1d53
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=parisc SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   hppa-linux-ld: drivers/video/fbdev/vesafb.o: in function `vesafb_probe':
>> (.text+0x738): undefined reference to `screen_info'
>> hppa-linux-ld: (.text+0x73c): undefined reference to `screen_info'
   hppa-linux-ld: drivers/firmware/sysfb.o: in function `sysfb_init':
>> (.init.text+0x28): undefined reference to `screen_info'
>> hppa-linux-ld: (.init.text+0x30): undefined reference to `screen_info'
   hppa-linux-ld: (.init.text+0x78): undefined reference to `screen_info'

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
