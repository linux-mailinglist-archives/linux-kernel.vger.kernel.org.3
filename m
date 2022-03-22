Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2D454E484D
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 22:32:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235676AbiCVVeE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 17:34:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230262AbiCVVeC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 17:34:02 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63D635C373
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 14:32:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647984754; x=1679520754;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=4YecuNbZ7H1xwUMk5C43gwWXdMFDqhF42R5lIuM3GFQ=;
  b=QbCnD6hNZuPxTV0aoApTR+P5lIiLxRLEtZRNWe/Q+arAxddT0jvu8c+6
   strYBL8SDSrdI187S+znAhmEM/YvYeybc65hyFi/paUKNb3tb+ctFXi75
   9TjQ527EftveoaS6c8ptmtAiErOtOj/ND6t8echbBh/mg9C/jrZ4cEk1H
   fh4aPbl/CXI+4h7ErjkJRCgIzYkNvA+CGb/Upupj31n1PKnosMkZRQnqD
   vEg8JqLHAuTwQY8WESk5Nkfh3Zy+o9A7E06iZ8bYbWnmBz3v2Cvo2rx5w
   No9SQwcVz/p9U8nlA9n2TnRWYLWYHmqUYgDTRvV9aCDfrX/To2wKbWvDo
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10294"; a="282793763"
X-IronPort-AV: E=Sophos;i="5.90,202,1643702400"; 
   d="scan'208";a="282793763"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2022 14:32:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,202,1643702400"; 
   d="scan'208";a="717133400"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 22 Mar 2022 14:32:32 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nWm7D-000JJ7-Sa; Tue, 22 Mar 2022 21:32:31 +0000
Date:   Wed, 23 Mar 2022 05:31:33 +0800
From:   kernel test robot <lkp@intel.com>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [amir73il:fan_evictable 8/8]
 fs/notify/fanotify/fanotify_user.c:1834:38: error: unterminated argument
 list invoking macro "if"
Message-ID: <202203230546.qTDYhD1c-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/amir73il/linux fan_evictable
head:   124c00a81cb264d633c45154392e0b1835fa7fd2
commit: 124c00a81cb264d633c45154392e0b1835fa7fd2 [8/8] fanotify: introduce FAN_MARK_LARGE for testing
config: nds32-buildonly-randconfig-r001-20220320 (https://download.01.org/0day-ci/archive/20220323/202203230546.qTDYhD1c-lkp@intel.com/config)
compiler: nds32le-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/amir73il/linux/commit/124c00a81cb264d633c45154392e0b1835fa7fd2
        git remote add amir73il https://github.com/amir73il/linux
        git fetch --no-tags amir73il fan_evictable
        git checkout 124c00a81cb264d633c45154392e0b1835fa7fd2
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=nds32 SHELL=/bin/bash fs/notify/fanotify/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All error/warnings (new ones prefixed by >>):

   fs/notify/fanotify/fanotify_user.c: In function 'do_fanotify_mark':
>> fs/notify/fanotify/fanotify_user.c:1834:38: error: unterminated argument list invoking macro "if"
    1834 | device_initcall(fanotify_user_setup);
         |                                      ^
>> fs/notify/fanotify/fanotify_user.c:1835: error: expected '(' at end of input
   fs/notify/fanotify/fanotify_user.c:1634:9: note: '-Wmisleading-indentation' is disabled from this point onwards, since column-tracking was disabled due to the size of the code/headers
    1634 |         if ((!capable(CAP_SYS_ADMIN) ||
         |         ^~
   fs/notify/fanotify/fanotify_user.c:1634:9: note: adding '-flarge-source-files' will allow for more column-tracking support, at the expense of compilation time and memory
>> fs/notify/fanotify/fanotify_user.c:1634:9: error: expected declaration or statement at end of input
   fs/notify/fanotify/fanotify_user.c:1625:17: error: label 'fput_and_out' used but not defined
    1625 |                 goto fput_and_out;
         |                 ^~~~
   fs/notify/fanotify/fanotify_user.c:1568:13: warning: variable 'ret' set but not used [-Wunused-but-set-variable]
    1568 |         int ret;
         |             ^~~
   fs/notify/fanotify/fanotify_user.c:1567:13: warning: unused variable 'umask' [-Wunused-variable]
    1567 |         u32 umask = 0;
         |             ^~~~~
   fs/notify/fanotify/fanotify_user.c:1566:32: warning: unused variable 'fid_mode' [-Wunused-variable]
    1566 |         unsigned int obj_type, fid_mode;
         |                                ^~~~~~~~
   fs/notify/fanotify/fanotify_user.c:1566:22: warning: variable 'obj_type' set but not used [-Wunused-but-set-variable]
    1566 |         unsigned int obj_type, fid_mode;
         |                      ^~~~~~~~
   fs/notify/fanotify/fanotify_user.c:1562:34: warning: unused variable 'fsid' [-Wunused-variable]
    1562 |         __kernel_fsid_t __fsid, *fsid = NULL;
         |                                  ^~~~
   fs/notify/fanotify/fanotify_user.c:1562:25: warning: unused variable '__fsid' [-Wunused-variable]
    1562 |         __kernel_fsid_t __fsid, *fsid = NULL;
         |                         ^~~~~~
   fs/notify/fanotify/fanotify_user.c:1561:21: warning: unused variable 'path' [-Wunused-variable]
    1561 |         struct path path;
         |                     ^~~~
>> fs/notify/fanotify/fanotify_user.c:1559:32: warning: variable 'group' set but not used [-Wunused-but-set-variable]
    1559 |         struct fsnotify_group *group;
         |                                ^~~~~
   fs/notify/fanotify/fanotify_user.c:1558:26: warning: unused variable 'mnt' [-Wunused-variable]
    1558 |         struct vfsmount *mnt = NULL;
         |                          ^~~
   fs/notify/fanotify/fanotify_user.c:1557:23: warning: unused variable 'inode' [-Wunused-variable]
    1557 |         struct inode *inode = NULL;
         |                       ^~~~~
   At top level:
   fs/notify/fanotify/fanotify_user.c:1554:12: warning: 'do_fanotify_mark' defined but not used [-Wunused-function]
    1554 | static int do_fanotify_mark(int fanotify_fd, unsigned int flags, __u64 mask,
         |            ^~~~~~~~~~~~~~~~
   fs/notify/fanotify/fanotify_user.c:1538:12: warning: 'fanotify_events_supported' defined but not used [-Wunused-function]
    1538 | static int fanotify_events_supported(struct path *path, __u64 mask)
         |            ^~~~~~~~~~~~~~~~~~~~~~~~~
   fs/notify/fanotify/fanotify_user.c:1522:12: warning: 'fanotify_test_fid' defined but not used [-Wunused-function]
    1522 | static int fanotify_test_fid(struct dentry *dentry)
         |            ^~~~~~~~~~~~~~~~~
   fs/notify/fanotify/fanotify_user.c:1491:12: warning: 'fanotify_test_fsid' defined but not used [-Wunused-function]
    1491 | static int fanotify_test_fsid(struct dentry *dentry, __kernel_fsid_t *fsid)
         |            ^~~~~~~~~~~~~~~~~~
   fs/notify/fanotify/fanotify_user.c:1279:12: warning: 'fanotify_add_inode_mark' defined but not used [-Wunused-function]
    1279 | static int fanotify_add_inode_mark(struct fsnotify_group *group,
         |            ^~~~~~~~~~~~~~~~~~~~~~~
   fs/notify/fanotify/fanotify_user.c:1271:12: warning: 'fanotify_add_sb_mark' defined but not used [-Wunused-function]
    1271 | static int fanotify_add_sb_mark(struct fsnotify_group *group,
         |            ^~~~~~~~~~~~~~~~~~~~
   fs/notify/fanotify/fanotify_user.c:1263:12: warning: 'fanotify_add_vfsmount_mark' defined but not used [-Wunused-function]
    1263 | static int fanotify_add_vfsmount_mark(struct fsnotify_group *group,
         |            ^~~~~~~~~~~~~~~~~~~~~~~~~~
   fs/notify/fanotify/fanotify_user.c:1079:12: warning: 'fanotify_remove_inode_mark' defined but not used [-Wunused-function]
    1079 | static int fanotify_remove_inode_mark(struct fsnotify_group *group,
         |            ^~~~~~~~~~~~~~~~~~~~~~~~~~
   fs/notify/fanotify/fanotify_user.c:1071:12: warning: 'fanotify_remove_sb_mark' defined but not used [-Wunused-function]
    1071 | static int fanotify_remove_sb_mark(struct fsnotify_group *group,
         |            ^~~~~~~~~~~~~~~~~~~~~~~
   fs/notify/fanotify/fanotify_user.c:1063:12: warning: 'fanotify_remove_vfsmount_mark' defined but not used [-Wunused-function]
    1063 | static int fanotify_remove_vfsmount_mark(struct fsnotify_group *group,
         |            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   fs/notify/fanotify/fanotify_user.c:951:12: warning: 'fanotify_find_path' defined but not used [-Wunused-function]
     951 | static int fanotify_find_path(int dfd, const char __user *filename,
         |            ^~~~~~~~~~~~~~~~~~


vim +/if +1834 fs/notify/fanotify/fanotify_user.c

91c2e0bcae72a3 Al Viro           2013-03-05  1788  
2a3edf86040a7e Eric Paris        2009-12-17  1789  /*
ae0e47f02aaedb Justin P. Mattock 2011-03-01  1790   * fanotify_user_setup - Our initialization function.  Note that we cannot return
2a3edf86040a7e Eric Paris        2009-12-17  1791   * error because we have compiled-in VFS hooks.  So an (unlikely) failure here
2a3edf86040a7e Eric Paris        2009-12-17  1792   * must result in panic().
2a3edf86040a7e Eric Paris        2009-12-17  1793   */
2a3edf86040a7e Eric Paris        2009-12-17  1794  static int __init fanotify_user_setup(void)
2a3edf86040a7e Eric Paris        2009-12-17  1795  {
5b8fea65d197f4 Amir Goldstein    2021-03-04  1796  	struct sysinfo si;
5b8fea65d197f4 Amir Goldstein    2021-03-04  1797  	int max_marks;
5b8fea65d197f4 Amir Goldstein    2021-03-04  1798  
5b8fea65d197f4 Amir Goldstein    2021-03-04  1799  	si_meminfo(&si);
5b8fea65d197f4 Amir Goldstein    2021-03-04  1800  	/*
5b8fea65d197f4 Amir Goldstein    2021-03-04  1801  	 * Allow up to 1% of addressable memory to be accounted for per user
5b8fea65d197f4 Amir Goldstein    2021-03-04  1802  	 * marks limited to the range [8192, 1048576]. mount and sb marks are
5b8fea65d197f4 Amir Goldstein    2021-03-04  1803  	 * a lot cheaper than inode marks, but there is no reason for a user
5b8fea65d197f4 Amir Goldstein    2021-03-04  1804  	 * to have many of those, so calculate by the cost of inode marks.
5b8fea65d197f4 Amir Goldstein    2021-03-04  1805  	 */
5b8fea65d197f4 Amir Goldstein    2021-03-04  1806  	max_marks = (((si.totalram - si.totalhigh) / 100) << PAGE_SHIFT) /
5b8fea65d197f4 Amir Goldstein    2021-03-04  1807  		    INODE_MARK_COST;
5b8fea65d197f4 Amir Goldstein    2021-03-04  1808  	max_marks = clamp(max_marks, FANOTIFY_OLD_DEFAULT_MAX_MARKS,
5b8fea65d197f4 Amir Goldstein    2021-03-04  1809  				     FANOTIFY_DEFAULT_MAX_USER_MARKS);
5b8fea65d197f4 Amir Goldstein    2021-03-04  1810  
a8b98c808eab3e Amir Goldstein    2021-05-24  1811  	BUILD_BUG_ON(FANOTIFY_INIT_FLAGS & FANOTIFY_INTERNAL_GROUP_FLAGS);
d61fd650e9d206 Amir Goldstein    2021-11-29  1812  	BUILD_BUG_ON(HWEIGHT32(FANOTIFY_INIT_FLAGS) != 12);
124c00a81cb264 Amir Goldstein    2022-03-22  1813  	BUILD_BUG_ON(HWEIGHT32(FANOTIFY_MARK_FLAGS) != 11);
bdd5a46fe30653 Amir Goldstein    2018-10-04  1814  
d46eb14b735b11 Shakeel Butt      2018-08-17  1815  	fanotify_mark_cache = KMEM_CACHE(fsnotify_mark,
d46eb14b735b11 Shakeel Butt      2018-08-17  1816  					 SLAB_PANIC|SLAB_ACCOUNT);
7088f35720a55b Jan Kara          2020-03-24  1817  	fanotify_fid_event_cachep = KMEM_CACHE(fanotify_fid_event,
7088f35720a55b Jan Kara          2020-03-24  1818  					       SLAB_PANIC);
7088f35720a55b Jan Kara          2020-03-24  1819  	fanotify_path_event_cachep = KMEM_CACHE(fanotify_path_event,
7088f35720a55b Jan Kara          2020-03-24  1820  						SLAB_PANIC);
6685df31255493 Miklos Szeredi    2017-10-30  1821  	if (IS_ENABLED(CONFIG_FANOTIFY_ACCESS_PERMISSIONS)) {
6685df31255493 Miklos Szeredi    2017-10-30  1822  		fanotify_perm_event_cachep =
33913997d5c067 Amir Goldstein    2019-01-10  1823  			KMEM_CACHE(fanotify_perm_event, SLAB_PANIC);
6685df31255493 Miklos Szeredi    2017-10-30  1824  	}
2a3edf86040a7e Eric Paris        2009-12-17  1825  
5b8fea65d197f4 Amir Goldstein    2021-03-04  1826  	fanotify_max_queued_events = FANOTIFY_DEFAULT_MAX_EVENTS;
5b8fea65d197f4 Amir Goldstein    2021-03-04  1827  	init_user_ns.ucount_max[UCOUNT_FANOTIFY_GROUPS] =
5b8fea65d197f4 Amir Goldstein    2021-03-04  1828  					FANOTIFY_DEFAULT_MAX_GROUPS;
5b8fea65d197f4 Amir Goldstein    2021-03-04  1829  	init_user_ns.ucount_max[UCOUNT_FANOTIFY_MARKS] = max_marks;
7b9ad122b52c98 Xiaoming Ni       2022-01-21  1830  	fanotify_sysctls_init();
5b8fea65d197f4 Amir Goldstein    2021-03-04  1831  
2a3edf86040a7e Eric Paris        2009-12-17  1832  	return 0;
bbaa4168b2d2d8 Eric Paris        2009-12-17  1833  }
2a3edf86040a7e Eric Paris        2009-12-17 @1834  device_initcall(fanotify_user_setup);

:::::: The code at line 1834 was first introduced by commit
:::::: 2a3edf86040a7e15684525a2aadc29f532c51325 fanotify: fanotify_mark syscall implementation

:::::: TO: Eric Paris <eparis@redhat.com>
:::::: CC: Eric Paris <eparis@redhat.com>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
