Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10887513EF1
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 01:15:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353228AbiD1XRt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 19:17:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229842AbiD1XRr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 19:17:47 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D05DAE54
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 16:14:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651187671; x=1682723671;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Hf5dykjmQnuUkPbIdZrE8Y2gyksGp36/rBPPucB6sFw=;
  b=kFAyrM7J1P6XsAR7/QwNMCdv1U12RkfQM8PM2Z5gVZSw+ovBI9o905Ns
   2kA38eo+k3HKODyOxga/rBigDuEURvX3XATOrWckLbEX2DOQOWcw8Zh3m
   7iINJVW8oJTWcTm7md4vLwf9iyljj8GxAMcX2og2WY4//qJsMKjqo1BXg
   ObhyJ+ctTHvOVfaUkeotjcLS0KFYrl67/WH2QKXZfCcxP7sj2AM7vBLP5
   IW4948QilmYgJi850NUZPlr1dvcjkjn9KY5rD8moqW3zSsgzg8VS7vgs0
   QPA4FtlF2hqKbggFNjSZZ0SmAcUb2zah+Tk5tow4G1j9mu5zei3ZXaIgn
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10331"; a="326949133"
X-IronPort-AV: E=Sophos;i="5.91,296,1647327600"; 
   d="scan'208";a="326949133"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2022 16:14:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,296,1647327600"; 
   d="scan'208";a="534152964"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 28 Apr 2022 16:14:29 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nkDLB-0005l9-01;
        Thu, 28 Apr 2022 23:14:29 +0000
Date:   Fri, 29 Apr 2022 07:14:24 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [kas:lam 6/10] drivers/char/ipmi/ipmi_watchdog.c:776:37: sparse:
 sparse: incorrect type in initializer (different address spaces)
Message-ID: <202204290719.Ro26lojw-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/kas/linux.git lam
head:   956305b67dd062e5a58c68c871dee2ee1d579feb
commit: 2d7493c0421d267a906653b33aca69bf87f0595f [6/10] x86/uaccess: Remove tags from the address before checking
config: x86_64-randconfig-s022 (https://download.01.org/0day-ci/archive/20220429/202204290719.Ro26lojw-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.2.0-20) 11.2.0
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/kas/linux.git/commit/?id=2d7493c0421d267a906653b33aca69bf87f0595f
        git remote add kas https://git.kernel.org/pub/scm/linux/kernel/git/kas/linux.git
        git fetch --no-tags kas lam
        git checkout 2d7493c0421d267a906653b33aca69bf87f0595f
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
>> drivers/char/ipmi/ipmi_watchdog.c:776:37: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected char const [noderef] __user *__ptr_clean @@     got char const * @@
   drivers/char/ipmi/ipmi_watchdog.c:776:37: sparse:     expected char const [noderef] __user *__ptr_clean
   drivers/char/ipmi/ipmi_watchdog.c:776:37: sparse:     got char const *

vim +776 drivers/char/ipmi/ipmi_watchdog.c

55929332c92e5d3 Arnd Bergmann  2010-04-27  758  
^1da177e4c3f415 Linus Torvalds 2005-04-16  759  static ssize_t ipmi_write(struct file *file,
^1da177e4c3f415 Linus Torvalds 2005-04-16  760  			  const char  __user *buf,
^1da177e4c3f415 Linus Torvalds 2005-04-16  761  			  size_t      len,
^1da177e4c3f415 Linus Torvalds 2005-04-16  762  			  loff_t      *ppos)
^1da177e4c3f415 Linus Torvalds 2005-04-16  763  {
^1da177e4c3f415 Linus Torvalds 2005-04-16  764  	int rv;
^1da177e4c3f415 Linus Torvalds 2005-04-16  765  
^1da177e4c3f415 Linus Torvalds 2005-04-16  766  	if (len) {
^1da177e4c3f415 Linus Torvalds 2005-04-16  767  		if (!nowayout) {
^1da177e4c3f415 Linus Torvalds 2005-04-16  768  			size_t i;
^1da177e4c3f415 Linus Torvalds 2005-04-16  769  
^1da177e4c3f415 Linus Torvalds 2005-04-16  770  			/* In case it was set long ago */
^1da177e4c3f415 Linus Torvalds 2005-04-16  771  			expect_close = 0;
^1da177e4c3f415 Linus Torvalds 2005-04-16  772  
^1da177e4c3f415 Linus Torvalds 2005-04-16  773  			for (i = 0; i != len; i++) {
^1da177e4c3f415 Linus Torvalds 2005-04-16  774  				char c;
^1da177e4c3f415 Linus Torvalds 2005-04-16  775  
^1da177e4c3f415 Linus Torvalds 2005-04-16 @776  				if (get_user(c, buf + i))
^1da177e4c3f415 Linus Torvalds 2005-04-16  777  					return -EFAULT;
^1da177e4c3f415 Linus Torvalds 2005-04-16  778  				if (c == 'V')
^1da177e4c3f415 Linus Torvalds 2005-04-16  779  					expect_close = 42;
^1da177e4c3f415 Linus Torvalds 2005-04-16  780  			}
^1da177e4c3f415 Linus Torvalds 2005-04-16  781  		}
^1da177e4c3f415 Linus Torvalds 2005-04-16  782  		rv = ipmi_heartbeat();
^1da177e4c3f415 Linus Torvalds 2005-04-16  783  		if (rv)
^1da177e4c3f415 Linus Torvalds 2005-04-16  784  			return rv;
^1da177e4c3f415 Linus Torvalds 2005-04-16  785  	}
3976df9b04c113a Mark Rustad    2008-07-10  786  	return len;
^1da177e4c3f415 Linus Torvalds 2005-04-16  787  }
^1da177e4c3f415 Linus Torvalds 2005-04-16  788  

:::::: The code at line 776 was first introduced by commit
:::::: 1da177e4c3f41524e886b7f1b8a0c1fc7321cac2 Linux-2.6.12-rc2

:::::: TO: Linus Torvalds <torvalds@ppc970.osdl.org>
:::::: CC: Linus Torvalds <torvalds@ppc970.osdl.org>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
