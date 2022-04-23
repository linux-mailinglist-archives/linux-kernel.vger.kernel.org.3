Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FAC550C5F7
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Apr 2022 03:15:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231500AbiDWBSd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 21:18:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229941AbiDWBSa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 21:18:30 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEE9257B0D
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 18:15:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650676535; x=1682212535;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=kAE4EkRynMmHZuZVooQDcnPKLK4VaZhgzbo6HL5JbxM=;
  b=hr/lIP54sf5OY8WINf67Jn06wC6IARwUWojEtUxUES4gi9iALk/g9Try
   kE3fZBblVIfC3QhaJqJIn6dcceO/eup3pBp80UqgzV0X+9f4knJ7HN6WP
   WDeF4fQL27mkG4TLHnvntKiKqG/shwjxnDvcWpyi2zhd9+RhQtFAwD8Sb
   ctO51h45VK8WUl0NsjWDuUqnzko36YEDLkrRk0nt4sf2eSihdO/c6BOLc
   T3KN0Dklh7edG7l31GKb4a8JNFRHSZPwvAZqnCfcJj/d2glVnakbDJPn1
   MGp20AQnHQ3DZPx6z+NxyR6RrpBJTKZTdHHOnxZbNEB0WQNKDRM8a7fg2
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10324"; a="327740393"
X-IronPort-AV: E=Sophos;i="5.90,283,1643702400"; 
   d="scan'208";a="327740393"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2022 18:15:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,283,1643702400"; 
   d="scan'208";a="806229938"
Received: from lkp-server01.sh.intel.com (HELO 3abc53900bec) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 22 Apr 2022 18:15:34 -0700
Received: from kbuild by 3abc53900bec with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1ni4N3-000AlG-Ej;
        Sat, 23 Apr 2022 01:15:33 +0000
Date:   Sat, 23 Apr 2022 09:14:48 +0800
From:   kernel test robot <lkp@intel.com>
To:     David Howells <dhowells@redhat.com>
Cc:     kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org
Subject: [ammarfaizi2-block:dhowells/linux-fs/netfs-maple 26/44]
 include/linux/fscache.h:540: undefined reference to
 `__fscache_begin_write_operation'
Message-ID: <202204230943.UBa5uRYJ-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ammarfaizi2/linux-block dhowells/linux-fs/netfs-maple
head:   931e50676c6598d0eda1954ead465519ff91874d
commit: 1cdfbd29bdd34acf57d11846369b44dbab7b4d3a [26/44] netfs: Dispatch write requests to process a writeback slice
config: microblaze-randconfig-r006-20220422 (https://download.01.org/0day-ci/archive/20220423/202204230943.UBa5uRYJ-lkp@intel.com/config)
compiler: microblaze-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/ammarfaizi2/linux-block/commit/1cdfbd29bdd34acf57d11846369b44dbab7b4d3a
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block dhowells/linux-fs/netfs-maple
        git checkout 1cdfbd29bdd34acf57d11846369b44dbab7b4d3a
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross W=1 O=build_dir ARCH=microblaze SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   microblaze-linux-ld: fs/netfs/output.o: in function `fscache_begin_write_operation':
>> include/linux/fscache.h:540: undefined reference to `__fscache_begin_write_operation'


vim +540 include/linux/fscache.h

9af1c6c3089b29 David Howells 2021-10-20  516  
16f2f4e679cfda David Howells 2021-08-27  517  /**
16f2f4e679cfda David Howells 2021-08-27  518   * fscache_begin_write_operation - Begin a write operation for the netfs lib
16f2f4e679cfda David Howells 2021-08-27  519   * @cres: The cache resources for the write being performed
16f2f4e679cfda David Howells 2021-08-27  520   * @cookie: The cookie representing the cache object
16f2f4e679cfda David Howells 2021-08-27  521   *
16f2f4e679cfda David Howells 2021-08-27  522   * Begin a write operation on behalf of the netfs helper library.  @cres
16f2f4e679cfda David Howells 2021-08-27  523   * indicates the cache resources to which the operation state should be
16f2f4e679cfda David Howells 2021-08-27  524   * attached; @cookie indicates the cache object that will be accessed.
16f2f4e679cfda David Howells 2021-08-27  525   *
16f2f4e679cfda David Howells 2021-08-27  526   * @cres->inval_counter is set from @cookie->inval_counter for comparison at
16f2f4e679cfda David Howells 2021-08-27  527   * the end of the operation.  This allows invalidation during the operation to
16f2f4e679cfda David Howells 2021-08-27  528   * be detected by the caller.
16f2f4e679cfda David Howells 2021-08-27  529   *
16f2f4e679cfda David Howells 2021-08-27  530   * Returns:
16f2f4e679cfda David Howells 2021-08-27  531   * * 0		- Success
16f2f4e679cfda David Howells 2021-08-27  532   * * -ENOBUFS	- No caching available
16f2f4e679cfda David Howells 2021-08-27  533   * * Other error code from the cache, such as -ENOMEM.
16f2f4e679cfda David Howells 2021-08-27  534   */
16f2f4e679cfda David Howells 2021-08-27  535  static inline
16f2f4e679cfda David Howells 2021-08-27  536  int fscache_begin_write_operation(struct netfs_cache_resources *cres,
16f2f4e679cfda David Howells 2021-08-27  537  				  struct fscache_cookie *cookie)
16f2f4e679cfda David Howells 2021-08-27  538  {
16f2f4e679cfda David Howells 2021-08-27  539  	if (fscache_cookie_enabled(cookie))
16f2f4e679cfda David Howells 2021-08-27 @540  		return __fscache_begin_write_operation(cres, cookie);
16f2f4e679cfda David Howells 2021-08-27  541  	return -ENOBUFS;
16f2f4e679cfda David Howells 2021-08-27  542  }
16f2f4e679cfda David Howells 2021-08-27  543  

:::::: The code at line 540 was first introduced by commit
:::::: 16f2f4e679cfdaa9552574484f104014908a76c6 nfs: Implement cache I/O by accessing the cache directly

:::::: TO: David Howells <dhowells@redhat.com>
:::::: CC: David Howells <dhowells@redhat.com>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
