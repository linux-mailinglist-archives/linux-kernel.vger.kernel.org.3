Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 072314B3C53
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Feb 2022 17:58:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237148AbiBMQ6K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Feb 2022 11:58:10 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:49520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233353AbiBMQ6I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Feb 2022 11:58:08 -0500
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0D1D5BD0D
        for <linux-kernel@vger.kernel.org>; Sun, 13 Feb 2022 08:58:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644771482; x=1676307482;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=/GzIbD2kSlhRbVFLjRw6uGU8gbmHMTIvRwqnOuixLUw=;
  b=k7KElKMuypvRkxwSQ1zS5hRimf2Cm3uxn3/iLnPxM9CmmZV6SQNqRShP
   mCnTT0+uVKjhpedju//1RRjjtOo7YRJn8QFSDscopbN7feSduLriHYgrn
   NVD02ZtpbijpECKzLJn8Jrr1Ctmr+XTZ5fVqnhwQjAH4iqohdvEm4rPcz
   IOrUJ/GXMW2miJichufA6S4EbqOinvYQxklAv4YLepBZ1q8y6alqQ/7Bu
   hnP6DFXf/wjMwSlQ+jR0xnUgyK4KEUd5oYMXmBlJgItvL28e46jXg8ear
   mAHEPEX/o5cTD6LzHWgxRqT10wpG4ccsHqf9uhCH6bnRQyrW9vplx/TaF
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10256"; a="310698839"
X-IronPort-AV: E=Sophos;i="5.88,365,1635231600"; 
   d="scan'208";a="310698839"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2022 08:58:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,365,1635231600"; 
   d="scan'208";a="501329345"
Received: from lkp-server01.sh.intel.com (HELO d95dc2dabeb1) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 13 Feb 2022 08:58:01 -0800
Received: from kbuild by d95dc2dabeb1 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nJICG-0007eh-Ef; Sun, 13 Feb 2022 16:58:00 +0000
Date:   Mon, 14 Feb 2022 00:57:09 +0800
From:   kernel test robot <lkp@intel.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Luis Chamberlain <mcgrof@kernel.org>
Subject: kernel/module_decompress.c:264:36: error: 'module_kset' undeclared;
 did you mean 'module_use'?
Message-ID: <202202140027.K0xZn3T2-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   b81b1829e7e39f6cebdf6e4d5484eacbceda8554
commit: b1ae6dc41eaaa98bb75671e0f3665bfda248c3e7 module: add in-kernel support for decompressing
date:   5 weeks ago
config: sparc-randconfig-r005-20220213 (https://download.01.org/0day-ci/archive/20220214/202202140027.K0xZn3T2-lkp@intel.com/config)
compiler: sparc-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=b1ae6dc41eaaa98bb75671e0f3665bfda248c3e7
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout b1ae6dc41eaaa98bb75671e0f3665bfda248c3e7
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=sparc SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   kernel/module_decompress.c: In function 'module_decompress_sysfs_init':
>> kernel/module_decompress.c:264:36: error: 'module_kset' undeclared (first use in this function); did you mean 'module_use'?
     264 |         error = sysfs_create_file(&module_kset->kobj,
         |                                    ^~~~~~~~~~~
         |                                    module_use
   kernel/module_decompress.c:264:36: note: each undeclared identifier is reported only once for each function it appears in


vim +264 kernel/module_decompress.c

   259	
   260	static int __init module_decompress_sysfs_init(void)
   261	{
   262		int error;
   263	
 > 264		error = sysfs_create_file(&module_kset->kobj,

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
