Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE9CC52618B
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 14:05:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380133AbiEMMFM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 08:05:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380127AbiEMMFJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 08:05:09 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D32492944BA
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 05:05:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652443507; x=1683979507;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=BNeavGT6SI5dxe+h9jv+bBWNm/028mOdGjs8qZE3aXk=;
  b=jyAwoLHjoPOIS6manIVwEuXjlEpHHFzfEBa/HaHd56tZZ0qxxNabZuei
   65rFLccKUucwVyjpi7NKH+oh3cN144BW6ah7gltMgP+Nwi6syivdsctLq
   QmRBQh01rmzUFvaWdMSzh3ioJ2w5K4l0iHViNoohypIeU0pp1rNnVNACq
   hvIQQkdFdgS7Ar2/vGuj4nbYFbkMraS9vIOqAUrdWsa6LgjQEpw6Q9KHr
   KkOVTluKOUwUTn+5rys32Igv313dKHui6gkYex5i5PgVMSsVkHjIBCASp
   sufbxS8xbc5OxZLRRyYSGRkKkFxRliTzlRMDbdvyQV3B6GOlxaJA+5ZGr
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10345"; a="333324125"
X-IronPort-AV: E=Sophos;i="5.91,221,1647327600"; 
   d="scan'208";a="333324125"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2022 05:05:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,221,1647327600"; 
   d="scan'208";a="698463920"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 13 May 2022 05:04:41 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1npU2B-000Lic-Bz;
        Fri, 13 May 2022 12:04:39 +0000
Date:   Fri, 13 May 2022 20:04:34 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jagan Teki <jagan@amarulasolutions.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Marek Szyprowski <m.szyprowski@samsung.com>
Subject: [mszyprow:v5.18-next-20220511-dsi-rework 14/35] ERROR: modpost:
 "dsi_driver" [drivers/gpu/drm/exynos/exynosdrm.ko] undefined!
Message-ID: <202205131932.PAaaeVrI-lkp@intel.com>
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

tree:   https://github.com/mszyprow/linux.git v5.18-next-20220511-dsi-rework
head:   65cb4959430021041f1e68ef98a6ec541d5891aa
commit: 395cab08cbac6e4028dafce068414ea43244a592 [14/35] drm: bridge: Add Samsung DSIM bridge driver
config: mips-allmodconfig (https://download.01.org/0day-ci/archive/20220513/202205131932.PAaaeVrI-lkp@intel.com/config)
compiler: mips-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/mszyprow/linux/commit/395cab08cbac6e4028dafce068414ea43244a592
        git remote add mszyprow https://github.com/mszyprow/linux.git
        git fetch --no-tags mszyprow v5.18-next-20220511-dsi-rework
        git checkout 395cab08cbac6e4028dafce068414ea43244a592
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=mips SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>, old ones prefixed by <<):

>> ERROR: modpost: "dsi_driver" [drivers/gpu/drm/exynos/exynosdrm.ko] undefined!

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
