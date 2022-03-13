Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 895B74D7506
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Mar 2022 12:41:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233314AbiCMLmR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Mar 2022 07:42:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232220AbiCMLmG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Mar 2022 07:42:06 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3FCEA7769
        for <linux-kernel@vger.kernel.org>; Sun, 13 Mar 2022 04:40:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647171658; x=1678707658;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=dLIV4OzaCGnROXJTIZD/OgAWMRXV8wMaE958Z3hy49s=;
  b=MAB6aQOIAgyH1fNOTuDgvm7o5VErBUv9BeNU+SdvlEo/uCJCKWEe40zJ
   /UbAniCeSE3livtRGJ+Xfxvz4PvMGVBGPw8qnHzHYPyUNH5Pna9LGSV7r
   H+JRkF35uDQZoXdyh+UGsjDQgIALV/sZ57oW0EWyYUa1Yxw7TvKpQPPHe
   EC7+N7V2kX2ExlQOKHjHPWrguDR8mQqUrBJ4lPtQgtdPEsBkwgPqmg8zm
   ewzT5OZP8hnJgvQDvYnZp6DofjMRMztXKfv9rrnC/VEbsoUYSw+cY19CD
   Lj8tz3zbPSTpv8H+dUpIKVxdJlSEiy/kR9icb/dyp9W/duwpzwMiyzkrz
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10284"; a="253422453"
X-IronPort-AV: E=Sophos;i="5.90,178,1643702400"; 
   d="scan'208";a="253422453"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2022 04:40:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,178,1643702400"; 
   d="scan'208";a="539585898"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 13 Mar 2022 04:40:56 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nTMam-0008uQ-0U; Sun, 13 Mar 2022 11:40:56 +0000
Date:   Sun, 13 Mar 2022 19:40:21 +0800
From:   kernel test robot <lkp@intel.com>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [mhiramat:bootconfig/core 2/3] init/main.c:442:4: warning: format
 specifies type 'long' but the argument has type 'size_t' (aka 'unsigned
 int')
Message-ID: <202203131957.y4uSC7J3-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/mhiramat/linux.git bootconfig/core
head:   851eb04a13868ed61bd973f38e4fa9d741eef92e
commit: 6bdb50bbe6cbc3db8e621bde3fe16ad92a9a7321 [2/3] bootconfig: Support embedding a bootconfig file in kernel
config: arm-buildonly-randconfig-r003-20220313 (https://download.01.org/0day-ci/archive/20220313/202203131957.y4uSC7J3-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 0467eb2cb7654c15ae366967ef35093c5724c416)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm cross compiling tool for clang build
        # apt-get install binutils-arm-linux-gnueabi
        # https://git.kernel.org/pub/scm/linux/kernel/git/mhiramat/linux.git/commit/?id=6bdb50bbe6cbc3db8e621bde3fe16ad92a9a7321
        git remote add mhiramat https://git.kernel.org/pub/scm/linux/kernel/git/mhiramat/linux.git
        git fetch --no-tags mhiramat bootconfig/core
        git checkout 6bdb50bbe6cbc3db8e621bde3fe16ad92a9a7321
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> init/main.c:442:4: warning: format specifies type 'long' but the argument has type 'size_t' (aka 'unsigned int') [-Wformat]
                           size, XBC_DATA_MAX);
                           ^~~~
   include/linux/printk.h:489:33: note: expanded from macro 'pr_err'
           printk(KERN_ERR pr_fmt(fmt), ##__VA_ARGS__)
                                  ~~~     ^~~~~~~~~~~
   include/linux/printk.h:446:60: note: expanded from macro 'printk'
   #define printk(fmt, ...) printk_index_wrap(_printk, fmt, ##__VA_ARGS__)
                                                       ~~~    ^~~~~~~~~~~
   include/linux/printk.h:418:19: note: expanded from macro 'printk_index_wrap'
                   _p_func(_fmt, ##__VA_ARGS__);                           \
                           ~~~~    ^~~~~~~~~~~
   init/main.c:455:52: warning: format specifies type 'long' but the argument has type 'size_t' (aka 'unsigned int') [-Wformat]
                   pr_info("Load bootconfig: %ld bytes %d nodes\n", size, ret);
                                             ~~~                    ^~~~
                                             %u
   include/linux/printk.h:519:34: note: expanded from macro 'pr_info'
           printk(KERN_INFO pr_fmt(fmt), ##__VA_ARGS__)
                                   ~~~     ^~~~~~~~~~~
   include/linux/printk.h:446:60: note: expanded from macro 'printk'
   #define printk(fmt, ...) printk_index_wrap(_printk, fmt, ##__VA_ARGS__)
                                                       ~~~    ^~~~~~~~~~~
   include/linux/printk.h:418:19: note: expanded from macro 'printk_index_wrap'
                   _p_func(_fmt, ##__VA_ARGS__);                           \
                           ~~~~    ^~~~~~~~~~~
   init/main.c:769:20: warning: no previous prototype for function 'arch_post_acpi_subsys_init' [-Wmissing-prototypes]
   void __init __weak arch_post_acpi_subsys_init(void) { }
                      ^
   init/main.c:769:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void __init __weak arch_post_acpi_subsys_init(void) { }
   ^
   static 
   init/main.c:781:20: warning: no previous prototype for function 'mem_encrypt_init' [-Wmissing-prototypes]
   void __init __weak mem_encrypt_init(void) { }
                      ^
   init/main.c:781:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void __init __weak mem_encrypt_init(void) { }
   ^
   static 
   init/main.c:783:20: warning: no previous prototype for function 'poking_init' [-Wmissing-prototypes]
   void __init __weak poking_init(void) { }
                      ^
   init/main.c:783:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void __init __weak poking_init(void) { }
   ^
   static 
   5 warnings generated.


vim +442 init/main.c

d0ac5fbaf783d5 Masami Hiramatsu        2021-08-05  408  
2b7d2fe76f9c84 Cao jin                 2021-03-11  409  static void __init setup_boot_config(void)
7684b8582c2453 Masami Hiramatsu        2020-01-11  410  {
f61872bb58a1cd Steven Rostedt (VMware  2020-02-07  411) 	static char tmp_cmdline[COMMAND_LINE_SIZE] __initdata;
89b74cac783473 Masami Hiramatsu        2020-03-03  412  	const char *msg;
89b74cac783473 Masami Hiramatsu        2020-03-03  413  	int pos;
6bdb50bbe6cbc3 Masami Hiramatsu        2022-03-12  414  	size_t size;
bdac5c2b243f68 Masami Hiramatsu        2021-09-16  415  	char *data, *err;
a00574036c2614 Masami Hiramatsu        2020-02-05  416  	int ret;
7684b8582c2453 Masami Hiramatsu        2020-01-11  417  
611d0a95d46b09 Masami Hiramatsu        2020-05-11  418  	/* Cut out the bootconfig data even if we have no bootconfig option */
5698b97b800447 Masami Hiramatsu        2022-03-13  419  	data = get_boot_config_from_initrd(&size);
6bdb50bbe6cbc3 Masami Hiramatsu        2022-03-12  420  	/* If there is no bootconfig in initrd, try embedded one. */
6bdb50bbe6cbc3 Masami Hiramatsu        2022-03-12  421  	if (!data)
6bdb50bbe6cbc3 Masami Hiramatsu        2022-03-12  422  		data = xbc_get_embedded_bootconfig(&size);
de462e5f107185 Masami Hiramatsu        2020-04-26  423  
f61872bb58a1cd Steven Rostedt (VMware  2020-02-07  424) 	strlcpy(tmp_cmdline, boot_command_line, COMMAND_LINE_SIZE);
477d0847817046 Masami Hiramatsu        2020-08-04  425  	err = parse_args("bootconfig", tmp_cmdline, NULL, 0, 0, 0, NULL,
f61872bb58a1cd Steven Rostedt (VMware  2020-02-07  426) 			 bootconfig_params);
f61872bb58a1cd Steven Rostedt (VMware  2020-02-07  427) 
477d0847817046 Masami Hiramatsu        2020-08-04  428  	if (IS_ERR(err) || !bootconfig_found)
7684b8582c2453 Masami Hiramatsu        2020-01-11  429  		return;
7684b8582c2453 Masami Hiramatsu        2020-01-11  430  
b66fbbe8d48228 Masami Hiramatsu        2021-09-05  431  	/* parse_args() stops at the next param of '--' and returns an address */
477d0847817046 Masami Hiramatsu        2020-08-04  432  	if (err)
b66fbbe8d48228 Masami Hiramatsu        2021-09-05  433  		initargs_offs = err - tmp_cmdline;
477d0847817046 Masami Hiramatsu        2020-08-04  434  
611d0a95d46b09 Masami Hiramatsu        2020-05-11  435  	if (!data) {
611d0a95d46b09 Masami Hiramatsu        2020-05-11  436  		pr_err("'bootconfig' found on command line, but no bootconfig found\n");
611d0a95d46b09 Masami Hiramatsu        2020-05-11  437  		return;
611d0a95d46b09 Masami Hiramatsu        2020-05-11  438  	}
611d0a95d46b09 Masami Hiramatsu        2020-05-11  439  
7495e0926fdf30 Steven Rostedt (VMware  2020-02-04  440) 	if (size >= XBC_DATA_MAX) {
6bdb50bbe6cbc3 Masami Hiramatsu        2022-03-12  441  		pr_err("bootconfig size %ld greater than max size %d\n",
7495e0926fdf30 Steven Rostedt (VMware  2020-02-04 @442) 			size, XBC_DATA_MAX);
7684b8582c2453 Masami Hiramatsu        2020-01-11  443  		return;
7495e0926fdf30 Steven Rostedt (VMware  2020-02-04  444) 	}
7684b8582c2453 Masami Hiramatsu        2020-01-11  445  
bdac5c2b243f68 Masami Hiramatsu        2021-09-16  446  	ret = xbc_init(data, size, &msg, &pos);
89b74cac783473 Masami Hiramatsu        2020-03-03  447  	if (ret < 0) {
89b74cac783473 Masami Hiramatsu        2020-03-03  448  		if (pos < 0)
89b74cac783473 Masami Hiramatsu        2020-03-03  449  			pr_err("Failed to init bootconfig: %s.\n", msg);
89b74cac783473 Masami Hiramatsu        2020-03-03  450  		else
89b74cac783473 Masami Hiramatsu        2020-03-03  451  			pr_err("Failed to parse bootconfig: %s at %d.\n",
89b74cac783473 Masami Hiramatsu        2020-03-03  452  				msg, pos);
89b74cac783473 Masami Hiramatsu        2020-03-03  453  	} else {
e306220cb7b7c2 Masami Hiramatsu        2021-09-16  454  		xbc_get_info(&ret, NULL);
6bdb50bbe6cbc3 Masami Hiramatsu        2022-03-12  455  		pr_info("Load bootconfig: %ld bytes %d nodes\n", size, ret);
51887d03aca101 Masami Hiramatsu        2020-01-11  456  		/* keys starting with "kernel." are passed via cmdline */
51887d03aca101 Masami Hiramatsu        2020-01-11  457  		extra_command_line = xbc_make_cmdline("kernel");
1319916209ce8f Masami Hiramatsu        2020-01-11  458  		/* Also, "init." keys are init arguments */
1319916209ce8f Masami Hiramatsu        2020-01-11  459  		extra_init_args = xbc_make_cmdline("init");
51887d03aca101 Masami Hiramatsu        2020-01-11  460  	}
7495e0926fdf30 Steven Rostedt (VMware  2020-02-04  461) 	return;
7684b8582c2453 Masami Hiramatsu        2020-01-11  462  }
de462e5f107185 Masami Hiramatsu        2020-04-26  463  

:::::: The code at line 442 was first introduced by commit
:::::: 7495e0926fdf302cb9e62a49f7c22198815624cd bootconfig: Only load bootconfig if "bootconfig" is on the kernel cmdline

:::::: TO: Steven Rostedt (VMware) <rostedt@goodmis.org>
:::::: CC: Steven Rostedt (VMware) <rostedt@goodmis.org>

---
0-DAY CI Kernel Test Service
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
