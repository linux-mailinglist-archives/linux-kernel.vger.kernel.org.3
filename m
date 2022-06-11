Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADCA454717F
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Jun 2022 05:09:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349012AbiFKDJH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 23:09:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349195AbiFKDJD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 23:09:03 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6356646B
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 20:09:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654916942; x=1686452942;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=R9M8qLW2GZ8OavFL9qgrv5U4YwMqdH1bUiTEm6KSo5M=;
  b=c3kk5PEpc1hE55DyPGoQtw00WNwmVDGkXizS6mjTCQY5muEY5Qb2+hzu
   thGUYs002HAqi0ZD5gwKB3qYhSwMFBJgYNX4glbO9lWI6ugOKY/DHat9h
   pBfJlH8njtcU2voUAprlx8XzDboO/Gal9q11UzOkld3LlsXu263gG3CW9
   4uD4IrHvXW3oM9T+Bzj9ryGvxiZ7HsFV8tCpbdlz7I9Z+Zb83ns9Z1EOb
   28hgcd+Zq1M0IZJyVup1PtSg4VsxNQXflnGCYynSg74fzbPA6TtyPksJS
   UoCMA7wIRjMa5xzo1GLXvT9QYvW1slvhk85YoR0cXUBcTT0ArrCL/pBn9
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10374"; a="266577884"
X-IronPort-AV: E=Sophos;i="5.91,292,1647327600"; 
   d="scan'208";a="266577884"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2022 20:09:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,292,1647327600"; 
   d="scan'208";a="638494905"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 10 Jun 2022 20:09:00 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nzrUh-000IUt-PR;
        Sat, 11 Jun 2022 03:08:59 +0000
Date:   Sat, 11 Jun 2022 11:08:19 +0800
From:   kernel test robot <lkp@intel.com>
To:     David Howells <dhowells@redhat.com>
Cc:     kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org
Subject: [ammarfaizi2-block:dhowells/linux-fs/netfs-linked-list 57/57]
 fs/netfs/buffered_write.c:934:2: warning: #warning TRIGGER NEW FLUSH GROUP
 FOR TESTING
Message-ID: <202206111043.15uHwTqk-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ammarfaizi2/linux-block dhowells/linux-fs/netfs-linked-list
head:   c19d336b7f0c53bd31e73f6d7d6c1524f0df55b8
commit: c19d336b7f0c53bd31e73f6d7d6c1524f0df55b8 [57/57] netfs: Add a struct to group modifications together and flushed in order
config: x86_64-randconfig-a011 (https://download.01.org/0day-ci/archive/20220611/202206111043.15uHwTqk-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-3) 11.3.0
reproduce (this is a W=1 build):
        # https://github.com/ammarfaizi2/linux-block/commit/c19d336b7f0c53bd31e73f6d7d6c1524f0df55b8
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block dhowells/linux-fs/netfs-linked-list
        git checkout c19d336b7f0c53bd31e73f6d7d6c1524f0df55b8
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash fs/netfs/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from include/linux/gfp.h:5,
                    from include/linux/xarray.h:15,
                    from include/linux/list_lru.h:14,
                    from include/linux/fs.h:13,
                    from fs/netfs/buffered_write.c:9:
   include/linux/page-flags.h: In function 'PageHead':
   include/linux/page-flags.h:788:27: warning: passing argument 1 of 'dump_page' discards 'const' qualifier from pointer target type [-Wdiscarded-qualifiers]
     788 |         PF_POISONED_CHECK(page);
         |                           ^~~~
   include/linux/mmdebug.h:21:35: note: in definition of macro 'VM_BUG_ON_PAGE'
      21 |                         dump_page(page, "VM_BUG_ON_PAGE(" __stringify(cond)")");\
         |                                   ^~~~
   include/linux/page-flags.h:370:17: note: in expansion of macro 'VM_BUG_ON_PGFLAGS'
     370 |                 VM_BUG_ON_PGFLAGS(PagePoisoned(page), page);            \
         |                 ^~~~~~~~~~~~~~~~~
   include/linux/page-flags.h:788:9: note: in expansion of macro 'PF_POISONED_CHECK'
     788 |         PF_POISONED_CHECK(page);
         |         ^~~~~~~~~~~~~~~~~
   include/linux/mmdebug.h:12:29: note: expected 'struct page *' but argument is of type 'const struct page *'
      12 | void dump_page(struct page *page, const char *reason);
         |                ~~~~~~~~~~~~~^~~~
   fs/netfs/buffered_write.c: In function 'netfs_file_write_iter':
>> fs/netfs/buffered_write.c:934:2: warning: #warning TRIGGER NEW FLUSH GROUP FOR TESTING [-Wcpp]
     934 | #warning TRIGGER NEW FLUSH GROUP FOR TESTING
         |  ^~~~~~~


vim +934 fs/netfs/buffered_write.c

   893	
   894	/**
   895	 * netfs_file_write_iter - write data to a file
   896	 * @iocb:	IO state structure
   897	 * @from:	iov_iter with data to write
   898	 *
   899	 * This is a wrapper around __generic_file_write_iter() to be used by most
   900	 * filesystems. It takes care of syncing the file in case of O_SYNC file and
   901	 * acquires i_mutex as needed.
   902	 * Return:
   903	 * * negative error code if no data has been written at all of
   904	 *   vfs_fsync_range() failed for a synchronous write
   905	 * * number of bytes written, even for truncated writes
   906	 */
   907	ssize_t netfs_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
   908	{
   909		struct file *file = iocb->ki_filp;
   910		struct inode *inode = file->f_mapping->host;
   911		struct netfs_inode *ctx = netfs_inode(inode);
   912		ssize_t ret;
   913	
   914		_enter("%llx,%zx,%llx", iocb->ki_pos, iov_iter_count(from), i_size_read(inode));
   915	
   916		inode_lock(inode);
   917		ret = generic_write_checks(iocb, from);
   918		if (ret <= 0)
   919			goto error_unlock;
   920	
   921		trace_netfs_write_iter(iocb, from);
   922	
   923		/* We can write back this queue in page reclaim */
   924		current->backing_dev_info = inode_to_bdi(inode);
   925		ret = file_remove_privs(file);
   926		if (ret)
   927			goto error;
   928	
   929		ret = file_update_time(file);
   930		if (ret)
   931			goto error;
   932	
   933		{
 > 934	#warning TRIGGER NEW FLUSH GROUP FOR TESTING
   935			static atomic_t jump;
   936			ret = netfs_require_flush_group(inode, (atomic_inc_return(&jump) & 3) == 3);
   937			if (ret < 0)
   938				goto error;
   939		}
   940	
   941		ret = netfs_flush_conflicting_writes(ctx, file, iocb->ki_pos,
   942						     iov_iter_count(from), NULL);
   943		if (ret < 0 && ret != -EAGAIN)
   944			goto error;
   945	
   946		if (iocb->ki_flags & IOCB_DIRECT)
   947			ret = netfs_direct_write_iter(iocb, from);
   948		else
   949			ret = netfs_perform_write(iocb, from);
   950	
   951	error:
   952		inode_unlock(inode);
   953		/* TODO: Wait for DSYNC region here. */
   954		current->backing_dev_info = NULL;
   955		return ret;
   956	error_unlock:
   957		inode_unlock(inode);
   958		return ret;
   959	}
   960	EXPORT_SYMBOL(netfs_file_write_iter);
   961	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
