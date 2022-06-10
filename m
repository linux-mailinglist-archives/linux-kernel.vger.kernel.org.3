Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14E43546F9D
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Jun 2022 00:24:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346952AbiFJWX7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 18:23:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344553AbiFJWX5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 18:23:57 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD1974D255
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 15:23:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654899835; x=1686435835;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=V7t8lSrb0C6xBDOD8a0Eas/m6Qqaza+K5YwoS452IA8=;
  b=iXD4lgb8NTBMZ8hTVAas/TKJEV0BsK6sgAc9dhhO+dDs5QlfGZpfj4En
   vouR/xejBlkWXU4opfRVuXb9jHC/GG1iGHtUs16Q6jEXmoEsoantfWRbh
   e9ag7ELzoKgRoloBf+GXFMZHzNniKejHRc8sxDOc3iTkIcG2oiLYxlmnc
   H8ScgKFqVCSHYDe/3v5OKJkWQgK2hUNdLWspE7PAcDvxFBiaMpNQJgtII
   Ark3Nr55V0FCIY+ESBqxkbweE5PJc0yCuCOM1GRARPA+vxjY3Ue0pDFPo
   q8Wojx9Vbto3+SJSvxSPuMKw8xSvh9i+3ceuZFf/UgVdMpLHrOLa2cuCV
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10374"; a="339516173"
X-IronPort-AV: E=Sophos;i="5.91,291,1647327600"; 
   d="scan'208";a="339516173"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2022 15:23:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,291,1647327600"; 
   d="scan'208";a="586414131"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 10 Jun 2022 15:23:54 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nzn2n-000IJx-Km;
        Fri, 10 Jun 2022 22:23:53 +0000
Date:   Sat, 11 Jun 2022 06:23:41 +0800
From:   kernel test robot <lkp@intel.com>
To:     David Howells <dhowells@redhat.com>
Cc:     kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org
Subject: [ammarfaizi2-block:dhowells/linux-fs/netfs-linked-list 53/57]
 fs/ceph/inode.c:453:33: warning: unused variable 'ctx'
Message-ID: <202206110629.olgNuQ6q-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ammarfaizi2/linux-block dhowells/linux-fs/netfs-linked-list
head:   c19d336b7f0c53bd31e73f6d7d6c1524f0df55b8
commit: 61ba76d79797856f64673f37c08bdfb79df31f21 [53/57] afs: Use the netfs write helpers
config: x86_64-rhel-8.3 (https://download.01.org/0day-ci/archive/20220611/202206110629.olgNuQ6q-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-3) 11.3.0
reproduce (this is a W=1 build):
        # https://github.com/ammarfaizi2/linux-block/commit/61ba76d79797856f64673f37c08bdfb79df31f21
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block dhowells/linux-fs/netfs-linked-list
        git checkout 61ba76d79797856f64673f37c08bdfb79df31f21
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   fs/ceph/inode.c: In function 'ceph_alloc_inode':
>> fs/ceph/inode.c:453:33: warning: unused variable 'ctx' [-Wunused-variable]
     453 |         struct netfs_i_context *ctx;
         |                                 ^~~


vim +/ctx +453 fs/ceph/inode.c

   447	
   448	/*
   449	 * initialize a newly allocated inode.
   450	 */
   451	struct inode *ceph_alloc_inode(struct super_block *sb)
   452	{
 > 453		struct netfs_i_context *ctx;
   454		struct ceph_inode_info *ci;
   455		int i;
   456	
   457		ci = alloc_inode_sb(sb, ceph_inode_cachep, GFP_NOFS);
   458		if (!ci)
   459			return NULL;
   460	
   461		dout("alloc_inode %p\n", &ci->netfs.inode);
   462	
   463		/* Set parameters for the netfs library */
   464		netfs_inode_init(&ci->netfs.inode, &ceph_netfs_ops);
   465		ci->netfs.min_bshift = ilog2(0x10000);
   466		ci->netfs.obj_bshift = ilog2(0x40000);
   467	
   468		spin_lock_init(&ci->i_ceph_lock);
   469	
   470		ci->i_version = 0;
   471		ci->i_inline_version = 0;
   472		ci->i_time_warp_seq = 0;
   473		ci->i_ceph_flags = 0;
   474		atomic64_set(&ci->i_ordered_count, 1);
   475		atomic64_set(&ci->i_release_count, 1);
   476		atomic64_set(&ci->i_complete_seq[0], 0);
   477		atomic64_set(&ci->i_complete_seq[1], 0);
   478		ci->i_symlink = NULL;
   479	
   480		ci->i_max_bytes = 0;
   481		ci->i_max_files = 0;
   482	
   483		memset(&ci->i_dir_layout, 0, sizeof(ci->i_dir_layout));
   484		memset(&ci->i_cached_layout, 0, sizeof(ci->i_cached_layout));
   485		RCU_INIT_POINTER(ci->i_layout.pool_ns, NULL);
   486	
   487		ci->i_fragtree = RB_ROOT;
   488		mutex_init(&ci->i_fragtree_mutex);
   489	
   490		ci->i_xattrs.blob = NULL;
   491		ci->i_xattrs.prealloc_blob = NULL;
   492		ci->i_xattrs.dirty = false;
   493		ci->i_xattrs.index = RB_ROOT;
   494		ci->i_xattrs.count = 0;
   495		ci->i_xattrs.names_size = 0;
   496		ci->i_xattrs.vals_size = 0;
   497		ci->i_xattrs.version = 0;
   498		ci->i_xattrs.index_version = 0;
   499	
   500		ci->i_caps = RB_ROOT;
   501		ci->i_auth_cap = NULL;
   502		ci->i_dirty_caps = 0;
   503		ci->i_flushing_caps = 0;
   504		INIT_LIST_HEAD(&ci->i_dirty_item);
   505		INIT_LIST_HEAD(&ci->i_flushing_item);
   506		ci->i_prealloc_cap_flush = NULL;
   507		INIT_LIST_HEAD(&ci->i_cap_flush_list);
   508		init_waitqueue_head(&ci->i_cap_wq);
   509		ci->i_hold_caps_max = 0;
   510		INIT_LIST_HEAD(&ci->i_cap_delay_list);
   511		INIT_LIST_HEAD(&ci->i_cap_snaps);
   512		ci->i_head_snapc = NULL;
   513		ci->i_snap_caps = 0;
   514	
   515		ci->i_last_rd = ci->i_last_wr = jiffies - 3600 * HZ;
   516		for (i = 0; i < CEPH_FILE_MODE_BITS; i++)
   517			ci->i_nr_by_mode[i] = 0;
   518	
   519		mutex_init(&ci->i_truncate_mutex);
   520		ci->i_truncate_seq = 0;
   521		ci->i_truncate_size = 0;
   522		ci->i_truncate_pending = 0;
   523	
   524		ci->i_max_size = 0;
   525		ci->i_reported_size = 0;
   526		ci->i_wanted_max_size = 0;
   527		ci->i_requested_max_size = 0;
   528	
   529		ci->i_pin_ref = 0;
   530		ci->i_rd_ref = 0;
   531		ci->i_rdcache_ref = 0;
   532		ci->i_wr_ref = 0;
   533		ci->i_wb_ref = 0;
   534		ci->i_fx_ref = 0;
   535		ci->i_wrbuffer_ref = 0;
   536		ci->i_wrbuffer_ref_head = 0;
   537		atomic_set(&ci->i_filelock_ref, 0);
   538		atomic_set(&ci->i_shared_gen, 1);
   539		ci->i_rdcache_gen = 0;
   540		ci->i_rdcache_revoking = 0;
   541	
   542		INIT_LIST_HEAD(&ci->i_unsafe_dirops);
   543		INIT_LIST_HEAD(&ci->i_unsafe_iops);
   544		spin_lock_init(&ci->i_unsafe_lock);
   545	
   546		ci->i_snap_realm = NULL;
   547		INIT_LIST_HEAD(&ci->i_snap_realm_item);
   548		INIT_LIST_HEAD(&ci->i_snap_flush_item);
   549	
   550		INIT_WORK(&ci->i_work, ceph_inode_work);
   551		ci->i_work_mask = 0;
   552		memset(&ci->i_btime, '\0', sizeof(ci->i_btime));
   553		return &ci->netfs.inode;
   554	}
   555	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
