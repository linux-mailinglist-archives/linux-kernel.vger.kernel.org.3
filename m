Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E7C3502AD3
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 15:11:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243160AbiDONN5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 09:13:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229584AbiDONN4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 09:13:56 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A23BB9BB9C
        for <linux-kernel@vger.kernel.org>; Fri, 15 Apr 2022 06:11:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650028287; x=1681564287;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=m1fSnHxSjX54Mtl0eRLvV9TDZ/MPILtzEzLQunpal+4=;
  b=HbOWKgOissBw+aEtNGUQsiYkVCd2Kqr9kQrMKXn/PUSsRvxA8Xxqj4p0
   +3ru4D5KCoMFvZjW40RSmv0kKg/zFKsTdzfABW+Ua7MEyVJmYt96UYx90
   0Hv233+qEd5hraIDbcZdE0+kQdisRBYoXWDoAiLIzpDg2gkQCpEnZIHq8
   OC2Mcz5BFnGsP1t78lJJ2IQo48DJaAnMOPo4sfSV35AXMmQxO45Pfacf8
   hvGR9sethVAu57gU8f39LziLdkmq1QDE4cQxTCDjsx6bpaxD0Fk2mW60o
   Zoxkc2J7D+NWSRcJI9zMZyzyolTCq/mgxoH+BgJHb0pFR+yb+joW8nv4K
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10317"; a="261995357"
X-IronPort-AV: E=Sophos;i="5.90,262,1643702400"; 
   d="scan'208";a="261995357"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2022 06:11:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,262,1643702400"; 
   d="scan'208";a="725775892"
Received: from lkp-server01.sh.intel.com (HELO 3abc53900bec) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 15 Apr 2022 06:11:26 -0700
Received: from kbuild by 3abc53900bec with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nfLjR-0001xz-GP;
        Fri, 15 Apr 2022 13:11:25 +0000
Date:   Fri, 15 Apr 2022 21:10:40 +0800
From:   kernel test robot <lkp@intel.com>
To:     Corey Minyard <cminyard@mvista.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [cminyard-ipmi:for-next 9/11]
 drivers/char/ipmi/ipmi_msghandler.c:14:31: error: called object is not a
 function or function pointer
Message-ID: <202204152125.TxH8q58H-lkp@intel.com>
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

tree:   https://github.com/cminyard/linux-ipmi for-next
head:   d2e94b3095bb7886bce0fb313bc9f65a94dc6ce5
commit: 7cd75d3cce636c70f968287dfeaee1458564d1ba [9/11] ipmi: Convert pr_debug() to dev_dbg()
config: i386-randconfig-a005 (https://download.01.org/0day-ci/archive/20220415/202204152125.TxH8q58H-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.2.0-19) 11.2.0
reproduce (this is a W=1 build):
        # https://github.com/cminyard/linux-ipmi/commit/7cd75d3cce636c70f968287dfeaee1458564d1ba
        git remote add cminyard-ipmi https://github.com/cminyard/linux-ipmi
        git fetch --no-tags cminyard-ipmi for-next
        git checkout 7cd75d3cce636c70f968287dfeaee1458564d1ba
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from include/linux/printk.h:555,
                    from include/linux/kernel.h:29,
                    from arch/x86/include/asm/percpu.h:27,
                    from arch/x86/include/asm/current.h:6,
                    from arch/x86/include/asm/processor.h:17,
                    from arch/x86/include/asm/timex.h:5,
                    from include/linux/timex.h:65,
                    from include/linux/time32.h:13,
                    from include/linux/time.h:60,
                    from include/linux/stat.h:19,
                    from include/linux/module.h:13,
                    from drivers/char/ipmi/ipmi_msghandler.c:17:
   drivers/char/ipmi/ipmi_msghandler.c: In function 'i_ipmi_request':
>> drivers/char/ipmi/ipmi_msghandler.c:14:31: error: called object is not a function or function pointer
      14 | #define pr_fmt(fmt) "%s" fmt, "IPMI message handler: "
         |                               ^~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/dynamic_debug.h:134:17: note: in definition of macro '__dynamic_func_call'
     134 |                 func(&id, ##__VA_ARGS__);               \
         |                 ^~~~
   include/linux/dynamic_debug.h:166:9: note: in expansion of macro '_dynamic_func_call'
     166 |         _dynamic_func_call(fmt,__dynamic_dev_dbg,               \
         |         ^~~~~~~~~~~~~~~~~~
   include/linux/dev_printk.h:155:9: note: in expansion of macro 'dynamic_dev_dbg'
     155 |         dynamic_dev_dbg(dev, dev_fmt(fmt), ##__VA_ARGS__)
         |         ^~~~~~~~~~~~~~~
   drivers/char/ipmi/ipmi_msghandler.c:15:17: note: in expansion of macro 'pr_fmt'
      15 | #define dev_fmt pr_fmt
         |                 ^~~~~~
   include/linux/dev_printk.h:155:30: note: in expansion of macro 'dev_fmt'
     155 |         dynamic_dev_dbg(dev, dev_fmt(fmt), ##__VA_ARGS__)
         |                              ^~~~~~~
   drivers/char/ipmi/ipmi_msghandler.c:2387:17: note: in expansion of macro 'dev_dbg'
    2387 |                 dev_dbg(intf->si_dev, "Send: %*ph\n",
         |                 ^~~~~~~
   drivers/char/ipmi/ipmi_msghandler.c: In function 'handle_ipmb_get_msg_cmd':
>> drivers/char/ipmi/ipmi_msghandler.c:14:31: error: called object is not a function or function pointer
      14 | #define pr_fmt(fmt) "%s" fmt, "IPMI message handler: "
         |                               ^~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/dynamic_debug.h:134:17: note: in definition of macro '__dynamic_func_call'
     134 |                 func(&id, ##__VA_ARGS__);               \
         |                 ^~~~
   include/linux/dynamic_debug.h:166:9: note: in expansion of macro '_dynamic_func_call'
     166 |         _dynamic_func_call(fmt,__dynamic_dev_dbg,               \
         |         ^~~~~~~~~~~~~~~~~~
   include/linux/dev_printk.h:155:9: note: in expansion of macro 'dynamic_dev_dbg'
     155 |         dynamic_dev_dbg(dev, dev_fmt(fmt), ##__VA_ARGS__)
         |         ^~~~~~~~~~~~~~~
   drivers/char/ipmi/ipmi_msghandler.c:15:17: note: in expansion of macro 'pr_fmt'
      15 | #define dev_fmt pr_fmt
         |                 ^~~~~~
   include/linux/dev_printk.h:155:30: note: in expansion of macro 'dev_fmt'
     155 |         dynamic_dev_dbg(dev, dev_fmt(fmt), ##__VA_ARGS__)
         |                              ^~~~~~~
   drivers/char/ipmi/ipmi_msghandler.c:3926:17: note: in expansion of macro 'dev_dbg'
    3926 |                 dev_dbg(intf->si_dev, "Invalid command: %*ph\n",
         |                 ^~~~~~~
   drivers/char/ipmi/ipmi_msghandler.c: In function 'handle_one_recv_msg':
>> drivers/char/ipmi/ipmi_msghandler.c:14:31: error: called object is not a function or function pointer
      14 | #define pr_fmt(fmt) "%s" fmt, "IPMI message handler: "
         |                               ^~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/dynamic_debug.h:134:17: note: in definition of macro '__dynamic_func_call'
     134 |                 func(&id, ##__VA_ARGS__);               \
         |                 ^~~~
   include/linux/dynamic_debug.h:166:9: note: in expansion of macro '_dynamic_func_call'
     166 |         _dynamic_func_call(fmt,__dynamic_dev_dbg,               \
         |         ^~~~~~~~~~~~~~~~~~
   include/linux/dev_printk.h:155:9: note: in expansion of macro 'dynamic_dev_dbg'
     155 |         dynamic_dev_dbg(dev, dev_fmt(fmt), ##__VA_ARGS__)
         |         ^~~~~~~~~~~~~~~
   drivers/char/ipmi/ipmi_msghandler.c:15:17: note: in expansion of macro 'pr_fmt'
      15 | #define dev_fmt pr_fmt
         |                 ^~~~~~
   include/linux/dev_printk.h:155:30: note: in expansion of macro 'dev_fmt'
     155 |         dynamic_dev_dbg(dev, dev_fmt(fmt), ##__VA_ARGS__)
         |                              ^~~~~~~
   drivers/char/ipmi/ipmi_msghandler.c:4535:9: note: in expansion of macro 'dev_dbg'
    4535 |         dev_dbg(intf->si_dev, "Recv: %*ph\n", msg->rsp_size, msg->rsp);
         |         ^~~~~~~
   drivers/char/ipmi/ipmi_msghandler.c: In function 'smi_from_recv_msg':
>> drivers/char/ipmi/ipmi_msghandler.c:14:31: error: called object is not a function or function pointer
      14 | #define pr_fmt(fmt) "%s" fmt, "IPMI message handler: "
         |                               ^~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/dynamic_debug.h:134:17: note: in definition of macro '__dynamic_func_call'
     134 |                 func(&id, ##__VA_ARGS__);               \
         |                 ^~~~
   include/linux/dynamic_debug.h:166:9: note: in expansion of macro '_dynamic_func_call'
     166 |         _dynamic_func_call(fmt,__dynamic_dev_dbg,               \
         |         ^~~~~~~~~~~~~~~~~~
   include/linux/dev_printk.h:155:9: note: in expansion of macro 'dynamic_dev_dbg'
     155 |         dynamic_dev_dbg(dev, dev_fmt(fmt), ##__VA_ARGS__)
         |         ^~~~~~~~~~~~~~~
   drivers/char/ipmi/ipmi_msghandler.c:15:17: note: in expansion of macro 'pr_fmt'
      15 | #define dev_fmt pr_fmt
         |                 ^~~~~~
   include/linux/dev_printk.h:155:30: note: in expansion of macro 'dev_fmt'
     155 |         dynamic_dev_dbg(dev, dev_fmt(fmt), ##__VA_ARGS__)
         |                              ^~~~~~~
   drivers/char/ipmi/ipmi_msghandler.c:4917:9: note: in expansion of macro 'dev_dbg'
    4917 |         dev_dbg(intf->si_dev, "Resend: %*ph\n",
         |         ^~~~~~~


vim +14 drivers/char/ipmi/ipmi_msghandler.c

445e2cbda928a3 Joe Perches 2018-05-09 @14  #define pr_fmt(fmt) "%s" fmt, "IPMI message handler: "
445e2cbda928a3 Joe Perches 2018-05-09  15  #define dev_fmt pr_fmt
445e2cbda928a3 Joe Perches 2018-05-09  16  

:::::: The code at line 14 was first introduced by commit
:::::: 445e2cbda928a3523c1c1da76788d19df52611c8 ipmi: msghandler: Add and use pr_fmt and dev_fmt, remove PFX

:::::: TO: Joe Perches <joe@perches.com>
:::::: CC: Corey Minyard <cminyard@mvista.com>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
