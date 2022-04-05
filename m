Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F7FA4F4C8C
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 03:19:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1578759AbiDEXYy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 19:24:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1457096AbiDEQCo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 12:02:44 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F5A1F1AC9
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 08:28:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649172497; x=1680708497;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=TpDgxiyjCBQHjpm+3j7YA+Szlh4kAXMuzZRE+lz2Y/k=;
  b=gSLsK0e8woyJWJ7Tnmeojzs1kA1y6S4VkKFPjzvQOXl4ahvh0VEL90eW
   4ITq3UcfsDr3UVbuQjoIP5+N7x6KeCSrzSxUVxDwoCTifcckFIalXIHMC
   CcrWStZ7swNsmTSW2gqaH7PO4KASCv1rZLqY/DFDqyO+6JfxqUCd1+tBG
   xQM6xGX8949ctmRPHMrF8a+ofcoZ6QeaKfSZvnWOJJzJo/kUziMpfZPml
   wkQ/alKqqBd21m0TNF53SbnhEVfFFwf0qhAqPE9JrZe0ZuG1OsKkrWPFT
   NanEFBv1EJR0BiNv5qbqijGlh/39IP+EaEMPOSu44aMmtcfiXVTKPA8zZ
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10308"; a="258362208"
X-IronPort-AV: E=Sophos;i="5.90,236,1643702400"; 
   d="scan'208";a="258362208"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2022 08:28:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,236,1643702400"; 
   d="scan'208";a="549098652"
Received: from lkp-server02.sh.intel.com (HELO a44fdfb70b94) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 05 Apr 2022 08:28:15 -0700
Received: from kbuild by a44fdfb70b94 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nbl6M-0003Tr-CB;
        Tue, 05 Apr 2022 15:28:14 +0000
Date:   Tue, 5 Apr 2022 23:28:10 +0800
From:   kernel test robot <lkp@intel.com>
To:     David Howells <dhowells@redhat.com>
Cc:     kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org
Subject: [ammarfaizi2-block:dhowells/linux-fs/netfs-maple 24/40]
 include/linux/fscache.h:540: undefined reference to
 `__fscache_begin_write_operation'
Message-ID: <202204052321.Q7Js0HBV-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ammarfaizi2/linux-block dhowells/linux-fs/netfs-maple
head:   674eea41fc70a740ff83ec590f9833f805852464
commit: d77af6a0e73b5e3c4bae01c64df536f2662e2dab [24/40] netfs: Dispatch write requests to process a writeback slice
config: x86_64-rhel-8.3-func (https://download.01.org/0day-ci/archive/20220405/202204052321.Q7Js0HBV-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.2.0-19) 11.2.0
reproduce (this is a W=1 build):
        # https://github.com/ammarfaizi2/linux-block/commit/d77af6a0e73b5e3c4bae01c64df536f2662e2dab
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block dhowells/linux-fs/netfs-maple
        git checkout d77af6a0e73b5e3c4bae01c64df536f2662e2dab
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   ld: fs/netfs/output.o: in function `fscache_begin_write_operation':
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
