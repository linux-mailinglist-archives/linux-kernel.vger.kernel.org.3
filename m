Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 868B8497F82
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 13:27:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239604AbiAXM1q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 07:27:46 -0500
Received: from mga17.intel.com ([192.55.52.151]:51910 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239363AbiAXM1n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 07:27:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643027263; x=1674563263;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=EqQHn0ZoeAwD8HgVv8SNasFoJD4otEaUKuLOFtUS8Kk=;
  b=BSTv9N5McG0U7E6dB8biPRVxxyF+jQ/FbbkJDyF2hzxo4W2qrHPw8vjs
   6YvmQTC/MBGjSaEY5ITvK2UvHpy7gjXptWtwY+eG++9rrF44T3xbkUzdP
   kqyefMNcB1YO5ijVIpQ1K2j4gtTXKGy7cyK2jmP2aawPLHRHvWYOXZ0r7
   lPI4N3ihEy22LdWIRp9G4ykMAlPHQvuBhVEYsYLsziB3hYi5640ZslaTq
   ObzhCWmB9ygISxz+O+sy6uOq299mb2z7P3jCBP1ySP3/t+ggppzwU240K
   sOMS6BSRC/weohTxfZZkplCWcXG1lD0x0Ynl8w/WZ2PiWI1FfRcv6vEND
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10236"; a="226705307"
X-IronPort-AV: E=Sophos;i="5.88,311,1635231600"; 
   d="scan'208";a="226705307"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2022 04:27:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,311,1635231600"; 
   d="scan'208";a="617217124"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 24 Jan 2022 04:27:40 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nByRf-000IJH-Es; Mon, 24 Jan 2022 12:27:39 +0000
Date:   Mon, 24 Jan 2022 20:27:22 +0800
From:   kernel test robot <lkp@intel.com>
To:     ratnesh-r1 <me.ratnesh682@gmail.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        me.ratnesh682@gmail.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Christian Brauner <christian@brauner.io>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: android: ashmem: Declared file operation with
 const keyword
Message-ID: <202201242027.9RTdyW5P-lkp@intel.com>
References: <1643008187-75859-1-git-send-email-me.ratnesh682@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1643008187-75859-1-git-send-email-me.ratnesh682@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi ratnesh-r1,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on staging/staging-testing]

url:    https://github.com/0day-ci/linux/commits/ratnesh-r1/staging-android-ashmem-Declared-file-operation-with-const-keyword/20220124-151116
base:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git fa783154524a71ab74e293cd8251155e5971952b
config: riscv-randconfig-c006-20220124 (https://download.01.org/0day-ci/archive/20220124/202201242027.9RTdyW5P-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project 2e58a18910867ba6795066e044293e6daf89edf5)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install riscv cross compiling tool for clang build
        # apt-get install binutils-riscv64-linux-gnu
        # https://github.com/0day-ci/linux/commit/c24fe2afe4abdf6436628abd13a0109ec420f373
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review ratnesh-r1/staging-android-ashmem-Declared-file-operation-with-const-keyword/20220124-151116
        git checkout c24fe2afe4abdf6436628abd13a0109ec420f373
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=riscv SHELL=/bin/bash drivers/staging/android/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> drivers/staging/android/ashmem.c:431:16: error: cannot assign to variable 'vmfile_fops' with const-qualified type 'const struct file_operations'
                           vmfile_fops = *vmfile->f_op;
                           ~~~~~~~~~~~ ^
   drivers/staging/android/ashmem.c:380:38: note: variable 'vmfile_fops' declared const here
           static const struct file_operations vmfile_fops;
           ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~
   drivers/staging/android/ashmem.c:432:21: error: cannot assign to variable 'vmfile_fops' with const-qualified type 'const struct file_operations'
                           vmfile_fops.mmap = ashmem_vmfile_mmap;
                           ~~~~~~~~~~~~~~~~ ^
   drivers/staging/android/ashmem.c:380:38: note: variable 'vmfile_fops' declared const here
           static const struct file_operations vmfile_fops;
           ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~
   drivers/staging/android/ashmem.c:433:34: error: cannot assign to variable 'vmfile_fops' with const-qualified type 'const struct file_operations'
                           vmfile_fops.get_unmapped_area =
                           ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ ^
   drivers/staging/android/ashmem.c:380:38: note: variable 'vmfile_fops' declared const here
           static const struct file_operations vmfile_fops;
           ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~
   3 errors generated.


vim +431 drivers/staging/android/ashmem.c

6d67b0290b4b84 Suren Baghdasaryan 2020-01-27  377  
11980c2ac4ccfa Robert Love        2011-12-20  378  static int ashmem_mmap(struct file *file, struct vm_area_struct *vma)
11980c2ac4ccfa Robert Love        2011-12-20  379  {
c24fe2afe4abdf ratnesh-r1         2022-01-23  380  	static const struct file_operations vmfile_fops;
11980c2ac4ccfa Robert Love        2011-12-20  381  	struct ashmem_area *asma = file->private_data;
11980c2ac4ccfa Robert Love        2011-12-20  382  	int ret = 0;
11980c2ac4ccfa Robert Love        2011-12-20  383  
11980c2ac4ccfa Robert Love        2011-12-20  384  	mutex_lock(&ashmem_mutex);
11980c2ac4ccfa Robert Love        2011-12-20  385  
11980c2ac4ccfa Robert Love        2011-12-20  386  	/* user needs to SET_SIZE before mapping */
59848d6aded59a Alistair Strachan  2018-06-19  387  	if (!asma->size) {
11980c2ac4ccfa Robert Love        2011-12-20  388  		ret = -EINVAL;
11980c2ac4ccfa Robert Love        2011-12-20  389  		goto out;
11980c2ac4ccfa Robert Love        2011-12-20  390  	}
11980c2ac4ccfa Robert Love        2011-12-20  391  
8632c614565d0c Alistair Strachan  2018-06-19  392  	/* requested mapping size larger than object size */
8632c614565d0c Alistair Strachan  2018-06-19  393  	if (vma->vm_end - vma->vm_start > PAGE_ALIGN(asma->size)) {
11980c2ac4ccfa Robert Love        2011-12-20  394  		ret = -EINVAL;
11980c2ac4ccfa Robert Love        2011-12-20  395  		goto out;
11980c2ac4ccfa Robert Love        2011-12-20  396  	}
11980c2ac4ccfa Robert Love        2011-12-20  397  
11980c2ac4ccfa Robert Love        2011-12-20  398  	/* requested protection bits must match our allowed protection mask */
59848d6aded59a Alistair Strachan  2018-06-19  399  	if ((vma->vm_flags & ~calc_vm_prot_bits(asma->prot_mask, 0)) &
59848d6aded59a Alistair Strachan  2018-06-19  400  	    calc_vm_prot_bits(PROT_MASK, 0)) {
11980c2ac4ccfa Robert Love        2011-12-20  401  		ret = -EPERM;
11980c2ac4ccfa Robert Love        2011-12-20  402  		goto out;
11980c2ac4ccfa Robert Love        2011-12-20  403  	}
56f76fc68492af Arve Hjønnevåg     2011-12-20  404  	vma->vm_flags &= ~calc_vm_may_flags(~asma->prot_mask);
11980c2ac4ccfa Robert Love        2011-12-20  405  
11980c2ac4ccfa Robert Love        2011-12-20  406  	if (!asma->file) {
11980c2ac4ccfa Robert Love        2011-12-20  407  		char *name = ASHMEM_NAME_DEF;
11980c2ac4ccfa Robert Love        2011-12-20  408  		struct file *vmfile;
3e338d3c95c735 Suren Baghdasaryan 2020-07-30  409  		struct inode *inode;
11980c2ac4ccfa Robert Love        2011-12-20  410  
11980c2ac4ccfa Robert Love        2011-12-20  411  		if (asma->name[ASHMEM_NAME_PREFIX_LEN] != '\0')
11980c2ac4ccfa Robert Love        2011-12-20  412  			name = asma->name;
11980c2ac4ccfa Robert Love        2011-12-20  413  
11980c2ac4ccfa Robert Love        2011-12-20  414  		/* ... and allocate the backing shmem file */
11980c2ac4ccfa Robert Love        2011-12-20  415  		vmfile = shmem_file_setup(name, asma->size, vma->vm_flags);
7f44cb0ba88b40 Viresh Kumar       2015-07-31  416  		if (IS_ERR(vmfile)) {
11980c2ac4ccfa Robert Love        2011-12-20  417  			ret = PTR_ERR(vmfile);
11980c2ac4ccfa Robert Love        2011-12-20  418  			goto out;
11980c2ac4ccfa Robert Love        2011-12-20  419  		}
97fbfef6bd5978 Shuxiao Zhang      2017-04-06  420  		vmfile->f_mode |= FMODE_LSEEK;
3e338d3c95c735 Suren Baghdasaryan 2020-07-30  421  		inode = file_inode(vmfile);
3e338d3c95c735 Suren Baghdasaryan 2020-07-30  422  		lockdep_set_class(&inode->i_rwsem, &backing_shmem_inode_class);
11980c2ac4ccfa Robert Love        2011-12-20  423  		asma->file = vmfile;
6d67b0290b4b84 Suren Baghdasaryan 2020-01-27  424  		/*
6d67b0290b4b84 Suren Baghdasaryan 2020-01-27  425  		 * override mmap operation of the vmfile so that it can't be
6d67b0290b4b84 Suren Baghdasaryan 2020-01-27  426  		 * remapped which would lead to creation of a new vma with no
6d67b0290b4b84 Suren Baghdasaryan 2020-01-27  427  		 * asma permission checks. Have to override get_unmapped_area
6d67b0290b4b84 Suren Baghdasaryan 2020-01-27  428  		 * as well to prevent VM_BUG_ON check for f_ops modification.
6d67b0290b4b84 Suren Baghdasaryan 2020-01-27  429  		 */
6d67b0290b4b84 Suren Baghdasaryan 2020-01-27  430  		if (!vmfile_fops.mmap) {
6d67b0290b4b84 Suren Baghdasaryan 2020-01-27 @431  			vmfile_fops = *vmfile->f_op;
6d67b0290b4b84 Suren Baghdasaryan 2020-01-27  432  			vmfile_fops.mmap = ashmem_vmfile_mmap;
6d67b0290b4b84 Suren Baghdasaryan 2020-01-27  433  			vmfile_fops.get_unmapped_area =
6d67b0290b4b84 Suren Baghdasaryan 2020-01-27  434  					ashmem_vmfile_get_unmapped_area;
6d67b0290b4b84 Suren Baghdasaryan 2020-01-27  435  		}
6d67b0290b4b84 Suren Baghdasaryan 2020-01-27  436  		vmfile->f_op = &vmfile_fops;
11980c2ac4ccfa Robert Love        2011-12-20  437  	}
11980c2ac4ccfa Robert Love        2011-12-20  438  	get_file(asma->file);
11980c2ac4ccfa Robert Love        2011-12-20  439  
11980c2ac4ccfa Robert Love        2011-12-20  440  	/*
11980c2ac4ccfa Robert Love        2011-12-20  441  	 * XXX - Reworked to use shmem_zero_setup() instead of
11980c2ac4ccfa Robert Love        2011-12-20  442  	 * shmem_set_file while we're in staging. -jstultz
11980c2ac4ccfa Robert Love        2011-12-20  443  	 */
11980c2ac4ccfa Robert Love        2011-12-20  444  	if (vma->vm_flags & VM_SHARED) {
11980c2ac4ccfa Robert Love        2011-12-20  445  		ret = shmem_zero_setup(vma);
11980c2ac4ccfa Robert Love        2011-12-20  446  		if (ret) {
11980c2ac4ccfa Robert Love        2011-12-20  447  			fput(asma->file);
11980c2ac4ccfa Robert Love        2011-12-20  448  			goto out;
11980c2ac4ccfa Robert Love        2011-12-20  449  		}
44960f2a7b63e2 John Stultz        2018-07-31  450  	} else {
44960f2a7b63e2 John Stultz        2018-07-31  451  		vma_set_anonymous(vma);
11980c2ac4ccfa Robert Love        2011-12-20  452  	}
11980c2ac4ccfa Robert Love        2011-12-20  453  
295992fb815e79 Christian König    2020-09-14  454  	vma_set_file(vma, asma->file);
295992fb815e79 Christian König    2020-09-14  455  	/* XXX: merge this with the get_file() above if possible */
295992fb815e79 Christian König    2020-09-14  456  	fput(asma->file);
11980c2ac4ccfa Robert Love        2011-12-20  457  
11980c2ac4ccfa Robert Love        2011-12-20  458  out:
11980c2ac4ccfa Robert Love        2011-12-20  459  	mutex_unlock(&ashmem_mutex);
11980c2ac4ccfa Robert Love        2011-12-20  460  	return ret;
11980c2ac4ccfa Robert Love        2011-12-20  461  }
11980c2ac4ccfa Robert Love        2011-12-20  462  

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
