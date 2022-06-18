Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86D035506B3
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Jun 2022 22:42:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230480AbiFRUln (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Jun 2022 16:41:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbiFRUlf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jun 2022 16:41:35 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A44D211C02
        for <linux-kernel@vger.kernel.org>; Sat, 18 Jun 2022 13:41:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655584894; x=1687120894;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=khlXxBNtw9otyLIH7to3c6AMa7OD9qLduT03+uTNd/s=;
  b=gZE1ALl+weJDTRY9bVqWZdSjtpbbvLxgeSxCF6LfOkzMZU8utKyiphwx
   ACI4k1eRWnGT7Kxjrv8yZl2cnB/SWZH3voysuU/2YV3znibuRJSBdOR+M
   yPidUGMJHGyazLkPrcFkADWaeOcrq6qEu/kLqHw8JnqA9ZXlbUzkpzFBU
   lRz7lsvRyR3KJAc6Vk4bh+20pWDYA2Q+Xpxa1xt7+q857iPAb77Be/474
   tUmeOPZscVLhU8IXrf6lQiyQovjq1gBQGNlOo4VLaFvD/rQx+t/Lr6EtP
   WvqrsDVelJSfdK3Y7S5QFfnaZJuO5xRAf5srajb5zLUvW/bFhRt0izYsd
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10380"; a="260109992"
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="260109992"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2022 13:41:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="584419932"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 18 Jun 2022 13:41:32 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o2fG8-000Qa9-3Q;
        Sat, 18 Jun 2022 20:41:32 +0000
Date:   Sun, 19 Jun 2022 04:41:26 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org
Subject: [ammarfaizi2-block:axboe/linux-block/for-5.20/io_uring-cancel 98/98]
 ./usr/include/linux/io_uring.h:573:41: error: field 'timeout' has incomplete
 type
Message-ID: <202206190428.1ubitzgx-lkp@intel.com>
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

tree:   https://github.com/ammarfaizi2/linux-block axboe/linux-block/for-5.20/io_uring-cancel
head:   c96865d6b624236f64b285734357c704a8fbf10c
commit: c96865d6b624236f64b285734357c704a8fbf10c [98/98] io_uring: add sync cancelation API through io_uring_register()
config: x86_64-randconfig-a006 (https://download.01.org/0day-ci/archive/20220619/202206190428.1ubitzgx-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-3) 11.3.0
reproduce (this is a W=1 build):
        # https://github.com/ammarfaizi2/linux-block/commit/c96865d6b624236f64b285734357c704a8fbf10c
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block axboe/linux-block/for-5.20/io_uring-cancel
        git checkout c96865d6b624236f64b285734357c704a8fbf10c
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from <command-line>:
>> ./usr/include/linux/io_uring.h:573:41: error: field 'timeout' has incomplete type
     573 |         struct __kernel_timespec        timeout;
         |                                         ^~~~~~~

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
