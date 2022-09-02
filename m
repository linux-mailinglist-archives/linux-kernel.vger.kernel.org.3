Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E97885ABADC
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Sep 2022 00:41:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230339AbiIBWlk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 18:41:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229593AbiIBWli (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 18:41:38 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E27FBE3988
        for <linux-kernel@vger.kernel.org>; Fri,  2 Sep 2022 15:41:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662158496; x=1693694496;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=m758XPhbT6i96/wQPC0LJ9DTxfM51/yvBsQc43ztx24=;
  b=JoYPeiZSZeNy8TsxWcqQU07xFA1ifPZ7HL02167SZfi0ybagLDb4jaj3
   7i6aOtbd1XkWb9yrL+C7hsneL0TjcttkUvSsKlsEUHvO+7Wv9iERIsl1c
   PjylKKfv+1fomKrKK4mglItNLRPWouQVOzM9V6TKLtWenjy04SqWD290o
   i0w7oBAQ3ouO3g3dfB+p9+t+NyZe98zxq7UUTsAb9L/lp0utXgXNW/loi
   4uQZuijINwL1KAilvZmCzyDDLk//UuoXKmloU/L4tYGtkxeKMNNVnWbeI
   3lLUHuVo/sejmqhB/Gr2K/8guFvKL/iB1lqAjEPEL40YLXlf6GNKyI3cR
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10458"; a="297393082"
X-IronPort-AV: E=Sophos;i="5.93,285,1654585200"; 
   d="scan'208";a="297393082"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2022 15:41:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,285,1654585200"; 
   d="scan'208";a="590240174"
Received: from lkp-server02.sh.intel.com (HELO 95dfd251caa2) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 02 Sep 2022 15:41:27 -0700
Received: from kbuild by 95dfd251caa2 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oUFLr-0000gf-02;
        Fri, 02 Sep 2022 22:41:27 +0000
Date:   Sat, 3 Sep 2022 06:40:35 +0800
From:   kernel test robot <lkp@intel.com>
To:     Thierry Reding <treding@nvidia.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [thierryreding:for-5.21/work 120/125] fs/lockd/svclock.c:474:34:
 warning: unused variable 'inode'
Message-ID: <202209030659.Z1Ak3sy7-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/thierryreding/linux for-5.21/work
head:   52ddba5b7001206107d4587c706be62369d71240
commit: 80a1856c0cbc57c7ecee8571cd34b76b5542bbd1 [120/125] WIP
config: x86_64-allyesconfig (https://download.01.org/0day-ci/archive/20220903/202209030659.Z1Ak3sy7-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-5) 11.3.0
reproduce (this is a W=1 build):
        # https://github.com/thierryreding/linux/commit/80a1856c0cbc57c7ecee8571cd34b76b5542bbd1
        git remote add thierryreding https://github.com/thierryreding/linux
        git fetch --no-tags thierryreding for-5.21/work
        git checkout 80a1856c0cbc57c7ecee8571cd34b76b5542bbd1
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash fs/lockd/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   fs/lockd/svclock.c: In function 'nlmsvc_lock':
>> fs/lockd/svclock.c:474:34: warning: unused variable 'inode' [-Wunused-variable]
     474 |         struct inode            *inode = nlmsvc_file_inode(file);
         |                                  ^~~~~


vim +/inode +474 fs/lockd/svclock.c

2b36f412ab6f2e Marc Eshel           2006-11-28  463  
^1da177e4c3f41 Linus Torvalds       2005-04-16  464  /*
^1da177e4c3f41 Linus Torvalds       2005-04-16  465   * Attempt to establish a lock, and if it can't be granted, block it
^1da177e4c3f41 Linus Torvalds       2005-04-16  466   * if required.
^1da177e4c3f41 Linus Torvalds       2005-04-16  467   */
52921e02a4f416 Al Viro              2006-10-19  468  __be32
^1da177e4c3f41 Linus Torvalds       2005-04-16  469  nlmsvc_lock(struct svc_rqst *rqstp, struct nlm_file *file,
6cde4de8077349 Jeff Layton          2008-07-15  470  	    struct nlm_host *host, struct nlm_lock *lock, int wait,
b2b5028905226f J. Bruce Fields      2008-02-06  471  	    struct nlm_cookie *cookie, int reclaim)
^1da177e4c3f41 Linus Torvalds       2005-04-16  472  {
40595cdc93edf4 J. Bruce Fields      2021-12-16  473  #if IS_ENABLED(CONFIG_SUNRPC_DEBUG)
b840be2f00c0bc J. Bruce Fields      2021-08-20 @474  	struct inode		*inode = nlmsvc_file_inode(file);
40595cdc93edf4 J. Bruce Fields      2021-12-16  475  #endif
40595cdc93edf4 J. Bruce Fields      2021-12-16  476  	struct nlm_block	*block = NULL;
^1da177e4c3f41 Linus Torvalds       2005-04-16  477  	int			error;
7f024fcd5c97dc J. Bruce Fields      2021-08-23  478  	int			mode;
b840be2f00c0bc J. Bruce Fields      2021-08-20  479  	int			async_block = 0;
52921e02a4f416 Al Viro              2006-10-19  480  	__be32			ret;
^1da177e4c3f41 Linus Torvalds       2005-04-16  481  
^1da177e4c3f41 Linus Torvalds       2005-04-16  482  	dprintk("lockd: nlmsvc_lock(%s/%ld, ty=%d, pi=%d, %Ld-%Ld, bl=%d)\n",
80a1856c0cbc57 Thierry Reding       2022-08-24  483  				nlmsvc_file_inode(file)->i_sb->s_id,
80a1856c0cbc57 Thierry Reding       2022-08-24  484  				nlmsvc_file_inode(file)->i_ino,
^1da177e4c3f41 Linus Torvalds       2005-04-16  485  				lock->fl.fl_type, lock->fl.fl_pid,
^1da177e4c3f41 Linus Torvalds       2005-04-16  486  				(long long)lock->fl.fl_start,
^1da177e4c3f41 Linus Torvalds       2005-04-16  487  				(long long)lock->fl.fl_end,
^1da177e4c3f41 Linus Torvalds       2005-04-16  488  				wait);
^1da177e4c3f41 Linus Torvalds       2005-04-16  489  
40595cdc93edf4 J. Bruce Fields      2021-12-16  490  	if (nlmsvc_file_file(file)->f_op->lock) {
b840be2f00c0bc J. Bruce Fields      2021-08-20  491  		async_block = wait;
b840be2f00c0bc J. Bruce Fields      2021-08-20  492  		wait = 0;
b840be2f00c0bc J. Bruce Fields      2021-08-20  493  	}
b840be2f00c0bc J. Bruce Fields      2021-08-20  494  
^1da177e4c3f41 Linus Torvalds       2005-04-16  495  	/* Lock file against concurrent access */
89e63ef609fb00 Neil Brown           2006-10-04  496  	mutex_lock(&file->f_mutex);
f812048020282f Marc Eshel           2006-12-05  497  	/* Get existing block (in case client is busy-waiting)
f812048020282f Marc Eshel           2006-12-05  498  	 * or create new block
f812048020282f Marc Eshel           2006-12-05  499  	 */
d9f6eb75d49007 Trond Myklebust      2006-03-20  500  	block = nlmsvc_lookup_block(file, lock);
09c7938c5640a6 Trond Myklebust      2006-03-20  501  	if (block == NULL) {
560de0e65904db J. Bruce Fields      2008-07-15  502  		block = nlmsvc_create_block(rqstp, host, file, lock, cookie);
f812048020282f Marc Eshel           2006-12-05  503  		ret = nlm_lck_denied_nolocks;
f812048020282f Marc Eshel           2006-12-05  504  		if (block == NULL)
f812048020282f Marc Eshel           2006-12-05  505  			goto out;
92737230dd3f14 Trond Myklebust      2006-03-20  506  		lock = &block->b_call->a_args.lock;
f812048020282f Marc Eshel           2006-12-05  507  	} else
f812048020282f Marc Eshel           2006-12-05  508  		lock->fl.fl_flags &= ~FL_SLEEP;
^1da177e4c3f41 Linus Torvalds       2005-04-16  509  
1a8322b2b02071 Marc Eshel           2006-11-28  510  	if (block->b_flags & B_QUEUED) {
1a8322b2b02071 Marc Eshel           2006-11-28  511  		dprintk("lockd: nlmsvc_lock deferred block %p flags %d\n",
1a8322b2b02071 Marc Eshel           2006-11-28  512  							block, block->b_flags);
1a8322b2b02071 Marc Eshel           2006-11-28  513  		if (block->b_granted) {
1a8322b2b02071 Marc Eshel           2006-11-28  514  			nlmsvc_unlink_block(block);
1a8322b2b02071 Marc Eshel           2006-11-28  515  			ret = nlm_granted;
1a8322b2b02071 Marc Eshel           2006-11-28  516  			goto out;
1a8322b2b02071 Marc Eshel           2006-11-28  517  		}
1a8322b2b02071 Marc Eshel           2006-11-28  518  		if (block->b_flags & B_TIMED_OUT) {
1a8322b2b02071 Marc Eshel           2006-11-28  519  			nlmsvc_unlink_block(block);
1a8322b2b02071 Marc Eshel           2006-11-28  520  			ret = nlm_lck_denied;
1a8322b2b02071 Marc Eshel           2006-11-28  521  			goto out;
1a8322b2b02071 Marc Eshel           2006-11-28  522  		}
1a8322b2b02071 Marc Eshel           2006-11-28  523  		ret = nlm_drop_reply;
1a8322b2b02071 Marc Eshel           2006-11-28  524  		goto out;
1a8322b2b02071 Marc Eshel           2006-11-28  525  	}
^1da177e4c3f41 Linus Torvalds       2005-04-16  526  
5ccb0066f2d561 Stanislav Kinsbursky 2012-07-25  527  	if (locks_in_grace(SVC_NET(rqstp)) && !reclaim) {
b2b5028905226f J. Bruce Fields      2008-02-06  528  		ret = nlm_lck_denied_grace_period;
b2b5028905226f J. Bruce Fields      2008-02-06  529  		goto out;
b2b5028905226f J. Bruce Fields      2008-02-06  530  	}
5ccb0066f2d561 Stanislav Kinsbursky 2012-07-25  531  	if (reclaim && !locks_in_grace(SVC_NET(rqstp))) {
d22b1cff099737 J. Bruce Fields      2008-02-06  532  		ret = nlm_lck_denied_grace_period;
d22b1cff099737 J. Bruce Fields      2008-02-06  533  		goto out;
d22b1cff099737 J. Bruce Fields      2008-02-06  534  	}
b2b5028905226f J. Bruce Fields      2008-02-06  535  
1a8322b2b02071 Marc Eshel           2006-11-28  536  	if (!wait)
1a8322b2b02071 Marc Eshel           2006-11-28  537  		lock->fl.fl_flags &= ~FL_SLEEP;
7f024fcd5c97dc J. Bruce Fields      2021-08-23  538  	mode = lock_to_openmode(&lock->fl);
7f024fcd5c97dc J. Bruce Fields      2021-08-23  539  	error = vfs_lock_file(file->f_file[mode], F_SETLK, &lock->fl, NULL);
1a8322b2b02071 Marc Eshel           2006-11-28  540  	lock->fl.fl_flags &= ~FL_SLEEP;
a85f193e2fb7d5 Andy Adamson         2006-03-20  541  
1a8322b2b02071 Marc Eshel           2006-11-28  542  	dprintk("lockd: vfs_lock_file returned %d\n", error);
09c7938c5640a6 Trond Myklebust      2006-03-20  543  	switch (error) {
^1da177e4c3f41 Linus Torvalds       2005-04-16  544  		case 0:
15dadef9460ad8 Andy Adamson         2006-03-20  545  			ret = nlm_granted;
15dadef9460ad8 Andy Adamson         2006-03-20  546  			goto out;
09c7938c5640a6 Trond Myklebust      2006-03-20  547  		case -EAGAIN:
e33d1ea60c3a17 Miklos Szeredi       2009-02-09  548  			/*
e33d1ea60c3a17 Miklos Szeredi       2009-02-09  549  			 * If this is a blocking request for an
e33d1ea60c3a17 Miklos Szeredi       2009-02-09  550  			 * already pending lock request then we need
e33d1ea60c3a17 Miklos Szeredi       2009-02-09  551  			 * to put it back on lockd's block list
e33d1ea60c3a17 Miklos Szeredi       2009-02-09  552  			 */
e33d1ea60c3a17 Miklos Szeredi       2009-02-09  553  			if (wait)
9d9b87c1218be7 J. Bruce Fields      2009-02-04  554  				break;
b840be2f00c0bc J. Bruce Fields      2021-08-20  555  			ret = async_block ? nlm_lck_blocked : nlm_lck_denied;
e33d1ea60c3a17 Miklos Szeredi       2009-02-09  556  			goto out;
bde74e4bc64415 Miklos Szeredi       2008-07-25  557  		case FILE_LOCK_DEFERRED:
1a8322b2b02071 Marc Eshel           2006-11-28  558  			if (wait)
1a8322b2b02071 Marc Eshel           2006-11-28  559  				break;
1a8322b2b02071 Marc Eshel           2006-11-28  560  			/* Filesystem lock operation is in progress
1a8322b2b02071 Marc Eshel           2006-11-28  561  			   Add it to the queue waiting for callback */
1a8322b2b02071 Marc Eshel           2006-11-28  562  			ret = nlmsvc_defer_lock_rqst(rqstp, block);
1a8322b2b02071 Marc Eshel           2006-11-28  563  			goto out;
09c7938c5640a6 Trond Myklebust      2006-03-20  564  		case -EDEADLK:
15dadef9460ad8 Andy Adamson         2006-03-20  565  			ret = nlm_deadlock;
15dadef9460ad8 Andy Adamson         2006-03-20  566  			goto out;
^1da177e4c3f41 Linus Torvalds       2005-04-16  567  		default:			/* includes ENOLCK */
15dadef9460ad8 Andy Adamson         2006-03-20  568  			ret = nlm_lck_denied_nolocks;
15dadef9460ad8 Andy Adamson         2006-03-20  569  			goto out;
^1da177e4c3f41 Linus Torvalds       2005-04-16  570  	}
^1da177e4c3f41 Linus Torvalds       2005-04-16  571  
09c7938c5640a6 Trond Myklebust      2006-03-20  572  	ret = nlm_lck_blocked;
^1da177e4c3f41 Linus Torvalds       2005-04-16  573  
^1da177e4c3f41 Linus Torvalds       2005-04-16  574  	/* Append to list of blocked */
f812048020282f Marc Eshel           2006-12-05  575  	nlmsvc_insert_block(block, NLM_NEVER);
15dadef9460ad8 Andy Adamson         2006-03-20  576  out:
89e63ef609fb00 Neil Brown           2006-10-04  577  	mutex_unlock(&file->f_mutex);
6849c0cab69f5d Trond Myklebust      2006-03-20  578  	nlmsvc_release_block(block);
15dadef9460ad8 Andy Adamson         2006-03-20  579  	dprintk("lockd: nlmsvc_lock returned %u\n", ret);
15dadef9460ad8 Andy Adamson         2006-03-20  580  	return ret;
^1da177e4c3f41 Linus Torvalds       2005-04-16  581  }
^1da177e4c3f41 Linus Torvalds       2005-04-16  582  

:::::: The code at line 474 was first introduced by commit
:::::: b840be2f00c0bc00d993f8f76e251052b83e4382 lockd: don't attempt blocking locks on nfs reexports

:::::: TO: J. Bruce Fields <bfields@redhat.com>
:::::: CC: Chuck Lever <chuck.lever@oracle.com>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
