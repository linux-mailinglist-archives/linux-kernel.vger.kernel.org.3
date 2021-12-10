Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5976146F94C
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 03:43:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236100AbhLJCr1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 21:47:27 -0500
Received: from mga06.intel.com ([134.134.136.31]:28120 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231175AbhLJCr1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 21:47:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639104233; x=1670640233;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=AK6C/kt0u0dSUpyH48nqt5KemhvO1JjPsGitR6x9Jbk=;
  b=In15AjadhCuhDSmJ6tgTfuxDXnra5heLQ80p7Xt/R2ik3GYboHTJy7Xc
   WWocqYPcaDBsCxCDgCWhXi8OK5s56Uy8DnGq92VwSjY7jSwkxB9xyY+Wl
   MPXKa6ts7yYQJeBCLfTR/UIhklvYCVswAWWY76Huin7MtUL/NTZrzElGw
   dFnKp10YSu73agCaca69y30b7Eiz3tzkNI+1HxDKj7vaLFW/Dg+s20EuX
   DxDpqlRr/bNcN2AEk3/GhIQlfI9zxk0qXUZWYzr/5/q73FGr82AtNpf0g
   yItb1wIzkSSitSWfSRVPf3Z+NPDwQ6fcBfJME6ALLT+u4fsfMNNWzYh5B
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10193"; a="299048813"
X-IronPort-AV: E=Sophos;i="5.88,194,1635231600"; 
   d="scan'208";a="299048813"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2021 18:43:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,194,1635231600"; 
   d="scan'208";a="680586108"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 09 Dec 2021 18:43:51 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mvVt0-0002fu-JE; Fri, 10 Dec 2021 02:43:50 +0000
Date:   Fri, 10 Dec 2021 10:43:03 +0800
From:   kernel test robot <lkp@intel.com>
To:     David Howells <dhowells@redhat.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [dhowells-fs:fscache-rewrite 65/69] fs/nfs/file.c:435:9: error:
 implicit declaration of function 'nfs_fscache_release_page'
Message-ID: <202112101053.5YQV0dqW-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git fscache-rewrite
head:   82abe23a0865faea23cf06ac51f2303f26b9bb53
commit: f6770459bb519747a01e91834f88ac82299a47de [65/69] nfs: Implement cache I/O by accessing the cache directly
config: x86_64-randconfig-a011-20211209 (https://download.01.org/0day-ci/archive/20211210/202112101053.5YQV0dqW-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project 097a1cb1d5ebb3a0ec4bcaed8ba3ff6a8e33c00a)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git/commit/?id=f6770459bb519747a01e91834f88ac82299a47de
        git remote add dhowells-fs https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git
        git fetch --no-tags dhowells-fs fscache-rewrite
        git checkout f6770459bb519747a01e91834f88ac82299a47de
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash fs/nfs/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   fs/nfs/file.c:87:2: error: implicit declaration of function 'nfs_fscache_release_file' [-Werror,-Wimplicit-function-declaration]
           nfs_fscache_release_file(inode, filp);
           ^
   fs/nfs/file.c:87:2: note: did you mean 'nfs_fscache_open_file'?
   fs/nfs/fscache.h:130:20: note: 'nfs_fscache_open_file' declared here
   static inline void nfs_fscache_open_file(struct inode *inode,
                      ^
>> fs/nfs/file.c:435:9: error: implicit declaration of function 'nfs_fscache_release_page' [-Werror,-Wimplicit-function-declaration]
           return nfs_fscache_release_page(page, gfp);
                  ^
   2 errors generated.


vim +/nfs_fscache_release_page +435 fs/nfs/file.c

cd52ed35535ef4 Trond Myklebust 2006-03-20  421  
6b9b3514aa1881 David Howells   2009-04-03  422  /*
6b9b3514aa1881 David Howells   2009-04-03  423   * Attempt to release the private state associated with a page
545db45f0fc0d4 David Howells   2009-04-03  424   * - Called if either PG_private or PG_fscache is set on the page
6b9b3514aa1881 David Howells   2009-04-03  425   * - Caller holds page lock
6b9b3514aa1881 David Howells   2009-04-03  426   * - Return true (may release page) or false (may not)
6b9b3514aa1881 David Howells   2009-04-03  427   */
cd52ed35535ef4 Trond Myklebust 2006-03-20  428  static int nfs_release_page(struct page *page, gfp_t gfp)
cd52ed35535ef4 Trond Myklebust 2006-03-20  429  {
b7eaefaa8722fd Chuck Lever     2008-06-11  430  	dfprintk(PAGECACHE, "NFS: release_page(%p)\n", page);
b7eaefaa8722fd Chuck Lever     2008-06-11  431  
e3db7691e9f3df Trond Myklebust 2007-01-10  432  	/* If PagePrivate() is set, then the page is not freeable */
545db45f0fc0d4 David Howells   2009-04-03  433  	if (PagePrivate(page))
ddeff520f02b92 Nikita Danilov  2006-08-09  434  		return 0;
545db45f0fc0d4 David Howells   2009-04-03 @435  	return nfs_fscache_release_page(page, gfp);
e3db7691e9f3df Trond Myklebust 2007-01-10  436  }
e3db7691e9f3df Trond Myklebust 2007-01-10  437  

:::::: The code at line 435 was first introduced by commit
:::::: 545db45f0fc0d4203b045047798ce156972a3056 NFS: FS-Cache page management

:::::: TO: David Howells <dhowells@redhat.com>
:::::: CC: David Howells <dhowells@redhat.com>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
