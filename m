Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66C79508094
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 07:27:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243677AbiDTF3z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 01:29:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231937AbiDTF3v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 01:29:51 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1D9F3614D
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 22:27:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650432426; x=1681968426;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=kwdrcbUeYDAMMJmmHHBlWjyBPoeqAG9YmWEn6RV6OfU=;
  b=B46OEzMBL0cOUqHW3JrF6W6VcE//N54gqpoeoLeMI8CW76CPpYhScZk4
   a5VVWYQ2yKUfZtYN67lee1GbXKoGrUy/gFzMo92wQk4cmx3ZsCc9QfxWe
   Y+dnQKxqWbJiaM5Y8Axq/nmYp3IabQW/pz4zsSFysNWyB3zBKOMNylr9n
   p6bbZQ80wtysv4VCbfH9afJRp5D/ZWxtAWxRg4U0NHREwNI++MU83pCO3
   OTvvSr1h9mzQxPVDyJJqljAmFZPVUw4gW7EhAiE0tmZi3LxCjPSorKvqu
   Svl/7UDNQCy7RMk4Mtw/ism4IXBgY1sE25TUHingK/U8va4Q1Vt+Wq1rN
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10322"; a="243875073"
X-IronPort-AV: E=Sophos;i="5.90,274,1643702400"; 
   d="scan'208";a="243875073"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2022 22:27:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,274,1643702400"; 
   d="scan'208";a="510413249"
Received: from lkp-server01.sh.intel.com (HELO 3abc53900bec) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 19 Apr 2022 22:27:05 -0700
Received: from kbuild by 3abc53900bec with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nh2ro-0006ba-HD;
        Wed, 20 Apr 2022 05:27:04 +0000
Date:   Wed, 20 Apr 2022 13:26:02 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [mingo-tip:sched/headers 1453/2579] arch/mips/vdso/genvdso.c:21:10:
 fatal error: linux/mm_api.h: No such file or directory
Message-ID: <202204201324.Q6K7rbCQ-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git sched/headers
head:   49e1ec6c70a6eb4b7de9250a455b8b63eb42afbe
commit: 4eb7f06cbb9a0539016473ab509c83b5c9c50127 [1453/2579] headers/deps: Add header dependencies to .c files: <linux/mm_api.h>
config: mips-randconfig-r032-20220419 (https://download.01.org/0day-ci/archive/20220420/202204201324.Q6K7rbCQ-lkp@intel.com/config)
compiler: mipsel-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git/commit/?id=4eb7f06cbb9a0539016473ab509c83b5c9c50127
        git remote add mingo-tip git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git
        git fetch --no-tags mingo-tip sched/headers
        git checkout 4eb7f06cbb9a0539016473ab509c83b5c9c50127
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross W=1 O=build_dir ARCH=mips SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> arch/mips/vdso/genvdso.c:21:10: fatal error: linux/mm_api.h: No such file or directory
      21 | #include <linux/mm_api.h>
         |          ^~~~~~~~~~~~~~~~
   compilation terminated.

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for SSB_EMBEDDED
   Depends on SSB && SSB_DRIVER_MIPS && SSB_PCICORE_HOSTMODE
   Selected by
   - BCM47XX_SSB && BCM47XX


vim +21 arch/mips/vdso/genvdso.c

  > 21	#include <linux/mm_api.h>
    22	#include <sys/mman.h>
    23	#include <sys/stat.h>
    24	#include <sys/types.h>
    25	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
