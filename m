Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A8B94B3957
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Feb 2022 05:44:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233443AbiBMEoP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Feb 2022 23:44:15 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:41758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232021AbiBMEoN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Feb 2022 23:44:13 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD6935E759
        for <linux-kernel@vger.kernel.org>; Sat, 12 Feb 2022 20:44:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644727447; x=1676263447;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=d3jQxq7PxoosC3S53epEUHJaVO6gqm1tY25u74t3mhQ=;
  b=Yx/tACxrRxMMyjcWhiAe1xN35rJOCEM+LmWrhhD7W+gxvF81xqbRaUPs
   Bg2TgPUwjgz42ILbGDenoNnw4W8qYrV5A6PGj5nDCAEuRqz2IQ/dy8jfK
   Wlx0E+DaoC8BUWojgFu/ARdgEbt6yvQYTcq/NgmMou/y556JpLKL5d25T
   YKRImMgCV6Sty6M0BVq8R4LXH0a5iA8KRsPe5pf+NNAgqWnE/4TmpSQVO
   GkNENGyYPHlqrltQHvT5MNsSSl6prtUYD315fyql+fr2E4Tz4jaCxk+bq
   oylIR5Wq/oyRZG3R99sGgbcxJjXDrEWNzD4SJt+AhMvVC10lcyZ54wPZj
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10256"; a="250128818"
X-IronPort-AV: E=Sophos;i="5.88,364,1635231600"; 
   d="scan'208";a="250128818"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2022 20:44:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,364,1635231600"; 
   d="scan'208";a="702528946"
Received: from lkp-server01.sh.intel.com (HELO d95dc2dabeb1) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 12 Feb 2022 20:44:06 -0800
Received: from kbuild by d95dc2dabeb1 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nJ6k1-00073x-Ib; Sun, 13 Feb 2022 04:44:05 +0000
Date:   Sun, 13 Feb 2022 12:43:35 +0800
From:   kernel test robot <lkp@intel.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [arnd-playground:set_fs 2/11] mm/maccess.c:37:17: sparse: sparse:
 cast removes address space '__user' of expression
Message-ID: <202202131259.S6ZP2d9J-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/arnd/playground.git set_fs
head:   0a081326831928b0d739bce68b8c0f9138b9c8ba
commit: 872ec1b8b0c531c0367aa6f365149bf70d3bcd30 [2/11] sparc64: add __{get,put}_kernel_nocheck()
config: sparc64-randconfig-s032-20220213 (https://download.01.org/0day-ci/archive/20220213/202202131259.S6ZP2d9J-lkp@intel.com/config)
compiler: sparc64-linux-gcc (GCC) 11.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/arnd/playground.git/commit/?id=872ec1b8b0c531c0367aa6f365149bf70d3bcd30
        git remote add arnd-playground https://git.kernel.org/pub/scm/linux/kernel/git/arnd/playground.git
        git fetch --no-tags arnd-playground set_fs
        git checkout 872ec1b8b0c531c0367aa6f365149bf70d3bcd30
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=sparc64 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
>> mm/maccess.c:37:17: sparse: sparse: cast removes address space '__user' of expression
>> mm/maccess.c:37:17: sparse: sparse: cast removes address space '__user' of expression
>> mm/maccess.c:37:17: sparse: sparse: cast removes address space '__user' of expression
>> mm/maccess.c:37:17: sparse: sparse: cast removes address space '__user' of expression
   mm/maccess.c:39:17: sparse: sparse: cast removes address space '__user' of expression
   mm/maccess.c:39:17: sparse: sparse: cast removes address space '__user' of expression
   mm/maccess.c:39:17: sparse: sparse: cast removes address space '__user' of expression
   mm/maccess.c:39:17: sparse: sparse: cast removes address space '__user' of expression
   mm/maccess.c:41:17: sparse: sparse: cast removes address space '__user' of expression
   mm/maccess.c:41:17: sparse: sparse: cast removes address space '__user' of expression
   mm/maccess.c:41:17: sparse: sparse: cast removes address space '__user' of expression
   mm/maccess.c:41:17: sparse: sparse: cast removes address space '__user' of expression
   mm/maccess.c:42:9: sparse: sparse: cast removes address space '__user' of expression
   mm/maccess.c:42:9: sparse: sparse: cast removes address space '__user' of expression
   mm/maccess.c:42:9: sparse: sparse: cast removes address space '__user' of expression
   mm/maccess.c:42:9: sparse: sparse: cast removes address space '__user' of expression
   mm/maccess.c:68:17: sparse: sparse: cast removes address space '__user' of expression
   mm/maccess.c:68:17: sparse: sparse: cast removes address space '__user' of expression
   mm/maccess.c:68:17: sparse: sparse: cast removes address space '__user' of expression
   mm/maccess.c:68:17: sparse: sparse: cast removes address space '__user' of expression
   mm/maccess.c:70:17: sparse: sparse: cast removes address space '__user' of expression
   mm/maccess.c:70:17: sparse: sparse: cast removes address space '__user' of expression
   mm/maccess.c:70:17: sparse: sparse: cast removes address space '__user' of expression
   mm/maccess.c:70:17: sparse: sparse: cast removes address space '__user' of expression
   mm/maccess.c:72:17: sparse: sparse: cast removes address space '__user' of expression
   mm/maccess.c:72:17: sparse: sparse: cast removes address space '__user' of expression
   mm/maccess.c:72:17: sparse: sparse: cast removes address space '__user' of expression
   mm/maccess.c:72:17: sparse: sparse: cast removes address space '__user' of expression
   mm/maccess.c:73:9: sparse: sparse: cast removes address space '__user' of expression
   mm/maccess.c:73:9: sparse: sparse: cast removes address space '__user' of expression
   mm/maccess.c:73:9: sparse: sparse: cast removes address space '__user' of expression
   mm/maccess.c:73:9: sparse: sparse: cast removes address space '__user' of expression
   mm/maccess.c:92:17: sparse: sparse: cast removes address space '__user' of expression
   mm/maccess.c:92:17: sparse: sparse: cast removes address space '__user' of expression
   mm/maccess.c:92:17: sparse: sparse: cast removes address space '__user' of expression
   mm/maccess.c:92:17: sparse: sparse: cast removes address space '__user' of expression

vim +/__user +37 mm/maccess.c

b58294ead14cde Christoph Hellwig 2020-06-08  16  
fe557319aa06c2 Christoph Hellwig 2020-06-17  17  #define copy_from_kernel_nofault_loop(dst, src, len, type, err_label)	\
b58294ead14cde Christoph Hellwig 2020-06-08  18  	while (len >= sizeof(type)) {					\
b58294ead14cde Christoph Hellwig 2020-06-08  19  		__get_kernel_nofault(dst, src, type, err_label);		\
b58294ead14cde Christoph Hellwig 2020-06-08  20  		dst += sizeof(type);					\
b58294ead14cde Christoph Hellwig 2020-06-08  21  		src += sizeof(type);					\
b58294ead14cde Christoph Hellwig 2020-06-08  22  		len -= sizeof(type);					\
b58294ead14cde Christoph Hellwig 2020-06-08  23  	}
b58294ead14cde Christoph Hellwig 2020-06-08  24  
fe557319aa06c2 Christoph Hellwig 2020-06-17  25  long copy_from_kernel_nofault(void *dst, const void *src, size_t size)
b58294ead14cde Christoph Hellwig 2020-06-08  26  {
2423de2e6f4d86 Arnd Bergmann     2021-08-11  27  	unsigned long align = 0;
2423de2e6f4d86 Arnd Bergmann     2021-08-11  28  
2423de2e6f4d86 Arnd Bergmann     2021-08-11  29  	if (!IS_ENABLED(CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS))
2423de2e6f4d86 Arnd Bergmann     2021-08-11  30  		align = (unsigned long)dst | (unsigned long)src;
2423de2e6f4d86 Arnd Bergmann     2021-08-11  31  
fe557319aa06c2 Christoph Hellwig 2020-06-17  32  	if (!copy_from_kernel_nofault_allowed(src, size))
2a71e81d321987 Christoph Hellwig 2020-06-08  33  		return -ERANGE;
b58294ead14cde Christoph Hellwig 2020-06-08  34  
b58294ead14cde Christoph Hellwig 2020-06-08  35  	pagefault_disable();
2423de2e6f4d86 Arnd Bergmann     2021-08-11  36  	if (!(align & 7))
fe557319aa06c2 Christoph Hellwig 2020-06-17 @37  		copy_from_kernel_nofault_loop(dst, src, size, u64, Efault);
2423de2e6f4d86 Arnd Bergmann     2021-08-11  38  	if (!(align & 3))
fe557319aa06c2 Christoph Hellwig 2020-06-17  39  		copy_from_kernel_nofault_loop(dst, src, size, u32, Efault);
2423de2e6f4d86 Arnd Bergmann     2021-08-11  40  	if (!(align & 1))
fe557319aa06c2 Christoph Hellwig 2020-06-17  41  		copy_from_kernel_nofault_loop(dst, src, size, u16, Efault);
fe557319aa06c2 Christoph Hellwig 2020-06-17  42  	copy_from_kernel_nofault_loop(dst, src, size, u8, Efault);
b58294ead14cde Christoph Hellwig 2020-06-08  43  	pagefault_enable();
b58294ead14cde Christoph Hellwig 2020-06-08  44  	return 0;
b58294ead14cde Christoph Hellwig 2020-06-08  45  Efault:
b58294ead14cde Christoph Hellwig 2020-06-08  46  	pagefault_enable();
b58294ead14cde Christoph Hellwig 2020-06-08  47  	return -EFAULT;
b58294ead14cde Christoph Hellwig 2020-06-08  48  }
fe557319aa06c2 Christoph Hellwig 2020-06-17  49  EXPORT_SYMBOL_GPL(copy_from_kernel_nofault);
b58294ead14cde Christoph Hellwig 2020-06-08  50  

:::::: The code at line 37 was first introduced by commit
:::::: fe557319aa06c23cffc9346000f119547e0f289a maccess: rename probe_kernel_{read,write} to copy_{from,to}_kernel_nofault

:::::: TO: Christoph Hellwig <hch@lst.de>
:::::: CC: Linus Torvalds <torvalds@linux-foundation.org>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
