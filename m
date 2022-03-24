Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D6D94E5DD1
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 05:22:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242027AbiCXEXI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 00:23:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232518AbiCXEXG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 00:23:06 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CC7A90FD7
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 21:21:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648095695; x=1679631695;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=WEBXS2k33H89vevKP3bv3JQ48m7+OpWseWHyAcN/JS4=;
  b=nr4OwAH1HKuu0yAaxf0TRFmk9YTFYtCuZWKwE+zDME0bMxCeiIy/IOEp
   s5J9dt+dpI0EgELJoP0K5y1zP9a1sSCOGD8ZzGY9iXhFCnVOyQklgcBkM
   jrRWVYvGsyWHJbXKsy8sPWeK9CFslLqlTSHDbWEiTebXWwd76PukUSpjX
   CXgrMxCGLukL3VtF+NmPH+9Cc+w+izp02F5g5pMeuBpiJWcfHM/ecHkOL
   9r5Qrq2GBBxrakD1Shuyh9/w5ZOxpNC8vBi1HHMk5Dxn10CMiFXa0yuUy
   lPK4DA2E/x3jHlU0vlQBhN+AObphSfaeAunuwTf72uNk2Xp/B1u6K5QR1
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10295"; a="238885033"
X-IronPort-AV: E=Sophos;i="5.90,206,1643702400"; 
   d="scan'208";a="238885033"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2022 21:21:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,206,1643702400"; 
   d="scan'208";a="601552459"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by fmsmga008.fm.intel.com with ESMTP; 23 Mar 2022 21:21:30 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nXEyX-000Kgh-CO; Thu, 24 Mar 2022 04:21:29 +0000
Date:   Thu, 24 Mar 2022 12:21:04 +0800
From:   kernel test robot <lkp@intel.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Greg Ungerer <gerg@linux-m68k.org>
Subject: uboot.c:undefined reference to `_init_sp'
Message-ID: <202203241211.iGHRKXCk-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   d51b1b33c51d147b757f042b4d336603b699f362
commit: 8b22820efb35f93d98638563b0a8f4094e8ee399 m68k: m68328: remove duplicate code
date:   1 year, 4 months ago
config: m68k-buildonly-randconfig-r002-20220323 (https://download.01.org/0day-ci/archive/20220324/202203241211.iGHRKXCk-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=8b22820efb35f93d98638563b0a8f4094e8ee399
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 8b22820efb35f93d98638563b0a8f4094e8ee399
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=m68k SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   m68k-linux-ld: arch/m68k/kernel/uboot.o: in function `process_uboot_commandline':
>> uboot.c:(.init.text+0x32): undefined reference to `_init_sp'

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
