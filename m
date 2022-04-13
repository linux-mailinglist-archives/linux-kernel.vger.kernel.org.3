Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7309B4FED47
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 05:06:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231865AbiDMDHi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 23:07:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231970AbiDMDG7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 23:06:59 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2BAF54FA0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 20:04:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649819072; x=1681355072;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=dK7udxG6bgxJt7xKd4ClWjZpEriOEAWgaIkIvydR0Sg=;
  b=W17guCwz/jTY+v3UtaPT139QQIEeK5a/oknoCiyT7azUuC2Ali0sTWom
   OVAU7f9LDqHvfU//Tee7EX+YIBy3iWDbSxhaTiGUMRqhg0F7gl9YOF46f
   2KrLgZ/7XBhCQ3E5hq37aZfIQ0ywSLJu3d3L7h4XsvDF0Q15lb29tJ6nz
   PCpt4rKWZhGmYxiqdUKzc2vD2qjpkGrJ8MPrC0L7KEbkH5K9URVWZRgUn
   ZQbjmj0FhckF3asmPLTZNhibVjb8fjXbQIqBcSr6FLraRF3HIunz25GlT
   TO38MSD+HlZNbe/rQlXA6at5Djg/M5KbXcmWCQFwDjedjZvBtAPktLHxH
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10315"; a="262737405"
X-IronPort-AV: E=Sophos;i="5.90,255,1643702400"; 
   d="scan'208";a="262737405"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2022 20:04:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,255,1643702400"; 
   d="scan'208";a="700081100"
Received: from lkp-server02.sh.intel.com (HELO d3fc50ef50de) ([10.239.97.151])
  by fmsmga001.fm.intel.com with ESMTP; 12 Apr 2022 20:04:29 -0700
Received: from kbuild by d3fc50ef50de with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1neTIz-0003OI-6u;
        Wed, 13 Apr 2022 03:04:29 +0000
Date:   Wed, 13 Apr 2022 11:03:25 +0800
From:   kernel test robot <lkp@intel.com>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [mark:stacktrace/testing 1/1] ERROR: modpost:
 "kallsyms_lookup_size_offset" [lib/test_stacktrace/test_stacktrace.ko]
 undefined!
Message-ID: <202204131029.GIdIxZ9E-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git stacktrace/testing
head:   a8e8825116626f8c3e8be3bb889b6442a7465cb8
commit: a8e8825116626f8c3e8be3bb889b6442a7465cb8 [1/1] WIP: stacktrace tests
config: hexagon-randconfig-r041-20220412 (https://download.01.org/0day-ci/archive/20220413/202204131029.GIdIxZ9E-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project fe2478d44e4f7f191c43fef629ac7a23d0251e72)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git/commit/?id=a8e8825116626f8c3e8be3bb889b6442a7465cb8
        git remote add mark https://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git
        git fetch --no-tags mark stacktrace/testing
        git checkout a8e8825116626f8c3e8be3bb889b6442a7465cb8
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=hexagon SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All error/warnings (new ones prefixed by >>, old ones prefixed by <<):

>> ERROR: modpost: "kallsyms_lookup_size_offset" [lib/test_stacktrace/test_stacktrace.ko] undefined!
--
>> lib/test_stacktrace/kunit.c:54:5: warning: no previous prototype for function 'st_find_func_idx' [-Wmissing-prototypes]
   int st_find_func_idx(struct st_data *st, void *func, int start)
       ^
   lib/test_stacktrace/kunit.c:54:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   int st_find_func_idx(struct st_data *st, void *func, int start)
   ^
   static 
   1 warning generated.

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
