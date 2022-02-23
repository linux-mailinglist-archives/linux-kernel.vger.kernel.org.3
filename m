Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E9DC4C0C61
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 07:01:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238150AbiBWGBs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 01:01:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233319AbiBWGBq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 01:01:46 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8B793B014
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 22:01:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645596079; x=1677132079;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=TUBO1g97m00F453/0UQ/chaM7fEojgQjviugcJ4xIjQ=;
  b=HKCFeu5ZodotaI3FxvM4nW5Cgz6bvNmNJ+cK1cYslFA/xKTXSwVI6Mji
   LVkr+TX8BnHS3oqrjShGRWLDgEb4JHloUaxj/XWFf7zgQcDMo5lFo0YgZ
   x19DMBqMnsHot2v/JznWd2uNFLPmWkql/gozZtyKjMjuf4zRSxfXB9r3I
   +KoWm7mn23/iDwZEe9yqscOxYtq/v/EnyUV7j2OV9o0Vq3IVuBL0XmbR6
   bvnlDhUKP9y1k3VG8pi9u0T+QxuT009HwsNgrfI2iJlJqTJTia4syTvyC
   opW2ZM7XQceKkGZkVud9qJFrHXPS1fuB/WWQQGF2ZyhKOXO/VRi93iJKR
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10266"; a="315119954"
X-IronPort-AV: E=Sophos;i="5.88,390,1635231600"; 
   d="scan'208";a="315119954"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2022 22:01:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,390,1635231600"; 
   d="scan'208";a="706908731"
Received: from lkp-server01.sh.intel.com (HELO 788b1cd46f0d) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 22 Feb 2022 22:01:17 -0800
Received: from kbuild by 788b1cd46f0d with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nMkiD-00013A-9P; Wed, 23 Feb 2022 06:01:17 +0000
Date:   Wed, 23 Feb 2022 14:01:13 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Jason A. Donenfeld" <zx2c4@kernel.org>
Cc:     kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org
Subject: [ammarfaizi2-block:crng/random/jd/vmgenid 44/44]
 include/linux/kern_levels.h:5:18: warning: format '%llx' expects argument of
 type 'long long unsigned int', but argument 2 has type 'phys_addr_t' {aka
 'unsigned int'}
Message-ID: <202202231308.bUuKfhGx-lkp@intel.com>
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

tree:   https://github.com/ammarfaizi2/linux-block crng/random/jd/vmgenid
head:   a3909de4c661c33b84a77a66395bb27d10abb1ff
commit: a3909de4c661c33b84a77a66395bb27d10abb1ff [44/44] drivers/virt: use VM generation ID to reseed RNG
config: i386-randconfig-a003 (https://download.01.org/0day-ci/archive/20220223/202202231308.bUuKfhGx-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build):
        # https://github.com/ammarfaizi2/linux-block/commit/a3909de4c661c33b84a77a66395bb27d10abb1ff
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block crng/random/jd/vmgenid
        git checkout a3909de4c661c33b84a77a66395bb27d10abb1ff
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash drivers/virt/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from include/linux/kernel.h:29,
                    from arch/x86/include/asm/percpu.h:27,
                    from arch/x86/include/asm/current.h:6,
                    from include/linux/mutex.h:14,
                    from include/linux/kernfs.h:11,
                    from include/linux/sysfs.h:16,
                    from include/linux/kobject.h:20,
                    from include/linux/of.h:17,
                    from include/linux/irqdomain.h:35,
                    from include/linux/acpi.h:13,
                    from drivers/virt/vmgenid.c:12:
   drivers/virt/vmgenid.c: In function 'vmgenid_acpi_map':
>> include/linux/kern_levels.h:5:18: warning: format '%llx' expects argument of type 'long long unsigned int', but argument 2 has type 'phys_addr_t' {aka 'unsigned int'} [-Wformat=]
       5 | #define KERN_SOH "\001"  /* ASCII Start Of Header */
         |                  ^~~~~~
   include/linux/printk.h:418:11: note: in definition of macro 'printk_index_wrap'
     418 |   _p_func(_fmt, ##__VA_ARGS__);    \
         |           ^~~~
   include/linux/printk.h:489:2: note: in expansion of macro 'printk'
     489 |  printk(KERN_ERR pr_fmt(fmt), ##__VA_ARGS__)
         |  ^~~~~~
   include/linux/kern_levels.h:11:18: note: in expansion of macro 'KERN_SOH'
      11 | #define KERN_ERR KERN_SOH "3" /* error conditions */
         |                  ^~~~~~~~
   include/linux/printk.h:489:9: note: in expansion of macro 'KERN_ERR'
     489 |  printk(KERN_ERR pr_fmt(fmt), ##__VA_ARGS__)
         |         ^~~~~~~~
   drivers/virt/vmgenid.c:53:3: note: in expansion of macro 'pr_err'
      53 |   pr_err("failed to map memory at 0x%llx, size %zu\n",
         |   ^~~~~~
   drivers/virt/vmgenid.c:53:40: note: format string is defined here
      53 |   pr_err("failed to map memory at 0x%llx, size %zu\n",
         |                                     ~~~^
         |                                        |
         |                                        long long unsigned int
         |                                     %x


vim +5 include/linux/kern_levels.h

314ba3520e513a Joe Perches 2012-07-30  4  
04d2c8c83d0e3a Joe Perches 2012-07-30 @5  #define KERN_SOH	"\001"		/* ASCII Start Of Header */
04d2c8c83d0e3a Joe Perches 2012-07-30  6  #define KERN_SOH_ASCII	'\001'
04d2c8c83d0e3a Joe Perches 2012-07-30  7  

:::::: The code at line 5 was first introduced by commit
:::::: 04d2c8c83d0e3ac5f78aeede51babb3236200112 printk: convert the format for KERN_<LEVEL> to a 2 byte pattern

:::::: TO: Joe Perches <joe@perches.com>
:::::: CC: Linus Torvalds <torvalds@linux-foundation.org>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
