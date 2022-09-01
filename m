Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81C545A8CF2
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 06:52:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232590AbiIAEwr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 00:52:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229755AbiIAEwp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 00:52:45 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED488114C63
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 21:52:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662007963; x=1693543963;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=2JFUzA9PnB8sENrXT/Oe6aXThGhndWfqeuAE7z3EbmU=;
  b=QGVi7+B8JlHqpa7xqrPohCnirMOxhCTOCFHc7h37wKcG161oirmzlzm3
   Toy6WTEEGd5PgFv/VVOaLSJlN+lKaNySgn6k+iwLlZiZ6mNl/e9aurkrp
   ICboO7o3OE84GSOS01uj1mlKOpxcD5/ntQzi9Es4bvLEUNDw7citYNTtO
   xfWtUiXI/3wZARcWtPaHX85OpOSp4c8t/nIp4lUIvtnMudPT7Tk0AF0SE
   O+Hio/i8E47Fe4O6FkAbytrTTnXgXeGlnp9AYcIK9xCwyfL4B9PcSYHH4
   jY63BtUKnT8T7K8dkjmswsSgZCGptl/6h1UQ5kEPwPms3fD5Iy2Eusptd
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10456"; a="321760234"
X-IronPort-AV: E=Sophos;i="5.93,280,1654585200"; 
   d="scan'208";a="321760234"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2022 21:52:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,280,1654585200"; 
   d="scan'208";a="645490834"
Received: from lkp-server02.sh.intel.com (HELO 811e2ceaf0e5) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 31 Aug 2022 21:52:41 -0700
Received: from kbuild by 811e2ceaf0e5 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oTcC1-00017G-0K;
        Thu, 01 Sep 2022 04:52:41 +0000
Date:   Thu, 1 Sep 2022 12:51:57 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Minghao Chi (CGEL ZTE)" <chi.minghao@zte.com.cn>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Maxime Ripard <maxime@cerno.tech>,
        Sasha Levin <sashal@kernel.org>
Subject: [stable:linux-5.15.y 9126/9999] ERROR: modpost:
 "devm_drm_of_get_bridge" [drivers/gpu/drm/vc4/vc4.ko] undefined!
Message-ID: <202209011256.zvBzxcpP-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-5.15.y
head:   1ded0ef2419e8f83a17d65594523ec3aeb2e3d0f
commit: 3d722c01d628d17a37cf2820195f15cfc9a6a332 [9126/9999] drm/vc4: Use of_device_get_match_data()
config: parisc-randconfig-c034-20220831 (https://download.01.org/0day-ci/archive/20220901/202209011256.zvBzxcpP-lkp@intel.com/config)
compiler: hppa-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git/commit/?id=3d722c01d628d17a37cf2820195f15cfc9a6a332
        git remote add stable https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git
        git fetch --no-tags stable linux-5.15.y
        git checkout 3d722c01d628d17a37cf2820195f15cfc9a6a332
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=parisc SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>, old ones prefixed by <<):

>> ERROR: modpost: "devm_drm_of_get_bridge" [drivers/gpu/drm/vc4/vc4.ko] undefined!

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
