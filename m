Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F8735A3986
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Aug 2022 20:36:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230304AbiH0SgP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Aug 2022 14:36:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229932AbiH0SgM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Aug 2022 14:36:12 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 392AE2B613
        for <linux-kernel@vger.kernel.org>; Sat, 27 Aug 2022 11:36:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661625371; x=1693161371;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=koHL5CUm0Rm3QSvTUTxrrp9dPRvyCW/mFKcL42YZD6c=;
  b=mRX7gEuag8orSyLDQRIMxj6/fi5yo9Jf8jZBw7IztvI4Wbrw5ZIIipPi
   IRBnmlPX3UJh4K89bUCPgS7rQbBHVOmb60fcL9yYPSvlDZrOd5wlWpRS4
   oqtVAWFY/xj0yoDxuay41j/WeDZnOWejPIEl2HqTsZri/6W4NgzBZRtcd
   v8MlAnLhxMK0tHBAd5Qg+7yWuZEhmqqurF2peh91PB/yL9g88T+HbS8Nf
   VkvFW9iRr2lHDh1rMicenn5GxGY5sC4S82h5I6LbY4mhlbpHswamxFTPw
   qVixAXBNekql4nHjjBopMFSD0aZxsnhUMGmK5QGkyNc3Cw6n0biRIjrmP
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10452"; a="292262320"
X-IronPort-AV: E=Sophos;i="5.93,269,1654585200"; 
   d="scan'208";a="292262320"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2022 11:36:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,269,1654585200"; 
   d="scan'208";a="644000802"
Received: from lkp-server01.sh.intel.com (HELO fc16deae1c42) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 27 Aug 2022 11:36:08 -0700
Received: from kbuild by fc16deae1c42 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oS0fA-0000NE-0q;
        Sat, 27 Aug 2022 18:36:08 +0000
Date:   Sun, 28 Aug 2022 02:35:32 +0800
From:   kernel test robot <lkp@intel.com>
To:     Shaomin Deng <dengshaomin@cdjrlc.com>, agk@redhat.com,
        snitzer@kernel.org, dm-devel@redhat.com,
        linux-kernel@vger.kernel.org
Cc:     kbuild-all@lists.01.org, Shaomin Deng <dengshaomin@cdjrlc.com>
Subject: Re: [PATCH] dm: Remove the unneeeded variable
Message-ID: <202208280213.3Ws9aJBm-lkp@intel.com>
References: <20220827163848.24296-1-dengshaomin@cdjrlc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220827163848.24296-1-dengshaomin@cdjrlc.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Shaomin,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on v6.0-rc2]
[also build test ERROR on linus/master next-20220826]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Shaomin-Deng/dm-Remove-the-unneeeded-variable/20220828-004044
base:    1c23f9e627a7b412978b4e852793c5e3c3efc555
config: x86_64-defconfig (https://download.01.org/0day-ci/archive/20220828/202208280213.3Ws9aJBm-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-5) 11.3.0
reproduce (this is a W=1 build):
        # https://github.com/intel-lab-lkp/linux/commit/fd20974ffc753b102401c766eb62117c276a1527
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Shaomin-Deng/dm-Remove-the-unneeeded-variable/20220828-004044
        git checkout fd20974ffc753b102401c766eb62117c276a1527
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from include/linux/dm-dirty-log.h:16,
                    from drivers/md/dm-log.c:13:
   drivers/md/dm-log.c: In function 'disk_status':
>> include/linux/device-mapper.h:615:22: error: 'sz' undeclared (first use in this function); did you mean 's8'?
     615 | #define DMEMIT(x...) sz += ((sz >= maxlen) ? \
         |                      ^~
   drivers/md/dm-log.c:810:17: note: in expansion of macro 'DMEMIT'
     810 |                 DMEMIT("3 %s %s %c", log->type->name, lc->log_dev->name,
         |                 ^~~~~~
   include/linux/device-mapper.h:615:22: note: each undeclared identifier is reported only once for each function it appears in
     615 | #define DMEMIT(x...) sz += ((sz >= maxlen) ? \
         |                      ^~
   drivers/md/dm-log.c:810:17: note: in expansion of macro 'DMEMIT'
     810 |                 DMEMIT("3 %s %s %c", log->type->name, lc->log_dev->name,
         |                 ^~~~~~


vim +615 include/linux/device-mapper.h

0da336e5fab75c Alasdair G Kergon 2008-04-24  614  
0da336e5fab75c Alasdair G Kergon 2008-04-24 @615  #define DMEMIT(x...) sz += ((sz >= maxlen) ? \
0da336e5fab75c Alasdair G Kergon 2008-04-24  616  			  0 : scnprintf(result + sz, maxlen - sz, x))
0da336e5fab75c Alasdair G Kergon 2008-04-24  617  

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
