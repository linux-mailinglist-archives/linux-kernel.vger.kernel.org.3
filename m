Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B6E74E46D6
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 20:40:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231824AbiCVTmE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 15:42:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231753AbiCVTmB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 15:42:01 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C9D4117F
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 12:40:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647978032; x=1679514032;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=eVQpN62bwRAduBhvaKILy1JrCMLgfWnYBJ/tm/j/ycU=;
  b=HcNni3tOoxDfNpTXGEg6zdnkEBGrdOEj4Fe8SwCp74WV+Vv8vfgKfynr
   an1GRZ4WCQ5omtFyO1U+GeXhEDLD0VYqV6GzYbaN6TcPzqFO8L2lL97Ns
   am3rkaJpAMvjlhos9tAJTFSiV1KTt0rjozGSbVz1Vjkx2KUohZX2fqHZX
   pRpGpxF192susrFkebWVQN1ox8gepHhkm3nQCvXZ1TC7/pd04jgcwx6Yh
   aJTVxiyiwvAL9gPtVc5KrBIdPwP7k2BgHbex8tAtrb6FT8twHd791+EpM
   22SsLOkawwE97JV6e7SafY8OFO+7bOJAYYOrko9u5h7nLPJLvQVbS1YNc
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10294"; a="245404697"
X-IronPort-AV: E=Sophos;i="5.90,202,1643702400"; 
   d="scan'208";a="245404697"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2022 12:40:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,202,1643702400"; 
   d="scan'208";a="543865355"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 22 Mar 2022 12:40:30 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nWkMn-000JDu-QM; Tue, 22 Mar 2022 19:40:29 +0000
Date:   Wed, 23 Mar 2022 03:39:30 +0800
From:   kernel test robot <lkp@intel.com>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [amir73il:fan_evictable 8/8]
 fs/notify/fanotify/fanotify_user.c:1568:13: warning: variable 'ret' set but
 not used
Message-ID: <202203230347.wUvYT0j0-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
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
config: ia64-allmodconfig (https://download.01.org/0day-ci/archive/20220323/202203230347.wUvYT0j0-lkp@intel.com/config)
compiler: ia64-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/amir73il/linux/commit/124c00a81cb264d633c45154392e0b1835fa7fd2
        git remote add amir73il https://github.com/amir73il/linux
        git fetch --no-tags amir73il fan_evictable
        git checkout 124c00a81cb264d633c45154392e0b1835fa7fd2
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=ia64 SHELL=/bin/bash fs/notify/fanotify/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   fs/notify/fanotify/fanotify_user.c: In function 'do_fanotify_mark':
   fs/notify/fanotify/fanotify_user.c:1637:37: error: expected ')' before 'goto'
    1637 |              flags & FAN_MARK_LARGE)
         |                                     ^
         |                                     )
    1638 |                 goto fput_and_out;
         |                 ~~~~                 
   fs/notify/fanotify/fanotify_user.c:1634:12: note: to match this '('
    1634 |         if ((!capable(CAP_SYS_ADMIN) ||
         |            ^
   fs/notify/fanotify/fanotify_user.c:1767:1: error: expected expression before '}' token
    1767 | }
         | ^
   fs/notify/fanotify/fanotify_user.c:1625:17: error: label 'fput_and_out' used but not defined
    1625 |                 goto fput_and_out;
         |                 ^~~~
>> fs/notify/fanotify/fanotify_user.c:1568:13: warning: variable 'ret' set but not used [-Wunused-but-set-variable]
    1568 |         int ret;
         |             ^~~
   fs/notify/fanotify/fanotify_user.c:1567:13: warning: unused variable 'umask' [-Wunused-variable]
    1567 |         u32 umask = 0;
         |             ^~~~~
   fs/notify/fanotify/fanotify_user.c:1566:32: warning: unused variable 'fid_mode' [-Wunused-variable]
    1566 |         unsigned int obj_type, fid_mode;
         |                                ^~~~~~~~
>> fs/notify/fanotify/fanotify_user.c:1566:22: warning: variable 'obj_type' set but not used [-Wunused-but-set-variable]
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
   fs/notify/fanotify/fanotify_user.c:1558:26: warning: unused variable 'mnt' [-Wunused-variable]
    1558 |         struct vfsmount *mnt = NULL;
         |                          ^~~
   fs/notify/fanotify/fanotify_user.c:1557:23: warning: unused variable 'inode' [-Wunused-variable]
    1557 |         struct inode *inode = NULL;
         |                       ^~~~~
   fs/notify/fanotify/fanotify_user.c:1767:1: error: control reaches end of non-void function [-Werror=return-type]
    1767 | }
         | ^
   At top level:
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
   cc1: some warnings being treated as errors


vim +/ret +1568 fs/notify/fanotify/fanotify_user.c

0b3b094ac9a7bb Jan Kara                2019-05-15  1553  
183caa3c8668e9 Dominik Brodowski       2018-03-17  1554  static int do_fanotify_mark(int fanotify_fd, unsigned int flags, __u64 mask,
183caa3c8668e9 Dominik Brodowski       2018-03-17  1555  			    int dfd, const char  __user *pathname)
bbaa4168b2d2d8 Eric Paris              2009-12-17  1556  {
0ff21db9fcc390 Eric Paris              2009-12-17  1557  	struct inode *inode = NULL;
0ff21db9fcc390 Eric Paris              2009-12-17  1558  	struct vfsmount *mnt = NULL;
2a3edf86040a7e Eric Paris              2009-12-17  1559  	struct fsnotify_group *group;
2903ff019b346a Al Viro                 2012-08-28  1560  	struct fd f;
2a3edf86040a7e Eric Paris              2009-12-17  1561  	struct path path;
73072283a249c7 Amir Goldstein          2019-01-10  1562  	__kernel_fsid_t __fsid, *fsid = NULL;
bdd5a46fe30653 Amir Goldstein          2018-10-04  1563  	u32 valid_mask = FANOTIFY_EVENTS | FANOTIFY_EVENT_FLAGS;
23c9deeb3285d3 Amir Goldstein          2018-10-04  1564  	unsigned int mark_type = flags & FANOTIFY_MARK_TYPE_BITS;
3ef866536645ce Amir Goldstein          2020-07-16  1565  	bool ignored = flags & FAN_MARK_IGNORED_MASK;
d809daf1b6add5 Amir Goldstein          2020-07-16 @1566  	unsigned int obj_type, fid_mode;
85af5d9258cc58 Amir Goldstein          2020-07-16  1567  	u32 umask = 0;
2903ff019b346a Al Viro                 2012-08-28 @1568  	int ret;
2a3edf86040a7e Eric Paris              2009-12-17  1569  
2a3edf86040a7e Eric Paris              2009-12-17  1570  	pr_debug("%s: fanotify_fd=%d flags=%x dfd=%d pathname=%p mask=%llx\n",
2a3edf86040a7e Eric Paris              2009-12-17  1571  		 __func__, fanotify_fd, flags, dfd, pathname, mask);
2a3edf86040a7e Eric Paris              2009-12-17  1572  
2a3edf86040a7e Eric Paris              2009-12-17  1573  	/* we only use the lower 32 bits as of right now. */
22d483b9986320 Christian Brauner       2021-03-25  1574  	if (upper_32_bits(mask))
2a3edf86040a7e Eric Paris              2009-12-17  1575  		return -EINVAL;
2a3edf86040a7e Eric Paris              2009-12-17  1576  
23c9deeb3285d3 Amir Goldstein          2018-10-04  1577  	if (flags & ~FANOTIFY_MARK_FLAGS)
88380fe66e0ac2 Andreas Gruenbacher     2009-12-17  1578  		return -EINVAL;
d54f4fba889b20 Amir Goldstein          2018-09-01  1579  
d54f4fba889b20 Amir Goldstein          2018-09-01  1580  	switch (mark_type) {
d54f4fba889b20 Amir Goldstein          2018-09-01  1581  	case FAN_MARK_INODE:
ac5656d8a4cdd9 Aaron Goidel            2019-08-12  1582  		obj_type = FSNOTIFY_OBJ_TYPE_INODE;
ac5656d8a4cdd9 Aaron Goidel            2019-08-12  1583  		break;
d54f4fba889b20 Amir Goldstein          2018-09-01  1584  	case FAN_MARK_MOUNT:
ac5656d8a4cdd9 Aaron Goidel            2019-08-12  1585  		obj_type = FSNOTIFY_OBJ_TYPE_VFSMOUNT;
ac5656d8a4cdd9 Aaron Goidel            2019-08-12  1586  		break;
d54f4fba889b20 Amir Goldstein          2018-09-01  1587  	case FAN_MARK_FILESYSTEM:
ac5656d8a4cdd9 Aaron Goidel            2019-08-12  1588  		obj_type = FSNOTIFY_OBJ_TYPE_SB;
d54f4fba889b20 Amir Goldstein          2018-09-01  1589  		break;
d54f4fba889b20 Amir Goldstein          2018-09-01  1590  	default:
d54f4fba889b20 Amir Goldstein          2018-09-01  1591  		return -EINVAL;
d54f4fba889b20 Amir Goldstein          2018-09-01  1592  	}
d54f4fba889b20 Amir Goldstein          2018-09-01  1593  
4d92604cc90aa1 Eric Paris              2009-12-17  1594  	switch (flags & (FAN_MARK_ADD | FAN_MARK_REMOVE | FAN_MARK_FLUSH)) {
df561f6688fef7 Gustavo A. R. Silva     2020-08-23  1595  	case FAN_MARK_ADD:
88380fe66e0ac2 Andreas Gruenbacher     2009-12-17  1596  	case FAN_MARK_REMOVE:
1734dee4e3a296 Lino Sanfilippo         2010-11-22  1597  		if (!mask)
1734dee4e3a296 Lino Sanfilippo         2010-11-22  1598  			return -EINVAL;
cc299a98eb13a9 Heinrich Schuchardt     2014-06-04  1599  		break;
4d92604cc90aa1 Eric Paris              2009-12-17  1600  	case FAN_MARK_FLUSH:
23c9deeb3285d3 Amir Goldstein          2018-10-04  1601  		if (flags & ~(FANOTIFY_MARK_TYPE_BITS | FAN_MARK_FLUSH))
cc299a98eb13a9 Heinrich Schuchardt     2014-06-04  1602  			return -EINVAL;
88380fe66e0ac2 Andreas Gruenbacher     2009-12-17  1603  		break;
88380fe66e0ac2 Andreas Gruenbacher     2009-12-17  1604  	default:
88380fe66e0ac2 Andreas Gruenbacher     2009-12-17  1605  		return -EINVAL;
88380fe66e0ac2 Andreas Gruenbacher     2009-12-17  1606  	}
8fcd65280abc46 Eric Paris              2010-10-28  1607  
6685df31255493 Miklos Szeredi          2017-10-30  1608  	if (IS_ENABLED(CONFIG_FANOTIFY_ACCESS_PERMISSIONS))
23c9deeb3285d3 Amir Goldstein          2018-10-04  1609  		valid_mask |= FANOTIFY_PERM_EVENTS;
6685df31255493 Miklos Szeredi          2017-10-30  1610  
6685df31255493 Miklos Szeredi          2017-10-30  1611  	if (mask & ~valid_mask)
2a3edf86040a7e Eric Paris              2009-12-17  1612  		return -EINVAL;
2a3edf86040a7e Eric Paris              2009-12-17  1613  
3ef866536645ce Amir Goldstein          2020-07-16  1614  	/* Event flags (ONDIR, ON_CHILD) are meaningless in ignored mask */
3ef866536645ce Amir Goldstein          2020-07-16  1615  	if (ignored)
3ef866536645ce Amir Goldstein          2020-07-16  1616  		mask &= ~FANOTIFY_EVENT_FLAGS;
3ef866536645ce Amir Goldstein          2020-07-16  1617  
2903ff019b346a Al Viro                 2012-08-28  1618  	f = fdget(fanotify_fd);
2903ff019b346a Al Viro                 2012-08-28  1619  	if (unlikely(!f.file))
2a3edf86040a7e Eric Paris              2009-12-17  1620  		return -EBADF;
2a3edf86040a7e Eric Paris              2009-12-17  1621  
2a3edf86040a7e Eric Paris              2009-12-17  1622  	/* verify that this is indeed an fanotify instance */
2a3edf86040a7e Eric Paris              2009-12-17  1623  	ret = -EINVAL;
2903ff019b346a Al Viro                 2012-08-28  1624  	if (unlikely(f.file->f_op != &fanotify_fops))
2a3edf86040a7e Eric Paris              2009-12-17  1625  		goto fput_and_out;
2903ff019b346a Al Viro                 2012-08-28  1626  	group = f.file->private_data;
4231a23530a30e Eric Paris              2010-10-28  1627  
7cea2a3c505e87 Amir Goldstein          2021-03-04  1628  	/*
a8b98c808eab3e Amir Goldstein          2021-05-24  1629  	 * An unprivileged user is not allowed to setup mount nor filesystem
a8b98c808eab3e Amir Goldstein          2021-05-24  1630  	 * marks.  This also includes setting up such marks by a group that
a8b98c808eab3e Amir Goldstein          2021-05-24  1631  	 * was initialized by an unprivileged user.
7cea2a3c505e87 Amir Goldstein          2021-03-04  1632  	 */
7cea2a3c505e87 Amir Goldstein          2021-03-04  1633  	ret = -EPERM;
a8b98c808eab3e Amir Goldstein          2021-05-24 @1634  	if ((!capable(CAP_SYS_ADMIN) ||
a8b98c808eab3e Amir Goldstein          2021-05-24  1635  	     FAN_GROUP_FLAG(group, FANOTIFY_UNPRIV)) &&
124c00a81cb264 Amir Goldstein          2022-03-22  1636  	    (mark_type != FAN_MARK_INODE ||
124c00a81cb264 Amir Goldstein          2022-03-22  1637  	     flags & FAN_MARK_LARGE)
7cea2a3c505e87 Amir Goldstein          2021-03-04  1638  		goto fput_and_out;
7cea2a3c505e87 Amir Goldstein          2021-03-04  1639  
4231a23530a30e Eric Paris              2010-10-28  1640  	/*
4231a23530a30e Eric Paris              2010-10-28  1641  	 * group->priority == FS_PRIO_0 == FAN_CLASS_NOTIF.  These are not
4231a23530a30e Eric Paris              2010-10-28  1642  	 * allowed to set permissions events.
4231a23530a30e Eric Paris              2010-10-28  1643  	 */
4231a23530a30e Eric Paris              2010-10-28  1644  	ret = -EINVAL;
23c9deeb3285d3 Amir Goldstein          2018-10-04  1645  	if (mask & FANOTIFY_PERM_EVENTS &&
4231a23530a30e Eric Paris              2010-10-28  1646  	    group->priority == FS_PRIO_0)
4231a23530a30e Eric Paris              2010-10-28  1647  		goto fput_and_out;
2a3edf86040a7e Eric Paris              2009-12-17  1648  
9709bd548f11a0 Gabriel Krisman Bertazi 2021-10-25  1649  	if (mask & FAN_FS_ERROR &&
9709bd548f11a0 Gabriel Krisman Bertazi 2021-10-25  1650  	    mark_type != FAN_MARK_FILESYSTEM)
9709bd548f11a0 Gabriel Krisman Bertazi 2021-10-25  1651  		goto fput_and_out;
9709bd548f11a0 Gabriel Krisman Bertazi 2021-10-25  1652  
615ff7e609bdbc Amir Goldstein          2022-03-22  1653  	/*
615ff7e609bdbc Amir Goldstein          2022-03-22  1654  	 * Evictable is only relevant for inode marks, because only inode object
615ff7e609bdbc Amir Goldstein          2022-03-22  1655  	 * can be evicted on memory pressure.
615ff7e609bdbc Amir Goldstein          2022-03-22  1656  	 */
615ff7e609bdbc Amir Goldstein          2022-03-22  1657  	if (flags & FAN_MARK_EVICTABLE &&
615ff7e609bdbc Amir Goldstein          2022-03-22  1658  	     mark_type != FAN_MARK_INODE)
615ff7e609bdbc Amir Goldstein          2022-03-22  1659  		goto fput_and_out;
615ff7e609bdbc Amir Goldstein          2022-03-22  1660  
235328d1fa4251 Amir Goldstein          2019-01-10  1661  	/*
4fe595cf1c80e7 Gabriel Krisman Bertazi 2021-10-25  1662  	 * Events that do not carry enough information to report
4fe595cf1c80e7 Gabriel Krisman Bertazi 2021-10-25  1663  	 * event->fd require a group that supports reporting fid.  Those
4fe595cf1c80e7 Gabriel Krisman Bertazi 2021-10-25  1664  	 * events are not supported on a mount mark, because they do not
4fe595cf1c80e7 Gabriel Krisman Bertazi 2021-10-25  1665  	 * carry enough information (i.e. path) to be filtered by mount
4fe595cf1c80e7 Gabriel Krisman Bertazi 2021-10-25  1666  	 * point.
235328d1fa4251 Amir Goldstein          2019-01-10  1667  	 */
d809daf1b6add5 Amir Goldstein          2020-07-16  1668  	fid_mode = FAN_GROUP_FLAG(group, FANOTIFY_FID_BITS);
4fe595cf1c80e7 Gabriel Krisman Bertazi 2021-10-25  1669  	if (mask & ~(FANOTIFY_FD_EVENTS|FANOTIFY_EVENT_FLAGS) &&
d809daf1b6add5 Amir Goldstein          2020-07-16  1670  	    (!fid_mode || mark_type == FAN_MARK_MOUNT))
235328d1fa4251 Amir Goldstein          2019-01-10  1671  		goto fput_and_out;
235328d1fa4251 Amir Goldstein          2019-01-10  1672  
8cc3b1ccd930fe Amir Goldstein          2021-11-29  1673  	/*
8cc3b1ccd930fe Amir Goldstein          2021-11-29  1674  	 * FAN_RENAME uses special info type records to report the old and
8cc3b1ccd930fe Amir Goldstein          2021-11-29  1675  	 * new parent+name.  Reporting only old and new parent id is less
8cc3b1ccd930fe Amir Goldstein          2021-11-29  1676  	 * useful and was not implemented.
8cc3b1ccd930fe Amir Goldstein          2021-11-29  1677  	 */
8cc3b1ccd930fe Amir Goldstein          2021-11-29  1678  	if (mask & FAN_RENAME && !(fid_mode & FAN_REPORT_NAME))
8cc3b1ccd930fe Amir Goldstein          2021-11-29  1679  		goto fput_and_out;
8cc3b1ccd930fe Amir Goldstein          2021-11-29  1680  
0a8dd2db579f7a Heinrich Schuchardt     2014-06-04  1681  	if (flags & FAN_MARK_FLUSH) {
0a8dd2db579f7a Heinrich Schuchardt     2014-06-04  1682  		ret = 0;
d54f4fba889b20 Amir Goldstein          2018-09-01  1683  		if (mark_type == FAN_MARK_MOUNT)
0a8dd2db579f7a Heinrich Schuchardt     2014-06-04  1684  			fsnotify_clear_vfsmount_marks_by_group(group);
d54f4fba889b20 Amir Goldstein          2018-09-01  1685  		else if (mark_type == FAN_MARK_FILESYSTEM)
d54f4fba889b20 Amir Goldstein          2018-09-01  1686  			fsnotify_clear_sb_marks_by_group(group);
0a8dd2db579f7a Heinrich Schuchardt     2014-06-04  1687  		else
0a8dd2db579f7a Heinrich Schuchardt     2014-06-04  1688  			fsnotify_clear_inode_marks_by_group(group);
0a8dd2db579f7a Heinrich Schuchardt     2014-06-04  1689  		goto fput_and_out;
0a8dd2db579f7a Heinrich Schuchardt     2014-06-04  1690  	}
0a8dd2db579f7a Heinrich Schuchardt     2014-06-04  1691  
ac5656d8a4cdd9 Aaron Goidel            2019-08-12  1692  	ret = fanotify_find_path(dfd, pathname, &path, flags,
ac5656d8a4cdd9 Aaron Goidel            2019-08-12  1693  			(mask & ALL_FSNOTIFY_EVENTS), obj_type);
2a3edf86040a7e Eric Paris              2009-12-17  1694  	if (ret)
2a3edf86040a7e Eric Paris              2009-12-17  1695  		goto fput_and_out;
2a3edf86040a7e Eric Paris              2009-12-17  1696  
0b3b094ac9a7bb Jan Kara                2019-05-15  1697  	if (flags & FAN_MARK_ADD) {
0b3b094ac9a7bb Jan Kara                2019-05-15  1698  		ret = fanotify_events_supported(&path, mask);
0b3b094ac9a7bb Jan Kara                2019-05-15  1699  		if (ret)
0b3b094ac9a7bb Jan Kara                2019-05-15  1700  			goto path_put_and_out;
0b3b094ac9a7bb Jan Kara                2019-05-15  1701  	}
0b3b094ac9a7bb Jan Kara                2019-05-15  1702  
d809daf1b6add5 Amir Goldstein          2020-07-16  1703  	if (fid_mode) {
8299212cbdb01a Gabriel Krisman Bertazi 2021-10-25  1704  		ret = fanotify_test_fsid(path.dentry, &__fsid);
8299212cbdb01a Gabriel Krisman Bertazi 2021-10-25  1705  		if (ret)
8299212cbdb01a Gabriel Krisman Bertazi 2021-10-25  1706  			goto path_put_and_out;
8299212cbdb01a Gabriel Krisman Bertazi 2021-10-25  1707  
8299212cbdb01a Gabriel Krisman Bertazi 2021-10-25  1708  		ret = fanotify_test_fid(path.dentry);
a8b13aa20afb69 Amir Goldstein          2019-01-10  1709  		if (ret)
a8b13aa20afb69 Amir Goldstein          2019-01-10  1710  			goto path_put_and_out;
77115225acc67d Amir Goldstein          2019-01-10  1711  
73072283a249c7 Amir Goldstein          2019-01-10  1712  		fsid = &__fsid;
a8b13aa20afb69 Amir Goldstein          2019-01-10  1713  	}
a8b13aa20afb69 Amir Goldstein          2019-01-10  1714  
2a3edf86040a7e Eric Paris              2009-12-17  1715  	/* inode held in place by reference to path; group by fget on fd */
d54f4fba889b20 Amir Goldstein          2018-09-01  1716  	if (mark_type == FAN_MARK_INODE)
2a3edf86040a7e Eric Paris              2009-12-17  1717  		inode = path.dentry->d_inode;
0ff21db9fcc390 Eric Paris              2009-12-17  1718  	else
0ff21db9fcc390 Eric Paris              2009-12-17  1719  		mnt = path.mnt;
2a3edf86040a7e Eric Paris              2009-12-17  1720  
85af5d9258cc58 Amir Goldstein          2020-07-16  1721  	/* Mask out FAN_EVENT_ON_CHILD flag for sb/mount/non-dir marks */
85af5d9258cc58 Amir Goldstein          2020-07-16  1722  	if (mnt || !S_ISDIR(inode->i_mode)) {
85af5d9258cc58 Amir Goldstein          2020-07-16  1723  		mask &= ~FAN_EVENT_ON_CHILD;
85af5d9258cc58 Amir Goldstein          2020-07-16  1724  		umask = FAN_EVENT_ON_CHILD;
5128063739d293 Amir Goldstein          2020-07-16  1725  		/*
5128063739d293 Amir Goldstein          2020-07-16  1726  		 * If group needs to report parent fid, register for getting
5128063739d293 Amir Goldstein          2020-07-16  1727  		 * events with parent/name info for non-directory.
5128063739d293 Amir Goldstein          2020-07-16  1728  		 */
5128063739d293 Amir Goldstein          2020-07-16  1729  		if ((fid_mode & FAN_REPORT_DIR_FID) &&
5128063739d293 Amir Goldstein          2020-07-16  1730  		    (flags & FAN_MARK_ADD) && !ignored)
5128063739d293 Amir Goldstein          2020-07-16  1731  			mask |= FAN_EVENT_ON_CHILD;
85af5d9258cc58 Amir Goldstein          2020-07-16  1732  	}
85af5d9258cc58 Amir Goldstein          2020-07-16  1733  
2a3edf86040a7e Eric Paris              2009-12-17  1734  	/* create/update an inode mark */
0a8dd2db579f7a Heinrich Schuchardt     2014-06-04  1735  	switch (flags & (FAN_MARK_ADD | FAN_MARK_REMOVE)) {
c6223f464927ca Andreas Gruenbacher     2009-12-17  1736  	case FAN_MARK_ADD:
d54f4fba889b20 Amir Goldstein          2018-09-01  1737  		if (mark_type == FAN_MARK_MOUNT)
77115225acc67d Amir Goldstein          2019-01-10  1738  			ret = fanotify_add_vfsmount_mark(group, mnt, mask,
77115225acc67d Amir Goldstein          2019-01-10  1739  							 flags, fsid);
d54f4fba889b20 Amir Goldstein          2018-09-01  1740  		else if (mark_type == FAN_MARK_FILESYSTEM)
77115225acc67d Amir Goldstein          2019-01-10  1741  			ret = fanotify_add_sb_mark(group, mnt->mnt_sb, mask,
77115225acc67d Amir Goldstein          2019-01-10  1742  						   flags, fsid);
0ff21db9fcc390 Eric Paris              2009-12-17  1743  		else
77115225acc67d Amir Goldstein          2019-01-10  1744  			ret = fanotify_add_inode_mark(group, inode, mask,
77115225acc67d Amir Goldstein          2019-01-10  1745  						      flags, fsid);
c6223f464927ca Andreas Gruenbacher     2009-12-17  1746  		break;
c6223f464927ca Andreas Gruenbacher     2009-12-17  1747  	case FAN_MARK_REMOVE:
d54f4fba889b20 Amir Goldstein          2018-09-01  1748  		if (mark_type == FAN_MARK_MOUNT)
77115225acc67d Amir Goldstein          2019-01-10  1749  			ret = fanotify_remove_vfsmount_mark(group, mnt, mask,
85af5d9258cc58 Amir Goldstein          2020-07-16  1750  							    flags, umask);
d54f4fba889b20 Amir Goldstein          2018-09-01  1751  		else if (mark_type == FAN_MARK_FILESYSTEM)
77115225acc67d Amir Goldstein          2019-01-10  1752  			ret = fanotify_remove_sb_mark(group, mnt->mnt_sb, mask,
85af5d9258cc58 Amir Goldstein          2020-07-16  1753  						      flags, umask);
f3640192c0a177 Andreas Gruenbacher     2009-12-17  1754  		else
77115225acc67d Amir Goldstein          2019-01-10  1755  			ret = fanotify_remove_inode_mark(group, inode, mask,
85af5d9258cc58 Amir Goldstein          2020-07-16  1756  							 flags, umask);
c6223f464927ca Andreas Gruenbacher     2009-12-17  1757  		break;
c6223f464927ca Andreas Gruenbacher     2009-12-17  1758  	default:
c6223f464927ca Andreas Gruenbacher     2009-12-17  1759  		ret = -EINVAL;
c6223f464927ca Andreas Gruenbacher     2009-12-17  1760  	}
2a3edf86040a7e Eric Paris              2009-12-17  1761  
a8b13aa20afb69 Amir Goldstein          2019-01-10  1762  path_put_and_out:
2a3edf86040a7e Eric Paris              2009-12-17  1763  	path_put(&path);
2a3edf86040a7e Eric Paris              2009-12-17  1764  fput_and_out:
2903ff019b346a Al Viro                 2012-08-28  1765  	fdput(f);
2a3edf86040a7e Eric Paris              2009-12-17  1766  	return ret;
2a3edf86040a7e Eric Paris              2009-12-17  1767  }
2a3edf86040a7e Eric Paris              2009-12-17  1768  

:::::: The code at line 1568 was first introduced by commit
:::::: 2903ff019b346ab8d36ebbf54853c3aaf6590608 switch simple cases of fget_light to fdget

:::::: TO: Al Viro <viro@zeniv.linux.org.uk>
:::::: CC: Al Viro <viro@zeniv.linux.org.uk>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
