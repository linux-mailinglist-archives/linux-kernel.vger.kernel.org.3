Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B75DC4E8B00
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 01:02:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234409AbiC0XD6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Mar 2022 19:03:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbiC0XD5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Mar 2022 19:03:57 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3DB93FDAC
        for <linux-kernel@vger.kernel.org>; Sun, 27 Mar 2022 16:02:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648422137; x=1679958137;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=COX1dVvku+lnTG99Hr51mJqhPKIU6FF2BADU46vdDUo=;
  b=KGteQLY0WK6JcS0OVGzSi3lBm8VZLd/rcqZmHIsoDhIvHzrTFVf+IaEQ
   PBpsyGS5RzNMJ47DR+dcsJ8GP3S2OJSZVV8RnJyV5LkEw5b2OR0WgCDzM
   LVAXaGS0d5IDExtdHFWhZ2sKbr6raZcIimVhpTCrephby2fLiJA96A3lL
   +yrbiP9j580jLZUtFWmAQJYspfbHTL/+OTewh8No3WAsPs3mYZoif2kPn
   PKw7mJh6ffBlrWzcK/R9VyBZhAzc7B/IB3mjRtUrQYVvZMbKF2dGvNiDs
   ogdq3ikxjnVHrx8uCqTPsIaL1w0gHd0GKV1vxfkxWj0jWhEbYaDptRKB2
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10299"; a="238814253"
X-IronPort-AV: E=Sophos;i="5.90,216,1643702400"; 
   d="scan'208";a="238814253"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2022 16:02:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,216,1643702400"; 
   d="scan'208";a="651239636"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 27 Mar 2022 16:02:16 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nYbtn-0001VQ-8d; Sun, 27 Mar 2022 23:02:15 +0000
Date:   Mon, 28 Mar 2022 07:01:53 +0800
From:   kernel test robot <lkp@intel.com>
To:     Marek Vasut <marex@denx.de>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Michael Tretter <m.tretter@pengutronix.de>
Subject: undefined reference to `v4l2_fwnode_endpoint_parse'
Message-ID: <202203280727.KWAptOyZ-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   50d602d81f35621042fa0cdae25808662caffda8
commit: 51ef2be546e2e480e56fdb59fdeb9a4406e8d52e media: i2c: isl7998x: Add driver for Intersil ISL7998x
date:   3 weeks ago
config: microblaze-randconfig-r025-20220328 (https://download.01.org/0day-ci/archive/20220328/202203280727.KWAptOyZ-lkp@intel.com/config)
compiler: microblaze-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=51ef2be546e2e480e56fdb59fdeb9a4406e8d52e
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 51ef2be546e2e480e56fdb59fdeb9a4406e8d52e
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=microblaze SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   microblaze-linux-ld: drivers/media/i2c/isl7998x.o: in function `isl7998x_probe':
>> (.text+0x8f4): undefined reference to `v4l2_fwnode_endpoint_parse'

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
