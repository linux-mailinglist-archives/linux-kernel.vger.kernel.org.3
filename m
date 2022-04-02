Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 700BD4EFEE6
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Apr 2022 07:18:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245702AbiDBFUg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Apr 2022 01:20:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353858AbiDBFUa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Apr 2022 01:20:30 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BEA62AE07
        for <linux-kernel@vger.kernel.org>; Fri,  1 Apr 2022 22:18:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648876718; x=1680412718;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=qdBvea340ni/B2V5RQAVdReTxPRWNedDvc0ZrPw39Oc=;
  b=bId9OWSMR++naQ2J+b64HR1Tz81u3E0zvL2XwQxdYB3/s35qKgeaFD8u
   zhjgWnG3Rpb0vDFrARwPBhwiSFt/EznfoTeiLYpKyIvkfQjwrT/he4pE3
   v/CySNdlnl+xKnv3WpQELVFGU25OhVkMg0XcExwcSAAHalhUIsPY/BAjp
   3VdG2q7WUdQa2FKK5QZgk9dHYsCx52vcVhAvMhI67W4oeBAk602cgEcpl
   HDJKY+Ae6AickiqoSgRsTdnWzGY10YPOuZ65/g+GvURSa+Enogb6dna14
   r8p1WTQqZFZaBTlYPjtZprPMoNWzG317eW8cA6K5qeqvbvDUuUrquCD3v
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10304"; a="260265269"
X-IronPort-AV: E=Sophos;i="5.90,229,1643702400"; 
   d="scan'208";a="260265269"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2022 22:18:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,229,1643702400"; 
   d="scan'208";a="523013267"
Received: from lkp-server02.sh.intel.com (HELO 3231c491b0e2) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 01 Apr 2022 22:18:33 -0700
Received: from kbuild by 3231c491b0e2 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1naW9g-0001ki-J8;
        Sat, 02 Apr 2022 05:18:32 +0000
Date:   Sat, 2 Apr 2022 13:18:04 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jeffle Xu <jefflexu@linux.alibaba.com>
Cc:     kbuild-all@lists.01.org, Xiang Gao <xiang@kernel.org>,
        linux-kernel@vger.kernel.org,
        Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [xiang:jeffle/fscache 2/19] fs/cachefiles/namei.c:478:17: error:
 label 'out_unuse' used but not defined
Message-ID: <202204021359.3SIrp1y5-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/xiang/linux.git jeffle/fscache
head:   c536a60b958806d427fb66e3f53a1201826fdcf4
commit: 6e3731398f863eec9b10f9e0cead9f2ec09d8b4d [2/19] cachefiles: notify user daemon with anon_fd when looking up cookie
config: x86_64-randconfig-a011 (https://download.01.org/0day-ci/archive/20220402/202204021359.3SIrp1y5-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.2.0-19) 11.2.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/xiang/linux.git/commit/?id=6e3731398f863eec9b10f9e0cead9f2ec09d8b4d
        git remote add xiang https://git.kernel.org/pub/scm/linux/kernel/git/xiang/linux.git
        git fetch --no-tags xiang jeffle/fscache
        git checkout 6e3731398f863eec9b10f9e0cead9f2ec09d8b4d
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash fs/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   fs/cachefiles/namei.c: In function 'cachefiles_create_tmpfile':
>> fs/cachefiles/namei.c:478:17: error: label 'out_unuse' used but not defined
     478 |                 goto out_unuse;
         |                 ^~~~


vim +/out_unuse +478 fs/cachefiles/namei.c

   434	
   435	/*
   436	 * Create a temporary file and leave it unattached and un-xattr'd until the
   437	 * time comes to discard the object from memory.
   438	 */
   439	struct file *cachefiles_create_tmpfile(struct cachefiles_object *object)
   440	{
   441		struct cachefiles_volume *volume = object->volume;
   442		struct cachefiles_cache *cache = volume->cache;
   443		const struct cred *saved_cred;
   444		struct dentry *fan = volume->fanout[(u8)object->cookie->key_hash];
   445		struct file *file;
   446		struct path path;
   447		uint64_t ni_size;
   448		long ret;
   449	
   450	
   451		cachefiles_begin_secure(cache, &saved_cred);
   452	
   453		path.mnt = cache->mnt;
   454		ret = cachefiles_inject_write_error();
   455		if (ret == 0)
   456			path.dentry = vfs_tmpfile(&init_user_ns, fan, S_IFREG, O_RDWR);
   457		else
   458			path.dentry = ERR_PTR(ret);
   459		if (IS_ERR(path.dentry)) {
   460			trace_cachefiles_vfs_error(object, d_inode(fan), PTR_ERR(path.dentry),
   461						   cachefiles_trace_tmpfile_error);
   462			if (PTR_ERR(path.dentry) == -EIO)
   463				cachefiles_io_error_obj(object, "Failed to create tmpfile");
   464			file = ERR_CAST(path.dentry);
   465			goto out;
   466		}
   467	
   468		trace_cachefiles_tmpfile(object, d_backing_inode(path.dentry));
   469	
   470		if (!cachefiles_mark_inode_in_use(object, path.dentry)) {
   471			file = ERR_PTR(-EBUSY);
   472			goto out_dput;
   473		}
   474	
   475		ret = cachefiles_ondemand_init_object(object);
   476		if (ret < 0) {
   477			file = ERR_PTR(ret);
 > 478			goto out_unuse;
   479		}
   480	
   481		ni_size = object->cookie->object_size;
   482		ni_size = round_up(ni_size, CACHEFILES_DIO_BLOCK_SIZE);
   483	
   484		if (ni_size > 0) {
   485			trace_cachefiles_trunc(object, d_backing_inode(path.dentry), 0, ni_size,
   486					       cachefiles_trunc_expand_tmpfile);
   487			ret = cachefiles_inject_write_error();
   488			if (ret == 0)
   489				ret = vfs_truncate(&path, ni_size);
   490			if (ret < 0) {
   491				trace_cachefiles_vfs_error(
   492					object, d_backing_inode(path.dentry), ret,
   493					cachefiles_trace_trunc_error);
   494				file = ERR_PTR(ret);
   495				goto out_dput;
   496			}
   497		}
   498	
   499		file = open_with_fake_path(&path, O_RDWR | O_LARGEFILE | O_DIRECT,
   500					   d_backing_inode(path.dentry), cache->cache_cred);
   501		if (IS_ERR(file)) {
   502			trace_cachefiles_vfs_error(object, d_backing_inode(path.dentry),
   503						   PTR_ERR(file),
   504						   cachefiles_trace_open_error);
   505			goto out_dput;
   506		}
   507		if (unlikely(!file->f_op->read_iter) ||
   508		    unlikely(!file->f_op->write_iter)) {
   509			fput(file);
   510			pr_notice("Cache does not support read_iter and write_iter\n");
   511			file = ERR_PTR(-EINVAL);
   512		}
   513	
   514	out_dput:
   515		dput(path.dentry);
   516	out:
   517		cachefiles_end_secure(cache, saved_cred);
   518		return file;
   519	}
   520	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
