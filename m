Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E5AE515AE7
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Apr 2022 09:04:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234477AbiD3HHF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Apr 2022 03:07:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231345AbiD3HHB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Apr 2022 03:07:01 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D50D26620E
        for <linux-kernel@vger.kernel.org>; Sat, 30 Apr 2022 00:03:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651302220; x=1682838220;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=5Kc8qZ8rIzn8zM2YLjvvX98UuDzTt6QppaT3rvHtvds=;
  b=d4XOIZQ97iJKyjNuB5Ul/YtT+2p2Jl1oCsUPmLiuvhom+eoM4TYcOVWm
   v0/+v5t4ywOKcu51CFOSQXU+33HlhHRiUCmgUWdc3Dosy9eAwV6T8xkr1
   YJJZzk4TA+wv1t0bDikjcuBm3wwSbUtrfOqGZjm1fAqv1w28d6OBge8mU
   15Km6oZDSZ3w9LY25AzRCfec4csSU5HAVtIZZG8tCYF8gD40bgQfAfxc5
   NW2Cqu8/OmRO+8wwEVKEaTn7cKIQ0sfNfjbPnkO+XYI2x9fgLrspJ04bY
   zUYgVgg0RwlyMemPiN72VHwudzXenIGGZVe5NXbctB6VSsqoUH0L30xaa
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10332"; a="254246550"
X-IronPort-AV: E=Sophos;i="5.91,187,1647327600"; 
   d="scan'208";a="254246550"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2022 00:03:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,187,1647327600"; 
   d="scan'208";a="515198512"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 30 Apr 2022 00:03:39 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nkh8k-0006yj-Hi;
        Sat, 30 Apr 2022 07:03:38 +0000
Date:   Sat, 30 Apr 2022 15:03:33 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ioannis Angelakopoulos <iangelak@redhat.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [rhvgoyal:ioannis-fanotify 13/18]
 fs/notify/fanotify/fanotify_user.c:1637 do_fanotify_mark() warn:
 inconsistent indenting
Message-ID: <202204301433.yqsNAcRP-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/rhvgoyal/linux ioannis-fanotify
head:   10887e7003a6a801e521d59daff76f0c035f061f
commit: c8e47599d4489ca1c6a72c73882a36b3f5f23b47 [13/18] Fanotify, Inotify: Send remote request when adding a local watch
config: nios2-randconfig-m031-20220428 (https://download.01.org/0day-ci/archive/20220430/202204301433.yqsNAcRP-lkp@intel.com/config)
compiler: nios2-linux-gcc (GCC) 11.3.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

New smatch warnings:
fs/notify/fanotify/fanotify_user.c:1637 do_fanotify_mark() warn: inconsistent indenting
fs/notify/fanotify/fanotify_user.c:1693 do_fanotify_mark() warn: variable dereferenced before check 'inode' (see line 1667)

Old smatch warnings:
arch/nios2/include/asm/thread_info.h:62 current_thread_info() error: uninitialized symbol 'sp'.
fs/notify/fanotify/fanotify_user.c:422 copy_fid_info_to_user() error: we previously assumed 'fh' could be null (see line 381)
fs/notify/fanotify/fanotify_user.c:1686 do_fanotify_mark() error: we previously assumed 'mnt' could be null (see line 1667)
fs/notify/fanotify/fanotify_user.c:1710 do_fanotify_mark() warn: variable dereferenced before check 'inode' (see line 1667)

vim +1637 fs/notify/fanotify/fanotify_user.c

  1501	
  1502	static int do_fanotify_mark(int fanotify_fd, unsigned int flags, __u64 mask,
  1503				    int dfd, const char  __user *pathname)
  1504	{
  1505		struct inode *inode = NULL;
  1506		struct vfsmount *mnt = NULL;
  1507		struct fsnotify_group *group;
  1508		struct fd f;
  1509		struct path path;
  1510		__kernel_fsid_t __fsid, *fsid = NULL;
  1511		u32 valid_mask = FANOTIFY_EVENTS | FANOTIFY_EVENT_FLAGS;
  1512		unsigned int mark_type = flags & FANOTIFY_MARK_TYPE_BITS;
  1513		bool ignored = flags & FAN_MARK_IGNORED_MASK;
  1514		unsigned int obj_type, fid_mode;
  1515		u32 umask = 0;
  1516		int ret;
  1517	
  1518		pr_debug("%s: fanotify_fd=%d flags=%x dfd=%d pathname=%p mask=%llx\n",
  1519			 __func__, fanotify_fd, flags, dfd, pathname, mask);
  1520	
  1521		/* we only use the lower 32 bits as of right now. */
  1522		if (upper_32_bits(mask))
  1523			return -EINVAL;
  1524	
  1525		if (flags & ~FANOTIFY_MARK_FLAGS)
  1526			return -EINVAL;
  1527	
  1528		switch (mark_type) {
  1529		case FAN_MARK_INODE:
  1530			obj_type = FSNOTIFY_OBJ_TYPE_INODE;
  1531			break;
  1532		case FAN_MARK_MOUNT:
  1533			obj_type = FSNOTIFY_OBJ_TYPE_VFSMOUNT;
  1534			break;
  1535		case FAN_MARK_FILESYSTEM:
  1536			obj_type = FSNOTIFY_OBJ_TYPE_SB;
  1537			break;
  1538		default:
  1539			return -EINVAL;
  1540		}
  1541	
  1542		switch (flags & (FAN_MARK_ADD | FAN_MARK_REMOVE | FAN_MARK_FLUSH)) {
  1543		case FAN_MARK_ADD:
  1544		case FAN_MARK_REMOVE:
  1545			if (!mask)
  1546				return -EINVAL;
  1547			break;
  1548		case FAN_MARK_FLUSH:
  1549			if (flags & ~(FANOTIFY_MARK_TYPE_BITS | FAN_MARK_FLUSH))
  1550				return -EINVAL;
  1551			break;
  1552		default:
  1553			return -EINVAL;
  1554		}
  1555	
  1556		if (IS_ENABLED(CONFIG_FANOTIFY_ACCESS_PERMISSIONS))
  1557			valid_mask |= FANOTIFY_PERM_EVENTS;
  1558	
  1559		if (mask & ~valid_mask)
  1560			return -EINVAL;
  1561	
  1562		/* Event flags (ONDIR, ON_CHILD) are meaningless in ignored mask */
  1563		if (ignored)
  1564			mask &= ~FANOTIFY_EVENT_FLAGS;
  1565	
  1566		f = fdget(fanotify_fd);
  1567		if (unlikely(!f.file))
  1568			return -EBADF;
  1569	
  1570		/* verify that this is indeed an fanotify instance */
  1571		ret = -EINVAL;
  1572		if (unlikely(f.file->f_op != &fanotify_fops))
  1573			goto fput_and_out;
  1574		group = f.file->private_data;
  1575	
  1576		/*
  1577		 * An unprivileged user is not allowed to setup mount nor filesystem
  1578		 * marks.  This also includes setting up such marks by a group that
  1579		 * was initialized by an unprivileged user.
  1580		 */
  1581		ret = -EPERM;
  1582		if ((!capable(CAP_SYS_ADMIN) ||
  1583		     FAN_GROUP_FLAG(group, FANOTIFY_UNPRIV)) &&
  1584		    mark_type != FAN_MARK_INODE)
  1585			goto fput_and_out;
  1586	
  1587		/*
  1588		 * group->priority == FS_PRIO_0 == FAN_CLASS_NOTIF.  These are not
  1589		 * allowed to set permissions events.
  1590		 */
  1591		ret = -EINVAL;
  1592		if (mask & FANOTIFY_PERM_EVENTS &&
  1593		    group->priority == FS_PRIO_0)
  1594			goto fput_and_out;
  1595	
  1596		if (mask & FAN_FS_ERROR &&
  1597		    mark_type != FAN_MARK_FILESYSTEM)
  1598			goto fput_and_out;
  1599	
  1600		/*
  1601		 * Events that do not carry enough information to report
  1602		 * event->fd require a group that supports reporting fid.  Those
  1603		 * events are not supported on a mount mark, because they do not
  1604		 * carry enough information (i.e. path) to be filtered by mount
  1605		 * point.
  1606		 */
  1607		fid_mode = FAN_GROUP_FLAG(group, FANOTIFY_FID_BITS);
  1608		if (mask & ~(FANOTIFY_FD_EVENTS|FANOTIFY_EVENT_FLAGS) &&
  1609		    (!fid_mode || mark_type == FAN_MARK_MOUNT))
  1610			goto fput_and_out;
  1611	
  1612		/*
  1613		 * FAN_RENAME uses special info type records to report the old and
  1614		 * new parent+name.  Reporting only old and new parent id is less
  1615		 * useful and was not implemented.
  1616		 */
  1617		if (mask & FAN_RENAME && !(fid_mode & FAN_REPORT_NAME))
  1618			goto fput_and_out;
  1619	
  1620		if (flags & FAN_MARK_FLUSH) {
  1621			ret = 0;
  1622			if (mark_type == FAN_MARK_MOUNT)
  1623				fsnotify_clear_vfsmount_marks_by_group(group);
  1624			else if (mark_type == FAN_MARK_FILESYSTEM)
  1625				fsnotify_clear_sb_marks_by_group(group);
  1626			else
  1627				fsnotify_clear_inode_marks_by_group(group);
  1628			goto fput_and_out;
  1629		}
  1630	
  1631		ret = fanotify_find_path(dfd, pathname, &path, flags,
  1632				(mask & ALL_FSNOTIFY_EVENTS), obj_type);
  1633		if (ret)
  1634			goto fput_and_out;
  1635	
  1636		 /* We do not support fid_mode plus remote fsnotify */
> 1637		 ret = -EPERM;
  1638		 if (!fid_mode && mark_type == FAN_MARK_INODE &&
  1639			 path.dentry->d_inode->i_op->fsnotify_update)
  1640				 goto fput_and_out;
  1641	
  1642		if (flags & FAN_MARK_ADD) {
  1643			ret = fanotify_events_supported(&path, mask);
  1644			if (ret)
  1645				goto path_put_and_out;
  1646		}
  1647	
  1648		if (fid_mode) {
  1649			ret = fanotify_test_fsid(path.dentry, &__fsid);
  1650			if (ret)
  1651				goto path_put_and_out;
  1652	
  1653			ret = fanotify_test_fid(path.dentry);
  1654			if (ret)
  1655				goto path_put_and_out;
  1656	
  1657			fsid = &__fsid;
  1658		}
  1659	
  1660		/* inode held in place by reference to path; group by fget on fd */
  1661		if (mark_type == FAN_MARK_INODE)
  1662			inode = path.dentry->d_inode;
  1663		else
  1664			mnt = path.mnt;
  1665	
  1666		/* Mask out FAN_EVENT_ON_CHILD flag for sb/mount/non-dir marks */
> 1667		if (mnt || !S_ISDIR(inode->i_mode)) {
  1668			mask &= ~FAN_EVENT_ON_CHILD;
  1669			umask = FAN_EVENT_ON_CHILD;
  1670			/*
  1671			 * If group needs to report parent fid, register for getting
  1672			 * events with parent/name info for non-directory.
  1673			 */
  1674			if ((fid_mode & FAN_REPORT_DIR_FID) &&
  1675			    (flags & FAN_MARK_ADD) && !ignored)
  1676				mask |= FAN_EVENT_ON_CHILD;
  1677		}
  1678	
  1679		/* create/update an inode mark */
  1680		switch (flags & (FAN_MARK_ADD | FAN_MARK_REMOVE)) {
  1681		case FAN_MARK_ADD:
  1682			if (mark_type == FAN_MARK_MOUNT)
  1683				ret = fanotify_add_vfsmount_mark(group, mnt, mask,
  1684								 flags, fsid);
  1685			else if (mark_type == FAN_MARK_FILESYSTEM)
  1686				ret = fanotify_add_sb_mark(group, mnt->mnt_sb, mask,
  1687							   flags, fsid);
  1688			else {
  1689				ret = fanotify_add_inode_mark(group, inode, mask,
  1690							      flags, fsid);
  1691				/* Only if the object is an inode send a request to FUSE server */
  1692				if (ret == 0){
> 1693					if (inode && inode->i_op->fsnotify_update)
  1694						inode->i_op->fsnotify_update(inode);
  1695				}
  1696			}
  1697			break;
  1698		case FAN_MARK_REMOVE:
  1699			if (mark_type == FAN_MARK_MOUNT)
  1700				ret = fanotify_remove_vfsmount_mark(group, mnt, mask,
  1701								    flags, umask);
  1702			else if (mark_type == FAN_MARK_FILESYSTEM)
  1703				ret = fanotify_remove_sb_mark(group, mnt->mnt_sb, mask,
  1704							      flags, umask);
  1705			else {
  1706				ret = fanotify_remove_inode_mark(group, inode, mask,
  1707								 flags, umask);
  1708				/* Only if the object is an inode send a request to FUSE server */
  1709				if (ret == 0){
  1710					if (inode && inode->i_op->fsnotify_update)
  1711						inode->i_op->fsnotify_update(inode);
  1712				}
  1713			}
  1714			break;
  1715		default:
  1716			ret = -EINVAL;
  1717		}
  1718	
  1719	path_put_and_out:
  1720		path_put(&path);
  1721	fput_and_out:
  1722		fdput(f);
  1723		return ret;
  1724	}
  1725	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
