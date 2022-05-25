Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 156CF53418D
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 18:32:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245469AbiEYQcH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 12:32:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242219AbiEYQcE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 12:32:04 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F2D44ECD3;
        Wed, 25 May 2022 09:32:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653496323; x=1685032323;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=dP4IHy/R3fOL3p1GqQYg4uQt9SXLTkI03WsLyvMU4lo=;
  b=Pysnr2QSPIWYy/X0nk8T1pKMOvDuJ18tv2pfplGrxKbbhqF3meAjwLQ+
   0UdaE01qhDHqN3BGdK9/lY0wdEc72AV1+G+0A/QRXAWgg9awzEX9ZXW4t
   VwVVRcIN3wFHQ86fbnCjLgVay+KWI7MB84bFEJ91vVFvd2c1jxuPoqc6U
   TGQ/y0xEDDYodedx6Z6tofz2/T9MDl4VLd1qagf/QyGHI1EzASU481C+J
   NxbwJv/KOEFMxghao9dY5VDNX0kVGjubLd11XGAs3kvXAbcdtE+SGGzPM
   n3C4FP5rnrFUBFiWXwm6OqmFBLkbuQjuC251Eq+IAQiNrrMEEiP6iOVfh
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10358"; a="272678160"
X-IronPort-AV: E=Sophos;i="5.91,250,1647327600"; 
   d="scan'208";a="272678160"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 May 2022 09:32:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,250,1647327600"; 
   d="scan'208";a="559757373"
Received: from lkp-server01.sh.intel.com (HELO db63a1be7222) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 25 May 2022 09:32:01 -0700
Received: from kbuild by db63a1be7222 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nttvU-00038H-9s;
        Wed, 25 May 2022 16:32:00 +0000
Date:   Thu, 26 May 2022 00:31:02 +0800
From:   kernel test robot <lkp@intel.com>
To:     Filipe Manana <fdmanana@suse.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        David Sterba <dsterba@suse.com>, linux-doc@vger.kernel.org
Subject: fs/btrfs/tree-log.c:6792: warning: This comment starts with '/**',
 but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
Message-ID: <202205260024.TLEp6Pj2-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   fdaf9a5840acaab18694a19e0eb0aa51162eeeed
commit: d5f5bd546552a94eefd68c42f40f778c40a89d2c btrfs: pass the dentry to btrfs_log_new_name() instead of the inode
date:   2 months ago
config: x86_64-randconfig-a011 (https://download.01.org/0day-ci/archive/20220526/202205260024.TLEp6Pj2-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-1) 11.3.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=d5f5bd546552a94eefd68c42f40f778c40a89d2c
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout d5f5bd546552a94eefd68c42f40f778c40a89d2c
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> fs/btrfs/tree-log.c:6792: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
    * Update the log after adding a new name for an inode.


vim +6792 fs/btrfs/tree-log.c

  6790	
  6791	/**
> 6792	 * Update the log after adding a new name for an inode.
  6793	 *
  6794	 * @trans:              Transaction handle.
  6795	 * @old_dentry:         The dentry associated with the old name and the old
  6796	 *                      parent directory.
  6797	 * @old_dir:            The inode of the previous parent directory for the case
  6798	 *                      of a rename. For a link operation, it must be NULL.
  6799	 * @parent:             The dentry associated with the directory under which the
  6800	 *                      new name is located.
  6801	 *
  6802	 * Call this after adding a new name for an inode, as a result of a link or
  6803	 * rename operation, and it will properly update the log to reflect the new name.
  6804	 */
  6805	void btrfs_log_new_name(struct btrfs_trans_handle *trans,
  6806				struct dentry *old_dentry, struct btrfs_inode *old_dir,
  6807				struct dentry *parent)
  6808	{
  6809		struct btrfs_inode *inode = BTRFS_I(d_inode(old_dentry));
  6810		struct btrfs_log_ctx ctx;
  6811	
  6812		/*
  6813		 * this will force the logging code to walk the dentry chain
  6814		 * up for the file
  6815		 */
  6816		if (!S_ISDIR(inode->vfs_inode.i_mode))
  6817			inode->last_unlink_trans = trans->transid;
  6818	
  6819		/*
  6820		 * if this inode hasn't been logged and directory we're renaming it
  6821		 * from hasn't been logged, we don't need to log it
  6822		 */
  6823		if (!inode_logged(trans, inode) &&
  6824		    (!old_dir || !inode_logged(trans, old_dir)))
  6825			return;
  6826	
  6827		/*
  6828		 * If we are doing a rename (old_dir is not NULL) from a directory that
  6829		 * was previously logged, make sure the next log attempt on the directory
  6830		 * is not skipped and logs the inode again. This is because the log may
  6831		 * not currently be authoritative for a range including the old
  6832		 * BTRFS_DIR_INDEX_KEY key, so we want to make sure after a log replay we
  6833		 * do not end up with both the new and old dentries around (in case the
  6834		 * inode is a directory we would have a directory with two hard links and
  6835		 * 2 inode references for different parents). The next log attempt of
  6836		 * old_dir will happen at btrfs_log_all_parents(), called through
  6837		 * btrfs_log_inode_parent() below, because we have previously set
  6838		 * inode->last_unlink_trans to the current transaction ID, either here or
  6839		 * at btrfs_record_unlink_dir() in case the inode is a directory.
  6840		 */
  6841		if (old_dir)
  6842			old_dir->logged_trans = 0;
  6843	
  6844		btrfs_init_log_ctx(&ctx, &inode->vfs_inode);
  6845		ctx.logging_new_name = true;
  6846		/*
  6847		 * We don't care about the return value. If we fail to log the new name
  6848		 * then we know the next attempt to sync the log will fallback to a full
  6849		 * transaction commit (due to a call to btrfs_set_log_full_commit()), so
  6850		 * we don't need to worry about getting a log committed that has an
  6851		 * inconsistent state after a rename operation.
  6852		 */
  6853		btrfs_log_inode_parent(trans, inode, parent, LOG_INODE_EXISTS, &ctx);
  6854	}
  6855	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
