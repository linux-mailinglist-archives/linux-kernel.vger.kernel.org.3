Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDA4B563BC6
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 23:31:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231163AbiGAVbO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 17:31:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbiGAVbI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 17:31:08 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9646E4F666
        for <linux-kernel@vger.kernel.org>; Fri,  1 Jul 2022 14:31:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656711067; x=1688247067;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=mxcbylT/27Ga36BZnx+qmT5tteE4Nxe8NzKQzxgXfKM=;
  b=kh50QBkx+oPmdBYquUElWlohgotx8zzI0v89ACvsDLLUrBa/X+yZLfxR
   5x7Lz7obDQLYrSUhvclK1f1yLe/x+M7baMilpnyOJ/kvnUj0GkuDJUoJ4
   dpWz5Fm376cejtPnFiqyw340wf1fUbxGDDbDSQR+VVlt1Egf2Hx28pJB3
   0/8JKl8MbDgfwDGgcuhXQoPG00hwKvjJz4mUlSQIWQlv/+SF7C3dpj/BM
   GoOI4I2WHUHDmbrn5o6+7bvD+7sXJfsYEL/inV132iF5jTUZWdkA2tq47
   m1l2R4AwC7xA+Vwo066f0LDUcPRW3YB3Zl2OXKGH2entUP2oIal2B4Mf1
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10395"; a="369068647"
X-IronPort-AV: E=Sophos;i="5.92,238,1650956400"; 
   d="scan'208";a="369068647"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2022 14:31:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,238,1650956400"; 
   d="scan'208";a="541871203"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 01 Jul 2022 14:31:05 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o7OED-000ENA-02;
        Fri, 01 Jul 2022 21:31:05 +0000
Date:   Sat, 2 Jul 2022 05:30:20 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org, David Howells <dhowells@redhat.com>
Subject: [ammarfaizi2-block:dhowells/linux-fs/netfs-linked-list 59/61]
 fs/netfs/buffered_write.c:815:9: warning: no previous prototype for
 'netfs_file_write_iter_locked'
Message-ID: <202207020503.motNWt1A-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ammarfaizi2/linux-block dhowells/linux-fs/netfs-linked-list
head:   ce4670495468b797b0c5927fcb661bc0da48b9ab
commit: e237ecdc44f74b59d00230cc4e6e8067a4bed176 [59/61] netfs: add new buffered/direct exclusive locking scheme
config: i386-defconfig (https://download.01.org/0day-ci/archive/20220702/202207020503.motNWt1A-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-3) 11.3.0
reproduce (this is a W=1 build):
        # https://github.com/ammarfaizi2/linux-block/commit/e237ecdc44f74b59d00230cc4e6e8067a4bed176
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block dhowells/linux-fs/netfs-linked-list
        git checkout e237ecdc44f74b59d00230cc4e6e8067a4bed176
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash fs/netfs/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> fs/netfs/buffered_write.c:815:9: warning: no previous prototype for 'netfs_file_write_iter_locked' [-Wmissing-prototypes]
     815 | ssize_t netfs_file_write_iter_locked(struct kiocb *iocb, struct iov_iter *from)
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~


vim +/netfs_file_write_iter_locked +815 fs/netfs/buffered_write.c

   801	
   802	/**
   803	 * netfs_file_write_iter_locked - write data to a file
   804	 * @iocb:	IO state structure
   805	 * @from:	iov_iter with data to write
   806	 *
   807	 * This is a wrapper around __generic_file_write_iter() to be used by most
   808	 * filesystems that want to deal with the locking themselves. It takes care
   809	 * of syncing the file in case of O_SYNC.
   810	 * Return:
   811	 * * negative error code if no data has been written at all of
   812	 *   vfs_fsync_range() failed for a synchronous write
   813	 * * number of bytes written, even for truncated writes
   814	 */
 > 815	ssize_t netfs_file_write_iter_locked(struct kiocb *iocb, struct iov_iter *from)
   816	{
   817		struct file *file = iocb->ki_filp;
   818		struct inode *inode = file->f_mapping->host;
   819		struct netfs_inode *ctx = netfs_inode(inode);
   820		ssize_t ret;
   821	
   822		_enter("%llx,%zx,%llx", iocb->ki_pos, iov_iter_count(from), i_size_read(inode));
   823	
   824		ret = generic_write_checks(iocb, from);
   825		if (ret <= 0)
   826			return ret;
   827	
   828		trace_netfs_write_iter(iocb, from);
   829	
   830		/* We can write back this queue in page reclaim */
   831		current->backing_dev_info = inode_to_bdi(inode);
   832		ret = file_remove_privs(file);
   833		if (ret)
   834			goto error;
   835	
   836		ret = file_update_time(file);
   837		if (ret)
   838			goto error;
   839	
   840		ret = netfs_flush_conflicting_writes(ctx, file, iocb->ki_pos,
   841						     iov_iter_count(from), NULL);
   842		if (ret < 0 && ret != -EAGAIN)
   843			goto error;
   844	
   845		if (iocb->ki_flags & IOCB_DIRECT)
   846			ret = netfs_direct_write_iter(iocb, from);
   847		else
   848			ret = netfs_perform_write(iocb, from);
   849	
   850	error:
   851		/* TODO: Wait for DSYNC region here. */
   852		current->backing_dev_info = NULL;
   853		return ret;
   854	}
   855	EXPORT_SYMBOL(netfs_file_write_iter_locked);
   856	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
