Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDA0549EA3B
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 19:18:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239374AbiA0SSM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 13:18:12 -0500
Received: from mga07.intel.com ([134.134.136.100]:34121 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231634AbiA0SSJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 13:18:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643307489; x=1674843489;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=pGoLZHnI73YgEmn98ZskkLkKABqXikyEfgK+5FHE6bI=;
  b=LqqwBSdTSsv/64//XkeWdGmdr5RSuOZU1p9uoZQLKIwp6R+s3o02rzB8
   WX+KZZaaf7GyIjcnaQzMzPG9B1a9j2VhVvGbEQJvN8q31bfzkUKP8/L1R
   TbrgtXAne6f9KFdYfjSAvcukNxPXQ7fxnVFQXoVPCMIss9+741QbZ2uHq
   k/Tzuq6Yt2armdkTOScKOtcoiyAlRSuBF7ej3DgDkRNCBCmihT4pYnSOh
   m3U1zfQS9Myd59ghfz4W3x9sIb100cM031AEK/pqamTMQQh+kh/7dp2zo
   y2ypdbdtyc1XyBCQKIC7WTYgoiKbZb+0pC67fzIsU1R9sjyk5p7B6IbPI
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10239"; a="310244619"
X-IronPort-AV: E=Sophos;i="5.88,321,1635231600"; 
   d="scan'208";a="310244619"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2022 10:18:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,321,1635231600"; 
   d="scan'208";a="521337648"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 27 Jan 2022 10:18:07 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nD9LS-000Mu2-GH; Thu, 27 Jan 2022 18:18:06 +0000
Date:   Fri, 28 Jan 2022 02:17:20 +0800
From:   kernel test robot <lkp@intel.com>
To:     Matthew Maurer <mmaurer@google.com>
Cc:     kbuild-all@lists.01.org, GNU/Weeb Mailing List <gwml@gnuweeb.org>,
        linux-kernel@vger.kernel.org,
        Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>
Subject: [ammarfaizi2-block:google/android/kernel/common/android12-trusty-5.10
 5854/5866] ERROR: modpost: "trusty_dma_buf_get_ffa_tag"
 [drivers/trusty/trusty-ipc.ko] undefined!
Message-ID: <202201280205.HX0qfTsU-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ammarfaizi2/linux-block google/android/kernel/common/android12-trusty-5.10
head:   52cdd137fae0b001197a51646289e3cbdda921d5
commit: 988b52b392a13c1b710e9ffdc5de9f933de77551 [5854/5866] ANDROID: trusty: Support setting FF-A Tag
config: arm-allmodconfig (https://download.01.org/0day-ci/archive/20220128/202201280205.HX0qfTsU-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/ammarfaizi2/linux-block/commit/988b52b392a13c1b710e9ffdc5de9f933de77551
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block google/android/kernel/common/android12-trusty-5.10
        git checkout 988b52b392a13c1b710e9ffdc5de9f933de77551
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arm SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>, old ones prefixed by <<):

>> ERROR: modpost: "trusty_dma_buf_get_ffa_tag" [drivers/trusty/trusty-ipc.ko] undefined!

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
