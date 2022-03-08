Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FC324D20C3
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 19:55:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348071AbiCHSzj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 13:55:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244002AbiCHSzg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 13:55:36 -0500
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 842C931360
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 10:54:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646765679; x=1678301679;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=XikT9LcfOEBTWylAnmX0FzDRFbtIsY7OHfomsC6NN78=;
  b=ERvykGExqc/EYr5JDvbiXB2SJeLOBbPj9wO3gArc/GhJsr6cYFPyx4N/
   e+7VjjKg5Tob71ytz1eeCvoWrbk4sYkbk/6W9l9MhOQvxz2hp32yKv50p
   KqA1q1Onz8zAeAElGDtuOAvC+ZIgmasx5/WtXWXClI8TFwp8ACW3sFFj7
   5k7kz1dMlPiNX6wsYJTVDcMUIQXGgks0JtU0yPGgOJCzA2K5UXtqgnSh0
   kAgn+U6emjnNfxqqs7H/5K0CTmEg+klu1H+h0guj9exzzWR6T/QNSRl8X
   RZUY7dLDoL7rLKrJvy6dBDYnpuPLzqQkOZHNR4GpW0OkUxhAaoaq/jst4
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10280"; a="315500982"
X-IronPort-AV: E=Sophos;i="5.90,165,1643702400"; 
   d="scan'208";a="315500982"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2022 10:54:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,165,1643702400"; 
   d="scan'208";a="814181655"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by fmsmga005.fm.intel.com with ESMTP; 08 Mar 2022 10:54:35 -0800
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nReyh-0001pq-7A; Tue, 08 Mar 2022 18:54:35 +0000
Date:   Wed, 9 Mar 2022 02:54:03 +0800
From:   kernel test robot <lkp@intel.com>
To:     Eugene Zemtsov <ezemtsov@google.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org,
        Paul Lawrence <paullawrence@google.com>
Subject: [ammarfaizi2-block:google/android/kernel/common/android-trusty-5.4
 2532/6879] fs/incfs/data_mgmt.c:790:21: warning: variable 'mi' set but not
 used
Message-ID: <202203090212.bPXFBNNd-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ammarfaizi2/linux-block google/android/kernel/common/android-trusty-5.4
head:   d556bac5a4d65c759ce3c5a7529aef568f05f650
commit: 1be052b20ba04b635cf87bcff80de5314697953e [2532/6879] ANDROID: Initial commit of Incremental FS
config: x86_64-randconfig-c007-20220307 (https://download.01.org/0day-ci/archive/20220309/202203090212.bPXFBNNd-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project d271fc04d5b97b12e6b797c6067d3c96a8d7470e)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/ammarfaizi2/linux-block/commit/1be052b20ba04b635cf87bcff80de5314697953e
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block google/android/kernel/common/android-trusty-5.4
        git checkout 1be052b20ba04b635cf87bcff80de5314697953e
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash arch/x86/xen/ fs/incfs/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> fs/incfs/data_mgmt.c:790:21: warning: variable 'mi' set but not used [-Wunused-but-set-variable]
           struct mount_info *mi = NULL;
                              ^
   1 warning generated.


vim +/mi +790 fs/incfs/data_mgmt.c

   785	
   786	int incfs_process_new_hash_block(struct data_file *df,
   787					 struct incfs_new_data_block *block, u8 *data)
   788	{
   789		struct backing_file_context *bfc = NULL;
 > 790		struct mount_info *mi = NULL;
   791		struct mtree *hash_tree = NULL;
   792		struct ondisk_signature *sig = NULL;
   793		loff_t hash_area_base = 0;
   794		loff_t hash_area_size = 0;
   795		int error = 0;
   796	
   797		if (!df || !block)
   798			return -EFAULT;
   799	
   800		if (!(block->flags & INCFS_BLOCK_FLAGS_HASH))
   801			return -EINVAL;
   802	
   803		bfc = df->df_backing_file_context;
   804		mi = df->df_mount_info;
   805	
   806		if (!df)
   807			return -ENOENT;
   808	
   809		hash_tree = df->df_hash_tree;
   810		sig = df->df_signature;
   811		if (!hash_tree || !sig || sig->mtree_offset == 0)
   812			return -ENOTSUPP;
   813	
   814		hash_area_base = sig->mtree_offset;
   815		hash_area_size = sig->mtree_size;
   816		if (hash_area_size < block->block_index * INCFS_DATA_FILE_BLOCK_SIZE
   817					+ block->data_len) {
   818			/* Hash block goes beyond dedicated hash area of this file. */
   819			return -ERANGE;
   820		}
   821	
   822		error = mutex_lock_interruptible(&bfc->bc_mutex);
   823		if (!error)
   824			error = incfs_write_hash_block_to_backing_file(
   825				bfc, range(data, block->data_len), block->block_index,
   826				hash_area_base);
   827		mutex_unlock(&bfc->bc_mutex);
   828		return error;
   829	}
   830	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
