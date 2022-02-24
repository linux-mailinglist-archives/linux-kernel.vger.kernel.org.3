Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00FB14C2085
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 01:15:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245223AbiBXAPY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 19:15:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239973AbiBXAPX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 19:15:23 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27515606E4
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 16:14:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645661695; x=1677197695;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=zQUmlgChyzMbyYMRmey7n1zKR+Div7iBoiP6Wm1FY8s=;
  b=fK/4m2bye6uav+TQjOLdDnhMJp9Yccth7Hso8QNA76gBELit/Ey7XmCv
   f9SnjEm+yxaV+SAj+K0dhmn6mte35DBXHPtvbKfE8ZBHAVkvK5bbf2VZQ
   iGBx0m5lJVfyJxCLfACjzD0uaZRRNZkyioi2XjYeJqSSXBbSJx5zHf+pZ
   4dbbZyadnn3xt2GFJSW3sN9pOCtdUde+pnNieL4qDg1eTYl0FnPnf/VGf
   H8Hm/U+YZvu15VEIin7PmQ/HHRH1iqEyDrm/fqxjda+NZUyhKqFNhjH/f
   VQuIH6CWr9KolCgjB421AovI0COJD+D+D+bVU6ZHTRH8mPhqvt3aBmQwm
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10267"; a="315339295"
X-IronPort-AV: E=Sophos;i="5.88,392,1635231600"; 
   d="scan'208";a="315339295"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2022 16:14:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,392,1635231600"; 
   d="scan'208";a="491400477"
Received: from lkp-server01.sh.intel.com (HELO 788b1cd46f0d) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 23 Feb 2022 16:14:53 -0800
Received: from kbuild by 788b1cd46f0d with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nN1mW-000207-Ps; Thu, 24 Feb 2022 00:14:52 +0000
Date:   Thu, 24 Feb 2022 08:14:24 +0800
From:   kernel test robot <lkp@intel.com>
To:     Hannes Reinecke <hare@suse.de>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [hare-scsi-devel:tls-upcall.v2 28/67] <command-line>: warning:
 format '%lu' expects argument of type 'long unsigned int', but argument 9
 has type 'size_t' {aka 'unsigned int'}
Message-ID: <202202240808.1QpLOeqY-lkp@intel.com>
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

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/hare/scsi-devel.git tls-upcall.v2
head:   ac729ea3c52bda460616c71d5f5fc47b2e64da6d
commit: 3e155fab03919dae359f4f87a1a38d7b0e080f1a [28/67] nvmet-auth: Diffie-Hellman key exchange support
config: arc-allyesconfig (https://download.01.org/0day-ci/archive/20220224/202202240808.1QpLOeqY-lkp@intel.com/config)
compiler: arceb-elf-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/hare/scsi-devel.git/commit/?id=3e155fab03919dae359f4f87a1a38d7b0e080f1a
        git remote add hare-scsi-devel https://git.kernel.org/pub/scm/linux/kernel/git/hare/scsi-devel.git
        git fetch --no-tags hare-scsi-devel tls-upcall.v2
        git checkout 3e155fab03919dae359f4f87a1a38d7b0e080f1a
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arc SHELL=/bin/bash drivers/nvme/ net/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   drivers/nvme/target/fabrics-cmd-auth.c: In function 'nvmet_auth_challenge':
>> <command-line>: warning: format '%lu' expects argument of type 'long unsigned int', but argument 9 has type 'size_t' {aka 'unsigned int'} [-Wformat=]
   drivers/nvme/target/fabrics-cmd-auth.c:7:21: note: in expansion of macro 'KBUILD_MODNAME'
       7 | #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
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
   drivers/nvme/target/fabrics-cmd-auth.c:371:9: note: in expansion of macro 'pr_debug'
     371 |         pr_debug("%s: ctrl %d qid %d seq %d transaction %d hl %d dhvlen %lu\n",
         |         ^~~~~~~~

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
