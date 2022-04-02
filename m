Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E5674F0159
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Apr 2022 14:09:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242091AbiDBMJn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Apr 2022 08:09:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231302AbiDBMJl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Apr 2022 08:09:41 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E05A16E23A
        for <linux-kernel@vger.kernel.org>; Sat,  2 Apr 2022 05:07:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648901270; x=1680437270;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=W+L7BoXCLKO5t1VVJHLR7NwuuTQfL8hpjoZxZWDmZC4=;
  b=Pf/QQfRBm//GrQU8PmwigD5pYYHiD/ms7Ukh2Ko8q2vyddAEiRcXdtI6
   Do/z4OtiV+MYBpu9jLibuXFhEB6nxu0Q2Nk2DJgDYue44RYHlBAGK26py
   KOx0igumkMicgv2YtbXSEQke3x44ZJFWlqIwOKHMmwO3CitkZwbxDlf9k
   /tyWUR7uJOpaK1mToliDVbsIHmoTUeKQ8KXdwKaCnbMc5cxHAO6rdMjEU
   2h1vj1xNKxdUk1C7b69441GbNpo5CIYKohP5KikBIIv+GQaKTvD4a+lAK
   LBJj2Pc7w5skYJsvQxVeS5uSZ9EbzGxEidnO3a64pLVuWsxdf1e7Je4Vo
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10304"; a="260284769"
X-IronPort-AV: E=Sophos;i="5.90,230,1643702400"; 
   d="scan'208";a="260284769"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2022 05:07:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,230,1643702400"; 
   d="scan'208";a="504447201"
Received: from lkp-server02.sh.intel.com (HELO a44fdfb70b94) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 02 Apr 2022 05:07:48 -0700
Received: from kbuild by a44fdfb70b94 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nacXj-00007T-TO;
        Sat, 02 Apr 2022 12:07:47 +0000
Date:   Sat, 2 Apr 2022 20:07:24 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jeffle Xu <jefflexu@linux.alibaba.com>
Cc:     kbuild-all@lists.01.org, Xiang Gao <xiang@kernel.org>,
        linux-kernel@vger.kernel.org,
        Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [xiang:jeffle/fscache 3/20] ERROR: modpost: "__f_unlock_pos"
 [fs/cachefiles/cachefiles.ko] undefined!
Message-ID: <202204022026.Ega6tzhd-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/xiang/linux.git jeffle/fscache
head:   f265c5a83357b9b14124da2313473b125e9c8ae9
commit: 5bb73c5f300413cc7913919eac4d3f90bddff581 [3/20] cachefiles: notify user daemon with anon_fd when looking up cookie
config: mips-allmodconfig (https://download.01.org/0day-ci/archive/20220402/202204022026.Ega6tzhd-lkp@intel.com/config)
compiler: mips-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/xiang/linux.git/commit/?id=5bb73c5f300413cc7913919eac4d3f90bddff581
        git remote add xiang https://git.kernel.org/pub/scm/linux/kernel/git/xiang/linux.git
        git fetch --no-tags xiang jeffle/fscache
        git checkout 5bb73c5f300413cc7913919eac4d3f90bddff581
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=mips SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>, old ones prefixed by <<):

>> ERROR: modpost: "__f_unlock_pos" [fs/cachefiles/cachefiles.ko] undefined!
>> ERROR: modpost: "__fdget_pos" [fs/cachefiles/cachefiles.ko] undefined!

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
