Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98ADB536AB7
	for <lists+linux-kernel@lfdr.de>; Sat, 28 May 2022 06:30:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355605AbiE1E3p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 May 2022 00:29:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238534AbiE1E3m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 May 2022 00:29:42 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12A675BE56
        for <linux-kernel@vger.kernel.org>; Fri, 27 May 2022 21:29:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653712181; x=1685248181;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=LBj68ZipfQDG93/AYhFLpML4p/fOJtG/9iR7B+y6gEg=;
  b=ISNXLcLyt2uBepGO8F/e/gVyJU5Y23EDgSM3ANJaocMGvBLY7TUG1Q96
   dMgScj7iloU1Y6m8zg8fF8+X11P0RgbODmbxt2cK8pPAbP08l9Ih2Zo11
   9SLfoDz2IlxY+TMXsvB2xO0tvQSf3RN21wP34rndfyALOOYUGIIS3Aqh2
   P6hixNrYevbwHT0wFv79p0vMgSvgtF8hFc/Ojb6+1R8I7uke/Fieosnmc
   AwtJOKx8ZCINpqbrJQAb3q98jJx8VP/rTfvZzHGhnc7G1vBpcDWcrQxMo
   OBNCYkGY9d6HquKvNXkR9UIHN+Xo95Z1SIbl1iAH1KGuCDkZTq/e+oHSP
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10360"; a="254501326"
X-IronPort-AV: E=Sophos;i="5.91,257,1647327600"; 
   d="scan'208";a="254501326"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2022 21:29:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,257,1647327600"; 
   d="scan'208";a="747360059"
Received: from lkp-server01.sh.intel.com (HELO db63a1be7222) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 27 May 2022 21:29:39 -0700
Received: from kbuild by db63a1be7222 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nuo54-0005RZ-PR;
        Sat, 28 May 2022 04:29:38 +0000
Date:   Sat, 28 May 2022 12:29:27 +0800
From:   kernel test robot <lkp@intel.com>
To:     Daniel Vetter <daniel.vetter@ffwll.ch>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: drivers/video/fbdev/core/fbcon.c:106:16: sparse: sparse: symbol
 'fbcon_registered_fb' was not declared. Should it be static?
Message-ID: <202205281235.rdumodzg-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   a9f94826e4bb6402e67f3eb849dee0811f1de6da
commit: efc3acbc105af79bce2ccf97a6159255b7cf6b38 fbcon: Maintain a private array of fb_info
date:   7 weeks ago
config: ia64-randconfig-s031-20220524 (https://download.01.org/0day-ci/archive/20220528/202205281235.rdumodzg-lkp@intel.com/config)
compiler: ia64-linux-gcc (GCC) 11.3.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-14-g5a0004b5-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=efc3acbc105af79bce2ccf97a6159255b7cf6b38
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout efc3acbc105af79bce2ccf97a6159255b7cf6b38
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=ia64 SHELL=/bin/bash drivers/video/fbdev/core/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
>> drivers/video/fbdev/core/fbcon.c:106:16: sparse: sparse: symbol 'fbcon_registered_fb' was not declared. Should it be static?
>> drivers/video/fbdev/core/fbcon.c:107:5: sparse: sparse: symbol 'fbcon_num_registered_fb' was not declared. Should it be static?

vim +/fbcon_registered_fb +106 drivers/video/fbdev/core/fbcon.c

   105	
 > 106	struct fb_info *fbcon_registered_fb[FB_MAX];
 > 107	int fbcon_num_registered_fb;
   108	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
