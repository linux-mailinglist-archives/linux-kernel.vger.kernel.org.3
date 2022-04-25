Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF54450EB45
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 23:20:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245750AbiDYVWw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 17:22:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245753AbiDYVWu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 17:22:50 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5E85114FBA
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 14:19:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650921581; x=1682457581;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=ExmHMAfPVHfO/JdQ0nxz2QT074iA2w9jqfnValNd+OI=;
  b=KfkpT4nD0teBvNpFNJdk28PqWoADC3RszqYe7LG189yWIDl1HIId3DQU
   uRdkKaGMypO7IPEgXkbQWI5o1UmdHvD3eGPlAG9kYXnwgA4qxg4NmsUTf
   M+1Tha88Wm7iU4SPR0smI8VOzn/STTBAeuKwD4beUahJgMw1rJNe1PUVk
   yJtpc0bHVkKcAPadCOZUzk7YriF6Ek42wPznryZz4VO5ArzOY0NqVS08K
   qxb6MVfBVjzJK0Y/u84Ylk72u5URKijyQ4u1hdJS6M9m3Qw+IrcdbiRpQ
   mAs3FMnfpwo85vV12APrBrMFkDDizvYuFLGdN0Hc2uvQYtGTzz0dqeA9n
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10328"; a="245291988"
X-IronPort-AV: E=Sophos;i="5.90,289,1643702400"; 
   d="scan'208";a="245291988"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2022 14:19:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,289,1643702400"; 
   d="scan'208";a="595413541"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 25 Apr 2022 14:19:33 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nj67I-0002tM-9R;
        Mon, 25 Apr 2022 21:19:32 +0000
Date:   Tue, 26 Apr 2022 05:18:35 +0800
From:   kernel test robot <lkp@intel.com>
To:     Dai Ngo <dai.ngo@oracle.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Chuck Lever <chuck.lever@oracle.com>
Subject: [cel:nfsd-courteous-server 3/7] ERROR: modpost: "laundry_wq"
 [fs/nfsd/nfsd.ko] undefined!
Message-ID: <202204260546.DetnHYRq-lkp@intel.com>
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

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/cel/linux nfsd-courteous-server
head:   f5af813d2e996e3c4ea5c54a72693c4e9a8dd842
commit: f5801355cac36f76ad08e99c1159817d73e0ef85 [3/7] NFSD: move create/destroy of laundry_wq to init_nfsd and exit_nfsd
config: m68k-q40_defconfig (https://download.01.org/0day-ci/archive/20220426/202204260546.DetnHYRq-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git/commit/?id=f5801355cac36f76ad08e99c1159817d73e0ef85
        git remote add cel git://git.kernel.org/pub/scm/linux/kernel/git/cel/linux
        git fetch --no-tags cel nfsd-courteous-server
        git checkout f5801355cac36f76ad08e99c1159817d73e0ef85
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=m68k SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>, old ones prefixed by <<):

>> ERROR: modpost: "laundry_wq" [fs/nfsd/nfsd.ko] undefined!

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
