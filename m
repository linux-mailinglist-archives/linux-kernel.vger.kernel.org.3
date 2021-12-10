Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5ACE546F8CD
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 02:52:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235542AbhLJB42 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 20:56:28 -0500
Received: from mga01.intel.com ([192.55.52.88]:58411 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235446AbhLJB41 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 20:56:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639101173; x=1670637173;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=kmM1tgd8FYTYKIj9BXxysODAFcJI92I6TFR5cf1a1VA=;
  b=OoFitY+Kp8XkQTXrpJih51p4hpB7iZoKESN4YmkJL4FB8/1bLVZpc0fZ
   XoxDjHPngxtD3nauf5//td/mBcsL5h+HXszTXVlBL8X9+dXRFVPJyYnDC
   aWJNlQqlDi9rtS6H//A2f/PPeNel9lkS5yew6erOhsO0zLC+jC5i5rMis
   YwAYinMBRAgIQfhWPPtKSA+7g6fzDpBnjZ5Qsgxtb6Kvk0CHzqkBL5wSo
   aiw7+J7BHKIYdYwfSL+d+UTTx6EL6dF0cg/LSfO4Jc3sIe+DhRNRYL2pA
   uJd8SArYd9xvL1nb8Rm3FqYLi9TGXyRQyErQWuXau6p6mvc85tWD5BQzP
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10193"; a="262359149"
X-IronPort-AV: E=Sophos;i="5.88,194,1635231600"; 
   d="scan'208";a="262359149"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2021 17:52:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,194,1635231600"; 
   d="scan'208";a="503741239"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 09 Dec 2021 17:52:49 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mvV5d-0002cD-An; Fri, 10 Dec 2021 01:52:49 +0000
Date:   Fri, 10 Dec 2021 09:51:54 +0800
From:   kernel test robot <lkp@intel.com>
To:     Dave Wysochanski <dwysocha@redhat.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, David Howells <dhowells@redhat.com>
Subject: [dhowells-fs:fscache-rewrite 64/69] fs/nfs/file.c:87:2: error:
 implicit declaration of function 'nfs_fscache_release_file'
Message-ID: <202112100931.6qc8V8T4-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git fscache-rewrite
head:   82abe23a0865faea23cf06ac51f2303f26b9bb53
commit: 57858b0feb9a11f6d9b5720cdd13222098f9e59f [64/69] nfs: Convert to new fscache volume/cookie API
config: x86_64-randconfig-a011-20211209 (https://download.01.org/0day-ci/archive/20211210/202112100931.6qc8V8T4-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project 097a1cb1d5ebb3a0ec4bcaed8ba3ff6a8e33c00a)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git/commit/?id=57858b0feb9a11f6d9b5720cdd13222098f9e59f
        git remote add dhowells-fs https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git
        git fetch --no-tags dhowells-fs fscache-rewrite
        git checkout 57858b0feb9a11f6d9b5720cdd13222098f9e59f
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash fs/nfs/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> fs/nfs/file.c:87:2: error: implicit declaration of function 'nfs_fscache_release_file' [-Werror,-Wimplicit-function-declaration]
           nfs_fscache_release_file(inode, filp);
           ^
   fs/nfs/file.c:87:2: note: did you mean 'nfs_fscache_release_page'?
   fs/nfs/fscache.h:154:19: note: 'nfs_fscache_release_page' declared here
   static inline int nfs_fscache_release_page(struct page *page, gfp_t gfp)
                     ^
   1 error generated.


vim +/nfs_fscache_release_file +87 fs/nfs/file.c

    79	
    80	int
    81	nfs_file_release(struct inode *inode, struct file *filp)
    82	{
    83		dprintk("NFS: release(%pD2)\n", filp);
    84	
    85		nfs_inc_stats(inode, NFSIOS_VFSRELEASE);
    86		nfs_file_clear_open_context(filp);
  > 87		nfs_fscache_release_file(inode, filp);
    88		return 0;
    89	}
    90	EXPORT_SYMBOL_GPL(nfs_file_release);
    91	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
