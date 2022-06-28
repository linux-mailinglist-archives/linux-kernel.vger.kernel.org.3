Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C605655F051
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 23:28:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231240AbiF1V1j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 17:27:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230235AbiF1V1i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 17:27:38 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C87563AA6B
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 14:27:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656451656; x=1687987656;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=ht6RD7xZRlXcB57Cb+O3uq7WqxJf7H0Y7TRitceJP38=;
  b=GUBxMUlbLIvGIgYntpGajOIjvt4AfEkChsbTBdFm/ecYh9ehs83yQVwU
   iwS2amk5J1BX0W4a3c/CY9iCfzT3Gkn3Iup6J+sKajB7Cy5EPkTPbqVEf
   XpgzSYb2aGas7pX5WL0h1lpRrtG1WwJCUVzua349ZZZdzEGpXNfY1P2cv
   AR1QbQSGVNP3Dxi4ijvJkgNSWxuN/F7H8bJ6TBeiEnAxRNctRjBxvd6y5
   JGY5tg1S/rCa4GOoHwGHSdkQAirvJwWs1siNiGhBFLa35DxB0y6iYjJI/
   d5vYSw7OADSq9OR2xyEqLBsEMOghiF8Fy7FzP+dAELaf/ha0JCL+oiYEG
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10392"; a="281887313"
X-IronPort-AV: E=Sophos;i="5.92,229,1650956400"; 
   d="scan'208";a="281887313"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2022 14:27:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,229,1650956400"; 
   d="scan'208";a="594954574"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 28 Jun 2022 14:27:35 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o6IkA-000Ae2-NT;
        Tue, 28 Jun 2022 21:27:34 +0000
Date:   Wed, 29 Jun 2022 05:27:11 +0800
From:   kernel test robot <lkp@intel.com>
To:     David Howells <dhowells@redhat.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Jeff Layton <jlayton@kernel.org>
Subject: [jlayton:netfs-linked-list 5/54] fs/afs/inode.c:856:43: error:
 passing argument 1 of 'netfs_resize_file' from incompatible pointer type
Message-ID: <202206290541.3FJEiknk-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/jlayton/linux.git netfs-linked-list
head:   d35a2461e039c9131e97bb125eac59a0f04e9161
commit: a65715e19870a21d17796d337cac4d41326feaad [5/54] netfs: Track the fpos above which the server has no data
config: i386-allyesconfig (https://download.01.org/0day-ci/archive/20220629/202206290541.3FJEiknk-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-3) 11.3.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/jlayton/linux.git/commit/?id=a65715e19870a21d17796d337cac4d41326feaad
        git remote add jlayton https://git.kernel.org/pub/scm/linux/kernel/git/jlayton/linux.git
        git fetch --no-tags jlayton netfs-linked-list
        git checkout a65715e19870a21d17796d337cac4d41326feaad
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   fs/afs/inode.c: In function 'afs_setattr_edit_file':
>> fs/afs/inode.c:856:43: error: passing argument 1 of 'netfs_resize_file' from incompatible pointer type [-Werror=incompatible-pointer-types]
     856 |                         netfs_resize_file(inode, size);
         |                                           ^~~~~
         |                                           |
         |                                           struct inode *
   In file included from include/linux/fscache.h:18,
                    from fs/afs/internal.h:17,
                    from fs/afs/inode.c:25:
   include/linux/netfs.h:338:58: note: expected 'struct netfs_inode *' but argument is of type 'struct inode *'
     338 | static inline void netfs_resize_file(struct netfs_inode *ctx, loff_t new_i_size)
         |                                      ~~~~~~~~~~~~~~~~~~~~^~~
   cc1: some warnings being treated as errors


vim +/netfs_resize_file +856 fs/afs/inode.c

   844	
   845	static void afs_setattr_edit_file(struct afs_operation *op)
   846	{
   847		struct afs_vnode_param *vp = &op->file[0];
   848		struct inode *inode = &vp->vnode->netfs.inode;
   849	
   850		if (op->setattr.attr->ia_valid & ATTR_SIZE) {
   851			loff_t size = op->setattr.attr->ia_size;
   852			loff_t i_size = op->setattr.old_i_size;
   853	
   854			if (size != i_size) {
   855				truncate_pagecache(inode, size);
 > 856				netfs_resize_file(inode, size);
   857				fscache_resize_cookie(afs_vnode_cache(vp->vnode), size);
   858			}
   859		}
   860	}
   861	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
