Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98E8F48A50C
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 02:28:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243588AbiAKB2Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 20:28:25 -0500
Received: from mga11.intel.com ([192.55.52.93]:9992 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230204AbiAKB2V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 20:28:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641864501; x=1673400501;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=yNvF/S5lMPjSPNIBvnaoyQXunzOgVd4Up84RLDknPRc=;
  b=NR7IS2TfLyVQUdOPsSz/H65m/ODvv2al4hr6krUpewvbdzPFoc7c1oAU
   VCbk6ru3UXaJ0Eh05RWQtH6qrQePh8ue9FNEgS54DB0p9OvInE+Y20CMp
   MiEThMVYxnWacgI00qvTMwwwxKy7ifslZb8hW4rZfn8f377mtxng3omZ2
   j8GI0dXXl26hJ6QOcTBJlsTpiEafZsWVlBi4E4tOJmDjuZSZT0bZ2T0Z+
   9DzvLFJTKR5VQjVdRoCri7SlxW56NL3NW7m1AP0WDZtOAnxVafZ8qy2ND
   W+IFabG7h1GXnO8fYdohakFQ/nWRYwGq1yt+YJI7JQkRPHCVDOjMYHHU1
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10223"; a="240927203"
X-IronPort-AV: E=Sophos;i="5.88,278,1635231600"; 
   d="scan'208";a="240927203"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2022 17:28:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,278,1635231600"; 
   d="scan'208";a="514899339"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 10 Jan 2022 17:28:19 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n75xS-0004Az-Df; Tue, 11 Jan 2022 01:28:18 +0000
Date:   Tue, 11 Jan 2022 09:28:04 +0800
From:   kernel test robot <lkp@intel.com>
To:     Dave Chinner <david@fromorbit.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        0day robot <lkp@intel.com>
Subject: fs/xfs/xfs_aops.c:173:1: warning: format '%lu' expects argument of
 type 'long unsigned int', but argument 4 has type 'size_t' {aka 'unsigned
 int'}
Message-ID: <202201110922.MKEJwgs1-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/0day-ci/linux/commits/UPDATE-20220111-073805/trondmy-kernel-org/iomap-Address-soft-lockup-in-iomap_finish_ioend/20211231-034313
head:   f1c8b8b2e616895aa0f5be4e53d4cd1ffa751001
commit: f1c8b8b2e616895aa0f5be4e53d4cd1ffa751001 iomap: Address soft lockup in iomap_finish_ioend()
date:   2 hours ago
config: openrisc-buildonly-randconfig-r002-20220111 (https://download.01.org/0day-ci/archive/20220111/202201110922.MKEJwgs1-lkp@intel.com/config)
compiler: or1k-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/f1c8b8b2e616895aa0f5be4e53d4cd1ffa751001
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review UPDATE-20220111-073805/trondmy-kernel-org/iomap-Address-soft-lockup-in-iomap_finish_ioend/20211231-034313
        git checkout f1c8b8b2e616895aa0f5be4e53d4cd1ffa751001
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=openrisc SHELL=/bin/bash fs/xfs/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from include/linux/cpumask.h:10,
                    from include/linux/smp.h:13,
                    from include/linux/lockdep.h:14,
                    from include/linux/spinlock.h:62,
                    from include/linux/mmzone.h:8,
                    from include/linux/gfp.h:6,
                    from include/linux/slab.h:15,
                    from fs/xfs/kmem.h:9,
                    from fs/xfs/xfs_linux.h:24,
                    from fs/xfs/xfs.h:22,
                    from fs/xfs/xfs_aops.c:7:
   fs/xfs/xfs_aops.c: In function 'xfs_end_io':
>> fs/xfs/xfs_aops.c:173:1: warning: format '%lu' expects argument of type 'long unsigned int', but argument 4 has type 'size_t' {aka 'unsigned int'} [-Wformat=]
     173 | "off 0x%llx, sect 0x%llx size %lu/0x%lx end 0x%llx",
         | ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   ......
     176 |                 ioend->io_size, (ioend->io_size >> 9),
         |                 ~~~~~~~~~~~~~~
         |                      |
         |                      size_t {aka unsigned int}
   include/linux/kernel.h:324:47: note: in definition of macro '__trace_printk_check_format'
     324 |                 ____trace_printk_check_format(fmt, ##args);             \
         |                                               ^~~
   include/linux/kernel.h:361:17: note: in expansion of macro 'do_trace_printk'
     361 |                 do_trace_printk(fmt, ##__VA_ARGS__);    \
         |                 ^~~~~~~~~~~~~~~
   fs/xfs/xfs_aops.c:172:9: note: in expansion of macro 'trace_printk'
     172 |         trace_printk(
         |         ^~~~~~~~~~~~
   fs/xfs/xfs_aops.c:173:33: note: format string is defined here
     173 | "off 0x%llx, sect 0x%llx size %lu/0x%lx end 0x%llx",
         |                               ~~^
         |                                 |
         |                                 long unsigned int
         |                               %u
   In file included from include/linux/cpumask.h:10,
                    from include/linux/smp.h:13,
                    from include/linux/lockdep.h:14,
                    from include/linux/spinlock.h:62,
                    from include/linux/mmzone.h:8,
                    from include/linux/gfp.h:6,
                    from include/linux/slab.h:15,
                    from fs/xfs/kmem.h:9,
                    from fs/xfs/xfs_linux.h:24,
                    from fs/xfs/xfs.h:22,
                    from fs/xfs/xfs_aops.c:7:
>> fs/xfs/xfs_aops.c:173:1: warning: format '%lx' expects argument of type 'long unsigned int', but argument 5 has type 'size_t' {aka 'unsigned int'} [-Wformat=]
     173 | "off 0x%llx, sect 0x%llx size %lu/0x%lx end 0x%llx",
         | ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   ......
     176 |                 ioend->io_size, (ioend->io_size >> 9),
         |                                 ~~~~~~~~~~~~~~~~~~~~~
         |                                                 |
         |                                                 size_t {aka unsigned int}
   include/linux/kernel.h:324:47: note: in definition of macro '__trace_printk_check_format'
     324 |                 ____trace_printk_check_format(fmt, ##args);             \
         |                                               ^~~
   include/linux/kernel.h:361:17: note: in expansion of macro 'do_trace_printk'
     361 |                 do_trace_printk(fmt, ##__VA_ARGS__);    \
         |                 ^~~~~~~~~~~~~~~
   fs/xfs/xfs_aops.c:172:9: note: in expansion of macro 'trace_printk'
     172 |         trace_printk(
         |         ^~~~~~~~~~~~
   fs/xfs/xfs_aops.c:173:39: note: format string is defined here
     173 | "off 0x%llx, sect 0x%llx size %lu/0x%lx end 0x%llx",
         |                                     ~~^
         |                                       |
         |                                       long unsigned int
         |                                     %x
   In file included from include/linux/cpumask.h:10,
                    from include/linux/smp.h:13,
                    from include/linux/lockdep.h:14,
                    from include/linux/spinlock.h:62,
                    from include/linux/mmzone.h:8,
                    from include/linux/gfp.h:6,
                    from include/linux/slab.h:15,
                    from fs/xfs/kmem.h:9,
                    from fs/xfs/xfs_linux.h:24,
                    from fs/xfs/xfs.h:22,
                    from fs/xfs/xfs_aops.c:7:
   fs/xfs/xfs_aops.c:173:1: warning: format '%lu' expects argument of type 'long unsigned int', but argument 5 has type 'size_t' {aka 'unsigned int'} [-Wformat=]
     173 | "off 0x%llx, sect 0x%llx size %lu/0x%lx end 0x%llx",
         | ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   ......
     176 |                 ioend->io_size, (ioend->io_size >> 9),
         |                 ~~~~~~~~~~~~~~
         |                      |
         |                      size_t {aka unsigned int}
   include/linux/kernel.h:377:43: note: in definition of macro 'do_trace_printk'
     377 |                 __trace_printk(_THIS_IP_, fmt, ##args);                 \
         |                                           ^~~
   fs/xfs/xfs_aops.c:172:9: note: in expansion of macro 'trace_printk'
     172 |         trace_printk(
         |         ^~~~~~~~~~~~
   fs/xfs/xfs_aops.c:173:33: note: format string is defined here
     173 | "off 0x%llx, sect 0x%llx size %lu/0x%lx end 0x%llx",
         |                               ~~^
         |                                 |
         |                                 long unsigned int
         |                               %u
   In file included from include/linux/cpumask.h:10,
                    from include/linux/smp.h:13,
                    from include/linux/lockdep.h:14,
                    from include/linux/spinlock.h:62,
                    from include/linux/mmzone.h:8,
                    from include/linux/gfp.h:6,
                    from include/linux/slab.h:15,
                    from fs/xfs/kmem.h:9,
                    from fs/xfs/xfs_linux.h:24,
                    from fs/xfs/xfs.h:22,
                    from fs/xfs/xfs_aops.c:7:
   fs/xfs/xfs_aops.c:173:1: warning: format '%lx' expects argument of type 'long unsigned int', but argument 6 has type 'size_t' {aka 'unsigned int'} [-Wformat=]
     173 | "off 0x%llx, sect 0x%llx size %lu/0x%lx end 0x%llx",
         | ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   ......
     176 |                 ioend->io_size, (ioend->io_size >> 9),
         |                                 ~~~~~~~~~~~~~~~~~~~~~
         |                                                 |
         |                                                 size_t {aka unsigned int}
   include/linux/kernel.h:377:43: note: in definition of macro 'do_trace_printk'
     377 |                 __trace_printk(_THIS_IP_, fmt, ##args);                 \
         |                                           ^~~
   fs/xfs/xfs_aops.c:172:9: note: in expansion of macro 'trace_printk'
     172 |         trace_printk(
         |         ^~~~~~~~~~~~
   fs/xfs/xfs_aops.c:173:39: note: format string is defined here
     173 | "off 0x%llx, sect 0x%llx size %lu/0x%lx end 0x%llx",
         |                                     ~~^
         |                                       |
         |                                       long unsigned int
         |                                     %x


vim +173 fs/xfs/xfs_aops.c

   138	
   139	/*
   140	 * Finish all pending IO completions that require transactional modifications.
   141	 *
   142	 * We try to merge physical and logically contiguous ioends before completion to
   143	 * minimise the number of transactions we need to perform during IO completion.
   144	 * Both unwritten extent conversion and COW remapping need to iterate and modify
   145	 * one physical extent at a time, so we gain nothing by merging physically
   146	 * discontiguous extents here.
   147	 *
   148	 * The ioend chain length that we can be processing here is largely unbound in
   149	 * length and we may have to perform significant amounts of work on each ioend
   150	 * to complete it. Hence we have to be careful about holding the CPU for too
   151	 * long in this loop.
   152	 */
   153	void
   154	xfs_end_io(
   155		struct work_struct	*work)
   156	{
   157		struct xfs_inode	*ip =
   158			container_of(work, struct xfs_inode, i_ioend_work);
   159		struct iomap_ioend	*ioend;
   160		struct list_head	tmp;
   161		unsigned long		flags;
   162	
   163		msleep(5000);
   164		spin_lock_irqsave(&ip->i_ioend_lock, flags);
   165		list_replace_init(&ip->i_ioend_list, &tmp);
   166		spin_unlock_irqrestore(&ip->i_ioend_lock, flags);
   167	
   168		iomap_sort_ioends(&tmp);
   169		while ((ioend = list_first_entry_or_null(&tmp, struct iomap_ioend,
   170				io_list))) {
   171			list_del_init(&ioend->io_list);
   172		trace_printk(
 > 173	"off 0x%llx, sect 0x%llx size %lu/0x%lx end 0x%llx",
   174			ioend->io_offset,
   175			ioend->io_sector,
   176			ioend->io_size, (ioend->io_size >> 9),
   177			ioend->io_sector + (ioend->io_size >> 9));
   178	
   179			iomap_ioend_try_merge(ioend, &tmp);
   180			xfs_end_ioend(ioend);
   181			cond_resched();
   182		}
   183	}
   184	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
