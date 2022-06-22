Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD1E3554772
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 14:12:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232255AbiFVIPr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 04:15:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229582AbiFVIPo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 04:15:44 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E06C537BCD
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 01:15:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655885743; x=1687421743;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=dqUl1qLKhSTbBSPE+HwF8+sPOml0pgG4RVSizv+lwCg=;
  b=hSyWk38I31Am+0lcoWZxq7NMPgYOiBJh90LEKd5fxinmZai5fCaOOVu2
   11qClQ7Kk9Wj/TUuy9vNmJ0omY1TE/Q7LQFpYczdqQh6AKMjHsoEZJ0E+
   jIXNXfa0eriEZxPfSqh+k5alsDwxm5DZ1Ln9/gOY2l9/E4gcV+3nJsXEz
   Mx5KhrjsIEZQnqI2QLZxaprDNQpuNMFcJ3xU37cQHLS9GOAvIq3laBUsc
   E7MQhuzQCaYVMyJ6ZkFE8zN4Th/R4609K+UPJpXcmsFa9hCvh4pUE72DQ
   hO7OyOx3J2o7X96qTVIyKa2znfWxnh4Pdg6YhdN61+fhZlk58BJvYep6N
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10385"; a="342035461"
X-IronPort-AV: E=Sophos;i="5.92,212,1650956400"; 
   d="scan'208";a="342035461"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2022 01:15:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,212,1650956400"; 
   d="scan'208";a="592068965"
Received: from lkp-server02.sh.intel.com (HELO a67cc04a5eeb) ([10.239.97.151])
  by fmsmga007.fm.intel.com with ESMTP; 22 Jun 2022 01:15:39 -0700
Received: from kbuild by a67cc04a5eeb with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o3vWU-00012T-H7;
        Wed, 22 Jun 2022 08:15:38 +0000
Date:   Wed, 22 Jun 2022 16:15:14 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jarkko Sakkinen <jarkko@profian.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [jarkko-tpmdd:kprobes 3/3] arch/powerpc/kernel/module_alloc.c:31:46:
 error: '_etext' undeclared
Message-ID: <202206221611.lYrZWqbt-lkp@intel.com>
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

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git kprobes
head:   8a45ec8f64f51131c2e98dcb9ee56edf0ca0a0b3
commit: 8a45ec8f64f51131c2e98dcb9ee56edf0ca0a0b3 [3/3] kprobes: Enable tracing for mololithic kernel images
config: powerpc-allmodconfig (https://download.01.org/0day-ci/archive/20220622/202206221611.lYrZWqbt-lkp@intel.com/config)
compiler: powerpc-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git/commit/?id=8a45ec8f64f51131c2e98dcb9ee56edf0ca0a0b3
        git remote add jarkko-tpmdd git://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git
        git fetch --no-tags jarkko-tpmdd kprobes
        git checkout 8a45ec8f64f51131c2e98dcb9ee56edf0ca0a0b3
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=powerpc SHELL=/bin/bash arch/powerpc/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   arch/powerpc/kernel/module_alloc.c: In function 'module_alloc':
>> arch/powerpc/kernel/module_alloc.c:31:46: error: '_etext' undeclared (first use in this function)
      31 |         unsigned long limit = (unsigned long)_etext - SZ_32M;
         |                                              ^~~~~~
   arch/powerpc/kernel/module_alloc.c:31:46: note: each undeclared identifier is reported only once for each function it appears in


vim +/_etext +31 arch/powerpc/kernel/module_alloc.c

    27	
    28	void *module_alloc(unsigned long size)
    29	{
    30	#ifdef MODULES_VADDR
  > 31		unsigned long limit = (unsigned long)_etext - SZ_32M;

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
