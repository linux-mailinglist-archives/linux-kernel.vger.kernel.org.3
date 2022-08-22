Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB15559BA3C
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 09:27:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232804AbiHVH1q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 03:27:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbiHVH1n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 03:27:43 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E730F29CB0
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 00:27:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661153262; x=1692689262;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=ZIX/nHo7zid4qKFYJG9ZTmbJikpG6pbFmXZh0kFzUE8=;
  b=LKkNXzV4+uyBXae4s5i17fxuPpsQGSTSolOnTY4Ll1Icia23z/YFgqI+
   tYNtYjZFBce/iVrnyQf5AXURpShw0NDqL7qEBCqNxcTt7zMo7aZ6At1zu
   28Rv6ioigMonrWIXSWaPtRhjJLAMwk3nnkbPKqakjmsDfNJnOXzQ1LUu8
   u51FcS1+ba08U2uJC8N8ZFHLc1yNysaYJPs1Cia0A8CaX45aBqcNqmn+8
   /pVhlIVliNIWt3Jc+3kJDk87RZrv6cWLGLC/qL4fFau5BPGW7+7SZaxPO
   TI3Fx5IHbHQXPg43AUMQfGcHBnNhw105uOSa8ZwAdbYOmCDvBokn6e200
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10446"; a="379636725"
X-IronPort-AV: E=Sophos;i="5.93,254,1654585200"; 
   d="scan'208";a="379636725"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2022 00:27:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,254,1654585200"; 
   d="scan'208";a="936930985"
Received: from lkp-server01.sh.intel.com (HELO 44b6dac04a33) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 22 Aug 2022 00:27:37 -0700
Received: from kbuild by 44b6dac04a33 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oQ1qS-00054l-1W;
        Mon, 22 Aug 2022 07:27:36 +0000
Date:   Mon, 22 Aug 2022 15:26:36 +0800
From:   kernel test robot <lkp@intel.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Noralf =?iso-8859-1?Q?Tr=F8nnes?= <noralf@tronnes.org>,
        Douglas Anderson <dianders@chromium.org>
Subject: ld.lld: error: undefined symbol: drm_gem_fb_get_obj
Message-ID: <202208221506.0Lo051G4-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   1c23f9e627a7b412978b4e852793c5e3c3efc555
commit: 57f6190a60ecc19f1ddddac0d7ea6524229271a9 drm/panel: ws2401: Add driver for WideChips WS2401
date:   1 year, 1 month ago
config: x86_64-randconfig-a002-20220822 (https://download.01.org/0day-ci/archive/20220822/202208221506.0Lo051G4-lkp@intel.com/config)
compiler: clang version 14.0.6 (https://github.com/llvm/llvm-project f28c006a5895fc0e329fe15fead81e37457cb1d1)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=57f6190a60ecc19f1ddddac0d7ea6524229271a9
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 57f6190a60ecc19f1ddddac0d7ea6524229271a9
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> ld.lld: error: undefined symbol: drm_gem_fb_get_obj
   >>> referenced by drm_mipi_dbi.c:203 (drivers/gpu/drm/drm_mipi_dbi.c:203)
   >>>               gpu/drm/drm_mipi_dbi.o:(mipi_dbi_buf_copy) in archive drivers/built-in.a
   >>> referenced by drm_mipi_dbi.c:258 (drivers/gpu/drm/drm_mipi_dbi.c:258)
   >>>               gpu/drm/drm_mipi_dbi.o:(mipi_dbi_fb_dirty) in archive drivers/built-in.a
--
>> ld.lld: error: undefined symbol: drm_fb_swab
   >>> referenced by drm_mipi_dbi.c:219 (drivers/gpu/drm/drm_mipi_dbi.c:219)
   >>>               gpu/drm/drm_mipi_dbi.o:(mipi_dbi_buf_copy) in archive drivers/built-in.a
--
>> ld.lld: error: undefined symbol: drm_atomic_helper_connector_destroy_state
   >>> referenced by drm_mipi_dbi.c
   >>>               gpu/drm/drm_mipi_dbi.o:(mipi_dbi_connector_funcs) in archive drivers/built-in.a
--
>> ld.lld: error: undefined symbol: drm_gem_fb_create_with_dirty
   >>> referenced by drm_mipi_dbi.c
   >>>               gpu/drm/drm_mipi_dbi.o:(mipi_dbi_mode_config_funcs) in archive drivers/built-in.a
--
>> ld.lld: error: undefined symbol: drm_atomic_helper_check
   >>> referenced by drm_mipi_dbi.c
   >>>               gpu/drm/drm_mipi_dbi.o:(mipi_dbi_mode_config_funcs) in archive drivers/built-in.a
--
>> ld.lld: error: undefined symbol: drm_atomic_helper_commit
   >>> referenced by drm_mipi_dbi.c
   >>>               gpu/drm/drm_mipi_dbi.o:(mipi_dbi_mode_config_funcs) in archive drivers/built-in.a
--
>> ld.lld: error: undefined symbol: drm_fb_xrgb8888_to_rgb565
   >>> referenced by drm_mipi_dbi.c:224 (drivers/gpu/drm/drm_mipi_dbi.c:224)
   >>>               gpu/drm/drm_mipi_dbi.o:(mipi_dbi_buf_copy) in archive drivers/built-in.a
--
>> ld.lld: error: undefined symbol: drm_fb_memcpy
   >>> referenced by drm_mipi_dbi.c:221 (drivers/gpu/drm/drm_mipi_dbi.c:221)
   >>>               gpu/drm/drm_mipi_dbi.o:(mipi_dbi_buf_copy) in archive drivers/built-in.a
--
>> ld.lld: error: undefined symbol: drm_atomic_helper_damage_merged
   >>> referenced by drm_mipi_dbi.c:318 (drivers/gpu/drm/drm_mipi_dbi.c:318)
   >>>               gpu/drm/drm_mipi_dbi.o:(mipi_dbi_pipe_update) in archive drivers/built-in.a
--
>> ld.lld: error: undefined symbol: drm_simple_display_pipe_init
   >>> referenced by drm_mipi_dbi.c:529 (drivers/gpu/drm/drm_mipi_dbi.c:529)
   >>>               gpu/drm/drm_mipi_dbi.o:(mipi_dbi_dev_init_with_formats) in archive drivers/built-in.a
--
>> ld.lld: error: undefined symbol: drm_atomic_helper_connector_reset
   >>> referenced by drm_mipi_dbi.c
   >>>               gpu/drm/drm_mipi_dbi.o:(mipi_dbi_connector_funcs) in archive drivers/built-in.a
..

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
