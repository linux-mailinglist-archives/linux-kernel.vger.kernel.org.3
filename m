Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 057F84C58CF
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Feb 2022 01:31:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229558AbiB0Abu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Feb 2022 19:31:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbiB0Abt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Feb 2022 19:31:49 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F58226E6FA
        for <linux-kernel@vger.kernel.org>; Sat, 26 Feb 2022 16:31:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645921874; x=1677457874;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=sOyOsxXuxmtJUI5ZDktjJTn51b2Xs5cQAh1cUHBdHYk=;
  b=WEg7j+wggd/0K3OKtkUvvVyiaVJn6HA3xSbFYJlpy8MtfVVQxrimGexa
   cotnpH5gBg9zUYNbwwR0b1Au9YUUALTB4W8M+u6rGf06Zv4uPwX0slnPu
   fG2otzO6Dvhx7Vd2rmv74n4rlYb58hGY51nKnK+em5gBigrrXurX4fB1Y
   dHl09qdGgvKe0un3kykNM0n+L1v+LUHd0hyWG26BpaJjJAHrEhDMfU3js
   w4l1cJe/DSszPTYsfHxuCWeqDmwWaW8AkkJQgY5+6kgEG4w4p099Wj0Ah
   8VnzlTPou2GPaXpEdcLd6CSu9e7ZriIXjfsN5GB+DFnlFJTH99kN2Qx3P
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10270"; a="339128696"
X-IronPort-AV: E=Sophos;i="5.90,140,1643702400"; 
   d="scan'208";a="339128696"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2022 16:31:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,140,1643702400"; 
   d="scan'208";a="509660379"
Received: from lkp-server01.sh.intel.com (HELO 788b1cd46f0d) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 26 Feb 2022 16:31:12 -0800
Received: from kbuild by 788b1cd46f0d with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nO7Sx-00064e-MO; Sun, 27 Feb 2022 00:31:11 +0000
Date:   Sun, 27 Feb 2022 08:30:46 +0800
From:   kernel test robot <lkp@intel.com>
To:     Hannes Reinecke <hare@suse.de>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [hare-scsi-devel:tls-upcall.v2 149/159] <command-line>: warning:
 format '%lu' expects argument of type 'long unsigned int', but argument 5
 has type 'size_t' {aka 'unsigned int'}
Message-ID: <202202270827.WapljpyD-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FROM_FMBLA_NEWDOM,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/hare/scsi-devel.git tls-upcall.v2
head:   21b520ae0b338bd30496feb1ca90a2820dab7a65
commit: 96e2b9364c5e070dab1a5d438376a406ab66690d [149/159] nvme-tcp: cmsg for tls recvmsg()
config: arc-randconfig-r043-20220227 (https://download.01.org/0day-ci/archive/20220227/202202270827.WapljpyD-lkp@intel.com/config)
compiler: arc-elf-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/hare/scsi-devel.git/commit/?id=96e2b9364c5e070dab1a5d438376a406ab66690d
        git remote add hare-scsi-devel https://git.kernel.org/pub/scm/linux/kernel/git/hare/scsi-devel.git
        git fetch --no-tags hare-scsi-devel tls-upcall.v2
        git checkout 96e2b9364c5e070dab1a5d438376a406ab66690d
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arc SHELL=/bin/bash drivers/nvme/host/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   drivers/nvme/host/tcp.c: In function 'nvme_tcp_init_connection':
>> <command-line>: warning: format '%lu' expects argument of type 'long unsigned int', but argument 5 has type 'size_t' {aka 'unsigned int'} [-Wformat=]
   drivers/nvme/host/tcp.c:6:21: note: in expansion of macro 'KBUILD_MODNAME'
       6 | #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
         |                     ^~~~~~~~~~~~~~
   include/linux/dynamic_debug.h:134:29: note: in expansion of macro 'pr_fmt'
     134 |                 func(&id, ##__VA_ARGS__);               \
         |                             ^~~~~~~~~~~
   include/linux/dynamic_debug.h:152:9: note: in expansion of macro '__dynamic_func_call'
     152 |         __dynamic_func_call(__UNIQUE_ID(ddebug), fmt, func, ##__VA_ARGS__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/linux/dynamic_debug.h:162:9: note: in expansion of macro '_dynamic_func_call'
     162 |         _dynamic_func_call(fmt, __dynamic_pr_debug,             \
         |         ^~~~~~~~~~~~~~~~~~
   include/linux/printk.h:574:9: note: in expansion of macro 'dynamic_pr_debug'
     574 |         dynamic_pr_debug(fmt, ##__VA_ARGS__)
         |         ^~~~~~~~~~~~~~~~
   drivers/nvme/host/tcp.c:1298:9: note: in expansion of macro 'pr_debug'
    1298 |         pr_debug("queue %d: sent %d/%lu icreq bytes\n",
         |         ^~~~~~~~
>> <command-line>: warning: format '%lu' expects argument of type 'long unsigned int', but argument 5 has type 'size_t' {aka 'unsigned int'} [-Wformat=]
   drivers/nvme/host/tcp.c:6:21: note: in expansion of macro 'KBUILD_MODNAME'
       6 | #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
         |                     ^~~~~~~~~~~~~~
   include/linux/dynamic_debug.h:134:29: note: in expansion of macro 'pr_fmt'
     134 |                 func(&id, ##__VA_ARGS__);               \
         |                             ^~~~~~~~~~~
   include/linux/dynamic_debug.h:152:9: note: in expansion of macro '__dynamic_func_call'
     152 |         __dynamic_func_call(__UNIQUE_ID(ddebug), fmt, func, ##__VA_ARGS__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/linux/dynamic_debug.h:162:9: note: in expansion of macro '_dynamic_func_call'
     162 |         _dynamic_func_call(fmt, __dynamic_pr_debug,             \
         |         ^~~~~~~~~~~~~~~~~~
   include/linux/printk.h:574:9: note: in expansion of macro 'dynamic_pr_debug'
     574 |         dynamic_pr_debug(fmt, ##__VA_ARGS__)
         |         ^~~~~~~~~~~~~~~~
   drivers/nvme/host/tcp.c:1327:9: note: in expansion of macro 'pr_debug'
    1327 |         pr_debug("queue %d: received %d/%lu icresp bytes\n",
         |         ^~~~~~~~

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
