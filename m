Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5716F50AA66
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 22:54:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1392612AbiDUU5k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 16:57:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1392607AbiDUU5h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 16:57:37 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 809DE4EA20
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 13:54:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650574487; x=1682110487;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=gaVn/25jgrMwzaFXLGnssnKEM3HuBCFYsCdGnJ71o2U=;
  b=n4mTFAfzHE/xCnjj5/8oAdBPcBA1/eBxVBqD6ZKEdFTtK7VKqTX39/Rn
   VGdvB8/QQIV84GnaDObPuO5x9QrVo8acscvg1DRzEtTYdBVbuAPPicAEb
   ef9PhKZPRTMN29vsQcFLCuYayMY9AshkCxhWE/+eHtwXy8lGMQJbvMbvj
   U3JWEHiagpMlIeAiQnnelBlqGYzMfw72AtmVKTfdJCIWP1FeLTnVK32TZ
   8PHglTvWuEkGBN2wycvou3DLvM12o+bhqYQQrfDttX5OWqqfVeKP83h0C
   7HSeESae+/pnBto1/Oo+CcriAVB9myUL1zoC6KCimQpR/L9tAQU8qSYoP
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10324"; a="324927033"
X-IronPort-AV: E=Sophos;i="5.90,279,1643702400"; 
   d="scan'208";a="324927033"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2022 13:54:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,279,1643702400"; 
   d="scan'208";a="703244931"
Received: from lkp-server01.sh.intel.com (HELO 3abc53900bec) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 21 Apr 2022 13:54:45 -0700
Received: from kbuild by 3abc53900bec with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nhdp7-0008mm-6t;
        Thu, 21 Apr 2022 20:54:45 +0000
Date:   Fri, 22 Apr 2022 04:54:28 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jiri Slaby <jslaby@suse.cz>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [jirislaby:devel 40/70] drivers/tty/serial/amba-pl011.c:45:10: fatal
 error: 'amba-pl011.h' file not found
Message-ID: <202204220445.8rhFIlg0-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/jirislaby/linux.git devel
head:   c73cb9009b8d130305afba38bbd407a58bf8f2c8
commit: 01ba379ed8413be7b65a53ab02f0d044233857f3 [40/70] serial: amba-pl011: move header content to .c
config: arm-randconfig-r013-20220421 (https://download.01.org/0day-ci/archive/20220422/202204220445.8rhFIlg0-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project bac6cd5bf85669e3376610cfc4c4f9ca015e7b9b)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm cross compiling tool for clang build
        # apt-get install binutils-arm-linux-gnueabi
        # https://git.kernel.org/pub/scm/linux/kernel/git/jirislaby/linux.git/commit/?id=01ba379ed8413be7b65a53ab02f0d044233857f3
        git remote add jirislaby https://git.kernel.org/pub/scm/linux/kernel/git/jirislaby/linux.git
        git fetch --no-tags jirislaby devel
        git checkout 01ba379ed8413be7b65a53ab02f0d044233857f3
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> drivers/tty/serial/amba-pl011.c:45:10: fatal error: 'amba-pl011.h' file not found
   #include "amba-pl011.h"
            ^~~~~~~~~~~~~~
   1 error generated.


vim +45 drivers/tty/serial/amba-pl011.c

^1da177e4c3f41 drivers/serial/amba-pl011.c     Linus Torvalds 2005-04-16  44  
9f25bc510e960c drivers/tty/serial/amba-pl011.c Russell King   2015-11-03 @45  #include "amba-pl011.h"
9f25bc510e960c drivers/tty/serial/amba-pl011.c Russell King   2015-11-03  46  

:::::: The code at line 45 was first introduced by commit
:::::: 9f25bc510e960c551dc295c2d1d60e3da334590c tty: amba-pl011: prepare REG_* register indexes

:::::: TO: Russell King <rmk+kernel@arm.linux.org.uk>
:::::: CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
