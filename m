Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AD854DD4E4
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 07:51:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232813AbiCRGvZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 02:51:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231588AbiCRGvW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 02:51:22 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D862217584A
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 23:50:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647586202; x=1679122202;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=zew9kCyUCa+y6nwOuAeL3Q1B6zPPFWtdmSxcGJ6ON4c=;
  b=ltptRBtuxJEIhMqC+qzvHAR3x1iya0kXJKe+Koxyc4fVWE4DsxXsv1nk
   Iqs0QHlnV52Rn+3MTwmMyylHfasICcMNNA5zvYc5u1yUEozvZPxWalKbb
   64sr9aoZO6E7qPXy4qGFEjngkS3vjQu7DDELXhb2B0GvdG7MeG+0SO3G+
   kYja2C2swiK3f6locQjJUnPhsdVjRfJF5SljeG5GFEZtuRams9B3fAj1z
   IABkvcGI5Sky0pE3UZ8rHeU5JcW93rgf87NAM2KntCQ29obLGbsn+EcCQ
   /a1Z8qY94sq8iFCZuG9YsRg0zMruD48gXDvfLXvIQYctONFMNfHoESTyF
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10289"; a="256799051"
X-IronPort-AV: E=Sophos;i="5.90,191,1643702400"; 
   d="scan'208";a="256799051"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2022 23:50:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,191,1643702400"; 
   d="scan'208";a="517076875"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 17 Mar 2022 23:50:00 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nV6Qy-000EUQ-4N; Fri, 18 Mar 2022 06:50:00 +0000
Date:   Fri, 18 Mar 2022 14:49:24 +0800
From:   kernel test robot <lkp@intel.com>
To:     Dave Wysochanski <dwysocha@redhat.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Trond Myklebust <trond.myklebust@hammerspace.com>
Subject: [trondmy-nfs-2.6:testing 52/72] fs/nfs/fscache.c:231:71: error:
 'nfsi' undeclared
Message-ID: <202203181425.lKRZyrao-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://git.linux-nfs.org/projects/trondmy/nfs-2.6.git testing
head:   2fd93b6b58106aa3bc5a70739ba0f86cfee8fda9
commit: 45f3a70ba68e1fc7fe0edde731b08d85435da30d [52/72] NFS: Cleanup usage of nfs_inode in fscache interface
config: arm-allmodconfig (https://download.01.org/0day-ci/archive/20220318/202203181425.lKRZyrao-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git remote add trondmy-nfs-2.6 git://git.linux-nfs.org/projects/trondmy/nfs-2.6.git
        git fetch --no-tags trondmy-nfs-2.6 testing
        git checkout 45f3a70ba68e1fc7fe0edde731b08d85435da30d
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arm SHELL=/bin/bash fs/nfs/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

Note: the trondmy-nfs-2.6/testing HEAD 2fd93b6b58106aa3bc5a70739ba0f86cfee8fda9 builds fine.
      It only hurts bisectability.

All errors (new ones prefixed by >>):

   In file included from include/linux/kernel.h:29,
                    from fs/nfs/fscache.c:9:
   fs/nfs/fscache.c: In function 'nfs_fscache_open_file':
>> fs/nfs/fscache.c:231:71: error: 'nfsi' undeclared (first use in this function)
     231 |                 dfprintk(FSCACHE, "NFS: nfsi 0x%p disabling cache\n", nfsi);
         |                                                                       ^~~~
   include/linux/printk.h:418:33: note: in definition of macro 'printk_index_wrap'
     418 |                 _p_func(_fmt, ##__VA_ARGS__);                           \
         |                                 ^~~~~~~~~~~
   include/linux/sunrpc/debug.h:40:17: note: in expansion of macro 'printk'
      40 |                 printk(KERN_DEFAULT fmt, ##__VA_ARGS__);                \
         |                 ^~~~~~
   fs/nfs/fscache.c:231:17: note: in expansion of macro 'dfprintk'
     231 |                 dfprintk(FSCACHE, "NFS: nfsi 0x%p disabling cache\n", nfsi);
         |                 ^~~~~~~~
   fs/nfs/fscache.c:231:71: note: each undeclared identifier is reported only once for each function it appears in
     231 |                 dfprintk(FSCACHE, "NFS: nfsi 0x%p disabling cache\n", nfsi);
         |                                                                       ^~~~
   include/linux/printk.h:418:33: note: in definition of macro 'printk_index_wrap'
     418 |                 _p_func(_fmt, ##__VA_ARGS__);                           \
         |                                 ^~~~~~~~~~~
   include/linux/sunrpc/debug.h:40:17: note: in expansion of macro 'printk'
      40 |                 printk(KERN_DEFAULT fmt, ##__VA_ARGS__);                \
         |                 ^~~~~~
   fs/nfs/fscache.c:231:17: note: in expansion of macro 'dfprintk'
     231 |                 dfprintk(FSCACHE, "NFS: nfsi 0x%p disabling cache\n", nfsi);
         |                 ^~~~~~~~


vim +/nfsi +231 fs/nfs/fscache.c

ef79c097bbe9724 David Howells    2009-04-03  200  
ef79c097bbe9724 David Howells    2009-04-03  201  /*
f1fe29b4a02d080 David Howells    2013-09-27  202   * Enable or disable caching for a file that is being opened as appropriate.
f1fe29b4a02d080 David Howells    2013-09-27  203   * The cookie is allocated when the inode is initialised, but is not enabled at
f1fe29b4a02d080 David Howells    2013-09-27  204   * that time.  Enablement is deferred to file-open time to avoid stat() and
f1fe29b4a02d080 David Howells    2013-09-27  205   * access() thrashing the cache.
f1fe29b4a02d080 David Howells    2013-09-27  206   *
f1fe29b4a02d080 David Howells    2013-09-27  207   * For now, with NFS, only regular files that are open read-only will be able
ef79c097bbe9724 David Howells    2009-04-03  208   * to use the cache.
f1fe29b4a02d080 David Howells    2013-09-27  209   *
f1fe29b4a02d080 David Howells    2013-09-27  210   * We enable the cache for an inode if we open it read-only and it isn't
f1fe29b4a02d080 David Howells    2013-09-27  211   * currently open for writing.  We disable the cache if the inode is open
f1fe29b4a02d080 David Howells    2013-09-27  212   * write-only.
f1fe29b4a02d080 David Howells    2013-09-27  213   *
f1fe29b4a02d080 David Howells    2013-09-27  214   * The caller uses the file struct to pin i_writecount on the inode before
f1fe29b4a02d080 David Howells    2013-09-27  215   * calling us when a file is opened for writing, so we can make use of that.
f1fe29b4a02d080 David Howells    2013-09-27  216   *
f1fe29b4a02d080 David Howells    2013-09-27  217   * Note that this may be invoked multiple times in parallel by parallel
f1fe29b4a02d080 David Howells    2013-09-27  218   * nfs_open() functions.
ef79c097bbe9724 David Howells    2009-04-03  219   */
f1fe29b4a02d080 David Howells    2013-09-27  220  void nfs_fscache_open_file(struct inode *inode, struct file *filp)
ef79c097bbe9724 David Howells    2009-04-03  221  {
402cb8dda949d9b David Howells    2018-04-04  222  	struct nfs_fscache_inode_auxdata auxdata;
f1fe29b4a02d080 David Howells    2013-09-27  223  	struct fscache_cookie *cookie = nfs_i_fscache(inode);
a6b5a28eb56c3f4 Dave Wysochanski 2020-11-14  224  	bool open_for_write = inode_is_open_for_write(inode);
ef79c097bbe9724 David Howells    2009-04-03  225  
f1fe29b4a02d080 David Howells    2013-09-27  226  	if (!fscache_cookie_valid(cookie))
f1fe29b4a02d080 David Howells    2013-09-27  227  		return;
ef79c097bbe9724 David Howells    2009-04-03  228  
a6b5a28eb56c3f4 Dave Wysochanski 2020-11-14  229  	fscache_use_cookie(cookie, open_for_write);
a6b5a28eb56c3f4 Dave Wysochanski 2020-11-14  230  	if (open_for_write) {
f1fe29b4a02d080 David Howells    2013-09-27 @231  		dfprintk(FSCACHE, "NFS: nfsi 0x%p disabling cache\n", nfsi);
45f3a70ba68e1fc Dave Wysochanski 2022-03-01  232  		nfs_fscache_update_auxdata(&auxdata, inode);
a6b5a28eb56c3f4 Dave Wysochanski 2020-11-14  233  		fscache_invalidate(cookie, &auxdata, i_size_read(inode),
a6b5a28eb56c3f4 Dave Wysochanski 2020-11-14  234  				   FSCACHE_INVAL_DIO_WRITE);
ef79c097bbe9724 David Howells    2009-04-03  235  	}
ef79c097bbe9724 David Howells    2009-04-03  236  }
f1fe29b4a02d080 David Howells    2013-09-27  237  EXPORT_SYMBOL_GPL(nfs_fscache_open_file);
545db45f0fc0d42 David Howells    2009-04-03  238  

:::::: The code at line 231 was first introduced by commit
:::::: f1fe29b4a02d0805aa7d0ff6b73410a9f9316d69 NFS: Use i_writecount to control whether to get an fscache cookie in nfs_open()

:::::: TO: David Howells <dhowells@redhat.com>
:::::: CC: David Howells <dhowells@redhat.com>

---
0-DAY CI Kernel Test Service
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
