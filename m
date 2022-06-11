Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A7535473AA
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Jun 2022 12:22:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231171AbiFKKWQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Jun 2022 06:22:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230413AbiFKKWO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jun 2022 06:22:14 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A8E41D9
        for <linux-kernel@vger.kernel.org>; Sat, 11 Jun 2022 03:22:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654942932; x=1686478932;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=gC2juinoSHEY0+8X831/SBR5lbbv9snE6ZelIhvr+uA=;
  b=B2y3MCmtlF0xGgp1nXVvE0T+yeY6XveglSQhRaGB4SRCQq6vBdavYFhD
   XaZLvDU0v893dqeTm3L1uWGKGbo/YfbrVZMxuEkCsUZ98xwU0BQ+/G9kl
   PtW+yzAWBhqUGOwub6c9Qtz/dA+ozpYU19eKx+Xh6nCY+01y7t4VzTuIV
   DAx06LCk4bXJPJMBS+/jft785vIh0znBVmL9HXKAlQCpXIPeJ1mYn7QBZ
   b7MKs2ulVrFHX8Vs436GZXmdyWLyYUbnd8HWSnQdDcYTNPHmK3fsrWKl3
   23cui6HkoJJ/Y+dHoL3ILIbcd6mZ3/b5l2NORD0iUWWOZXk6pjcP52rYU
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10374"; a="257695505"
X-IronPort-AV: E=Sophos;i="5.91,293,1647327600"; 
   d="scan'208";a="257695505"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2022 03:22:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,293,1647327600"; 
   d="scan'208";a="828714157"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 11 Jun 2022 03:22:10 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nzyFu-000InV-3j;
        Sat, 11 Jun 2022 10:22:10 +0000
Date:   Sat, 11 Jun 2022 18:22:05 +0800
From:   kernel test robot <lkp@intel.com>
To:     David Howells <dhowells@redhat.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org
Subject: [ammarfaizi2-block:dhowells/linux-fs/netfs-linked-list 57/57]
 fs/netfs/buffered_write.c:934:2: warning: TRIGGER NEW FLUSH GROUP FOR
 TESTING
Message-ID: <202206111840.22bAafuo-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ammarfaizi2/linux-block dhowells/linux-fs/netfs-linked-list
head:   c19d336b7f0c53bd31e73f6d7d6c1524f0df55b8
commit: c19d336b7f0c53bd31e73f6d7d6c1524f0df55b8 [57/57] netfs: Add a struct to group modifications together and flushed in order
config: arm-randconfig-r034-20220610 (https://download.01.org/0day-ci/archive/20220611/202206111840.22bAafuo-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project ff4abe755279a3a47cc416ef80dbc900d9a98a19)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm cross compiling tool for clang build
        # apt-get install binutils-arm-linux-gnueabi
        # https://github.com/ammarfaizi2/linux-block/commit/c19d336b7f0c53bd31e73f6d7d6c1524f0df55b8
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block dhowells/linux-fs/netfs-linked-list
        git checkout c19d336b7f0c53bd31e73f6d7d6c1524f0df55b8
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash fs/netfs/ lib/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> fs/netfs/buffered_write.c:934:2: warning: TRIGGER NEW FLUSH GROUP FOR TESTING [-W#warnings]
   #warning TRIGGER NEW FLUSH GROUP FOR TESTING
    ^
   fs/netfs/buffered_write.c:22:20: warning: unused function 'netfs_pgoff_before_touch' [-Wunused-function]
   static inline bool netfs_pgoff_before_touch(pgoff_t a, pgoff_t b)
                      ^
   2 warnings generated.


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
