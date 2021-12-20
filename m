Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E18947B56A
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 22:58:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231723AbhLTV62 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 16:58:28 -0500
Received: from mga11.intel.com ([192.55.52.93]:28496 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231705AbhLTV60 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 16:58:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640037506; x=1671573506;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=WePxmrd3wEigSqY9uR8tVCDA1TGLawIzf0UAt16kxQw=;
  b=aX8jDPjQtRXQxtyhrYZqDx3glogo5/IPHxmDPFDPZziDMOgLrMvN7C4h
   m3vUNWm4nMvjTPhQqlDhtn3r+OCf7FxkF6jxFFuuR3suiS1Z3ELUbaYrc
   +x0gaPAVnskf940qx/vv7RYCKrixTd/upW81LlTJdXdXwplp7XAzup09x
   ymTRcyyIq2zoOSVKHwqLcxsgm3C8Vj/ZpJv9kvf+hWLcHeCEzD+DNVb92
   0b8AmM8Z250G37dt6pmlXwWEiHx45SS50bVVLcWgdoQDlCF+1+RwOylKj
   a15SN59d+9xqQhnatO0Yx/mSjzH4GyDrOJ8QGPXbSgMgvKvcrzrPugh3K
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10204"; a="237816169"
X-IronPort-AV: E=Sophos;i="5.88,221,1635231600"; 
   d="scan'208";a="237816169"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Dec 2021 13:58:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,221,1635231600"; 
   d="scan'208";a="507843353"
Received: from lkp-server02.sh.intel.com (HELO 9f38c0981d9f) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 20 Dec 2021 13:58:24 -0800
Received: from kbuild by 9f38c0981d9f with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mzQfn-0008Hv-R4; Mon, 20 Dec 2021 21:58:23 +0000
Date:   Tue, 21 Dec 2021 05:57:57 +0800
From:   kernel test robot <lkp@intel.com>
To:     Chao Yu <yuchao0@huawei.com>, Chao Yu <chao@kernel.org>
Cc:     kbuild-all@lists.01.org, Chao Yu <yuchao0@huawei.com>,
        Chao Yu <chao@kernel.org>, linux-kernel@vger.kernel.org
Subject: [chao:feature/dax 4/9] fs/f2fs/file.c:584:14: error: implicit
 declaration of function 'daxdev_mapping_supported'
Message-ID: <202112210512.TWkTNRT1-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/chao/linux.git feature/dax
head:   d08999836fd60ab725eee1f5a5fb3b00f7bcefd3
commit: f154828642167c70161576b977082361123a5768 [4/9] f2fs: support dax page fault
config: microblaze-randconfig-r015-20211220 (https://download.01.org/0day-ci/archive/20211221/202112210512.TWkTNRT1-lkp@intel.com/config)
compiler: microblaze-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/chao/linux.git/commit/?id=f154828642167c70161576b977082361123a5768
        git remote add chao https://git.kernel.org/pub/scm/linux/kernel/git/chao/linux.git
        git fetch --no-tags chao feature/dax
        git checkout f154828642167c70161576b977082361123a5768
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=microblaze SHELL=/bin/bash fs/f2fs/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from include/linux/build_bug.h:5,
                    from include/linux/container_of.h:5,
                    from include/linux/list.h:5,
                    from include/linux/wait.h:7,
                    from include/linux/wait_bit.h:8,
                    from include/linux/fs.h:6,
                    from fs/f2fs/file.c:8:
   fs/f2fs/file.c: In function 'f2fs_file_mmap':
>> fs/f2fs/file.c:584:14: error: implicit declaration of function 'daxdev_mapping_supported' [-Werror=implicit-function-declaration]
     584 |         if (!daxdev_mapping_supported(vma, F2FS_I_SB(inode)->s_daxdev))
         |              ^~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/compiler.h:58:52: note: in definition of macro '__trace_if_var'
      58 | #define __trace_if_var(cond) (__builtin_constant_p(cond) ? (cond) : __trace_if_value(cond))
         |                                                    ^~~~
   fs/f2fs/file.c:584:9: note: in expansion of macro 'if'
     584 |         if (!daxdev_mapping_supported(vma, F2FS_I_SB(inode)->s_daxdev))
         |         ^~
   cc1: some warnings being treated as errors


vim +/daxdev_mapping_supported +584 fs/f2fs/file.c

   569	
   570	static int f2fs_file_mmap(struct file *file, struct vm_area_struct *vma)
   571	{
   572		struct inode *inode = file_inode(file);
   573	
   574		if (unlikely(f2fs_cp_error(F2FS_I_SB(inode))))
   575			return -EIO;
   576	
   577		if (!f2fs_is_compress_backend_ready(inode))
   578			return -EOPNOTSUPP;
   579	
   580		/*
   581		 * We don't support synchronous mappings for non-DAX files and
   582		 * for DAX files if underneath dax_device is not synchronous.
   583		 */
 > 584		if (!daxdev_mapping_supported(vma, F2FS_I_SB(inode)->s_daxdev))
   585			return -EOPNOTSUPP;
   586	
   587		file_accessed(file);
   588	
   589		if (IS_DAX(inode)) {
   590			vma->vm_ops = &f2fs_dax_vm_ops;
   591			vma->vm_flags |= VM_HUGEPAGE;
   592		} else {
   593			vma->vm_ops = &f2fs_file_vm_ops;
   594		}
   595	
   596		set_inode_flag(inode, FI_MMAP_FILE);
   597		return 0;
   598	}
   599	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
