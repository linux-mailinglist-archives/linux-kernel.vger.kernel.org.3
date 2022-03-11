Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 262874D6A58
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Mar 2022 00:26:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229790AbiCKWvF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 17:51:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbiCKWus (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 17:50:48 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C224F26C54B
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 14:32:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647037934; x=1678573934;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=MMwq4VJd3WwBUQgQFIlXAjltBe+bytuBVNYxACJgaQs=;
  b=nAaG6N9RqewMbtSJNQZKgnOzhgwJnfz7sRikfp7k/xIX5Nq0XgsYN8BI
   H+Qo0MWlc0oUPyDu9iiE9NxyU2oYoWtJ2rS8OXNSHtf0fd6mwmA7Ungqk
   XxXZEawaTHfN9tXMcmuomsQKPU+ASQwK8GfEMnYNq4onp11gOROjbvD8u
   AUhO8GYbSZ7aVI9/bHCb05VncG/Xe8lkbUPsx6cKfJbhwO77kxD0NJStN
   Sp4SO0uVckXJHtDLkE14MJUTukFn7+qvAjgGLL24cW2sgR9syjic9RD56
   J+qBEFc067VwGG7RACbf9t0WNhFm2LMgFVeHfp1TkMUeXgAkWWJwmCpMx
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10283"; a="255390979"
X-IronPort-AV: E=Sophos;i="5.90,174,1643702400"; 
   d="scan'208";a="255390979"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2022 13:25:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,174,1643702400"; 
   d="scan'208";a="511511142"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga002.jf.intel.com with ESMTP; 11 Mar 2022 13:25:08 -0800
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nSml1-00077X-SG; Fri, 11 Mar 2022 21:25:07 +0000
Date:   Sat, 12 Mar 2022 05:24:54 +0800
From:   kernel test robot <lkp@intel.com>
To:     Anuj Gupta <anuj20.g@samsung.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kanchan Joshi <joshi.k@samsung.com>
Subject: [mcgrof-next:20220311-io-uring-cmd 6/17]
 include/linux/io_uring.h:53:5: warning: no previous prototype for
 'io_uring_cmd_import_fixed'
Message-ID: <202203120537.2MDWUU2D-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux-next.git 20220311-io-uring-cmd
head:   abe791464a630c1cc3821258e002a0a623dc9b5a
commit: 6e63b680e18e66346f48ea7b637f778e146fb82f [6/17] io_uring: prep for fixed-buffer enabled uring-cmd
config: sparc-buildonly-randconfig-r003-20220310 (https://download.01.org/0day-ci/archive/20220312/202203120537.2MDWUU2D-lkp@intel.com/config)
compiler: sparc-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux-next.git/commit/?id=6e63b680e18e66346f48ea7b637f778e146fb82f
        git remote add mcgrof-next https://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux-next.git
        git fetch --no-tags mcgrof-next 20220311-io-uring-cmd
        git checkout 6e63b680e18e66346f48ea7b637f778e146fb82f
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=sparc SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from kernel/fork.c:98:
>> include/linux/io_uring.h:53:5: warning: no previous prototype for 'io_uring_cmd_import_fixed' [-Wmissing-prototypes]
      53 | int io_uring_cmd_import_fixed(u64 ubuf, unsigned long len,
         |     ^~~~~~~~~~~~~~~~~~~~~~~~~
   kernel/fork.c:162:13: warning: no previous prototype for 'arch_release_task_struct' [-Wmissing-prototypes]
     162 | void __weak arch_release_task_struct(struct task_struct *tsk)
         |             ^~~~~~~~~~~~~~~~~~~~~~~~
   kernel/fork.c:764:20: warning: no previous prototype for 'arch_task_cache_init' [-Wmissing-prototypes]
     764 | void __init __weak arch_task_cache_init(void) { }
         |                    ^~~~~~~~~~~~~~~~~~~~
   kernel/fork.c:859:12: warning: no previous prototype for 'arch_dup_task_struct' [-Wmissing-prototypes]
     859 | int __weak arch_dup_task_struct(struct task_struct *dst,
         |            ^~~~~~~~~~~~~~~~~~~~
--
   In file included from kernel/exit.c:65:
>> include/linux/io_uring.h:53:5: warning: no previous prototype for 'io_uring_cmd_import_fixed' [-Wmissing-prototypes]
      53 | int io_uring_cmd_import_fixed(u64 ubuf, unsigned long len,
         |     ^~~~~~~~~~~~~~~~~~~~~~~~~
   kernel/exit.c:1824:13: warning: no previous prototype for 'abort' [-Wmissing-prototypes]
    1824 | __weak void abort(void)
         |             ^~~~~
--
   In file included from fs/exec.c:66:
>> include/linux/io_uring.h:53:5: warning: no previous prototype for 'io_uring_cmd_import_fixed' [-Wmissing-prototypes]
      53 | int io_uring_cmd_import_fixed(u64 ubuf, unsigned long len,
         |     ^~~~~~~~~~~~~~~~~~~~~~~~~


vim +/io_uring_cmd_import_fixed +53 include/linux/io_uring.h

    36	
    37	static inline void io_uring_files_cancel(void)
    38	{
    39		if (current->io_uring)
    40			__io_uring_cancel(false);
    41	}
    42	static inline void io_uring_task_cancel(void)
    43	{
    44		if (current->io_uring)
    45			__io_uring_cancel(true);
    46	}
    47	static inline void io_uring_free(struct task_struct *tsk)
    48	{
    49		if (tsk->io_uring)
    50			__io_uring_free(tsk);
    51	}
    52	#else
  > 53	int io_uring_cmd_import_fixed(u64 ubuf, unsigned long len,
    54			int rw, struct iov_iter *iter, void *ioucmd)
    55	{
    56		return -1;
    57	}
    58	static inline void io_uring_cmd_done(struct io_uring_cmd *cmd, ssize_t ret)
    59	{
    60	}
    61	static inline void io_uring_cmd_complete_in_task(struct io_uring_cmd *ioucmd,
    62				void (*driver_cb)(struct io_uring_cmd *))
    63	{
    64	}
    65	static inline struct sock *io_uring_get_socket(struct file *file)
    66	{
    67		return NULL;
    68	}
    69	static inline void io_uring_task_cancel(void)
    70	{
    71	}
    72	static inline void io_uring_files_cancel(void)
    73	{
    74	}
    75	static inline void io_uring_free(struct task_struct *tsk)
    76	{
    77	}
    78	#endif
    79	

---
0-DAY CI Kernel Test Service
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
