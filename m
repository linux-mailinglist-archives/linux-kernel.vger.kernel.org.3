Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B5B2509FB3
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 14:33:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384629AbiDUMey (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 08:34:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353159AbiDUMew (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 08:34:52 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CB4920BE3
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 05:32:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650544323; x=1682080323;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=PMqVe53Hbsg7k9hFURsqKFTi+ZF+K3jn57xT2aqbFkg=;
  b=LRuq/8GqOv8KNGtgoIQWQPQVioZMEoL+kDvpDV+jEbvTE+PJXrS9jK8C
   flzt+xfjv89vpPamUSPMTZZ7rwcFhDuWmWpNdIVQc73/DRws4VzXYRZqw
   NUn+rMiyuIRjdHoO9ktudTRCjyewsgS0rXRqLOW47vyf0kywOqtXnkR90
   wo87xHCuxTqJrBeB9I8I+hGnTzmaWH/My4kr3CtjOBk1cFvPtT/N1i6Sr
   9r1jPgSa2pkcguaysvmPOURzyTqqGP2vZjK35JXPvQfojAI7sgDOSPnld
   t0vOb9K+NKTdzhA5SFlk8Vml1gZXn8D7OeOLPWgSy2UeQLsAzEo5ZOU0e
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10323"; a="264503467"
X-IronPort-AV: E=Sophos;i="5.90,278,1643702400"; 
   d="scan'208";a="264503467"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2022 05:32:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,278,1643702400"; 
   d="scan'208";a="626497600"
Received: from lkp-server01.sh.intel.com (HELO 3abc53900bec) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 21 Apr 2022 05:32:02 -0700
Received: from kbuild by 3abc53900bec with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nhVyb-0008OF-HX;
        Thu, 21 Apr 2022 12:32:01 +0000
Date:   Thu, 21 Apr 2022 20:31:06 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [mingo-tip:sched/headers 102/2579]
 ./usr/include/asm-generic/shmbuf.h:9:10: fatal error:
 'uapi/asm-generic/ipcbuf.h' file not found
Message-ID: <202204212023.dIkUxbJS-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git sched/headers
head:   49e1ec6c70a6eb4b7de9250a455b8b63eb42afbe
commit: 303c55f2ed6ecc81b7b19a796a9d3562e99b350c [102/2579] headers/deps: Remove <linux/sem.h> from <linux/sched.h>
config: x86_64-randconfig-a013-20220418 (https://download.01.org/0day-ci/archive/20220421/202204212023.dIkUxbJS-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 429cbac0390654f90bba18a41799464adf31a5ec)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git/commit/?id=303c55f2ed6ecc81b7b19a796a9d3562e99b350c
        git remote add mingo-tip git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git
        git fetch --no-tags mingo-tip sched/headers
        git checkout 303c55f2ed6ecc81b7b19a796a9d3562e99b350c
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

Note: the mingo-tip/sched/headers HEAD 49e1ec6c70a6eb4b7de9250a455b8b63eb42afbe builds fine.
      It only hurts bisectability.

All errors (new ones prefixed by >>):

   In file included from <built-in>:1:
   In file included from ./usr/include/linux/shm.h:26:
   In file included from ./usr/include/asm/shmbuf.h:6:
>> ./usr/include/asm-generic/shmbuf.h:9:10: fatal error: 'uapi/asm-generic/ipcbuf.h' file not found
   #include <uapi/asm-generic/ipcbuf.h>
            ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   1 error generated.

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
