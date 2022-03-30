Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A29514EBD05
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 10:56:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244486AbiC3I6K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 04:58:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241961AbiC3I6C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 04:58:02 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8603C133DBB
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 01:56:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648630578; x=1680166578;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=SDwP7+t69WD6530TWyZPeK6zEBoSkgsHq+ayCPYFfyM=;
  b=RNiBH1gKZS1lTIH4phI3yWjjhqAlOWO9EvnlH6NXv1rEMiwsA4n/DG6V
   /U8LkZ5SofdI8kkzpfQqO1Iyhu3sGysnSt6i+8rjdubLxT24Ws7x5gO/5
   tGyr6qY3CqDa4Rz0wN8FKGQNwOFh4qiDa16QVyJkZwTIqBjedqVYhE4nK
   ByrrnqR1YjhyK802y3YE0Z5Oca0DTUSyZ/zj+2T2IWlt894waJK6BWMHM
   TEJkniL30zmUTScsmXQnEJupGCx/TRUeOcVOGrOlUKSecBMPnAqoqJmxG
   HQC3dK6l0qnEVtb7q9easgna4StahJ0rZ6uO66+kIYUJEDDNUaS2d1pDd
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10301"; a="240084419"
X-IronPort-AV: E=Sophos;i="5.90,222,1643702400"; 
   d="scan'208";a="240084419"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2022 01:56:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,222,1643702400"; 
   d="scan'208";a="503237336"
Received: from lkp-server02.sh.intel.com (HELO 7a008980c4ea) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 30 Mar 2022 01:56:16 -0700
Received: from kbuild by 7a008980c4ea with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nZU7j-0000AH-TI; Wed, 30 Mar 2022 08:56:15 +0000
Date:   Wed, 30 Mar 2022 16:55:59 +0800
From:   kernel test robot <lkp@intel.com>
To:     Matthew Maurer <mmaurer@google.com>
Cc:     kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org,
        Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>
Subject: [ammarfaizi2-block:google/android/kernel/common/android12-trusty-5.10
 5854/5872] ERROR: modpost: "trusty_dma_buf_get_ffa_tag"
 [drivers/trusty/trusty-ipc.ko] undefined!
Message-ID: <202203301644.1prdbsrp-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matthew,

FYI, the error/warning still remains.

tree:   https://github.com/ammarfaizi2/linux-block google/android/kernel/common/android12-trusty-5.10
head:   07055bfd3d810d41a38354693dfaa55a6f8c0025
commit: 988b52b392a13c1b710e9ffdc5de9f933de77551 [5854/5872] ANDROID: trusty: Support setting FF-A Tag
config: arm-allmodconfig (https://download.01.org/0day-ci/archive/20220330/202203301644.1prdbsrp-lkp@intel.com/config)
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

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
