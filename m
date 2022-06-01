Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94DC1539DFE
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 09:18:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344639AbiFAHSA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 03:18:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343803AbiFAHRy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 03:17:54 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBDFA22BEA
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jun 2022 00:17:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654067871; x=1685603871;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=hNzVhC2BQ7v7qd4GJVYOzEzYCDinZY6da33WxAy5gMo=;
  b=dJmCdOvkWzZ7fgGrxue8ary5Gwa/BJY7SyIdG14/qfQsJqKY/52eWTgB
   W0bcggEEMTTPKKUQbwNbv2VXG/+UkYYLWfIPgEwkqFCZXZumXLi9WN3yz
   PyZRFc5hss8t8yOx2iVaK/mDhOi2DFpla3ghaw8SvfCjU3K4gmbiBuKKH
   IBtd/V7Hc1Ad5tmNfowXD5kAX6//h4qeZVoVgsPtEDGa1iJ1sRQmAtDjj
   9FLI0yLBS1BtxHdJNl40c5DO2qlYf73M/eHGPbFMmkDaAKpVOOAHgi/B0
   R/IdnKJ8nG3rS3RipL7kbe7CliIalhR4oUAArQo7rG3QsKj4F1b9KIJJ2
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10364"; a="274302049"
X-IronPort-AV: E=Sophos;i="5.91,266,1647327600"; 
   d="scan'208";a="274302049"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2022 00:17:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,266,1647327600"; 
   d="scan'208";a="755716160"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 01 Jun 2022 00:17:49 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nwIc1-0003gA-0J;
        Wed, 01 Jun 2022 07:17:49 +0000
Date:   Wed, 1 Jun 2022 15:17:10 +0800
From:   kernel test robot <lkp@intel.com>
To:     David Howells <dhowells@redhat.com>
Cc:     kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org
Subject: [ammarfaizi2-block:dhowells/linux-fs/cifs-netfs 34/41]
 fs/cifs/smb2ops.c:3965:34: sparse: sparse: incorrect type in argument 2
 (different base types)
Message-ID: <202206011525.hK4OI0FN-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ammarfaizi2/linux-block dhowells/linux-fs/cifs-netfs
head:   1fc71b6b30f6d2a981c163b77c9aee0aecaecb29
commit: 4c67a0e88c041546f0a045d5034e045e0c404918 [34/41] cifs: Share server EOF pos with netfslib
config: i386-randconfig-s002 (https://download.01.org/0day-ci/archive/20220601/202206011525.hK4OI0FN-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-1) 11.3.0
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.4-14-g5a0004b5-dirty
        # https://github.com/ammarfaizi2/linux-block/commit/4c67a0e88c041546f0a045d5034e045e0c404918
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block dhowells/linux-fs/cifs-netfs
        git checkout 4c67a0e88c041546f0a045d5034e045e0c404918
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=i386 SHELL=/bin/bash fs/cifs/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
>> fs/cifs/smb2ops.c:3965:34: sparse: sparse: incorrect type in argument 2 (different base types) @@     expected long long [usertype] new_i_size @@     got restricted __le64 [addressable] [assigned] [usertype] eof @@
   fs/cifs/smb2ops.c:3965:34: sparse:     expected long long [usertype] new_i_size
   fs/cifs/smb2ops.c:3965:34: sparse:     got restricted __le64 [addressable] [assigned] [usertype] eof
>> fs/cifs/smb2ops.c:3966:33: sparse: sparse: incorrect type in argument 2 (different base types) @@     expected long long [usertype] newsize @@     got restricted __le64 [addressable] [assigned] [usertype] eof @@
   fs/cifs/smb2ops.c:3966:33: sparse:     expected long long [usertype] newsize
   fs/cifs/smb2ops.c:3966:33: sparse:     got restricted __le64 [addressable] [assigned] [usertype] eof
>> fs/cifs/smb2ops.c:3967:57: sparse: sparse: incorrect type in argument 2 (different base types) @@     expected long long [usertype] new_size @@     got restricted __le64 [addressable] [assigned] [usertype] eof @@
   fs/cifs/smb2ops.c:3967:57: sparse:     expected long long [usertype] new_size
   fs/cifs/smb2ops.c:3967:57: sparse:     got restricted __le64 [addressable] [assigned] [usertype] eof
   fs/cifs/smb2ops.c:4752:39: sparse: sparse: incompatible types in comparison expression (different type sizes):
   fs/cifs/smb2ops.c:4752:39: sparse:    unsigned int *
   fs/cifs/smb2ops.c:4752:39: sparse:    unsigned long *

vim +3965 fs/cifs/smb2ops.c

  3932	
  3933	static long smb3_collapse_range(struct file *file, struct cifs_tcon *tcon,
  3934				    loff_t off, loff_t len)
  3935	{
  3936		int rc;
  3937		unsigned int xid;
  3938		struct inode *inode;
  3939		struct cifsFileInfo *cfile = file->private_data;
  3940		__le64 eof;
  3941	
  3942		xid = get_xid();
  3943	
  3944		inode = d_inode(cfile->dentry);
  3945	
  3946		if (off >= i_size_read(inode) ||
  3947		    off + len >= i_size_read(inode)) {
  3948			rc = -EINVAL;
  3949			goto out;
  3950		}
  3951	
  3952		rc = smb2_copychunk_range(xid, cfile, cfile, off + len,
  3953					  i_size_read(inode) - off - len, off);
  3954		if (rc < 0)
  3955			goto out;
  3956	
  3957		eof = cpu_to_le64(i_size_read(inode) - len);
  3958		rc = SMB2_set_eof(xid, tcon, cfile->fid.persistent_fid,
  3959				  cfile->fid.volatile_fid, cfile->pid, &eof);
  3960		if (rc < 0)
  3961			goto out;
  3962	
  3963		rc = 0;
  3964	
> 3965		netfs_resize_file(inode, eof);
> 3966		truncate_setsize(inode, eof);
> 3967		fscache_resize_cookie(cifs_inode_cookie(inode), eof);
  3968	 out:
  3969		free_xid(xid);
  3970		return rc;
  3971	}
  3972	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
