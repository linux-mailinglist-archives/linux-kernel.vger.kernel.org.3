Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF00851DF9A
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 21:16:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1390311AbiEFTTs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 15:19:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1385702AbiEFTTp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 15:19:45 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 778BA237F5
        for <linux-kernel@vger.kernel.org>; Fri,  6 May 2022 12:16:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651864561; x=1683400561;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=GAs5M9aaPMAmYtox6cAb0wycfcacPCY61CJ/1Zh7f1s=;
  b=NRVKHuLSV3rGIOqZpicGtYJHqMHvYxTKnG6yALDrOK2ufLs3olWaw0R/
   OYUz+DfzRfMEAxrQACG4XFuguBOimzrwFeZDTJVzDS81aUVE6ZAm1rWkV
   SIkMZYDdvl6aTElRq4X8KexZ3DwO0Hqq0yzLObTgRI9B2iQkXWix4U3ix
   emRETk1rKMcFoJuCKzRxGaiO0csWyYQomOdzwr2OGccNz9tI24ITLJwEC
   wrb9iJMf2JHd04hTJP2e78SfNy4Mt6BL98zS4B8g6SBmDSrZkwlZ7efdN
   fIoyxzX8/GxGX6fF6ucEwqdsDjmu3EvOnTGdi5CJZQ3ySrr8wq+9d1s36
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10339"; a="354989206"
X-IronPort-AV: E=Sophos;i="5.91,205,1647327600"; 
   d="scan'208";a="354989206"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2022 12:16:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,205,1647327600"; 
   d="scan'208";a="654830294"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 06 May 2022 12:15:59 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nn3Qk-000DnY-Nb;
        Fri, 06 May 2022 19:15:58 +0000
Date:   Sat, 7 May 2022 03:15:49 +0800
From:   kernel test robot <lkp@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        x86@kernel.org, Borislav Petkov <bp@suse.de>
Subject: [tip:x86/asm 12/12] include/linux/objtool.h:5:10: fatal error:
 asm/asm.h: No such file or directory
Message-ID: <202205070302.5S7yoOTI-lkp@intel.com>
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

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/asm
head:   38f3803fb4fa588ef7645048285493efbe264d79
commit: 38f3803fb4fa588ef7645048285493efbe264d79 [12/12] objtool: Fix STACK_FRAME_NON_STANDARD reloc type
config: arc-randconfig-r043-20220506 (https://download.01.org/0day-ci/archive/20220507/202205070302.5S7yoOTI-lkp@intel.com/config)
compiler: arc-elf-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/commit/?id=38f3803fb4fa588ef7645048285493efbe264d79
        git remote add tip https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
        git fetch --no-tags tip x86/asm
        git checkout 38f3803fb4fa588ef7645048285493efbe264d79
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=arc SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from kernel/bpf/core.c:28:
>> include/linux/objtool.h:5:10: fatal error: asm/asm.h: No such file or directory
       5 | #include <asm/asm.h>
         |          ^~~~~~~~~~~
   compilation terminated.


vim +5 include/linux/objtool.h

     4	
   > 5	#include <asm/asm.h>
     6	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
