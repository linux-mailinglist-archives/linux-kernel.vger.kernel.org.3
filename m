Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 492824A2C31
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jan 2022 07:53:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243344AbiA2Gwv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jan 2022 01:52:51 -0500
Received: from mga02.intel.com ([134.134.136.20]:54262 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242130AbiA2Gwq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jan 2022 01:52:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643439166; x=1674975166;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=FoB738ABfuKyQwAKFpU1eA7/cIJ+XYVb7z/u7AHbr3s=;
  b=hb8TUndVc7tVR4H1q1PpGWisLD1HcSUZsanuTjuXF7nhgZO0U2r4T4NE
   Yb9/jLWu0zOPbDwi8vrJG0fsrVeeCjO+KJEUdLAayBxNqCTFFY31vhxqs
   t5+GdbL1ukKg89IF13h/vfCc6DS5W46gJPIV+sp1tFtxfbUfrOj05tIuB
   CGNKOKdo60gh8iOTneaQG9P2XBSs3yh08Dc7VHBPQg6YIqu6g3u4/awBf
   Yj0IWDWXAdkmOZcrqEKZLbMyU2RXfzYX6Kyr2rX8ut9YjBy2CPWPuubcm
   PD3fKISwdcATh5FEuiQoDq4y7AEyrTinW9y4jyyvg1yjrg8rLzeU9rJgS
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10241"; a="234637066"
X-IronPort-AV: E=Sophos;i="5.88,326,1635231600"; 
   d="scan'208";a="234637066"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2022 22:52:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,326,1635231600"; 
   d="scan'208";a="533728520"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 28 Jan 2022 22:52:43 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nDhbH-000OtB-1f; Sat, 29 Jan 2022 06:52:43 +0000
Date:   Sat, 29 Jan 2022 14:52:21 +0800
From:   kernel test robot <lkp@intel.com>
To:     Yishai Hadas <yishaih@nvidia.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Jason Gunthorpe <jgg@nvidia.com>,
        Leon Romanovsky <leonro@nvidia.com>
Subject: [jgunthorpe:for-yishai 12/17] drivers/vfio/pci/mlx5/main.c:254:10:
 warning: result of comparison of constant 9223372036854775807 with
 expression of type 'size_t' (aka 'unsigned int') is always false
Message-ID: <202201291323.OBtyolrA-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/jgunthorpe/linux for-yishai
head:   f63f92a10949b3ad5f769771001e82774bcef055
commit: 70ccf2dd2a78780dd3fd87a7112938ce05da498c [12/17] vfio/mlx5: Implement vfio_pci driver for mlx5 devices
config: i386-allmodconfig (https://download.01.org/0day-ci/archive/20220129/202201291323.OBtyolrA-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project 33b45ee44b1f32ffdbc995e6fec806271b4b3ba4)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/jgunthorpe/linux/commit/70ccf2dd2a78780dd3fd87a7112938ce05da498c
        git remote add jgunthorpe https://github.com/jgunthorpe/linux
        git fetch --no-tags jgunthorpe for-yishai
        git checkout 70ccf2dd2a78780dd3fd87a7112938ce05da498c
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash drivers/vfio/pci/mlx5/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/vfio/pci/mlx5/main.c:254:10: warning: result of comparison of constant 9223372036854775807 with expression of type 'size_t' (aka 'unsigned int') is always false [-Wtautological-constant-out-of-range-compare]
           if (len > type_max(loff_t) || *pos < 0 ||
               ~~~ ^ ~~~~~~~~~~~~~~~~
   1 warning generated.


vim +254 drivers/vfio/pci/mlx5/main.c

   242	
   243	static ssize_t mlx5vf_resume_write(struct file *filp, const char __user *buf,
   244					   size_t len, loff_t *pos)
   245	{
   246		struct mlx5_vf_migration_file *migf = filp->private_data;
   247		loff_t requested_length;
   248		ssize_t done = 0;
   249	
   250		if (pos)
   251			return -ESPIPE;
   252		pos = &filp->f_pos;
   253	
 > 254		if (len > type_max(loff_t) || *pos < 0 ||
   255		    check_add_overflow((loff_t)len, *pos, &requested_length))
   256			return -EINVAL;
   257	
   258		if (requested_length > MAX_MIGRATION_SIZE)
   259			return -ENOMEM;
   260	
   261		mutex_lock(&migf->lock);
   262		if (migf->disabled) {
   263			done = -ENODEV;
   264			goto out_unlock;
   265		}
   266	
   267		if (migf->allocated_length < requested_length) {
   268			done = mlx5vf_add_migration_pages(
   269				migf,
   270				DIV_ROUND_UP(requested_length - migf->allocated_length,
   271					     PAGE_SIZE));
   272			if (done)
   273				goto out_unlock;
   274		}
   275	
   276		while (len) {
   277			size_t page_offset;
   278			struct page *page;
   279			size_t page_len;
   280			u8 *to_buff;
   281			int ret;
   282	
   283			page_offset = (*pos) % PAGE_SIZE;
   284			page = mlx5vf_get_migration_page(migf, *pos - page_offset);
   285			if (!page) {
   286				if (done == 0)
   287					done = -EINVAL;
   288				goto out_unlock;
   289			}
   290	
   291			page_len = min_t(size_t, len, PAGE_SIZE - page_offset);
   292			to_buff = kmap_local_page(page);
   293			ret = copy_from_user(to_buff + page_offset, buf, page_len);
   294			kunmap_local(to_buff);
   295			if (ret) {
   296				done = -EFAULT;
   297				goto out_unlock;
   298			}
   299			*pos += page_len;
   300			len -= page_len;
   301			done += page_len;
   302			buf += page_len;
   303			migf->total_length += page_len;
   304		}
   305	out_unlock:
   306		mutex_unlock(&migf->lock);
   307		return done;
   308	}
   309	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
