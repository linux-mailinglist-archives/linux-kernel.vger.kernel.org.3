Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 872285553DD
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 20:59:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377189AbiFVS7D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 14:59:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377797AbiFVS7A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 14:59:00 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E379D1A38F
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 11:58:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655924338; x=1687460338;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=LlltW24ySiskehtC8pnURPF7rl62uQLUH72akN1+Mnw=;
  b=NntoIvutqLgjmzbK+aGoXhVrrI2gCyp97gHA1VhNWyUFphMvo1v+iVAx
   xBZ18FLnATTp9bYO95inbz4g5kx/EvkKyVed6f5sigLKLmf4VRB/f5z5t
   xrsdmTcjoQGeM8AnLtluKXLLe5GT0sGJ90BCfJCpNXWh0yaeRFsmU938G
   MQLonmlLn7nUupLKZQ5MBwkBmWSu4K2MYaBfN9HwMjjihXoV3Ej/tK0xm
   WR9t5uKcMelz9LR+69n5t32AKsz60aU+QofbmvIOv8yaWHcwDcosPifv/
   Jy1xMT9hM4zZBK5CL+lo8XE1pfguMAQr/byyq/DXemOkl3+YEGrngOGa1
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10386"; a="366837775"
X-IronPort-AV: E=Sophos;i="5.92,212,1650956400"; 
   d="scan'208";a="366837775"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2022 11:58:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,212,1650956400"; 
   d="scan'208";a="834267165"
Received: from lkp-server02.sh.intel.com (HELO a67cc04a5eeb) ([10.239.97.151])
  by fmsmga006.fm.intel.com with ESMTP; 22 Jun 2022 11:58:57 -0700
Received: from kbuild by a67cc04a5eeb with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o45Z2-0001a4-MA;
        Wed, 22 Jun 2022 18:58:56 +0000
Date:   Thu, 23 Jun 2022 02:58:14 +0800
From:   kernel test robot <lkp@intel.com>
To:     Nick Terrell <terrelln@fb.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: ERROR: modpost: "__ld_r13_to_r24_ret" [lib/zstd/zstd_decompress.ko]
 undefined!
Message-ID: <202206230225.eMycxeLU-lkp@intel.com>
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

Hi Nick,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   3abc3ae553c7ed73365b385b9a4cffc5176aae45
commit: 7416cdc9b9c10968c57b1f73be5d48b3ecdaf3c8 lib: zstd: Don't add -O3 to cflags
date:   7 months ago
config: arc-buildonly-randconfig-r006-20220622 (https://download.01.org/0day-ci/archive/20220623/202206230225.eMycxeLU-lkp@intel.com/config)
compiler: arceb-elf-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=7416cdc9b9c10968c57b1f73be5d48b3ecdaf3c8
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 7416cdc9b9c10968c57b1f73be5d48b3ecdaf3c8
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=arc SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>, old ones prefixed by <<):

>> ERROR: modpost: "__ld_r13_to_r24_ret" [lib/zstd/zstd_decompress.ko] undefined!
>> ERROR: modpost: "__st_r13_to_r24" [lib/zstd/zstd_decompress.ko] undefined!

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
