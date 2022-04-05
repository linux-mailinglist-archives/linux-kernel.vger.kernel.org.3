Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB5F94F48CB
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 02:10:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386561AbiDEVul (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 17:50:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382069AbiDEMAh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 08:00:37 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC7193F894
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 04:18:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649157517; x=1680693517;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=YOdap6IKUD7bVBloCdYLnSJYTixqzWdp2iFUxhRJX4Q=;
  b=BL3BF7YuCD/7xwF2+I88sl0kPXOkqiAgtLWrRtaoXrIJP4gHUV70hRsF
   wFiYbWfrhubzrx+ZQsuL6ca9I3qO6KoQFkTEaiCSiA1T4xbDK4GVy3STb
   d6MUEZo8Z7AYwbr4WoQ4waJWDiU8ZaLqiSeDdHipTlqtD5r2WU0ckCd2N
   TwVgwx4VR0UlhwDBztta3Cm5SFDdu6b/f0trDwbJyQS69y8hRrX3r8vwN
   w1lU495jkY3J5B4fNEcmSz5FS8hQ1hJY+3KhlgFf6rMbRkaz18sgww2Pb
   PCjZisBoJHbuXUsIFqEgCajtnmJw67v3g4LSD6M0GxwEA7uhiLGPV2BBM
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10307"; a="323898321"
X-IronPort-AV: E=Sophos;i="5.90,236,1643702400"; 
   d="scan'208";a="323898321"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2022 04:18:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,236,1643702400"; 
   d="scan'208";a="620325752"
Received: from lkp-server02.sh.intel.com (HELO a44fdfb70b94) ([10.239.97.151])
  by fmsmga004.fm.intel.com with ESMTP; 05 Apr 2022 04:18:06 -0700
Received: from kbuild by a44fdfb70b94 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nbhCH-000383-IH;
        Tue, 05 Apr 2022 11:18:05 +0000
Date:   Tue, 5 Apr 2022 19:17:20 +0800
From:   kernel test robot <lkp@intel.com>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [mhiramat:bootconfig/core 3/4] init/main.c:419:44: error: passing
 argument 1 of 'get_boot_config_from_initrd' from incompatible pointer type
Message-ID: <202204051939.gOVSGNXT-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/mhiramat/linux.git bootconfig/core
head:   3907c71b99b8055dc7720ef35346f4d99870eb8c
commit: a33f53148090d20b836dbea6ab603c3770165d28 [3/4] bootconfig: Support embedding a bootconfig file in kernel
config: sparc64-buildonly-randconfig-r004-20220405 (https://download.01.org/0day-ci/archive/20220405/202204051939.gOVSGNXT-lkp@intel.com/config)
compiler: sparc64-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/mhiramat/linux.git/commit/?id=a33f53148090d20b836dbea6ab603c3770165d28
        git remote add mhiramat https://git.kernel.org/pub/scm/linux/kernel/git/mhiramat/linux.git
        git fetch --no-tags mhiramat bootconfig/core
        git checkout a33f53148090d20b836dbea6ab603c3770165d28
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=sparc64 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   init/main.c: In function 'setup_boot_config':
>> init/main.c:419:44: error: passing argument 1 of 'get_boot_config_from_initrd' from incompatible pointer type [-Werror=incompatible-pointer-types]
     419 |         data = get_boot_config_from_initrd(&size);
         |                                            ^~~~~
         |                                            |
         |                                            size_t * {aka long unsigned int *}
   init/main.c:316:55: note: expected 'u32 *' {aka 'unsigned int *'} but argument is of type 'size_t *' {aka 'long unsigned int *'}
     316 | static void * __init get_boot_config_from_initrd(u32 *_size)
         |                                                  ~~~~~^~~~~
   init/main.c: At top level:
   init/main.c:769:20: warning: no previous prototype for 'arch_post_acpi_subsys_init' [-Wmissing-prototypes]
     769 | void __init __weak arch_post_acpi_subsys_init(void) { }
         |                    ^~~~~~~~~~~~~~~~~~~~~~~~~~
   init/main.c:781:20: warning: no previous prototype for 'mem_encrypt_init' [-Wmissing-prototypes]
     781 | void __init __weak mem_encrypt_init(void) { }
         |                    ^~~~~~~~~~~~~~~~
   init/main.c:783:20: warning: no previous prototype for 'poking_init' [-Wmissing-prototypes]
     783 | void __init __weak poking_init(void) { }
         |                    ^~~~~~~~~~~
   cc1: some warnings being treated as errors


vim +/get_boot_config_from_initrd +419 init/main.c

d0ac5fbaf783d5 Masami Hiramatsu        2021-08-05  409  
2b7d2fe76f9c84 Cao jin                 2021-03-11  410  static void __init setup_boot_config(void)
7684b8582c2453 Masami Hiramatsu        2020-01-11  411  {
f61872bb58a1cd Steven Rostedt (VMware  2020-02-07  412) 	static char tmp_cmdline[COMMAND_LINE_SIZE] __initdata;
a33f53148090d2 Masami Hiramatsu        2022-03-12  413  	const char *msg, *data;
a33f53148090d2 Masami Hiramatsu        2022-03-12  414  	int pos, ret;
a33f53148090d2 Masami Hiramatsu        2022-03-12  415  	size_t size;
a33f53148090d2 Masami Hiramatsu        2022-03-12  416  	char *err;
7684b8582c2453 Masami Hiramatsu        2020-01-11  417  
611d0a95d46b09 Masami Hiramatsu        2020-05-11  418  	/* Cut out the bootconfig data even if we have no bootconfig option */
88404d100627e1 Masami Hiramatsu        2022-03-28 @419  	data = get_boot_config_from_initrd(&size);
a33f53148090d2 Masami Hiramatsu        2022-03-12  420  	/* If there is no bootconfig in initrd, try embedded one. */
a33f53148090d2 Masami Hiramatsu        2022-03-12  421  	if (!data)
a33f53148090d2 Masami Hiramatsu        2022-03-12  422  		data = xbc_get_embedded_bootconfig(&size);
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
a33f53148090d2 Masami Hiramatsu        2022-03-12  441  		pr_err("bootconfig size %ld greater than max size %d\n",
a33f53148090d2 Masami Hiramatsu        2022-03-12  442  			(long)size, XBC_DATA_MAX);
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
a33f53148090d2 Masami Hiramatsu        2022-03-12  455  		pr_info("Load bootconfig: %ld bytes %d nodes\n", (long)size, ret);
51887d03aca101 Masami Hiramatsu        2020-01-11  456  		/* keys starting with "kernel." are passed via cmdline */
51887d03aca101 Masami Hiramatsu        2020-01-11  457  		extra_command_line = xbc_make_cmdline("kernel");
1319916209ce8f Masami Hiramatsu        2020-01-11  458  		/* Also, "init." keys are init arguments */
1319916209ce8f Masami Hiramatsu        2020-01-11  459  		extra_init_args = xbc_make_cmdline("init");
51887d03aca101 Masami Hiramatsu        2020-01-11  460  	}
7495e0926fdf30 Steven Rostedt (VMware  2020-02-04  461) 	return;
7684b8582c2453 Masami Hiramatsu        2020-01-11  462  }
de462e5f107185 Masami Hiramatsu        2020-04-26  463  

:::::: The code at line 419 was first introduced by commit
:::::: 88404d100627e1ed2f02a264e2465e2ae62f386a bootconfig: Check the checksum before removing the bootconfig from initrd

:::::: TO: Masami Hiramatsu <mhiramat@kernel.org>
:::::: CC: Masami Hiramatsu <mhiramat@kernel.org>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
