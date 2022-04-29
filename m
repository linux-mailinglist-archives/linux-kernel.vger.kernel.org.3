Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95EC55158A6
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Apr 2022 00:45:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381611AbiD2Wss (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 18:48:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381606AbiD2Wsp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 18:48:45 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 222F533883
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 15:45:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651272326; x=1682808326;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=h45R2rWnTKQnbs+ZcQAZolum42G1Y2PIHBnkk0SVkLw=;
  b=XKxYxj1YnMopn4tDodO6xuvn2e4fxj+91DM/x/ZpnbWSJ5p91LVEixUj
   cdoadWCRV/GoG4o7Ug69JVk56KOY23/4FjeGN/6Al6a90Ujst8cDKOfwK
   uDCKISDVztbWcbNGdPKLivzhTHRFyrzws8qTF7GbEnTFl/M/nHmD5TKFS
   CPHgV17d//F1EKREarQaZWYzeKS4+DyHdPh1cOQMlsV9v5Ej/yKtz8FyW
   LIOLgxQvrcAhQbv+wT0B5F+ynDZRdtKOKwJ38PSuQn55+tNluMV7JAq41
   rQedIt/BGxFQvOklJm+UZOMDZZFnF915lXo+rQILSAig21UHJzo+BQYPl
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10332"; a="353221197"
X-IronPort-AV: E=Sophos;i="5.91,186,1647327600"; 
   d="scan'208";a="353221197"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2022 15:45:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,186,1647327600"; 
   d="scan'208";a="651955956"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 29 Apr 2022 15:45:24 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nkZMZ-0006eZ-L4;
        Fri, 29 Apr 2022 22:45:23 +0000
Date:   Sat, 30 Apr 2022 06:44:46 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ioannis Angelakopoulos <iangelak@redhat.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [rhvgoyal:ioannis-fanotify 11/18] fs/fuse/dir.c:1904:21: error:
 'struct inode' has no member named 'i_fsnotify_mask'
Message-ID: <202204300631.E5yUzmoT-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/rhvgoyal/linux ioannis-fanotify
head:   10887e7003a6a801e521d59daff76f0c035f061f
commit: 834efb94978e62da824c5f4cde878fe592c2426d [11/18] FUSE, VFS: Add the fuse_fsnotify_update_mark inode operation
config: arc-randconfig-r043-20220428 (https://download.01.org/0day-ci/archive/20220430/202204300631.E5yUzmoT-lkp@intel.com/config)
compiler: arceb-elf-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/rhvgoyal/linux/commit/834efb94978e62da824c5f4cde878fe592c2426d
        git remote add rhvgoyal https://github.com/rhvgoyal/linux
        git fetch --no-tags rhvgoyal ioannis-fanotify
        git checkout 834efb94978e62da824c5f4cde878fe592c2426d
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=arc SHELL=/bin/bash fs/fuse/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   fs/fuse/dir.c: In function 'fuse_fsnotify_update_mark':
>> fs/fuse/dir.c:1904:21: error: 'struct inode' has no member named 'i_fsnotify_mask'
    1904 |         mask = inode->i_fsnotify_mask & ~(FS_IN_IGNORED | FS_UNMOUNT |
         |                     ^~
   fs/fuse/dir.c:1911:107: warning: left-hand operand of comma expression has no effect [-Wunused-value]
    1911 |                                                                                                 FS_UNMOUNT, FS_IN_IGNORED,
         |                                                                                                           ^
   fs/fuse/dir.c:1911:122: warning: left-hand operand of comma expression has no effect [-Wunused-value]
    1911 |                                                                                                 FS_UNMOUNT, FS_IN_IGNORED,
         |                                                                                                                          ^
   fs/fuse/dir.c:1916:16: error: implicit declaration of function 'fuse_fsnotify_send_request' [-Werror=implicit-function-declaration]
    1916 |         return fuse_fsnotify_send_request(inode, mask);
         |                ^~~~~~~~~~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors


vim +1904 fs/fuse/dir.c

  1892	
  1893	static int fuse_fsnotify_update_mark(struct inode *inode)
  1894	{
  1895		uint64_t mask;
  1896		/*
  1897		 * We have to remove the bits added to the mask before being attached
  1898		 * or detached to the inode, since these bits are going to be
  1899		 * added by the "remote" host kernel. If these bits were still enabled
  1900		 * in the mask that was sent to the "remote" kernel then the watch would
  1901		 * be rejected as an unsupported value. These bits are added by the
  1902		 * fsnotify subsystem thus we use the corresponding fsnotify bits here.
  1903		 */
> 1904		mask = inode->i_fsnotify_mask & ~(FS_IN_IGNORED | FS_UNMOUNT |
  1905										  FS_IN_ONESHOT | FS_EXCL_UNLINK);
  1906	
  1907		if (!inode)
  1908			return -EINVAL;
  1909	
  1910		if (mask && !(mask & ALL_FSNOTIFY_EVENTS & ~(ALL_FSNOTIFY_DIRENT_EVENTS |
  1911													FS_UNMOUNT, FS_IN_IGNORED,
  1912													FS_ERROR)))
  1913			return -EINVAL;
  1914	
  1915		/* Send the inode and the aggregated mask for the inode*/
  1916		return fuse_fsnotify_send_request(inode, mask);
  1917	}
  1918	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
