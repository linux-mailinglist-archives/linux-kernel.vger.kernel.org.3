Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (unknown [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6192B59B0EB
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Aug 2022 01:44:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234468AbiHTXm0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Aug 2022 19:42:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231510AbiHTXmY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Aug 2022 19:42:24 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1E1933341
        for <linux-kernel@vger.kernel.org>; Sat, 20 Aug 2022 16:42:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661038942; x=1692574942;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=bq9lQODtCgTCMYvCpj7ZlkJWzxsNbbH0OLNleYcbOOc=;
  b=h6xd2tu4SoNwRnZEykzcQHpkbVP/qq0zT6505XFjbq8PKTBzf1n1AJIK
   TOeI+ZwGetrrcUiMP4P3JOFASrZVQoDZ93MhUYp4SjpcPyq15/WGr6Hux
   8PUux0szOLDxDMC5X2kUOF6lRli7B6IlMKEB3bO176qcdH5ZlveUCOTQR
   YYGUTL81WpR5vpR6EeqReIlcarOStnxH48+m9RheXJJez15F20GeN6zTu
   eBhPRCoeOhuS6LS4Lo9zvHswgCwZcV9sLAg0vwDT8rY74jmJmrzdlMsUF
   PgzfLd35328e4bT0CDg37zdLTiuCbkDgzSvhvMq7bG9770VEaCr9JxBsf
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10445"; a="293209206"
X-IronPort-AV: E=Sophos;i="5.93,251,1654585200"; 
   d="scan'208";a="293209206"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2022 16:42:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,251,1654585200"; 
   d="scan'208";a="936595274"
Received: from lkp-server01.sh.intel.com (HELO 44b6dac04a33) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 20 Aug 2022 16:42:21 -0700
Received: from kbuild by 44b6dac04a33 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oPY6e-0003M7-1v;
        Sat, 20 Aug 2022 23:42:20 +0000
Date:   Sun, 21 Aug 2022 07:41:15 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Jason A. Donenfeld" <zx2c4@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [linux-stable-rc:linux-5.10.y 7936/7987]
 include/linux/types.h:30:33: error: two or more data types in declaration
 specifiers
Message-ID: <202208210710.fFNAH58i-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.10.y
head:   879ffc7efcbe48e91264fd3bd3ec52cbcf69114c
commit: 56660dd43bbfcd7b0a6872f3ceb0c924fe2f5af9 [7936/7987] um: seed rng using host OS rng
config: um-kunit_defconfig (https://download.01.org/0day-ci/archive/20220821/202208210710.fFNAH58i-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-5) 11.3.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git/commit/?id=56660dd43bbfcd7b0a6872f3ceb0c924fe2f5af9
        git remote add linux-stable-rc https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
        git fetch --no-tags linux-stable-rc linux-5.10.y
        git checkout 56660dd43bbfcd7b0a6872f3ceb0c924fe2f5af9
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=um SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   cc1: warning: arch/um/include/uapi: No such file or directory [-Wmissing-include-dirs]
   In file included from arch/um/include/shared/irq_user.h:10,
                    from arch/um/include/shared/os.h:12,
                    from arch/um/kernel/umid.c:9:
>> include/linux/stddef.h:11:9: error: expected identifier before numeric constant
      11 |         false   = 0,
         |         ^~~~~
>> include/linux/types.h:30:33: error: two or more data types in declaration specifiers
      30 | typedef _Bool                   bool;
         |                                 ^~~~
   In file included from arch/um/include/shared/os.h:17,
                    from arch/um/kernel/umid.c:9:
   include/linux/types.h:30:1: warning: useless type name in empty declaration
      30 | typedef _Bool                   bool;
         | ^~~~~~~


vim +30 include/linux/types.h

^1da177e4c3f415 Linus Torvalds   2005-04-16  29  
6e2182874324727 Richard Knutsson 2006-09-30 @30  typedef _Bool			bool;
6e2182874324727 Richard Knutsson 2006-09-30  31  

:::::: The code at line 30 was first introduced by commit
:::::: 6e21828743247270d09a86756a0c11702500dbfb [PATCH] Generic boolean

:::::: TO: Richard Knutsson <ricknu-0@student.ltu.se>
:::::: CC: Linus Torvalds <torvalds@g5.osdl.org>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
