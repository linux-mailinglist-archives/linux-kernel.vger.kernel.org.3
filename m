Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34F11590A2F
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 04:15:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236692AbiHLCP1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 22:15:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230006AbiHLCPY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 22:15:24 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C37B12528B;
        Thu, 11 Aug 2022 19:15:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660270522; x=1691806522;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=C5XPX+xgLnybnz3zgClOK3gD/zt1tfCCW/hBJxZSdGc=;
  b=oF7TBZl8aOmllVL6KMDbw7ZxRxk2s5zzt8yR2JFy5GcCK6rk+N7Bfz6W
   9RVNzatupPA0/G8vn4chdYF0ttYBtdt4UcqwsQfiEiLOhz9V9E+v8HcPF
   Znf5sGYrbNAlBylQKB4cZT00QQwNJuC1dnTMIL5AqjfGxZ1janLV8DCbf
   Cz5dOZxNhzu274VcqXe/kDJnUveYqkitBOJh3AJ5JtylX8SOEfLQK+WXF
   d/C4sjBXhTaXpsk9qFqUwn0FKbIKu9HEXe5c9wSMqXvWQkLScpFBEscYw
   sk3pUNgceLkHz4sNzvskyLDxfbZdRa5zQnr868VmJFrX8kLzFq2LMLlEn
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10436"; a="377795945"
X-IronPort-AV: E=Sophos;i="5.93,231,1654585200"; 
   d="scan'208";a="377795945"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2022 19:15:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,231,1654585200"; 
   d="scan'208";a="732079410"
Received: from lkp-server02.sh.intel.com (HELO cfab306db114) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 11 Aug 2022 19:15:20 -0700
Received: from kbuild by cfab306db114 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oMKCl-0000y8-2E;
        Fri, 12 Aug 2022 02:15:19 +0000
Date:   Fri, 12 Aug 2022 10:15:12 +0800
From:   kernel test robot <lkp@intel.com>
To:     Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Cc:     Paul Gazzillo <paul@pgazz.com>,
        Necip Fazil Yildiran <fazilyildiran@gmail.com>,
        kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, Hans Verkuil <hverkuil@xs4all.nl>
Subject: kismet: WARNING: unmet direct dependencies detected for
 PHY_SUN6I_MIPI_DPHY when selected by VIDEO_SUN6I_MIPI_CSI2
Message-ID: <202208121001.4zu3vDkU-lkp@intel.com>
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
head:   7ebfc85e2cd7b08f518b526173e9a33b56b3913b
commit: af54b4f4c17f54e8c7c43fb34571bc361cfa4ab4 media: sunxi: Add support for the A31 MIPI CSI-2 controller
date:   5 weeks ago
config: x86_64-kismet-CONFIG_PHY_SUN6I_MIPI_DPHY-CONFIG_VIDEO_SUN6I_MIPI_CSI2-0-0 (https://download.01.org/0day-ci/archive/20220812/202208121001.4zu3vDkU-lkp@intel.com/config)
reproduce:
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=af54b4f4c17f54e8c7c43fb34571bc361cfa4ab4
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout af54b4f4c17f54e8c7c43fb34571bc361cfa4ab4
        # 1. reproduce by kismet
           # install kmax per https://github.com/paulgazz/kmax/blob/master/README.md
           kismet --linux-ksrc=linux --selectees CONFIG_PHY_SUN6I_MIPI_DPHY --selectors CONFIG_VIDEO_SUN6I_MIPI_CSI2 -a=x86_64
        # 2. reproduce by make
           # save the config file to linux source tree
           cd linux
           make ARCH=x86_64 olddefconfig

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

kismet warnings: (new ones prefixed by >>)
>> kismet: WARNING: unmet direct dependencies detected for PHY_SUN6I_MIPI_DPHY when selected by VIDEO_SUN6I_MIPI_CSI2
   
   WARNING: unmet direct dependencies detected for PHY_SUN6I_MIPI_DPHY
     Depends on [n]: (ARCH_SUNXI || COMPILE_TEST [=y]) && HAS_IOMEM [=y] && COMMON_CLK [=y] && RESET_CONTROLLER [=n]
     Selected by [y]:
     - VIDEO_SUN6I_MIPI_CSI2 [=y] && MEDIA_SUPPORT [=y] && MEDIA_PLATFORM_SUPPORT [=y] && MEDIA_PLATFORM_DRIVERS [=y] && V4L_PLATFORM_DRIVERS [=y] && VIDEO_DEV [=y] && (ARCH_SUNXI || COMPILE_TEST [=y]) && PM [=y] && COMMON_CLK [=y]

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
