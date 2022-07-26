Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3709F581720
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 18:16:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238972AbiGZQQs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 12:16:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229768AbiGZQQp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 12:16:45 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4059D24095
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 09:16:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658852203; x=1690388203;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=5hyLSrL4KSUdoWk6zNVtWxQQtR09URwlBAviONiENXs=;
  b=V/R8d6QLAqQiCvqhhL9N5umv4/8gEa8QoTOqwV6iGsmmjJmKVnQzuaSY
   8e5ro+82YTuH/mak1idEoHqvNooPrE6wQDI87QSq5UsyHVhATA20oTQSw
   zefujjYCdj+JzhkkS7rG5LpfvA80J5VXH50+yTLlDBcOd79FJI+iclzwI
   RHz17/kjP7aRvhrR0XquTSkvU69fTmaTJWfd0HJx15FF4g0hfmG/Nbp+3
   zaZhZU147t44SnTYTkuXB34jI1uoFc3q9BDNzB6r0zcJJfcEjJD+J9zir
   vOjlpo64IaYjqSuBkUNirhBmg8P6hFrlDvnMFJJlpyM9V5fTMa3vbsouv
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10420"; a="274865885"
X-IronPort-AV: E=Sophos;i="5.93,194,1654585200"; 
   d="scan'208";a="274865885"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jul 2022 09:16:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,194,1654585200"; 
   d="scan'208";a="658755433"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 26 Jul 2022 09:16:41 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oGNEe-0007CU-1J;
        Tue, 26 Jul 2022 16:16:40 +0000
Date:   Wed, 27 Jul 2022 00:16:28 +0800
From:   kernel test robot <lkp@intel.com>
To:     Keith Busch <kbusch@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [kbusch:dma-prereg-v5 5/6] include/linux/uaccess.h:124: undefined
 reference to `io_dma_unmap'
Message-ID: <202207270041.8fQ9kcrB-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/kbusch/linux.git dma-prereg-v5
head:   4f4a93bf02dcf20e9a4a3ac0c9cd39d79e9e540e
commit: 1b0c9acb050749ce7ad964cc66eef72779835832 [5/6] io_uring: add support for dma pre-mapping
config: xtensa-randconfig-r001-20220724 (https://download.01.org/0day-ci/archive/20220727/202207270041.8fQ9kcrB-lkp@intel.com/config)
compiler: xtensa-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/kbusch/linux.git/commit/?id=1b0c9acb050749ce7ad964cc66eef72779835832
        git remote add kbusch https://git.kernel.org/pub/scm/linux/kernel/git/kbusch/linux.git
        git fetch --no-tags kbusch dma-prereg-v5
        git checkout 1b0c9acb050749ce7ad964cc66eef72779835832
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=xtensa SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   xtensa-linux-ld: io_uring/rsrc.o: in function `_copy_from_user':
>> include/linux/uaccess.h:124: undefined reference to `io_dma_unmap'
   xtensa-linux-ld: io_uring/rsrc.o: in function `io_buffer_unmap':
   io_uring/rsrc.c:151: undefined reference to `io_dma_unmap'


vim +124 include/linux/uaccess.h

d597580d373774 Al Viro              2017-03-20  110  
d597580d373774 Al Viro              2017-03-20  111  #ifdef INLINE_COPY_FROM_USER
9dd819a15162f8 Kees Cook            2019-09-25  112  static inline __must_check unsigned long
d597580d373774 Al Viro              2017-03-20  113  _copy_from_user(void *to, const void __user *from, unsigned long n)
d597580d373774 Al Viro              2017-03-20  114  {
d597580d373774 Al Viro              2017-03-20  115  	unsigned long res = n;
9c5f6908de03a4 Al Viro              2017-06-29  116  	might_fault();
4d0e9df5e43dba Albert van der Linde 2020-10-15  117  	if (!should_fail_usercopy() && likely(access_ok(from, n))) {
76d6f06c36a3b5 Marco Elver          2020-01-21  118  		instrument_copy_from_user(to, from, n);
d597580d373774 Al Viro              2017-03-20  119  		res = raw_copy_from_user(to, from, n);
9c5f6908de03a4 Al Viro              2017-06-29  120  	}
d597580d373774 Al Viro              2017-03-20  121  	if (unlikely(res))
d597580d373774 Al Viro              2017-03-20  122  		memset(to + (n - res), 0, res);
d597580d373774 Al Viro              2017-03-20  123  	return res;
d597580d373774 Al Viro              2017-03-20 @124  }
d597580d373774 Al Viro              2017-03-20  125  #else
9dd819a15162f8 Kees Cook            2019-09-25  126  extern __must_check unsigned long
d597580d373774 Al Viro              2017-03-20  127  _copy_from_user(void *, const void __user *, unsigned long);
d597580d373774 Al Viro              2017-03-20  128  #endif
d597580d373774 Al Viro              2017-03-20  129  

:::::: The code at line 124 was first introduced by commit
:::::: d597580d373774b1bdab84b3d26ff0b55162b916 generic ...copy_..._user primitives

:::::: TO: Al Viro <viro@zeniv.linux.org.uk>
:::::: CC: Al Viro <viro@zeniv.linux.org.uk>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
