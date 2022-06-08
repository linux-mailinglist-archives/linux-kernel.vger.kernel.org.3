Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3D49543FC8
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 01:14:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231243AbiFHXOa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 19:14:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230228AbiFHXO0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 19:14:26 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA01B2F393
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 16:14:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654730064; x=1686266064;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=WqjKbEmRoF/PMPqDCF4g6LhNE1X61z/laXlRPGM8XWs=;
  b=DAfVnIclTpPj2l98ey7yb4igtulyEmHFxrT0ieEMlUqBLBFgdBfFJGZc
   ePUdemlDvnF/4a5/GTpn9HbpRTkk3PYAPBTV/Bu7i+AwvlUQMNAsKNBiF
   9FcxjrS2jb38p5EknC9Tvf6i8ytdj+4sIGRrj+uVgVvdQo7GAdCjsaRmE
   4OazE1NW3rZREwYtyrv38yrZBtu/c+YNuqqlLyC+XiXFdLXTwPRb7kBJe
   VmV8nuIQUfOTQnq1R8vobCB4WTPBirVGkUcNTXMhYKP0ooUYlCTZKXiuT
   hGHygJI3HDhXIVmRwVqXOHjIj18XtPWGaSIZxv0Wo++lAHpzYGZTmSeNC
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10372"; a="277903308"
X-IronPort-AV: E=Sophos;i="5.91,287,1647327600"; 
   d="scan'208";a="277903308"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2022 16:14:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,287,1647327600"; 
   d="scan'208";a="683620700"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 08 Jun 2022 16:14:07 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nz4sI-000FDl-Cg;
        Wed, 08 Jun 2022 23:14:06 +0000
Date:   Thu, 9 Jun 2022 07:13:39 +0800
From:   kernel test robot <lkp@intel.com>
To:     Enzo Matsumiya <ematsumiya@suse.de>
Cc:     kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org, Sasha Levin <sashal@kernel.org>,
        "Paulo Alcantara (SUSE)" <pc@cjr.nz>,
        Steve French <stfrench@microsoft.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [ammarfaizi2-block:stable/linux-stable-rc/queue/5.18 29/879]
 fs/cifs/connect.c:3435:14: warning: unused variable 'nodfs'
Message-ID: <202206090711.ZJTiUk4L-lkp@intel.com>
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

tree:   https://github.com/ammarfaizi2/linux-block stable/linux-stable-rc/queue/5.18
head:   7383156f95c8c7f7bda72abd7fa4d1bc06e2a8cf
commit: 98dd3927170845f16f5120686a0b5c5f181a3b87 [29/879] cifs: don't call cifs_dfs_query_info_nonascii_quirk() if nodfs was set
config: i386-randconfig-a001 (https://download.01.org/0day-ci/archive/20220609/202206090711.ZJTiUk4L-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-3) 11.3.0
reproduce (this is a W=1 build):
        # https://github.com/ammarfaizi2/linux-block/commit/98dd3927170845f16f5120686a0b5c5f181a3b87
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block stable/linux-stable-rc/queue/5.18
        git checkout 98dd3927170845f16f5120686a0b5c5f181a3b87
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash fs/cifs/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   fs/cifs/connect.c: In function 'is_path_remote':
>> fs/cifs/connect.c:3435:14: warning: unused variable 'nodfs' [-Wunused-variable]
    3435 |         bool nodfs = cifs_sb->mnt_cifs_flags & CIFS_MOUNT_NO_DFS;
         |              ^~~~~


vim +/nodfs +3435 fs/cifs/connect.c

  3421	
  3422	/*
  3423	 * Check if path is remote (e.g. a DFS share). Return -EREMOTE if it is,
  3424	 * otherwise 0.
  3425	 */
  3426	static int is_path_remote(struct mount_ctx *mnt_ctx)
  3427	{
  3428		int rc;
  3429		struct cifs_sb_info *cifs_sb = mnt_ctx->cifs_sb;
  3430		struct TCP_Server_Info *server = mnt_ctx->server;
  3431		unsigned int xid = mnt_ctx->xid;
  3432		struct cifs_tcon *tcon = mnt_ctx->tcon;
  3433		struct smb3_fs_context *ctx = mnt_ctx->fs_ctx;
  3434		char *full_path;
> 3435		bool nodfs = cifs_sb->mnt_cifs_flags & CIFS_MOUNT_NO_DFS;
  3436	
  3437		if (!server->ops->is_path_accessible)
  3438			return -EOPNOTSUPP;
  3439	
  3440		/*
  3441		 * cifs_build_path_to_root works only when we have a valid tcon
  3442		 */
  3443		full_path = cifs_build_path_to_root(ctx, cifs_sb, tcon,
  3444						    tcon->Flags & SMB_SHARE_IS_IN_DFS);
  3445		if (full_path == NULL)
  3446			return -ENOMEM;
  3447	
  3448		cifs_dbg(FYI, "%s: full_path: %s\n", __func__, full_path);
  3449	
  3450		rc = server->ops->is_path_accessible(xid, tcon, cifs_sb,
  3451						     full_path);
  3452	#ifdef CONFIG_CIFS_DFS_UPCALL
  3453		if (nodfs) {
  3454			if (rc == -EREMOTE)
  3455				rc = -EOPNOTSUPP;
  3456			goto out;
  3457		}
  3458	
  3459		/* path *might* exist with non-ASCII characters in DFS root
  3460		 * try again with full path (only if nodfs is not set) */
  3461		if (rc == -ENOENT && is_tcon_dfs(tcon))
  3462			rc = cifs_dfs_query_info_nonascii_quirk(xid, tcon, cifs_sb,
  3463								full_path);
  3464	#endif
  3465		if (rc != 0 && rc != -EREMOTE)
  3466			goto out;
  3467	
  3468		if (rc != -EREMOTE) {
  3469			rc = cifs_are_all_path_components_accessible(server, xid, tcon,
  3470				cifs_sb, full_path, tcon->Flags & SMB_SHARE_IS_IN_DFS);
  3471			if (rc != 0) {
  3472				cifs_server_dbg(VFS, "cannot query dirs between root and final path, enabling CIFS_MOUNT_USE_PREFIX_PATH\n");
  3473				cifs_sb->mnt_cifs_flags |= CIFS_MOUNT_USE_PREFIX_PATH;
  3474				rc = 0;
  3475			}
  3476		}
  3477	
  3478	out:
  3479		kfree(full_path);
  3480		return rc;
  3481	}
  3482	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
