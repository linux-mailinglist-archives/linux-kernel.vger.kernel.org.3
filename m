Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C9DF55F00A
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 22:57:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231477AbiF1U5g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 16:57:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231252AbiF1U5f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 16:57:35 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B0CA3914A
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 13:57:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656449854; x=1687985854;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=7EASrP8TbY4kZA/ihQpkN/hTKwuF8+QdZ2zKsCBhPAU=;
  b=j5Rj1oFVVoPbGCjXbOgP7jtoqD1Wl90QCMzTdRzCwTQjuMds2BClAbQd
   ySQ+TVY1x46jx7zkeMuDsDp7PvJ2MZmrEIAKrApqr+u15EZax+oNb3u7o
   fU4jHpxABzclJ/cz1Q3X3pPrHkw+HDsUlrXEqdTX2mKi0cDxIZDSE/29n
   WC0T2lMD+nU2xhcDmPR7KSWlV6F5UnyOHpUBkis55OQbx6MJMwMT2JYd4
   N0LYPLKlr0yg3Mpi5sFSMti2X/PHBqNzLuCk6At3CnAEGPfdEFu/bi/e9
   cE4416zQA5ZIxtk5cg+IHEArrufAi3agMxzMZjzfCd7KGbxRgSLXWf8yM
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10392"; a="270608858"
X-IronPort-AV: E=Sophos;i="5.92,229,1650956400"; 
   d="scan'208";a="270608858"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2022 13:57:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,229,1650956400"; 
   d="scan'208";a="588003216"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 28 Jun 2022 13:57:32 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o6IH6-000Ace-7z;
        Tue, 28 Jun 2022 20:57:32 +0000
Date:   Wed, 29 Jun 2022 04:56:44 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Jason A. Donenfeld" <zx2c4@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [zx2c4:master 9/10] ERROR: modpost: "wake_up_state"
 [drivers/char/hw_random/rng-core.ko] undefined!
Message-ID: <202206290411.mqUgqNBX-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/zx2c4/linux.git master
head:   9b3548a2475866d26bdeee84d62eecf1bc94d22a
commit: 78223ae64136d911588115c6c317a31305100ce4 [9/10] ath9k: let sleep be interrupted when unregistering hwrng
config: m68k-allmodconfig (https://download.01.org/0day-ci/archive/20220629/202206290411.mqUgqNBX-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/zx2c4/linux.git/commit/?id=78223ae64136d911588115c6c317a31305100ce4
        git remote add zx2c4 https://git.kernel.org/pub/scm/linux/kernel/git/zx2c4/linux.git
        git fetch --no-tags zx2c4 master
        git checkout 78223ae64136d911588115c6c317a31305100ce4
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=m68k SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>, old ones prefixed by <<):

>> ERROR: modpost: "wake_up_state" [drivers/char/hw_random/rng-core.ko] undefined!

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
