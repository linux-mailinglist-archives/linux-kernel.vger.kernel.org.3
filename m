Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30D7E4C3F36
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 08:44:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238187AbiBYHoa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 02:44:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229774AbiBYHo3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 02:44:29 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C1991EC9B6
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 23:43:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645775037; x=1677311037;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=DN2p7KxLB5XwxTqu5Cf/PTHocnMkAa+elHEUHPuQ280=;
  b=QLgdD1mjbJuauVUkguR1ucW0YqhLSrShq2Ku+mFfj/EiVjBACYLfPhdI
   UUEIc/3EMhZGQGvQJGk1WYjjBqmRFK1OqWByg4XZLVbBG3JYJKPXCeprv
   Bt45iGixwqZl7q6JJH+GMs8rtjyebZ4i0lq1f2X23DtzHgSmJ0QEstjNp
   +X2n5YtyoFT4T/90IUe9jLzBPK03XvHZR+Xhm1gKh283TVrKMzUaGUL/u
   fUeO7J3gwols4EcHArRVgqKsoAIl6Z24kUmCyGlnI0mDw8nFxcXbcWjs+
   w+w/G1S3uhiPymY5VKSmBljqHDnowfToHHlOa7Q8MMQorLT9HKIceUZMO
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10268"; a="252172741"
X-IronPort-AV: E=Sophos;i="5.90,135,1643702400"; 
   d="scan'208";a="252172741"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2022 23:43:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,135,1643702400"; 
   d="scan'208";a="509188703"
Received: from lkp-server01.sh.intel.com (HELO 788b1cd46f0d) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 24 Feb 2022 23:43:55 -0800
Received: from kbuild by 788b1cd46f0d with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nNVGc-00042T-RI; Fri, 25 Feb 2022 07:43:54 +0000
Date:   Fri, 25 Feb 2022 15:43:11 +0800
From:   kernel test robot <lkp@intel.com>
To:     Dinh Nguyen <dinguyen@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>, Arnd Bergmann <arnd@arndb.de>
Subject: [dinguyen:nios2_for_v5.18 5/6] lib/strncpy_from_user.c:123:13:
 error: implicit declaration of function 'user_addr_max'
Message-ID: <202202251524.ivDzBaPs-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/dinguyen/linux.git nios2_for_v5.18
head:   048b7695b48a3a4523a7a7fbfedc396b40ccf62f
commit: f368e6211f42e086e37dde58d081a86ac033dda3 [5/6] uaccess: generalize access_ok()
config: i386-randconfig-a014 (https://download.01.org/0day-ci/archive/20220225/202202251524.ivDzBaPs-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/dinguyen/linux.git/commit/?id=f368e6211f42e086e37dde58d081a86ac033dda3
        git remote add dinguyen https://git.kernel.org/pub/scm/linux/kernel/git/dinguyen/linux.git
        git fetch --no-tags dinguyen nios2_for_v5.18
        git checkout f368e6211f42e086e37dde58d081a86ac033dda3
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   lib/strncpy_from_user.c: In function 'strncpy_from_user':
>> lib/strncpy_from_user.c:123:13: error: implicit declaration of function 'user_addr_max' [-Werror=implicit-function-declaration]
     123 |  max_addr = user_addr_max();
         |             ^~~~~~~~~~~~~
   cc1: some warnings being treated as errors
--
   lib/strnlen_user.c: In function 'strnlen_user':
>> lib/strnlen_user.c:99:13: error: implicit declaration of function 'user_addr_max' [-Werror=implicit-function-declaration]
      99 |  max_addr = user_addr_max();
         |             ^~~~~~~~~~~~~
   cc1: some warnings being treated as errors


vim +/user_addr_max +123 lib/strncpy_from_user.c

2922585b93294d David S. Miller      2012-05-24   94  
2922585b93294d David S. Miller      2012-05-24   95  /**
2922585b93294d David S. Miller      2012-05-24   96   * strncpy_from_user: - Copy a NUL terminated string from userspace.
2922585b93294d David S. Miller      2012-05-24   97   * @dst:   Destination address, in kernel space.  This buffer must be at
2922585b93294d David S. Miller      2012-05-24   98   *         least @count bytes long.
2922585b93294d David S. Miller      2012-05-24   99   * @src:   Source address, in user space.
2922585b93294d David S. Miller      2012-05-24  100   * @count: Maximum number of bytes to copy, including the trailing NUL.
2922585b93294d David S. Miller      2012-05-24  101   *
2922585b93294d David S. Miller      2012-05-24  102   * Copies a NUL-terminated string from userspace to kernel space.
2922585b93294d David S. Miller      2012-05-24  103   *
2922585b93294d David S. Miller      2012-05-24  104   * On success, returns the length of the string (not including the trailing
2922585b93294d David S. Miller      2012-05-24  105   * NUL).
2922585b93294d David S. Miller      2012-05-24  106   *
2922585b93294d David S. Miller      2012-05-24  107   * If access to userspace fails, returns -EFAULT (some data may have been
2922585b93294d David S. Miller      2012-05-24  108   * copied).
2922585b93294d David S. Miller      2012-05-24  109   *
2922585b93294d David S. Miller      2012-05-24  110   * If @count is smaller than the length of the string, copies @count bytes
2922585b93294d David S. Miller      2012-05-24  111   * and returns @count.
2922585b93294d David S. Miller      2012-05-24  112   */
2922585b93294d David S. Miller      2012-05-24  113  long strncpy_from_user(char *dst, const char __user *src, long count)
2922585b93294d David S. Miller      2012-05-24  114  {
2922585b93294d David S. Miller      2012-05-24  115  	unsigned long max_addr, src_addr;
2922585b93294d David S. Miller      2012-05-24  116  
07887358993d48 KP Singh             2020-06-04  117  	might_fault();
4d0e9df5e43dba Albert van der Linde 2020-10-15  118  	if (should_fail_usercopy())
4d0e9df5e43dba Albert van der Linde 2020-10-15  119  		return -EFAULT;
2922585b93294d David S. Miller      2012-05-24  120  	if (unlikely(count <= 0))
2922585b93294d David S. Miller      2012-05-24  121  		return 0;
2922585b93294d David S. Miller      2012-05-24  122  
2922585b93294d David S. Miller      2012-05-24 @123  	max_addr = user_addr_max();

:::::: The code at line 123 was first introduced by commit
:::::: 2922585b93294d47172a765115e0dbc1bfe1be19 lib: Sparc's strncpy_from_user is generic enough, move under lib/

:::::: TO: David S. Miller <davem@davemloft.net>
:::::: CC: David S. Miller <davem@davemloft.net>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
