Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12561507E2E
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 03:33:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242650AbiDTBfh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 21:35:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229685AbiDTBfg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 21:35:36 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56E632B264
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 18:32:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650418372; x=1681954372;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=uiX9HvvMr1I4Z6NfuE4V81mO9FtzpDQslKd7JE3l+Ls=;
  b=Sf++R7KivdMzs2LOgNhWyJYbofXgim+u7pDIKSshX3dlCx1qLVZPEXv7
   oXKOet2ejpax1NlIfAzo2WrfA21jzGRRxM76haeQPcmRgD762KgfzPQfC
   7vnWF66TqnU4qtK1ixdxh2lHY92PmN7/JEGtRknywFZU933Q1NkjFzGTS
   YXEvwe1Ohi5BxAAlx9U8B36c8C+NUjc/QUXK1OhD/+ltc5YRWvl7r7t1R
   QbpWTnenwtgEQMsGxN+w0D1B4O8E5wd6Gk+XnWwPzuYNpiasqlUCkoXX+
   jvooijLSSepGgHtnNtr7BkU6ImTUW43IKk/FyYzTZk32+u49FcKP8GuLs
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10322"; a="262770337"
X-IronPort-AV: E=Sophos;i="5.90,274,1643702400"; 
   d="scan'208";a="262770337"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2022 18:32:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,274,1643702400"; 
   d="scan'208";a="625868983"
Received: from lkp-server01.sh.intel.com (HELO 3abc53900bec) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 19 Apr 2022 18:32:50 -0700
Received: from kbuild by 3abc53900bec with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1ngzD8-0006PR-Bh;
        Wed, 20 Apr 2022 01:32:50 +0000
Date:   Wed, 20 Apr 2022 09:32:03 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [bvanassche:scsi-gap-zone 10/10] include/linux/kern_levels.h:5:25:
 warning: format '%u' expects argument of type 'unsigned int', but argument 3
 has type 'sector_t' {aka 'long long unsigned int'}
Message-ID: <202204200933.JyliDZWf-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/bvanassche/linux scsi-gap-zone
head:   8a37a38282a57095a4a3ff6e6c68f2481234ad10
commit: 8a37a38282a57095a4a3ff6e6c68f2481234ad10 [10/10] scsi-debug-dbg
config: arc-randconfig-r032-20220419 (https://download.01.org/0day-ci/archive/20220420/202204200933.JyliDZWf-lkp@intel.com/config)
compiler: arc-elf-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/bvanassche/linux/commit/8a37a38282a57095a4a3ff6e6c68f2481234ad10
        git remote add bvanassche https://github.com/bvanassche/linux
        git fetch --no-tags bvanassche scsi-gap-zone
        git checkout 8a37a38282a57095a4a3ff6e6c68f2481234ad10
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross W=1 O=build_dir ARCH=arc SHELL=/bin/bash drivers/scsi/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from include/linux/kernel.h:29,
                    from include/linux/cpumask.h:10,
                    from include/linux/mm_types_task.h:14,
                    from include/linux/mm_types.h:5,
                    from include/linux/buildid.h:5,
                    from include/linux/module.h:14,
                    from drivers/scsi/scsi_debug.c:18:
   drivers/scsi/scsi_debug.c: In function 'sdebug_device_create_zones':
>> include/linux/kern_levels.h:5:25: warning: format '%u' expects argument of type 'unsigned int', but argument 3 has type 'sector_t' {aka 'long long unsigned int'} [-Wformat=]
       5 | #define KERN_SOH        "\001"          /* ASCII Start Of Header */
         |                         ^~~~~~
   include/linux/printk.h:418:25: note: in definition of macro 'printk_index_wrap'
     418 |                 _p_func(_fmt, ##__VA_ARGS__);                           \
         |                         ^~~~
   include/linux/printk.h:519:9: note: in expansion of macro 'printk'
     519 |         printk(KERN_INFO pr_fmt(fmt), ##__VA_ARGS__)
         |         ^~~~~~
   include/linux/kern_levels.h:14:25: note: in expansion of macro 'KERN_SOH'
      14 | #define KERN_INFO       KERN_SOH "6"    /* informational */
         |                         ^~~~~~~~
   include/linux/printk.h:519:16: note: in expansion of macro 'KERN_INFO'
     519 |         printk(KERN_INFO pr_fmt(fmt), ##__VA_ARGS__)
         |                ^~~~~~~~~
   drivers/scsi/scsi_debug.c:5100:25: note: in expansion of macro 'pr_info'
    5100 |                         pr_info("adding a gap zone; start %u; size %u\n",
         |                         ^~~~~~~


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
