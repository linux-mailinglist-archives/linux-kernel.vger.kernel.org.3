Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00C5F4E19A1
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Mar 2022 05:33:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244693AbiCTEe0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Mar 2022 00:34:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235846AbiCTEeY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Mar 2022 00:34:24 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACA7AF39
        for <linux-kernel@vger.kernel.org>; Sat, 19 Mar 2022 21:33:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647750780; x=1679286780;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=T8PgXPwUB7x80Snub8mVwqNz4p0+StZLkf6bD2ZZHxE=;
  b=Q+oKxSgCwredOXEpkD2QEj80wvsoI2Yb9dJ9QhIKV3LUnaJMZWnMksLf
   xZ9zz0D/pia0c6vsCHVWU0sZU8FuwU65PnAMOLAOWy4kD01uVHlelRzML
   cdrv1BefL6zQ35MkmkrFNE9F1qgTnAertlONuAwEKZpFxZdIzbd5clJjt
   C2z99i9yZM3Chv6sm3hDTSKr5PAdszlyUyy6TDRg+e/5Bg3ePj0vU8DwD
   SRPKuy3nAnFxfkaqq3jyE/ws6JsqdVVZ7XmaNaDDzAQtsLsx/p/JjvjNh
   6Zmi8V62T7coaND8cCWaRcTt+OBAz+XnWeuQc087IVf0iMieI3CSVgYhp
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10291"; a="282172294"
X-IronPort-AV: E=Sophos;i="5.90,195,1643702400"; 
   d="scan'208";a="282172294"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2022 21:32:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,195,1643702400"; 
   d="scan'208";a="514553418"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga002.jf.intel.com with ESMTP; 19 Mar 2022 21:32:56 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nVnFP-000GZq-ML; Sun, 20 Mar 2022 04:32:55 +0000
Date:   Sun, 20 Mar 2022 12:32:22 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Ryan C. England" <rcengland@gmail.com>, gregkh@linuxfoundation.org
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org, arve@android.com,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev,
        "Ryan C. England" <rcengland@gmail.com>
Subject: Re: [PATCH] staging: android: ashmem: Fixed a struct coding style
 issue
Message-ID: <202203201252.7MGSCMzO-lkp@intel.com>
References: <20220320033337.47118-1-rcengland@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220320033337.47118-1-rcengland@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi "Ryan,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on v5.17-rc8]
[cannot apply to staging/staging-testing next-20220318]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Ryan-C-England/staging-android-ashmem-Fixed-a-struct-coding-style-issue/20220320-113530
base:    09688c0166e76ce2fb85e86b9d99be8b0084cdf9
config: hexagon-randconfig-r001-20220320 (https://download.01.org/0day-ci/archive/20220320/202203201252.7MGSCMzO-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 85e9b2687a13d1908aa86d1b89c5ce398a06cd39)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/10507a768384915f1f405934b635a4409626571d
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Ryan-C-England/staging-android-ashmem-Fixed-a-struct-coding-style-issue/20220320-113530
        git checkout 10507a768384915f1f405934b635a4409626571d
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=hexagon SHELL=/bin/bash drivers/staging/android/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> drivers/staging/android/ashmem.c:431:16: error: cannot assign to variable 'vmfile_fops' with const-qualified type 'const struct file_operations'
                           vmfile_fops = *vmfile->f_op;
                           ~~~~~~~~~~~ ^
   drivers/staging/android/ashmem.c:380:31: note: variable 'vmfile_fops' declared const here
           const struct file_operations vmfile_fops;
           ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~
   drivers/staging/android/ashmem.c:432:21: error: cannot assign to variable 'vmfile_fops' with const-qualified type 'const struct file_operations'
                           vmfile_fops.mmap = ashmem_vmfile_mmap;
                           ~~~~~~~~~~~~~~~~ ^
   drivers/staging/android/ashmem.c:380:31: note: variable 'vmfile_fops' declared const here
           const struct file_operations vmfile_fops;
           ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~
   drivers/staging/android/ashmem.c:433:34: error: cannot assign to variable 'vmfile_fops' with const-qualified type 'const struct file_operations'
                           vmfile_fops.get_unmapped_area =
                           ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ ^
   drivers/staging/android/ashmem.c:380:31: note: variable 'vmfile_fops' declared const here
           const struct file_operations vmfile_fops;
           ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~
   3 errors generated.


vim +431 drivers/staging/android/ashmem.c

6d67b0290b4b84 Suren Baghdasaryan 2020-01-27  377  
11980c2ac4ccfa Robert Love        2011-12-20  378  static int ashmem_mmap(struct file *file, struct vm_area_struct *vma)
11980c2ac4ccfa Robert Love        2011-12-20  379  {
10507a76838491 Ryan C. England    2022-03-20  380  	const struct file_operations vmfile_fops;
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

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
