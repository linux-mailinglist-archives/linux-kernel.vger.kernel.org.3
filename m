Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31E005154DF
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 21:52:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380414AbiD2Tzo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 15:55:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239376AbiD2Tzl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 15:55:41 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC07A28E2C
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 12:52:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651261942; x=1682797942;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=GARhOmNBd1ME0CHLOJNqer0adibXv0bWTEQcGPSkh6s=;
  b=QnV1iObSw5fuDPJZqFbbH7AljkXvfHWQ/l0Fm1splVuzEpQoMdzatMyT
   aMF0UAgCviX8YZwrZzMKUjrSUr9Z3Bz+ie73knpS8IXp8Zl+IqUYBhYGM
   rddA7C8Opa3XgWWReQdjL1ZDcQXDb0hf7LvYgX7aiO4/9YlVij6nxHejJ
   cgOy1q98AfmFZVx89ayZ1QRZb9oEfVil9XaC962a+RSG+0YrcqCWLKRvb
   PTmbrNtxGwK9XvBcLFqRFDT1QwBM8PrW9lUgVZppnXwV8bznvqzkMIprO
   s5CLoWBDCL0JFFNn8GtINlerP2nqZMWZGLIwfSEIfbTdFq6u9OGxDiZA7
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10332"; a="246673132"
X-IronPort-AV: E=Sophos;i="5.91,186,1647327600"; 
   d="scan'208";a="246673132"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2022 12:52:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,186,1647327600"; 
   d="scan'208";a="534660010"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 29 Apr 2022 12:52:21 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nkWf6-0006ad-Rp;
        Fri, 29 Apr 2022 19:52:20 +0000
Date:   Sat, 30 Apr 2022 03:52:04 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ioannis Angelakopoulos <iangelak@redhat.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [rhvgoyal:ioannis-fanotify 10/18] fs/fuse/inode.c:1246:24: warning:
 extra tokens at end of #ifdef directive
Message-ID: <202204300354.BZkrhejM-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/rhvgoyal/linux ioannis-fanotify
head:   10887e7003a6a801e521d59daff76f0c035f061f
commit: c76a3b348db49e81d723d06f9cdf37bc3a7d51e8 [10/18] FUSE: Add the remote fsnotify support capability to FUSE
config: x86_64-randconfig-a015 (https://download.01.org/0day-ci/archive/20220430/202204300354.BZkrhejM-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.2.0-20) 11.2.0
reproduce (this is a W=1 build):
        # https://github.com/rhvgoyal/linux/commit/c76a3b348db49e81d723d06f9cdf37bc3a7d51e8
        git remote add rhvgoyal https://github.com/rhvgoyal/linux
        git fetch --no-tags rhvgoyal ioannis-fanotify
        git checkout c76a3b348db49e81d723d06f9cdf37bc3a7d51e8
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash fs/fuse/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   fs/fuse/inode.c: In function 'fuse_send_init':
>> fs/fuse/inode.c:1246:24: warning: extra tokens at end of #ifdef directive
    1246 | #ifdef CONFIG_FANOTIFY ||  CONFIG_INOTIFY_USER
         |                        ^~


vim +1246 fs/fuse/inode.c

  1217	
  1218	void fuse_send_init(struct fuse_mount *fm)
  1219	{
  1220		struct fuse_init_args *ia;
  1221		u64 flags;
  1222	
  1223		ia = kzalloc(sizeof(*ia), GFP_KERNEL | __GFP_NOFAIL);
  1224	
  1225		ia->in.major = FUSE_KERNEL_VERSION;
  1226		ia->in.minor = FUSE_KERNEL_MINOR_VERSION;
  1227		ia->in.max_readahead = fm->sb->s_bdi->ra_pages * PAGE_SIZE;
  1228		flags =
  1229			FUSE_ASYNC_READ | FUSE_POSIX_LOCKS | FUSE_ATOMIC_O_TRUNC |
  1230			FUSE_EXPORT_SUPPORT | FUSE_BIG_WRITES | FUSE_DONT_MASK |
  1231			FUSE_SPLICE_WRITE | FUSE_SPLICE_MOVE | FUSE_SPLICE_READ |
  1232			FUSE_FLOCK_LOCKS | FUSE_HAS_IOCTL_DIR | FUSE_AUTO_INVAL_DATA |
  1233			FUSE_DO_READDIRPLUS | FUSE_READDIRPLUS_AUTO | FUSE_ASYNC_DIO |
  1234			FUSE_WRITEBACK_CACHE | FUSE_NO_OPEN_SUPPORT |
  1235			FUSE_PARALLEL_DIROPS | FUSE_HANDLE_KILLPRIV | FUSE_POSIX_ACL |
  1236			FUSE_ABORT_ERROR | FUSE_MAX_PAGES | FUSE_CACHE_SYMLINKS |
  1237			FUSE_NO_OPENDIR_SUPPORT | FUSE_EXPLICIT_INVAL_DATA |
  1238			FUSE_HANDLE_KILLPRIV_V2 | FUSE_SETXATTR_EXT | FUSE_INIT_EXT |
  1239			FUSE_SECURITY_CTX;
  1240	#ifdef CONFIG_FUSE_DAX
  1241		if (fm->fc->dax)
  1242			flags |= FUSE_MAP_ALIGNMENT;
  1243		if (fuse_is_inode_dax_mode(fm->fc->dax_mode))
  1244			flags |= FUSE_HAS_INODE_DAX;
  1245	#endif
> 1246	#ifdef CONFIG_FANOTIFY ||  CONFIG_INOTIFY_USER
  1247		flags |= FUSE_HAVE_FSNOTIFY;
  1248	#endif
  1249		if (fm->fc->auto_submounts)
  1250			flags |= FUSE_SUBMOUNTS;
  1251	
  1252		ia->in.flags = flags;
  1253		ia->in.flags2 = flags >> 32;
  1254	
  1255		ia->args.opcode = FUSE_INIT;
  1256		ia->args.in_numargs = 1;
  1257		ia->args.in_args[0].size = sizeof(ia->in);
  1258		ia->args.in_args[0].value = &ia->in;
  1259		ia->args.out_numargs = 1;
  1260		/* Variable length argument used for backward compatibility
  1261		   with interface version < 7.5.  Rest of init_out is zeroed
  1262		   by do_get_request(), so a short reply is not a problem */
  1263		ia->args.out_argvar = true;
  1264		ia->args.out_args[0].size = sizeof(ia->out);
  1265		ia->args.out_args[0].value = &ia->out;
  1266		ia->args.force = true;
  1267		ia->args.nocreds = true;
  1268		ia->args.end = process_init_reply;
  1269	
  1270		if (fuse_simple_background(fm, &ia->args, GFP_KERNEL) != 0)
  1271			process_init_reply(fm, &ia->args, -ENOTCONN);
  1272	}
  1273	EXPORT_SYMBOL_GPL(fuse_send_init);
  1274	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
