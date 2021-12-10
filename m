Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2ED2B46F835
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 02:01:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235044AbhLJBFZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 20:05:25 -0500
Received: from mga12.intel.com ([192.55.52.136]:35827 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233309AbhLJBFY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 20:05:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639098110; x=1670634110;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=eOJLLcXb1/bckefrtZrecFBn7qdkg7pIKECqUj7+pPY=;
  b=diWdj8ZGgXRjEk3D+8uOc/vvZw3BT+UBtobt/mDYkpWxfY0Ev9/LAUSj
   VcFVxHfKMRDNIZOsxpKFyglOpa+r9H47Q7iB9y9yn4W2Pq/Q7JZ3BkCC9
   GLF71eOm7HLeI9XXxQS+b9sl59j2/WzS0ozYYVLsOrMQ1/O9JjQqc7PPh
   fgokVxHtnK2+Ds1iETh4qGa7R7PnWiJ4y3hAAoAraHKxzK+yT3T9NpzvP
   BYOvuDr4qOCRdTs94QoiJxZ13c7fuTOGgoa9jD8AVNDn0MqrXgtARQw3y
   sE2t0+qqIkWNKLDAvUYoPr4fTLcvwjmb7IVE0ZDBcFxA0TjTJGozoAB/B
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10193"; a="218264783"
X-IronPort-AV: E=Sophos;i="5.88,194,1635231600"; 
   d="scan'208";a="218264783"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2021 17:01:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,194,1635231600"; 
   d="scan'208";a="752960146"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by fmsmga005.fm.intel.com with ESMTP; 09 Dec 2021 17:01:48 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mvUIG-0002Zo-4S; Fri, 10 Dec 2021 01:01:48 +0000
Date:   Fri, 10 Dec 2021 09:00:58 +0800
From:   kernel test robot <lkp@intel.com>
To:     Dave Wysochanski <dwysocha@redhat.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        David Howells <dhowells@redhat.com>
Subject: [dhowells-fs:fscache-rewrite 64/69] fs/nfs/file.c:87:9: error:
 implicit declaration of function 'nfs_fscache_release_file'; did you mean
 'nfs_fscache_release_page'?
Message-ID: <202112100804.nksO8K4u-lkp@intel.com>
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
config: nds32-defconfig (https://download.01.org/0day-ci/archive/20211210/202112100804.nksO8K4u-lkp@intel.com/config)
compiler: nds32le-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git/commit/?id=57858b0feb9a11f6d9b5720cdd13222098f9e59f
        git remote add dhowells-fs https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git
        git fetch --no-tags dhowells-fs fscache-rewrite
        git checkout 57858b0feb9a11f6d9b5720cdd13222098f9e59f
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=nds32 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   fs/nfs/file.c: In function 'nfs_file_release':
>> fs/nfs/file.c:87:9: error: implicit declaration of function 'nfs_fscache_release_file'; did you mean 'nfs_fscache_release_page'? [-Werror=implicit-function-declaration]
      87 |         nfs_fscache_release_file(inode, filp);
         |         ^~~~~~~~~~~~~~~~~~~~~~~~
         |         nfs_fscache_release_page
   cc1: some warnings being treated as errors


vim +87 fs/nfs/file.c

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
