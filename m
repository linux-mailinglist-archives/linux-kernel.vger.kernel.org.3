Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D65547AB0D
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 15:11:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233475AbhLTOLC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 09:11:02 -0500
Received: from mga06.intel.com ([134.134.136.31]:34702 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230116AbhLTOLB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 09:11:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640009461; x=1671545461;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=rqvsOpIixW7RTGrdUz0Xm3qC62qrpABj6D5TeHDs8B0=;
  b=nl5ZJEYK0L47HRkTeCSwv5WES7Jwe7BLlA6XAED7fHUEf0LhFUVxyLaO
   2ZW1/yfs0ngzRNJdmprYxK0+93Ep2P5hbyldZ4ZI9u+UPCvNh80V+QOVA
   xHhu0ZLPUAdP0n200aMcq3tFAVneRi3Ce5XLlJ/FaJZO9NFsCTFCgRSGV
   bGpxVb2Thp3iaNA0h+ulAoUd+Dq4UX28a3nsMd/PfR9BFEDmpcycoGne/
   TO1WNEkAxjysdEEgW+NiHuoOtoF8dG4Eypuu6a2Sj+I8z39Rl0YN/y5d5
   2RZHsKvNfF63wdpm2RwLV5Gb4dGBNy6ujBVM6pLifpdJ4pyrjHTLW7DPI
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10203"; a="300942856"
X-IronPort-AV: E=Sophos;i="5.88,220,1635231600"; 
   d="scan'208";a="300942856"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Dec 2021 06:07:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,220,1635231600"; 
   d="scan'208";a="755370719"
Received: from lkp-server02.sh.intel.com (HELO 9f38c0981d9f) ([10.239.97.151])
  by fmsmga006.fm.intel.com with ESMTP; 20 Dec 2021 06:07:13 -0800
Received: from kbuild by 9f38c0981d9f with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mzJJj-0007pY-NB; Mon, 20 Dec 2021 14:07:07 +0000
Date:   Mon, 20 Dec 2021 22:06:57 +0800
From:   kernel test robot <lkp@intel.com>
To:     Chao Yu <yuchao0@huawei.com>, Chao Yu <chao@kernel.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        Chao Yu <yuchao0@huawei.com>, Chao Yu <chao@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [chao:feature/dax 4/9] fs/f2fs/file.c:584:7: error: implicit
 declaration of function 'daxdev_mapping_supported'
Message-ID: <202112202110.sW5LQCPm-lkp@intel.com>
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
config: mips-randconfig-r002-20211220 (https://download.01.org/0day-ci/archive/20211220/202112202110.sW5LQCPm-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project 683cbc12b33e5c8dc8d29bf5ed79fbf45763aadd)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install mips cross compiling tool for clang build
        # apt-get install binutils-mips-linux-gnu
        # https://git.kernel.org/pub/scm/linux/kernel/git/chao/linux.git/commit/?id=f154828642167c70161576b977082361123a5768
        git remote add chao https://git.kernel.org/pub/scm/linux/kernel/git/chao/linux.git
        git fetch --no-tags chao feature/dax
        git checkout f154828642167c70161576b977082361123a5768
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=mips SHELL=/bin/bash fs/f2fs/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> fs/f2fs/file.c:584:7: error: implicit declaration of function 'daxdev_mapping_supported' [-Werror,-Wimplicit-function-declaration]
           if (!daxdev_mapping_supported(vma, F2FS_I_SB(inode)->s_daxdev))
                ^
   1 error generated.


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
