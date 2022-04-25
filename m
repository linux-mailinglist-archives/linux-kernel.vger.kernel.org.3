Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A794250E056
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 14:31:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241833AbiDYMeV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 08:34:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231655AbiDYMeD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 08:34:03 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D73A96623E
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 05:30:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650889859; x=1682425859;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=RVA4Iq60mJapAqst6cODpjgM/QIEZkXSszcINoGkx2U=;
  b=Rt6BaGQ39ts/REmR0LHDZIi/19rKqhBs7+EU/YruEn9hPSSXB/K/ylNZ
   gbWd9WdDz5p6QRRa3psoXcxqNgzSGfNi5FS75Ckeob5kQoDQYvJvGwl4E
   dV35m5e0Ug6wb1HN1pg0UcNT9XBFL+b00Dg/bTc9PPNoYH02FOCNQyODl
   eHu8ThmzDiBo0tk2iWMo6eVaj16Am+PQqp2yQ0cDpLDEANDemCG9Jg0AM
   BF/nz1453qkW0mxmHKYrxpF+c0zt9TyxvcEqOvE74EyAltk0XLUZAzecU
   t7M7d/ETvIkanS6tCyY1AFcDNaGJvIzvvuRZIqBW1bF6bC8SnFkuVMKB+
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10327"; a="264751912"
X-IronPort-AV: E=Sophos;i="5.90,288,1643702400"; 
   d="scan'208";a="264751912"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2022 05:30:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,288,1643702400"; 
   d="scan'208";a="704540114"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 25 Apr 2022 05:30:57 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nixrk-0002Ud-Vx;
        Mon, 25 Apr 2022 12:30:56 +0000
Date:   Mon, 25 Apr 2022 20:30:18 +0800
From:   kernel test robot <lkp@intel.com>
To:     Marek Vasut <marex@denx.de>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Michael Tretter <m.tretter@pengutronix.de>
Subject: isl7998x.c:undefined reference to `v4l2_fwnode_endpoint_parse'
Message-ID: <202204252008.EH3XUAjp-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   af2d861d4cd2a4da5137f795ee3509e6f944a25b
commit: 51ef2be546e2e480e56fdb59fdeb9a4406e8d52e media: i2c: isl7998x: Add driver for Intersil ISL7998x
date:   8 weeks ago
config: riscv-randconfig-r026-20220425 (https://download.01.org/0day-ci/archive/20220425/202204252008.EH3XUAjp-lkp@intel.com/config)
compiler: riscv64-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=51ef2be546e2e480e56fdb59fdeb9a4406e8d52e
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 51ef2be546e2e480e56fdb59fdeb9a4406e8d52e
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross W=1 O=build_dir ARCH=riscv SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   riscv64-linux-ld: drivers/media/i2c/isl7998x.o: in function `.L0 ':
>> isl7998x.c:(.text+0xa54): undefined reference to `v4l2_fwnode_endpoint_parse'
   riscv64-linux-ld: net/core/sock.o: in function `.L1089':
   sock.c:(.text+0x5190): undefined reference to `__sk_defer_free_flush'

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
