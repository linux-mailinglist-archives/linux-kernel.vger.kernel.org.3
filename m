Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E2EA574A2F
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 12:12:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238125AbiGNKMO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 06:12:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231163AbiGNKML (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 06:12:11 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B2FB4E85F
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 03:12:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657793530; x=1689329530;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=JQlJDKssteaPZeUYsjfBApzNCdJz+y8Krml4yEAslSU=;
  b=kX7uaZE031mCUE1GX9lgLTL5NVzUvLAwCBLdwx67kDATWr1Q5s4wE0NH
   +R4IfQKHbd0SkTVsevTFItYW013Fy+NFGtzHjfx+Pmnn51XNO+5ecyr5r
   B6QQBRPpRSvejTrKKMnYqdeYx9mX7m92Wr4uh5lmcHEmv8xXmb2TByxeg
   72pYqdGktnbNpvZJG/tXXtTAoB+V5tvPM102ixIvI+2ZdqSB+ktXjP8y4
   jT4Va3eO1e5zemjtg9VAnNWb0l7fvept3x1dkky/rAGkK7gtzN+0oiJkA
   0oslnYKllRjIH2a0aG4kHc9RDLMfubUoH8TwngW0M7mLudIUdfdHy0y8k
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10407"; a="347153582"
X-IronPort-AV: E=Sophos;i="5.92,269,1650956400"; 
   d="scan'208";a="347153582"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2022 03:12:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,269,1650956400"; 
   d="scan'208";a="546215061"
Received: from lkp-server01.sh.intel.com (HELO fd2c14d642b4) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 14 Jul 2022 03:12:08 -0700
Received: from kbuild by fd2c14d642b4 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1oBvpH-0000Qx-TY;
        Thu, 14 Jul 2022 10:12:07 +0000
Date:   Thu, 14 Jul 2022 18:11:09 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Jason A. Donenfeld" <zx2c4@kernel.org>
Cc:     kbuild-all@lists.01.org, build@wireguard.com,
        linux-kernel@vger.kernel.org
Subject: [zx2c4-wireguard:jd/new-archs 3/9] arch/um/drivers/tty.c:26:24:
 error: 'NULL' undeclared
Message-ID: <202207141802.1bmhOfxR-lkp@intel.com>
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

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/zx2c4/wireguard-linux.git jd/new-archs
head:   b41a21fc924011fb4c7463c8b7b4761dc798e795
commit: 2c1370ee8e1c862e1de8c624d7900d575a131150 [3/9] um: include sys/types.h instead of stddef.h for size_t
config: um-i386_defconfig (https://download.01.org/0day-ci/archive/20220714/202207141802.1bmhOfxR-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-3) 11.3.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/zx2c4/wireguard-linux.git/commit/?id=2c1370ee8e1c862e1de8c624d7900d575a131150
        git remote add zx2c4-wireguard https://git.kernel.org/pub/scm/linux/kernel/git/zx2c4/wireguard-linux.git
        git fetch --no-tags zx2c4-wireguard jd/new-archs
        git checkout 2c1370ee8e1c862e1de8c624d7900d575a131150
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=um SUBARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   arch/um/drivers/tty.c: In function 'tty_chan_init':
>> arch/um/drivers/tty.c:26:24: error: 'NULL' undeclared (first use in this function)
      26 |                 return NULL;
         |                        ^~~~
   arch/um/drivers/tty.c:12:1: note: 'NULL' is defined in header '<stddef.h>'; did you forget to '#include <stddef.h>'?
      11 | #include <um_malloc.h>
     +++ |+#include <stddef.h>
      12 | 
   arch/um/drivers/tty.c:26:24: note: each undeclared identifier is reported only once for each function it appears in
      26 |                 return NULL;
         |                        ^~~~
--
   arch/um/drivers/cow_user.c: In function 'read_cow_header':
>> arch/um/drivers/cow_user.c:296:17: error: implicit declaration of function 'offsetof' [-Werror=implicit-function-declaration]
     296 |         if (n < offsetof(typeof(header->v1), backing_file)) {
         |                 ^~~~~~~~
   arch/um/drivers/cow_user.c:17:1: note: 'offsetof' is defined in header '<stddef.h>'; did you forget to '#include <stddef.h>'?
      16 | #include "cow_sys.h"
     +++ |+#include <stddef.h>
      17 | 
>> arch/um/drivers/cow_user.c:296:26: error: expected expression before 'typeof'
     296 |         if (n < offsetof(typeof(header->v1), backing_file)) {
         |                          ^~~~~~
   cc1: some warnings being treated as errors


vim +/NULL +26 arch/um/drivers/tty.c

^1da177e4c3f415 Linus Torvalds 2005-04-16  18  
5e7672ec3f059f7 Jeff Dike      2006-09-27  19  static void *tty_chan_init(char *str, int device, const struct chan_opts *opts)
^1da177e4c3f415 Linus Torvalds 2005-04-16  20  {
^1da177e4c3f415 Linus Torvalds 2005-04-16  21  	struct tty_chan *data;
^1da177e4c3f415 Linus Torvalds 2005-04-16  22  
^1da177e4c3f415 Linus Torvalds 2005-04-16  23  	if (*str != ':') {
e99525f97069004 Jeff Dike      2007-10-16  24  		printk(UM_KERN_ERR "tty_init : channel type 'tty' must specify "
^1da177e4c3f415 Linus Torvalds 2005-04-16  25  		       "a device\n");
108ffa8cbfa323d Jeff Dike      2006-07-10 @26  		return NULL;
^1da177e4c3f415 Linus Torvalds 2005-04-16  27  	}
^1da177e4c3f415 Linus Torvalds 2005-04-16  28  	str++;
^1da177e4c3f415 Linus Torvalds 2005-04-16  29  
43f5b3085fdd27c Jeff Dike      2008-05-12  30  	data = uml_kmalloc(sizeof(*data), UM_GFP_KERNEL);
^1da177e4c3f415 Linus Torvalds 2005-04-16  31  	if (data == NULL)
108ffa8cbfa323d Jeff Dike      2006-07-10  32  		return NULL;
^1da177e4c3f415 Linus Torvalds 2005-04-16  33  	*data = ((struct tty_chan) { .dev 	= str,
^1da177e4c3f415 Linus Torvalds 2005-04-16  34  				     .raw 	= opts->raw });
^1da177e4c3f415 Linus Torvalds 2005-04-16  35  
108ffa8cbfa323d Jeff Dike      2006-07-10  36  	return data;
^1da177e4c3f415 Linus Torvalds 2005-04-16  37  }
^1da177e4c3f415 Linus Torvalds 2005-04-16  38  

:::::: The code at line 26 was first introduced by commit
:::::: 108ffa8cbfa323d462a2f4b49f38da3205d36e5a [PATCH] uml: formatting fixes

:::::: TO: Jeff Dike <jdike@addtoit.com>
:::::: CC: Linus Torvalds <torvalds@g5.osdl.org>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
