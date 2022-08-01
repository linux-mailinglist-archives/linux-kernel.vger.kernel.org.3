Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16BA3586679
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 10:38:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230210AbiHAIi1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 04:38:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbiHAIiZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 04:38:25 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29E822E9F5
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 01:38:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659343105; x=1690879105;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=iKwX0iE1kKSS0UTE0Kh8rQC1gwFu5nd3qKGM5KLEEAY=;
  b=EgIVA0Lx8GpiO+uDvEws3Zn+k5NlrYTwUHnhV4Z4aTnd7+liMcvHlicE
   HcA4CX/7ffQAe9F8qwXPaeo+yE1tFZ11HANOxmqYYj20lbHB36MrYz/pp
   m/Mb7Woe0lu4RxwaS1euZEFFHON7we9Pn3KMhD1wxcRZEpMjpjtlo0Z3s
   5BxQTmwxWtufvyf0KjzECbVSRtxQ6DwIeJpVhtuHskBnBJP5NSTLZc2qc
   WRbyDpad1L2PQVXvAxKNnAaOoA32CxTeox8xc7gzb9P/ntIEOh3AIL7vx
   EH6tpjMXE5BjsbfYBZEE6PS1195Zd+7xqU1VBI1XlC5e4t+hkgQ30niAo
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10425"; a="268860930"
X-IronPort-AV: E=Sophos;i="5.93,206,1654585200"; 
   d="scan'208";a="268860930"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Aug 2022 01:38:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,206,1654585200"; 
   d="scan'208";a="552437505"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 01 Aug 2022 01:38:23 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oIQwQ-000EyB-1I;
        Mon, 01 Aug 2022 08:38:22 +0000
Date:   Mon, 1 Aug 2022 16:38:06 +0800
From:   kernel test robot <lkp@intel.com>
To:     Max Filippov <jcmvbkbc@gmail.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: xtensa-linux-ld: section .start VMA
 [00000000d1000000,00000000d1000007] overlaps section .image VMA
 [00000000d0003000,00000000d10e49a7]
Message-ID: <202208011640.tpZWgjSJ-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Max,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   3d7cb6b04c3f3115719235cc6866b10326de34cd
commit: da0a4e5c8fbcce3d1afebf9f2a967083bb19634d xtensa: only build windowed register support code when needed
date:   10 months ago
config: xtensa-randconfig-r032-20220801 (https://download.01.org/0day-ci/archive/20220801/202208011640.tpZWgjSJ-lkp@intel.com/config)
compiler: xtensa-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=da0a4e5c8fbcce3d1afebf9f2a967083bb19634d
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout da0a4e5c8fbcce3d1afebf9f2a967083bb19634d
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=xtensa SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> xtensa-linux-ld: section .start VMA [00000000d1000000,00000000d1000007] overlaps section .image VMA [00000000d0003000,00000000d10e49a7]

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
