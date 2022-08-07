Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 451B458BCBC
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Aug 2022 21:28:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234924AbiHGT14 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Aug 2022 15:27:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229898AbiHGT1x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Aug 2022 15:27:53 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 494F86477
        for <linux-kernel@vger.kernel.org>; Sun,  7 Aug 2022 12:27:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659900472; x=1691436472;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=yLahnk8gUpB4eMz6x+NA8cMGlMGLWdheAl+Yb3xVhr4=;
  b=WHEr8RYPlmsrXMJtefrYSzU5+tItLh24zgwRpc02C8IWbcYfeqNK//Qj
   DWpGFER9Z+XaZ+fsH1HB2QLPoP8yF71gzZHRTd8Ml7IjoTPxg0pk/l/d/
   MX/9OQ9K9ROsV2v2Uqtk34qAWgitPO8UoET8a0GX2J7jkyqTJI42TiVNw
   oyCV4lMVXt9pzuWIbSsIdr9IG/ZCLU5v/PiynpbzsS/gMgpqm9lefOj3b
   gjbBaXKq2JN66ED6a05n8xh7MJzDScSVwY7oLlgEFWSZCtLa1ob9gOHa8
   l7HQIhRd6JvuA5AeI7fmt9HOt+G3+VcFgJV/D/Vfn6B/ywTYnu+PEQyDm
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10432"; a="291688916"
X-IronPort-AV: E=Sophos;i="5.93,220,1654585200"; 
   d="scan'208";a="291688916"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2022 12:27:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,220,1654585200"; 
   d="scan'208";a="746399315"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 07 Aug 2022 12:27:50 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oKlwD-000Lb3-2H;
        Sun, 07 Aug 2022 19:27:49 +0000
Date:   Mon, 8 Aug 2022 03:27:00 +0800
From:   kernel test robot <lkp@intel.com>
To:     Chao Yu <yuchao0@huawei.com>, Chao Yu <chao@kernel.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        Chao Yu <yuchao0@huawei.com>, Chao Yu <chao@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [chao:feature/dax 4/10] fs/f2fs/file.c:585:7: error: call to
 undeclared function 'daxdev_mapping_supported'; ISO C99 and later do not
 support implicit function declarations
Message-ID: <202208080315.WUak48sf-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/chao/linux.git feature/dax
head:   42f73c9b2a369f724de6c1df5acb0bbde2688e35
commit: ceea248a26ac122204ddad5c76b55ff37fbc06b9 [4/10] f2fs: support dax page fault
config: x86_64-randconfig-a012 (https://download.01.org/0day-ci/archive/20220808/202208080315.WUak48sf-lkp@intel.com/config)
compiler: clang version 16.0.0 (https://github.com/llvm/llvm-project 5f1c7e2cc5a3c07cbc2412e851a7283c1841f520)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/chao/linux.git/commit/?id=ceea248a26ac122204ddad5c76b55ff37fbc06b9
        git remote add chao https://git.kernel.org/pub/scm/linux/kernel/git/chao/linux.git
        git fetch --no-tags chao feature/dax
        git checkout ceea248a26ac122204ddad5c76b55ff37fbc06b9
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash fs/f2fs/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> fs/f2fs/file.c:585:7: error: call to undeclared function 'daxdev_mapping_supported'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
           if (!daxdev_mapping_supported(vma, F2FS_I_SB(inode)->s_daxdev))
                ^
   1 error generated.


vim +/daxdev_mapping_supported +585 fs/f2fs/file.c

   570	
   571	static int f2fs_file_mmap(struct file *file, struct vm_area_struct *vma)
   572	{
   573		struct inode *inode = file_inode(file);
   574	
   575		if (unlikely(f2fs_cp_error(F2FS_I_SB(inode))))
   576			return -EIO;
   577	
   578		if (!f2fs_is_compress_backend_ready(inode))
   579			return -EOPNOTSUPP;
   580	
   581		/*
   582		 * We don't support synchronous mappings for non-DAX files and
   583		 * for DAX files if underneath dax_device is not synchronous.
   584		 */
 > 585		if (!daxdev_mapping_supported(vma, F2FS_I_SB(inode)->s_daxdev))
   586			return -EOPNOTSUPP;
   587	
   588		file_accessed(file);
   589	
   590		if (IS_DAX(inode)) {
   591			vma->vm_ops = &f2fs_dax_vm_ops;
   592			vma->vm_flags |= VM_HUGEPAGE;
   593		} else {
   594			vma->vm_ops = &f2fs_file_vm_ops;
   595		}
   596	
   597		set_inode_flag(inode, FI_MMAP_FILE);
   598		return 0;
   599	}
   600	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
