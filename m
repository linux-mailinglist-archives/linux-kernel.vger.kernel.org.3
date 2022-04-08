Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B70AA4FA03B
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Apr 2022 01:45:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240063AbiDHXq7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 19:46:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230302AbiDHXq5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 19:46:57 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A8473010B7
        for <linux-kernel@vger.kernel.org>; Fri,  8 Apr 2022 16:44:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649461492; x=1680997492;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=WdprLBNO/atloYq5ip7b7OdY08oRpZC1biQ3XfzvKWE=;
  b=cN3RvlSzEl7HeWNs+Br8KnKD82OHSxFSvAWNczzIUlE5E634vlz58N54
   JseDvIx8+QxnH9FNG63JNmqJL2cj+yco+9ab6kDnkZIDOPh69yEInTY3l
   jV8kiHSofwz2tDvua0sXJgWeYsoGbRa0/3pK9YP//NNqI4o5iST2fXzVB
   fSmAHAB+uZtB78m2JSx97iXM4dRdbLUIARN6CfIX9UHUS6TaqXAF27lOf
   g4+n4MkHI/A1LD9aCRrGtYkyLd4DvbmGlq2BnULLr3YJJrAtG/QRVdr1T
   n+2M5mnQQ7lW8yqu3wchAbrY2va94ZzghpjVkDGr6vh4oPXCe94lbE/Nt
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10311"; a="260567127"
X-IronPort-AV: E=Sophos;i="5.90,246,1643702400"; 
   d="scan'208";a="260567127"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2022 16:44:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,246,1643702400"; 
   d="scan'208";a="621848663"
Received: from lkp-server02.sh.intel.com (HELO 7e80bc2a00a0) ([10.239.97.151])
  by fmsmga004.fm.intel.com with ESMTP; 08 Apr 2022 16:44:50 -0700
Received: from kbuild by 7e80bc2a00a0 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1ncyHZ-0000in-Tn;
        Fri, 08 Apr 2022 23:44:49 +0000
Date:   Sat, 9 Apr 2022 07:44:27 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [kas:lam 6/10] drivers/char/ipmi/ipmi_watchdog.c:776:37: sparse:
 sparse: incorrect type in argument 1 (different address spaces)
Message-ID: <202204090719.r9wPivY6-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/kas/linux.git lam
head:   73447e771c55e18598a6fbf6adee1002aee18ea0
commit: 92948bd2c12648f2fb8256ae69dd092ce4398a3a [6/10] x86/uaccess: Remove tags from the address before checking
config: x86_64-randconfig-s022 (https://download.01.org/0day-ci/archive/20220409/202204090719.r9wPivY6-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.2.0-19) 11.2.0
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/kas/linux.git/commit/?id=92948bd2c12648f2fb8256ae69dd092ce4398a3a
        git remote add kas https://git.kernel.org/pub/scm/linux/kernel/git/kas/linux.git
        git fetch --no-tags kas lam
        git checkout 92948bd2c12648f2fb8256ae69dd092ce4398a3a
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
>> drivers/char/ipmi/ipmi_watchdog.c:776:37: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got char const *__ptr_clean @@
   drivers/char/ipmi/ipmi_watchdog.c:776:37: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/char/ipmi/ipmi_watchdog.c:776:37: sparse:     got char const *__ptr_clean

vim +776 drivers/char/ipmi/ipmi_watchdog.c

55929332c92e5d Arnd Bergmann  2010-04-27  758  
^1da177e4c3f41 Linus Torvalds 2005-04-16  759  static ssize_t ipmi_write(struct file *file,
^1da177e4c3f41 Linus Torvalds 2005-04-16  760  			  const char  __user *buf,
^1da177e4c3f41 Linus Torvalds 2005-04-16  761  			  size_t      len,
^1da177e4c3f41 Linus Torvalds 2005-04-16  762  			  loff_t      *ppos)
^1da177e4c3f41 Linus Torvalds 2005-04-16  763  {
^1da177e4c3f41 Linus Torvalds 2005-04-16  764  	int rv;
^1da177e4c3f41 Linus Torvalds 2005-04-16  765  
^1da177e4c3f41 Linus Torvalds 2005-04-16  766  	if (len) {
^1da177e4c3f41 Linus Torvalds 2005-04-16  767  		if (!nowayout) {
^1da177e4c3f41 Linus Torvalds 2005-04-16  768  			size_t i;
^1da177e4c3f41 Linus Torvalds 2005-04-16  769  
^1da177e4c3f41 Linus Torvalds 2005-04-16  770  			/* In case it was set long ago */
^1da177e4c3f41 Linus Torvalds 2005-04-16  771  			expect_close = 0;
^1da177e4c3f41 Linus Torvalds 2005-04-16  772  
^1da177e4c3f41 Linus Torvalds 2005-04-16  773  			for (i = 0; i != len; i++) {
^1da177e4c3f41 Linus Torvalds 2005-04-16  774  				char c;
^1da177e4c3f41 Linus Torvalds 2005-04-16  775  
^1da177e4c3f41 Linus Torvalds 2005-04-16 @776  				if (get_user(c, buf + i))
^1da177e4c3f41 Linus Torvalds 2005-04-16  777  					return -EFAULT;
^1da177e4c3f41 Linus Torvalds 2005-04-16  778  				if (c == 'V')
^1da177e4c3f41 Linus Torvalds 2005-04-16  779  					expect_close = 42;
^1da177e4c3f41 Linus Torvalds 2005-04-16  780  			}
^1da177e4c3f41 Linus Torvalds 2005-04-16  781  		}
^1da177e4c3f41 Linus Torvalds 2005-04-16  782  		rv = ipmi_heartbeat();
^1da177e4c3f41 Linus Torvalds 2005-04-16  783  		if (rv)
^1da177e4c3f41 Linus Torvalds 2005-04-16  784  			return rv;
^1da177e4c3f41 Linus Torvalds 2005-04-16  785  	}
3976df9b04c113 Mark Rustad    2008-07-10  786  	return len;
^1da177e4c3f41 Linus Torvalds 2005-04-16  787  }
^1da177e4c3f41 Linus Torvalds 2005-04-16  788  

:::::: The code at line 776 was first introduced by commit
:::::: 1da177e4c3f41524e886b7f1b8a0c1fc7321cac2 Linux-2.6.12-rc2

:::::: TO: Linus Torvalds <torvalds@ppc970.osdl.org>
:::::: CC: Linus Torvalds <torvalds@ppc970.osdl.org>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
