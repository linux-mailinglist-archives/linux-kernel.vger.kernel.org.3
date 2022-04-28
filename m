Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A83AE512FA9
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 11:47:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345475AbiD1JbY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 05:31:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347239AbiD1Jad (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 05:30:33 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AE587C16B
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 02:27:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651138039; x=1682674039;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=BL7FbK1nu3gA7P1M1qIu9/gKr1VPvrt+sdkc/scSC5c=;
  b=QZ+8TZxFwfw1LELQb5IqRxMqlPCzG+xWDXvxPOA6ukeI6x3yuFY8gIai
   lvnj41bHmHO6+w7+t3AvD/8N+58x37wRVJ138C2yZ1zI5Xfv/QRsv6Twk
   SUprTzkv2hO1XJMzVnKyVNOjl8bqsiQS9XqPFF7IYc0rBlHbwXg98Hpgi
   Hrx9/MtRfkQlyFAjJTVD5d2ZHsKE6QS5p+zX0tTuFDcgF3yU0ngukAfQs
   hM/v4t93yI45ItUaoZD2XrNQfFgopsxeZxIZRrxlqyOXocWDbbDqayhIe
   mwbq7s2yOrFt2XIH1PgCRtQ8TNV0GIdXQ2/yFajjGMvHx1tjQrV5sCTYG
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10330"; a="253601392"
X-IronPort-AV: E=Sophos;i="5.90,295,1643702400"; 
   d="scan'208";a="253601392"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2022 02:27:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,295,1643702400"; 
   d="scan'208";a="651141431"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 28 Apr 2022 02:27:17 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nk0Qe-0005Ex-Hy;
        Thu, 28 Apr 2022 09:27:16 +0000
Date:   Thu, 28 Apr 2022 17:27:02 +0800
From:   kernel test robot <lkp@intel.com>
To:     David Howells <dhowells@redhat.com>
Cc:     kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org
Subject: [ammarfaizi2-block:dhowells/linux-fs/netfs-linked-list 39/45]
 fs/netfs/buffered_write.c:669:13: sparse: sparse: incorrect type in
 assignment (different base types)
Message-ID: <202204281739.ZRJW1o8Z-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ammarfaizi2/linux-block dhowells/linux-fs/netfs-linked-list
head:   a20ca5707a9b524115f5ded439fed1f8e552dd6b
commit: 95f517db4cb2fbcfdabe76d0be06d75746958b0b [39/45] netfs: Allow buffered shared-writeable mmap through netfs_page_mkwrite()
config: s390-randconfig-s032-20220428 (https://download.01.org/0day-ci/archive/20220428/202204281739.ZRJW1o8Z-lkp@intel.com/config)
compiler: s390-linux-gcc (GCC) 11.3.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://github.com/ammarfaizi2/linux-block/commit/95f517db4cb2fbcfdabe76d0be06d75746958b0b
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block dhowells/linux-fs/netfs-linked-list
        git checkout 95f517db4cb2fbcfdabe76d0be06d75746958b0b
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=s390 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
>> fs/netfs/buffered_write.c:669:13: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted vm_fault_t [usertype] ret @@     got int @@
   fs/netfs/buffered_write.c:669:13: sparse:     expected restricted vm_fault_t [usertype] ret
   fs/netfs/buffered_write.c:669:13: sparse:     got int
>> fs/netfs/buffered_write.c:670:13: sparse: sparse: restricted vm_fault_t degrades to integer

vim +669 fs/netfs/buffered_write.c

   640	
   641	/*
   642	 * Notification that a previously read-only page is about to become writable.
   643	 * Note that the caller indicates a single page of a multipage folio.
   644	 */
   645	vm_fault_t netfs_page_mkwrite(struct vm_fault *vmf)
   646	{
   647		struct netfs_dirty_region *region;
   648		struct folio *folio = page_folio(vmf->page);
   649		struct file *file = vmf->vma->vm_file;
   650		struct inode *inode = file_inode(file);
   651		struct netfs_i_context *ctx = netfs_i_context(inode);
   652		vm_fault_t ret = VM_FAULT_RETRY;
   653		int err;
   654		LIST_HEAD(spare_regions);
   655	
   656		_enter("%lx", folio->index);
   657	
   658		if (ctx->ops->validate_for_write(inode, file) < 0)
   659			return VM_FAULT_SIGBUS;
   660	
   661		sb_start_pagefault(inode->i_sb);
   662	
   663		if (folio_wait_writeback_killable(folio))
   664			goto out;
   665	
   666		if (folio_lock_killable(folio) < 0)
   667			goto out;
   668	
 > 669		ret = netfs_preallocate_regions(&spare_regions);
 > 670		if (ret < 0) {

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
