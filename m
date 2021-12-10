Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3068546F8CE
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 02:53:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235560AbhLJB4g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 20:56:36 -0500
Received: from mga09.intel.com ([134.134.136.24]:50744 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233728AbhLJB4f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 20:56:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639101181; x=1670637181;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=eurIK1uYaYz5dKAW78Ta++JEAOIgT9uFZs3zOPwt8+o=;
  b=TQ0h1l+ZLE+0BcFVvy1ffT6cbUiVi+/adzQFJ5FRCiigsbm3iihxpa/X
   q3tpMbQs3cA8e8s0mw0Br1DluF9fQfpEOtL1EvtLrAAtCbYMIgA/nDGi+
   FXH5cF0qDivCust52doydVmX7AcCMkxeNBtkOOeOvEZRUyTIz/8OmyLb2
   LcyVZR601MCztHMogrdC0REWtIE8ZQhxq+TT6x8BwYerKUXSGaEKstO14
   U0YAdMQfeuCvFbadBj/WhFvYrSz0mPMflyWiOFYgpJ6uuEE8lSBP9kXxs
   ViSbZCX/GcYyffQQkOxppwahZIFzZtMOmj8mTfpLMv9l8e9PBgB0ajb8y
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10193"; a="238053773"
X-IronPort-AV: E=Sophos;i="5.88,194,1635231600"; 
   d="scan'208";a="238053773"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2021 17:52:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,194,1635231600"; 
   d="scan'208";a="463488106"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 09 Dec 2021 17:52:50 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mvV5d-0002cF-BF; Fri, 10 Dec 2021 01:52:49 +0000
Date:   Fri, 10 Dec 2021 09:51:51 +0800
From:   kernel test robot <lkp@intel.com>
To:     David Howells <dhowells@redhat.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [dhowells-fs:fscache-rewrite 65/69] fs/nfs/file.c:435:16: error:
 implicit declaration of function 'nfs_fscache_release_page'; did you mean
 'nfs_release_page'?
Message-ID: <202112100957.2oEDT20W-lkp@intel.com>
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
config: nds32-defconfig (https://download.01.org/0day-ci/archive/20211210/202112100957.2oEDT20W-lkp@intel.com/config)
compiler: nds32le-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git/commit/?id=f6770459bb519747a01e91834f88ac82299a47de
        git remote add dhowells-fs https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git
        git fetch --no-tags dhowells-fs fscache-rewrite
        git checkout f6770459bb519747a01e91834f88ac82299a47de
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=nds32 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   fs/nfs/file.c: In function 'nfs_file_release':
   fs/nfs/file.c:87:9: error: implicit declaration of function 'nfs_fscache_release_file'; did you mean 'nfs_fscache_open_file'? [-Werror=implicit-function-declaration]
      87 |         nfs_fscache_release_file(inode, filp);
         |         ^~~~~~~~~~~~~~~~~~~~~~~~
         |         nfs_fscache_open_file
   fs/nfs/file.c: In function 'nfs_release_page':
>> fs/nfs/file.c:435:16: error: implicit declaration of function 'nfs_fscache_release_page'; did you mean 'nfs_release_page'? [-Werror=implicit-function-declaration]
     435 |         return nfs_fscache_release_page(page, gfp);
         |                ^~~~~~~~~~~~~~~~~~~~~~~~
         |                nfs_release_page
   cc1: some warnings being treated as errors


vim +435 fs/nfs/file.c

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
