Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4308554116
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 06:00:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231436AbiFVEAg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 00:00:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229905AbiFVEAc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 00:00:32 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C56062EA3E
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 21:00:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655870431; x=1687406431;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Q6h8WulSh+ENgoPqn3e+4bZfRdJ5VakAV3CDijVfD/g=;
  b=f5UaZau2tgfeySfbJWvcD4k22iQMhYXCHSG49pswmD9vGX74+3rHiJx5
   wyLcCt2DsCfqeOCMEE04nNtm+MsX/13nbjVKoQGerPstpjgCOkWjnw2cF
   1wPQdzCLBSDag1GdZ9rtysLUoo4i4inDFDoRm74qL+UTSi4PUA/aJZQEi
   myRcikzQ7LPu+dyUVth9epJCo+3dnyj9K7sppeq18/MjcQBzNFaNaI4yO
   vmXTDPoz3Jc8J39ORN5qVX1mJxgE5P+03UM8solEE0CeoGWM3LjqREPxK
   Hkyi8z3CnsM6VFWI7MIoSFvrjBsDKuqZ03obcOlr0ue3guDevT4I5ldP6
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10385"; a="279074235"
X-IronPort-AV: E=Sophos;i="5.92,211,1650956400"; 
   d="scan'208";a="279074235"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2022 21:00:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,211,1650956400"; 
   d="scan'208";a="833892571"
Received: from lkp-server02.sh.intel.com (HELO a67cc04a5eeb) ([10.239.97.151])
  by fmsmga006.fm.intel.com with ESMTP; 21 Jun 2022 21:00:30 -0700
Received: from kbuild by a67cc04a5eeb with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o3rXZ-0000oH-SQ;
        Wed, 22 Jun 2022 04:00:29 +0000
Date:   Wed, 22 Jun 2022 12:00:04 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jarkko Sakkinen <jarkko@profian.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [jarkko-tpmdd:kprobes 3/3] arch/powerpc/kernel/module_alloc.c:31:39:
 error: use of undeclared identifier '_etext'
Message-ID: <202206221119.cyyF058c-lkp@intel.com>
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
config: powerpc-mpc8313_rdb_defconfig (https://download.01.org/0day-ci/archive/20220622/202206221119.cyyF058c-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project af6d2a0b6825e71965f3e2701a63c239fa0ad70f)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install powerpc cross compiling tool for clang build
        # apt-get install binutils-powerpc-linux-gnu
        # https://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git/commit/?id=8a45ec8f64f51131c2e98dcb9ee56edf0ca0a0b3
        git remote add jarkko-tpmdd git://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git
        git fetch --no-tags jarkko-tpmdd kprobes
        git checkout 8a45ec8f64f51131c2e98dcb9ee56edf0ca0a0b3
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=powerpc SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> arch/powerpc/kernel/module_alloc.c:31:39: error: use of undeclared identifier '_etext'
           unsigned long limit = (unsigned long)_etext - SZ_32M;
                                                ^
   1 error generated.


vim +/_etext +31 arch/powerpc/kernel/module_alloc.c

    27	
    28	void *module_alloc(unsigned long size)
    29	{
    30	#ifdef MODULES_VADDR
  > 31		unsigned long limit = (unsigned long)_etext - SZ_32M;

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
