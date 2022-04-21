Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 116DB50A0BF
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 15:24:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356500AbiDUN0w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 09:26:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1385501AbiDUN0c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 09:26:32 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACF8436E1D
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 06:23:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650547416; x=1682083416;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=UVSxh8CbXTjBYQT0GwhNnPQhc0FfkGKPcK166DLDR14=;
  b=KZwig6YuXwCaBYypw4dqw+62fwqSHbJyRdogp320AQInZFa8QkJ0QpX9
   sBgsVK+mjCF5Okd3W3qEchzzyHXjvar3g6bRrgfEflvvn5sqpcVJx8ago
   6nYs4UanaQhndpm8qHpupYv4w9FV527rZ8DY4m6qdSVN1jR9yyfxqCOh4
   LTLGu+pXJuYoF3SYUiNfzTEHFhcq2SjPZYuP87ghMJe5GMZ6GXi6nqpXT
   zxzTZ1mq4rfNQjNS3hVj21vbU592MbRE6H/Wu8oWLZfMlGnc9Dk2RKFEL
   W6bzHoCYVym9CCrOGF7zPJcGNW8DMQFa5bSaXQXjLDJPUdZl3VojZlLSw
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10323"; a="350789941"
X-IronPort-AV: E=Sophos;i="5.90,278,1643702400"; 
   d="scan'208";a="350789941"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2022 06:23:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,278,1643702400"; 
   d="scan'208";a="511065067"
Received: from lkp-server01.sh.intel.com (HELO 3abc53900bec) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 21 Apr 2022 06:23:16 -0700
Received: from kbuild by 3abc53900bec with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nhWmB-0008Qp-A7;
        Thu, 21 Apr 2022 13:23:15 +0000
Date:   Thu, 21 Apr 2022 21:22:48 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jean-Marc Eurin <jmeurin@google.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [mtd:mtd/next 10/11] include/linux/kern_levels.h:5:25: warning:
 format '%ld' expects argument of type 'long int', but argument 4 has type
 'unsigned int'
Message-ID: <202204212112.2ixFkcQp-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git mtd/next
head:   f812679fab605b3d5b853ed24a81dabb222ea23a
commit: 0629fcef16d703d384f76cb2c2c3a119a9149a34 [10/11] mtd: mtdoops: Create a header structure for the saved mtdoops.
config: arc-randconfig-r023-20220420 (https://download.01.org/0day-ci/archive/20220421/202204212112.2ixFkcQp-lkp@intel.com/config)
compiler: arc-elf-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git/commit/?id=0629fcef16d703d384f76cb2c2c3a119a9149a34
        git remote add mtd https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git
        git fetch --no-tags mtd mtd/next
        git checkout 0629fcef16d703d384f76cb2c2c3a119a9149a34
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross W=1 O=build_dir ARCH=arc SHELL=/bin/bash drivers/mtd/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from include/linux/kernel.h:29,
                    from drivers/mtd/mtdoops.c:10:
   drivers/mtd/mtdoops.c: In function 'find_next_position':
>> include/linux/kern_levels.h:5:25: warning: format '%ld' expects argument of type 'long int', but argument 4 has type 'unsigned int' [-Wformat=]
       5 | #define KERN_SOH        "\001"          /* ASCII Start Of Header */
         |                         ^~~~~~
   include/linux/printk.h:418:25: note: in definition of macro 'printk_index_wrap'
     418 |                 _p_func(_fmt, ##__VA_ARGS__);                           \
         |                         ^~~~
   drivers/mtd/mtdoops.c:243:25: note: in expansion of macro 'printk'
     243 |                         printk(KERN_ERR "mtdoops: read failure at %ld (%td of %ld read), err %d\n",
         |                         ^~~~~~
   include/linux/kern_levels.h:11:25: note: in expansion of macro 'KERN_SOH'
      11 | #define KERN_ERR        KERN_SOH "3"    /* error conditions */
         |                         ^~~~~~~~
   drivers/mtd/mtdoops.c:243:32: note: in expansion of macro 'KERN_ERR'
     243 |                         printk(KERN_ERR "mtdoops: read failure at %ld (%td of %ld read), err %d\n",
         |                                ^~~~~~~~


vim +5 include/linux/kern_levels.h

314ba3520e513a Joe Perches 2012-07-30  4  
04d2c8c83d0e3a Joe Perches 2012-07-30 @5  #define KERN_SOH	"\001"		/* ASCII Start Of Header */
04d2c8c83d0e3a Joe Perches 2012-07-30  6  #define KERN_SOH_ASCII	'\001'
04d2c8c83d0e3a Joe Perches 2012-07-30  7  

:::::: The code at line 5 was first introduced by commit
:::::: 04d2c8c83d0e3ac5f78aeede51babb3236200112 printk: convert the format for KERN_<LEVEL> to a 2 byte pattern

:::::: TO: Joe Perches <joe@perches.com>
:::::: CC: Linus Torvalds <torvalds@linux-foundation.org>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
