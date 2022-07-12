Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C868572189
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 19:05:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231321AbiGLRFa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 13:05:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229760AbiGLRF2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 13:05:28 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA1A4BDBAC
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 10:05:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657645527; x=1689181527;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=U/LXGy7z+UX9UqdYooR6+SHEaSx51YHHs9OChHxVj9k=;
  b=ZFehXT8BnmOuMQ/a2RzT5fIlsUtooQ5ANOh6KvxqNHHhP0fDwsg1UTJN
   SDeU3S9o7kPV2Z2YgPjuGg3mFaZSXHq9SwNNLNMxYWwORN19S6pgSElAb
   DZ2/g+yxqTRhiG8ChfkbKrTuikvO9Xo/XxQuFgjYk0KZDZ4IurAK/Vvr4
   kb5z8qmnbKx3AAtoXx9qHSCS8ThNaUQb6NyiYbN+W/IsrIwx1bdLuGo4O
   0GQYJHuMmkscwgzz0rhIEQ4NdZ6AbOicsbdLeexvcymqyZt/yYbqoOV0s
   Dd/jS8d+Af6/R2u3RFssXnwfeZYusnmP7Mq9oh8smwrDMqyAzxOEqZdwF
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10406"; a="286120842"
X-IronPort-AV: E=Sophos;i="5.92,266,1650956400"; 
   d="scan'208";a="286120842"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2022 10:05:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,266,1650956400"; 
   d="scan'208";a="771946030"
Received: from lkp-server02.sh.intel.com (HELO 8708c84be1ad) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 12 Jul 2022 10:05:26 -0700
Received: from kbuild by 8708c84be1ad with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1oBJK9-0002Tt-RU;
        Tue, 12 Jul 2022 17:05:25 +0000
Date:   Wed, 13 Jul 2022 01:04:47 +0800
From:   kernel test robot <lkp@intel.com>
To:     Dominique Martinet <asmadeus@codewreck.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [martinetd:9p-next 11/11] net/9p/trans_fd.c:275:12: warning:
 'failme' defined but not used
Message-ID: <202207130129.m6d1HPhz-lkp@intel.com>
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

tree:   https://github.com/martinetd/linux.git 9p-next
head:   c249fb4f91931b9f010849134e95d33e388c375b
commit: c249fb4f91931b9f010849134e95d33e388c375b [11/11] 9p: roll p9_tag_remove into p9_req_put
config: i386-defconfig (https://download.01.org/0day-ci/archive/20220713/202207130129.m6d1HPhz-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-3) 11.3.0
reproduce (this is a W=1 build):
        # https://github.com/martinetd/linux/commit/c249fb4f91931b9f010849134e95d33e388c375b
        git remote add martinetd https://github.com/martinetd/linux.git
        git fetch --no-tags martinetd 9p-next
        git checkout c249fb4f91931b9f010849134e95d33e388c375b
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash net/9p/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> net/9p/trans_fd.c:275:12: warning: 'failme' defined but not used [-Wunused-variable]
     275 | static int failme;
         |            ^~~~~~


vim +/failme +275 net/9p/trans_fd.c

   268	
   269	/**
   270	 * p9_read_work - called when there is some data to be read from a transport
   271	 * @work: container of work to be done
   272	 *
   273	 */
   274	
 > 275	static int failme;
   276	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
